Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC7FC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960A920722
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUnWCa8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKROQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:16:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40653 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfKROQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:16:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id p59so13644628edp.7;
        Mon, 18 Nov 2019 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dCmxAbOnh1DEwR9gqcYuPuyebviFJypxHrWw58u6XUI=;
        b=tUnWCa8xtKMg67o8vDVr3JBTyIdT1MYo0i+TdImZ3F4m4SAcyqlZhXpdRqANsodH+w
         nNhZ0Yqlgol/6mI1EQvIussnwfghlilJVKLug4q5NzRRlOGVhEHH2fjGQMoO94UbnXDf
         X4Y/eGO3g6ub3lRA2seNqdPSaBwaosPz10IWoOQLbe39ikRvS/YDyMhU1SfZ0lAaVLg7
         EYbOoPMERUtAW/yy0CHVkPA+icNFkXFLWZ3up4LinBEp9WJKWHb1ZTD0pbea1qdpB78z
         xNMTvZFtZmcaMuH+pk1F+sDdmGZv0pXUk/nbpZDCkl0O0ZbZBHnj9r/YEnE2tUWkOqT7
         Br0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dCmxAbOnh1DEwR9gqcYuPuyebviFJypxHrWw58u6XUI=;
        b=eLtyxknu0oh7AdAW5xJqaTLOgShJEjWuueox/201OLP59yjmyeoVB8Q6PDP7qePv+1
         r92ncC+BFsCqNHOtaYgMbHk+A5VvDtsDmgbv35rUL1jEC3nQgB004VlS1u4nyDjJUOuz
         0bmJEozUUReqx2CdiS6SLkNyHIRnMQlFbyPJGYNDHZnnSQ8AU7KSb6aAsFrSVq7VkKr9
         kS3L8plgCFjKzXqC1l2vnO0Qhq1erhWK7Bekb3oRzDeXFXWyUaYxIxGH60EiagEFTEWu
         s6Rp7Z4eVrcENuFYkFHdDazFJyD8Zf7Zdozsvws2LIPdTocq+8skhdtGNUbYjcaZdE+i
         QUFQ==
X-Gm-Message-State: APjAAAUANtynK2Q7Qfojb1ZSx8WMTssl+AEpE5b2gqmsHz88t/VsK3u9
        Q6rt8gwxYI7XtsKi/x5YHmL9kl67BpsFnSoqr/U=
X-Google-Smtp-Source: APXvYqzvN57cgmr0vzC+8Wg7xerpuW5clGmE/FuIbFlcie09sQ425t8bFW80Y6SiYxim2k0dkPlO9A7L3Eb5WSYQ124=
X-Received: by 2002:a17:906:1fd5:: with SMTP id e21mr26117015ejt.320.1574086591558;
 Mon, 18 Nov 2019 06:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20191114195609.30222-1-marco.franchi@nxp.com> <CAOMZO5Asp-m7zyY6dp72_VKZs0OisxX4B-PJtP4=GuE_-XDBsg@mail.gmail.com>
In-Reply-To: <CAOMZO5Asp-m7zyY6dp72_VKZs0OisxX4B-PJtP4=GuE_-XDBsg@mail.gmail.com>
From:   Marco Franchi <marcofrk@gmail.com>
Date:   Mon, 18 Nov 2019 12:16:30 -0200
Message-ID: <CAM4PwSX+tkCwt2vmBB4-WAdfaTbxUEutGjzKxCVQiAnWbtD3JA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Antonio Franchi <marco.franchi@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Thank you for your comments. I have some points to discuss inline:

Em qui., 14 de nov. de 2019 =C3=A0s 18:13, Fabio Estevam
<festevam@gmail.com> escreveu:
>
> Hi Marco,
>
> On Thu, Nov 14, 2019 at 4:56 PM Marco Antonio Franchi
> <marco.franchi@nxp.com> wrote:
> >
> > This patch adds the device tree to support Google Coral Edge TPU,
> > historicaly named as fsl-imx8mq-phanbell, a computer on module
> > which can be used for AI/ML propose.
> >
> > It introduces a minimal enablement support for this module and
>
> What are the features that have been tested?
I can include one list at the v2.
>
> Also, is the schematics available?
Yes: https://storage.googleapis.com/site_and_emails_static_assets/Files/Cor=
al-Dev-Board-baseboard-schematic.pdf
>
> > was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell
> > Google Source Code for Coral Edge TPU Mendel release:
> > https://coral.googlesource.com/linux-imx/
> >
> > This patch was tested using the U-Boot 2017-03-1-release-chef,
> > which is supported by the Coral Edge TPU Mendel release:
> > https://coral.googlesource.com/uboot-imx/
>
> I would suggest removing this paragraph from the commit log as it is
> not relevant to the dts itself.
This U-Boot is the unique available for the Coral Edge TPU, and it
does not provides the fdt_file settup, so I cannot change the Device
Tree name and I thought it was important to put this information
somehow here.
>
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 38e344a2f0ff..cc7e02a30ed1 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dt=
b
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> >
> > +dtb-$(CONFIG_ARCH_MXC) +=3D fsl-imx8mq-phanbell.dtb
>
> Please remove the fsl prefix and call it mx8mq-phanbell.dtb instead to
> align with the other imx8mq dtbs.
If I applied this change, I won't be able to boot the board, due to
the U-Boot dependence.
Should I try to apply the U-Boot mainline support first?
>
> > +&i2c1 {
> > +       clock-frequency =3D <400000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c1>;
> > +       status =3D "okay";
> > +
> > +       pmic: pmic@4b {
> > +               reg =3D <0x4b>;
> > +               compatible =3D "rohm,bd71837";
> > +               pinctrl-0 =3D <&pinctrl_pmic>;
> > +               gpio_intr =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
>
> This property does not exist upstream.
>
> You should describe the interrupt like this instead:
>
> interrupt-parent =3D <&gpio1>;
> interrupts =3D <3 GPIO_ACTIVE_LOW>;
>
Sure, I will!
> > +
> > +               gpo {
> > +                       rohm,drv =3D <0x0C>;
>
> This property does not exist upstream.
>
> > +&sai2 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_sai2>;
> > +       assigned-clocks =3D
> > +               <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>=
;
>
> Please don't split the lines as it gets harder to read.
>
> > +       assigned-clock-parents =3D
> > +               <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
>
> Same here.
>
> > +       assigned-clock-rates =3D <0>, <24576000>;
> > +       status =3D "okay";
> > +};
> > +
> > +&wdog1 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_wdog>;
> > +       fsl,ext-reset-output;
> > +       status =3D "okay";
> > +};
> > +
> > +&iomuxc {
> > +       pinctrl-names =3D "default";
> > +
> > +       imx8mq-evk {
>
> No need for this imx8mq-evk container.
>
> > +               pinctrl_pmic: pmicirq {
> > +                       fsl,pins =3D <
> > +                               MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3      =
 0x41 /*0x17059*/
>
> This comment looks confusing. I would suggest removing it.
>
> Regards,
>
> Fabio Estevam

Ok for all the other comments.

Thanks for your suggestion Fabio.
Please, just check the comments regarding the Device Tree name and I
will send the v2 with the required changes.

BR,
Marco
