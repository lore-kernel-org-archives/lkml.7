Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BBDC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A203620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAHU0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:26:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:41770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAHU0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:26:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="223651674"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 12:26:53 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipHuo-0007Zo-5R; Wed, 08 Jan 2020 22:26:54 +0200
Date:   Wed, 8 Jan 2020 22:26:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/2] lib/test_bitmap: Correct test data offsets for
 32-bit
Message-ID: <20200108202654.GJ32742@smile.fi.intel.com>
References: <20200108184611.7065-1-andriy.shevchenko@linux.intel.com>
 <20200108192437.GA13872@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108192437.GA13872@yury-thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:24:37AM -0800, Yury Norov wrote:
> On Wed, Jan 08, 2020 at 08:46:10PM +0200, Andy Shevchenko wrote:
> > On 32-bit platform the size of long is only 32 bits which makes wrong offset
> > in the array of 64 bit size.
> > 
> > Calculate offset based on BITS_PER_LONG.
> > 
> > Fixes: 30544ed5de43 ("lib/bitmap: introduce bitmap_replace() helper")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> >  	unsigned int nbits = 64;
> > +	unsigned int step = DIV_ROUND_UP(nbits, BITS_PER_LONG);
> 
> Step is already defined in this file:
>         #define step (sizeof(u64) / sizeof(unsigned long))

...and later undefined.

> to avoid the same problem in other test cases. Introducing another variant of 
> it looks messy.

I don't see any problem.

> 
> >  	DECLARE_BITMAP(bmap, 1024);
> >  
> >  	bitmap_zero(bmap, 1024);
> > -	bitmap_replace(bmap, &exp2[0], &exp2[1], exp2_to_exp3_mask, nbits);
> > +	bitmap_replace(bmap, &exp2[0 * step], &exp2[1 * step], exp2_to_exp3_mask, nbits);
> >  	expect_eq_bitmap(bmap, exp3_0_1, nbits);
> 
> If nbits is always 64, why don't you pass 64 directly?

We may use any setting. For now it's 64, but nothing prevents us to extend to,
let's say, 75.

-- 
With Best Regards,
Andy Shevchenko


