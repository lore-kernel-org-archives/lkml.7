Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4953BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B37820644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392360AbfFMQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:26:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733022AbfFMQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:26:26 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbSYP-0001xt-72; Thu, 13 Jun 2019 18:26:21 +0200
Date:   Thu, 13 Jun 2019 18:26:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
In-Reply-To: <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com> <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de> <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com> <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com> <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
 <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
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

On Thu, 13 Jun 2019, Jason A. Donenfeld wrote:
> Hey Arnd,
> 
> On Thu, Jun 13, 2019 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > A seqlock is a very cheap synchronization primitive, I would actually
> > guess that this is faster than most implementations of sched_clock()
> > that access a hardware register for reading the time.
> 
> It appears to me that ktime_get_coarse_boottime() has a granularity of
> a whole second, which is a lot worse than jiffies. Looking at the
> source, you assign base but don't then add ns like the other
> functions. At first I thought this was an intentional quirk to avoid
> hitting the slow hardware paths. But noticing this poor granularity
> now and observing that there's actually a blank line (\n\n) where the
> nanosecond addition normally would be, I wonder if something was lost
> in cut-and-paste?
> 
> I'm still poking around trying to see what's up. As a quick test,
> running this on every packet during a high speed test shows the left
> incrementing many times per second, whereas the right increments once
> per second:
> 
> static int x = 0;
> if (!(x++ % 30000))
>      pr_err("%llu %llu\n", local_clock(), ktime_get_coarse_boottime());

That does not make sense. The coarse time getters use
tk->tkr_mono.base. base is updated every tick (or if the machine is
completely idle right when the first CPU wakes up again).

timekeeping_get_ns() which is added in ktime_get_boottime() is the time in
ns elapsed since base was updated last, which is less than a tick.

Thanks,

	tglx
