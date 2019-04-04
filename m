Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C66C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE4D2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfDDN73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:59:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:23320 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfDDN72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:59:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 06:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="288679078"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2019 06:59:25 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hC2to-0006C9-Qc; Thu, 04 Apr 2019 16:59:24 +0300
Date:   Thu, 4 Apr 2019 16:59:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over
 suspend/resume
Message-ID: <20190404135924.GV9224@smile.fi.intel.com>
References: <20190328123444.GX3622@lahna.fi.intel.com>
 <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com>
 <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
 <20190401122256.GF9224@smile.fi.intel.com>
 <CAB4CAwd6+6+Qwb2wDFkVOc_auTNdrEw07tX2ha=XLvxfwFHRXw@mail.gmail.com>
 <20190402115836.GL9224@smile.fi.intel.com>
 <CAB4CAwe7n5XsRNS-ZoJL1K7dHLpRrwNReBCCMXjDWCtxYaqfdQ@mail.gmail.com>
 <20190403130640.GD9224@smile.fi.intel.com>
 <CAB4CAweo6uSbn2hY-YbnPqWPBShAYwfGhfOosHL+oL_EE=8L9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB4CAweo6uSbn2hY-YbnPqWPBShAYwfGhfOosHL+oL_EE=8L9A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:06:04PM +0800, Chris Chiu wrote:
> On Wed, Apr 3, 2019 at 9:06 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Apr 03, 2019 at 03:06:43PM +0800, Chris Chiu wrote:
> > > On Tue, Apr 2, 2019 at 7:58 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:

> > This better to make as a separate helper function
> >
> > static u32 intel_gpio_is_requested(chip, base, size)
> > {
> >         u32 requested = 0;
> >         unsigned int i;
> >
> >         for () {
> >                 if ()
> >                         requested |= BIT();
> >         }
> >         return requested;
> > }
> >
> > (Note u32 as a type)
> >
> 
> Thanks. I made a minor modification for the check function. I think to
> pass a padgroup
> as the argument would be better instead of base, size which I may need
> to check if
> the size > 32 (of course it shouldn't happen) or not.

Group size is never bigger than 32 pins.

The helper should be pure GPIO, that's why I still would like to see base
there. Otherwise it would be layering violation.

> +intel_padgroup_has_gpio_requested(struct gpio_chip *chip,  const
> struct intel_padgroup *gpp)

Namespace is intel_gpio_ here.

> +{
> +       u32 requested = 0;
> +       int i;
> +
> +       if (gpp == NULL)
> +               return 0;
> +
> +       if (gpp->gpio_base < 0)
> +               return 0;
> +
> +       for (i = 0; i < gpp->size; i++)
> +               if (gpiochip_is_requested(chip, gpp->gpio_base + i))
> +                       requested |= BIT(i);
> +
> +       return requested;
> +}

> > > +                       if (requested) {
> > > +                               if (communities[i].hostown[gpp] !=
> > > readl(base + gpp * 4)) {
> > > +
> > > writel(communities[i].hostown[gpp], base + gpp * 4);
> >
> > The idea here not to check this at all, but rather apply a mask.
> >
> > u32 value;
> >
> > ...
> > value = readl();
> > value = (value & ~requested) | (hostown[gpp] & requested);
> > writel(value);
> >
> 
> I made the following per your suggestion. So basically I don't need to show a
> warning for the abnormal HOSTSW_OWN value change? I will submit a formal
> patch for review if there's no big problem for these code logic. Please advise
> if any. Thanks.

You still have all data to produce a warning if it's needed.

((value ^ hostown[gpp]) & requested) will return the changed bits.


> +               base = community->regs + community->hostown_offset;
> +               for (gpp = 0; gpp < community->ngpps; gpp++) {
> +                       const struct intel_padgroup *padgrp =
> &community->gpps[i];
> +                       u32 requested =
> intel_padgroup_has_gpio_requested(&pctrl->chip, padgrp);
> +

> +                       if (requested) {

You may not need this check at all.

> +                               u32 value = readl(base + gpp * 4);
> +                               u32 saved = communities[i].hostown[gpp];
> +
> +                               value = (value & ~requested) | (saved
> & requested);
> +                               writel(value, base + gpp * 4);

It's possible to split this as well to another helper function.

static void intel_gpio_update_pad_mode(void __iomem *hostown, u32 mask, u32 value)
{
	...
}

> +                               dev_dbg(dev, "restored hostown %d/%u
> %#08x\n", i, gpp,
> +                                       readl(base + gpp * 4));
> +                       }
> +               }

-- 
With Best Regards,
Andy Shevchenko


