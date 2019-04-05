Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D23021855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnwULOBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfDENH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:07:56 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41985 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:07:56 -0400
Received: by mail-yb1-f193.google.com with SMTP id l124so857714ybf.9;
        Fri, 05 Apr 2019 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/rZw+omkdtebTrMmsTTXY6J3AGMbTfxqz54VzMnfPs=;
        b=hnwULOBdbT/CXl2oNI7anAY3SOR03s2NMbP0C63Y/uChwvOWDD9vD5JvL1l9nSC+mZ
         Lq2TQAcEYiexgK0OfyssLyIiOv3PmQ+95HYsUwK3eENutj7aaCeZkecv6CkhKvEZdLmm
         +OxEbQf+m2ngbnccjvUzNF7unRHmGdd3WkRXFiE0bqI+NJkF9Wb2pxNYFKsF53U/wJhd
         EJ9mlTfZZ+w3R1aBvms9Dyq4gb4b37XNnx/0EbLgTwEGfh7aJGUVJ2AKaSKOtBNw8TWD
         PlhfdPYK3U5vL0zWJRP379Vcbu+Fob8+gGOpY6f28got1v9YKZd6dkdoWpBfcQNpfb56
         uowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/rZw+omkdtebTrMmsTTXY6J3AGMbTfxqz54VzMnfPs=;
        b=NKQOzKUn2j0pjrXKlDjG3qtp6D5DR4HRgc/unEGqGn3l+ig1ohtmLBX6PgedQ2jAt8
         olDd6pjZRZE718QIZdGjuzx/t6VQPn2cb89IYDRNCPecX2UiHBJxSJV//C93e8OT0Db+
         jzypR9z52sZK9+c3+t+oS/bJwUrgGTfCuznhsu/SrQFwANyh/vDA2YQSqsiaFraDg7Uu
         aqmb3bKbY5kQ6/w4qFiAvlYGySgOZsVDzD20HfFNos8CHSPoRvr4rIx003654SMQaUJL
         H17JL5Hrnerk05R813yrzt44wa3PC1mLV04wx79U0D+qDVv5qJN3SyKvdxlZH+L3xHeo
         Fm4w==
X-Gm-Message-State: APjAAAV0XraPhCwiKhvk8HHs+R959ZwUhV+23FgTKAGa4x4TApHBJnzD
        fHq2klxZvQlzW4Yw7DlOpRLquznvF9OeO9tfRWvprA==
X-Google-Smtp-Source: APXvYqw9q8VPB0C2SMrInu5IJOU14MkStSbXx/gAGRmttAQF+fW9pXRDvvp1Ld2oDkQ3gX5ZqcYscIee9CvLIrtq6+E=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr10813569ybb.23.1554469674878;
 Fri, 05 Apr 2019 06:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190405122446.2101-1-peron.clem@gmail.com> <20190405122446.2101-5-peron.clem@gmail.com>
 <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com>
In-Reply-To: <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 15:07:56 +0200
Message-ID: <CAJiuCcf0RwmhXu2UkKUpZA6nXTTwziVQFJZx-5xXX4Y9FcqDZw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probing PMIC, Probe the PL0/1 Pins which Probe PL Bank power which Probe PM=
IC


On Fri, 5 Apr 2019 at 14:53, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi,
>
> Adding this r_pio regulators make a new error in the bootlog :
>
> [    0.346843] sun50i-h6-r-pinctrl 7022000.pinctrl: Couldn't get bank
> PL regulator
> [    0.346853] sun50i-h6-r-pinctrl 7022000.pinctrl: request() failed for =
pin 352
> [    0.346862] sun50i-h6-r-pinctrl 7022000.pinctrl: pin-352
> (7081400.i2c) status -517
> [    0.346871] sun50i-h6-r-pinctrl 7022000.pinctrl: could not request
> pin 352 (PL0) from group PL0  on device 7022000.pinctrl
> [    0.346878] mv64xxx_i2c 7081400.i2c: Error applying setting,
> reverse things back
>
> PL0 and PL1 are SCK/SDA for the PMIC :(
>
> Clement
>
> On Fri, 5 Apr 2019 at 14:21, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m> wrote:
> >
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
> > Changes in v2 (Thanks to Maxime Ripard):
> >  - move MMC pinctrl to SOC dtsi
> >  - add board to Sunxi YAML file
> >  - add PIO/R_PIO regulators
> >  - remove always_on from SDIO regulators
> >
> >
> >  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 256 ++++++++++++++++++
> >  3 files changed, 262 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1=
.dts
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documen=
tation/devicetree/bindings/arm/sunxi.yaml
> > index 11563d3f7c65..9ab9b266881d 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -136,6 +136,11 @@ properties:
> >            - const: lemaker,bananapro
> >            - const: allwinner,sun7i-a20
> >
> > +      - description: Beelink GS1
> > +        items:
> > +          - const: azw,beelink-gs1
> > +          - const: allwinner,sun50i-h6
> > +
> >        - description: Beelink X2
> >          items:
> >            - const: roofull,beelink-x2
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
> > index 000000000000..d820a138522b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -0,0 +1,256 @@
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
> > +       model =3D "Beelink GS1";
> > +       compatible =3D "azw,beelink-gs1", "allwinner,sun50i-h6";
> > +
> > +       aliases {
> > +               ethernet0 =3D &emac;
> > +               serial0 =3D &uart0;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial0:115200n8";
> > +       };
> > +
> > +       connector {
> > +               compatible =3D "hdmi-connector";
> > +               type =3D "a";
> > +
> > +               port {
> > +                       hdmi_con_in: endpoint {
> > +                               remote-endpoint =3D <&hdmi_out_con>;
> > +                       };
> > +               };
> > +       };
> > +
> > +       leds {
> > +               compatible =3D "gpio-leds";
> > +
> > +               power {
> > +                       label =3D "beelink:white:power";
> > +                       gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4=
 */
> > +                       default-state =3D "on";
> > +               };
> > +       };
> > +
> > +       reg_vcc5v: vcc5v {
> > +               /* board wide 5V supply directly from the DC jack */
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc-5v";
> > +               regulator-min-microvolt =3D <5000000>;
> > +               regulator-max-microvolt =3D <5000000>;
> > +               regulator-always-on;
> > +       };
> > +};
> > +
> > +&de {
> > +       status =3D "okay";
> > +};
> > +
> > +&ehci0 {
> > +       status =3D "okay";
> > +};
> > +
> > +&emac {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&ext_rgmii_pins>;
> > +       phy-mode =3D "rgmii";
> > +       phy-handle =3D <&ext_rgmii_phy>;
> > +       phy-supply =3D <&reg_aldo2>;
> > +       allwinner,rx-delay-ps =3D <0>;
> > +       allwinner,tx-delay-ps =3D <0>;
> > +       status =3D "okay";
> > +};
> > +
> > +&hdmi {
> > +       status =3D "okay";
> > +};
> > +
> > +&hdmi_out {
> > +       hdmi_out_con: endpoint {
> > +               remote-endpoint =3D <&hdmi_con_in>;
> > +       };
> > +};
> > +
> > +&mdio {
> > +       ext_rgmii_phy: ethernet-phy@1 {
> > +               compatible =3D "ethernet-phy-ieee802.3-c22";
> > +               reg =3D <1>;
> > +       };
> > +};
> > +
> > +&mmc0 {
> > +       vmmc-supply =3D <&reg_cldo1>;
> > +       cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> > +       bus-width =3D <4>;
> > +       status =3D "okay";
> > +};
> > +
> > +&mmc2 {
> > +       vmmc-supply =3D <&reg_cldo1>;
> > +       vqmmc-supply =3D <&reg_bldo2>;
> > +       non-removable;
> > +       cap-mmc-hw-reset;
> > +       bus-width =3D <8>;
> > +       status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> > +       status =3D "okay";
> > +};
> > +
> > +&pio {
> > +       vcc-pd-supply =3D <&reg_cldo1>;
> > +       vcc-pg-supply =3D <&reg_aldo1>;
> > +};
> > +
> > +&r_i2c {
> > +       status =3D "okay";
> > +
> > +       axp805: pmic@36 {
> > +               compatible =3D "x-powers,axp805", "x-powers,axp806";
> > +               reg =3D <0x36>;
> > +               interrupt-parent =3D <&r_intc>;
> > +               interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> > +               interrupt-controller;
> > +               #interrupt-cells =3D <1>;
> > +               x-powers,self-working-mode;
> > +               vina-supply =3D <&reg_vcc5v>;
> > +               vinb-supply =3D <&reg_vcc5v>;
> > +               vinc-supply =3D <&reg_vcc5v>;
> > +               vind-supply =3D <&reg_vcc5v>;
> > +               vine-supply =3D <&reg_vcc5v>;
> > +               aldoin-supply =3D <&reg_vcc5v>;
> > +               bldoin-supply =3D <&reg_vcc5v>;
> > +               cldoin-supply =3D <&reg_vcc5v>;
> > +
> > +               regulators {
> > +                       reg_aldo1: aldo1 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc-pl";
> > +                       };
> > +
> > +                       reg_aldo2: aldo2 {
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc-ac200";
> > +                               regulator-enable-ramp-delay =3D <100000=
>;
> > +                       };
> > +
> > +                       reg_aldo3: aldo3 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc25-dram";
> > +                       };
> > +
> > +                       reg_bldo1: bldo1 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "vcc-bias-pll";
> > +                       };
> > +
> > +                       reg_bldo2: bldo2 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "vcc-efuse-pcie-hdmi=
-io";
> > +                       };
> > +
> > +                       reg_bldo3: bldo3 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <1800000>;
> > +                               regulator-max-microvolt =3D <1800000>;
> > +                               regulator-name =3D "vcc-dcxoio";
> > +                       };
> > +
> > +                       bldo4 {
> > +                               /* unused */
> > +                       };
> > +
> > +                       reg_cldo1: cldo1 {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc-3v3";
> > +                       };
> > +
> > +                       reg_cldo2: cldo2 {
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc-wifi-1";
> > +                       };
> > +
> > +                       reg_cldo3: cldo3 {
> > +                               regulator-min-microvolt =3D <3300000>;
> > +                               regulator-max-microvolt =3D <3300000>;
> > +                               regulator-name =3D "vcc-wifi-2";
> > +                       };
> > +
> > +                       reg_dcdca: dcdca {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <810000>;
> > +                               regulator-max-microvolt =3D <1080000>;
> > +                               regulator-name =3D "vdd-cpu";
> > +                       };
> > +
> > +                       reg_dcdcc: dcdcc {
> > +                               regulator-min-microvolt =3D <810000>;
> > +                               regulator-max-microvolt =3D <1080000>;
> > +                               regulator-name =3D "vdd-gpu";
> > +                       };
> > +
> > +                       reg_dcdcd: dcdcd {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <960000>;
> > +                               regulator-max-microvolt =3D <960000>;
> > +                               regulator-name =3D "vdd-sys";
> > +                       };
> > +
> > +                       reg_dcdce: dcdce {
> > +                               regulator-always-on;
> > +                               regulator-min-microvolt =3D <1200000>;
> > +                               regulator-max-microvolt =3D <1200000>;
> > +                               regulator-name =3D "vcc-dram";
> > +                       };
> > +
> > +                       sw {
> > +                               /* unused */
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&r_pio {
> > +       vcc-pl-supply =3D <&reg_aldo1>;
> > +       vcc-pm-supply =3D <&reg_aldo1>;
> > +};
> > +
> > +&uart0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&uart0_ph_pins>;
> > +       status =3D "okay";
> > +};
> > +
> > +&usb2otg {
> > +       dr_mode =3D "host";
> > +       status =3D "okay";
> > +};
> > +
> > +&usb2phy {
> > +       usb0_vbus-supply =3D <&reg_vcc5v>;
> > +       status =3D "okay";
> > +};
> > --
> > 2.17.1
> >
