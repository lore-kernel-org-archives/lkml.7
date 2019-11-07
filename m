Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC222C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521821882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfKGSN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:13:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55019 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:13:27 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iSmHR-0001kB-TM; Thu, 07 Nov 2019 19:13:13 +0100
Date:   Thu, 7 Nov 2019 19:13:11 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        jollys@xilinx.com, nava.manne@xilinx.com, tejas.patel@xilinx.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] clk: zynqmp: Fix divider calculation
Message-ID: <20191107191311.4e0d58b2@litschi.hi.pengutronix.de>
In-Reply-To: <1573117574-9316-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573117574-9316-1-git-send-email-rajan.vaja@xilinx.com>
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

On Thu, 07 Nov 2019 01:06:14 -0800, Rajan Vaja wrote:
> Linux doesn't know maximum value of divisor that it can support.
> zynqmp_clk_divider_round_rate() returns actual divider value
> after calculating from parent rate and desired rate, even though
> that rate is not supported by single divider of hardware. It is
> also possible that such divisor value can be achieved through 2
> different dividers. As, Linux tries to set such divisor value(out
> of range) in single divider set divider is getting failed.
> 
> Fix the same by computing best possible combination of two
> divisors which provides more accurate clock rate.

This patch could be split into two patches. One for getting the maximum
value of the divisor and one for calculating the best combination of
the two clocks.

> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> ---
>  drivers/clk/zynqmp/divider.c         | 62 +++++++++++++++++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h |  3 +-
>  2 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index d8f5b70d..d2be24e 100644
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
> @@ -41,6 +41,7 @@ struct zynqmp_clk_divider {
>  	bool is_frac;
>  	u32 clk_id;
>  	u32 div_type;
> +	u32 max_div;

If the maximum value is 0xFFFF, shouldn't this be u16?

>  };
>  
>  static inline int zynqmp_divider_get_val(unsigned long parent_rate,
> @@ -88,6 +89,34 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
>  	return DIV_ROUND_UP_ULL(parent_rate, value);
>  }
>  
> +static void zynqmp_compute_divider(struct clk_hw *hw,
> +				   unsigned long rate,
> +				   unsigned long parent_rate,
> +				   u32 max_div,
> +				   int *bestdiv)

Return bestdiv instead of returning void and passing it as a pointer.
Also maybe you can find a better name for this function.

> +{
> +	int div1;
> +	int div2;
> +	long error = LONG_MAX;
> +	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
> +	struct zynqmp_clk_divider *pdivider = to_zynqmp_clk_divider(parent_hw);
> +
> +	if (!pdivider)
> +		return;
> +
> +	*bestdiv = 1;
> +	for (div1 = 1; div1 <= pdivider->max_div; div1++) {
> +		for (div2 = 1; div2 <= max_div; div2++) {

What happens, if the parent or this divider only supports divisors that
are a power of 2?

> +			long new_error = ((parent_rate / div1) / div2) - rate;
> +
> +			if (abs(new_error) < abs(error)) {
> +				*bestdiv = div2;
> +				error = new_error;
> +			}
> +		}
> +	}
> +}
> +
>  /**
>   * zynqmp_clk_divider_round_rate() - Round rate of divider clock
>   * @hw:			handle between common and hardware-specific interfaces
> @@ -125,8 +154,21 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
>  
>  	bestdiv = zynqmp_divider_get_val(*prate, rate);
>  
> +	/*
> +	 * In case of two divisors, compute best divider values and return
> +	 * divider2 value based on compute value. div1 will  be automatically
> +	 * set to optimum based on required total divider value.
> +	 */
> +	if (div_type == TYPE_DIV2 &&
> +	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> +		zynqmp_compute_divider(hw, rate, *prate,
> +				       divider->max_div, &bestdiv);
> +	}
> +
>  	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
>  		bestdiv = rate % *prate ? 1 : bestdiv;
> +
> +	bestdiv = min_t(u32, bestdiv, divider->max_div);
>  	*prate = rate * bestdiv;
>  
>  	return rate;
> @@ -195,6 +237,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>  	struct clk_hw *hw;
>  	struct clk_init_data init;
>  	int ret;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	struct zynqmp_pm_query_data qdata = {0};
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
>  
>  	/* allocate the divider */
>  	div = kzalloc(sizeof(*div), GFP_KERNEL);
> @@ -215,6 +260,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>  	div->clk_id = clk_id;
>  	div->div_type = nodes->type;
>  
> +	/*
> +	 * To achieve best possible rate, maximum limit of divider is required
> +	 * while computation. Get maximum supported divisor from firmware. To
> +	 * maintain backward compatibility assign maximum possible value(0xFFFF)
> +	 * if query for max divisor is not successful.
> +	 */
> +	qdata.qid = PM_QID_CLOCK_GET_MAX_DIVISOR;
> +	qdata.arg1 = clk_id;
> +	qdata.arg2 = nodes->type;
> +	ret = eemi_ops->query_data(qdata, ret_payload);
> +	if (ret)
> +		div->max_div = 0XFFFF;

U16_MAX?

Michael

> +	else
> +		div->max_div = ret_payload[1];
> +
>  	hw = &div->hw;
>  	ret = clk_hw_register(NULL, hw);
>  	if (ret) {
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 778abbb..1edb6e9 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -2,7 +2,7 @@
>  /*
>   * Xilinx Zynq MPSoC Firmware layer
>   *
> - *  Copyright (C) 2014-2018 Xilinx
> + *  Copyright (C) 2014-2019 Xilinx
>   *
>   *  Michal Simek <michal.simek@xilinx.com>
>   *  Davorin Mista <davorin.mista@aggios.com>
> @@ -105,6 +105,7 @@ enum pm_query_id {
>  	PM_QID_CLOCK_GET_PARENTS,
>  	PM_QID_CLOCK_GET_ATTRIBUTES,
>  	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
> +	PM_QID_CLOCK_GET_MAX_DIVISOR,
>  };
>  
>  enum zynqmp_pm_reset_action {
