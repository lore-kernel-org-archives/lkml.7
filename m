Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC39C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853720665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfE2I13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:27:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43283 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfE2I12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:27:28 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hVtvf-0006WG-1t; Wed, 29 May 2019 10:27:23 +0200
Message-ID: <1559118442.4039.17.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB
 charger chip
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 May 2019 10:27:22 +0200
In-Reply-To: <20190529071843.24767-1-andrew.smirnov@gmail.com>
References: <20190529071843.24767-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 29.05.2019, 00:18 -0700 schrieb Andrey Smirnov:
> Add node for UCS1002 USB charger chip connected to front panel USB and
> replace "regulator-fixed" previously used to control VBUS.
> 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

FWIW:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changes since [v1]:
> 
>     - Added GPIO hog configuration to put UCS1002 into correct mode
>       even before its driver takes over. The code for that is taken
>       from similar patch from Lucas, so I added his Signed-off-by as
>       well.
> 
> [v1] lore.kernel.org/r/20190522071227.31488-1-andrew.smirnov@gmail.com
> 
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 77 +++++++++++++++++++------
>  1 file changed, 59 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 93be00a60c88..07e21d1e5b4c 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -60,18 +60,6 @@
> >  		regulator-always-on;
> >  	};
>  
> > -	reg_5p0v_user_usb: regulator-5p0v-user-usb {
> > -		compatible = "regulator-fixed";
> > -		pinctrl-names = "default";
> > -		pinctrl-0 = <&pinctrl_reg_user_usb>;
> > -		vin-supply = <&reg_5p0v_main>;
> > -		regulator-name = "5V_USER_USB";
> > -		regulator-min-microvolt = <5000000>;
> > -		regulator-max-microvolt = <5000000>;
> > -		gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
> > -		startup-delay-us = <1000>;
> > -	};
> -
> >  	reg_3p3v_pmic: regulator-3p3v-pmic {
> >  		compatible = "regulator-fixed";
> >  		vin-supply = <&reg_12p0v>;
> @@ -331,6 +319,39 @@
> >  	};
>  };
>  
> +&gpio3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_gpio3_hog>;
> +
> > +	usb-emulation {
> > +		gpio-hog;
> > +		gpios = <19 GPIO_ACTIVE_HIGH>;
> > +		output-low;
> > +		line-name = "usb-emulation";
> > +	};
> +
> > +	usb-mode1 {
> > +		gpio-hog;
> > +		gpios = <20 GPIO_ACTIVE_HIGH>;
> > +		output-high;
> > +		line-name = "usb-mode1";
> > +	};
> +
> > +	usb-pwr {
> > +		gpio-hog;
> > +		gpios = <22 GPIO_ACTIVE_LOW>;
> > +		output-high;
> > +		line-name = "usb-pwr-ctrl-en-n";
> > +	};
> +
> > +	usb-mode2 {
> > +		gpio-hog;
> > +		gpios = <23 GPIO_ACTIVE_HIGH>;
> > +		output-high;
> > +		line-name = "usb-mode2";
> > +	};
> +};
> +
>  &i2c1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_i2c1>;
> @@ -590,6 +611,16 @@
> >  		status = "disabled";
> >  	};
>  
> > > +	reg_5p0v_user_usb: charger@32 {
> > +		compatible = "microchip,ucs1002";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ucs1002_pins>;
> > +		reg = <0x32>;
> > +		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> > +				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> > +		interrupt-names = "a_det", "alert";
> > +	};
> +
> > >  	hpa1: amp@60 {
> >  		compatible = "ti,tpa6130a2";
> >  		pinctrl-names = "default";
> @@ -935,6 +966,15 @@
> >  		>;
> >  	};
>  
> > +	pinctrl_gpio3_hog: gpio3hoggrp {
> > +		fsl,pins = <
> > > +			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x1b0b0
> > > +			MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x1b0b0
> > > +			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0
> > > +			MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x1b0b0
> > +		>;
> > +	};
> +
> >  	pinctrl_i2c1: i2c1grp {
> >  		fsl,pins = <
> > >  			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
> @@ -982,12 +1022,6 @@
> >  		>;
> >  	};
>  
> > -	pinctrl_reg_user_usb: usbotggrp {
> > -		fsl,pins = <
> > > -			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x40000038
> > -		>;
> > -	};
> -
> >  	pinctrl_rmii_phy_irq: phygrp {
> >  		fsl,pins = <
> > >  			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x40010000
> @@ -1047,6 +1081,13 @@
> >  		>;
> >  	};
>  
> > +	pinctrl_ucs1002_pins: ucs1002grp {
> > +		fsl,pins = <
> > > +			MX6QDL_PAD_EIM_A25__GPIO5_IO02  	0x1b0b0
> > > +			MX6QDL_PAD_EIM_D21__GPIO3_IO21  	0x1b0b0
> > +		>;
> > +	};
> +
> >  	pinctrl_usdhc2: usdhc2grp {
> >  		fsl,pins = <
> > >  			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x10059
