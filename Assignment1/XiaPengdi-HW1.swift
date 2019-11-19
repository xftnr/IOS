//
//  XiaPengdi-HW1
//  XiaPengdi-HW1
//  px353
//  Course: CS371L
//
//  Created by Pengdi Xia on 2/3/19.
//  Copyright 2019 Pengdi Xia. All rights reserved.
//

class Weapon{
    var type = ""
    var damage = 0
    
    init(weaponType:String) {
        self.type = weaponType
        switch weaponType {
        case "dagger":
            damage = 4
        case "axe":
            damage = 6
        case "staff":
            damage = 6
        case "sword":
            damage = 10
        default:
            damage = 1
        }
    }
    
}

class Armor{
    var type = ""
    var ac = 0
    
    init(armorType:String) {
        self.type = armorType
        switch armorType {
        case "plate":
            ac = 2
        case "chain":
            ac = 5
        case "leather":
            ac = 8
        default:
            ac = 10
        }
    }
}



class RPGCharacter{
    let maxHP:Int
    let maxSP:Int
    var currHP:Int
    var currSP:Int
    var armor = Armor(armorType:"none")
    var weapon = Weapon(weaponType:"none")
    let name:String
    
    func wield(weaponObject:Weapon){
        weapon = weaponObject
        print(name + " is now wielding a(n) " + weapon.type)
    }
    
    func unwield() {
        weapon = Weapon(weaponType:"none")
        print(name + " is no longer wielding anything.")
    }
    
    func putOnArmor(armorObject:Armor){
        armor = armorObject
        print(name+" is now wearing "+armor.type)
    }
    
    func takeOffArmor() {
        armor = Armor(armorType:"none")
        print(name + " is no longer wearing anything.")
    }
    
    func fight(opponent:RPGCharacter) {
        print(name + " attacks " + opponent.name + " with a(n) " + weapon.type)
        opponent.currHP -= weapon.damage
        print(name + " does \(weapon.damage) damage to " + opponent.name)
        print(opponent.name + " is now down to \(opponent.currHP) health")
        if(checkForDefeat(target: opponent)){
            print(opponent.name+" has been defeated!")
        }
    }
    
    func show() {
        print(name)
        print("   Current Health:  \(currHP)")
        print("   Current Spell Points:  \(currSP)")
        print("   Wielding:  " + weapon.type)
        print("   Wearing:  " + armor.type)
        print("   Armor class:  \(armor.ac)")
    }
    
    func checkForDefeat(target:RPGCharacter) -> Bool {
        if(target.currHP<=0){
            return true
        }
        return false
    }
    
    init(hp:Int,sp:Int,name:String) {
        maxHP = hp
        maxSP = sp
        currHP = maxHP
        currSP = maxSP
        self.name = name
    }
    
}

class Fighter: RPGCharacter {
    init(name:String){
        super.init(hp:40,sp:0,name:name)
    }
}

class Wizard: RPGCharacter {
    init(name:String) {
        super.init(hp:16,sp:20,name:name)
    }
    
    override func wield(weaponObject:Weapon) {
        if(weapon.type == "dagger" ||
            weapon.type == "staff"  ||
            weapon.type == "none") {
            weapon = weaponObject
            print(name + " is now wielding a(n) " + weapon.type)
        } else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    override func putOnArmor(armorObject: Armor){
        print("Armor not allowed for this character class.")
    }
    
    func castSpell(spellName:String,target:RPGCharacter){
        switch spellName {
        case "Fireball":
            if(currSP>2){
                print(name + " casts Fireball at " + target.name)
                currSP -= 3
                target.currHP -= 5
                print(name + " does 5 damage to " + target.name)
                print(target.name + " is now down to \(target.currHP) health")
                if(checkForDefeat(target: target)){
                    print(target.name+" has been defeated!")
                }
            }
            else{
                print("Insufficient spell points")
            }
        case "Lightning Bolt":
            if(currSP>9){
                print(name + " casts Lightning Bolt at " + target.name)
                currSP -= 10
                target.currHP -= 10
                print(name + " does 10 damage to " + target.name)
                print(target.name + " is now down to \(target.currHP) health")
                if(checkForDefeat(target: target)){
                    print(target.name+" has been defeated!")
                }
            }
            else{
                print("Insufficient spell points")
            }
        case "Heal":
            if(currSP>5){
                print(name + " casts Heal at " + target.name)
                var healVol = 6
                currSP -= 6
                target.currHP += 6
                if(target.currHP>target.maxHP){
                    healVol = 6 - (target.currHP-target.maxHP)
                    target.currHP=target.maxHP
                }
                print(name + " heals " + target.name + " for \(healVol) health points.")
                print(target.name + " is now at \(target.currHP) health")
            }
            else{
                print("Insufficient spell points")
            }
        default:
            print("Unknown spell name. Spell failed.")
            
        }
    }
}

let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword = Weapon(weaponType: "sword")
let staff = Weapon(weaponType: "staff")
let axe = Weapon(weaponType: "axe")

let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)

let aragorn = Fighter(name: "Aragorn")
aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)

gandalf.fight(opponent: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()
