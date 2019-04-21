Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB5C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D7A2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb/UFZ0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfDUIVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:21:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40460 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUIVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:21:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so4335623pfc.7;
        Sun, 21 Apr 2019 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6lc0ay5gHFR5swtwXOmViM7nIFzJo8K7yF0YlsWYOg=;
        b=Lb/UFZ0uxv3HebvlYtqdvSkTS29Xz8hxWdIwsbbMpu8C9N/iRhCNYm1K+TmfanEsMm
         cvArHVOtvPB2mp2UGDhFn0XVqB2+e3uzzdzCrndM7HCbkubjT5pBImuRm7BO29prjlrn
         mj2ykDW3QY8KXZZ2LfO3tiyyAt+NEOgHd/O6inrkJ0jBV0mN1alUE66BPIvj5Qdfak9a
         APHMyCZIDo9XWZKbSqQOIFOSf4V/rIhAeXy2TqqmSn4/ic4T75A9qJP3T0V+izWBHLh7
         qE3Y3H+81XpBJf5U1HYbm/W0/xxcEAbnCMA3WXZFmayWksRoxFXViwUcSQRcXbYKEhZl
         XXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6lc0ay5gHFR5swtwXOmViM7nIFzJo8K7yF0YlsWYOg=;
        b=K7UmKt+DZnJDipe63YU1IFVYOYIVZ5fn8SNW/qnyXGrtO9iuP8y9CIj7b3XKX/x1OY
         R1F/fJDDcGJuQAz/bibDQHX/7u/diaZ1n/nmEhf9wavK6ryGch9tXR/CP+QDgJ80471I
         XjSgeedQojE9b4ldr+lpQjQXIt1Rmxkwk2xBzgC+gZXXEIvRiyVj+QIQvylOIiCS4WpN
         yoz0CMrk7MPExw6Gsatcu5tOfJ5rhedU1eSMFNW1u9SJwW5aJWG9ExSrqKgmxsOGe0aP
         PvsAqQiI1hQcZlN6umKQecsSjmyCKUSheXSj6EEnQUUWNT6EvUWWkxnx0yj3zHmW6TC1
         e3XA==
X-Gm-Message-State: APjAAAXSoICtXBGbhfJqaWmNywTwMUT4wtCIu+viMSsFsy3NbEr4k8lA
        3yoA/SuhcmNGzn1n3F7yhJdJIKAN
X-Google-Smtp-Source: APXvYqwlm0+U1Ppd89QYq9KWm7eKJRFZ3kO4+wIUqMI3K2tvq7PCdrrvnWY2NN5zgRAX+2m/xkp14Q==
X-Received: by 2002:a62:7648:: with SMTP id r69mr14095914pfc.114.1555834864277;
        Sun, 21 Apr 2019 01:21:04 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id j20sm12366770pfn.84.2019.04.21.01.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 01:21:03 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:20:57 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Message-ID: <20190421082038.GA8304@Asurada>
References: <20190420091239.3793-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420091239.3793-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 09:12:52AM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> SAI has 4 clock sources, which can be selected using MSEL
> bit of SAI TCR2 register.

I have a doubt at this statement. As far as I can understand,
this MSEL is probably used by its internal clock MUX, so it's
not really proving that SAI has 4 MCLK inputs. What I know is
that SAI block itself only has 3 MCLK inputs as we defined in
DT. It's just internally connects bus clock or MCLK1 to input0
of clock MUX's and connects MCLK[1-3] to input[1-3]. So adding
an MCLK0 here doesn't sound a right way to me. Unless someone
can justify for it, I think we should just fix it from driver
side.

Thanks
Nicolin

> 
> On imx6/7 mclk0 and mclk1 always point to the same clock
> source. Anyhow, this is no longer true for imx8.
> 
> For this reason, we need to add mclk0 and handle it
> in a generic way in SAI driver.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 6 ++++--
>  arch/arm/boot/dts/imx6ul.dtsi | 9 ++++++---
>  arch/arm/boot/dts/imx7s.dtsi  | 9 ++++++---
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index b16a123990a2..682207b5d868 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -1071,9 +1071,10 @@
>  				reg = <0x021d4000 0x4000>;
>  				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SX_CLK_SAI1_IPG>,
> +					 <&clks IMX6SX_CLK_SAI1>,
>  					 <&clks IMX6SX_CLK_SAI1>,
>  					 <&clks 0>, <&clks 0>;
> -				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  				dma-names = "rx", "tx";
>  				dmas = <&sdma 31 24 0>, <&sdma 32 24 0>;
>  				status = "disabled";
> @@ -1090,9 +1091,10 @@
>  				reg = <0x021dc000 0x4000>;
>  				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SX_CLK_SAI2_IPG>,
> +					 <&clks IMX6SX_CLK_SAI2>,
>  					 <&clks IMX6SX_CLK_SAI2>,
>  					 <&clks 0>, <&clks 0>;
> -				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  				dma-names = "rx", "tx";
>  				dmas = <&sdma 33 24 0>, <&sdma 34 24 0>;
>  				status = "disabled";
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index bbf010c73336..e9691306f557 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -304,9 +304,10 @@
>  					reg = <0x02028000 0x4000>;
>  					interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6UL_CLK_SAI1_IPG>,
> +						 <&clks IMX6UL_CLK_SAI1>,
>  						 <&clks IMX6UL_CLK_SAI1>,
>  						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dmas = <&sdma 35 24 0>,
>  					       <&sdma 36 24 0>;
>  					dma-names = "rx", "tx";
> @@ -319,9 +320,10 @@
>  					reg = <0x0202c000 0x4000>;
>  					interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6UL_CLK_SAI2_IPG>,
> +						 <&clks IMX6UL_CLK_SAI2>,
>  						 <&clks IMX6UL_CLK_SAI2>,
>  						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dmas = <&sdma 37 24 0>,
>  					       <&sdma 38 24 0>;
>  					dma-names = "rx", "tx";
> @@ -334,9 +336,10 @@
>  					reg = <0x02030000 0x4000>;
>  					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
> +						 <&clks IMX6UL_CLK_SAI3>,
>  						 <&clks IMX6UL_CLK_SAI3>,
>  						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dmas = <&sdma 39 24 0>,
>  					       <&sdma 40 24 0>;
>  					dma-names = "rx", "tx";
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 0b01109ac0a9..693b88e37799 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -884,10 +884,11 @@
>  					reg = <0x308a0000 0x10000>;
>  					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX7D_SAI1_IPG_CLK>,
> +						 <&clks IMX7D_SAI1_ROOT_CLK>,
>  						 <&clks IMX7D_SAI1_ROOT_CLK>,
>  						 <&clks IMX7D_CLK_DUMMY>,
>  						 <&clks IMX7D_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dma-names = "rx", "tx";
>  					dmas = <&sdma 8 24 0>, <&sdma 9 24 0>;
>  					status = "disabled";
> @@ -899,10 +900,11 @@
>  					reg = <0x308b0000 0x10000>;
>  					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX7D_SAI2_IPG_CLK>,
> +						 <&clks IMX7D_SAI2_ROOT_CLK>,
>  						 <&clks IMX7D_SAI2_ROOT_CLK>,
>  						 <&clks IMX7D_CLK_DUMMY>,
>  						 <&clks IMX7D_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dma-names = "rx", "tx";
>  					dmas = <&sdma 10 24 0>, <&sdma 11 24 0>;
>  					status = "disabled";
> @@ -914,10 +916,11 @@
>  					reg = <0x308c0000 0x10000>;
>  					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>  					clocks = <&clks IMX7D_SAI3_IPG_CLK>,
> +						 <&clks IMX7D_SAI3_ROOT_CLK>,
>  						 <&clks IMX7D_SAI3_ROOT_CLK>,
>  						 <&clks IMX7D_CLK_DUMMY>,
>  						 <&clks IMX7D_CLK_DUMMY>;
> -					clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>  					dma-names = "rx", "tx";
>  					dmas = <&sdma 12 24 0>, <&sdma 13 24 0>;
>  					status = "disabled";
> -- 
> 2.17.1
> 
