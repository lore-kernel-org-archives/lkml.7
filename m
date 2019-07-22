Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F43AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B937218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfGVQJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:09:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:17126 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:09:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 09:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="252950881"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2019 09:09:52 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpaso-00075z-Qx; Mon, 22 Jul 2019 19:09:50 +0300
Date:   Mon, 22 Jul 2019 19:09:50 +0300
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
Subject: Re: [PATCH v2 0/7] backlight: gpio: simplify the driver
Message-ID: <20190722160950.GA9224@smile.fi.intel.com>
References: <20190722150302.29526-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150302.29526-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:02:55PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
> 
> The first patch adds all necessary data structures to ecovec24. Patch
> 2/7 unifies much of the code for both pdata and non-pdata cases. Patches
> 3-4/7 remove unused platform data fields. Last three patches contain
> additional improvements for the GPIO backlight driver while we're already
> modifying it.
> 
> I don't have access to this HW but hopefully this works. Only compile
> tested.
> 
> [1] https://lkml.org/lkml/2019/6/25/900

For uncommented ones
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> v1 -> v2:
> - rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
> - added additional two patches with minor improvements
> 
> Bartosz Golaszewski (7):
>   sh: ecovec24: add additional properties to the backlight device
>   backlight: gpio: simplify the platform data handling
>   sh: ecovec24: don't set unused fields in platform data
>   backlight: gpio: remove unused fields from platform data
>   backlight: gpio: remove dev from struct gpio_backlight
>   backlight: gpio: remove def_value from struct gpio_backlight
>   backlight: gpio: use a helper variable for &pdev->dev
> 
>  arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++--
>  drivers/video/backlight/gpio_backlight.c     | 87 ++++++--------------
>  include/linux/platform_data/gpio_backlight.h |  3 -
>  3 files changed, 48 insertions(+), 75 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


