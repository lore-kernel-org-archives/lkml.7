Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E96206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WAef+TBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfG3Ihv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:37:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfG3Ihv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:37:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so64753234wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=suXKnHbhHZc+njEGPUuwld4hD75sxIfXNLOtC4f4vMk=;
        b=WAef+TBHHXmbDvSkkhwdEbkiU8EgTl5LL9ynnKa4uBqhurYYLeejpaee64FMBWuWZ3
         rbFdwHH6/c+0RVYGAJBN6C5NePIeuNBPn+UBxpieyKFbsG2Ii0eV/KNv5xsSXY46P6tW
         JnYGMvBvp7s73yqYdhf+i9WVFaIr3P/uP7rU32DiJK/PXgGdcaEvgS0vTfYoGlXoxxAI
         0M5/U8aBHEcQcHiCcqTN4VkxzrpS3jCXK3Uhs02nmQnebEJPWiWscHCv26vNrX7rK0fK
         bYVRYiDx0VxMye563gJU2MGPDknafsBcCNFs3okeCCRKXGnJQOYoy72r9gSThkr9b2hz
         NO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=suXKnHbhHZc+njEGPUuwld4hD75sxIfXNLOtC4f4vMk=;
        b=a7VhYsuMvMSCMPf8MDX+SiurG1lSEo4OhddY1H1b4KLkMbljSSRriMcI2ohcJaDWDk
         IIO/Are4mucOYNOOnodUfZzZp083otOdCP/i43oAAY8JQEEn5fTcNKwE/HVkJQpni5W6
         7oXhzODtHkzAqjkJdo96Z4mMs08udWlzfKY5Ll7yRlSHRD7P1YCTO1/VPlOVr5pJ3qjH
         wZO9BJcGBGV5uqtSS/Ec3FvJlGtaEt616VTjvifc5gbn6l+FaHX+B9Ca3ULdjaOirPTY
         S71FxKMz1+Z5icC4RBqj5szvtsdaf67iQyBBLRx4fcQxmzbFR7dY2fqIN1k8WdvHunaI
         stdQ==
X-Gm-Message-State: APjAAAVOYoTIEtlz9ayL4ya1KrfOFO09e5ac/tqi8idbuf+8I6Y4lnFd
        81ZTv6Ug27Y3uaaC4DUPV50n7Q==
X-Google-Smtp-Source: APXvYqy0Fw9+nDmXFM4QD0+LGZSGBlZb90GhsgIqF8cB27dJMzeh2QBrBviB3FWRQm/fkblVYh4b4A==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr5483263wrq.333.1564475868470;
        Tue, 30 Jul 2019 01:37:48 -0700 (PDT)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id y18sm60800679wmi.23.2019.07.30.01.37.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:37:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] clk: meson: g12a: add notifiers to handle cpu clock change
In-Reply-To: <20190729131656.7308-4-narmstrong@baylibre.com>
References: <20190729131656.7308-1-narmstrong@baylibre.com> <20190729131656.7308-4-narmstrong@baylibre.com>
Date:   Tue, 30 Jul 2019 10:37:46 +0200
Message-ID: <1j36in3okl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jul 2019 at 15:16, Neil Armstrong <narmstrong@baylibre.com> wrote:

> In order to implement clock switching for the CLKID_CPU_CLK and
> CLKID_CPUB_CLK, notifiers are added on specific points of the
> clock tree :
>
> cpu_clk / cpub_clk
> |   \- cpu_clk_dyn
> |      |  \- cpu_clk_premux0
> |      |        |- cpu_clk_postmux0
> |      |        |    |- cpu_clk_dyn0_div
> |      |        |    \- xtal/fclk_div2/fclk_div3
> |      |        \- xtal/fclk_div2/fclk_div3
> |      \- cpu_clk_premux1
> |            |- cpu_clk_postmux1
> |            |    |- cpu_clk_dyn1_div
> |            |    \- xtal/fclk_div2/fclk_div3
> |            \- xtal/fclk_div2/fclk_div3
> \ sys_pll / sys1_pll
>
> This for each cluster, a single one for G12A, two for G12B.
>
> Each cpu_clk_premux1 tree is marked as read-only and CLK_SET_RATE_NO_REPARENT,
> to be used as "parking" clock in a safe clock frequency.
>
> A notifier is added on each cpu_clk_premux0 to detech when CCF want to
> change the frequency of the cpu_clk_dyn tree.
> In this notifier, the cpu_clk_premux1 tree is configured to use the xtal
> clock and then the cpu_clk_dyn is switch to cpu_clk_premux1 while CCF
> updates the cpu_clk_premux0 tree.
>
> A notifier is added on each sys_pll/sys1_pll to detect when CCF wants to
> change the PLL clock source of the cpu_clk.
> In this notifier, the cpu_clk is switched to cpu_clk_dyn while CCF
> updates the sys_pll/sys1_pll frequency.
>
> A third small notifier is added on each cpu_clk / cpub_clk and cpu_clk_dyn,
> add a small delay at PRE_RATE_CHANGE/POST_RATE_CHANGE to let the other
> notofiers change propagate before changing the cpu_clk_premux0 and sys_pll
> clock trees.
>
> This notifier set permits switching the cpu_clk / cpub_clk without any
> glitches and using a safe parking clock while switching between sub-GHz
> clocks using the cpu_clk_dyn tree.
>
> This setup has been tested and validated on the Amlogic G12A and G12B
> SoCs running the arm64 cpuburn at [1] and cycling between all the possible
> cpufreq translations of each cluster and checking the final frequency using
> the clock-measurer, script at [2].
>
> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> [2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
> ---
>  drivers/clk/meson/g12a.c | 567 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 521 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index e4957fd9f91f..23162310c7ee 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
>  
>  #include "clk-mpll.h"
>  #include "clk-pll.h"
> @@ -88,16 +89,9 @@ static struct clk_regmap g12a_fixed_pll = {
>  	},
>  };
>  
> -/*
> - * Internal sys pll emulation configuration parameters
> - */
> -static const struct reg_sequence g12a_sys_init_regs[] = {
> -	{ .reg = HHI_SYS_PLL_CNTL1,	.def = 0x00000000 },
> -	{ .reg = HHI_SYS_PLL_CNTL2,	.def = 0x00000000 },
> -	{ .reg = HHI_SYS_PLL_CNTL3,	.def = 0x48681c00 },
> -	{ .reg = HHI_SYS_PLL_CNTL4,	.def = 0x88770290 },
> -	{ .reg = HHI_SYS_PLL_CNTL5,	.def = 0x39272000 },
> -	{ .reg = HHI_SYS_PLL_CNTL6,	.def = 0x56540000 },
> +static const struct pll_mult_range g12a_sys_pll_mult_range = {
> +	.min = 128,
> +	.max = 250,
>  };

The init sequence is removed, I suppose you were concerned about
glitching the clock on startup ?

Without the init sequence, it will inherit whatever is left by the
bootloader. We have seen in the past that this is not desirable.

I'm mostly concerned about CNTL3 to CNTL6. Should we apply the sequence
on .set_rate() instead ? It should be safe then ?

>

[...]

>  
> @@ -364,16 +366,50 @@ static struct clk_regmap g12a_cpu_clk_premux1 = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_clk_dyn1_sel",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		.parent_data = (const struct clk_parent_data []) {
>  			{ .fw_name = "xtal", },
>  			{ .hw = &g12a_fclk_div2.hw },
>  			{ .hw = &g12a_fclk_div3.hw },
>  		},
>  		.num_parents = 3,
> +		/* This sub-tree is used a parking clock */
> +		.flags = CLK_SET_RATE_NO_REPARENT
>  	},
>  };
>  
> +#define SYS_CPU_DYN_ENABLE	BIT(26)
> +
> +/* This divider uses bit 26 to take change in account */
> +static int g12a_cpu_clk_mux0_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +					  unsigned long parent_rate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = divider_get_val(rate, parent_rate, div->table, div->width,
> +			      div->flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (unsigned int)ret << div->shift;
> +
> +	regmap_update_bits(clk->map, HHI_SYS_CPU_CLK_CNTL0,
> +			   SYS_CPU_DYN_ENABLE, SYS_CPU_DYN_ENABLE);
> +
> +	return regmap_update_bits(clk->map, div->offset,
> +				  clk_div_mask(div->width) << div->shift |
> +				  SYS_CPU_DYN_ENABLE, val);
> +};
> +
> +const struct clk_ops g12a_cpu_clk_mux0_div_ops = {
> +	.recalc_rate = clk_regmap_div_recalc_rate,
> +	.round_rate = clk_regmap_div_round_rate,
> +	.set_rate = g12a_cpu_clk_mux0_div_set_rate,
> +};

I would prefer if we could keep the clock drivers and clock controllers
separated.

Could you move the above above in another file ?

> +

[...]

>  
> +/* This divider uses bit 26 to take change in account */
> +static int g12b_cpub_clk_mux0_div_set_rate(struct clk_hw *hw,
> +					   unsigned long rate,
> +					   unsigned long parent_rate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = divider_get_val(rate, parent_rate, div->table, div->width,
> +			      div->flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (unsigned int)ret << div->shift;
> +
> +	regmap_update_bits(clk->map, HHI_SYS_CPUB_CLK_CNTL,

Unless I missed something, this function is same as the g12a with the
exception of the register address.

It seems this clock could have its own clock type and its own data
structure to store the 'dyn enable' register parameter.

> +			   SYS_CPU_DYN_ENABLE, SYS_CPU_DYN_ENABLE);
> +
> +	return regmap_update_bits(clk->map, div->offset,
> +				  clk_div_mask(div->width) << div->shift |
> +				  SYS_CPU_DYN_ENABLE, val);
> +};
> +
> +static const struct clk_ops g12b_cpub_clk_mux0_div_ops = {
> +	.recalc_rate = clk_regmap_div_recalc_rate,
> +	.round_rate = clk_regmap_div_round_rate,
> +	.set_rate = g12b_cpub_clk_mux0_div_set_rate,
> +};
> +

[...]

> +
> +static int g12a_cpu_clk_postmux_notifier_cb(struct notifier_block *nb,
> +					    unsigned long event, void *data)
> +{
> +	struct g12a_cpu_clk_postmux_nb_data *nb_data =
> +		container_of(nb, struct g12a_cpu_clk_postmux_nb_data, nb);
> +
> +	switch (event) {
> +	case PRE_RATE_CHANGE:
> +		/*
> +		 * This notifier means cpu_clk_postmux0 clock will be changed
> +		 * to feed cpu_clk, this is the current path :
> +		 * cpu_clk
> +		 *    \- cpu_clk_dyn
> +		 *          \- cpu_clk_postmux0
> +		 *                \- cpu_clk_muxX_div
> +		 *                      \- cpu_clk_premux0
> +		 *				\- fclk_div3 or fclk_div2
> +		 *		OR
> +		 *                \- cpu_clk_premux0
> +		 *			\- fclk_div3 or fclk_div2
> +		 */
> +
> +		/* Setup cpu_clk_premux1 to xtal */
> +		clk_hw_set_parent(nb_data->cpu_clk_premux1,
> +				  nb_data->xtal);
> +
> +		/* Setup cpu_clk_postmux1 to bypass divider */
> +		clk_hw_set_parent(nb_data->cpu_clk_postmux1,
> +				  nb_data->cpu_clk_premux1);
> +
> +		/* Switch to parking clk on cpu_clk_postmux1 */
> +		clk_hw_set_parent(nb_data->cpu_clk_dyn,
> +				  nb_data->cpu_clk_postmux1);
> +
> +		/*
> +		 * Now, cpu_clk is 24MHz in the current path :
> +		 * cpu_clk
> +		 *    \- cpu_clk_dyn
> +		 *          \- cpu_clk_postmux1
> +		 *                \- cpu_clk_premux1
> +		 *                      \- xtal
> +		 */
> +
> +		udelay(100);

Just curious about the this 100us delay. It seems fairly long, even at
24MHz. In your stress tests, have you tried shorter delays ? 10us maybe ?

> +
> +		return NOTIFY_OK;
> +
> +	case POST_RATE_CHANGE:
> +		/*
> +		 * The cpu_clk_postmux0 has ben updated, now switch back
> +		 * cpu_clk_dyn to cpu_clk_postmux0 and take the changes
> +		 * in account.
> +		 */
> +
> +		/* Configure cpu_clk_dyn back to cpu_clk_postmux0 */
> +		clk_hw_set_parent(nb_data->cpu_clk_dyn,
> +				  nb_data->cpu_clk_postmux0);
> +
> +		/*
> +		 * new path :
> +		 * cpu_clk
> +		 *    \- cpu_clk_dyn
> +		 *          \- cpu_clk_postmux0
> +		 *                \- cpu_clk_muxX_div
> +		 *                      \- cpu_clk_premux0
> +		 *				\- fclk_div3 or fclk_div2
> +		 *		OR
> +		 *                \- cpu_clk_premux0
> +		 *			\- fclk_div3 or fclk_div2
> +		 */
> +
> +		udelay(100);
> +
> +		return NOTIFY_OK;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
