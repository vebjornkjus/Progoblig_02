include gdrive-sheets
include data-source
include shared-gdrive(
"dcic-2021",
  "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")

#Oppgave a
ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"
kWh-wealthy-consumer-data =
load-table: komponent, energi
source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
    sanitize energi using string-sanitizer
end

kWh-wealthy-consumer-data
#For å få inn riktig tabbel la jeg inn koden fra dokumentet og "sanitize energi using string-sanitizer". 

#Oppgave b (brukte koden i oppgaven)
fun energi-to-number(str :: String) -> Number:
  cases(Option) string-to-number(str):
    | some(a) => a
    | none => 0
  end
where:
energi-to-number("") is 0
  energi-to-number("48") is 48
end

#Oppgave c
energy-table = transform-column(kWh-wealthy-consumer-data, "energi", 
  energi-to-number)
energy-table
#For å tilfredstille testene i where-blokken overførte jeg data fra type string til type number.

distance-travelled-per-day = 48
distance-per-unit-of-fuel = 4
energy-per-unit-of-fuel = 10

energy-per-day = ( distance-travelled-per-day /
  distance-per-unit-of-fuel ) *
energy-per-unit-of-fuel
energy-per-day

#Oppgave d
energiforbruk = sum(energy-table, "energi")
energiforbruk

#Oppgave e
bar-chart(energy-table, "komponent", "energi")