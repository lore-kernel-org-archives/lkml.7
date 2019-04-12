Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68571C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6812171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDLLqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:46:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39120 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDLLqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:46:03 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEud5-0005F1-T1; Fri, 12 Apr 2019 13:45:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
Subject: Re: [PATCH v1 4/6] clk: rockchip: add a clock-type for muxes based in the pmugrf
Date:   Fri, 12 Apr 2019 13:45:59 +0200
Message-ID: <15573177.ccEzvj8eDD@diego>
In-Reply-To: <1554284549-24916-5-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <1554284549-24916-5-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Mittwoch, 3. April 2019, 11:42:27 CEST schrieb Elaine Zhang:
> Rockchip socs often have some tiny number of muxes not controlled from
> the core clock controller but through bits set in the pmugrf.
> Use MUXPMUGRF() to cover this special clock-type.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Do you have an example for such a clock?

I.e. on rk3399 we have the pmucru which already links
to the pmugrf as its "regular" rockchip,grf.
Similarly the main-cru links to the main grf.

So I don't really see where a clock needs to be defined
in the main-grf and use a bit from the pmugrf.

Similarly I wasn't really able to find anything that looks like
a clock-mux in the PX30's (rk3326) pmugrf.

So I'd really like an example beforehand :-D

Thanks
Heiko

> ---
>  drivers/clk/rockchip/clk.c |  9 +++++++++
>  drivers/clk/rockchip/clk.h | 17 +++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 0a8a694a41ab..875412043dd7 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -415,6 +415,8 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
>  
>  	ctx->grf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
>  						   "rockchip,grf");
> +	ctx->pmugrf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
> +						   "rockchip,pmugrf");
>  
>  	return ctx;
>  
> @@ -490,6 +492,13 @@ void __init rockchip_clk_register_branches(
>  				list->mux_shift, list->mux_width,
>  				list->mux_flags);
>  			break;
> +		case branch_muxpmugrf:
> +			clk = rockchip_clk_register_muxgrf(list->name,
> +				list->parent_names, list->num_parents,
> +				flags, ctx->pmugrf, list->muxdiv_offset,
> +				list->mux_shift, list->mux_width,
> +				list->mux_flags);
> +			break;
>  		case branch_divider:
>  			if (list->div_table)
>  				clk = clk_register_divider_table(NULL,
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 20200a707611..1b30346f11e1 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -234,6 +234,7 @@ struct rockchip_clk_provider {
>  	struct clk_onecell_data clk_data;
>  	struct device_node *cru_node;
>  	struct regmap *grf;
> +	struct regmap *pmugrf;
>  	spinlock_t lock;
>  };
>  
> @@ -386,6 +387,7 @@ enum rockchip_clk_branch_type {
>  	branch_composite,
>  	branch_mux,
>  	branch_muxgrf,
> +	branch_muxpmugrf,
>  	branch_divider,
>  	branch_fraction_divider,
>  	branch_gate,
> @@ -658,6 +660,21 @@ struct rockchip_clk_branch {
>  		.gate_offset	= -1,				\
>  	}
>  
> +#define MUXPMUGRF(_id, cname, pnames, f, o, s, w, mf)		\
> +	{							\
> +		.id		= _id,				\
> +		.branch_type	= branch_muxpmugrf,		\
> +		.name		= cname,			\
> +		.parent_names	= pnames,			\
> +		.num_parents	= ARRAY_SIZE(pnames),		\
> +		.flags		= f,				\
> +		.muxdiv_offset	= o,				\
> +		.mux_shift	= s,				\
> +		.mux_width	= w,				\
> +		.mux_flags	= mf,				\
> +		.gate_offset	= -1,				\
> +	}
> +
>  #define DIV(_id, cname, pname, f, o, s, w, df)			\
>  	{							\
>  		.id		= _id,				\
> 




