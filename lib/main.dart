import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(AgroVisionApp());
}

class AgroVisionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

enum AppLang { en, te, hi, ta, kn, ml }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _imageBytes;
  bool _showResult = false;
  String _crop = 'Tomato';
  String _statusMsg = '';
  final picker = ImagePicker();
  AppLang curLang = AppLang.en;

  String L(String en, String te, String hi, String ta, String kn, String ml) {
    if (curLang == AppLang.te) return te;
    if (curLang == AppLang.hi) return hi;
    if (curLang == AppLang.ta) return ta;
    if (curLang == AppLang.kn) return kn;
    if (curLang == AppLang.ml) return ml;
    return en;
  }

  String langNativeName(AppLang l) {
    if (l == AppLang.te) return 'తెలుగు';
    if (l == AppLang.hi) return 'हिन्दी';
    if (l == AppLang.ta) return 'தமிழ்';
    if (l == AppLang.kn) return 'ಕನ್ನಡ';
    if (l == AppLang.ml) return 'മലയാളം';
    return 'English';
  }

  String trCrop(String en) {
    if (en == 'All Crops') {
      return L('All Crops', 'అన్ని పంటలు', 'सभी फसलें', 'அனைத்து பயிர்கள்', 'ಎಲ್ಲಾ ಬೆಳೆಗಳು', 'എല്ലാ വിളകൾ');
    }
    if (en == 'Tomato') {
      return L('Tomato', 'టమోటా', 'टमाटर', 'தக்காளி', 'ಟೊಮೆಟೊ', 'തക്കാളി');
    }
    if (en == 'Potato') {
      return L('Potato', 'బంగాళాదుంప', 'आलू', 'உருளைக்கிழங்கு', 'ಆಲೂಗಡ್ಡೆ', 'ഉരുളക്കിഴങ്ങ്');
    }
    if (en == 'Chilli') {
      return L('Chilli', 'మిర్చి', 'मिर्च', 'மிளகாய்', 'ಮೆಣಸಿನಕಾಯಿ', 'മുളക്');
    }
    if (en == 'Onion') {
      return L('Onion', 'ఉల్లిపాయ', 'प्याज', 'வெங்காயம்', 'ಈರುಳ್ಳಿ', 'സവാള');
    }
    return en;
  }

  String trMonth(String en) {
    if (en == 'January') return L('January', 'జనవరి', 'जनवरी', 'ஜனவரி', 'ಜನವರಿ', 'ജനുവരി');
    if (en == 'February') return L('February', 'ఫిబ్రవరి', 'फ़रवरी', 'பிப்ரவரி', 'ಫೆಬ್ರವರಿ', 'ഫെബ്രുവരി');
    if (en == 'March') return L('March', 'మార్చి', 'मार्च', 'மார்ச்', 'ಮಾರ್ಚ್', 'മാർച്ച്');
    if (en == 'April') return L('April', 'ఏప్రిల్', 'अप्रैल', 'ஏப்ரல்', 'ಏಪ್ರಿಲ್', 'ഏപ്രിൽ');
    if (en == 'May') return L('May', 'మే', 'मई', 'மே', 'ಮೇ', 'മേ');
    if (en == 'June') return L('June', 'జూన్', 'जून', 'ஜூன்', 'ಜೂನ್', 'ജൂൺ');
    if (en == 'July') return L('July', 'జూలై', 'जुलाई', 'ஜூலை', 'ಜುಲೈ', 'ജൂലൈ');
    if (en == 'August') return L('August', 'ఆగస్టు', 'अगस्त', 'ஆகஸ்ட்', 'ಆಗಸ್ಟ್', 'ഓഗസ്റ്റ്');
    if (en == 'September') return L('September', 'సెప్టెంబర్', 'सितंबर', 'செப்டம்பர்', 'ಸೆಪ್ಟೆಂಬರ್', 'സെപ്റ്റംബർ');
    if (en == 'October') return L('October', 'అక్టోబర్', 'अक्टूबर', 'அக்டோபர்', 'ಅಕ್ಟೋಬರ್', 'ഒക്ടോബർ');
    if (en == 'November') return L('November', 'నవంబర్', 'नवंबर', 'நவம்பர்', 'ನವೆಂಬರ್', 'നവംബർ');
    if (en == 'December') return L('December', 'డిసెంబర్', 'दिसंबर', 'டிசம்பர்', 'ಡಿಸೆಂಬರ್', 'ഡിസംബർ');
    return en;
  }

  String trDate(String en) {
    if (curLang == AppLang.en) return en;
    String d = en;
    d = d.replaceAll('Jan', trMonth('January'));
    d = d.replaceAll('Feb', trMonth('February'));
    d = d.replaceAll('Mar', trMonth('March'));
    d = d.replaceAll('Apr', trMonth('April'));
    d = d.replaceAll('May', trMonth('May'));
    d = d.replaceAll('Jun', trMonth('June'));
    d = d.replaceAll('Jul', trMonth('July'));
    d = d.replaceAll('Aug', trMonth('August'));
    d = d.replaceAll('Sep', trMonth('September'));
    d = d.replaceAll('Oct', trMonth('October'));
    d = d.replaceAll('Nov', trMonth('November'));
    d = d.replaceAll('Dec', trMonth('December'));
    return d;
  }

  String schemeName(String key) {
    if (key == 'Rythu Bandhu') return L('Rythu Bandhu', 'రైతు బంధు', 'रैतु बंधु', 'ரைத்து பந்து', 'ರೈತು ಬಂಧು', 'റൈതു ബന്ധു');
    if (key == 'PM Kisan') return L('PM Kisan', 'పిఎం కిసాన్', 'पीएम किसान', 'பிஎம் கிசான்', 'ಪಿಎಂ ಕಿಸಾನ್', 'പിഎം കിസാൻ');
    if (key == 'Crop Insurance') return L('Crop Insurance - PMFBY', 'పంట భీమా - పిఎంఎఫ్బివై', 'फसल बीमा - पीएमएफबीवाई', 'பயிர் காப்பீடு', 'ಬೆಳೆ ವಿಮೆ', 'വിള ഇൻഷുറൻസ്');
    if (key == 'Drip Subsidy') return L('Drip Irrigation Subsidy', 'బిందు సేద్యం రాయితీ', 'ड्रिप सिंचाई सब्सिडी', 'சொட்டு நீர் பாசன மானியம்', 'ಹನಿ ನೀರಾವರಿ ಸಬ್ಸಿಡಿ', 'ഡ്രിപ്പ് ജലസേചന സബ്സിഡി');
    if (key == 'Fertilizer Subsidy') return L('Fertilizer Subsidy', 'ఎరువుల రాయితీ', 'उर्वरक सब्सिडी', 'உர மானியம்', 'ರಸಗೊಬ್ಬರ ಸಬ್ಸಿಡಿ', 'വള സബ്സിഡി');
    if (key == 'Seed Subsidy') return L('Seed Subsidy', 'విత్తన రాయితీ', 'बीज सब्सिडी', 'விதை மானியம்', 'ಬೀಜ ಸಬ್ಸಿಡಿ', 'വിത്ത് സബ്സിഡി');
    if (key == 'Soil Card') return L('Soil Health Card', 'నేల ఆరోగ్య కార్డు', 'मिट्टी स्वास्थ्य कार्ड', 'மண் ஆரோக்கிய அட்டை', 'ಮಣ್ಣು ಆರೋಗ್ಯ ಕಾರ್ಡ್', 'മണ്ണ് ആരോഗ്യ കാർഡ്');
    if (key == 'Crop Loan') return L('Crop Loan - Zero Interest', 'పంట రుణం - వడ్డీ లేదు', 'फसल ऋण - शून्य ब्याज', 'பயிர் கடன் - வட்டி இல்லை', 'ಬೆಳೆ ಸಾಲ - ಬಡ್ಡಿ ಇಲ್ಲ', 'വിള വായ്പ - പലിശ ഇല്ല');
    if (key == 'Chilli Kit') return L('Chilli - Pest Control Kit', 'మిర్చి - పురుగు మందు కిట్', 'मिर्च - कीट नियंत्रण किट', 'மிளகாய் - பூச்சி கட்டுப்பாடு', 'ಮೆಣಸಿನಕಾಯಿ - ಕೀಟ ನಿಯಂತ್ರಣ', 'മുളക് - കീട നിയന്ത്രണ');
    if (key == 'Ploughing') return L('Summer Ploughing Subsidy', 'వేసవి దున్నకం రాయితీ', 'ग्रीष्म जुताई सब्सिडी', 'கோடை உழவு மானியம்', 'ಬೇಸಿಗೆ ಉಳುಮೆ ಸಬ್ಸಿಡಿ', 'വേനൽ ഉഴവ് സബ്സിഡി');
    if (key == 'Storage') return L('Potato Storage Support', 'బంగాళాదుంప నిల్వ సహాయం', 'आलू भंडारण सहायता', 'உருளைக்கிழங்கு சேமிப்பு', 'ಆಲೂಗಡ್ಡೆ ಸಂಗ್ರಹ', 'ഉരുളക്കിഴങ്ങ് സംഭരണം');
    if (key == 'Monsoon Kit') return L('Monsoon Seed Kit', 'వర్షాకాల విత్తన కిట్', 'मानसून बीज किट', 'பருவமழை விதை கிட்', 'ಮುಂಗಾರು ಬೀಜ ಕಿಟ್', 'മൺസൂൺ വിത്ത് കിറ്റ്');
    if (key == 'Pest Subsidy') return L('Pest Control Subsidy', 'పురుగు మందు రాయితీ', 'कीट नियंत्रण सब्सिडी', 'பூச்சி கட்டுப்பாடு மானியம்', 'ಕೀಟ ನಿಯಂತ್ರಣ ಸಬ್ಸಿಡಿ', 'കീട നിയന്ത്രണ സബ്സിഡി');
    if (key == 'Market Support') return L('Onion - Market Support', 'ఉల్లిపాయ - మార్కెట్ సహాయం', 'प्याज - बाजार सहायता', 'வெங்காயம் - சந்தை உதவி', 'ಈರುಳ್ಳಿ - ಮಾರುಕಟ್ಟೆ ಬೆಂಬಲ', 'സവാള - മാർക്കറ്റ് സഹായം');
    if (key == 'Harvest Machine') return L('Harvest Machine Subsidy', 'కోత యంత్ర రాయితీ', 'कटाई मशीन सब्सिडी', 'அறுவடை இயந்திர மானியம்', 'ಕೊಯ್ಲು ಯಂತ್ರ ಸಬ್ಸಿಡಿ', 'വിളവെടുപ്പ് യന്ത്ര സബ്സിഡി');
    if (key == 'Onion Storage') return L('Onion Storage Subsidy', 'ఉల్లిపాయ నిల్వ రాయితీ', 'प्याज भंडारण सब्सिडी', 'வெங்காயம் சேமிப்பு மானியம்', 'ಈರುಳ್ಳಿ ಸಂಗ್ರಹ ಸಬ್ಸಿಡಿ', 'സവാള സംഭരണ സബ്സിഡി');
    if (key == 'Chilli Subsidy') return L('Chilli Subsidy', 'మిర్చి రాయితీ', 'मिर्च सब्सिडी', 'மிளகாய் மானியம்', 'ಮೆಣಸಿನಕಾಯಿ ಸಬ್ಸಿಡಿ', 'മുളക് സബ്സിഡി');
    return key;
  }

  String schemeDesc(String key) {
    if (key == 'Rythu Bandhu') return L('Telangana Govt - Investment Support', 'తెలంగాణ ప్రభుత్వం - పెట్టుబడి సహాయం', 'तेलंगाना सरकार - निवेश सहायता', 'தெலுங்கானா அரசு - முதலீடு உதவி', 'ತೆಲಂಗಾಣ ಸರ್ಕಾರ - ಹೂಡಿಕೆ ಬೆಂಬಲ', 'തെലങ്കാന സർക്കാർ - നിക്ഷേപ സഹായം');
    if (key == 'PM Kisan') return L('Central Govt - Direct Money', 'కేంద్ర ప్రభుత్వం - నేరుగా డబ్బు', 'केंद्र सरकार - सीधा पैसा', 'மத்திய அரசு - நேரடி பணம்', 'ಕೇಂದ್ರ ಸರ್ಕಾರ - ನೇರ ಹಣ', 'കേന്ദ്ര സർക്കാർ - നേരിട്ടുള്ള പണം');
    return L('For All Farmers - Direct Benefit', 'అందరు రైతులకు - నేరుగా లాభం', 'सभी किसानों के लिए - सीधा लाभ', 'அனைத்து விவசாயிகளுக்கும் - நேரடி பலன்', 'ಎಲ್ಲಾ ರೈತರಿಗೆ - ನೇರ ಲಾಭ', 'എല്ലാ കർഷകർക്കും - നേരിട്ടുള്ള നേട്ടം');
  }

  String schemeAmount(String en) {
    if (curLang == AppLang.en) return en;
    String a = en;
    a = a.replaceAll('Rs.', L('Rs.', 'రూ.', 'रु.', 'ரூ.', 'ರೂ.', 'രൂ.'));
    a = a.replaceAll('/ Acre', L('/ Acre', '/ ఎకరం', '/ एकड़', '/ ஏக்கர்', '/ ಎಕರೆ', '/ ഏക്കർ'));
    a = a.replaceAll('Off', L('Off', 'తగ్గింపు', 'छूट', 'தள்ளுபடி', 'ರಿಯಾಯಿತಿ', 'കിഴിവ്'));
    a = a.replaceAll('Free', L('Free', 'ఉచితం', 'मुफ़्त', 'இலவசம்', 'ಉಚಿತ', 'സൗജന്യം'));
    a = a.replaceAll('Interest', L('Interest', 'వడ్డీ', 'ब्याज', 'வட்டி', 'ಬಡ್ಡಿ', 'പലിശ'));
    a = a.replaceAll('Insurance', L('Insurance', 'భీమా', 'बीमा', 'காப்பீடு', 'ವಿಮೆ', 'ഇൻഷുറൻസ്'));
    a = a.replaceAll('Test', L('Test', 'పరీక్ష', 'परीक्षा', 'பரிசோதனை', 'ಪರೀಕ್ಷೆ', 'പരിശോധന'));
    a = a.replaceAll('Kit', L('Kit', 'కిట్', 'किट', 'கிட்', 'ಕಿಟ್', 'കിറ്റ്'));
    return a;
  }

  String _schemeCrop = 'All Crops';
  String _schemeMonth = 'November';

  List<String> allMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  List<String> allCrops = ['All Crops', 'Tomato', 'Potato', 'Chilli', 'Onion'];
  List<String> leafCrops = ['Tomato', 'Potato', 'Chilli', 'Onion'];

  List<Map<String, String>> allSchemes = [
    {'key': 'Rythu Bandhu', 'crop': 'All Crops', 'month': 'January', 'amount': 'Rs. 5000 / Acre', 'date': '25 Jan 2027', 'descKey': 'Rythu Bandhu'},
    {'key': 'Drip Subsidy', 'crop': 'All Crops', 'month': 'January', 'amount': '50% Off', 'date': '10 Jan 2027', 'descKey': 'General'},
    {'key': 'PM Kisan', 'crop': 'All Crops', 'month': 'February', 'amount': 'Rs. 2000', 'date': '15 Feb 2027', 'descKey': 'PM Kisan'},
    {'key': 'Seed Subsidy', 'crop': 'Tomato', 'month': 'February', 'amount': 'Rs. 3000', 'date': '20 Feb 2027', 'descKey': 'General'},
    {'key': 'Soil Card', 'crop': 'All Crops', 'month': 'March', 'amount': 'Free Test', 'date': '05 Mar 2027', 'descKey': 'General'},
    {'key': 'Seed Subsidy', 'crop': 'Onion', 'month': 'March', 'amount': 'Rs. 2500', 'date': '12 Mar 2027', 'descKey': 'General'},
    {'key': 'Crop Loan', 'crop': 'All Crops', 'month': 'April', 'amount': '0% Interest', 'date': '01 Apr 2027', 'descKey': 'General'},
    {'key': 'Chilli Kit', 'crop': 'Chilli', 'month': 'April', 'amount': 'Free Kit', 'date': '18 Apr 2027', 'descKey': 'General'},
    {'key': 'Ploughing', 'crop': 'All Crops', 'month': 'May', 'amount': 'Rs. 4000', 'date': '10 May 2027', 'descKey': 'General'},
    {'key': 'Storage', 'crop': 'Potato', 'month': 'May', 'amount': 'Rs. 5000', 'date': '22 May 2027', 'descKey': 'General'},
    {'key': 'Rythu Bandhu', 'crop': 'All Crops', 'month': 'June', 'amount': 'Rs. 5000 / Acre', 'date': '15 Jun 2027', 'descKey': 'Rythu Bandhu'},
    {'key': 'Monsoon Kit', 'crop': 'Tomato', 'month': 'June', 'amount': 'Rs. 3500', 'date': '20 Jun 2027', 'descKey': 'General'},
    {'key': 'Crop Insurance', 'crop': 'All Crops', 'month': 'July', 'amount': 'Free Insurance', 'date': '05 Jul 2027', 'descKey': 'General'},
    {'key': 'Fertilizer Subsidy', 'crop': 'All Crops', 'month': 'July', 'amount': 'Rs. 2000', 'date': '18 Jul 2027', 'descKey': 'General'},
    {'key': 'PM Kisan', 'crop': 'All Crops', 'month': 'August', 'amount': 'Rs. 2000', 'date': '15 Aug 2027', 'descKey': 'PM Kisan'},
    {'key': 'Drip Subsidy', 'crop': 'Chilli', 'month': 'August', 'amount': '60% Off', 'date': '25 Aug 2027', 'descKey': 'General'},
    {'key': 'Pest Subsidy', 'crop': 'All Crops', 'month': 'September', 'amount': 'Rs. 1500', 'date': '10 Sep 2027', 'descKey': 'General'},
    {'key': 'Market Support', 'crop': 'Onion', 'month': 'September', 'amount': 'Rs. 6000', 'date': '20 Sep 2027', 'descKey': 'General'},
    {'key': 'Harvest Machine', 'crop': 'All Crops', 'month': 'October', 'amount': '40% Off', 'date': '08 Oct 2027', 'descKey': 'General'},
    {'key': 'Storage', 'crop': 'Potato', 'month': 'October', 'amount': 'Rs. 4500', 'date': '22 Oct 2027', 'descKey': 'General'},
    {'key': 'Rythu Bandhu', 'crop': 'Tomato', 'month': 'November', 'amount': 'Rs. 5000 / Acre', 'date': '15 Nov 2026', 'descKey': 'Rythu Bandhu'},
    {'key': 'PM Kisan', 'crop': 'Tomato', 'month': 'November', 'amount': 'Rs. 2000', 'date': '20 Nov 2026', 'descKey': 'PM Kisan'},
    {'key': 'Crop Insurance', 'crop': 'Potato', 'month': 'November', 'amount': 'Free Insurance', 'date': '30 Nov 2026', 'descKey': 'General'},
    {'key': 'Chilli Subsidy', 'crop': 'Chilli', 'month': 'December', 'amount': 'Rs. 7500', 'date': '05 Dec 2026', 'descKey': 'General'},
    {'key': 'Onion Storage', 'crop': 'Onion', 'month': 'December', 'amount': 'Rs. 10000', 'date': '12 Dec 2026', 'descKey': 'General'},
    {'key': 'Seed Subsidy', 'crop': 'Potato', 'month': 'December', 'amount': 'Rs. 4000', 'date': '18 Dec 2026', 'descKey': 'General'},
  ];

  List<Map<String, String>> get filteredSchemes {
    return allSchemes.where((s) {
      bool cropMatch = _schemeCrop == 'All Crops' || s['crop'] == _schemeCrop || s['crop'] == 'All Crops';
      bool monthMatch = s['month'] == _schemeMonth;
      return cropMatch && monthMatch;
    }).toList();
  }

  Future<void> pickFromCamera() async {
    try {
      final p = await picker.pickImage(source: ImageSource.camera);
      if (p != null) {
        final bytes = await p.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _showResult = false;
          _statusMsg = L('Photo captured from Camera', 'కెమెరా నుంచి ఫోటో తీసుకున్నాం', 'कैमरे से फोटो ली', 'கேமராவிலிருந்து புகைப்படம்', 'ಕ್ಯಾಮೆರಾದಿಂದ ಫೋಟೋ', 'ക്യാമറയിൽ നിന്ന് ഫോട്ടോ');
        });
        return;
      }
      await pickFromGallery();
    } catch (e) {
      await pickFromGallery();
    }
  }

  Future<void> pickFromGallery() async {
    final p = await picker.pickImage(source: ImageSource.gallery);
    if (p != null) {
      final bytes = await p.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _showResult = false;
        _statusMsg = L('Photo selected from Gallery', 'గ్యాలరీ నుంచి ఫోటో తీసుకున్నాం', 'गैलरी से फोटो चुना', 'கேலரியிலிருந்து புகைப்படம்', 'ಗ್ಯಾಲರಿಯಿಂದ ಫೋಟೋ', 'ഗാലറിയിൽ നിന്ന് ഫോട്ടോ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF0FDF4),
      body: SafeArea(
        child: SizedBox(
          width: w,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xFF16A34A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text('🌾', style: TextStyle(fontSize: 22)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L('AgroVision', 'ఆగ్రోవిజన్', 'एग्रोविज़न', 'அக்ரோவிஷன்', 'ಆಗ್ರೋವಿಷನ್', 'അഗ്രോവിഷൻ'),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Text(
                              L('For Farmer - AI Crop Doctor', 'రైతు కోసం - ఏఐ పంట డాక్టర్', 'किसान के लिए - एआई फसल डॉक्टर', 'விவசாயிக்காக - ஏஐ பயிர் மருத்துவர்', 'ರೈತರಿಗಾಗಿ - ಎಐ ಬೆಳೆ ವೈದ್ಯರು', 'കർഷകന് വേണ്ടി - എഐ വിള ഡോക്ടർ'),
                              style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.notifications_none, color: Colors.green, size: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text(
                        L('Languages', 'భాషలు', 'भाषाएँ', 'மொழிகள்', 'ಭಾಷೆಗಳು', 'ഭാഷകൾ'),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                      ),
                      Spacer(),
                      DropdownButton<AppLang>(
                        value: curLang,
                        underline: SizedBox(),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        items: AppLang.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              langNativeName(e),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              curLang = v;
                              _statusMsg = '';
                              _showResult = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: L('Search crop, disease...', 'పంట, రోగం వెతకండి...', 'फसल, रोग खोजें...', 'பயிர், நோய் தேடுங்கள்...', 'ಬೆಳೆ, ರೋಗ ಹುಡುಕಿ...', 'വിള, രോഗം തിരയുക...'),
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Color(0xFF16A34A), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L('Scan Your Leaf', 'నీ ఆకు స్కాన్ చేయి', 'अपनी पत्ती स्कैन करें', 'உங்கள் இலையை ஸ்கேன் செய்யுங்கள்', 'ನಿಮ್ಮ ಎಲೆ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ', 'നിങ്ങളുടെ ഇല സ്കാൻ ചെയ്യുക'),
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              L('Take a photo and detect disease in 2 seconds', 'ఫోటో తీసి 2 సెకన్లలో రోగం తెలుసుకో', 'फोटो लें और 2 सेकंड में रोग जानें', 'புகைப்படம் எடுத்து 2 வினாடிகளில் நோயை அறியுங்கள்', 'ಫೋಟೋ ತೆಗೆದು 2 ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ ರೋಗ ತಿಳಿಯಿರಿ', 'ഫോട്ടോ എടുത്ത് 2 സെക്കൻഡിൽ രോഗം അറിയുക'),
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: pickFromCamera,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7)),
                              child: Text(
                                L('Scan Now - Camera', 'ఇప్పుడే స్కాన్ చేయి', 'अभी स्कैन करें', 'இப்போது ஸ்கேன் செய்யுங்கள்', 'ಈಗ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ', 'ഇപ്പോൾ സ്കാൻ ചെയ്യുക'),
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        L('Leaf', 'ఆకు', 'पत्ती', 'இலை', 'ಎಲೆ', 'ഇല'),
                        style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  L('Today Status', 'ఈరోజు స్థితి', 'आज की स्थिति', 'இன்றைய நிலை', 'ಇಂದಿನ ಸ್ಥಿತಿ', 'ഇന്നത്തെ നില'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    smallBox('19', L('Scans', 'స్కాన్లు', 'स्कैन', 'ஸ்கேன்', 'ಸ್ಕ್ಯಾನ್', 'സ്കാൻ'), Colors.blue, L('Total', 'మొత్తం', 'कुल', 'மொத்தம்', 'ಒಟ್ಟು', 'ആകെ')),
                    SizedBox(width: 6),
                    smallBox('7', L('Healthy', 'ఆరోగ్యం', 'स्वस्थ', 'ஆரோக்கியம்', 'ಆರೋಗ್ಯ', 'ആരോഗ്യം'), Colors.green, L('Good', 'మంచి', 'अच्छा', 'நல்லது', 'ಒಳ್ಳೆಯದು', 'നല്ലത്')),
                    SizedBox(width: 6),
                    smallBox('12', L('Sick', 'జబ్బు', 'बीमार', 'நோய்', 'ಕಾಯಿಲೆ', 'രോഗം'), Colors.red, L('Bad', 'చెడు', 'खराब', 'கெட்டது', 'ಕೆಟ್ಟದು', 'മോശം')),
                    SizedBox(width: 6),
                    smallBox('2', L('Danger', 'ప్రమాదం', 'खतरा', 'ஆபத்து', 'ಅಪಾಯ', 'അപകടം'), Colors.orange, L('Risk', 'రిస్క్', 'जोखिम', 'ஆபத்து', 'ಅಪಾಯ', 'റിസ്ക്')),
                  ],
                ),
                SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L('Feature 1 - Leaf Scan and Disease Check', 'ఫీచర్ 1 - ఆకు స్కాన్ - రోగం చెక్', 'फीचर 1 - पत्ती स्कैन - रोग जांच', 'அம்சம் 1 - இலை ஸ்கேன் - நோய் சரிபார்ப்பு', 'ಫೀಚರ್ 1 - ಎಲೆ ಸ್ಕ್ಯಾನ್ - ರೋಗ ತಪಾಸಣೆ', 'ഫീച്ചർ 1 - ഇല സ്കാൻ - രോഗ പരിശോധന'),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 9),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade200)),
                        child: DropdownButton<String>(
                          value: _crop,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: leafCrops.map((e) {
                            return DropdownMenuItem(value: e, child: Text(trCrop(e), style: TextStyle(color: Colors.black, fontSize: 13)));
                          }).toList(),
                          onChanged: (v) {
                            setState(() {
                              _crop = v!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 9),
                      if (_imageBytes != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(_imageBytes!, height: 150, width: double.infinity, fit: BoxFit.cover),
                        )
                      else
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green)),
                          child: Center(
                            child: Text(
                              L('No photo yet\nTap below to add', 'ఇంకా ఫోటో లేదు\nకింద క్లిక్ చేయి', 'अभी कोई फोटो नहीं\nनीचे क्लिक करें', 'இன்னும் புகைப்படம் இல்லை\nகீழே கிளிக் செய்யுங்கள்', 'ಇನ್ನೂ ಫೋಟೋ ಇಲ್ಲ\nಕೆಳಗೆ ಕ್ಲಿಕ್ ಮಾಡಿ', 'ഇതുവരെ ഫോട്ടോ ഇല്ല\nതാഴെ ക്ലിക്ക് ചെയ്യുക'),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ),
                      if (_statusMsg.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(_statusMsg, style: TextStyle(color: Colors.green, fontSize: 11)),
                        ),
                      SizedBox(height: 9),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: pickFromCamera,
                              icon: Icon(Icons.camera_alt, size: 15),
                              label: Text(L('Camera', 'కెమెరా', 'कैमरा', 'கேமரா', 'ಕ್ಯಾಮೆರಾ', 'ക്യാമറ'), style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF16A34A)),
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: pickFromGallery,
                              icon: Icon(Icons.photo, size: 15),
                              label: Text(L('Gallery / Upload', 'గ్యాలరీ / అప్లోడ్', 'गैलरी / अपलोड', 'கேலரி / பதிவேற்றம்', 'ಗ್ಯಾಲರಿ / ಅಪ್‌ಲೋಡ್', 'ഗാലറി / അപ്‌ലോഡ്'), style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF22C55E)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showResult = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF16A34A), padding: EdgeInsets.all(11)),
                          child: Text(
                            L('CHECK DISEASE', 'రోగం చెక్ చేయి', 'रोग जांचें', 'நோயை சரிபார்க்கவும்', 'ರೋಗ ಪರಿಶೀಲಿಸಿ', 'രോഗം പരിശോധിക്കുക'),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ),
                      if (_showResult)
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                L('Result: ${trCrop(_crop)} Early Blight - 91%', 'ఫలితం: ${trCrop(_crop)} ఎర్లీ బ్లైట్ - 91%', 'परिणाम: ${trCrop(_crop)} अर्ली ब्लाइट - 91%', 'முடிவு: ${trCrop(_crop)} ஆரம்ப பிளைட் - 91%', 'ಫಲಿತಾಂಶ: ${trCrop(_crop)} ಅರ್ಲಿ ಬ್ಲೈಟ್ - 91%', 'ഫലം: ${trCrop(_crop)} എർലി ബ്ലൈറ്റ് - 91%'),
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              SizedBox(height: 5),
                              Text(
                                L('Explainable AI: Brown spots 85% - Yellow ring 72% - Leaf drying 78%', 'ఏఐ చెప్పింది: గోధుమ మచ్చలు 85% - పసుపు రింగ్ 72% - ఆకు ఎండు 78%', 'एआई ने कहा: भूरे धब्बे 85% - पीली रिंग 72% - पत्ती सूखना 78%', 'ஏஐ சொன்னது: பழுப்பு புள்ளிகள் 85% - மஞ்சள் வளையம் 72% - இலை உலர்தல் 78%', 'ಎಐ ಹೇಳಿದೆ: ಕಂದು ಕಲೆಗಳು 85% - ಹಳದಿ ಉಂಗುರ 72% - ಎಲೆ ಒಣಗುವುದು 78%', 'എഐ പറഞ്ഞു: തവിട്ട് പാടുകൾ 85% - മഞ്ഞ വളയം 72% - ഇല ഉണങ്ങൽ 78%'),
                                style: TextStyle(color: Colors.black87, fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(
                                L('Precaution: Neem Oil spray, Remove sick leaves, Mancozeb 2.5g / litre', 'జాగ్రత్త: వేప నూనె కొట్టు, జబ్బు ఆకులు తీసేయి, మాంకోజెబ్ 2.5గ్రా / లీటర్', 'सावधानी: नीम तेल छिड़कें, बीमार पत्ते हटाएं, मैंकोजेब 2.5ग्रा / लीटर', 'முன்னெச்சரிக்கை: வேப்ப எண்ணெய் தெளிக்கவும், நோய் இலைகளை அகற்றவும்', 'ಮುನ್ನೆಚ್ಚರಿಕೆ: ಬೇವಿನ ಎಣ್ಣೆ ಸಿಂಪಡಿಸಿ, ರೋಗದ ಎಲೆಗಳನ್ನು ತೆಗೆದುಹಾಕಿ', 'മുൻകരുതൽ: വേപ്പെണ്ണ തളിക്കുക, രോഗമുള്ള ഇലകൾ നീക്കം ചെയ്യുക'),
                                style: TextStyle(color: Colors.black87, fontSize: 12),
                              ),
                              SizedBox(height: 5),
                              Text(
                                L('Risk Level: HIGH - Act Now', 'రిస్క్ లెవల్: ఎక్కువ - వెంటనే చేయి', 'जोखिम स्तर: अधिक - अभी करें', 'ஆபத்து நிலை: அதிகம் - இப்போதே செய்யுங்கள்', 'ಅಪಾಯ ಮಟ್ಟ: ಹೆಚ್ಚು - ಈಗಲೇ ಮಾಡಿ', 'റിസ്ക് ലെവൽ: കൂടുതൽ - ഇപ്പോൾ ചെയ്യുക'),
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  L('Feature 2 - Weather and Market', 'ఫీచర్ 2 - వాతావరణం మరియు మార్కెట్', 'फीचर 2 - मौसम और बाजार', 'அம்சம் 2 - வானிலை மற்றும் சந்தை', 'ಫೀಚರ್ 2 - ಹವಾಮಾನ ಮತ್ತು ಮಾರುಕಟ್ಟೆ', 'ഫീച്ചർ 2 - കാലാവസ്ഥയും മാർക്കറ്റും'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Expanded(
                      child: miniCard(
                        L('Weather', 'వాతావరణం', 'मौसम', 'வானிலை', 'ಹವಾಮಾನ', 'കാലാവസ്ഥ'),
                        L('29 C\nCloudy\nRain Tomorrow!\nDo Not Spray', '29 సి\nమేఘాలు\nరేపు వర్షం!\nస్ప్రే చేయొద్దు', '29 सी\nबादल\nकल बारिश!\nस्प्रे न करें', '29 சி\nமேகமூட்டம்\nநாளை மழை!\nஸ்ப்ரே செய்ய வேண்டாம்', '29 ಸಿ\nಮೋಡ\nನಾಳೆ ಮಳೆ!\nಸಿಂಪಡಿಸಬೇಡಿ', '29 സി\nമേഘം\nനാളെ മഴ!\nസ്പ്രേ ചെയ്യരുത്'),
                        Colors.blue.shade50,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: miniCard(
                        L('Market', 'మార్కెట్', 'बाजार', 'சந்தை', 'ಮಾರುಕಟ್ಟೆ', 'മാർക്കറ്റ്'),
                        L('Tomato Rs.30\nOnion Rs.25\nChilli Rs.65\nPotato Rs.28', 'టమోటా రూ.30\nఉల్లిపాయ రూ.25\nమిర్చి రూ.65\nబంగాళాదుంప రూ.28', 'टमाटर रु.30\nप्याज रु.25\nमिर्च रु.65\nआलू रु.28', 'தக்காளி ரூ.30\nவெங்காயம் ரூ.25\nமிளகாய் ரூ.65\nஉருளைக்கிழங்கு ரூ.28', 'ಟೊಮೆಟೊ ರೂ.30\nಈರುಳ್ಳಿ ರೂ.25\nಮೆಣಸಿನಕಾಯಿ ರೂ.65\nಆಲೂಗಡ್ಡೆ ರೂ.28', 'തക്കാളി രൂ.30\nസവാള രൂ.25\nമുളക് രൂ.65\nഉരുളക്കിഴങ്ങ് രൂ.28'),
                        Colors.orange.shade50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L('Feature 3 - Govt Schemes', 'ఫీచర్ 3 - ప్రభుత్వ పథకాలు', 'फीचर 3 - सरकारी योजनाएं', 'அம்சம் 3 - அரசு திட்டங்கள்', 'ಫೀಚರ್ 3 - ಸರ್ಕಾರಿ ಯೋಜನೆಗಳು', 'ഫീച്ചർ 3 - സർക്കാർ പദ്ധതികൾ'),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(height: 3),
                      Text(
                        L('This month - What money will come for your crop?', 'ఈ నెల - నీ పంటకు ఏ డబ్బులు వస్తాయి?', 'इस महीने - आपकी फसल के लिए क्या पैसा आएगा?', 'இந்த மாதம் - உங்கள் பயிருக்கு என்ன பணம் வரும்?', 'ಈ ತಿಂಗಳು - ನಿಮ್ಮ ಬೆಳೆಗೆ ಯಾವ ಹಣ ಬರುತ್ತದೆ?', 'ഈ മാസം - നിങ്ങളുടെ വിളയ്ക്ക് എന്ത് പണം വരും?'),
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          L('Selected Month: ${trMonth(_schemeMonth)}  |  Crop: ${trCrop(_schemeCrop)}', 'ఎంచుకున్న నెల: ${trMonth(_schemeMonth)}  |  పంట: ${trCrop(_schemeCrop)}', 'चुना महीना: ${trMonth(_schemeMonth)}  |  फसल: ${trCrop(_schemeCrop)}', 'தேர்ந்தெடுக்கப்பட்ட மாதம்: ${trMonth(_schemeMonth)}', 'ಆಯ್ಕೆ ಮಾಡಿದ ತಿಂಗಳು: ${trMonth(_schemeMonth)}', 'തിരഞ്ഞെടുത്ത മാസം: ${trMonth(_schemeMonth)}'),
                          style: TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(color: Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.shade200)),
                              child: DropdownButton<String>(
                                value: _schemeCrop,
                                isExpanded: true,
                                underline: SizedBox(),
                                items: allCrops.map((e) {
                                  return DropdownMenuItem(value: e, child: Text(trCrop(e), style: TextStyle(fontSize: 12, color: Colors.black)));
                                }).toList(),
                                onChanged: (v) {
                                  setState(() {
                                    _schemeCrop = v!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(color: Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue.shade200)),
                              child: DropdownButton<String>(
                                value: _schemeMonth,
                                isExpanded: true,
                                underline: SizedBox(),
                                items: allMonths.map((e) {
                                  return DropdownMenuItem(value: e, child: Text(trMonth(e), style: TextStyle(fontSize: 12, color: Colors.black)));
                                }).toList(),
                                onChanged: (v) {
                                  setState(() {
                                    _schemeMonth = v!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (filteredSchemes.isEmpty)
                        Text(
                          L('No scheme in this month for this crop', 'ఈ నెలలో ఈ పంటకు పథకం లేదు', 'इस महीने इस फसल के लिए कोई योजना नहीं', 'இந்த மாதம் இந்த பயிருக்கு திட்டம் இல்லை', 'ಈ ತಿಂಗಳು ಈ ಬೆಳೆಗೆ ಯೋಜನೆ ಇಲ್ಲ', 'ഈ മാസം ഈ വിളയ്ക്ക് പദ്ധതി ഇല്ല'),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      for (var s in filteredSchemes)
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.green.shade200)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      schemeName(s['key']!),
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 13),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      schemeAmount(s['amount']!),
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              Text(
                                '${L('Crop', 'పంట', 'फसल', 'பயிர்', 'ಬೆಳೆ', 'വിള')}: ${trCrop(s['crop']!)} | ${L('Date', 'తేదీ', 'तारीख', 'தேதி', 'ದಿನಾಂಕ', 'തീയതി')}: ${trDate(s['date']!)} | ${L('Month', 'నెల', 'महीना', 'மாதம்', 'ತಿಂಗಳು', 'മാസം')}: ${trMonth(s['month']!)}',
                                style: TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                              SizedBox(height: 3),
                              Text(
                                schemeDesc(s['descKey']!),
                                style: TextStyle(color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.orange, size: 16),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                L('Tip: Select All Crops to see all schemes in this month', 'చిట్కా: అన్ని పంటలు పెడితే ఈ నెలలో అన్ని పథకాలు కనిపిస్తాయి', 'टिप: इस महीने सभी योजनाएं देखने के लिए सभी फसलें चुनें', 'குறிப்பு: இந்த மாதம் அனைத்து திட்டங்களையும் பார்க்க', 'ಸಲಹೆ: ಈ ತಿಂಗಳ ಎಲ್ಲಾ ಯೋಜನೆಗಳನ್ನು ನೋಡಲು', 'നുറുങ്ങ്: ഈ മാസത്തെ എല്ലാ പദ്ധതികളും കാണാൻ'),
                                style: TextStyle(fontSize: 11, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  L('Recent Scans', 'ఇటీవల స్కాన్లు', 'हाल के स्कैन', 'சமீபத்திய ஸ்கேன்கள்', 'ಇತ್ತೀಚಿನ ಸ್ಕ್ಯಾನ್‌ಗಳು', 'സമീപകാല സ്കാനുകൾ'),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 7),
                tinyTile(trCrop('Tomato'), L('Early Blight', 'ఎర్లీ బ్లైట్', 'अर्ली ब्लाइट', 'ஆரம்ப பிளைட்', 'ಅರ್ಲಿ ಬ್ಲೈಟ್', 'എർലി ബ്ലൈറ്റ്'), L('HIGH', 'ఎక్కువ', 'अधिक', 'அதிகம்', 'ಹೆಚ್ಚು', 'കൂടുതൽ'), Colors.red),
                tinyTile(trCrop('Potato'), L('Healthy', 'బాగుంది', 'स्वस्थ', 'ஆரோக்கியமானது', 'ಆರೋಗ್ಯಕರ', 'ആരോഗ്യമുള്ളത്'), L('OK', 'ఓకే', 'ठीक है', 'சரி', 'ಸರಿ', 'ശരി'), Colors.green),
                tinyTile(trCrop('Chilli'), L('Leaf Rust', 'ఆకు తెగులు', 'पत्ती जंग', 'இலை துரு', 'ಎಲೆ ತುಕ್ಕು', 'ഇല തുരുമ്പ്'), L('MEDIUM', 'మధ్యస్థం', 'मध्यम', 'நடுத்தர', 'ಮಧ್ಯಮ', 'ഇടത്തരം'), Colors.orange),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    L('AgroVision AI - For guidance only', 'ఆగ్రోవిజన్ ఏఐ - మార్గదర్శకం కోసం మాత్రమే', 'एग्रोविज़न एआई - केवल मार्गदर्शन के लिए', 'அக்ரோவிஷன் ஏஐ - வழிகாட்டுதலுக்கு மட்டும்', 'ಆಗ್ರೋವಿಷನ್ ಎಐ - ಮಾರ್ಗದರ್ಶನಕ್ಕಾಗಿ ಮಾತ್ರ', 'അഗ്രോവിഷൻ എഐ - മാർഗ്ഗനിർദ്ദേശത്തിന് മാത്രം'),
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget smallBox(String num, String label, Color c, String title) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 11, color: Colors.grey)),
            SizedBox(height: 3),
            Text(num, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c)),
            Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget miniCard(String title, String body, Color bg) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
          SizedBox(height: 5),
          Text(body, style: TextStyle(color: Colors.black87, fontSize: 11)),
        ],
      ),
    );
  }

  Widget tinyTile(String crop, String disease, String tag, Color c) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(crop, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          Spacer(),
          Text(disease, style: TextStyle(color: Colors.grey, fontSize: 11)),
          SizedBox(width: 7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: c.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(tag, style: TextStyle(color: c, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}