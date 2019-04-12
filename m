Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99201C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE7B2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDLMQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:16:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39608 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLMP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:15:59 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEv63-0005RQ-9J; Fri, 12 Apr 2019 14:15:55 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        dianders@chromium.org, briannorris@chromium.org
Subject: Re: [PATCH v1 5/6] clk: rockchip: add pll up and down when change pll freq
Date:   Fri, 12 Apr 2019 14:15:54 +0200
Message-ID: <5677286.2uEqRd8HI1@diego>
In-Reply-To: <1554284649-26764-1-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <1554284649-26764-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Mittwoch, 3. April 2019, 11:44:09 CEST schrieb Elaine Zhang:
> set pll sequence:
> 	->set pll to slow mode or other plls
> 	->set pll down
> 	->set pll params
> 	->set pll up
> 	->wait pll lock status
> 	->set pll to normal mode
> 
> To slove the system error:
> wait_pll_lock: timeout waiting for pll to lock
> pll_set_params: pll update unsucessful,
> 		trying to restore old params

Can you tell me on what soc this was experienced?

The patch includes rk3399, but I don't think the CrOS kernel
does powerdown the pll when changing the cpu-frequency
[added Doug and Brian for clarification and possible testing :-) ]

But I did find that the M0 code in ATF does actually power-down the
PLL and follow your outline from above. So essentially I'd just like
a thumbs up from chromeos people if they have the time.


Heiko


> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-pll.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index dd0433d4753e..9fe1227e77e9 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -208,6 +208,11 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
>  		rate_change_remuxed = 1;
>  	}
>  
> +	/* set pll power down */
> +	writel(HIWORD_UPDATE(1,
> +			     RK3036_PLLCON1_PWRDOWN, 13),
> +	       pll->reg_base + RK3036_PLLCON(1));
> +
>  	/* update pll values */
>  	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MASK,
>  					  RK3036_PLLCON0_FBDIV_SHIFT) |
> @@ -229,6 +234,10 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
>  	pllcon |= rate->frac << RK3036_PLLCON2_FRAC_SHIFT;
>  	writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
>  
> +	/* set pll power up */
> +	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 13),
> +	       pll->reg_base + RK3036_PLLCON(1));
> +
>  	/* wait for the pll to lock */
>  	ret = rockchip_pll_wait_lock(pll);
>  	if (ret) {
> @@ -685,6 +694,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
>  		rate_change_remuxed = 1;
>  	}
>  
> +	/* set pll power down */
> +	writel(HIWORD_UPDATE(RK3399_PLLCON3_PWRDOWN,
> +			     RK3399_PLLCON3_PWRDOWN, 0),
> +	       pll->reg_base + RK3399_PLLCON(3));
> +
>  	/* update pll values */
>  	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
>  						  RK3399_PLLCON0_FBDIV_SHIFT),
> @@ -708,6 +722,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
>  					    RK3399_PLLCON3_DSMPD_SHIFT),
>  		       pll->reg_base + RK3399_PLLCON(3));
>  
> +	/* set pll power up */
> +	writel(HIWORD_UPDATE(0,
> +			     RK3399_PLLCON3_PWRDOWN, 0),
> +	       pll->reg_base + RK3399_PLLCON(3));
> +
>  	/* wait for the pll to lock */
>  	ret = rockchip_rk3399_pll_wait_lock(pll);
>  	if (ret) {
> 




