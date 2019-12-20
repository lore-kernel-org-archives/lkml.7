Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295A9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AD72467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTKN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:13:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:27828 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbfLTKN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:13:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 02:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="228566117"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 02:13:52 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iiFI8-0000Yx-UM; Fri, 20 Dec 2019 12:13:52 +0200
Date:   Fri, 20 Dec 2019 12:13:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yixin.zhu@linux.intel.com, qi-ming.wu@intel.com,
        rtanwar <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20191220101352.GU32742@smile.fi.intel.com>
References: <cover.1576811332.git.rahul.tanwar@linux.intel.com>
 <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:31:07AM +0800, Rahul Tanwar wrote:
> From: rtanwar <rahul.tanwar@intel.com>
> 
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
> Intel network processor SoC. It provides programming interfaces to control
> & configure all CPU & peripheral clocks. Add common clock framework based
> clock controller driver for CGU.

...

>  drivers/clk/Kconfig           |   8 +

This should be in x86 folder and you perhaps need to add
source "drivers/clk/x86/Kconfig" here.

Also drivers/clk/Makefile should be updated accordingly.

...

> +static int lgm_pll_wait_for_lock(struct lgm_clk_pll *pll)
> +{
> +	int max_loop_cnt = 100;
> +	unsigned long flags;
> +	unsigned int val;
> +
> +	while (max_loop_cnt > 0) {
> +		raw_spin_lock_irqsave(&pll->lock, flags);
> +		val = lgm_get_clk_val(pll->membase, pll->reg, 0, 1);
> +		raw_spin_unlock_irqrestore(&pll->lock, flags);
> +
> +		if (val)
> +			return 0;
> +
> +		udelay(1);
> +		max_loop_cnt--;
> +	}

Looks like a repetition of iopoll.h.
Even without that the waiting loops like this more natural in a form of

	unsigned int count = ...;
	...
	do {
		...
	} while (--count);

> +
> +	return -EIO;
> +}

I think I told you that during internal review.

...

> +void lgm_set_clk_val(void *membase, u32 reg,
> +		     u8 shift, u8 width, u32 set_val)

There is plenty of space, and to be precise it would take exactly 80, on the
previous line.

> +{
> +	u32 mask = (GENMASK(width - 1, 0) << shift);
> +	u32 regval;
> +
> +	regval = readl(membase + reg);
> +	regval = (regval & ~mask) | ((set_val << shift) & mask);
> +	writel(regval, membase + reg);
> +}

...

> +void lgm_clk_add_lookup(struct lgm_clk_provider *ctx,
> +			struct clk_hw *hw, unsigned int id)

Ditto.

...

> +	if (gate->flags & GATE_CLK_HW)
> +		reg = GATE_HW_REG_EN(gate->reg);
> +	else if (gate->flags & GATE_CLK_SW)
> +		reg = gate->reg;
> +	else {
> +		dev_err(gate->dev, "%s has unsupported flags 0x%lx\n",
> +			clk_hw_get_name(hw), gate->flags);
> +		return 0;
> +	}

Missed curly braces in first two conditionals.

...

> +	if (gate->flags & GATE_CLK_HW)
> +		reg = GATE_HW_REG_STAT(gate->reg);
> +	else if (gate->flags & GATE_CLK_SW)
> +		reg = gate->reg;
> +	else {
> +		dev_err(gate->dev, "%s has unsupported flags 0x%lx\n",
> +			clk_hw_get_name(hw), gate->flags);
> +		return 0;
> +	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


