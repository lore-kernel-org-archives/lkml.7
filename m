Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C9BC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CB020656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgAILNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:13:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:16395 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgAILNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:13:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="396059012"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 03:13:19 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipVke-0007KJ-9v; Thu, 09 Jan 2020 13:13:20 +0200
Date:   Thu, 9 Jan 2020 13:13:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] pinctrl: intel: Add GPIO <-> pin mapping ranges via
 callback
Message-ID: <20200109111320.GM32742@smile.fi.intel.com>
References: <20200109075329.398347-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109075329.398347-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:53:28AM +0100, Linus Walleij wrote:
> When IRQ chip is instantiated via GPIO library flow, the few functions,
> in particular the ACPI event registration mechanism, on some of ACPI based
> platforms expect that the pin ranges are initialized to that point.
> 
> Add GPIO <-> pin mapping ranges via callback in the GPIO library flow.
> 

Pushed to my review and testing queue, thanks!

> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Please apply this to the Intel pinctrl tree when you're pleased
> with it!
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 35 +++++++++++++++++----------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 4860bc9a4e48..b479bcf1e246 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1160,8 +1160,8 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)
>  	return ret;
>  }
>  
> -static int intel_gpio_add_pin_ranges(struct intel_pinctrl *pctrl,
> -				     const struct intel_community *community)
> +static int intel_gpio_add_community_ranges(struct intel_pinctrl *pctrl,
> +				const struct intel_community *community)
>  {
>  	int ret = 0, i;
>  
> @@ -1181,6 +1181,24 @@ static int intel_gpio_add_pin_ranges(struct intel_pinctrl *pctrl,
>  	return ret;
>  }
>  
> +static int intel_gpio_add_pin_ranges(struct gpio_chip *gc)
> +{
> +	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
> +	int ret, i;
> +
> +	for (i = 0; i < pctrl->ncommunities; i++) {
> +		struct intel_community *community = &pctrl->communities[i];
> +
> +		ret = intel_gpio_add_community_ranges(pctrl, community);
> +		if (ret) {
> +			dev_err(pctrl->dev, "failed to add GPIO pin range\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static unsigned int intel_gpio_ngpio(const struct intel_pinctrl *pctrl)
>  {
>  	const struct intel_community *community;
> @@ -1205,7 +1223,7 @@ static unsigned int intel_gpio_ngpio(const struct intel_pinctrl *pctrl)
>  
>  static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  {
> -	int ret, i;
> +	int ret;
>  
>  	pctrl->chip = intel_gpio_chip;
>  
> @@ -1214,6 +1232,7 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  	pctrl->chip.label = dev_name(pctrl->dev);
>  	pctrl->chip.parent = pctrl->dev;
>  	pctrl->chip.base = -1;
> +	pctrl->chip.add_pin_ranges = intel_gpio_add_pin_ranges;
>  	pctrl->irq = irq;
>  
>  	/* Setup IRQ chip */
> @@ -1231,16 +1250,6 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  		return ret;
>  	}
>  
> -	for (i = 0; i < pctrl->ncommunities; i++) {
> -		struct intel_community *community = &pctrl->communities[i];
> -
> -		ret = intel_gpio_add_pin_ranges(pctrl, community);
> -		if (ret) {
> -			dev_err(pctrl->dev, "failed to add GPIO pin range\n");
> -			return ret;
> -		}
> -	}
> -
>  	/*
>  	 * We need to request the interrupt here (instead of providing chip
>  	 * to the irq directly) because on some platforms several GPIO
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


