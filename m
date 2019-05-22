Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D6C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877E1205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfEVJhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:37:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46411 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVJhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:37:33 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hTNge-000703-Lo; Wed, 22 May 2019 11:37:28 +0200
Message-ID: <1558517848.2624.34.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: rdu2: Add node for UCS1002 USB
 charger chip
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 11:37:28 +0200
In-Reply-To: <20190522071227.31488-1-andrew.smirnov@gmail.com>
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
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

Hi Andrey,

Am Mittwoch, den 22.05.2019, 00:12 -0700 schrieb Andrey Smirnov:
> Add node for UCS1002 USB charger chip connected to front panel USB and
> replace "regulator-fixed" previously used to control VBUS.

I've had a similar version of this patch, but also added GPIO hogs for
the UCS1002 configuration pins, so the device is put into the expected
state even before driver load. Maybe something worth to consider?

Regards,
Lucas

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 35 ++++++++++++-------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 93be00a60c88..977d923e35df 100644
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
> @@ -590,6 +578,16 @@
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
> @@ -982,12 +980,6 @@
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
> @@ -1047,6 +1039,13 @@
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
