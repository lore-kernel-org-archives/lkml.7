Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C4C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682CD20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amyUUztS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfGRLMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:12:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33675 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGRLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:12:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so28543178otl.0;
        Thu, 18 Jul 2019 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jSBAN5ChqVqtw/44g2ZGmGPhZ2FzCbRolbvPZMe9/3E=;
        b=amyUUztSyYoc0UvoZVndW14gGHPwZGhTS9S9oVOA4dL19PxsgtEytPz8MhrxMAFi2A
         H2e/kqpfhyyOL6zgykQkbAwy2P6sVgpUA6tzO+f/HvcS0VcdJcDSiyEGyT0wmq+uM1uY
         swMr+48C7Fa7uB2244BjSmr69CZxAkI5vB3qZJdKXFyWDiqW9wzSo4kuAv2IQXZALigJ
         wThwQs1DfpMZZtgaX5FGk5CsOgixjkaRnJcpAlqlLmmyjfqv2KNvbkZM9TpXS2M9X3So
         nt91Agnypun6i/Uu9pfGgTpVXY5iEYMvCFzmpXlEsteiNEQJH912LCm6WDW4yli9GWoO
         Xp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jSBAN5ChqVqtw/44g2ZGmGPhZ2FzCbRolbvPZMe9/3E=;
        b=T/WbSP1kF3JD6TMkvLDAJKF2SsLqj4BtVRvRIcv285m1+jrgoRqyXFYeNw0J47n9CF
         q5UYPuXrnKSHVneYpyuPR/JC1x+eKh/XMrgbNIWFI8Lwtwvw1G/yIMuIo4o7yY/K5q7D
         K0fjk1mJexgTGmakCC0L2UoceKf8Vr4v3OS0qa+QkBnhihC7/zvLHmuu71q7dOqmQBSL
         zgjSBskdYxzkKQtnf33PdNqTSeQILLowW4wWvpkw3GaZgPRO7g7onYgBs1jGiB5tqtET
         I6vvLtiHTdMbiklACbYOQEbGP1Gn/cT9m6Pawvm4YXJz8WBSm4CH+MFTHKzx0BtnU0+w
         C8TQ==
X-Gm-Message-State: APjAAAU2i4S0xHmgBY42QhIGGRgxB9czVpR6ouo2p1J3ttUG5VC+K226
        OGnoxulRW+IrXcxfhNI4m9qwIcdgP1Z4zYp898o=
X-Google-Smtp-Source: APXvYqx/bz7PCzEI1NYi75MYPE5IKK92qFubbxI311wpZSmzdmwyFScZikZww/OYIpReeSvo//K6EuoaHfctd9TIm/g=
X-Received: by 2002:a05:6830:16:: with SMTP id c22mr34288852otp.116.1563448342264;
 Thu, 18 Jul 2019 04:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190625123407.15888-1-andradanciu1997@gmail.com> <20190718035523.GD11324@X250>
In-Reply-To: <20190718035523.GD11324@X250>
From:   Andra Danciu <andradanciu1997@gmail.com>
Date:   Thu, 18 Jul 2019 14:12:10 +0300
Message-ID: <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        Fabio Estevam <festevam@gmail.com>, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, angus@akkea.ca, vabhav.sharma@nxp.com,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Hu <richard.hu@technexion.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Please find my answers inline:

=C3=8En joi, 18 iul. 2019 la 06:55, Shawn Guo <shawnguo@kernel.org> a scris=
:
>
> On Tue, Jun 25, 2019 at 03:34:07PM +0300, Andra Danciu wrote:
> > From: Richard Hu <richard.hu@technexion.com>
> >
> > The current level of support yields a working console and is able to bo=
ot
> > userspace from an initial ramdisk copied via u-boot in RAM.
> >
> > Additional subsystems that are active :
> >       - Ethernet
> >       - USB
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Richard Hu <richard.hu@technexion.com>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> > Changes since v1:
> >  - renamed wandboard-pi-8m.dts to pico-pi-8m.dts
> >  - removed pinctrl_csi1, pinctrl_wifi_ctrl
> >  - used generic name for pmic
> >  - removed gpo node
> >  - delete regulator-virtuals node
> >  - remove always-on property from buck1-8 and ldo3-7
> >  - remove pmic-buck-uses-i2c-dvs property for buck1-4
> >
> >  arch/arm64/boot/dts/freescale/Makefile       |   1 +
> >  arch/arm64/boot/dts/freescale/pico-pi-8m.dts | 458 +++++++++++++++++++=
++++++++
> >  2 files changed, 459 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/pico-pi-8m.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index c043aca66572..538422903e8a 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -26,3 +26,4 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-rmb3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-zest.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D pico-pi-8m.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/pico-pi-8m.dts b/arch/arm64/=
boot/dts/freescale/pico-pi-8m.dts
> > new file mode 100644
> > index 000000000000..23422c8fc43f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/pico-pi-8m.dts
> > @@ -0,0 +1,458 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 Wandboard, Org.
> > + * Copyright 2017 NXP
> > + *
> > + * Author: Richard Hu <hakahu@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mq.dtsi"
> > +
> > +/ {
> > +     model =3D "PICO-PI-8M";
> > +     compatible =3D "wand,imx8mq-pico-pi", "fsl,imx8mq";
>
> The board compatible needs to be documented.
OK. Will fix. We will use technexion,pico-pi-imx8m. Wand is not even a
documented vendor!
I do not know why there are even compatibles like this: wand,imx6q-wandboar=
d.
>
> > +
> > +     chosen {
> > +             bootargs =3D "console=3Dttymxc0,115200 earlycon=3Dec_imx6=
q,0x30860000,115200";
>
> The earlycon is only needed for debugging early hang issue.  Do you
> really want it by default?  If no, we can save the 'bootargs' here,
> since 'stdout-path' below will get you correct console setup.
OK. Will fix.
>
> > +             stdout-path =3D &uart1;
> > +     };
> > +
> > +     regulators {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
>
> Drop this container node and put fixed regulator directly under root
> node.
OK.
>
> > +
> > +             reg_usb_otg_vbus: usb_otg_vbus {
>
> Please use node name like 'regulator-xxx'.
OK.
>
> > +                     pinctrl-names =3D "default";
> > +                     pinctrl-0 =3D <&pinctrl_otg_vbus>;
> > +                     compatible =3D "regulator-fixed";
> > +                     regulator-name =3D "usb_otg_vbus";
> > +                     regulator-min-microvolt =3D <5000000>;
> > +                     regulator-max-microvolt =3D <5000000>;
> > +                     gpio =3D <&gpio3 14 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl-names =3D "default";
>
> The 'pinctrl-names' is pointless if there is no 'pinctrl' property.
OK.
>
> > +
> > +     wand-pi-8m {
>
> Drop this container node.
OK.
>
> > +             pinctrl_otg_vbus: otgvbusgrp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14         =
       0x19   /* USB OTG VBUS Enable */
> > +                     >;
> > +             };
> > +
> > +             pinctrl_enet_3v3: enet3v3grp {
>
> Sort these pinctrl nodes alphabetically.
OK.
>
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0        =
       0x19
> > +                     >;
> > +             };
> > +
> > +             pinctrl_fec1: fec1grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC         0=
x3
> > +                             MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO       0=
x23
> > +                             MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3   0=
x1f
> > +                             MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2   0=
x1f
> > +                             MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1   0=
x1f
> > +                             MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0   0=
x1f
> > +                             MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3   0=
x91
> > +                             MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2   0=
x91
> > +                             MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1   0=
x91
> > +                             MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0   0=
x91
> > +                             MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC   0=
x1f
> > +                             MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC   0=
x91
> > +                             MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_C=
TL     0x91
> > +                             MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_C=
TL     0x1f
> > +                             MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9       0=
x19
> > +                     >;
> > +             };
> > +
> > +             pinctrl_i2c1: i2c1grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL           =
       0x4000007f
> > +                             MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA           =
       0x4000007f
> > +                     >;
> > +             };
> > +
> > +             pinctrl_i2c2: i2c2grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL           =
       0x4000007f
> > +                             MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA           =
       0x4000007f
> > +                     >;
> > +             };
> > +
> > +             pinctrl_uart1: uart1grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX      =
       0x49
> > +                             MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX      =
       0x49
> > +                     >;
> > +             };
> > +
> > +             pinctrl_uart2: uart2grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX      =
       0x49
> > +                             MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX      =
       0x49
> > +                             MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B   =
       0x49
> > +                             MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B   =
       0x49
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc1: usdhc1grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x83
> > +                             MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x83
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x85
> > +                             MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x85
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK          =
       0x87
> > +                             MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD          =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE    =
       0x87
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc2_gpio: usdhc2grpgpio {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12        0=
x41
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc2: usdhc2grp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x83
> > +                             MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc3
> > +                             MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc3
> > +                             MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc3
> > +                             MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x85
> > +                             MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc5
> > +                             MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc5
> > +                             MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc5
> > +                             MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> > +                     >;
> > +             };
> > +
> > +             pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK          =
       0x87
> > +                             MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD          =
       0xc7
> > +                             MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2      =
       0xc7
> > +                             MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3      =
       0xc7
> > +                             MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT   =
       0xc1
> > +                     >;
> > +             };
> > +
> > +             pinctrl_wdog: wdoggrp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
> > +                     >;
> > +             };
> > +
> > +             pinctrl_pmic: pmicirq {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3       0=
x41
> > +                     >;
> > +             };
> > +
> > +             pinctrl_tusb320_irq: tusb320_irqgrp {
>
> Please name the pinctrl node in a more consistent way, i.e. no
> underscore.
OK.
>
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_NAND_DATA00_GPIO3_IO6      0=
x41
> > +                     >;
> > +             };
> > +
> > +             pinctrl_typec_ss_sel: typec_ss_selgrp {
> > +                     fsl,pins =3D <
> > +                             MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5         0=
x19
> > +                     >;
> > +             };
> > +     };
> > +};
> > +
> > +&fec1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_fec1 &pinctrl_enet_3v3>;
> > +     phy-mode =3D "rgmii-id";
> > +     pinctrl-assert-gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;
> > +     phy-handle =3D <&ethphy0>;
> > +     fsl,magic-packet;
> > +     status =3D "okay";
> > +
> > +     mdio {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             ethphy0: ethernet-phy@1 {
> > +                     compatible =3D "ethernet-phy-ieee802.3-c22";
> > +                     reg =3D <1>;
> > +                     at803x,led-act-blind-workaround;
> > +                     at803x,eee-disabled;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     clock-frequency =3D <100000>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_i2c1>;
> > +     status =3D "okay";
> > +
> > +     typec_tusb320:tusb320@47 {
> > +             compatible =3D "ti,tusb320";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_tusb320_irq &pinctrl_typec_ss_sel=
>;
> > +             reg =3D <0x47>;
> > +             vbus-supply =3D <&reg_usb_otg_vbus>;
> > +             ss-sel-gpios =3D <&gpio3 5 GPIO_ACTIVE_HIGH>;
> > +             tusb320,int-gpio =3D <&gpio3 6 GPIO_ACTIVE_LOW>;
> > +             tusb320,select-mode =3D <0>;
> > +             tusb320,dfp-power =3D <0>;
> > +     };
>
> Where is the bindings doc for this device?
Indeed, this is from an internal tree, we will drop the node.
>
> > +
> > +     pmic: pmic@4b {
> > +             reg =3D <0x4b>;
> > +             compatible =3D "rohm,bd71837";
> > +             /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > +             pinctrl-0 =3D <&pinctrl_pmic>;
> > +             gpio_intr =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
>
> Where is the bindings for this property?
Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
>
> > +
> > +             regulators {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     buck1: BUCK1 {
> > +                             regulator-name =3D "buck1";
> > +                             regulator-min-microvolt =3D <700000>;
> > +                             regulator-max-microvolt =3D <1300000>;
> > +                             regulator-boot-on;
> > +                             regulator-ramp-delay =3D <1250>;
> > +                             rohm,dvs-run-voltage =3D <900000>;
> > +                             rohm,dvs-idle-voltage =3D <850000>;
> > +                             rohm,dvs-suspend-voltage =3D <800000>;
> > +                     };
> > +
> > +                     buck2: BUCK2 {
> > +                             regulator-name =3D "buck2";
> > +                             regulator-min-microvolt =3D <700000>;
> > +                             regulator-max-microvolt =3D <1300000>;
> > +                             regulator-boot-on;
> > +                             regulator-ramp-delay =3D <1250>;
> > +                             rohm,dvs-run-voltage =3D <1000000>;
> > +                             rohm,dvs-idle-voltage =3D <900000>;
> > +                     };
> > +
> > +                     buck3: BUCK3 {
> > +                             regulator-name =3D "buck3";
> > +                             regulator-min-microvolt =3D <700000>;
> > +                             regulator-max-microvolt =3D <1300000>;
> > +                             regulator-boot-on;
> > +                             rohm,dvs-run-voltage =3D <1000000>;
> > +                     };
> > +
> > +                     buck4: BUCK4 {
> > +                             regulator-name =3D "buck4";
> > +                             regulator-min-microvolt =3D <700000>;
> > +                             regulator-max-microvolt =3D <1300000>;
> > +                             regulator-boot-on;
> > +                             rohm,dvs-run-voltage =3D <1000000>;
> > +                     };
> > +
> > +                     buck5: BUCK5 {
> > +                             regulator-name =3D "buck5";
> > +                             regulator-min-microvolt =3D <700000>;
> > +                             regulator-max-microvolt =3D <1350000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     buck6: BUCK6 {
> > +                             regulator-name =3D "buck6";
> > +                             regulator-min-microvolt =3D <3000000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     buck7: BUCK7 {
> > +                             regulator-name =3D "buck7";
> > +                             regulator-min-microvolt =3D <1605000>;
> > +                             regulator-max-microvolt =3D <1995000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     buck8: BUCK8 {
> > +                             regulator-name =3D "buck8";
> > +                             regulator-min-microvolt =3D <800000>;
> > +                             regulator-max-microvolt =3D <1400000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     ldo1: LDO1 {
> > +                             regulator-name =3D "ldo1";
> > +                             regulator-min-microvolt =3D <3000000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo2: LDO2 {
> > +                             regulator-name =3D "ldo2";
> > +                             regulator-min-microvolt =3D <900000>;
> > +                             regulator-max-microvolt =3D <900000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     ldo3: LDO3 {
> > +                             regulator-name =3D "ldo3";
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     ldo4: LDO4 {
> > +                             regulator-name =3D "ldo4";
> > +                             regulator-min-microvolt =3D <900000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     ldo5: LDO5 {
> > +                             regulator-name =3D "ldo5";
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     ldo6: LDO6 {
> > +                             regulator-name =3D "ldo6";
> > +                             regulator-min-microvolt =3D <900000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                     };
> > +
> > +                     ldo7: LDO7 {
> > +                             regulator-name =3D "ldo7";
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&i2c2 {
> > +     clock-frequency =3D <100000>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_i2c2>;
> > +     status =3D "okay";
> > +};
> > +
> > +&uart1 { /* console */
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart1>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usdhc1 {
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc1>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
> > +     bus-width =3D <8>;
> > +     non-removable;
> > +     status =3D "okay";
> > +};
> > +
> > +&usdhc2 {
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> > +     bus-width =3D <4>;
> > +     cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_phy0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_dwc3_0 {
> > +     extcon =3D <&typec_tusb320>;
> > +     dr_mode =3D "otg";
> > +     status =3D "okay";
> > +};
> > +
> > +&usb3_phy1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&usb_dwc3_1 {
> > +     status =3D "okay";
> > +     dr_mode =3D "host";
>
> We prefer to end the property list with 'status', so please flip the
> order here.
OK.
