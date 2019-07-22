Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727CCC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B9218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfGVQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:06:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:20645 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbfGVQGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:06:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 09:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="174264795"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2019 09:06:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpap9-00072x-7M; Mon, 22 Jul 2019 19:06:03 +0300
Date:   Mon, 22 Jul 2019 19:06:03 +0300
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
Subject: Re: [PATCH v2 2/7] backlight: gpio: simplify the platform data
 handling
Message-ID: <20190722160603.GY9224@smile.fi.intel.com>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:02:57PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that the last user of platform data (sh ecovec24) defines a proper
> GPIO lookup and sets the 'default-on' device property, we can drop the
> platform_data-specific GPIO handling and unify a big chunk of code.
> 
> The only field used from the platform data is now the fbdev pointer.

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

Why not leave this function (perhaps with different name)?

-- 
With Best Regards,
Andy Shevchenko


