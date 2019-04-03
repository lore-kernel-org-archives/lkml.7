Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741E0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E582084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:06:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:16284 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfDCNGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:06:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 06:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="137243453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2019 06:06:41 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hBfbE-0002kQ-LO; Wed, 03 Apr 2019 16:06:40 +0300
Date:   Wed, 3 Apr 2019 16:06:40 +0300
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
Message-ID: <20190403130640.GD9224@smile.fi.intel.com>
References: <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
 <20190328123444.GX3622@lahna.fi.intel.com>
 <CAB4CAwcQTH5BiDDbzfFXTDDuYQ_fuDd_1tKkecf6vwygGQmn5w@mail.gmail.com>
 <20190401074953.GQ3622@lahna.fi.intel.com>
 <CAB4CAweW_3p4i_8ntscJyU9n55HwdLt3pxyT3Gf6SUSbZAJ8qA@mail.gmail.com>
 <20190401122256.GF9224@smile.fi.intel.com>
 <CAB4CAwd6+6+Qwb2wDFkVOc_auTNdrEw07tX2ha=XLvxfwFHRXw@mail.gmail.com>
 <20190402115836.GL9224@smile.fi.intel.com>
 <CAB4CAwe7n5XsRNS-ZoJL1K7dHLpRrwNReBCCMXjDWCtxYaqfdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB4CAwe7n5XsRNS-ZoJL1K7dHLpRrwNReBCCMXjDWCtxYaqfdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:06:43PM +0800, Chris Chiu wrote:
> On Tue, Apr 2, 2019 at 7:58 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

> > Instead you may need to loop over each pin in the part of the group related to
> > one 32-bit HOSTSW_OWN register (i.e. 8, see PADOWN_*() macros in the driver),
> > check if it's requested and break a loop. If loop index is off-by-one a limit,
> > nothing to do, otherwise restore hostown register.
> >
> > More pedantic approach is to collect the mask inside the loop and apply it.
> >
> > The check function name is gpiochip_is_requested().
> >
> > (One of Intel's drivers which is using that at ->resume() is
> >  drivers/gpio/gpio-lynxpoint.c)
> >
> > P.S. I prefer pedantic approach. The simplification one is showed in order to
> > give you an idea.

> Thanks for your great comment. I remove the useless hostown save function
> and make the following change in ->resume() to detect and restore the abnormal
> HOSTSW_OWN. Please help comment if there're still problems. Thanks.

> +               base = community->regs + community->hostown_offset;
> +               for (gpp = 0; gpp < community->ngpps; gpp++) {
> +                       const struct intel_padgroup *padgrp =
> &community->gpps[i];
> +                       unsigned int requested = 0;
> +                       int j;
> +
> +                       if (padgrp->gpio_base < 0)
> +                               continue;

> +
> +                       for (j = 0; j < padgrp->size; j++)
> +                               if
> (gpiochip_is_requested(&pctrl->chip, padgrp->gpio_base + j))
> +                                       requested |= BIT(j);
> +

This better to make as a separate helper function

static u32 intel_gpio_is_requested(chip, base, size)
{
	u32 requested = 0;
	unsigned int i;

	for () {
		if ()
			requested |= BIT();
	}
	return requested;
}

(Note u32 as a type)

> +                       if (requested) {
> +                               if (communities[i].hostown[gpp] !=
> readl(base + gpp * 4)) {
> +
> writel(communities[i].hostown[gpp], base + gpp * 4);

The idea here not to check this at all, but rather apply a mask.

u32 value;

...
value = readl();
value = (value & ~requested) | (hostown[gpp] & requested);
writel(value);

> +                                       dev_warn(dev, "hostown been
> changed during resume\n");
> +                                       dev_dbg(dev, "restored hostown
> %d/%u %#08x\n", i, gpp,
> +                                               readl(base + gpp * 4));
> +                               }
> +                       }
> +               }

-- 
With Best Regards,
Andy Shevchenko


