Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E12C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED552178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfKGR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:58:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39881 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfKGR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:58:00 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iSm2b-00008c-Ap; Thu, 07 Nov 2019 18:57:53 +0100
Date:   Thu, 7 Nov 2019 18:57:51 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        jollys@xilinx.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejas Patel <tejas.patel@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] clk: zynqmp: Add support for clock with
 CLK_DIVIDER_POWER_OF_TWO flag
Message-ID: <20191107185751.4bb873d9@litschi.hi.pengutronix.de>
In-Reply-To: <1573116902-7240-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573116902-7240-1-git-send-email-rajan.vaja@xilinx.com>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Nov 2019 00:55:02 -0800, Rajan Vaja wrote:
> From: Tejas Patel <tejas.patel@xilinx.com>
> 
> Existing clock divider functions is not checking for
> base of divider. So, if any clock divider is power of 2
> then clock rate calculation will be wrong.
> 
> Add support to calculate divider value for the clocks
> with CLK_DIVIDER_POWER_OF_TWO flag.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/clk/zynqmp/divider.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index d8f5b70d..ce63cf5 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -2,7 +2,7 @@
>  /*
>   * Zynq UltraScale+ MPSoC Divider support
>   *
> - *  Copyright (C) 2016-2018 Xilinx
> + *  Copyright (C) 2016-2019 Xilinx
>   *
>   * Adjustable divider clock implementation
>   */
> @@ -44,9 +44,26 @@ struct zynqmp_clk_divider {
>  };
>  
>  static inline int zynqmp_divider_get_val(unsigned long parent_rate,
> -					 unsigned long rate)
> +					 unsigned long rate, u16 flags)
>  {
> -	return DIV_ROUND_CLOSEST(parent_rate, rate);
> +	int up, down;
> +	unsigned long up_rate, down_rate;
> +
> +	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> +		up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> +		down = parent_rate / rate;

Maybe use DIV_ROUND_DOWN_ULL()?

> +
> +		up = __roundup_pow_of_two(up);
> +		down = __rounddown_pow_of_two(down);
> +
> +		up_rate = DIV_ROUND_UP_ULL((u64)parent_rate, up);
> +		down_rate = DIV_ROUND_UP_ULL((u64)parent_rate, down);
> +
> +		return (rate - up_rate) <= (down_rate - rate) ? up : down;

The calculation looks correct. Maybe there could be a common helper
with the _div_round_closest() function?

> +
> +	} else {
> +		return DIV_ROUND_CLOSEST(parent_rate, rate);
> +	}
>  }
>  
>  /**
> @@ -78,6 +95,9 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
>  	else
>  		value = div >> 16;
>  
> +	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> +		value = 1 << value;

Not sure, but I think a small helper similar to _get_div() would help
with the readability. Just hide the difference between the normal and
power of two divisors behind some helper functions.

Michael

> +
>  	if (!value) {
>  		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
>  		     "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> @@ -120,10 +140,13 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
>  		else
>  			bestdiv  = bestdiv >> 16;
>  
> +		if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> +			bestdiv = 1 << bestdiv;
> +
>  		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
>  	}
>  
> -	bestdiv = zynqmp_divider_get_val(*prate, rate);
> +	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
>  
>  	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
>  		bestdiv = rate % *prate ? 1 : bestdiv;
> @@ -151,7 +174,7 @@ static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  	int ret;
>  	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  
> -	value = zynqmp_divider_get_val(parent_rate, rate);
> +	value = zynqmp_divider_get_val(parent_rate, rate, divider->flags);
>  	if (div_type == TYPE_DIV1) {
>  		div = value & 0xFFFF;
>  		div |= 0xffff << 16;
> @@ -160,6 +183,9 @@ static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  		div |= value << 16;
>  	}
>  
> +	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> +		div = __ffs(div);
> +
>  	ret = eemi_ops->clock_setdivider(clk_id, div);
>  
>  	if (ret)
