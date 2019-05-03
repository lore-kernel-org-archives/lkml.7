Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2796C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D71206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfECVvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 17:51:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36590 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfECVvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 17:51:07 -0400
Received: from p508fd516.dip0.t-ipconnect.de ([80.143.213.22] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hMg58-0007vr-4r; Fri, 03 May 2019 23:51:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Don't yell about bad mmc phases when getting
Date:   Fri, 03 May 2019 23:51:01 +0200
Message-ID: <1783321.PXM97fLzLk@phil>
In-Reply-To: <20190503212208.223232-1-dianders@chromium.org>
References: <20190503212208.223232-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. Mai 2019, 23:22:08 CEST schrieb Douglas Anderson:
> At boot time, my rk3288-veyron devices yell with 8 lines that look
> like this:
>   [    0.000000] rockchip_mmc_get_phase: invalid clk rate
> 
> This is because the clock framework at clk_register() time tries to
> get the phase but we don't have a parent yet.
> 
> While the errors appear to be harmless they are still ugly and, in
> general, we don't want yells like this in the log unless they are
> important.
> 
> There's no real reason to be yelling here.  We can still return
> -EINVAL to indicate that the phase makes no sense without a parent.
> If someone really tries to do tuning and the clock is reported as 0
> then we'll see the yells in rockchip_mmc_set_phase().
> 
> Fixes: 4bf59902b500 ("clk: rockchip: Prevent calculating mmc phase if clock rate is zero")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for fixing that. I always meant to handle that yell, but hadn't
found the time yet.

@Stephen, Mike: if you want to just apply this atop the other Rockchip
clock patches for 5.2, here is a

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Otherwise I'l queue that up for 5.3 later on.

Thanks
Heiko

> ---
> 
>  drivers/clk/rockchip/clk-mmc-phase.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
> index 026a26bb702d..dbec84238ecd 100644
> --- a/drivers/clk/rockchip/clk-mmc-phase.c
> +++ b/drivers/clk/rockchip/clk-mmc-phase.c
> @@ -61,10 +61,8 @@ static int rockchip_mmc_get_phase(struct clk_hw *hw)
>  	u32 delay_num = 0;
>  
>  	/* See the comment for rockchip_mmc_set_phase below */
> -	if (!rate) {
> -		pr_err("%s: invalid clk rate\n", __func__);
> +	if (!rate)
>  		return -EINVAL;
> -	}
>  
>  	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
>  
> 




