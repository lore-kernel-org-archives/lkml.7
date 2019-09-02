Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DBE2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfIBHnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:43:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:10451 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfIBHnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:43:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="176255872"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2019 00:43:18 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id 6763F58043A;
        Mon,  2 Sep 2019 00:43:16 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@smile.fi.intel.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190828150951.GS2680@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
Date:   Mon, 2 Sep 2019 15:43:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828150951.GS2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

Thanks for your review comments.

On 28/8/2019 11:09 PM, Andy Shevchenko wrote:
> On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:
>> From: rtanwar <rahul.tanwar@intel.com>
>>
>> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
>> Intel network processor SoC. It provides programming interfaces to control
>> & configure all CPU & peripheral clocks. Add common clock framework based
>> clock controller driver for CGU.
>>   drivers/clk/intel/Kconfig       |  13 +
>>   drivers/clk/intel/Makefile      |   4 +
> Any plans what to do with existing x86 folder there?


I checked the x86 folder. This driver's clock controller IP is totally

different than other clock drivers inside x86. So having a common

driver source is not a option. It is of course possible to move this

driver inside x86 folder. Please let me know if you think moving

this driver inside x86 folder makes more sense.

>> +++ b/drivers/clk/intel/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config INTEL_LGM_CGU_CLK
>> +	depends on COMMON_CLK
>> +	select MFD_SYSCON
>> +	select OF_EARLY_FLATTREE
>> +	bool "Intel Clock Genration Unit support"
> Is it for X86? Don't you need a dependency?


Yes agree, will update in v2.

>> +/*
>> + * Calculate formula:
>> + * rate = (prate * mult + (prate * frac) / frac_div) / div
>> + */
>> +static unsigned long
>> +intel_pll_calc_rate(unsigned long prate, unsigned int mult,
>> +		    unsigned int div, unsigned int frac, unsigned int frac_div)
>> +{
>> +	u64 crate, frate, rate64;
>> +
>> +	rate64 = prate;
>> +	crate = rate64 * mult;
>> +
>> +	if (frac) {
> This seems unnecessary.
> I think you would like to check for frac_div instead?
> Though I would rather to use frac = 0, frac_div = 1 and drop this conditional
> completely.


frac_div value is fixed to BIT(24) i.e. always a non zero value. mult & div

are directly read from registers and by design the register values for

mult & div is also always a non zero value. However, frac can logically

be zero. So, I still find if (frac) condition most suitable here.

>> +		frate = rate64 * frac;
>> +		do_div(frate, frac_div);
>> +		crate += frate;
>> +	}
>> +	do_div(crate, div);
>> +
>> +	return (unsigned long)crate;
>> +}
>> +static struct clk_hw
>> +*intel_clk_register_pll(struct intel_clk_provider *ctx,
> * is part of type.


Yes, will update in v2.

>> +			const struct intel_pll_clk_data *list)
>> +{
>> +	struct clk_init_data init;
>> +	struct intel_clk_pll *pll;
>> +	struct device *dev = ctx->dev;
>> +	struct clk_hw *hw;
>> +	int ret;
>> +
>> +	init.ops = &intel_lgm_pll_ops;
>> +	init.name = list->name;
>> +	init.parent_names = list->parent_names;
>> +	init.num_parents = list->num_parents;
>> +
>> +	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
>> +	if (!pll)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pll->map = ctx->map;
>> +	pll->dev = ctx->dev;
>> +	pll->reg = list->reg;
>> +	pll->flags = list->flags;
>> +	pll->type = list->type;
>> +	pll->hw.init = &init;
>> +
>> +	hw = &pll->hw;
> Seems redundant temporary variable.


Agree, will update in v2.

>> +	ret = clk_hw_register(dev, hw);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return hw;
>> +}
>> +void intel_clk_register_plls(struct intel_clk_provider *ctx,
>> +			     const struct intel_pll_clk_data *list,
>> +				unsigned int nr_clk)
> Indentation issues.


Will fix in v2.

>> +{
>> +	struct clk_hw *hw;
>> +	int i;
>> +
>> +	for (i = 0; i < nr_clk; i++, list++) {
>> +		hw = intel_clk_register_pll(ctx, list);
>> +		if (IS_ERR(hw)) {
>> +			dev_err(ctx->dev, "failed to register pll: %s\n",
>> +				list->name);
> Is it fatal or not?


Agree that its fatal if PLL registration fails, just that its highly 
unlikely.

I will modify it to return error & make probe fail in failure cases.

>> +			continue;
>> +		}
>> +
>> +		intel_clk_add_lookup(ctx, hw, list->id);
>> +	}
> No error to return? Are all PLLs optional?


Will change it to return error code.

>> +}
>> +#endif				/* __INTEL_CLK_PLL_H */
> One TAB is enough.


Will fix in v2.

>> +/*
>> + *  Copyright (C) 2018 Intel Corporation.
>> + *  Zhu YiXin <Yixin.zhu@intel.com>
> On space after asterisk is enough.


Will fix in v2.

>> + */
>> +#define to_intel_clk_divider(_hw) \
>> +			container_of(_hw, struct intel_clk_divider, hw)
> One TAB is enough.


Will fix in v2.

>> +	pr_debug("Add clk: %s, id: %u\n", clk_hw_get_name(hw), id);
> Is this useful?


Yes, IMO, this proves very useful for system wide clock issues

debugging during bootup.

>> +/*
>> + * Below table defines the pair's of regval & effective dividers.
>> + * It's more efficient to provide an explicit table due to non-linear
>> + * relation between values.
>> + */
>> +static const struct clk_div_table pll_div[] = {
> Does val == 0 follows the table, i.e. makes div == 1?


0 val means output clock is ref clock i.e. div ==1. Agree that adding

.val = 0, .div =1 entry will make it more clear & complete.

>> +	{ .val = 1, .div = 2 },
>> +	{ .val = 2, .div = 3 },
>> +	{ .val = 3, .div = 4 },
>> +	{ .val = 4, .div = 5 },
>> +	{ .val = 5, .div = 6 },
>> +	{ .val = 6, .div = 8 },
>> +	{ .val = 7, .div = 10 },
>> +	{ .val = 8, .div = 12 },
>> +	{ .val = 9, .div = 16 },
>> +	{ .val = 10, .div = 20 },
>> +	{ .val = 11, .div = 24 },
>> +	{ .val = 12, .div = 32 },
>> +	{ .val = 13, .div = 40 },
>> +	{ .val = 14, .div = 48 },
>> +	{ .val = 15, .div = 64 },
>> +	{}
>> +};
>> +enum lgm_plls {
>> +	PLL0CZ, PLL0B, PLL1, PLL2, PLLPP, LJPLL3, LJPLL4
> At the end you may put comma just for slightly better maintenance.


Sure, will add.

>> +};
>> +static int __init intel_lgm_cgu_probe(struct platform_device *pdev)
>> +{
>> +	struct intel_clk_provider *ctx;
>> +	struct regmap *map;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	int ret;
>> +
>> +	if (!np)
>> +		return -ENODEV;
> Wouldn't the below fail?
> That said, do you need this check at all?


Agree, that this check is not needed. Will update in v2.

>> +
>> +	map = syscon_node_to_regmap(np);
>> +	if (IS_ERR(map))
>> +		return -ENODEV;
> Why shadow error code?


Yes, will change in v2.

>> +
>> +	ctx = intel_clk_init(dev, map, CLK_NR_CLKS);
>> +	if (IS_ERR(ctx))
>> +		return -ENOMEM;
> Ditto.


Will change in v2.


Regards,

Rahul

>> +}
