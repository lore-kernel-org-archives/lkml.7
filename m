Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAF2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eziIZnB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGBNKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:10:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36372 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGBNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:10:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id w7so12955497oic.3;
        Tue, 02 Jul 2019 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+YYdqr8bHiNSEYONgr3xT13YUnhch+TwXd78BsjKwI=;
        b=eziIZnB6UP2ncLWyn1GIs6IAQ6SmVLTiTWALqJ+NV95ZQXJosk2Rvc1xfqvA52MTIn
         mgv4E8NtfTj5k3n6f53wl9p4IG6ogNipFlNvCPXpKWAsvUo6rI/tSLPcGJsLoVFN34wy
         DQhGbygbUXg4iYmFiI/32JeyjhpJVBmvAFPhDEMXadQSmPiYO21rfZerCLKcbUYi4IoD
         KoIcqFkcyw8OqCHyRgnQo2XBD/KFJrWlUQfL2IyBBfh8X9xp2nhqQuU29CInf/KIRFLC
         YMl3bQ3GJMuVsA0+n+wV/hV5cH9LVso09EvL0AoAzXbjISvNH0WL53i8RMAJwSVa1yOU
         kPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+YYdqr8bHiNSEYONgr3xT13YUnhch+TwXd78BsjKwI=;
        b=L2qZC/+eXOwWqbXMmlEOSF9VmSyNBKxebAeoISH3a0N9klAUg5eVcZ51JM7USpdZL4
         S7QB9S8GBpjnSGMMHS8bHQXgbz5MzJHsfVYOS3ANewLLrd4XPFi2L1Ddy0HOMjJSFXwn
         rtWq//2R8C6JX28tEOO6r09D1KfFmmpVyNvX33bOJtNb3wyg39dqaIV23gJUQsRUolo/
         4/xVCJSLQ5O3JxObRgMcyroH0JH7PZoaApaezU76zCulPHsH+kSyBq+u5O+WDaDZ2tHW
         UZqnGy5/Lyml22Y/VZtrAOm0bCk7GKpTFtYv52qFM0/pOrDOr6mg5a2AKmuqRathuZCX
         9Mag==
X-Gm-Message-State: APjAAAWRqAwpSCcnDJTO542qQ8A9zUKKKKr+SC4IwQzP8/9swTTwKMFw
        CAe6D+CK5ix9emDIw6L4XOOrJNKWwPuk/8mAfqM=
X-Google-Smtp-Source: APXvYqyq4wtqpeOn7WAu2ZGR+EIUAbmE9caVAmYMQd3rx0io+tEem31bMZ3ZoSZGINgd5GV4DG56W3ilgF34KRgFmHA=
X-Received: by 2002:aca:f4ce:: with SMTP id s197mr2940295oih.45.1562073029171;
 Tue, 02 Jul 2019 06:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190702130239.17864-1-andradanciu1997@gmail.com>
In-Reply-To: <20190702130239.17864-1-andradanciu1997@gmail.com>
From:   Andra Danciu <andradanciu1997@gmail.com>
Date:   Tue, 2 Jul 2019 16:10:21 +0300
Message-ID: <CAJNLGsz9SGZV-+Si+6zyg91k3FebE2AwydwqTZb_ZLziwitLNw@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: freescale: add wand-pi-8m dtb
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, andrew.smirnov@gmail.com, angus@akkea.ca,
        ccaione@baylibre.com, agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this. Sent the wrong patch!

=C3=8En mar., 2 iul. 2019 la 16:02, Andra Danciu <andradanciu1997@gmail.com=
> a scris:
>
> From: Richard Hu <richard.hu@technexion.com>
>
> Add dtb for WAND-PI-8M board.
> ---
>  arch/arm64/boot/dts/freescale/Makefile       |   3 +-
>  arch/arm64/boot/dts/freescale/wand-pi-8m.dts | 780 +++++++++++++++++++++=
++++++
>  2 files changed, 782 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/wand-pi-8m.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 7a9dae6c43f5..308bbb1caa60 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -51,7 +51,8 @@ dtb-$(CONFIG_ARCH_FSL_IMX8MQ) +=3D fsl-imx8mq-ddr3l-arm=
2.dtb \
>                                  fsl-imx8mq-evk-dual-display.dtb \
>                                  fsl-imx8mq-evk-ak4497.dtb \
>                                  fsl-imx8mq-evk-audio-tdm.dtb \
> -                                fsl-imx8mq-evk-drm.dtb
> +                                fsl-imx8mq-evk-drm.dtb \
> +                                wand-pi-8m.dtb
>
>  always         :=3D $(dtb-y)
>  subdir-y       :=3D $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/freescale/wand-pi-8m.dts b/arch/arm64/bo=
ot/dts/freescale/wand-pi-8m.dts
> new file mode 100644
> index 000000000000..cc1d55ee88e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/wand-pi-8m.dts
> @@ -0,0 +1,780 @@
> +/*
> + * Copyright 2018 Wandboard, Org.
> + * Copyright 2017 NXP
> + *
> + * Author: Richard Hu <hakahu@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-imx8mq.dtsi"
> +
> +/ {
> +       model =3D "WAND-PI-8M";
> +       compatible =3D "wand,imx8mq-wand-pi", "fsl,imx8mq";
> +
> +       chosen {
> +               bootargs =3D "console=3Dttymxc0,115200 earlycon=3Dec_imx6=
q,0x30860000,115200";
> +               stdout-path =3D &uart1;
> +       };
> +
> +       regulators {
> +               compatible =3D "simple-bus";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               reg_usdhc2_vmmc: usdhc2_vmmc {
> +                       compatible =3D "regulator-fixed";
> +                       regulator-name =3D "VSD_3V3";
> +                       regulator-min-microvolt =3D <3300000>;
> +                       regulator-max-microvolt =3D <3300000>;
> +                       gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +                       enable-active-high;
> +               };
> +
> +               reg_gpio_dvfs: regulator-gpio {
> +                       compatible =3D "regulator-gpio";
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&pinctrl_dvfs>;
> +                       regulator-min-microvolt =3D <900000>;
> +                       regulator-max-microvolt =3D <1000000>;
> +                       regulator-name =3D "gpio_dvfs";
> +                       regulator-type =3D "voltage";
> +                       gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +                       states =3D <900000 0x1 1000000 0x0>;
> +               };
> +       };
> +
> +       modem_reset: modem-reset {
> +               compatible =3D "gpio-reset";
> +               reset-gpios =3D <&gpio3 5 GPIO_ACTIVE_LOW>;
> +               reset-delay-us =3D <2000>;
> +               reset-post-delay-ms =3D <40>;
> +               #reset-cells =3D <0>;
> +       };
> +
> +       wm8524: wm8524 {
> +               compatible =3D "wlf,wm8524";
> +               clocks =3D <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +               clock-names =3D "mclk";
> +               wlf,mute-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> +       };
> +
> +       sound-wm8524 {
> +               compatible =3D "fsl,imx-audio-wm8524";
> +               model =3D "wm8524-audio";
> +               audio-cpu =3D <&sai2>;
> +               audio-codec =3D <&wm8524>;
> +               audio-routing =3D
> +                       "Line Out Jack", "LINEVOUTL",
> +                       "Line Out Jack", "LINEVOUTR";
> +       };
> +
> +       sound-hdmi {
> +               compatible =3D "fsl,imx-audio-cdnhdmi";
> +               model =3D "imx-audio-hdmi";
> +               audio-cpu =3D <&sai4>;
> +               protocol =3D <1>;
> +       };
> +
> +       sound-spdif {
> +               compatible =3D "fsl,imx-audio-spdif";
> +               model =3D "imx-spdif";
> +               spdif-controller =3D <&spdif1>;
> +               spdif-out;
> +               spdif-in;
> +       };
> +
> +       sound-hdmi-arc {
> +               compatible =3D "fsl,imx-audio-spdif";
> +               model =3D "imx-hdmi-arc";
> +               spdif-controller =3D <&spdif2>;
> +               spdif-in;
> +       };
> +};
> +
> +&clk {
> +       assigned-clocks =3D <&clk IMX8MQ_AUDIO_PLL1>;
> +       assigned-clock-rates =3D <786432000>;
> +};
> +
> +&iomuxc {
> +       pinctrl-names =3D "default";
> +
> +       wand-pi-8m {
> +               pinctrl_csi1: csi1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3        =
       0x19
> +                               MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6        =
       0x19
> +                               MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO=
2      0x59
> +                       >;
> +               };
> +               pinctrl_csi2: csi2grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5        =
       0x19
> +                               MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6        =
       0x19
> +                               MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO=
2      0x59
> +                       >;
> +               };
> +
> +               pinctrl_fec1: fec1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC         0=
x3
> +                               MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO       0=
x23
> +                               MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3   0=
x1f
> +                               MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2   0=
x1f
> +                               MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1   0=
x1f
> +                               MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0   0=
x1f
> +                               MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3   0=
x91
> +                               MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2   0=
x91
> +                               MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1   0=
x91
> +                               MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0   0=
x91
> +                               MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC   0=
x1f
> +                               MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC   0=
x91
> +                               MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_C=
TL     0x91
> +                               MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_C=
TL     0x1f
> +                               MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9       0=
x19
> +                       >;
> +               };
> +
> +               pinctrl_i2c1: i2c1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL           =
       0x4000007f
> +                               MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA           =
       0x4000007f
> +                       >;
> +               };
> +
> +               pinctrl_i2c2: i2c2grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL           =
       0x4000007f
> +                               MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA           =
       0x4000007f
> +                       >;
> +               };
> +
> +
> +               pinctrl_pcie0: pcie0grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_I2C4_SCL_GPIO5_IO20        0=
x16
> +                               MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29       0=
x16
> +                               MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28       0=
x16
> +                       >;
> +               };
> +
> +               pinctrl_pcie1: pcie1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_I2C4_SDA_GPIO5_IO21        0=
x16
> +                               MX8MQ_IOMUXC_ECSPI2_SCLK_GPIO5_IO10     0=
x16
> +                               MX8MQ_IOMUXC_ECSPI2_MISO_GPIO5_IO12     0=
x16
> +                       >;
> +               };
> +
> +               pinctrl_dvfs: dvfsgrp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13      0=
x16
> +                       >;
> +               };
> +
> +               pinctrl_qspi: qspigrp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK       0=
x82
> +                               MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B    0=
x82
> +                               MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0   0=
x82
> +                               MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1   0=
x82
> +                               MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2   0=
x82
> +                               MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3   0=
x82
> +
> +                       >;
> +               };
> +
> +               pinctrl_typec: typecgrp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15       0=
x16
> +                               MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3       0=
x17059
> +                       >;
> +               };
> +
> +               pinctrl_uart1: uart1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX      =
       0x49
> +                               MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX      =
       0x49
> +                       >;
> +               };
> +
> +               pinctrl_uart3: uart3grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX      =
       0x49
> +                               MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX      =
       0x49
> +                               MX8MQ_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B =
       0x49
> +                               MX8MQ_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B  =
       0x49
> +                               MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5          =
       0x19
> +                       >;
> +               };
> +
> +               pinctrl_usdhc1: usdhc1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x83
> +                               MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc3
> +                               MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x83
> +                               MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B  =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x85
> +                               MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc5
> +                               MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x85
> +                               MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B  =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x87
> +                               MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc7
> +                               MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x87
> +                               MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B  =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_usdhc2_gpio: usdhc2grpgpio {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12        0=
x41
> +                               MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19     0=
x41
> +                       >;
> +               };
> +
> +               pinctrl_usdhc2: usdhc2grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x83
> +                               MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc3
> +                               MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc3
> +                               MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc3
> +                               MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc3
> +                               MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc3
> +                               MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x85
> +                               MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc5
> +                               MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc5
> +                               MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc5
> +                               MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc5
> +                               MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc5
> +                               MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x87
> +                               MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc7
> +                               MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc7
> +                               MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc7
> +                               MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc7
> +                               MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc7
> +                               MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> +                       >;
> +               };
> +
> +               pinctrl_sai2: sai2grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0=
xd6
> +                               MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0=
xd6
> +                               MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0=
xd6
> +                               MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0=
xd6
> +                               MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0=
xd6
> +                       >;
> +               };
> +
> +               pinctrl_spdif1: spdif1grp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT        0=
xd6
> +                               MX8MQ_IOMUXC_SPDIF_RX_SPDIF1_IN         0=
xd6
> +                       >;
> +               };
> +
> +               pinctrl_wdog: wdoggrp {
> +                       fsl,pins =3D <
> +                               MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
> +                       >;
> +               };
> +       };
> +};
> +
> +&fec1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_fec1>;
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&ethphy0>;
> +       fsl,magic-packet;
> +       status =3D "okay";
> +
> +       mdio {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               ethphy0: ethernet-phy@0 {
> +                       compatible =3D "ethernet-phy-ieee802.3-c22";
> +                       reg =3D <0>;
> +                       at803x,led-act-blind-workaround;
> +                       at803x,eee-disabled;
> +               };
> +       };
> +};
> +
> +&i2c1 {
> +       clock-frequency =3D <100000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c1>;
> +       status =3D "okay";
> +
> +       pmic: pfuze100@08 {
> +               compatible =3D "fsl,pfuze100";
> +               reg =3D <0x08>;
> +
> +               regulators {
> +                       sw1a_reg: sw1ab {
> +                               regulator-min-microvolt =3D <300000>;
> +                               regulator-max-microvolt =3D <1875000>;
> +                       };
> +
> +                       sw1c_reg: sw1c {
> +                               regulator-min-microvolt =3D <300000>;
> +                               regulator-max-microvolt =3D <1875000>;
> +                       };
> +
> +                       sw2_reg: sw2 {
> +                               regulator-min-microvolt =3D <800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw3a_reg: sw3ab {
> +                               regulator-min-microvolt =3D <400000>;
> +                               regulator-max-microvolt =3D <1975000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       sw4_reg: sw4 {
> +                               regulator-min-microvolt =3D <800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       swbst_reg: swbst {
> +                               regulator-min-microvolt =3D <5000000>;
> +                               regulator-max-microvolt =3D <5150000>;
> +                       };
> +
> +                       snvs_reg: vsnvs {
> +                               regulator-min-microvolt =3D <1000000>;
> +                               regulator-max-microvolt =3D <3000000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vref_reg: vrefddr {
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen1_reg: vgen1 {
> +                               regulator-min-microvolt =3D <800000>;
> +                               regulator-max-microvolt =3D <1550000>;
> +                       };
> +
> +                       vgen2_reg: vgen2 {
> +                               regulator-min-microvolt =3D <800000>;
> +                               regulator-max-microvolt =3D <1550000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen3_reg: vgen3 {
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen4_reg: vgen4 {
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen5_reg: vgen5 {
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen6_reg: vgen6 {
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                       };
> +               };
> +       };
> +
> +       typec_ptn5100: ptn5110@50 {
> +               compatible =3D "usb,tcpci";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_typec>;
> +               reg =3D <0x50>;
> +               interrupt-parent =3D <&gpio3>;
> +               interrupts =3D <3 8>;
> +               ss-sel-gpios =3D <&gpio3 15 GPIO_ACTIVE_HIGH>;
> +               src-pdos =3D <0x380190c8>;
> +               snk-pdos =3D <0x380190c8 0x3802d0c8>;
> +               max-snk-mv =3D <9000>;
> +               max-snk-ma =3D <1000>;
> +               op-snk-mw =3D <9000>;
> +               port-type =3D "drp";
> +               default-role =3D "sink";
> +       };
> +
> +       ov5640_mipi: ov5640_mipi@3c {
> +               compatible =3D "ovti,ov5640_mipi";
> +               reg =3D <0x3c>;
> +               status =3D "okay";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_csi1>;
> +               clocks =3D <&clk IMX8MQ_CLK_CLKO2_DIV>;
> +               clock-names =3D "csi_mclk";
> +               assigned-clocks =3D <&clk IMX8MQ_CLK_CLKO2_SRC>,
> +                                 <&clk IMX8MQ_CLK_CLKO2_DIV>;
> +               assigned-clock-parents =3D <&clk IMX8MQ_SYS2_PLL_200M>;
> +               assigned-clock-rates =3D <0>, <20000000>;
> +               csi_id =3D <0>;
> +               pwn-gpios =3D <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +               rst-gpios =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +               mclk =3D <20000000>;
> +               mclk_source =3D <0>;
> +               port {
> +                       ov5640_mipi1_ep: endpoint {
> +                               remote-endpoint =3D <&mipi1_sensor_ep>;
> +                       };
> +               };
> +       };
> +
> +       ov5640_mipi2: ov5640_mipi2@3c {
> +               compatible =3D "ovti,ov5640_mipi";
> +               reg =3D <0x3c>;
> +               status =3D "disabled";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_csi2>;
> +               clocks =3D <&clk IMX8MQ_CLK_CLKO2_DIV>;
> +               clock-names =3D "csi_mclk";
> +               assigned-clocks =3D <&clk IMX8MQ_CLK_CLKO2_SRC>,
> +                                 <&clk IMX8MQ_CLK_CLKO2_DIV>;
> +               assigned-clock-parents =3D <&clk IMX8MQ_SYS2_PLL_200M>;
> +               assigned-clock-rates =3D <0>, <20000000>;
> +               csi_id =3D <0>;
> +               pwn-gpios =3D <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +               rst-gpios =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +               mclk =3D <20000000>;
> +               mclk_source =3D <0>;
> +               port {
> +                       ov5640_mipi2_ep: endpoint {
> +                               remote-endpoint =3D <&mipi2_sensor_ep>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c2 {
> +       clock-frequency =3D <100000>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c2>;
> +       status =3D "disabled";
> +};
> +
> +&pcie0{
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pcie0>;
> +       clkreq-gpio =3D <&gpio5 20 GPIO_ACTIVE_LOW>;
> +       disable-gpio =3D <&gpio5 29 GPIO_ACTIVE_LOW>;
> +       reset-gpio =3D <&gpio5 28 GPIO_ACTIVE_LOW>;
> +       ext_osc =3D <1>;
> +       hard-wired =3D <1>;
> +       status =3D "okay";
> +};
> +
> +&pcie1{
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pcie1>;
> +       clkreq-gpio =3D <&gpio5 21 GPIO_ACTIVE_LOW>;
> +       disable-gpio =3D <&gpio5 10 GPIO_ACTIVE_LOW>;
> +       reset-gpio =3D <&gpio5 12 GPIO_ACTIVE_LOW>;
> +       ext_osc =3D <1>;
> +       status =3D "okay";
> +};
> +
> +&uart1 { /* console */
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart1>;
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_UART1_SRC>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_CLK_25M>;
> +       status =3D "okay";
> +};
> +
> +&qspi {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_qspi>;
> +       status =3D "okay";
> +
> +       flash0: n25q256a@0 {
> +               reg =3D <0>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               compatible =3D "micron,n25q256a";
> +               spi-max-frequency =3D <29000000>;
> +               spi-nor,ddr-quad-read-dummy =3D <6>;
> +       };
> +};
> +
> +&uart3 { /* BT */
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_uart3>;
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_UART3_SRC>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_SYS1_PLL_80M>;
> +       fsl,uart-has-rtscts;
> +       resets =3D <&modem_reset>;
> +       status =3D "okay";
> +};
> +
> +&usdhc1 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc1>;
> +       pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> +       pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
> +       bus-width =3D <8>;
> +       non-removable;
> +       status =3D "okay";
> +};
> +
> +&usdhc2 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +       bus-width =3D <4>;
> +       cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> +       vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +       status =3D "okay";
> +};
> +
> +&usb3_phy0 {
> +       status =3D "okay";
> +};
> +
> +&usb3_0 {
> +       status =3D "okay";
> +};
> +
> +&usb_dwc3_0 {
> +       status =3D "okay";
> +       extcon =3D <&typec_ptn5100>;
> +       dr_mode =3D "otg";
> +};
> +
> +&usb3_phy1 {
> +       status =3D "okay";
> +};
> +
> +&usb3_1 {
> +       status =3D "okay";
> +};
> +
> +&usb_dwc3_1 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
> +
> +&sai2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_sai2>;
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_SAI2_SRC>,
> +                       <&clk IMX8MQ_CLK_SAI2_DIV>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <0>, <24576000>;
> +       status =3D "okay";
> +};
> +
> +&sai4 {
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_SAI4_SRC>,
> +                       <&clk IMX8MQ_CLK_SAI4_DIV>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <0>, <24576000>;
> +       status =3D "okay";
> +};
> +
> +&spdif1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_spdif1>;
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_SPDIF1_SRC>,
> +                       <&clk IMX8MQ_CLK_SPDIF1_DIV>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <0>, <24576000>;
> +       status =3D "okay";
> +};
> +
> +&spdif2 {
> +       assigned-clocks =3D <&clk IMX8MQ_CLK_SPDIF2_SRC>,
> +                       <&clk IMX8MQ_CLK_SPDIF2_DIV>;
> +       assigned-clock-parents =3D <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <0>, <24576000>;
> +       status =3D "okay";
> +};
> +
> +&gpu_pd {
> +       power-supply =3D <&sw1a_reg>;
> +};
> +
> +&vpu_pd {
> +       power-supply =3D <&sw1c_reg>;
> +};
> +
> +&gpu {
> +       status =3D "okay";
> +};
> +
> +&vpu {
> +       status =3D "okay";
> +};
> +
> +&wdog1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_wdog>;
> +       fsl,ext-reset-output;
> +       status =3D "okay";
> +};
> +
> +&mu {
> +       status =3D "okay";
> +};
> +
> +&rpmsg{
> +       /*
> +        * 64K for one rpmsg instance:
> +        * --0xb8000000~0xb800ffff: pingpong
> +        */
> +       vdev-nums =3D <1>;
> +       reg =3D <0x0 0xb8000000 0x0 0x10000>;
> +       status =3D "okay";
> +};
> +
> +&A53_0 {
> +       operating-points =3D <
> +               /* kHz    uV */
> +               1500000 1000000
> +               1300000 1000000
> +               1000000 900000
> +               800000  900000
> +       >;
> +       dc-supply =3D <&reg_gpio_dvfs>;
> +};
> +
> +&dcss {
> +       status =3D "okay";
> +
> +       disp-dev =3D "hdmi_disp";
> +};
> +
> +&hdmi {
> +       status =3D "okay";
> +};
> +
> +&hdmi_cec {
> +       status =3D "okay";
> +};
> +
> +&csi1_bridge {
> +       fsl,mipi-mode;
> +       fsl,two-8bit-sensor-mode;
> +       status =3D "okay";
> +
> +       port {
> +               csi1_ep: endpoint {
> +                       remote-endpoint =3D <&csi1_mipi_ep>;
> +               };
> +       };
> +};
> +
> +&csi2_bridge {
> +       fsl,mipi-mode;
> +       fsl,two-8bit-sensor-mode;
> +       status =3D "disabled";
> +
> +       port {
> +               csi2_ep: endpoint {
> +                       remote-endpoint =3D <&csi2_mipi_ep>;
> +               };
> +       };
> +};
> +
> +&mipi_csi_1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "okay";
> +       port {
> +               mipi1_sensor_ep: endpoint1 {
> +                       remote-endpoint =3D <&ov5640_mipi1_ep>;
> +                       data-lanes =3D <1 2>;
> +               };
> +
> +               csi1_mipi_ep: endpoint2 {
> +                       remote-endpoint =3D <&csi1_ep>;
> +               };
> +       };
> +};
> +
> +&mipi_csi_2 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "disabled";
> +       port {
> +               mipi2_sensor_ep: endpoint1 {
> +                       remote-endpoint =3D <&ov5640_mipi2_ep>;
> +                       data-lanes =3D <1 2>;
> +               };
> +
> +               csi2_mipi_ep: endpoint2 {
> +                       remote-endpoint =3D <&csi2_ep>;
> +               };
> +       };
> +};
> --
> 2.11.0
>
