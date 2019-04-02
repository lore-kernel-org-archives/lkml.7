Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DF8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AAD20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lrmcUZV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfDBHK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:10:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oFbTYQs1nrCOUklNEX1eDxL662OWIbNqpOoxYj4/O7w=; b=lrmcUZV8abqLwbMSWnsnaA9lE
        ghI5yd8eAYGJ1lCD6WN/iTnAsrRee3iJxG80ePoaj21RRJ4jnzL2EY+P3td3vOH5HJWW1GVD9aGZh
        xW2PKg63CAR5OE7gV8yazavhXmZmp4WyDLNXiDpZIW+xqPczD3EVDgX0hUWuIeZuogcfwI14x5v0x
        0YHdNQcX67IynpdtEaF/P0mvASUGsbKOPmdMI5SfbHSPn0M+tuKEsGPq1R/CaT8rlDjkMtbQ/JChk
        IqEXqx0+XvBjbTjf7sKlsEbxKOAFd1DOtpG/y3FnRhLnRuGyz73xXVZiMKKxC4yMpJq9uVbvMCAe1
        cY5VFTxYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBDYR-0008VS-RF; Tue, 02 Apr 2019 07:09:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 796FC20072787; Tue,  2 Apr 2019 09:09:53 +0200 (CEST)
Date:   Tue, 2 Apr 2019 09:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Check for wakeup-safe conditions
 in rcu_read_unlock_special()
Message-ID: <20190402070953.GG12232@hirez.programming.kicks-ass.net>
References: <20190329182608.GA23877@linux.ibm.com>
 <20190329182634.24994-2-paulmck@linux.ibm.com>
 <20190401083211.GD11158@hirez.programming.kicks-ass.net>
 <20190401172257.GN4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401172257.GN4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:22:57AM -0700, Paul E. McKenney wrote:
> > > The initial solution to this problem was to use set_tsk_need_resched() and
> > > set_preempt_need_resched() to force a future context switch, which allows
> > > rcu_preempt_note_context_switch() to report the deferred quiescent state
> > > to RCU's core processing.  Unfortunately for expedited grace periods,
> > > there can be a significant delay between the call for a context switch
> > > and the actual context switch.
> > 
> > This is all PREEMPT=y kernels, right? Where is the latency coming from?
> > Because PREEMPT=y _should_ react quite quickly.
> 
> Yes, PREEMPT=y.  It happens like this:
> 
> 1.	rcu_read_lock() with everything enabled.
> 
> 2.	Preemption then resumption.
> 
> 3.	local_irq_disable().
> 
> 4.	rcu_read_unlock().
> 
> 5.	local_irq_enable().
> 
> From what I know, the scheduler doesn't see anything until the next
> interrupt, local_bh_enable(), return to userspace, etc.  Because this
> is PREEMPT=y, preempt_enable() and cond_resched() do nothing.  So
> it could be some time (milliseconds, depending on HZ, NO_HZ_FULL, and
> so on) until the scheduler responds.  With NO_HZ_FULL, last I knew,
> the delay can be extremely long.
> 
> Or am I missing something that gets the scheduler on the job faster?

Oh urgh, yah. So normally we only twiddle with the need_resched state:

 - while preempt_disabl(), such that preempt_enable() will reschedule
 - from interrupt context, such that interrupt return will reschedule

But the usage here 'violates' those rules and then there is an
unspecified latency between setting the state and it getting observed,
but no longer than 1 tick I would think.

I don't think we can go NOHZ with need_resched set, because the moment
we hit the idle loop with that set, we _will_ reschedule.

So in that respect the irq_work suggestion I made would fix things
properly.
