Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FAEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5E72186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loiNFVGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDEMwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:52:22 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34965 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:52:22 -0400
Received: by mail-yb1-f194.google.com with SMTP id e12so2346290ybq.2;
        Fri, 05 Apr 2019 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4X6driE4WExgVtCfqO3gzc044EgXrQW2x3kr34UtV0M=;
        b=loiNFVGVFOR48fET+HbUajmaKdfJapg3R341xs/FgIqp6yaxOaGq9mMo3WDTNjzN5H
         CnmHz00kR3JJUWa+WkUnPCar8YWzXcTJXezHkFkl9qjnYpt3vcymJndEqE/Gn6nRQAzq
         hm1OTrUbWOk4N0dWIUPvl2tttZn10OqiheQJehPOTMOx3sY/FxgpWurf6a0SrAsTV04b
         ClvUH0F6ExjtVvTziatuNHou47xiS/1zBRXuWpJ1+7IhCqvTeL6m1idimL6DhUIMcEtm
         IumUlxyzYSy633DbqHRNUrv7jFsPEZ6lWi0E/Hx8jXM+/yA3sa9eoaxq4d7mSZZC0pev
         PvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4X6driE4WExgVtCfqO3gzc044EgXrQW2x3kr34UtV0M=;
        b=p79i3s/otcIeLAamBKgSgfigMZHQXOFA/0NwAbotuft7Z8l70aDetKGr+WD4yQ3x5Y
         B3ts5hkhLpqkXSnzKiT60goxno5kvWbD3WZAuqMD9+rLx+SJ42V5cyLAdv6Bi3hC6C4q
         prIa74ZOnzKW/6d2DMyVKaWxv9mHu7bq0T7/nr/J/rOM2xNAaAYmyp5eEjja2lsWgEm8
         1luY0m6cNIFAmZCts1bo6vReBcgX75RStyVANLa3Lh1io+km5lpu7udTWe8SkjBzU7jV
         rW22ji0chJ+j/iMhP8pkMQkznDddu0YGyzelkbNFWmVfeDEbyKeJjcHk3xPVGGPeNVX9
         vFTg==
X-Gm-Message-State: APjAAAU3vSsFrIv2LAlNXv9Wwv5HIKNldjX0VYCCn5dttdwBGq/xFLBH
        lfsPxaFzuPTl5bh0uBuI6wvGp82SgGo9G4/S4xY=
X-Google-Smtp-Source: APXvYqxjgVT9KDGGfmuJS9Wp3nUSHTbJm9UyBxiH9Xeh7Uc+XBUn4yagGJbqLhx9OCoOk7wXqO2/YHJ5+1afRuPC9Vw=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr10738934ybb.23.1554468740476;
 Fri, 05 Apr 2019 05:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190405122446.2101-1-peron.clem@gmail.com> <20190405122446.2101-5-peron.clem@gmail.com>
In-Reply-To: <20190405122446.2101-5-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 14:53:35 +0200
Message-ID: <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com>
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

Hi,

Adding this r_pio regulators make a new error in the bootlog :

[    0.346843] sun50i-h6-r-pinctrl 7022000.pinctrl: Couldn't get bank
PL regulator
[    0.346853] sun50i-h6-r-pinctrl 7022000.pinctrl: request() failed for pi=
n 352
[    0.346862] sun50i-h6-r-pinctrl 7022000.pinctrl: pin-352
(7081400.i2c) status -517
[    0.346871] sun50i-h6-r-pinctrl 7022000.pinctrl: could not request
pin 352 (PL0) from group PL0  on device 7022000.pinctrl
[    0.346878] mv64xxx_i2c 7081400.i2c: Error applying setting,
reverse things back

PL0 and PL1 are SCK/SDA for the PMIC :(

Clement

On Fri, 5 Apr 2019 at 14:21, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Beelink GS1 is an Allwinner H6 based TV box,
> which support:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 2GB LPDDR3 RAM
> - AXP805 PMIC
> - 1Gbps GMAC via RTL8211E
> - FN-Link 6222B-SRB Wifi/BT
> - 1x USB 2.0 Host and 1x USB 3.0 Host
> - HDMI port
> - S/PDIF Tx
> - IR receiver
> - 5V/2A DC power supply
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>
> Thanks to Jagan and Icenowy, most of this devicetree is taken from their =
works on
> the OrangePi One Plus and Pine H64.
>
> Changes in v2 (Thanks to Maxime Ripard):
>  - move MMC pinctrl to SOC dtsi
>  - add board to Sunxi YAML file
>  - add PIO/R_PIO regulators
>  - remove always_on from SDIO regulators
>
>
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 256 ++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.d=
ts
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 11563d3f7c65..9ab9b266881d 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -136,6 +136,11 @@ properties:
>            - const: lemaker,bananapro
>            - const: allwinner,sun7i-a20
>
> +      - description: Beelink GS1
> +        items:
> +          - const: azw,beelink-gs1
> +          - const: allwinner,sun50i-h6
> +
>        - description: Beelink X2
>          items:
>            - const: roofull,beelink-x2
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index e4dce2f6fa3a..2dd806a3d5c9 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-pc2.dt=
b
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-beelink-gs1.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> new file mode 100644
> index 000000000000..d820a138522b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h6.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model =3D "Beelink GS1";
> +       compatible =3D "azw,beelink-gs1", "allwinner,sun50i-h6";
> +
> +       aliases {
> +               ethernet0 =3D &emac;
> +               serial0 =3D &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       connector {
> +               compatible =3D "hdmi-connector";
> +               type =3D "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint =3D <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +
> +               power {
> +                       label =3D "beelink:white:power";
> +                       gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 *=
/
> +                       default-state =3D "on";
> +               };
> +       };
> +
> +       reg_vcc5v: vcc5v {
> +               /* board wide 5V supply directly from the DC jack */
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc-5v";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               regulator-always-on;
> +       };
> +};
> +
> +&de {
> +       status =3D "okay";
> +};
> +
> +&ehci0 {
> +       status =3D "okay";
> +};
> +
> +&emac {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&ext_rgmii_pins>;
> +       phy-mode =3D "rgmii";
> +       phy-handle =3D <&ext_rgmii_phy>;
> +       phy-supply =3D <&reg_aldo2>;
> +       allwinner,rx-delay-ps =3D <0>;
> +       allwinner,tx-delay-ps =3D <0>;
> +       status =3D "okay";
> +};
> +
> +&hdmi {
> +       status =3D "okay";
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint =3D <&hdmi_con_in>;
> +       };
> +};
> +
> +&mdio {
> +       ext_rgmii_phy: ethernet-phy@1 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <1>;
> +       };
> +};
> +
> +&mmc0 {
> +       vmmc-supply =3D <&reg_cldo1>;
> +       cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +       bus-width =3D <4>;
> +       status =3D "okay";
> +};
> +
> +&mmc2 {
> +       vmmc-supply =3D <&reg_cldo1>;
> +       vqmmc-supply =3D <&reg_bldo2>;
> +       non-removable;
> +       cap-mmc-hw-reset;
> +       bus-width =3D <8>;
> +       status =3D "okay";
> +};
> +
> +&ohci0 {
> +       status =3D "okay";
> +};
> +
> +&pio {
> +       vcc-pd-supply =3D <&reg_cldo1>;
> +       vcc-pg-supply =3D <&reg_aldo1>;
> +};
> +
> +&r_i2c {
> +       status =3D "okay";
> +
> +       axp805: pmic@36 {
> +               compatible =3D "x-powers,axp805", "x-powers,axp806";
> +               reg =3D <0x36>;
> +               interrupt-parent =3D <&r_intc>;
> +               interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-controller;
> +               #interrupt-cells =3D <1>;
> +               x-powers,self-working-mode;
> +               vina-supply =3D <&reg_vcc5v>;
> +               vinb-supply =3D <&reg_vcc5v>;
> +               vinc-supply =3D <&reg_vcc5v>;
> +               vind-supply =3D <&reg_vcc5v>;
> +               vine-supply =3D <&reg_vcc5v>;
> +               aldoin-supply =3D <&reg_vcc5v>;
> +               bldoin-supply =3D <&reg_vcc5v>;
> +               cldoin-supply =3D <&reg_vcc5v>;
> +
> +               regulators {
> +                       reg_aldo1: aldo1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc-pl";
> +                       };
> +
> +                       reg_aldo2: aldo2 {
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc-ac200";
> +                               regulator-enable-ramp-delay =3D <100000>;
> +                       };
> +
> +                       reg_aldo3: aldo3 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc25-dram";
> +                       };
> +
> +                       reg_bldo1: bldo1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc-bias-pll";
> +                       };
> +
> +                       reg_bldo2: bldo2 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc-efuse-pcie-hdmi-i=
o";
> +                       };
> +
> +                       reg_bldo3: bldo3 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-name =3D "vcc-dcxoio";
> +                       };
> +
> +                       bldo4 {
> +                               /* unused */
> +                       };
> +
> +                       reg_cldo1: cldo1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc-3v3";
> +                       };
> +
> +                       reg_cldo2: cldo2 {
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc-wifi-1";
> +                       };
> +
> +                       reg_cldo3: cldo3 {
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc-wifi-2";
> +                       };
> +
> +                       reg_dcdca: dcdca {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <810000>;
> +                               regulator-max-microvolt =3D <1080000>;
> +                               regulator-name =3D "vdd-cpu";
> +                       };
> +
> +                       reg_dcdcc: dcdcc {
> +                               regulator-min-microvolt =3D <810000>;
> +                               regulator-max-microvolt =3D <1080000>;
> +                               regulator-name =3D "vdd-gpu";
> +                       };
> +
> +                       reg_dcdcd: dcdcd {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <960000>;
> +                               regulator-max-microvolt =3D <960000>;
> +                               regulator-name =3D "vdd-sys";
> +                       };
> +
> +                       reg_dcdce: dcdce {
> +                               regulator-always-on;
> +                               regulator-min-microvolt =3D <1200000>;
> +                               regulator-max-microvolt =3D <1200000>;
> +                               regulator-name =3D "vcc-dram";
> +                       };
> +
> +                       sw {
> +                               /* unused */
> +                       };
> +               };
> +       };
> +};
> +
> +&r_pio {
> +       vcc-pl-supply =3D <&reg_aldo1>;
> +       vcc-pm-supply =3D <&reg_aldo1>;
> +};
> +
> +&uart0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart0_ph_pins>;
> +       status =3D "okay";
> +};
> +
> +&usb2otg {
> +       dr_mode =3D "host";
> +       status =3D "okay";
> +};
> +
> +&usb2phy {
> +       usb0_vbus-supply =3D <&reg_vcc5v>;
> +       status =3D "okay";
> +};
> --
> 2.17.1
>
