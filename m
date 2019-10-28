Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A87CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7500C20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572252803;
	bh=sje/naToVwhIk0khoE4ly4GBr5AykbI6l4IxHlquzXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YB+2xeOopBvmpehKqdXSdtw9Sdg73J3ShmrNxjRosPjmd2M+Q6cKvUCa0y0cH4ECE
	 EK8gEcrIyycu3ktGhJaGSKDExrtGUWG3mS9g/KZOow6d9E5sGCKVB2guHIIH8Ae6B2
	 hPMr/dcQcqvXE3tlUlm5t+zipm9QHdc/Z+NIytvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJ1IxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbfJ1IxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:53:21 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A049320B7C;
        Mon, 28 Oct 2019 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572252800;
        bh=sje/naToVwhIk0khoE4ly4GBr5AykbI6l4IxHlquzXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eirtUJY0Fn/DBz9mj7Na0vO1p409aFKZz7RA1F8MCV7EZ2SRt3xK79XUE0jaPSQGT
         VxjmVFXe9hYUoWrnMmU7MeZTWCSULuRJqSp+kdy7ayLuL498nhbF4I53DLMG7DkVbj
         ZI0reb0b8x/gXa9dHhpAqOYspEtPIYsKo/XMOdwQ=
Date:   Mon, 28 Oct 2019 16:53:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Message-ID: <20191028085258.GZ16985@dragon>
References: <1571900044-22079-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571900044-22079-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Abel, comments?

Shawn

On Thu, Oct 24, 2019 at 06:57:21AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The current clk tree shows:
>  osc_25m                              9       11        0    25000000          0     0  50000
>     sys2_pll1_ref_sel                 1        1        0    25000000          0     0  50000
>        sys3_pll_out                   1        1        0    25000000          0     0  50000
>     sys1_pll1_ref_sel                 2        2        0    25000000          0     0  50000
>        sys2_pll_out                   6        6        0  1000000000          0     0  50000
> 
> It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent,
> sys2_pll_out use sys1_pll1_ref_sel as parent.
> 
> According to the current imx_clk_sccg_pll design, it uses both
> bypass1/2, however set bypass2 as 1 is not correct, because it will
> make sys[x]_pll_out use wrong parent and might access wrong registers.
> 
> So correct bypass2 to 0 and fix sys2/3_pll_out_sels.
> 
> After fix, the tree shows:
>  osc_25m                             10       12        0    25000000          0     0  50000
>     sys3_pll1_ref_sel                 1        1        0    25000000          0     0  50000
>        sys3_pll_out                   1        1        0    25000000          0     0  50000
>     sys2_pll1_ref_sel                 1        1        0    25000000          0     0  50000
>        sys2_pll_out                   6        6        0  1000000000          0     0  50000
>     sys1_pll1_ref_sel                 1        1        0    25000000          0     0  50000
>        sys1_pll_out                   5        5        0   800000000          0     0  50000
> 
> Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 05ece7b5da54..e17f0ebfacb0 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -35,8 +35,8 @@ static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_
>  static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
>  
>  static const char * const sys1_pll_out_sels[] = {"sys1_pll1_ref_sel", };
> -static const char * const sys2_pll_out_sels[] = {"sys1_pll1_ref_sel", "sys2_pll1_ref_sel", };
> -static const char * const sys3_pll_out_sels[] = {"sys3_pll1_ref_sel", "sys2_pll1_ref_sel", };
> +static const char * const sys2_pll_out_sels[] = {"sys2_pll1_ref_sel", };
> +static const char * const sys3_pll_out_sels[] = {"sys3_pll1_ref_sel", };
>  static const char * const dram_pll_out_sels[] = {"dram_pll1_ref_sel", };
>  static const char * const video2_pll_out_sels[] = {"video2_pll1_ref_sel", };
>  
> @@ -345,8 +345,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  	clks[IMX8MQ_VIDEO_PLL1_OUT] = imx_clk_gate("video_pll1_out", "video_pll1_bypass", base + 0x10, 21);
>  
>  	clks[IMX8MQ_SYS1_PLL_OUT] = imx_clk_sccg_pll("sys1_pll_out", sys1_pll_out_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CRITICAL);
> -	clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_sccg_pll("sys2_pll_out", sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CRITICAL);
> -	clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_sccg_pll("sys3_pll_out", sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITICAL);
> +	clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_sccg_pll("sys2_pll_out", sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 0, base + 0x3c, CLK_IS_CRITICAL);
> +	clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_sccg_pll("sys3_pll_out", sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRITICAL);
>  	clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_sccg_pll("dram_pll_out", dram_pll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITICAL);
>  	clks[IMX8MQ_VIDEO2_PLL_OUT] = imx_clk_sccg_pll("video2_pll_out", video2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
>  
> -- 
> 2.16.4
> 
