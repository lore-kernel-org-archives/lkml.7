Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128D320874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYD02dGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407612AbfFLM3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:29:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407187AbfFLM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r91Zjq8efp/+LZGF+WxkffUaN7hwd6sA92Jm/gqBIXg=; b=mYD02dGzprnF/jAS9I3p8jTvE
        w84yd/8Ndufssm3+ILJ2+jjJBUFWFie7hClxaEOQQDfhoXTypbv551nhG0C8QHS85n8IErqP9hdMR
        YD76VA6qYdknTI+WAbkq8wtzweSZjU57DbOa1I0gVSrKpIueLzV6nGEUU22srY1kJTdoAjran+jZk
        aFI2hb/sMqy+NFSbvmeoy/O/uzh2B6s10XklY1+domZGOb6Dn9apG+p/tY3dg94P20woNHMN5JHju
        w85OTed+8S4ms/5VjRE1GhUPsRJ4AgyUBRdINwR46Tr4Zo/rUcpVvZKHtqtZbGlyU9KrG0NM3Yo/9
        EtN/9MYFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb2N3-00061A-En; Wed, 12 Jun 2019 12:28:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33F92203BF963; Wed, 12 Jun 2019 14:28:43 +0200 (CEST)
Date:   Wed, 12 Jun 2019 14:28:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
Message-ID: <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net>
 <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:44:35AM +0200, Jason A. Donenfeld wrote:
> Hey Peter,
> 
> On Wed, Jun 12, 2019 at 11:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > How quasi? Do the comments in kernel/sched/clock.c look like something
> > you could use?
> >
> > As already mentioned in the other tasks, anything ktime will be
> > horrifically crap when it ends up using the HPET, the code in
> > kernel/sched/clock.c is a best effort to keep using TSC even when it is
> > deemed unusable for timekeeping.
> 
> Thanks for pointing that out. Indeed the HPET path is a bummer and I'd
> like to just escape using ktime all together.
> 
> In fact, my accuracy requirements are very lax. I could probably even
> deal with an inaccuracy as huge as ~200 milliseconds. But what I do
> need is 64-bit, so that it doesn't wrap, allowing me to compare two
> stamps taken a long time apart, and for it to take into account sleep
> time, like CLOCK_BOOTTIME does, which means get_jiffies_64() doesn't
> fit the bill. I was under the impression that I could only get this
> with ktime_get_boot & co, because those add the sleep offset.
> 
> It looks like, though, kernel/sched/clock.c keeps track of some
> offsets too -- __sched_clock_offset and __gtod_offset,

Right, those are used to keep the clock values coherent (as best as
possible) when we switch modes.

When the TSC is stable sched_clock_cpu() is mapped directly to
sched_clock() for performance reasons. The moment the TSC is detected to
be unsuitable, we switch to the unstable mode, where we take a GTOD
timestamp every tick and add resolution with the CPU local TSC (plus
filters etc..).

To make this mode-switch as smooth as possible, we track those offsets.

> and the comment at the top mentions explicit sleep hooks. I wasn't
> sure which function to use from here, though. 

Either local_clock() or cpu_clock(cpu). The sleep hooks are not
something the consumer has to worry about.

> sched_clock() seems based on jiffies, which
> has the 32-bit wraparound issue, and the base implementation doesn't
> seem to take into account sleeptime. The x86 implementation seems use
> rdtsc and then adds cyc2ns_offset which looks to be based on
> cyc2ns_suspend, which I assume is what I want. 

Yes.

> But there's still the
> issue of the 32-bit wraparound on the base implementation.

If an architecture doesn't provide a sched_clock(), you're on a
seriously handicapped arch. It wraps in ~500 days, and aside from
changing jiffies_lock to a latch, I don't think we can do much about it.

(the scheduler too expects sched_clock() to not wrap short of the u64
and so having those machines online for 500 days will get you 'funny'
results)

AFAICT only: alpha, h8300, hexagon, m68knommu, nds32, nios2, openrisc
are lacking any form of sched_clock(), the rest has it either natively
or through sched_clock_register().

> I guess you know this code better than my quick perusal. Is there some
> clock in here that doesn't have a wrap around issue and takes into
> account sleeptime, without being super slow like ktime/hpet?

You probably want to use local_clock().

