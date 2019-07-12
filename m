Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685BC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49E21537
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfGLFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 01:53:07 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:57404 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGLFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:53:07 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 12 Jul 2019 14:53:03 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 12 Jul 2019 14:53:03 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 12 Jul 2019 14:52:07 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712055207.GB7702@X58A-UD3R>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711130849.GA212044@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> > Finally, I urge you to join with Joel Fernandes and go through these
> > grace-period-duration tuning parameters.  Once you guys get your heads
> > completely around all of them and how they interact across the different
> > possible RCU configurations, I bet that the two of you will have excellent
> > ideas for improvement.
> 
> Yes, I am quite happy to join forces. Byungchul, let me know what about this

I love it. Let's talk later :)

> or other things you had in mind. I have some other RCU topics too I am trying
> to get my head around and planning to work on more patches.

Great.

Thanks,
Byungchul

> Paul, in case you had any other specific tunables or experiments in mind, let
> me know. I am quite happy to try out new experiments and learn something
> based on tuning something.
> 
> thanks,
> 
> - Joel
> 
> 
> 
> > > Thanks,
> > > Byungchul
> > > 
> > > ---8<---
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index e72c184..94b58f5 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3792,10 +3792,6 @@
> > >  			a value based on the most recent settings
> > >  			of rcutree.jiffies_till_first_fqs
> > >  			and rcutree.jiffies_till_next_fqs.
> > > -			This calculated value may be viewed in
> > > -			rcutree.jiffies_to_sched_qs.  Any attempt to set
> > > -			rcutree.jiffies_to_sched_qs will be cheerfully
> > > -			overwritten.
> > >  
> > >  	rcutree.kthread_prio= 	 [KNL,BOOT]
> > >  			Set the SCHED_FIFO priority of the RCU per-CPU
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a2f8ba2..ad9dc86 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -421,10 +421,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >   * How long the grace period must be before we start recruiting
> > >   * quiescent-state help from rcu_note_context_switch().
> > >   */
> > > -static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > +static ulong jiffies_till_sched_qs = ULONG_MAX; /* See adjust_jiffies_till_sched_qs(). */
> > >  module_param(jiffies_till_sched_qs, ulong, 0444);
> > > -static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > >  
> > >  /*
> > >   * Make sure that we give the grace-period kthread time to detect any
> > > @@ -436,18 +434,13 @@ static void adjust_jiffies_till_sched_qs(void)
> > >  {
> > >  	unsigned long j;
> > >  
> > > -	/* If jiffies_till_sched_qs was specified, respect the request. */
> > > -	if (jiffies_till_sched_qs != ULONG_MAX) {
> > > -		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > > -		return;
> > > -	}
> > >  	/* Otherwise, set to third fqs scan, but bound below on large system. */
> > >  	j = READ_ONCE(jiffies_till_first_fqs) +
> > >  		      2 * READ_ONCE(jiffies_till_next_fqs);
> > >  	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > >  		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > >  	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > > -	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > +	WRITE_ONCE(jiffies_till_sched_qs, j);
> > >  }
> > >  
> > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > > @@ -1033,16 +1026,16 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> > >  
> > >  	/*
> > >  	 * A CPU running for an extended time within the kernel can
> > > -	 * delay RCU grace periods: (1) At age jiffies_to_sched_qs,
> > > -	 * set .rcu_urgent_qs, (2) At age 2*jiffies_to_sched_qs, set
> > > +	 * delay RCU grace periods: (1) At age jiffies_till_sched_qs,
> > > +	 * set .rcu_urgent_qs, (2) At age 2*jiffies_till_sched_qs, set
> > >  	 * both .rcu_need_heavy_qs and .rcu_urgent_qs.  Note that the
> > >  	 * unsynchronized assignments to the per-CPU rcu_need_heavy_qs
> > >  	 * variable are safe because the assignments are repeated if this
> > >  	 * CPU failed to pass through a quiescent state.  This code
> > > -	 * also checks .jiffies_resched in case jiffies_to_sched_qs
> > > +	 * also checks .jiffies_resched in case jiffies_till_sched_qs
> > >  	 * is set way high.
> > >  	 */
> > > -	jtsq = READ_ONCE(jiffies_to_sched_qs);
> > > +	jtsq = READ_ONCE(jiffies_till_sched_qs);
> > >  	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> > >  	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> > >  	if (!READ_ONCE(*rnhqp) &&
> > > @@ -3383,7 +3376,8 @@ static void __init rcu_init_geometry(void)
> > >  		jiffies_till_first_fqs = d;
> > >  	if (jiffies_till_next_fqs == ULONG_MAX)
> > >  		jiffies_till_next_fqs = d;
> > > -	adjust_jiffies_till_sched_qs();
> > > +	if (jiffies_till_sched_qs == ULONG_MAX)
> > > +		adjust_jiffies_till_sched_qs();
> > >  
> > >  	/* If the compile-time values are accurate, just leave. */
> > >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> > 
