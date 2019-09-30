Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C182C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4238A215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfI3VU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:20:26 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47562 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfI3VU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:20:26 -0400
X-Greylist: delayed 2444 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 17:20:25 EDT
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D3F613A9B4F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 20:08:11 +0000 (UTC)
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2EA4840002;
        Mon, 30 Sep 2019 20:08:10 +0000 (UTC)
Date:   Mon, 30 Sep 2019 22:08:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20190930200809.GK3913@piout.net>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190108152528.utr3a5huran52gsf@pathway.suse.cz>
 <20190110215858.GG2362@piout.net>
 <20190726132037.GX9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726132037.GX9224@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 16:20:37+0300, Andy Shevchenko wrote:
> On Thu, Jan 10, 2019 at 10:58:58PM +0100, Alexandre Belloni wrote:
> > On 08/01/2019 16:25:28+0100, Petr Mladek wrote:
> > > On Fri 2019-01-04 21:30:06, Andy Shevchenko wrote:
> > > > There are users which print time and date represented by content of
> > > > time64_t type in human readable format.
> > > > 
> > > > Instead of open coding that each time introduce %ptT[dt][r] specifier.
> > > > 
> > > > Few test cases for %ptT specifier has been added as well.
> 
> > > > +void time64_to_rtc_time(time64_t time, struct rtc_time *rtc_time)
> > > > +{
> > > > +#ifdef CONFIG_RTC_LIB
> > > > +	rtc_time64_to_tm(time, rtc_time);
> 
> > > I wonder if the conversion between struct tm and rtc_time
> > > might be useful in general.
> > >
> > > It might make sense to de-duplicate time64_to_tm() and
> > > rtc_time64_to_tm() implementations.
> 
> > Looking at 57f1f0874f42, this seemed to be the plan at the time
> > time_to_tm was introduced but this was never done. Seeing that tm and
> > rtc_time are quite similar, we could probably always use time64_to_tm as
> > it is more accurate than rtc_time64_to_tm as the latter assumes a
> > specific year range.
> 
> So, do I understand correctly that dropping #ifdef along with
> rtc_time64_to_tm() call is sufficient for now?
> 

I'd be fine with that.

> > Maybe be rtc_str should take a struct tm instead of an rtc_time so
> > time64_to_rtc_time always uses time64_to_tm.
> 
> Because this one, while sounding plausible, maybe too invasive on current
> state of affairs.
> 

Well, if the kernel struct tm had an int tm_year instead of long
tm_year, then you could simply cast a struct rtc_time to a struct tm.
I'm not sure was was the rationale to have a long, especially since
userspace has an int.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
