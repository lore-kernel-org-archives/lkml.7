Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A5EC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE812187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG8BhAz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGCG2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:28:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51849 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGCG2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:28:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so895728wma.1;
        Tue, 02 Jul 2019 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eCCLmkLkeLDCE1a5Yy+pkPkgEz/If2djsBLUVl9QJY=;
        b=fG8BhAz8rpQYJOJXA5V8a2gJRw28DhFgY3Psa6mrsFvwZGR6CTs4wcu+duQr9PUZ1b
         1fp2XrkoaQVdrihUflkGjH61OlQWzrCfKToaVUOCr+GGgVuKvxBliXtP5U7AcmY2zQrc
         Lne4KAP8plFJyOy00k7E7hH1AKViwLCpDBkSc/LHT9W4VlPbc8C5ft6Xfw7Xyf1CuJpb
         MoW6PjhgtrCI0b6gtdMkTE4xIWeQCaGpJJxi97JxTdsXNKWuFCv+SuxKJ1OnA+5uAG45
         cC+U99NQXlHlClM71PsZWDq6NXd6SdjFTKkA1UxYG0/DF9R2psTPqwkbfoikmALWuHoI
         ohgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eCCLmkLkeLDCE1a5Yy+pkPkgEz/If2djsBLUVl9QJY=;
        b=kzv5hgemOY+474FMxAkTMfY41+ed7LdM9INrsJ0OYsiLEPqQr9SzwQ4LjtFKxwDoWz
         IkHzPdfO1G5eIbvlWR2DXR5N3oWCEWdzFcbPBjRrYgLz2JNOyQekrIt7/XQqNM0EWOvj
         j92XiWASwHBfMnevm4FynLxGgx10n0wIuoqnncxJ4HqfV/Tl4fghOHgmFRYiGDFjiZ97
         RH8GU2JUTXlKEd0oyVpDtZQkeqce6rZ0ky07MH6xx6B+igPsej4b+0Rsw9CMKOoph3sa
         Zk6Q+yT7udW0YWyiQCjIcOTqgK5PBuYPL4NWVMn+fjC67IKJxd0flktY1H8ZhecMbhVl
         qSvg==
X-Gm-Message-State: APjAAAWOocxl92EAyJFwHl/L384dUj+wpPWOsdF70yKsegox2sRdsATA
        T07edWHC442ErAqVeFR01pX6dIcNQ2mXVSgVDGE=
X-Google-Smtp-Source: APXvYqx802GCX61Rc7Neoi0DifztLFTBp2UudWaw5hHr7BOqJW/VmA8zZ/yFboZfaa3BWsIrlQi+SX8f4OGEhsRcTQg=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr5812991wmd.87.1562135288232;
 Tue, 02 Jul 2019 23:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
In-Reply-To: <20190702132353.18632-1-andradanciu1997@gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 3 Jul 2019 09:27:56 +0300
Message-ID: <CAEnQRZDO4FzsC-MZGsxd=7dxSc0dRGcMjWW-W9T2TF7C1iD9NA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, andrew.smirnov@gmail.com,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 4:25 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> SAI3 and SAI6 nodes are used to connect to an external codec.
> They have 1 Tx and 1 Rx dataline.
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
> Changes since v2:
>         - removed multiple new lines
>
> Changes since v1:
>         - Added sai3 node because we need it to enable audio on pico-pi-8m
>         - Added commit description
>
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index d09b808eff87..736cf81b695e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -278,6 +278,20 @@
>                         #size-cells = <1>;
>                         ranges = <0x30000000 0x30000000 0x400000>;
>
> +                       sai6: sai@30030000 {
> +                               compatible = "fsl,imx8mq-sai",
> +                                       "fsl,imx6sx-sai";
> +                               reg = <0x30030000 0x10000>;
> +                               interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
> +                                       <&clk IMX8MQ_CLK_SAI6_ROOT>,
> +                                       <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                               dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
> +                               dma-names = "rx", "tx";
> +                               status = "disabled";
> +                       };
> +
>                         gpio1: gpio@30200000 {
>                                 compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
>                                 reg = <0x30200000 0x10000>;
> @@ -728,6 +742,21 @@
>                                 status = "disabled";
>                         };
>
> +                       sai3: sai@308c0000 {
> +                               compatible = "fsl,imx8mq-sai",
> +                                            "fsl,imx6sx-sai";
> +                               reg = <0x308c0000 0x10000>;
> +                               interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MQ_CLK_SAI3_IPG>,
> +                                       <&clk IMX8MQ_CLK_DUMMY>,
> +                                       <&clk IMX8MQ_CLK_SAI3_ROOT>,
> +                                       <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +                               dmas = <&sdma1 12 24 0>, <&sdma1 13 24 0>;
> +                               dma-names = "rx", "tx";
> +                               status = "disabled";
> +                       };
> +
>                         i2c1: i2c@30a20000 {
>                                 compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
>                                 reg = <0x30a20000 0x10000>;
> --
> 2.11.0
>
