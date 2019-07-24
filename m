Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D510229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 11:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGXLoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:44:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:8103 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfGXLoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:44:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 04:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; 
   d="scan'208";a="253579928"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2019 04:44:11 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hqFgo-0006Dw-8S; Wed, 24 Jul 2019 14:44:10 +0300
Date:   Wed, 24 Jul 2019 14:44:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 2/7] backlight: gpio: simplify the platform data
 handling
Message-ID: <20190724114410.GX9224@smile.fi.intel.com>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724082508.27617-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:25:03AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that the last user of platform data (sh ecovec24) defines a proper
> GPIO lookup and sets the 'default-on' device property, we can drop the
> platform_data-specific GPIO handling and unify a big chunk of code.
> 
> The only field used from the platform data is now the fbdev pointer.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 64 +++++-------------------
>  1 file changed, 13 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e84f3087e29f..01262186fa1e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -55,30 +55,6 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> -				   struct gpio_backlight *gbl)
> -{
> -	struct device *dev = &pdev->dev;
> -	enum gpiod_flags flags;
> -	int ret;
> -
> -	gbl->def_value = device_property_read_bool(dev, "default-on");
> -	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> -
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -
> -		if (ret != -EPROBE_DEFER) {
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		}
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata =
> @@ -86,6 +62,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> +	enum gpiod_flags flags;
>  	int ret;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
> @@ -94,35 +71,20 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  
>  	gbl->dev = &pdev->dev;
>  
> -	if (pdev->dev.fwnode) {
> -		ret = gpio_backlight_probe_dt(pdev, gbl);
> -		if (ret)
> -			return ret;
> -	} else if (pdata) {
> -		/*
> -		 * Legacy platform data GPIO retrieveal. Do not expand
> -		 * the use of this code path, currently only used by one
> -		 * SH board.
> -		 */
> -		unsigned long flags = GPIOF_DIR_OUT;
> -
> +	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
> -		gbl->def_value = pdata->def_value;
> -		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
> -
> -		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
> -					    pdata ? pdata->name : "backlight");
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "unable to request GPIO\n");
> -			return ret;
> +
> +	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
> +	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +
> +	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
> +	if (IS_ERR(gbl->gpiod)) {
> +		ret = PTR_ERR(gbl->gpiod);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(&pdev->dev,
> +				"Error: The gpios parameter is missing or invalid.\n");
>  		}
> -		gbl->gpiod = gpio_to_desc(pdata->gpio);
> -		if (!gbl->gpiod)
> -			return -EINVAL;
> -	} else {
> -		dev_err(&pdev->dev,
> -			"failed to find platform data or device tree node.\n");
> -		return -ENODEV;
> +		return ret;
>  	}
>  
>  	memset(&props, 0, sizeof(props));
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


