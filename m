Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D46C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C4217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDDWAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:00:18 -0400
Received: from muru.com ([72.249.23.125]:44418 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfDDWAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:00:18 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C593180D4;
        Thu,  4 Apr 2019 22:00:31 +0000 (UTC)
Date:   Thu, 4 Apr 2019 15:00:13 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
Message-ID: <20190404220013.GG49658@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-2-dmurphy@ti.com>
 <f9d80ad1-d80c-bf77-5e0b-1e02a1b74200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d80ad1-d80c-bf77-5e0b-1e02a1b74200@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jacek Anaszewski <jacek.anaszewski@gmail.com> [190404 20:12]:
> Tony,
> 
> On 3/21/19 3:28 PM, Dan Murphy wrote:
> > Update the properties for the lm3532 device node for droid4.
> > With this change the backlight LED string and the keypad
> > LED strings will be controlled separately.
> > 
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> > 
> > v5 - No change - https://lore.kernel.org/patchwork/patch/1050409/
> > 
> > v4 - No change - https://lore.kernel.org/patchwork/patch/1050125/
> > v3 - updated keypad label on v1 comment - https://lore.kernel.org/patchwork/patch/1049023/
> > v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
> > I did not change the label as it is undecided what it could be - https://lore.kernel.org/patchwork/patch/1048806/
> > 
> >   arch/arm/boot/dts/omap4-droid4-xt894.dts | 26 ++++++++++++++++--------
> >   1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > index e21ec929f096..aea206f04f76 100644
> > --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > @@ -383,20 +383,30 @@
> >   };
> >   &i2c1 {
> > -	lm3532@38 {
> > +	led-controller@38 {
> >   		compatible = "ti,lm3532";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> >   		reg = <0x38>;
> >   		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
> > -		lcd_backlight: backlight {
> > -			compatible = "ti,lm3532-backlight";
> > +		ramp-up-us = <1024>;
> > +		ramp-down-us = <8193>;
> > -			lcd {
> > -				led-sources = <0 1 2>;
> > -				ramp-up-msec = <1>;
> > -				ramp-down-msec = <0>;
> > -			};
> 
> Since I'll be creating integration branch for this series,
> and it would be good to have this patch in it too, then
> I can do the amendments by myself:
> 
> > +		lcd_backlight: led@0 {
> > +			reg = <0>;
> > +			led-sources = <2>;
> > +			ti,led-mode = <0>;
> > +			label = "backlight";
> 
> s/backlight/:backlight/
> 
> > +			linux,default-trigger = "backlight";
> > +		};
> > +
> > +		led@1 {
> > +			reg = <1>;
> > +			led-sources = <1>;
> > +			ti,led-mode = <0>;
> > +			label = "platform::kbd_backlight";
> 
> s/platform::kbd_backlight/:kbd_backlight/

Yes makes sense to me.

> and then send you a pull request.
> 
> Would you be OK with that?

Sure go for it. Here's my ack for the changes:

Acked-by: Tony Lindgren <tony@atomide.com>

And then for the one liner to fold in below:

Signed-off-by: Tony Lindgren <tony@atomide.com>

8< -------------
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -214,7 +214,6 @@
 
 		width-mm = <50>;
 		height-mm = <89>;
-		backlight = <&lcd_backlight>;
 
 		panel-timing {
 			clock-frequency = <0>;		/* Calculated by dsi */
