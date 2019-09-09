Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83E0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C47218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfIILg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:36:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:21481 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfIILg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:36:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 04:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="183793654"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2019 04:36:54 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i7HyW-0007fb-V1; Mon, 09 Sep 2019 14:36:52 +0300
Date:   Mon, 9 Sep 2019 14:36:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 03/13] software node: get rid of property_set_pointer()
Message-ID: <20190909113652.GX2680@smile.fi.intel.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
 <20190909081557.93766-4-dmitry.torokhov@gmail.com>
 <20190909095505.GQ2680@smile.fi.intel.com>
 <20190909101555.GC145199@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909101555.GC145199@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 03:15:55AM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 09, 2019 at 12:55:05PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 09, 2019 at 01:15:47AM -0700, Dmitry Torokhov wrote:
> > > Instead of explicitly setting values of integer types when copying property
> > > entries lets just copy entire value union when processing non-array values.
> > > 
> > > When handling array values assign the pointer there using the newly introduced
> > > "raw" pointer union member. This allows us to remove property_set_pointer().
> > 
> > Is this reincarnation of 318a19718261?
> > Have you read 63dcc7090137?
> 
> Okay, I think if I squash this and the followup patch to
> property_get_data() then we'll only go through the "raw" pointer to get
> to the non-inline data and therefore we will not have the union aliasing
> issue.
> 
> The in-line values never change their type when storing/accessing.

It might work, though it prevents to do type checking at compile time. So,
basically something like

	struct obscure_things {
		u8 *prop_array_val;
		bla bla bla
	};

	struct property_entry entry;
	struct obscure_things things;
	...
	entry.pointer.raw = &things;

which shouldn't be possible.

I dunno what others think about your proposal.

-- 
With Best Regards,
Andy Shevchenko


