import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/intro_screens/1_intro_screen.dart';
import 'package:untitled/intro_screens/2_intro_screen.dart';
import 'package:untitled/intro_screens/3_intro_screen.dart';
import 'package:untitled/screens/homepage_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //controller to keep help indicating the page
  PageController _controller = PageController();

  //keep track of if it on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            //page view
            PageView(
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: const [
                IntroScreen1(),
                IntroScreen2(),
                IntroScreen3()
              ],
            ),

            //dot indicator
            Container(
              alignment: Alignment(0, 0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //skp
                    GestureDetector(
                      onTap: (){

                      _controller.jumpToPage(2);

                      },
                        child: const Text("Skip")
                    ),

                    // dot indicator
                    SmoothPageIndicator(controller: _controller, count: 3),

                    //next / done
                    onLastPage
                    ?  GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return const HomePage();
                              },
                              ),
                            );
                          },
                          child: Text("done"),
                      )
                    : GestureDetector(
                      onTap: (){
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                      child: Text("Next"),
                    )
                  ],
                ),
            ),
          ],
        )
    );
  }
}
