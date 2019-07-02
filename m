Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343DC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5162054F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/XwH55N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGBMkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:40:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGBMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:40:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so6440606wro.5;
        Tue, 02 Jul 2019 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWX5YYP1CNCT9e/dIGU0i3ZnwA5tEC0AyVRX+7SK6lw=;
        b=b/XwH55NMOZSeol8hUdl7s8+9MNvt25FwAvIKkjn8gLsUeAd8wx8U4In9vAjQGNQ66
         xYdpJP0am9FkBYaK54YKsNF01TFgWk2QfTmy5tHtf5nkg3MuXYQpV/8XCXNcHQFTy0Qm
         kMTJoAKR3BZmkJgsesFPmjKdASQG2RzkFRvw0Eo7QQ9hbk+jeXm28flyeoXL0idx9d4g
         Dwcpf2R+vKAYLFmmprGBnLTCsMflKJ4FSdgxmFCUjhMSTYG5E0Z/oicFe/U5L4gtkf3A
         yv7CpnzFlTy+sYMa0C/XUIxZqtiTmKVglM3VdtHNpkctEOku/xGln9sSUikdUov+mcwA
         kxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWX5YYP1CNCT9e/dIGU0i3ZnwA5tEC0AyVRX+7SK6lw=;
        b=MgLUDhBgdDRddmBttApajsHM1qDf62O0BSBsrn2Xv92q3z4Tm79FfTFgCtrdTK9PF/
         bU1pDFJXde0r1E5oFHkh7yrHpjhZZrubQ4xCdbCv+Gh+R7x7hAIO+R6WGMAbhFId+eht
         kUDjfjaOjkGBqpQn37N63BhBoLgXmMA2T53yCIZGCwJHNwoWE4EFlgjMiUc7slHgNIgh
         Lu2P5Zfg3z4IXd2pVcqzMrZFaSkZknbcd1ATAz8kKcSelfHQRkIQmzve79Y+wn1yNPwB
         zOdEFCTNj7SlH+SIZoVigm0JT98MUWyqJlYAgzTQIwmsdm812qkBTtnyDn6VEtcI28T7
         rrJw==
X-Gm-Message-State: APjAAAUVapyUVvxFuI2xOp5eQyb00g6Vym5NuIyrxttUED8V3u3QfsRj
        MQPVS35jDMZ6Oy0PCScSaIf/q+o3PiJJjg7ydEs=
X-Google-Smtp-Source: APXvYqwN7H5OuDdNXdoNXzu2dimkV8ct5pJbj57BHREg3taMw4HvwJusECpbPxShilr7quxy0JxRfexKoEAdrV0/3UU=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr15952442wre.93.1562071234542;
 Tue, 02 Jul 2019 05:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190702114102.1254-1-andradanciu1997@gmail.com> <20190702114542.2eoc6nm2kyhode43@fsr-ub1664-175>
In-Reply-To: <20190702114542.2eoc6nm2kyhode43@fsr-ub1664-175>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 2 Jul 2019 15:40:23 +0300
Message-ID: <CAEnQRZBtAOzuF0L1iKKTRdR_A5skbnZFb=B1io8f_pdHcnvbyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add sai6 node
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Andra Danciu <andradanciu1997@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 2:46 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 19-07-02 14:41:02, Andra Danciu wrote:
>
> Missing commit message here. Please add one.

Agree. Also, please add SAI3. As you noticed our pico pi board has
pins exposed on for SAI2/SAI3.

As for the description you can say:

SAI3/6 supports up to 2-channels TX (1 dataline) and 2-channels RX (1 dataline).

>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index d09b808eff87..1ff664523f56 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -278,6 +278,20 @@
> >                       #size-cells = <1>;
> >                       ranges = <0x30000000 0x30000000 0x400000>;
> >
> > +                     sai6: sai@30030000 {
> > +                             compatible = "fsl,imx8mq-sai",
> > +                                     "fsl,imx6sx-sai";
> > +                             reg = <0x30030000 0x10000>;
> > +                             interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
> > +                                     <&clk IMX8MQ_CLK_SAI6_ROOT>,
> > +                                     <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> > +                             clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > +                             dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
> > +                             dma-names = "rx", "tx";
> > +                             status = "disabled";
> > +                     };
> > +
> >                       gpio1: gpio@30200000 {
> >                               compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
> >                               reg = <0x30200000 0x10000>;
> > --
> > 2.11.0
> >
