Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE881C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737632171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551363409;
	bh=9xSREEXqSZaSGtv+FaDJsnmwYFQhzVRuYTR57iNggpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jyCDwHBbVgs0lPl2GRL3hSFNQS3sYypDO2qs2ZEpmsbChnLSUwBaCU1h6vp8lzFKo
	 BVzOnEomcC0CtKnaFcq59jfbc+zJ7hiCTftC3hplNDyC+IvoyPwseqIHSMRsVel50T
	 uTmEsTaX1jV4Q4HjAi/uo1C7/gD6+xvw+bDL4hao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfB1OQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbfB1OQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:16:47 -0500
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10BF214D8;
        Thu, 28 Feb 2019 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551363406;
        bh=9xSREEXqSZaSGtv+FaDJsnmwYFQhzVRuYTR57iNggpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUjyWrZP7KIimTkKuCtHkTEz7N4nI0he2TnJ/aiYRhm0xQm682ahlhEj9oeGNtE2p
         B0Syo8uVagSdP3LJc8NLuZWDEK3uYoOQ9TBjvB7DAvgSryAc7ILAXA0IyIZYn+Bdkc
         6gx7k+H9hclYZYqdiVz3CPlI2l3H0gZ/kAGtNZ/w=
Date:   Thu, 28 Feb 2019 22:15:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mq: Add the buck vdd_arm regulator
Message-ID: <20190228141543.GA29231@dragon>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
 <1550254032-16451-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550254032-16451-3-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 06:07:23PM +0000, Abel Vesa wrote:
> According to the schematics, this is a MP2147 switch converter
> which is controlled by GPIO1_IO13. When set the gpio is set to
> high the regulator output is set to 0.9V. When the gpio is set
> to low the regulator output is set to 1V.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 54737bf..e5da3dd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,35 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	buck2_reg: buck2 {

Please follow regulator-xxx naming convention.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_buck2>;
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd_arm";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <1000000>;
> +		gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		states = <1000000 0x0
> +			  900000 0x1>;
> +		enable-active-high;

The property only makes sense when enable-gpio is present?

Shawn

> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2_reg>;
>  };
>  
>  &fec1 {
> @@ -203,6 +232,13 @@
>  };
>  
>  &iomuxc {
> +	pinctrl_buck2: vddarmgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
> +		>;
> +
> +	};
> +
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
