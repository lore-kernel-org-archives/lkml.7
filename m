Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C353CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927DA206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sON/hvFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfDEMAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:00:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38972 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:00:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id b88so2280554ybi.6;
        Fri, 05 Apr 2019 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eVZEFw/9PlUm/k4lmOvhKeUNX5aqQT3h2z2tllpFKso=;
        b=sON/hvFWKy2YB56GLVdzo7D/SbtsEziV3fwSOzOq6tSACyoEHLGrk0l8Rqr8N31VDS
         mHNatQbBcNH3dtsiPmI+5QcZjInNJz7XEH2F4FkpLWZ1vGQrkt3hX7oTpr+BLgrwxFwO
         wWTGuTOr6gryh/NEUjps6lYG1vYkcOE51rhxNtQoroxzs4rkYMz1/2Db7VS9ZLmkM0VT
         vlbK6WNrctbhYD7sAmz7NlZSKPoowoclavhScq8K1J+SF5gWHupIprbyAn5pg8mqGGes
         WTVJQtoRME2flJVafD/EORoWjeYSb6ek3GbNrrVWmB7142S4gj+njmDaraZGqDospLWU
         44Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eVZEFw/9PlUm/k4lmOvhKeUNX5aqQT3h2z2tllpFKso=;
        b=MvPo2eAfqxanlppe9FF3MfQkp/MVSqO1HPAtl85L8g6kFstas4OIr/VszHot7HmsHs
         yxIOfJUXsLv8e3eNj4lgpYExJN1pbWpZKN7hA1bzyfIBYwA4yonZvZAUSWp0w9e5hod4
         Fzs/53r8bw5QG45RgWL4PZPta9MFBi52dIb+s/U3r+xQsT9rzA8dxwayHYQ9XdWKNN2x
         6oZ9uWdXQ6zcGlCd1r8NyNZiYFHHGzOgQ61tRC+RUVfyb4GO97N4nlIBkIgLCCr4czkL
         v346fFvLwZM935dMMZ+snN3KTFxDP4/iuVtDMvKk7WTcLAVzNieLh7nt7LycgbDdsZSn
         CPqA==
X-Gm-Message-State: APjAAAWk9vo+gOMiI0Ebg8fwMbW6vDwcweEGqdeNRFuaLUdM20qPNNeD
        2KKa9vWRiosKLMH4vcIJwh/n8JBT9neLwBs+ZQg=
X-Google-Smtp-Source: APXvYqwi5JsCP+RuMKxbyPRIrDC78urG8Tw3s+JNvEQRp2Txo7Crkqg2s8gqz09KYbXEdcEydF2LoGO2N6nw0i9cHbM=
X-Received: by 2002:a25:c9c7:: with SMTP id z190mr10542070ybf.234.1554465634346;
 Fri, 05 Apr 2019 05:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190404124504.11137-1-peron.clem@gmail.com> <20190404124504.11137-2-peron.clem@gmail.com>
 <20190405090836.cyz2eabxpqjgesig@flea>
In-Reply-To: <20190405090836.cyz2eabxpqjgesig@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 14:02:17 +0200
Message-ID: <CAJiuCcdGHgUgUg5xAVPjcxeCqJwnoVjf69_CJaWF22iGPNfniw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Apr 2019 at 11:08, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> Hi,
>
> On Thu, Apr 04, 2019 at 02:45:04PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Beelink GS1 is an Allwinner H6 based TV box,
> > which support:
> > - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> > - GPU Mali-T720
> > - 2GB LPDDR3 RAM
> > - AXP805 PMIC
> > - 1Gbps GMAC via RTL8211E
> > - FN-Link 6222B-SRB Wifi/BT
> > - 1x USB 2.0 Host and 1x USB 3.0 Host
> > - HDMI port
> > - S/PDIF Tx
> > - IR receiver
> > - 5V/2A DC power supply
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >
> > Thanks to Jagan and Icenowy, most of this devicetree is taken from thei=
r works on
> > the OrangePi One Plus and Pine H64.
> >
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 252 ++++++++++++++++++
> >  2 files changed, 253 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1=
.dts
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/d=
ts/allwinner/Makefile
> > index e4dce2f6fa3a..2dd806a3d5c9 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-pc2.=
dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-prime.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-beelink-gs1.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > new file mode 100644
> > index 000000000000..d927e7d33bf3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -0,0 +1,252 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2019 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h6.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +     model =3D "Beelink GS1";
> > +     compatible =3D "azw,beelink-gs1", "allwinner,sun50i-h6";
>
> Please add that board to
> Documentation/devicetree/bindings/arm/sunxi.yaml, it's new and in
> linux-next.

OK didn't know about that will do it.

>
> > +&mmc0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&mmc0_pins>;
> > +     vmmc-supply =3D <&reg_cldo1>;
> > +     cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> > +     bus-width =3D <4>;
> > +     status =3D "okay";
> > +};
> > +
> > +&mmc2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&mmc2_pins>;
>
> If those (mmc0 and mmc2_pins) are the only muxing options as their
> names suggests, it should be set in the DTSI.
Yes, it's the only muxing. I will add a patch to move these in the SOC dtsi=
.

>
> If not, the name of the pin group should be changed.
>
> > +                     reg_cldo2: cldo2 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-name =3D "vcc-wifi-1";
> > +                     };
> > +
> > +                     reg_cldo3: cldo3 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-name =3D "vcc-wifi-2";
> > +                     };
>
> I don't see any SDIO bus declared, why do you need those regulators on?
You're right forget to remove. Will do.

>
> Can you also declare the PIO regulators?
Ok,

Thanks for the review.


>
> Thanks!
> Maxmie
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
