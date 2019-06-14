Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46143C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA9D208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFNJSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:18:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37706 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfFNJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:18:15 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbiLY-00041V-D9; Fri, 14 Jun 2019 11:18:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: select hdmiphy clock source for rk3228
Date:   Fri, 14 Jun 2019 11:18:07 +0200
Message-ID: <4689860.tqrvb1PrOO@phil>
In-Reply-To: <20190612133343.28309-1-justin.swartz@risingedge.co.za>
References: <20190612133343.28309-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 12. Juni 2019, 15:33:43 CEST schrieb Justin Swartz:
> Unless explictly configured by a bootloader, the hdmiphy clock parent
> defaults to the xin24m clock source. This configuration does not yield
> any HDMI video output, so let hdmiphy_phy (the HDMI PHY output clock)
> be the parent instead.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Mainly for having breadcrumbs for people skimming the lists,
I've adapted this to use assigned-clocks instead of hardcoding.

See the dts-thread for further infos:
https://lore.kernel.org/linux-arm-kernel/1854794.0zkvb3x0FP@phil/T/#mf86ab45e07442ab2b25c67f423ebc4130259f6b0

Heiko


> ---
>  drivers/clk/rockchip/clk-rk3228.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
> index 1c5267d134ee..00a195e6c014 100644
> --- a/drivers/clk/rockchip/clk-rk3228.c
> +++ b/drivers/clk/rockchip/clk-rk3228.c
> @@ -699,6 +699,9 @@ static void __init rk3228_clk_init(struct device_node *np)
>  		return;
>  	}
>  
> +	/* Let hdmiphy_phy be the parent of the hdmiphy clock. */
> +	writel_relaxed(HIWORD_UPDATE(0, 1, 13), reg_base + RK2928_MISC_CON);
> +
>  	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
>  	if (IS_ERR(ctx)) {
>  		pr_err("%s: rockchip clk init failed\n", __func__);
> 




