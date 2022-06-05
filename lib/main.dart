import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAB2',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Expand Multiple Floating Action Buttons'),
      home: const OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              Container(
                color: Colors.red,
                child: const Center(
                    child: Text('Page 1',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              ),
              Container(
                color: Colors.blue,
                child: const Center(
                    child: Text('Page 2',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              ),
              Container(
                color: Colors.green,
                child: const Center(
                    child: Text('Page 3',
                        style: TextStyle(fontSize: 40, color: Colors.white))),
              )
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    minimumSize: const Size.fromHeight(80)),
                child:
                    const Text('Get Started', style: TextStyle(fontSize: 24)),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: ''))),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(2),
                        child: const Text('SKIP')),
                    Center(
                        child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 16,
                        dotHeight: 16,
                        dotWidth: 16,
                        type: WormType.thin,
                        // strokeWidth: 5,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    )),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        child: const Text('NEXT')),
                  ],
                ),
              ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    showToast('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    showToast('Go!');
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.share, //รูปไอคอนแชร์
        activeIcon: Icons.close, //แสดงรูปไอคอนปิด หลังจากคลิกปุ่ม
        //animatedIcon: AnimatedIcons.menu_close, //รูปไอคอนเมนู เมื่อคลิกจะเป็นปุ่มปิด
        backgroundColor: Colors.black, //สีพื้นหลังของปุ่ม
        overlayColor: Colors.black, //สีพื้นหลังเวลากดปุ่ม
        overlayOpacity: 0.4, //ระดับสี
        spacing: 12, //ระยะห่างระหว่างปุ่มหลักและปุ่มย่อย
        spaceBetweenChildren: 12, //ระยะห่างระหว่างปุ่มย่อย
        children: [
          SpeedDialChild(
              child: const Icon(Icons.mail),
              backgroundColor: Colors.lime,
              label: 'Mail',
              onTap: () => showToast('Selected Mail...')),
          SpeedDialChild(
              child: const Icon(Icons.copy),
              backgroundColor: Colors.lightGreen,
              label: 'Copy',
              onTap: () => showToast('Selected Copy...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              onTap: () => showToast('Selected Facebook...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.twitter,
                color: Colors.cyan,
              ),
              onTap: () => showToast('Selected Twitter...')),
          SpeedDialChild(
              child: const Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onTap: () => showToast('Selected Google...')),
        ],
      ),
    );
  }

  showToast(String message) async {
    Fluttertoast.cancel();
    await Fluttertoast.showToast(msg: message, fontSize: 18);
  }
}
