Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF2AC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769AD214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfLKOzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:55:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:58148 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfLKOzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:55:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 06:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="210757774"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2019 06:55:36 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1if3Oq-0000T8-PQ; Wed, 11 Dec 2019 16:55:36 +0200
Date:   Wed, 11 Dec 2019 16:55:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: pinctrl-baytrail: Use GPIO direction
 definitions
Message-ID: <20191211145536.GX32742@smile.fi.intel.com>
References: <cover.1576073444.git.matti.vaittinen@fi.rohmeurope.com>
 <67cb73a927b2bf36d9d9f3dd7be5b46119cdbcbc.1576073444.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cb73a927b2bf36d9d9f3dd7be5b46119cdbcbc.1576073444.git.matti.vaittinen@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:33:25PM +0200, Matti Vaittinen wrote:
> Use new GPIO_LINE_DIRECTION_IN and GPIO_LINE_DIRECTION_OUT when
> returning GPIO direction to GPIO framework.

LGTM!

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/pinctrl/intel/pinctrl-baytrail.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
> index 9ffb22211d2b..362276ad5640 100644
> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
> @@ -1160,9 +1160,9 @@ static int byt_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
>  	raw_spin_unlock_irqrestore(&vg->lock, flags);
>  
>  	if (!(value & BYT_OUTPUT_EN))
> -		return 0;
> +		return GPIO_LINE_DIRECTION_OUT;
>  	if (!(value & BYT_INPUT_EN))
> -		return 1;
> +		return GPIO_LINE_DIRECTION_IN;
>  
>  	return -EINVAL;
>  }
> -- 
> 2.21.0
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 

-- 
With Best Regards,
Andy Shevchenko


