Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F2B2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfIBMZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:25:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:13637 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbfIBMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:24:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 05:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="194051087"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 02 Sep 2019 05:24:55 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i4lOA-0001f8-HR; Mon, 02 Sep 2019 15:24:54 +0300
Date:   Mon, 2 Sep 2019 15:24:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@smile.fi.intel.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20190902122454.GF2680@smile.fi.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190828150951.GS2680@smile.fi.intel.com>
 <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
 <20190902122030.GE2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902122030.GE2680@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:20:30PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 03:43:13PM +0800, Tanwar, Rahul wrote:
> > On 28/8/2019 11:09 PM, Andy Shevchenko wrote:
> > > On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:

> > > Does val == 0 follows the table, i.e. makes div == 1?
> > 
> > 0 val means output clock is ref clock i.e. div ==1. Agree that adding
> > .val = 0, .div =1 entry will make it more clear & complete.
> > 
> > > > +	{ .val = 0, .div = 1 },
> > > > +	{ .val = 1, .div = 2 },
> > > > +	{ .val = 2, .div = 3 },
> 
> 1
> 
> > > > +	{ .val = 3, .div = 4 },
> > > > +	{ .val = 4, .div = 5 },
> > > > +	{ .val = 5, .div = 6 },
> 
> 1
> 
> > > > +	{ .val = 6, .div = 8 },
> > > > +	{ .val = 7, .div = 10 },
> > > > +	{ .val = 8, .div = 12 },
> 
> 2
> 
> > > > +	{ .val = 9, .div = 16 },
> > > > +	{ .val = 10, .div = 20 },
> > > > +	{ .val = 11, .div = 24 },
> 
> 4
> 
> > > > +	{ .val = 12, .div = 32 },
> > > > +	{ .val = 13, .div = 40 },
> > > > +	{ .val = 14, .div = 48 },
> 
> 8
> 
> > > > +	{ .val = 15, .div = 64 },
> 
> 16
> 
> 
> So, now we see the pattern:
> 
> 	div = val < 3 ? (val + 1) : (1 << ((val - 3) / 3));

It's not complete, but I think you got the idea.

> So, can we eliminate table?

-- 
With Best Regards,
Andy Shevchenko


