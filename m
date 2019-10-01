Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30019C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAD921924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfJAMMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:12:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:51896 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJAMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:12:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 05:11:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="366310897"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2019 05:11:56 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFH0U-0008Ta-Oi; Tue, 01 Oct 2019 15:11:54 +0300
Date:   Tue, 1 Oct 2019 15:11:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 1/4] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20191001121154.GL32742@smile.fi.intel.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190108152528.utr3a5huran52gsf@pathway.suse.cz>
 <20190110215858.GG2362@piout.net>
 <20190726132037.GX9224@smile.fi.intel.com>
 <20190930200809.GK3913@piout.net>
 <20191001113655.GI32742@smile.fi.intel.com>
 <20191001114816.GA4106@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001114816.GA4106@piout.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:48:16PM +0200, Alexandre Belloni wrote:
> On 01/10/2019 14:36:55+0300, Andy Shevchenko wrote:
> > On Mon, Sep 30, 2019 at 10:08:09PM +0200, Alexandre Belloni wrote:
> > > > > Maybe be rtc_str should take a struct tm instead of an rtc_time so
> > > > > time64_to_rtc_time always uses time64_to_tm.
> > > > 
> > > > Because this one, while sounding plausible, maybe too invasive on current
> > > > state of affairs.
> > > 
> > > Well, if the kernel struct tm had an int tm_year instead of long
> > > tm_year, then you could simply cast a struct rtc_time to a struct tm.
> > 
> > I don't think so. It will be error prone from endianess prospective on
> > 64-bit platforms.
> > 
> 
> I don't get why, as long as the first members of both structs are the
> same, this should work.

On BE 64-bit we will always get tm_year == 0, won't we?

-- 
With Best Regards,
Andy Shevchenko


