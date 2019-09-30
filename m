Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D737C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8B121855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfI3I13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:27:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfI3I13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:27:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEr1b-0003WF-As; Mon, 30 Sep 2019 10:27:19 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iEr1X-0002ak-4t; Mon, 30 Sep 2019 10:27:15 +0200
Date:   Mon, 30 Sep 2019 10:27:15 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 1/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20190930082715.mplf5ra35ikqmbyr@pengutronix.de>
References: <20190927061423.17278-1-andreas@kemnade.info>
 <20190927061423.17278-2-andreas@kemnade.info>
 <20190927094721.w26ggnli4f5a64uv@pengutronix.de>
 <20190927210807.26439a94@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927210807.26439a94@aktux>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:22:57 up 135 days, 14:41, 87 users,  load average: 0.02, 0.05,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 19-09-27 21:08, Andreas Kemnade wrote:
> Hi Marco,
> 
> On Fri, 27 Sep 2019 11:47:21 +0200
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > Hi Andreas,
> > 
> > thanks for the patch.
> > 
> thanks for the quick review. Most of your comments are clear.
> 
> [...]
> > > +	wifi_pwrseq: wifi_pwrseq {
> > > +		compatible = "mmc-pwrseq-simple";
> > > +		post-power-on-delay-ms = <20>;
> > > +		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;  
> > 
> > Can you add a pinctrl-entry here please? The general rule is to mux
> > things where you use it.
> > 
> yes, there are many places in my patch where they are added to some
> parent devices.
> I will fix that.
> [...]
> > > +	leds {
> > > +		compatible = "gpio-leds";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_led>;  
> > 
> > Please move all muxing you made here into this file or add phandles so
> > the dts file need to add only the muxing stuff. This applies to all
> > pinctrl you made here.
> > 
> so you disagree with this pattern:
> in .dtsi
>  some_device {
>    pinctrl-0 = <&pinctrl_some_device>;
>  };
> 
> and in .dts (one I sent with this patch series and the tolino/mx6sl one
> is not ready-cooked yet, will be part of a later series)
> &iomuxc {
>    pinctrl_some_device: some_devicegrp {
>    	fsl,pins = <...>;
>    };
> };
> 
> ?

Yes, because IMHO a dtsi is self contained as well as a dts. If it is
common for all boards you can move the muxing into the dtsi else it
should be done within the dts.

> > > +
> > > +		GLED {
> > > +			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
> > > +			linux,default-trigger = "timer";
> > > +		};
> > > +	};
> > > +
> > > +	gpio-keys {
> > > +		compatible = "gpio-keys";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > > +		power {
> > > +			label = "Power";
> > > +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> > > +			linux,code = <KEY_POWER>;  
> > 
> > Add missing header: dt-bindings/input/input.h to use this.
> > 
> I am doing this in the .dts but it is probably better to do it here
> because it is used here.
> 
> > > +			gpio-key,wakeup;
> > > +		};
> > > +		cover {
> > > +			label = "Cover";
> > > +			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> > > +			linux,code = <SW_LID>;
> > > +			linux,input-type = <0x05>;    /* EV_SW */  
> > 
> > In the header above EV_SW is also specified so please use it here.
> > 
> This pattern is in many files. I took one as an example. It seems that
> 50% of devicetree files have this pattern, the other 50% do have the
> pattern you proposed (which I like more). So probably EV_SW was not
> available in former times?

I don't know, checking the git history should bring the answer ;)
Anyway, if it is available we should use it.

> > > +			gpio-key,wakeup;
> > > +		};
> > > +	};
> > > +
> > > +};
> > > +
> > > +
> > > +  
> > 
> > Whitespaces
> > 
> > > +&audmux {
> > > +	pinctrl-names = "default";
> > > +	status = "disabled";  
> > 
> > Why you mentioned a pinctrl-names here without the mux? Do we need the
> > status line here? The common case is that such devices are off by
> > default/the base dt.
> > 
> yes, that things can be removed.
> > > +};
> > > +
> > > +&snvs_rtc {
> > > +	status = "disabled";  
> > 
> > Same applies here.
> > 
> 
> No, seems to be an exception, it does not have a status = "disabled" in
> imx6sll.dtsi.

Did you mean 6sll or 6ull?

Okay, is this baseboard only used with a 6ull?

Regards,
  Marco

> > > +};
> > > +
> > > +&i2c1 {
> > > +	clock-frequency = <100000>;
> > > +	pinctrl-names = "default","sleep";
> > > +	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_lm3630a_bl_gpio>;  
> > 
> > The &pinctrl_lm3630a_bl_gpio should be moved into the lm3630a node.
> > 
> > > +	pinctrl-1 = <&pinctrl_i2c1_sleep>;
> > > +	status = "okay";
> > > +
> > > +	lm3630a: lm3630a-i2c@36 {  
> > 
> > please name it backlight@36
> > 
> > > +		reg = <0x36>;
> > > +		status = "ok";  
> > 
> > status lines are always be the last and if it is okay you can drop it
> > because the default is okay.
> > 
> well, I added it because the driver was not loaded but later I found out
> that the real reason is that module aliases were broken and forgot to
> remove that "ok".
> 
> Regards,
> Andreas
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
