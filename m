Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4111C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AAC21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2dIQj0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfLEDPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:15:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37037 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLEDPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:15:50 -0500
Received: by mail-io1-f68.google.com with SMTP id k24so2063098ioc.4;
        Wed, 04 Dec 2019 19:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rq2BJZhNOEuuzLU02HzB8M493P6N6+V/gQh4jwiaHE=;
        b=S2dIQj0nTQmFcq11dgqMrtTbRUHNAKCUlMCO2MQqgkoVFwVNFY/QBMyJSqrSWZfV2u
         G077FZCLInZjM66KsukFRg/28j+rwyun2iVf0r4kCs3v25HFQd1RltmyhH2xPTWcVyQz
         mOKySLfyhid4ptvSoVQcjqrFjnSXeUJPK5w5gXkRX5jb44WM/dMIipHQdJoHVj0cnE38
         XIfced7OHX1Vkb6XIB+csC4FbOWIvFscxCJzjkNSZPFOYei8pan38xHEMNHylUGkO8ny
         r9aMDdeFqjSLaxoZbk4EOcQDuYMOkHc85ZWuvrnfQVIWPJqmzl2aHBcBRD+q9fval8HH
         RieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rq2BJZhNOEuuzLU02HzB8M493P6N6+V/gQh4jwiaHE=;
        b=tM6EjnpiAdh5ygLFtuABCSWndHi71Up9HQ9LkgSNrKN2ab1Ag4HqBxnwuTfdac0bp0
         saCG0eZohpMmlpAB3EKldS8J8BbmPbRxfQn1bWW0NMdTJ+nKRYaSOF7fbjQGvmFpGWa5
         EEHP3GMI3UBOkWlK72kdVjxtNrk747KxA7T6vpvpvOuYg4xrbnKjrI5js5zRc9sgP2u5
         OWssY7/hFDgNdKdIHuAwI470IsJEIEzAUHxuvfOVPT8K5lcswEE8GGXzgYMB0Me401Lr
         PfBmIthRZkYdLAdlK40SjTX6h/g0f77md/sxzLpYXd0umT0WUKvHMIOrbHrDWF+x0Zf3
         T4qg==
X-Gm-Message-State: APjAAAXBeWgUJBN1NAnYLaC1RpHl/+yqZbLw+owY0S0p8l/XGvwSSh8o
        SQ+TZC6mZ2XuBUbrXnNRVxdn+BTZSz4WEkcFRbY=
X-Google-Smtp-Source: APXvYqzA6x95/jEC5NspnWmfwG71rVSkxJrtiBiE16XWfNxWiXgjBk5LXMFVrb7iQ7I9+KP4K/03ei+gMG3m6W4sNqw=
X-Received: by 2002:a6b:7316:: with SMTP id e22mr4838252ioh.205.1575515748972;
 Wed, 04 Dec 2019 19:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20191205021924.25188-1-aford173@gmail.com> <20191205021924.25188-6-aford173@gmail.com>
 <DB7PR04MB517877B39D4659568F69B813875C0@DB7PR04MB5178.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB517877B39D4659568F69B813875C0@DB7PR04MB5178.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 4 Dec 2019 21:15:37 -0600
Message-ID: <CAHCN7xLwJvqb=Pc8oOxdRLOExjw-cDKaEmm4-bR3Yt=t+OwY6Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: imx8mm: add GPC power domains
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 8:37 PM Jacky Bai <ping.bai@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Thursday, December 5, 2019 10:19 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Adam Ford <aford173@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> > Mark Rutland <mark.rutland@arm.com>; Shawn Guo
> > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 5/7] arm64: dts: imx8mm: add GPC power domains
> >
> > There is a power domain controller on the i.XM8M Mini used for handling
> > interrupts and controlling certain peripherals like USB OTG and PCIe, which
> > are currently unavailable.
> >
> > This patch enables support the controller itself to the help facilitate enabling
> > additional peripherals.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 82
> > ++++++++++++++++++++++-
> >  1 file changed, 81 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index 23c8fad7932b..d05c5b617a4d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <dt-bindings/clock/imx8mm-clock.h>
> > +#include <dt-bindings/power/imx8m-power.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -13,7 +14,7 @@
> >
> >  / {
> >       compatible = "fsl,imx8mm";
> > -     interrupt-parent = <&gic>;
> > +     interrupt-parent = <&gpc>;
>
> NACK, for imx8mm, imx8mn & future i.MX8M SOC, we don't treat GPC as interrupt controller in linux anymore.
> Above change will break the low power mode support(suspend/resume)

What makes it different than the i.MX8MQ?  The I basically copied this
from the i.MX8MQ and updated the bit locations and tried to leave
everything else the same.

I'm OK with removing the interrupt controller stuff, but if that's
required, I'd like to understand why it's still in the i.MX8Q.

adam
>
> BR
> Jacky Bai
>
> >       #address-cells = <2>;
> >       #size-cells = <2>;
> >
> > @@ -495,6 +496,85 @@
> >                               interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> >                               #reset-cells = <1>;
> >                       };
> > +
> > +                     gpc: gpc@303a0000 {
> > +                             compatible = "fsl,imx8mm-gpc";
> > +                             reg = <0x303a0000 0x10000>;
> > +                             interrupt-parent = <&gic>;
> > +                             interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> > +                             interrupt-controller;
> > +                             #interrupt-cells = <3>;
> > +
> > +                             pgc {
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +
> > +                                     pgc_mipi: power-domain@0 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_MIPI>;
> > +                                     };
> > +
> > +                                     pgc_pcie: power-domain@1 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_PCIE>;
> > +                                     };
> > +
> > +                                     pgc_otg1: power-domain@2 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg =
> > <IMX8MM_POWER_DOMAIN_USB_OTG1>;
> > +                                     };
> > +
> > +                                     pgc_otg2: power-domain@3 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg =
> > <IMX8MM_POWER_DOMAIN_USB_OTG2>;
> > +                                     };
> > +
> > +                                     pgc_ddr1: power-domain@4 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_DDR1>;
> > +                                     };
> > +
> > +                                     pgc_gpu2d: power-domain@5 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_GPU2D>;
> > +                                     };
> > +
> > +                                     pgc_gpu: power-domain@6 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_GPU>;
> > +                                     };
> > +
> > +                                     pgc_vpu: power-domain@7 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_VPU>;
> > +                                     };
> > +
> > +                                     pgc_gpu3d: power-domain@8 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_GPU3D>;
> > +                                     };
> > +
> > +                                     pgc_disp: power-domain@9 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_DOMAIN_DISP>;
> > +                                     };
> > +
> > +                                     pgc_vpu_g1: power-domain@a {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_VPU_G1>;
> > +                                     };
> > +
> > +                                     pgc_vpu_g2: power-domain@b {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_VPU_G2>;
> > +                                     };
> > +
> > +                                     pgc_vpu_h1: power-domain@c {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MM_POWER_VPU_H1>;
> > +                                     };
> > +                             };
> > +                     };
> >               };
> >
> >               aips2: bus@30400000 {
> > --
> > 2.20.1
>
