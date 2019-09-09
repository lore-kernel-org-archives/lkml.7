Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B01C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5FE2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfIIKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:09:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:15074 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfIIKJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:09:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 03:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="196150981"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2019 03:09:19 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i7Gbm-0006RQ-1z; Mon, 09 Sep 2019 13:09:18 +0300
Date:   Mon, 9 Sep 2019 13:09:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190909100918.GS2680@smile.fi.intel.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
 <20190907163240.GA27112@dtor-ws>
 <20190907171251.GL2680@smile.fi.intel.com>
 <20190907173724.GA145199@dtor-ws>
 <20190907180348.GM2680@smile.fi.intel.com>
 <20190907182335.GB145199@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907182335.GB145199@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 11:23:35AM -0700, Dmitry Torokhov wrote:
> On Sat, Sep 07, 2019 at 09:03:48PM +0300, Andy Shevchenko wrote:
> > On Sat, Sep 07, 2019 at 10:37:24AM -0700, Dmitry Torokhov wrote:
> > > On Sat, Sep 07, 2019 at 08:12:51PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Sep 07, 2019 at 09:32:40AM -0700, Dmitry Torokhov wrote:
> > > > > On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> > > > 
> > > > > > > +	} else if (src->type == DEV_PROP_REF) {
> > > > > > > +		/* All reference properties must be arrays */
> > > > > > > +		return -EINVAL;
> > > > > > 
> > > > > > Hmm... What about to duplicate pointer under value union and use is_array to
> > > > > > distinguish which one to use? Because...
> > > > > 
> > > > > Then we have to special-case copying this entry, similar to the pains we
> > > > > are going with the strings.
> > > > 
> > > > I can't see it as a pain. Simple do the same kmemdup() for the case when
> > > > is_array = false and DEV_TYPE_REF?
> > > 
> > > And then you need to make sure it is freed on error paths and when we
> > > remove property entries. This requires more checks and code. In contrast
> > > we already know how to handle out of line objects of arbitrary size.
> > 
> > We can put it one level up to be a sibling to value / pointer unions.
> > In that case is_array can be anything (we just don't care).
> 
> I think it would be better if you sketched out your proposed data
> structure(s) so we are talking about the same things. But please note
> that when you are dealing with property arrays we need to keep the easy
> way of defining them, which means we should not be splitting individual
> entries.

This one:

        union {
                union {
                        const u8 *u8_data;
                        const u16 *u16_data;
                        const u32 *u32_data;
                        const u64 *u64_data;
                        const char * const *str;
                } pointer;
                union {
                        u8 u8_data;
                        u16 u16_data;
                        u32 u32_data;
                        u64 u64_data;
                        const char *str;
                } value;
		struct ... *ref;
        };

-- 
With Best Regards,
Andy Shevchenko


