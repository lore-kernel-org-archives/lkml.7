Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDZVsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:48:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:10130 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfDZVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:48:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 14:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,399,1549958400"; 
   d="scan'208";a="341182723"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2019 14:47:59 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK8hK-0003AJ-Gf; Sat, 27 Apr 2019 00:47:58 +0300
Date:   Sat, 27 Apr 2019 00:47:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        hotwater438@tutanota.com, hdegoede@redhat.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: intel: Clear interrupt status in unmask callback
Message-ID: <20190426214758.GC9224@smile.fi.intel.com>
References: <20190422044539.16085-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422044539.16085-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:45:39PM +0800, Kai-Heng Feng wrote:
> Commit a939bb57cd47 ("pinctrl: intel: implement gpio_irq_enable") was
> added because clearing interrupt status bit is required to avoid
> unexpected behavior.
> 
> Turns out the unmask callback also needs the fix, which can solve weird
> IRQ triggering issues on I2C touchpad ELAN1200.

> -static void intel_gpio_irq_enable(struct irq_data *d)
> -{
> -	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> -	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
> -	const struct intel_community *community;
> -	const struct intel_padgroup *padgrp;
> -	int pin;
> -
> -	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
> -	if (pin >= 0) {
> -		unsigned int gpp, gpp_offset, is_offset;
> -		unsigned long flags;
> -		u32 value;
> -
> -		gpp = padgrp->reg_num;
> -		gpp_offset = padgroup_offset(padgrp, pin);
> -		is_offset = community->is_offset + gpp * 4;
> -
> -		raw_spin_lock_irqsave(&pctrl->lock, flags);
> -		/* Clear interrupt status first to avoid unexpected interrupt */
> -		writel(BIT(gpp_offset), community->regs + is_offset);
> -
> -		value = readl(community->regs + community->ie_offset + gpp * 4);
> -		value |= BIT(gpp_offset);
> -		writel(value, community->regs + community->ie_offset + gpp * 4);
> -		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> -	}
> -}
> -
>  static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> @@ -963,6 +934,11 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
>  		reg = community->regs + community->ie_offset + gpp * 4;
>  
>  		raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +		/* Clear interrupt status first to avoid unexpected interrupt */

> +		if (!mask)

Can we do this unconditionally?

> +			writel(BIT(gpp_offset), community->regs + community->is_offset + gpp * 4);

I would rather prefer to follow the below pattern, like

reg = ...;
writel(..., reg);

or, to decrease calculus under spin lock, something like

reg = ->regs + gpp * 4;

writel(..., reg + is_offset);

readl(reg + ie_offset);

etc.

> +
>  		value = readl(reg);
>  		if (mask)
>  			value &= ~BIT(gpp_offset);
> @@ -1106,7 +1082,6 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)
>  
>  static struct irq_chip intel_gpio_irqchip = {
>  	.name = "intel-gpio",

> -	.irq_enable = intel_gpio_irq_enable,

Is it possible scenario when IRQ enable is called, but not masking callbacks?
For _AEI or GPE?

>  	.irq_ack = intel_gpio_irq_ack,
>  	.irq_mask = intel_gpio_irq_mask,
>  	.irq_unmask = intel_gpio_irq_unmask,

-- 
With Best Regards,
Andy Shevchenko


