Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E49C0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C91218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394012AbfIGSDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:03:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:26223 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbfIGSDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:03:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 11:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="335189350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2019 11:03:49 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6f3s-0001D0-9T; Sat, 07 Sep 2019 21:03:48 +0300
Date:   Sat, 7 Sep 2019 21:03:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907180348.GM2680@smile.fi.intel.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
 <20190907163240.GA27112@dtor-ws>
 <20190907171251.GL2680@smile.fi.intel.com>
 <20190907173724.GA145199@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907173724.GA145199@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 10:37:24AM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 07, 2019 at 08:12:51PM +0300, Andy Shevchenko wrote:
> > On Sat, Sep 07, 2019 at 09:32:40AM -0700, Dmitry Torokhov wrote:
> > > On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> > 
> > > > > +	} else if (src->type == DEV_PROP_REF) {
> > > > > +		/* All reference properties must be arrays */
> > > > > +		return -EINVAL;
> > > > 
> > > > Hmm... What about to duplicate pointer under value union and use is_array to
> > > > distinguish which one to use? Because...
> > > 
> > > Then we have to special-case copying this entry, similar to the pains we
> > > are going with the strings.
> > 
> > I can't see it as a pain. Simple do the same kmemdup() for the case when
> > is_array = false and DEV_TYPE_REF?
> 
> And then you need to make sure it is freed on error paths and when we
> remove property entries. This requires more checks and code. In contrast
> we already know how to handle out of line objects of arbitrary size.

We can put it one level up to be a sibling to value / pointer unions.
In that case is_array can be anything (we just don't care).

Actually strings aren't inlined.

> > By the way, don't we need to update property_entry_{get,set}_pointer()?
> 
> I do not see these, where are they?

swnode.c. I meant property_{get,set}_pointer().

> > > > > +	.is_array = true,						\
> > > > 
> > > > I really don't like this "cheating".
> > > 
> > > This is not cheating. Any single value can be represented as an array of
> > > one element. Actually, the only reason we have this "is_array" business
> > > is because for scalar values and short strings it is much cheaper to
> > > store single value in-line instead of out of line + pointer, especially
> > > on 64 bit arches.
> > 
> > Yes, and this is a lot of benefit!
> 
> Yes, nobody argues against it. Here however we are dealing with a larger
> structure. There is absolutely no benefit of trying to separate single
> value vs array here.

Thus, moving to upper layer makes more sense. Right?

> > > If you want we can change is_array into is_inline.
> > 
> > Nope, is_array is exactly what it tells us about the content. Its functional
> > load is to distinguish which union (value vs. pointer) we are using.
> 
> No, it signifies whether the value is stored within property entry or
> outside. I can fit probably 8 bytes arrays into property entry
> structure, in which case is_array will definitely not reflect the data
> type.

Nope, since strings are not inlined AFAICS.

> It is the type-specific accessors that know how to parse and fetch data
> from properties.

-- 
With Best Regards,
Andy Shevchenko


