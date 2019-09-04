Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66AF20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFaDXlIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfIDS0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:26:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfIDS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s77u1k+rZJN6iSCbRoduEfOWdKA/7h9aaKfVHtc+CJw=; b=jFaDXlIx/OxYa+ytg8ebhfp27
        E37dN3upZd3PsOfL2E0F81O3rPSaZ0mE6WXgF6HdIizgXHeU26Sk2FQhzSwqGmy+t+TIkCAGovloI
        2OJcrHDs22d9vji2GLvzkeOtd+Hsw/nWV5CHvY2DFwrzIj2iq9CN5CJ3vCvs3VbmzJEpzi3Ytm37F
        YP8BTbGaXiJt1t5+Pa2ukY7KDVMp6tqjfNzn6oRzce2t1olJjZZKwWtU15uV2lCyPgjjqJbhFHvYg
        ep8ljixm4zwNixNS95lKfRbEVfDkU5LxNncNhREXzEEcikdxl1tuc9dFOCtU2xWILl/aJW7wddrKc
        t7Hp916AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Zyk-0002Ja-Ih; Wed, 04 Sep 2019 18:26:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 985D3980BFC; Wed,  4 Sep 2019 20:26:07 +0200 (CEST)
Date:   Wed, 4 Sep 2019 20:26:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck <paulmck@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904182607.GG17205@worktop.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
 <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com>
 <20190904160953.GU2332@hirez.programming.kicks-ass.net>
 <1825272223.1740.1567617173011.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1825272223.1740.1567617173011.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:12:53PM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 4, 2019, at 12:09 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Sep 04, 2019 at 11:19:00AM -0400, Mathieu Desnoyers wrote:
> >> ----- On Sep 3, 2019, at 4:36 PM, Linus Torvalds torvalds@linux-foundation.org
> >> wrote:
> > 
> >> > I wonder if the easiest model might be to just use a percpu variable
> >> > instead for the membarrier stuff? It's not like it has to be in
> >> > 'struct task_struct' at all, I think. We only care about the current
> >> > runqueues, and those are percpu anyway.
> >> 
> >> One issue here is that membarrier iterates over all runqueues without
> >> grabbing any runqueue lock. If we copy that state from mm to rq on
> >> sched switch prepare, we would need to ensure we have the proper
> >> memory barriers between:
> >> 
> >> prior user-space memory accesses  /  setting the runqueue membarrier state
> >> 
> >> and
> >> 
> >> setting the runqueue membarrier state / following user-space memory accesses
> >> 
> >> Copying the membarrier state into the task struct leverages the fact that
> >> we have documented and guaranteed those barriers around the rq->curr update
> >> in the scheduler.
> > 
> > Should be the same as the barriers we already rely on for rq->curr, no?
> > That is, if we put this before switch_mm() then we have
> > smp_mb__after_spinlock() and switch_mm() itself.
> 
> Yes, I think we can piggy-back on the already documented barriers documented around
> rq->curr store.
> 
> > Also, if we place mm->membarrier_state in the same cacheline as mm->pgd
> > (which switch_mm() is bound to load) then we should be fine, I think.
> 
> Yes, if we make sure membarrier_prepare_task_switch only updates the
> rq->membarrier_state if prev->mm != next->mm, we should be able to avoid
> loading next->mm->membarrier_state when switch_mm() is not invoked.
> 
> I'll prepare RFC patch implementing this approach.

Thinking about this a bit; switching it 'on' still requires some
thinking. Consider register on an already threaded process of which
multiple threads are 'current' on multiple CPUs. In that case none of
the rq bits will be set.

Not even synchronize_rcu() is sufficient to force it either, since we
only update on switch_mm() and nothing guarantees we pass that.

One possible approach would be to IPI broadcast (after setting the
->mm->membarrier_State) and having the IPI update the rq state from
'current->mm'.

But possible I'm just confusing evryone again. I'm not having a good day
today.
