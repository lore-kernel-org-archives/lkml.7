Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030E52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfHTQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:14:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52562 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:14:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i06mH-0002oa-9G; Tue, 20 Aug 2019 18:14:33 +0200
Date:   Tue, 20 Aug 2019 18:14:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/core: Schedule new worker even if PI-blocked
Message-ID: <20190820161433.4v5du5zykycuganr@linutronix.de>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
 <20190820135014.GQ2332@hirez.programming.kicks-ass.net>
 <20190820145926.jhnpwiicv73z6ol3@linutronix.de>
 <20190820152025.GU2349@hirez.programming.kicks-ass.net>
 <20190820155401.c5apbxjntdz5n2gk@linutronix.de>
 <20190820160217.GR2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820160217.GR2369@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20 18:02:17 [+0200], Peter Zijlstra wrote:
> On Tue, Aug 20, 2019 at 05:54:01PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-20 17:20:25 [+0200], Peter Zijlstra wrote:
> 
> > > And am I right in thinking that that, again, is specific to the
> > > sleeping-spinlocks from PREEMPT_RT? Is there really nothing else that
> > > identifies those more specifically? It's been a while since I looked at
> > > them.
> > 
> > Not really. I hacked "int sleeping_lock" into task_struct which is
> > incremented each time a "sleeping lock" version of rtmutex is requested.
> > We have two users as of now:
> > - RCU, which checks if we schedule() while holding rcu_read_lock() which
> >   is okay if it is a sleeping lock.
> > 
> > - NOHZ's pending softirq detection while going to idle. It is possible
> >   that "ksoftirqd" and "current" are blocked on locks and the CPU goes
> >   to idle (because nothing else is runnable) with pending softirqs.
> > 
> > I wanted to let rtmutex invoke another schedule() function in case of a
> > sleeping lock to avoid the RCU warning. This would avoid incrementing
> > "sleeping_lock" in the fast path. But then I had no idea what to do with
> > the NOHZ thing.
> 
> Once upon a time there was also a shadow task->state thing, that was
> specific to the sleeping locks, because normally spinlocks don't muck
> with task->state and so we have code relying on it not getting trampled.
> 
> Can't we use that somewhow? Or is that gone?

we have ->state and ->saved_state. While sleeping on a sleeping lock
->state goes to ->saved_state (usually TASK_RUNNING) and ->state becomes
TASK_UNINTERRUPTIBLE. This is no different compared to regular
blocked-on-I/O wait.
We could add a state, say, TASK_LOCK_BLOCK to identify a task blocking
on sleeping lock. This shouldn't break anything. After all only a
regular "unlock" is allowed to wake such a task and "non-matching" wakes
are redirected to update ->saved_state.

> > > Also, I suppose it would be really good to put that in a comment.
> > So, what does that mean for that patch. According to my inbox it has
> > applied to an "urgent" branch. Do I resubmit the whole thing or just a
> > comment on top?
> 
> Yeah, I'm not sure. I was surprised by that, because afaict all this is
> PREEMPT_RT specific and not really /urgent material in the first place.
> Ingo?

Sebastian
