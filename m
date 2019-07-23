Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097AFC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99BA22543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfGWPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:32:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:2636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfGWPc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:32:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 08:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="180772567"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2019 08:32:52 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpwmY-0004Hw-9w; Tue, 23 Jul 2019 18:32:50 +0300
Date:   Tue, 23 Jul 2019 18:32:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/7] backlight: gpio: simplify the platform data
 handling
Message-ID: <20190723153250.GK9224@smile.fi.intel.com>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-3-brgl@bgdev.pl>
 <20190722160603.GY9224@smile.fi.intel.com>
 <CAMRc=Mfuvh6byfPhPdB51dy_YbAS5scJQT3n3pL_5VZLCjB3Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfuvh6byfPhPdB51dy_YbAS5scJQT3n3pL_5VZLCjB3Hw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:28:00AM +0200, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 18:06 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisał(a):
> >
> > On Mon, Jul 22, 2019 at 05:02:57PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Now that the last user of platform data (sh ecovec24) defines a proper
> > > GPIO lookup and sets the 'default-on' device property, we can drop the
> > > platform_data-specific GPIO handling and unify a big chunk of code.
> > >
> > > The only field used from the platform data is now the fbdev pointer.
> >
> > > -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> > > -                                struct gpio_backlight *gbl)
> > > -{
> > > -     struct device *dev = &pdev->dev;
> > > -     enum gpiod_flags flags;
> > > -     int ret;
> > > -
> > > -     gbl->def_value = device_property_read_bool(dev, "default-on");
> > > -     flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> > > -
> > > -     gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> > > -     if (IS_ERR(gbl->gpiod)) {
> > > -             ret = PTR_ERR(gbl->gpiod);
> > > -
> > > -             if (ret != -EPROBE_DEFER) {
> > > -                     dev_err(dev,
> > > -                             "Error: The gpios parameter is missing or invalid.\n");
> > > -             }
> > > -             return ret;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> >
> > Why not leave this function (perhaps with different name)?
> 
> Why would we do that if the entire probe() function is now less than
> 50 lines long? Also: it gets inlined by the compiler anyway. It
> doesn't make sense IMO.

I'm not against this, perhaps, dropping and moving can be split to two changes.

-- 
With Best Regards,
Andy Shevchenko


