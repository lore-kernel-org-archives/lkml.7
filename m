Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22679C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70BE2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578602804;
	bh=6J063jnpyCXZpSUr94ai5NB8cJFOa/nnW0mo8gZm2qI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=19guQYWtDOuZwwKiPXGVT0ODnUlPWV4RVWLOHMlgCbvJ3J7J+mRSJuFzXr6LXDNRb
	 2VpdaVkqKFH3mnXnCFxw7Jjo2muRSdp4mCRx43XjG5SwJApPMKZCf9Teo2R89JZlE6
	 BSdPWmLbujx5pxG4DBeZaOwIv8V/Z7L+JJv6DAEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgAIUqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgAIUqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:46:42 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA6F820721;
        Thu,  9 Jan 2020 20:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578602801;
        bh=6J063jnpyCXZpSUr94ai5NB8cJFOa/nnW0mo8gZm2qI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TJDZxhO9TM8TPFdfXvYo1lFxFcxpTRV5xGRwmeKBmSoQt0R+JlEb/OFxDywKrjPW9
         K+J+6KU6WVkwk+Ki3GL8GBangaQSkEErFV/A1/MGOj6s96QVP+XSqg6zgvknZ5H/3g
         lzIAwhfKRjeEcKliXGJeBaLLZ7zP8ra5vC8u59Dg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7775D352272E; Thu,  9 Jan 2020 12:46:41 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:46:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rcu 0/2] kcsan: Improvements to reporting
Message-ID: <20200109204641.GW13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200109152322.104466-1-elver@google.com>
 <20200109162739.GS13449@paulmck-ThinkPad-P72>
 <CANpmjNOR4oT+yuGsjajMjWduKjQOGg9Ybd97L2jwY2ZJN8hgqg@mail.gmail.com>
 <20200109173127.GU13449@paulmck-ThinkPad-P72>
 <CANpmjNP=8cfqgXkz7f8D6STTn1-2h9qzUery4qMHeTTeNJOdxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP=8cfqgXkz7f8D6STTn1-2h9qzUery4qMHeTTeNJOdxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 06:42:16PM +0100, Marco Elver wrote:
> On Thu, 9 Jan 2020 at 18:31, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2020 at 06:03:39PM +0100, Marco Elver wrote:
> > > On Thu, 9 Jan 2020 at 17:27, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 09, 2020 at 04:23:20PM +0100, Marco Elver wrote:
> > > > > Improvements to KCSAN data race reporting:
> > > > > 1. Show if access is marked (*_ONCE, atomic, etc.).
> > > > > 2. Rate limit reporting to avoid spamming console.
> > > > >
> > > > > Marco Elver (2):
> > > > >   kcsan: Show full access type in report
> > > > >   kcsan: Rate-limit reporting per data races
> > > >
> > > > Queued and pushed, thank you!  I edited the commit logs a bit, so could
> > > > you please check to make sure that I didn't mess anything up?
> > >
> > > Looks good to me, thank you.
> > >
> > > > At some point, boot-time-allocated per-CPU arrays might be needed to
> > > > avoid contention on large systems, but one step at a time.  ;-)
> > >
> > > I certainly hope the rate of fixing/avoiding data races will not be
> > > eclipsed by the rate at which new ones are introduced. :-)
> >
> > Me too!
> >
> > However, on a large system, duplicate reports might happen quite
> > frequently, which might cause slowdowns given the single global
> > array.  Or maybe not -- I guess we will find out soon enough. ;-)
> >
> > But I must confess that I am missing how concurrent access to the
> > report_times[] array is handled.  I would have expected that
> > rate_limit_report() would choose a random starting entry and
> > search circularly.  And I would expect that the code at the end
> > of that function would instead look something like this:
> >
> >         if (ktime_before(oldtime, invalid_before) &&
> >             cmpxchg(&use_entry->time, oldtime, now) == oldtime) {
> >                 use_entry->frame1 = frame1;
> >                 use_entry->frame2 = frame2;
> >         } else {
> >                 // Too bad, next duplicate report won't be suppressed.
> >         }
> >
> > Where "oldtime" is captured from the entry during the scan, and from the
> > first entry scanned.  This cmpxchg() approach is of course vulnerable
> > to the ->frame1 and ->frame2 assignments taking more than three seconds
> > (by default), but if that becomes a problem, a WARN_ON() could be added:
> >
> >         if (ktime_before(oldtime, invalid_before) &&
> >             cmpxchg(&use_entry->time, oldtime, now) == oldtime) {
> >                 use_entry->frame1 = frame1;
> >                 use_entry->frame2 = frame2;
> >                 WARN_ON_ONCE(use_entry->time != now);
> >         } else {
> >                 // Too bad, next duplicate report won't be suppressed.
> >         }
> >
> > So what am I missing here?
> 
> Ah right, sorry, I should have clarified or commented in the code that
> all of this is happening under 'report_lock' (taken in prepare_report,
> held in print_report->rate_limit_report, released in release_report).
> That also means that any optimization here won't matter until
> report_lock is removed.

Got it, thank you!  And yes, lock contention on report_lock might be
a problem on large systems.  But let's see how it goes.

							Thanx, Paul

> Thanks,
> -- Marco
> 
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > > -- Marco
> > >
> > > >                                                         Thanx, Paul
> > > >
> > > > >  kernel/kcsan/core.c   |  15 +++--
> > > > >  kernel/kcsan/kcsan.h  |   2 +-
> > > > >  kernel/kcsan/report.c | 153 +++++++++++++++++++++++++++++++++++-------
> > > > >  lib/Kconfig.kcsan     |  10 +++
> > > > >  4 files changed, 148 insertions(+), 32 deletions(-)
> > > > >
> > > > > --
> > > > > 2.25.0.rc1.283.g88dfdc4193-goog
> > > > >
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200109162739.GS13449%40paulmck-ThinkPad-P72.
