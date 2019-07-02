Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFABEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6C52064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHZrJP4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGBNOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:14:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:14:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so822110wmj.3;
        Tue, 02 Jul 2019 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43iWKH6jifytF6JFVgfLHPopXRcvvg3jKXLdEufvKFw=;
        b=XHZrJP4SOb5CVeG/E/xOCKM4DLp2Kmo4x9pWHCOlVjK45UA7ZmotrdUT/FpN5jf7j9
         qOpebsH/AJqMB8gFlQFEOReSsbmofA5CMNpe/82pJghUrdHdsgU2vSg+dnhowSv96oS8
         LK6v9QXiVAu355xmxFUEj+jfHAP4wWxWJCas00Ga3VcrhyZyZHw6khXDvKWNBU5CXjQH
         3BSvwbvAJbEgsCf4iaXiLLKvtVX1jaKGh+a7EuVJ55wlAx/2f5uF6Mcr2NixW95XbcV2
         lA8MjLt2kYklqra+H7kFMEYda+ZNRV5URE5AnIFvksujftfUeiDtoopSYkpemp3xSRME
         qD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43iWKH6jifytF6JFVgfLHPopXRcvvg3jKXLdEufvKFw=;
        b=CxhW0YWUWqDMzB/M9SLFpYdJ1Fu0cgoad1pznJSHdYZ9ggYcAUULkABgMA4DOi2gBU
         rwYTCI4Uxmnvz0a7KlvMBdZ/EytfGFoM8YAbW61ulKyGLRUbVRFCu9n/Cpuvpk4noIa3
         GOXjBrUYFufEwFciL7wfmCEvnEqcTIFfesp1TYW9X5WZQSWbUfBg8feaXQZaPCNBQCCK
         jF8S8UqEfWXn+iDQizrc8ELg2f7OZDYS9YNwnpTv3CbYi8sCoad17DawcLtmnIXdr2hm
         GZH9WiHb95OCozXmMCNMw1o4dKLw3uiyD/lN1TMIstMTXGJLZQZNr/KrUJqYpQbmNTjn
         o3LQ==
X-Gm-Message-State: APjAAAVYzu5tHb3T+u5uGQaGnwnPoDH5Ju6qSR6FZ7G1AJICAwwZYZDo
        yexQspMgwZydzj2nIu4nsTA6JIe3EmBz21AlX5o=
X-Google-Smtp-Source: APXvYqxWyXlIkUu8b3u0rYozO679+E2AsoRAzxugCAL/051AnSJ56YHrOmAaSBvKviIHxzKsoTLBzEQBGqT0b1X6Hc8=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr3394953wmc.25.1562073288730;
 Tue, 02 Jul 2019 06:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190702131155.18170-1-andradanciu1997@gmail.com>
In-Reply-To: <20190702131155.18170-1-andradanciu1997@gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 2 Jul 2019 16:14:37 +0300
Message-ID: <CAEnQRZDC_wxHbs4ZpeKTo9z7T-tdgeDLwgcf+DLRfZmXDga20A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add sai3 and sai6 nodes
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

Looks better now. One comment inline:

On Tue, Jul 2, 2019 at 4:12 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> SAI3 and SAI6 nodes are used to connect to an external codec.
> They have 1 Tx and 1 Rx dataline.
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
> Changes since v1:
>         - Added sai3 node because we need it to enable audio on pico-pi-8m
>         - Added commit description
>
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index d09b808eff87..2d489c5cdc26 100644
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
> @@ -728,6 +742,22 @@
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
> +

Please don't use multiple blank lines here.

>                         i2c1: i2c@30a20000 {
>                                 compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
>                                 reg = <0x30a20000 0x10000>;
> --
> 2.11.0
>
