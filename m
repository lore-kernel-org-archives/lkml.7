Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E0ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BF21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572089659;
	bh=/ZgfzByLCwOTe4PepmJqOGeav5FVx+wp6pJk4rlUrY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L5ejs4b48+gusuuUBHNMas26T4ZUNrR3wraQrP/ePzfq0prqGfogV1TwbInAvIhl7
	 43Yo8diGi7a6paFGGoe6ZLrbmYfNsyCQBYhhnaKSA1kdbK83SZBurpEWMD5i4dRV51
	 BZJ/OIonAiy/To7kGlSEyy6uQdIhcJzmw/16vIKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJZLeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfJZLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:34:15 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4399120863;
        Sat, 26 Oct 2019 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572089655;
        bh=/ZgfzByLCwOTe4PepmJqOGeav5FVx+wp6pJk4rlUrY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFZ++fOBoaobWkYaC1HW+9PAkgg7FGHkb3r4nQwrAYZfY1BGE/j8F91wljhS1VAfK
         DukWFoYMMDHj5NJrGkeUG+LthKqiRlSV5iJjoUh+SCAwjXyhKYxZJVimlGjASN6DBw
         IkavLbHLo6UoMmt157zDge/joFQWLhsxaywxp9MY=
Date:   Sat, 26 Oct 2019 19:34:00 +0800
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
Subject: Re: [PATCH v3] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Message-ID: <20191026113357.GH14401@dragon>
References: <20191015031501.2703-1-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015031501.2703-1-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:17:23AM +0000, Fancy Fang wrote:
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
> ChangeLog v2->v3:
>  * Keep 'IMX7ULP_CLK_MIPI_PLL' macro definition.

Please follow Stephen's suggestion to add a comment for
IMX7ULP_CLK_MIPI_PLL telling the clock shouldn't be used.

Shawn

> 
> ChangeLog v1->v2:
>  * Keep other clock indexes unchanged as Shawn suggested.
> 
>  Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
>  drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
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
> -- 
> 2.17.1
> 
