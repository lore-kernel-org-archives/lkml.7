Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E83C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD95E20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCGMFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:05:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58069 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:05:48 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h1rmI-0007E8-Hy; Thu, 07 Mar 2019 13:05:34 +0100
Message-ID: <1551960333.9298.37.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] clk: imx8mq: add hdmi_phy_27m clock as pll's
 reference clock
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 07 Mar 2019 13:05:33 +0100
In-Reply-To: <1551929772-22633-2-git-send-email-Anson.Huang@nxp.com>
References: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
         <1551929772-22633-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 07.03.2019, 03:41 +0000 schrieb Anson Huang:
> There is another 27MHz OSC inside i.MX8MQ's display block and
> it can be one of reference clocks of all PLLs, add it into clock
> tree and also add it as PLL's reference clock.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index a9b3888..bb1bf9b 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -26,7 +26,7 @@ static u32 share_count_nand;
>  
>  static struct clk *clks[IMX8MQ_CLK_END];
>  
> -static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "dummy", "dummy", };
> +static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "osc_hdmi_phy_27m", "dummy", };
>  static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
>  static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
>  static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
> @@ -281,6 +281,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  	clks[IMX8MQ_CLK_32K] = of_clk_get_by_name(np, "ckil");
>  	clks[IMX8MQ_CLK_25M] = of_clk_get_by_name(np, "osc_25m");
>  	clks[IMX8MQ_CLK_27M] = of_clk_get_by_name(np, "osc_27m");
> +	clks[IMX8MQ_CLK_HDMI_PHY_27M] = of_clk_get_by_name(np, "osc_hdmi_phy_27m");

This is not acceptable. This adds a new required clock input, without
bothering to add the corresponding binding information or thinking
about backwards compatibility. At this point there are existing DTs out
there, which don't provide this required clock, which will cause a full
boot regression. This can only be an optional clock input at this
point.

Regards,
Lucas

>  	clks[IMX8MQ_CLK_EXT1] = of_clk_get_by_name(np, "clk_ext1");
>  	clks[IMX8MQ_CLK_EXT2] = of_clk_get_by_name(np, "clk_ext2");
>  	clks[IMX8MQ_CLK_EXT3] = of_clk_get_by_name(np, "clk_ext3");
