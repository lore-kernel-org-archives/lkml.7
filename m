Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D8BCA9EBE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B56214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572259864;
	bh=9OhlQBQfGJwsaiYR0zQLkgRNjoR5DNpZiAm81WHbbLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U+4DLrRTG70gyr8FX0o0AGq/QuDYCkgOI2s0i68she1RFYBu19RJ3OKoex82ptl4g
	 a+8Vuj9gvktMG47CR0gB5xaUDwbcUh41wZ5p0nml61N/1aOlY7HR2BPlFkS/ScdMAh
	 WR766R4dEr9sg9D/f1hGgtRMBO45N1zNzzcoAs60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfJ1KvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbfJ1KvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:51:02 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62B820873;
        Mon, 28 Oct 2019 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572259860;
        bh=9OhlQBQfGJwsaiYR0zQLkgRNjoR5DNpZiAm81WHbbLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0+JkOhaq96U+qp1FtMCnoQh25qovOzVvaK0XbvsxNlL6o/ivlM38FyDig2PM5jPw
         ix1nl7s6ElT53Ah3vTvvkjhPLi9FzNMvMjPVh4h1C68GZlmlPOj5bBz1lt639hBz6U
         972wNv6KP7fM88gg8bUFRslUrGRjhchW6LOPUhFg=
Date:   Mon, 28 Oct 2019 18:50:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Message-ID: <20191028105038.GB16985@dragon>
References: <20191028080545.28275-1-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028080545.28275-1-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:07:59AM +0000, Fancy Fang wrote:
> The mipi pll clock comes from the MIPI PHY PLL output, so
> it should not be a fixed clock.
> 
> MIPI PHY PLL is in the MIPI DSI space, and it is used as
> the bit clock for transferring the pixel data out and its
> output clock is configured according to the display mode.
> 
> So it should be used only for MIPI DSI and not be exported
> out for other usages.
> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>
> ---
> ChangeLog v3->v4:
>  * Add some comments to 'IMX7ULP_CLK_MIPI_PLL'
>    clock.
> 
>  Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
>  drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
>  include/dt-bindings/clock/imx7ulp-clock.h                 | 6 ++++++
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> index a4f8cd478f92..93d89adb7afe 100644
> --- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> @@ -82,7 +82,6 @@ pcc2: pcc2@403f0000 {
>  		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
>  		 <&scg1 IMX7ULP_CLK_UPLL>,
>  		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
> -		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
>  		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
>  		 <&scg1 IMX7ULP_CLK_ROSC>,
>  		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
> diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
> index 2022d9bead91..459b120b71d5 100644
> --- a/drivers/clk/imx/clk-imx7ulp.c
> +++ b/drivers/clk/imx/clk-imx7ulp.c
> @@ -28,7 +28,7 @@ static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dumm
>  static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
>  static const char * const nic_sels[]		= { "firc", "ddr_clk", };
>  static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
> -static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
> +static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
>  static const char * const arm_sels[]		= { "divcore", "dummy", "dummy", "hsrun_divcore", };
>  
>  /* used by sosc/sirc/firc/ddr/spll/apll dividers */
> @@ -75,7 +75,6 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
>  	clks[IMX7ULP_CLK_SOSC]		= imx_obtain_fixed_clk_hw(np, "sosc");
>  	clks[IMX7ULP_CLK_SIRC]		= imx_obtain_fixed_clk_hw(np, "sirc");
>  	clks[IMX7ULP_CLK_FIRC]		= imx_obtain_fixed_clk_hw(np, "firc");
> -	clks[IMX7ULP_CLK_MIPI_PLL]	= imx_obtain_fixed_clk_hw(np, "mpll");
>  	clks[IMX7ULP_CLK_UPLL]		= imx_obtain_fixed_clk_hw(np, "upll");
>  
>  	/* SCG1 */
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
> index 6f66f9005c81..e9ef62f211fe 100644
> --- a/include/dt-bindings/clock/imx7ulp-clock.h
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -49,7 +49,13 @@
>  #define IMX7ULP_CLK_NIC1_DIV		36
>  #define IMX7ULP_CLK_NIC1_BUS_DIV	37
>  #define IMX7ULP_CLK_NIC1_EXT_DIV	38
> +
> +/* mpll clock is a special clock comes from
> + * mipi DPHY PLL and should be used only for
> + * mipi dsi instead of any other peripheral.
> + */
>  #define IMX7ULP_CLK_MIPI_PLL		39
> +

The point of comment is to tell that the clock ID is unsupported and
shouldn't be used in DT.

I reworded the comment and applied the patch.

Shawn

>  #define IMX7ULP_CLK_SIRC		40
>  #define IMX7ULP_CLK_SOSC_BUS_CLK	41
>  #define IMX7ULP_CLK_FIRC_BUS_CLK	42
> -- 
> 2.17.1
> 
