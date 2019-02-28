Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95100C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551363695;
	bh=lD6FHZ0R1A+zdLfwrCDaddv3WwOeKfDO1mENVaei+Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvZ6Od4TmRuYgvxxnNwLh4tFk0DW/ltTt7NeO17GJjRFd03MGdtpsaMjNnGHC05J5
	 aEnUFyYeHMRRtLejhRfehy6vJFKy6kYSooRY/pcJj0l9/nXqZFPN6Ljm7bgOAfkw9/
	 q9SCEENQ06juPERFZubRm0rkEDauudj9vdgNcxsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfB1OVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfB1OVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:21:33 -0500
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 964862171F;
        Thu, 28 Feb 2019 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551363692;
        bh=lD6FHZ0R1A+zdLfwrCDaddv3WwOeKfDO1mENVaei+Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2nAAq8r/+fqMuxVERnFjsvVyCfQDmC4xJbEUSCqMc0nWqUMyB8492NGn+tliO4Uf
         eE/MJtAB6CvNElo6mhk1aRxwVm97EVt+KDEKTMpPRrVe7HtKK+JB9TRszZxzvT36PI
         gHhPWo5QrUydJ3eJM86o37mnSXYd7Evni5obKnIA=
Date:   Thu, 28 Feb 2019 22:20:32 +0800
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
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mq: Add the opp table and cores
 opp properties
Message-ID: <20190228142030.GB29231@dragon>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
 <1550254032-16451-4-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550254032-16451-4-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 06:07:24PM +0000, Abel Vesa wrote:
> Add the 0.8GHz and 1GHz opps. According to the datasheet:
> https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf
> section 3.1.3 Operating ranges.
> 
> The 0.8GHz opp runs in nominal mode with the regulator set to 0.9V.
> The 1GHz runs in overdrive mode with the regulator set to 1V.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 1a89062..ebdec9e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -91,6 +91,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_1: cpu@1 {
> @@ -101,6 +102,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_2: cpu@2 {
> @@ -111,6 +113,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_3: cpu@3 {
> @@ -121,6 +124,7 @@
>  			clocks = <&clk IMX8MQ_CLK_ARM>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			operating-points-v2 = <&a53_0_opp_table>;
>  		};
>  
>  		A53_L2: l2-cache0 {
> @@ -666,6 +670,25 @@
>  			status = "disabled";
>  		};
>  
> +
> +		a53_0_opp_table: opp-table {

What's the point of having '0' in the label name, considering it's
actually referred by all CPU nodes?

Shawn

> +			compatible = "operating-points-v2";
> +			opp-shared;
> +
> +			opp-800000000 {
> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <900000>;
> +				clock-latency-ns = <150000>;
> +			};
> +
> +			opp-1000000000 {
> +				opp-hz = /bits/ 64 <1000000000>;
> +				opp-microvolt = <1000000>;
> +				clock-latency-ns = <150000>;
> +				opp-suspend;
> +			};
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,	/* GIC Dist */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
