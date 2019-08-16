Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C2C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8E7206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfHPVRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:17:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43308 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfHPVRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:17:30 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyjbD-00019X-93; Fri, 16 Aug 2019 23:17:27 +0200
Date:   Fri, 16 Aug 2019 23:17:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arul,

On Fri, 16 Aug 2019, Arul Jeniston wrote:

> Adding few more data points...

Can you please trim your replies? It's annoying to have to search for the
meat of your mail by scrolling down several pages and paying attention to
not skip something useful inside of useless information.

> On Fri, Aug 16, 2019 at 10:25 PM Arul Jeniston <arul.jeniston@gmail.com> wrote:
> > On Fri, Aug 16, 2019 at 4:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > We use CLOCK_REALTIME while creating timer_fd.
> > Can read() on timerfd return 0 when the clock is set to CLOCK_REALTIME?

As CLOCK_REALTIME is subject to be set by various mechanisms, yes. See
timerfd_clock_was_set(). If that's the case, your application is missing
something. But see below ...

> > We have Intel rangely 4 cpu system running debian stretch linux
> > kernel. The current clock source is set to tsc. During our testing, we
> > observed the time drifts backward occasionally. Through kernel
> > instrumentation, we observed, sometimes clocksource_delta() finds the
> > current time lesser than last time. and returns 0 delta.

That has absolutely nothing to do with CLOCK_REALTIME. Your machines TSC is
either going backwards or not synchronized between cores.

Hint: Dell has a track record of BIOS doing the wrong things to TSC in
order to hide their 'value add' features stealing CPU time.

> This causes the following code flow to return a time which is lesser
> than previously fetched time.
> ktime_get()-->timekeeping_get_ns()-->timekeeping_get_delta()-->clocksource_delta()

ktime_get() is CLOCK_MONOTONIC and not CLOCK_REALTIME.
 
> Since ktime_get() returns a time which is lesser than the expiry time,
> hrtimer_forward_now return 0.
> This in-turn causes timerfd_read to return 0.
> Is it not a bug?

It's a bug, but either a hardware or a BIOS bug and you are trying to paper
over it at the place where you observe the symptom, which is obviously the
wrong place because:

 1) Any other time related function even in timerfd is affected as well

 2) We do not cure symptoms, we cure the root cause. And clearly the root
    cause hase not been explained and addressed.

Thanks,

	tglx
