Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB621721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nz7Usnkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438016AbfFLPgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:36:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437732AbfFLPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ragvtRVA+Mqh9iyg/CWmZlBgAlE+eLvvJcHx4d09eGs=; b=nz7Usnktoyx6H1maX5usbn0lW
        xXNxiVlwlnqYZ7pHdhCqGYsQvQz/McUZZ2XBO5xEdF+qi/JogiJTq55syLsm2XONlK92IAODW9c99
        q0DPMVSHgIjiK27LkF96OYC/qP8uXrgkLJAdvAws7X7fdNCBlKHN6c7U0q5C0ZoWBxhOBkva3XGb4
        dX0Y8rfFA1AyqYZw2H9LJbcVbTSExfxQV3d9DMD9lIsEp5xloHQxhoYW8kdkSKCLCS7FxkSay4kC4
        6zeUJdgaoX07nJbZ1W7G47T+cJlWv4o0kxhEXe63vq/WY/UeDdtAFBamtDLEJR7MqVS91EWM/mNvD
        f+4LCQoCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb5IZ-0008IH-4E; Wed, 12 Jun 2019 15:36:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36AE82097C288; Wed, 12 Jun 2019 17:27:30 +0200 (CEST)
Date:   Wed, 12 Jun 2019 17:27:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
Message-ID: <20190612152730.GI3402@hirez.programming.kicks-ass.net>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net>
 <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
 <CAHmME9oWhWi=Gp2RpM0AOO+_1_24znUxDkz6CyJTc2qRgRRivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oWhWi=Gp2RpM0AOO+_1_24znUxDkz6CyJTc2qRgRRivw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 02:58:21PM +0200, Jason A. Donenfeld wrote:
> Hi Peter,
> 
> Thanks for the explanation.
> 
> On Wed, Jun 12, 2019 at 2:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > Either local_clock() or cpu_clock(cpu). The sleep hooks are not
> > something the consumer has to worry about.
> 
> Alright. Just so long as it *is* tracking sleep, then that's fine. If
> it isn't some important aspects of the protocol will be violated.

The scheduler also cares about how long a task has been sleeping, so
yes, that's automagic.

> > If an architecture doesn't provide a sched_clock(), you're on a
> > seriously handicapped arch. It wraps in ~500 days, and aside from
> > changing jiffies_lock to a latch, I don't think we can do much about it.
> 
> Are you sure? The base definition I'm looking at uses jiffies:
> 
> unsigned long long __weak sched_clock(void)
> {
>         return (unsigned long long)(jiffies - INITIAL_JIFFIES)
>                                         * (NSEC_PER_SEC / HZ);
> }
> 
> On a CONFIG_HZ_1000 machine, jiffies wraps in ~49.7 days:
> >>> ((1<<32)-1)/1000/(60*60*24)
> 49.710269618055555

Bah, I must've done the math wrong (or assumed HZ=100).

> Why not just use get_jiffies_64()? The lock is too costly on 32bit?

Deadlocks when you do get_jiffies_64() from within an update. What would
be an easier update is forcing everyone to use the GENERIC_SCHED_CLOCK
fallback or something like that.

OTOH, changing jiffies_lock to a latch shouldn't be rocket science
either.

> > (the scheduler too expects sched_clock() to not wrap short of the u64
> > and so having those machines online for 500 days will get you 'funny'
> > results)
> 
> Ahh. So if, on the other hand, the whole machine explodes at the wrap
> mark, I guess my silly protocol is the least of concerns, and so this
> shouldn't matter?

That was my thinking...
