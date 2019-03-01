Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3344C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47C20838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551411961;
	bh=9pE6BmrMT5M3/Gn9lBUsShN184ArQx3VDrhzm+gdT6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KpBs1pZECROoSGTTniFf+sHqRpyoTiVWRdToQjqAPeYRjqgyGotG0O+TyqRSRA1Vl
	 asid778SKM3lZadd8621KK8U9ZW7DykVerNnD/89VEl6RhmSHZg3wsYgUPgMJjWmSV
	 1iGCc0X0gzmU/Qfq49Pwg+n+Dq0m8w69+txI0zT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfCADpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfCADpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:45:41 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9C320838;
        Fri,  1 Mar 2019 03:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551411940;
        bh=9pE6BmrMT5M3/Gn9lBUsShN184ArQx3VDrhzm+gdT6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4UbDQxDuc/V4YQ4OjFdGdOiS9WcqZPN5leBOHENWGetOWqyjeendyQ8JfiOBQi/x
         D6qH8wOuGklPIqPkydBS85nLFct6S40xhkiyDgraqU61FnIEzh/jQgRpZ/+0sPX4eZ
         CBwZiSzeNqBRozavDndCNHRuMPAvAYTp7CyFJtMM=
Date:   Fri, 1 Mar 2019 04:45:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/37] softirq: Per vector masking v3
Message-ID: <20190301034536.GA19200@lenoir>
References: <20190228171242.32144-1-frederic@kernel.org>
 <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:33:15AM -0800, Linus Torvalds wrote:
> On Thu, Feb 28, 2019 at 9:12 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > So this set should hopefully address all reviews from the v2, and
> > fix all reports from the extremely useful (as always) Kbuild testing
> > bot. It also completes support for all archs.
> 
> The one thing I'd still like to see is some actual performance
> (latency?) numbers.
> 
> Maybe they were hiding somewhere in the pile and my quick scan missed
> them. But the main argument for this was that we've had the occasional
> latency issues with softirqs blocking (eg the USB v4l frame dropping
> etc), and I did that SOFTIRQ_NOW_MASK because it helped one particular
> case.
> 
> And you don't seem to have removed that hack, and I'd really like to
> see that that thing isn't needed any more.
> 
> Because otherwise the whole series seems a bit pointless, don't you
> think? If it doesn't fix that fundamental issue, then what's the point
> of all this churn..

Numbers are indeed missing. In fact this patchset mostly just brings an
infrastructure. We have yet to pinpoint the most latency-inducing
softirq disabled sites and make them disable only the vectors that
are involved in a given lock.

And last but not least, this patchset allows us to soft-interrupt
code that disabled other vectors but it doesn't yet allow us to
soft-interrupt a vector itself. Not much is needed to allow that
from the softirq core code. But we can't do that blindly. For example
TIMER_SOFTIRQ, HRTIMER_SOFTIRQ, TASKLET_SOFTIRQ, NET_RX_SOFTIRQ
can't interrupt each others because some locks can be taken on all
of them (the socket lock for example). Although so many vectors
involved for a single lock is probably rare but still...

The only solution I see to make vectors interruptible is to proceed
the same way as we do for softirq disabled sections: proceed case
by case on a per handler basis. Hopefully we can operate per subsystem
and we don't need to start from drivers.

So the idea is the following: if the lock A can be taken from both TIMER_SOFTIRQ
and BLOCK_SOFTIRQ, we do this from the timer handler for example:

         __do_softirq() {
	     // all vectors disabled
	     run_timers {
	         random_timer_callback() {
                     bh = local_bh_enable_mask(~(TIMER_SOFTIRQ | BLOCK_SOFTIRQ));
                     spin_lock(&A);
                     do_some_work();
                     spin_unlock(&A);
                     local_bh_disable_mask(bh);
		 }
            }
         }

Sounds tedious but that's the only way I can imagine to make that correct.

Another way could be for locks to piggyback the vectors they are involved in
on initialization:

DEFINE_SPINLOCK_SOFTIRQ(A, TIMER_SOFTIRQ | BLOCK_SOFTIRQ);

Then callsites can just use:

    bh = spin_lock_softirq(A);
    ....
    spin_unlock_softirq(A, bh);

Then the lock function always arrange to only disable TIMER_SOFTIRQ | BLOCK_SOFTIRQ
if not nesting, whether we are in a vector or not. The only drawback is for the
relevant spin_lock_t to carry those init flags.

> 
> See commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous"),
> which also has a couple of people listed who could hopefully re-test
> the v4l latency thing with whatever USB capture dongle it was that
> showed the issue.

So in this case for example, I'll need to check the callbacks involved
and make them disable only the vectors that need to be disabled.

I should try to reproduce the issue myself.

Thanks.
