Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B35EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD23422CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="G6cNjhEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbfHWKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:25:06 -0400
Received: from vps.xff.cz ([195.181.215.36]:52510 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfHWKZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566555903; bh=s3+8t5raJAu57uzI2j66XL5vmWrDNN4s7OqNz0XuY74=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=G6cNjhEL4gXabfOJtLMLF06hg7mqqqdSoBJG2OLFeqnL0TwIK/yd13XByKBdZCFON
         1zxKMXg2d51/X9WUpWfUKp78dpb7zQpU4KKQaBU0hUVD/YE0EAGw2DXnB93ZCgOa6S
         x3vqeIciy20uLyMKeF7nmvqY28EPND2IjROoxzlc=
Date:   Fri, 23 Aug 2019 12:25:03 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: allwinner: orange-pi-3: Enable WiFi
Message-ID: <20190823102503.ymndnooyzahoi522@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190823094228.6540-1-megous@megous.com>
 <20190823100807.22heh2gahi7owo4e@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823100807.22heh2gahi7owo4e@flea>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Fri, Aug 23, 2019 at 12:08:07PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Aug 23, 2019 at 11:42:28AM +0200, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > Orange Pi 3 has AP6256 WiFi/BT module. WiFi part of the module is called
> > bcm43356 and can be used with the brcmfmac driver. The module is powered by
> > the two always on regulators (not AXP805).
> >
> > WiFi uses a PG port with 1.8V voltage level signals. SoC needs to be
> > configured so that it sets up an 1.8V input bias on this port. This is done
> > by the pio driver by reading the vcc-pg-supply voltage.
> >
> > You'll need a fw_bcm43456c5_ag.bin firmware file and nvram.txt
> > configuration that can be found in the Xulongs's repository for H6:
> >
> > https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256
> >
> > Mainline brcmfmac driver expects the firmware and nvram at the following
> > paths relative to the firmware directory:
> >
> >   brcm/brcmfmac43456-sdio.bin
> >   brcm/brcmfmac43456-sdio.txt
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >
> > Since RTC patches for H6 were merged, this can now go in too, if it looks ok.
> >
> > Other patches for this WiFi chip support were merged in previous cycles,
> > so this just needs enabling in DTS now.
> >
> > Sorry for the links in the commit log, but this information is useful,
> > even if the link itself goes bad. Any pointer what to google for
> > (file names, tree name) is great for anyone searching in the future.
> 
> I understand, but this should (also?) be in the wiki. Please add it
> there too.

Added. Thank you.

  http://linux-sunxi.org/Xunlong_Orange_Pi_3#Firmware_files

regards,
	Ondrej

> > Please take a look.
> >
> > Thank you,
> > 	Ondrej
> >
> >  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > index eda9d5f640b9..49d954369087 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > @@ -56,6 +56,34 @@
> >  		regulator-max-microvolt = <5000000>;
> >  		regulator-always-on;
> >  	};
> > +
> > +	reg_vcc33_wifi: vcc33-wifi {
> > +		/* Always on 3.3V regulator for WiFi and BT */
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc33-wifi";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +		vin-supply = <&reg_vcc5v>;
> > +	};
> > +
> > +	reg_vcc_wifi_io: vcc-wifi-io {
> > +		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-wifi-io";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		regulator-always-on;
> > +		vin-supply = <&reg_vcc33_wifi>;
> > +	};
> > +
> > +	wifi_pwrseq: wifi_pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		clocks = <&rtc 1>;
> > +		clock-names = "ext_clock";
> > +		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> > +		post-power-on-delay-ms = <200>;
> > +	};
> >  };
> >
> >  &cpu0 {
> > @@ -91,6 +119,25 @@
> >  	status = "okay";
> >  };
> >
> > +&mmc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> 
> This is the default already. I've removed it and applied.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

