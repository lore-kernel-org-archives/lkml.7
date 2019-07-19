Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7549C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B7E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiZEvxEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGSKUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:20:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40114 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:20:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so2549961oie.7;
        Fri, 19 Jul 2019 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1PmZpw92veA1eto1LTZBUzfAFcyq0DgVKOAfp0MiE4=;
        b=oiZEvxEPRshTOj8YoPaI8n0z8YGmSea439I4TBwmEPewhKtHo9ue3GqOTnaFdhKXsk
         3G2GokHfW3XA1fgwPihs4HIV0y4zacKxwot/IH/dWrZtLMb7RPdGIsGZ3PGPJ0vWEvwd
         0YS0RR7hbDgXwVqTsBMIvGKoen3Xbe5/Av+4RzFi9UwEtaI7cVjjjB0w+UqkWZbjci+9
         0r/G9+uuIJ0RJluU6e5UvN+MrgDECIvrmY4jQO39rFe2t69f1nV0LhkTlNwNPCVf7CnI
         48JcLqLSypP2U5al99kFU2FTuI+cJgdYFm/YQuXbrzRME0Js7U8h0Mla1qNBhAf7mKJn
         E0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1PmZpw92veA1eto1LTZBUzfAFcyq0DgVKOAfp0MiE4=;
        b=G21rC7h6a3ExECfoQctBrvbkBdvN6KDn/Xgs7qZXwlvizMTrjSUqhgx6NDHfwOTznj
         HUTv8uHrl1Akfw8l7CKqCxgZpXB0iDx4lBHTcHnTvxbxxSl626gSkLcnst/Gm7FP2Wlo
         V5/JuZRIxkbg2zUfcn0wW9NTWrXLU/+29BIjpaguO40xM5gac33mt8AFaJPnsAXOgJa9
         BSIpOdeqrocCiq438D5S9snQZqLqgaJx7oI9Tr5ViZPwLPlyMH/zQqbd1KhrOOUnZ1hM
         W0E2inUkupsdTz1ZAGt//wNbOsOO2df+G5AzTtRG8ROI2rSzi6pPSXe7MovutYBfTa/X
         Bt+Q==
X-Gm-Message-State: APjAAAVvvJYHPQxlYHfTJEMNVukp81bSw9vBvlXiDFbA+5oa36hMthAq
        7s5eX0iHMdo0SaRdFMqqc/kxd+GWblJ4FM0vKCQ=
X-Google-Smtp-Source: APXvYqzBAufPNh0LrT5elMfGn1t8/NkuW5Z43HoQwl2eH229QNfm5i5dp/CS/2mTz1UuuJDjR05tq8mPcvBU6W1B5bc=
X-Received: by 2002:aca:90c:: with SMTP id 12mr24747271oij.91.1563531650797;
 Fri, 19 Jul 2019 03:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190718121628.23991-1-andradanciu1997@gmail.com>
 <20190718121628.23991-2-andradanciu1997@gmail.com> <CAOMZO5B-9+JnbfrTWP8GTuc0VcnDDPEZq-iXGbYVx9a6O9gwRg@mail.gmail.com>
In-Reply-To: <CAOMZO5B-9+JnbfrTWP8GTuc0VcnDDPEZq-iXGbYVx9a6O9gwRg@mail.gmail.com>
From:   Andra Danciu <andradanciu1997@gmail.com>
Date:   Fri, 19 Jul 2019 13:20:40 +0300
Message-ID: <CAJNLGsxvTmoBjfj82i3Fc5v7WUiw7XYtXg8nQNHZ_xdtuB711Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, sriram.dash@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>, pankaj.bansal@nxp.com,
        Ping Bai <ping.bai@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Richard Hu <richard.hu@technexion.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Please find my answers inline:

=C3=8En vin., 19 iul. 2019 la 02:05, Fabio Estevam <festevam@gmail.com> a s=
cris:
>
> Hi Andra,
>
> On Thu, Jul 18, 2019 at 9:16 AM Andra Danciu <andradanciu1997@gmail.com> =
wrote:
> >
> > From: Richard Hu <richard.hu@technexion.com>
>
> Please put a few words about the board and a link to its webpage, if avai=
lable.
OK
>
> > The current level of support yields a working console and is able to bo=
ot
> > userspace from NFS or init ramdisk.
> >
> > Additional subsystems that are active :
> >         - Ethernet
> >         - USB
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Richard Hu <richard.hu@technexion.com>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile       |   1 +
> >  arch/arm64/boot/dts/freescale/pico-pi-8m.dts | 417 +++++++++++++++++++=
++++++++
> >  2 files changed, 418 insertions(+)
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
>
> The convention we use with imx dtbs is to put the SoC name first, so
> that would become:
>
> imx8mq-pico-pi.dtb
Will do.
>
>
> > +&iomuxc {
>
> Please place iomuxc node as the last one.
Will do.
>
> > +&fec1 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_fec1 &pinctrl_enet_3v3>;
> > +       phy-mode =3D "rgmii-id";
> > +       pinctrl-assert-gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;
>
> This property does not exist.
OK, I will remove it.
>
> > +       phy-handle =3D <&ethphy0>;
> > +       fsl,magic-packet;
> > +       status =3D "okay";
> > +
> > +       mdio {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +
> > +               ethphy0: ethernet-phy@1 {
> > +                       compatible =3D "ethernet-phy-ieee802.3-c22";
> > +                       reg =3D <1>;
> > +                       at803x,led-act-blind-workaround;
> > +                       at803x,eee-disabled;
>
> These two properties do not exist.
OK, I will remove them.
>
> > +&i2c1 {
> > +       clock-frequency =3D <100000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c1>;
> > +       status =3D "okay";
> > +
> > +       pmic: pmic@4b {
> > +               reg =3D <0x4b>;
> > +               compatible =3D "rohm,bd71837";
> > +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > +               pinctrl-0 =3D <&pinctrl_pmic>;
>
> pinctrl-names =3D "default" is missing
OK, will add.
>
> > +               gpio_intr =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
>
> This is not documented.
>
> Please look at Documentation/devicetree/bindings/regulator/rohm,bd71837-r=
egulator.txt
> for the valid bindings and also at
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts for a
> reference for adding the BD71837 support.
OK, will do.
>
> > +&A53_0 {
> > +       operating-points =3D <
> > +               /* kHz    uV */
> > +               1500000 1000000
> > +               1300000 1000000
> > +               1000000 900000
> > +               800000  900000
>
> This is not needed as these operating points are already specified at
> imx8mq.dtsi.
OK, I will remove it.
