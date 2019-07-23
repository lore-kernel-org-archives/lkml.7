Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8599C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfGWP7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:59:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:4808 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfGWP7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:59:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 08:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="368416068"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2019 08:59:46 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hpxCb-0004iG-Mk; Tue, 23 Jul 2019 18:59:45 +0300
Date:   Tue, 23 Jul 2019 18:59:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpio: pch: Use dev_get_drvdata
Message-ID: <20190723155945.GQ9224@smile.fi.intel.com>
References: <20190723083923.21392-1-hslester96@gmail.com>
 <CAMpxmJXkg8wiLOj9rQs+aNx+_oqb_tUWeELmrWQd7GXi-qAueA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJXkg8wiLOj9rQs+aNx+_oqb_tUWeELmrWQd7GXi-qAueA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:49:46AM +0200, Bartosz Golaszewski wrote:
> wt., 23 lip 2019 o 10:39 Chuhong Yuan <hslester96@gmail.com> napisał(a):
> >
> > Instead of using to_pci_dev + pci_get_drvdata,
> > use dev_get_drvdata to make code simpler.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v2:
> >   - Change the subject line to gpio: pch: ...
> >
> >  drivers/gpio/gpio-pch.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> > index 1d99293096f2..3f3d9a94b709 100644
> > --- a/drivers/gpio/gpio-pch.c
> > +++ b/drivers/gpio/gpio-pch.c
> > @@ -409,8 +409,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
> >
> >  static int __maybe_unused pch_gpio_suspend(struct device *dev)
> >  {
> > -       struct pci_dev *pdev = to_pci_dev(dev);
> > -       struct pch_gpio *chip = pci_get_drvdata(pdev);
> > +       struct pch_gpio *chip = dev_get_drvdata(dev);
> >         unsigned long flags;
> >
> >         spin_lock_irqsave(&chip->spinlock, flags);
> > @@ -422,8 +421,7 @@ static int __maybe_unused pch_gpio_suspend(struct device *dev)
> >
> >  static int __maybe_unused pch_gpio_resume(struct device *dev)
> >  {
> > -       struct pci_dev *pdev = to_pci_dev(dev);
> > -       struct pch_gpio *chip = pci_get_drvdata(pdev);
> > +       struct pch_gpio *chip = dev_get_drvdata(dev);
> >         unsigned long flags;
> >
> >         spin_lock_irqsave(&chip->spinlock, flags);
> > --
> > 2.20.1
> >
> 
> Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Pushed to my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko


