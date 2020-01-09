Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B7C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB36B2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAILNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:13:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:39780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgAILNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:13:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="272088379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2020 03:13:42 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipVl1-0007Kb-Ps; Thu, 09 Jan 2020 13:13:43 +0200
Date:   Thu, 9 Jan 2020 13:13:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] pinctrl: intel: Pass irqchip when adding gpiochip
Message-ID: <20200109111343.GN32742@smile.fi.intel.com>
References: <20200109075329.398347-1-linus.walleij@linaro.org>
 <20200109075329.398347-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109075329.398347-2-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:53:29AM +0100, Linus Walleij wrote:
> We need to convert all old gpio irqchips to pass the irqchip
> setup along when adding the gpio_chip. For more info see
> drivers/gpio/TODO.
> 
> For chained irqchips this is a pretty straight-forward conversion.
> 

Pushed to my review and testing queue, thanks!

> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Please apply this to the Intel pinctrl tree when you are
> happy with the result!
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index b479bcf1e246..ffacd77861f7 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1224,6 +1224,7 @@ static unsigned int intel_gpio_ngpio(const struct intel_pinctrl *pctrl)
>  static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  {
>  	int ret;
> +	struct gpio_irq_chip *girq;
>  
>  	pctrl->chip = intel_gpio_chip;
>  
> @@ -1244,16 +1245,9 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  	pctrl->irqchip.irq_set_wake = intel_gpio_irq_wake;
>  	pctrl->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;
>  
> -	ret = devm_gpiochip_add_data(pctrl->dev, &pctrl->chip, pctrl);
> -	if (ret) {
> -		dev_err(pctrl->dev, "failed to register gpiochip\n");
> -		return ret;
> -	}
> -
>  	/*
> -	 * We need to request the interrupt here (instead of providing chip
> -	 * to the irq directly) because on some platforms several GPIO
> -	 * controllers share the same interrupt line.
> +	 * On some platforms several GPIO controllers share the same interrupt
> +	 * line.
>  	 */
>  	ret = devm_request_irq(pctrl->dev, irq, intel_gpio_irq,
>  			       IRQF_SHARED | IRQF_NO_THREAD,
> @@ -1263,14 +1257,20 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
>  		return ret;
>  	}
>  
> -	ret = gpiochip_irqchip_add(&pctrl->chip, &pctrl->irqchip, 0,
> -				   handle_bad_irq, IRQ_TYPE_NONE);
> +	girq = &pctrl->chip.irq;
> +	girq->chip = &pctrl->irqchip;
> +	/* This will let us handle the IRQ in the driver */
> +	girq->parent_handler = NULL;
> +	girq->num_parents = 0;
> +	girq->default_type = IRQ_TYPE_NONE;
> +	girq->handler = handle_bad_irq;
> +
> +	ret = devm_gpiochip_add_data(pctrl->dev, &pctrl->chip, pctrl);
>  	if (ret) {
> -		dev_err(pctrl->dev, "failed to add irqchip\n");
> +		dev_err(pctrl->dev, "failed to register gpiochip\n");
>  		return ret;
>  	}
>  
> -	gpiochip_set_chained_irqchip(&pctrl->chip, &pctrl->irqchip, irq, NULL);
>  	return 0;
>  }
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


