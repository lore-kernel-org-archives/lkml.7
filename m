Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D597C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C85820820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfIBMUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:20:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:18247 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfIBMUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:20:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 05:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="181862938"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2019 05:20:32 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i4lJu-0001cz-O7; Mon, 02 Sep 2019 15:20:30 +0300
Date:   Mon, 2 Sep 2019 15:20:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@smile.fi.intel.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20190902122030.GE2680@smile.fi.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190828150951.GS2680@smile.fi.intel.com>
 <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:43:13PM +0800, Tanwar, Rahul wrote:
> On 28/8/2019 11:09 PM, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:

> > >   drivers/clk/intel/Kconfig       |  13 +
> > >   drivers/clk/intel/Makefile      |   4 +
> > Any plans what to do with existing x86 folder there?

> I checked the x86 folder. This driver's clock controller IP is totally
> different than other clock drivers inside x86. So having a common
> driver source is not a option. It is of course possible to move this
> driver inside x86 folder. Please let me know if you think moving
> this driver inside x86 folder makes more sense.

I'm talking about unambiguous folder where we keep Intel's drivers.
With your series it will be confusing x86 vs intel.

> > > +/*
> > > + * Calculate formula:
> > > + * rate = (prate * mult + (prate * frac) / frac_div) / div
> > > + */
> > > +static unsigned long
> > > +intel_pll_calc_rate(unsigned long prate, unsigned int mult,
> > > +		    unsigned int div, unsigned int frac, unsigned int frac_div)
> > > +{
> > > +	u64 crate, frate, rate64;
> > > +
> > > +	rate64 = prate;
> > > +	crate = rate64 * mult;
> > > +
> > > +	if (frac) {
> > This seems unnecessary.
> > I think you would like to check for frac_div instead?
> > Though I would rather to use frac = 0, frac_div = 1 and drop this conditional
> > completely.

> frac_div value is fixed to BIT(24) i.e. always a non zero value. mult & div
> are directly read from registers and by design the register values for
> mult & div is also always a non zero value. However, frac can logically
> be zero. So, I still find if (frac) condition most suitable here.

Then it's simple not needed.

> > > +		frate = rate64 * frac;
> > > +		do_div(frate, frac_div);
> > > +		crate += frate;
> > > +	}
> > > +	do_div(crate, div);
> > > +
> > > +	return (unsigned long)crate;

> > > +	hw = &pll->hw;
> > Seems redundant temporary variable.
> 
> Agree, will update in v2.

Though in another method you have similar pattern. So, perhaps you may leave it
for sake of consistency with patterns.

> > > +	pr_debug("Add clk: %s, id: %u\n", clk_hw_get_name(hw), id);
> > Is this useful?

> Yes, IMO, this proves very useful for system wide clock issues
> debugging during bootup.

You may use function tracer for that.

> > Does val == 0 follows the table, i.e. makes div == 1?
> 
> 0 val means output clock is ref clock i.e. div ==1. Agree that adding
> .val = 0, .div =1 entry will make it more clear & complete.
> 
> > > +	{ .val = 0, .div = 1 },
> > > +	{ .val = 1, .div = 2 },
> > > +	{ .val = 2, .div = 3 },

1

> > > +	{ .val = 3, .div = 4 },
> > > +	{ .val = 4, .div = 5 },
> > > +	{ .val = 5, .div = 6 },

1

> > > +	{ .val = 6, .div = 8 },
> > > +	{ .val = 7, .div = 10 },
> > > +	{ .val = 8, .div = 12 },

2

> > > +	{ .val = 9, .div = 16 },
> > > +	{ .val = 10, .div = 20 },
> > > +	{ .val = 11, .div = 24 },

4

> > > +	{ .val = 12, .div = 32 },
> > > +	{ .val = 13, .div = 40 },
> > > +	{ .val = 14, .div = 48 },

8

> > > +	{ .val = 15, .div = 64 },

16


So, now we see the pattern:

	div = val < 3 ? (val + 1) : (1 << ((val - 3) / 3));

So, can we eliminate table?

-- 
With Best Regards,
Andy Shevchenko


