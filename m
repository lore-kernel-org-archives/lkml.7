Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555DEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2B217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsJehvDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCJvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:51:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JdytsbbNHMjD0HJ6gS6hPqztk3z9MN7nJ0dAz4AMaEE=; b=XsJehvDz3w9wSsyinCMIUOHND
        E7HdCLprb5ATldnReSQFIXJahDaOIc6/+QxSevXe5CgGlP8G+iZL2mS/utyMneSQ54H3V6iCINaDo
        E3MVUqOGLRooG/CGhvFVrIRDER8fXiIR4SashCXM+Z43znEgkkk8xF+Z0ZZBzVs3pVZC8AJf58cBx
        5MdgA79JmI+fyCFveoZJY20YjfPdOsDqSAOdX/RLEGC9UjpQitG75k8/qMNSNwgwOqijugdUz0QNl
        fX/NJQ+6unk8H39fMwLTWhCsGYTkNsk6Ce5H5pPRKluzqLpPx31y4A/DpyPSdoHabmiZ9JARG/piF
        hC/KRKOvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBcXh-0000HQ-CM; Wed, 03 Apr 2019 09:50:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A19962026BE96; Wed,  3 Apr 2019 11:50:46 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:50:46 +0200
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
Message-ID: <20190403095046.GD4038@hirez.programming.kicks-ass.net>
References: <20190329182608.GA23877@linux.ibm.com>
 <20190329182634.24994-2-paulmck@linux.ibm.com>
 <20190401083211.GD11158@hirez.programming.kicks-ass.net>
 <20190401172257.GN4102@linux.ibm.com>
 <20190402070953.GG12232@hirez.programming.kicks-ass.net>
 <20190402131853.GV4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402131853.GV4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:18:53AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 02, 2019 at 09:09:53AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 01, 2019 at 10:22:57AM -0700, Paul E. McKenney wrote:

> > > Or am I missing something that gets the scheduler on the job faster?
> > 
> > Oh urgh, yah. So normally we only twiddle with the need_resched state:
> > 
> >  - while preempt_disabl(), such that preempt_enable() will reschedule
> >  - from interrupt context, such that interrupt return will reschedule
> > 
> > But the usage here 'violates' those rules and then there is an
> > unspecified latency between setting the state and it getting observed,
> > but no longer than 1 tick I would think.
> 
> In general, yes, which is fine (famous last words) for normal grace
> periods but not so good for expedited grace periods.
> 
> > I don't think we can go NOHZ with need_resched set, because the moment
> > we hit the idle loop with that set, we _will_ reschedule.
> 
> Agreed, and I believe that transitioning to usermode execution also
> gives the scheduler a chance to take action.
> 
> The one exception to this is when a nohz_full CPU running in nohz_full
> mode does a system call that decides to execute for a very long time.
> Last I checked, the scheduling-clock interrupt did -not- get retriggered
> in this case, and the delay could be indefinite, as in bad even for
> normal grace periods.

Right, there is that.

> > So in that respect the irq_work suggestion I made would fix things
> > properly.
> 
> But wouldn't the current use of set_tsk_need_resched(current) followed by
> set_preempt_need_resched() work just as well in that case?  The scheduler
> would react to these at the next scheduler-clock interrupt on their
> own, right?  Or am I being scheduler-naive again?

Well, you have that unspecified delay. By forcing the (self) interrupt
you enforce a timely response.
