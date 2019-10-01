Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D50C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6C02133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfJALhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:37:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:46171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJALhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:37:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="191434426"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2019 04:36:57 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFGSd-0008Ar-Jv; Tue, 01 Oct 2019 14:36:55 +0300
Date:   Tue, 1 Oct 2019 14:36:55 +0300
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
Message-ID: <20191001113655.GI32742@smile.fi.intel.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190108152528.utr3a5huran52gsf@pathway.suse.cz>
 <20190110215858.GG2362@piout.net>
 <20190726132037.GX9224@smile.fi.intel.com>
 <20190930200809.GK3913@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930200809.GK3913@piout.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 10:08:09PM +0200, Alexandre Belloni wrote:
> On 26/07/2019 16:20:37+0300, Andy Shevchenko wrote:
> > On Thu, Jan 10, 2019 at 10:58:58PM +0100, Alexandre Belloni wrote:
> > > On 08/01/2019 16:25:28+0100, Petr Mladek wrote:
> > > > On Fri 2019-01-04 21:30:06, Andy Shevchenko wrote:
> > > > > There are users which print time and date represented by content of
> > > > > time64_t type in human readable format.
> > > > > 
> > > > > Instead of open coding that each time introduce %ptT[dt][r] specifier.
> > > > > 
> > > > > Few test cases for %ptT specifier has been added as well.
> > 
> > > > > +void time64_to_rtc_time(time64_t time, struct rtc_time *rtc_time)
> > > > > +{
> > > > > +#ifdef CONFIG_RTC_LIB
> > > > > +	rtc_time64_to_tm(time, rtc_time);
> > 
> > > > I wonder if the conversion between struct tm and rtc_time
> > > > might be useful in general.
> > > >
> > > > It might make sense to de-duplicate time64_to_tm() and
> > > > rtc_time64_to_tm() implementations.
> > 
> > > Looking at 57f1f0874f42, this seemed to be the plan at the time
> > > time_to_tm was introduced but this was never done. Seeing that tm and
> > > rtc_time are quite similar, we could probably always use time64_to_tm as
> > > it is more accurate than rtc_time64_to_tm as the latter assumes a
> > > specific year range.
> > 
> > So, do I understand correctly that dropping #ifdef along with
> > rtc_time64_to_tm() call is sufficient for now?
> > 
> 
> I'd be fine with that.

Good, thanks! I'll send v2 soon.

> > > Maybe be rtc_str should take a struct tm instead of an rtc_time so
> > > time64_to_rtc_time always uses time64_to_tm.
> > 
> > Because this one, while sounding plausible, maybe too invasive on current
> > state of affairs.
> 
> Well, if the kernel struct tm had an int tm_year instead of long
> tm_year, then you could simply cast a struct rtc_time to a struct tm.

I don't think so. It will be error prone from endianess prospective on
64-bit platforms.

> I'm not sure was was the rationale to have a long, especially since
> userspace has an int.

Yeah, this is strange, I guess we simple may long -> int in kernel's struct tm.

-- 
With Best Regards,
Andy Shevchenko


