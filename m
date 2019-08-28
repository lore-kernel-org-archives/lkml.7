Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF402C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CB322CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfH1PJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:09:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:53284 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfH1PJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:09:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 08:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="185651765"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2019 08:09:54 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i2za3-0001Da-Qk; Wed, 28 Aug 2019 18:09:51 +0300
Date:   Wed, 28 Aug 2019 18:09:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@smile.fi.intel.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20190828150951.GS2680@smile.fi.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:
> From: rtanwar <rahul.tanwar@intel.com>
> 
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
> Intel network processor SoC. It provides programming interfaces to control
> & configure all CPU & peripheral clocks. Add common clock framework based
> clock controller driver for CGU.

>  drivers/clk/intel/Kconfig       |  13 +
>  drivers/clk/intel/Makefile      |   4 +

Any plans what to do with existing x86 folder there?

> +++ b/drivers/clk/intel/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config INTEL_LGM_CGU_CLK
> +	depends on COMMON_CLK
> +	select MFD_SYSCON
> +	select OF_EARLY_FLATTREE
> +	bool "Intel Clock Genration Unit support"

Is it for X86? Don't you need a dependency?

> +/*
> + * Calculate formula:
> + * rate = (prate * mult + (prate * frac) / frac_div) / div
> + */
> +static unsigned long
> +intel_pll_calc_rate(unsigned long prate, unsigned int mult,
> +		    unsigned int div, unsigned int frac, unsigned int frac_div)
> +{
> +	u64 crate, frate, rate64;
> +
> +	rate64 = prate;
> +	crate = rate64 * mult;
> +

> +	if (frac) {

This seems unnecessary.
I think you would like to check for frac_div instead?
Though I would rather to use frac = 0, frac_div = 1 and drop this conditional
completely.

> +		frate = rate64 * frac;
> +		do_div(frate, frac_div);
> +		crate += frate;
> +	}
> +	do_div(crate, div);
> +
> +	return (unsigned long)crate;
> +}

> +static struct clk_hw

> +*intel_clk_register_pll(struct intel_clk_provider *ctx,

* is part of type.

> +			const struct intel_pll_clk_data *list)
> +{
> +	struct clk_init_data init;
> +	struct intel_clk_pll *pll;
> +	struct device *dev = ctx->dev;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	init.ops = &intel_lgm_pll_ops;
> +	init.name = list->name;
> +	init.parent_names = list->parent_names;
> +	init.num_parents = list->num_parents;
> +
> +	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pll->map = ctx->map;
> +	pll->dev = ctx->dev;
> +	pll->reg = list->reg;
> +	pll->flags = list->flags;
> +	pll->type = list->type;
> +	pll->hw.init = &init;
> +

> +	hw = &pll->hw;

Seems redundant temporary variable.

> +	ret = clk_hw_register(dev, hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return hw;
> +}

> +void intel_clk_register_plls(struct intel_clk_provider *ctx,
> +			     const struct intel_pll_clk_data *list,
> +				unsigned int nr_clk)

Indentation issues.

> +{
> +	struct clk_hw *hw;
> +	int i;
> +
> +	for (i = 0; i < nr_clk; i++, list++) {
> +		hw = intel_clk_register_pll(ctx, list);
> +		if (IS_ERR(hw)) {

> +			dev_err(ctx->dev, "failed to register pll: %s\n",
> +				list->name);

Is it fatal or not?

> +			continue;
> +		}
> +
> +		intel_clk_add_lookup(ctx, hw, list->id);
> +	}

No error to return? Are all PLLs optional?

> +}

> +#endif				/* __INTEL_CLK_PLL_H */

One TAB is enough.

> +/*
> + *  Copyright (C) 2018 Intel Corporation.
> + *  Zhu YiXin <Yixin.zhu@intel.com>

On space after asterisk is enough.

> + */

> +#define to_intel_clk_divider(_hw) \
> +			container_of(_hw, struct intel_clk_divider, hw)

One TAB is enough.

> +	val >>= shift;
> +	val &= BIT(width) - 1;
> +
> +	return val;

Can be one line, though up to you.

> +	pr_debug("Add clk: %s, id: %u\n", clk_hw_get_name(hw), id);

Is this useful?

> +static struct clk_hw

> +*intel_clk_register_fixed(struct intel_clk_provider *ctx,

* is part of the type.

> +			  const struct intel_clk_branch *list)

> +static struct clk_hw

> +*intel_clk_register_fixed_factor(struct intel_clk_provider *ctx,

Ditto.

> +				 const struct intel_clk_branch *list)

> +static struct clk_hw

> +*intel_clk_register_gate(struct intel_clk_provider *ctx,

Ditto.

> +			 const struct intel_clk_branch *list)

> +/*
> + * Below table defines the pair's of regval & effective dividers.
> + * It's more efficient to provide an explicit table due to non-linear
> + * relation between values.
> + */
> +static const struct clk_div_table pll_div[] = {

Does val == 0 follows the table, i.e. makes div == 1?

> +	{ .val = 1, .div = 2 },
> +	{ .val = 2, .div = 3 },
> +	{ .val = 3, .div = 4 },
> +	{ .val = 4, .div = 5 },
> +	{ .val = 5, .div = 6 },
> +	{ .val = 6, .div = 8 },
> +	{ .val = 7, .div = 10 },
> +	{ .val = 8, .div = 12 },
> +	{ .val = 9, .div = 16 },
> +	{ .val = 10, .div = 20 },
> +	{ .val = 11, .div = 24 },
> +	{ .val = 12, .div = 32 },
> +	{ .val = 13, .div = 40 },
> +	{ .val = 14, .div = 48 },
> +	{ .val = 15, .div = 64 },
> +	{}
> +};

> +enum lgm_plls {
> +	PLL0CZ, PLL0B, PLL1, PLL2, PLLPP, LJPLL3, LJPLL4

At the end you may put comma just for slightly better maintenance.

> +};

> +static int __init intel_lgm_cgu_probe(struct platform_device *pdev)
> +{
> +	struct intel_clk_provider *ctx;
> +	struct regmap *map;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +

> +	if (!np)
> +		return -ENODEV;

Wouldn't the below fail?
That said, do you need this check at all?

> +
> +	map = syscon_node_to_regmap(np);
> +	if (IS_ERR(map))

> +		return -ENODEV;

Why shadow error code?

> +
> +	ctx = intel_clk_init(dev, map, CLK_NR_CLKS);
> +	if (IS_ERR(ctx))

> +		return -ENOMEM;

Ditto.

> +}

-- 
With Best Regards,
Andy Shevchenko


