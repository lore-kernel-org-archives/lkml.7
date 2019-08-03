Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14CC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2616E206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfHCTrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 15:47:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbfHCTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:47:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x73Jfkej138445;
        Sat, 3 Aug 2019 15:46:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u56dwgprs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Aug 2019 15:46:13 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x73JjHnQ144606;
        Sat, 3 Aug 2019 15:46:13 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u56dwgprd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Aug 2019 15:46:13 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x73JidHx007024;
        Sat, 3 Aug 2019 19:46:12 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2u51w6cyp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Aug 2019 19:46:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x73JkB8p46465390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 3 Aug 2019 19:46:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3F4B206B;
        Sat,  3 Aug 2019 19:46:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D18FAB2064;
        Sat,  3 Aug 2019 19:46:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.228])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  3 Aug 2019 19:46:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B070F16C1B1C; Sat,  3 Aug 2019 12:46:11 -0700 (PDT)
Date:   Sat, 3 Aug 2019 12:46:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/11] rcu/nocb: Provide separate no-CBs
 grace-period kthreads
Message-ID: <20190803194611.GB28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801225009.GA17155@linux.ibm.com>
 <20190801225028.18225-3-paulmck@linux.ibm.com>
 <20190803174127.GA83025@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803174127.GA83025@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908030233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 01:41:27PM -0400, Joel Fernandes wrote:
> On Thu, Aug 01, 2019 at 03:50:20PM -0700, Paul E. McKenney wrote:
> > Currently, there is one no-CBs rcuo kthread per CPU, and these kthreads
> > are divided into groups.  The first rcuo kthread to come online in a
> > given group is that group's leader, and the leader both waits for grace
> > periods and invokes its CPU's callbacks.  The non-leader rcuo kthreads
> > only invoke callbacks.
> > 
> > This works well in the real-time/embedded environments for which it was
> > intended because such environments tend not to generate all that many
> > callbacks.  However, given huge floods of callbacks, it is possible for
> > the leader kthread to be stuck invoking callbacks while its followers
> > wait helplessly while their callbacks pile up.  This is a good recipe
> > for an OOM, and rcutorture's new callback-flood capability does generate
> > such OOMs.
> > 
> > One strategy would be to wait until such OOMs start happening in
> > production, but similar OOMs have in fact happened starting in 2018.
> > It would therefore be wise to take a more proactive approach.
> 
> I haven't looked much into nocbs/nohz_full stuff (yet). In particular, I did
> not even know that the rcuo threads do grace period life-cycle management and
> waiting, I thought only the RCU GP threads did :-/. however, it seems this is
> a completely separate grace-period management state machine outside of the
> RCU GP thread right?

No, the rcuo kthreads interact with the main RCU GP kthread, initiating
new grace periods when needed and being awakened as needed by the RCU
GP kthread.

> I was wondering for this patch, could we also just have the rcuo
> leader handle both callback execution and waking other non-leader threads at
> the same time? So like, execute few callbacks, then do the wake up of the
> non-leaders to execute their callbacks, the get back to executing their own
> callbacks, etc. That way we don't need a separate rcuog thread to wait for
> grace period, would that not work?

I did look into that, but it was more complex and also didn't foster
sharing of rcu_do_batch(), which used to only be for non-offloaded
callbacks but now does both.  Besides which, invoking callbacks would
degrade the rcuog kthread's response to new callbacks and the like.

> If you don't mind could you share with me a kvm.sh command (which has config,
> boot parameters etc) that can produce the OOM without this patch? I'd
> like to take a closer look at it.

Here you go:

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 120 --configs TREE04

If you add "--memory 1G" in mainline, the OOMs go away.  Or at least
decrease substantially in probability.

> Is there also a short answer for my the RCU GP thread cannot do the job of
> these new rcuog threads?

First, the code is more complicated when you do it that way (and yes,
I did actually write it out in pen on paper).  Second, if the CPU
corresponding to the combined grace-period/callback kthread is doing the
call_rcu() flooding, you are between a rock and a hard place.  On the
one hand, you want that kthread to do nothing but invoke callbacks so
as to have half a chance of keeping up, and on the other hand you need
it to check state frequently so as to react in a timely fashion to a
CPU corresponding to one of its callback kthreads starting a second
callback flood.

Introducing rcug grace-period-only kthreads means that you get the best of
both worlds.  Plus last year's flavor consolidation decreased the number
of rcuo kthreads from either 2N or 3N to N, so increasing it to only
(N + sqrt(N)) should be just fine.  Though I would expect that there
will be at least some screaming and shouting.  ;-)

							Thanx, Paul

> thanks a lot,
> 
>  - Joel
> 
> 
> > This commit therefore features per-CPU rcuo kthreads that do nothing
> > but invoke callbacks.  Instead of having one of these kthreads act as
> > leader, each group has a separate rcog kthread that handles grace periods
> > for its group.  Because these rcuog kthreads do not invoke callbacks,
> > callback floods on one CPU no longer block callbacks from reaching the
> > rcuc callback-invocation kthreads on other CPUs.
> > 
> > This change does introduce additional kthreads, however:
> > 
> > 1.	The number of additional kthreads is about the square root of
> > 	the number of CPUs, so that a 4096-CPU system would have only
> > 	about 64 additional kthreads.  Note that recent changes
> > 	decreased the number of rcuo kthreads by a factor of two
> > 	(CONFIG_PREEMPT=n) or even three (CONFIG_PREEMPT=y), so
> > 	this still represents a significant improvement on most systems.
> > 
> > 2.	The leading "rcuo" of the rcuog kthreads should allow existing
> > 	scripting to affinity these additional kthreads as needed, the
> > 	same as for the rcuop and rcuos kthreads.  (There are no longer
> > 	any rcuob kthreads.)
> > 
> > 3.	A state-machine approach was considered and rejected.  Although
> > 	this would allow the rcuo kthreads to continue their dual
> > 	leader/follower roles, it complicates callback invocation
> > 	and makes it more difficult to consolidate rcuo callback
> > 	invocation with existing softirq callback invocation.
> > 
> > The introduction of rcuog kthreads should thus be acceptable.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  kernel/rcu/tree.h        |   6 +-
> >  kernel/rcu/tree_plugin.h | 115 +++++++++++++++++++--------------------
> >  2 files changed, 61 insertions(+), 60 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 32b3348d3a4d..dc3c53cb9608 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -200,8 +200,8 @@ struct rcu_data {
> >  	atomic_long_t nocb_q_count_lazy; /*  invocation (all stages). */
> >  	struct rcu_head *nocb_cb_head;	/* CBs ready to invoke. */
> >  	struct rcu_head **nocb_cb_tail;
> > -	struct swait_queue_head nocb_wq; /* For nocb kthreads to sleep on. */
> > -	struct task_struct *nocb_cb_kthread;
> > +	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
> > +	struct task_struct *nocb_gp_kthread;
> >  	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
> >  	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
> >  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
> > @@ -211,6 +211,8 @@ struct rcu_data {
> >  					/* CBs waiting for GP. */
> >  	struct rcu_head **nocb_gp_tail;
> >  	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
> > +	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
> > +	struct task_struct *nocb_cb_kthread;
> >  	struct rcu_data *nocb_next_cb_rdp;
> >  					/* Next rcu_data in wakeup chain. */
> >  
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 5a72700c3a32..c3b6493313ab 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1531,7 +1531,7 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
> >  	struct rcu_data *rdp_leader = rdp->nocb_gp_rdp;
> >  
> >  	lockdep_assert_held(&rdp->nocb_lock);
> > -	if (!READ_ONCE(rdp_leader->nocb_cb_kthread)) {
> > +	if (!READ_ONCE(rdp_leader->nocb_gp_kthread)) {
> >  		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  		return;
> >  	}
> > @@ -1541,7 +1541,7 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
> >  		del_timer(&rdp->nocb_timer);
> >  		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  		smp_mb(); /* ->nocb_gp_sleep before swake_up_one(). */
> > -		swake_up_one(&rdp_leader->nocb_wq);
> > +		swake_up_one(&rdp_leader->nocb_gp_wq);
> >  	} else {
> >  		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> >  	}
> > @@ -1646,7 +1646,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
> >  	smp_mb__after_atomic(); /* Store *old_rhpp before _wake test. */
> >  
> >  	/* If we are not being polled and there is a kthread, awaken it ... */
> > -	t = READ_ONCE(rdp->nocb_cb_kthread);
> > +	t = READ_ONCE(rdp->nocb_gp_kthread);
> >  	if (rcu_nocb_poll || !t) {
> >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >  				    TPS("WakeNotPoll"));
> > @@ -1786,7 +1786,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
> >   * No-CBs GP kthreads come here to wait for additional callbacks to show up.
> >   * This function does not return until callbacks appear.
> >   */
> > -static void nocb_leader_wait(struct rcu_data *my_rdp)
> > +static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  {
> >  	bool firsttime = true;
> >  	unsigned long flags;
> > @@ -1794,12 +1794,10 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
> >  	struct rcu_data *rdp;
> >  	struct rcu_head **tail;
> >  
> > -wait_again:
> > -
> >  	/* Wait for callbacks to appear. */
> >  	if (!rcu_nocb_poll) {
> >  		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Sleep"));
> > -		swait_event_interruptible_exclusive(my_rdp->nocb_wq,
> > +		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
> >  				!READ_ONCE(my_rdp->nocb_gp_sleep));
> >  		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
> >  		my_rdp->nocb_gp_sleep = true;
> > @@ -1838,7 +1836,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
> >  			trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu,
> >  					    TPS("WokeEmpty"));
> >  		}
> > -		goto wait_again;
> > +		return;
> >  	}
> >  
> >  	/* Wait for one grace period. */
> > @@ -1862,34 +1860,47 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
> >  		rdp->nocb_cb_tail = rdp->nocb_gp_tail;
> >  		*tail = rdp->nocb_gp_head;
> >  		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> > -		if (rdp != my_rdp && tail == &rdp->nocb_cb_head) {
> > +		if (tail == &rdp->nocb_cb_head) {
> >  			/* List was empty, so wake up the kthread.  */
> > -			swake_up_one(&rdp->nocb_wq);
> > +			swake_up_one(&rdp->nocb_cb_wq);
> >  		}
> >  	}
> > +}
> >  
> > -	/* If we (the GP kthreads) don't have CBs, go wait some more. */
> > -	if (!my_rdp->nocb_cb_head)
> > -		goto wait_again;
> > +/*
> > + * No-CBs grace-period-wait kthread.  There is one of these per group
> > + * of CPUs, but only once at least one CPU in that group has come online
> > + * at least once since boot.  This kthread checks for newly posted
> > + * callbacks from any of the CPUs it is responsible for, waits for a
> > + * grace period, then awakens all of the rcu_nocb_cb_kthread() instances
> > + * that then have callback-invocation work to do.
> > + */
> > +static int rcu_nocb_gp_kthread(void *arg)
> > +{
> > +	struct rcu_data *rdp = arg;
> > +
> > +	for (;;)
> > +		nocb_gp_wait(rdp);
> > +	return 0;
> >  }
> >  
> >  /*
> >   * No-CBs CB kthreads come here to wait for additional callbacks to show up.
> > - * This function does not return until callbacks appear.
> > + * This function returns true ("keep waiting") until callbacks appear and
> > + * then false ("stop waiting") when callbacks finally do appear.
> >   */
> > -static void nocb_follower_wait(struct rcu_data *rdp)
> > +static bool nocb_follower_wait(struct rcu_data *rdp)
> >  {
> > -	for (;;) {
> > -		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
> > -		swait_event_interruptible_exclusive(rdp->nocb_wq,
> > -					 READ_ONCE(rdp->nocb_cb_head));
> > -		if (smp_load_acquire(&rdp->nocb_cb_head)) {
> > -			/* ^^^ Ensure CB invocation follows _head test. */
> > -			return;
> > -		}
> > -		WARN_ON(signal_pending(current));
> > -		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> > +	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
> > +	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> > +				 READ_ONCE(rdp->nocb_cb_head));
> > +	if (smp_load_acquire(&rdp->nocb_cb_head)) { /* VVV */
> > +		/* ^^^ Ensure CB invocation follows _head test. */
> > +		return false;
> >  	}
> > +	WARN_ON(signal_pending(current));
> > +	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> > +	return true;
> >  }
> >  
> >  /*
> > @@ -1899,7 +1910,7 @@ static void nocb_follower_wait(struct rcu_data *rdp)
> >   * have to do quite so many wakeups (as in they only need to wake the
> >   * no-CBs GP kthreads, not the CB kthreads).
> >   */
> > -static int rcu_nocb_kthread(void *arg)
> > +static int rcu_nocb_cb_kthread(void *arg)
> >  {
> >  	int c, cl;
> >  	unsigned long flags;
> > @@ -1911,10 +1922,8 @@ static int rcu_nocb_kthread(void *arg)
> >  	/* Each pass through this loop invokes one batch of callbacks */
> >  	for (;;) {
> >  		/* Wait for callbacks. */
> > -		if (rdp->nocb_gp_rdp == rdp)
> > -			nocb_leader_wait(rdp);
> > -		else
> > -			nocb_follower_wait(rdp);
> > +		while (nocb_follower_wait(rdp))
> > +			continue;
> >  
> >  		/* Pull the ready-to-invoke callbacks onto local list. */
> >  		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> > @@ -2048,7 +2057,8 @@ void __init rcu_init_nohz(void)
> >  static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
> >  {
> >  	rdp->nocb_tail = &rdp->nocb_head;
> > -	init_swait_queue_head(&rdp->nocb_wq);
> > +	init_swait_queue_head(&rdp->nocb_cb_wq);
> > +	init_swait_queue_head(&rdp->nocb_gp_wq);
> >  	rdp->nocb_cb_tail = &rdp->nocb_cb_head;
> >  	raw_spin_lock_init(&rdp->nocb_lock);
> >  	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
> > @@ -2056,50 +2066,39 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
> >  
> >  /*
> >   * If the specified CPU is a no-CBs CPU that does not already have its
> > - * rcuo kthread, spawn it.  If the CPUs are brought online out of order,
> > - * this can require re-organizing the GP-CB relationships.
> > + * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
> > + * for this CPU's group has not yet been created, spawn it as well.
> >   */
> >  static void rcu_spawn_one_nocb_kthread(int cpu)
> >  {
> > -	struct rcu_data *rdp;
> > -	struct rcu_data *rdp_last;
> > -	struct rcu_data *rdp_old_leader;
> > -	struct rcu_data *rdp_spawn = per_cpu_ptr(&rcu_data, cpu);
> > +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > +	struct rcu_data *rdp_gp;
> >  	struct task_struct *t;
> >  
> >  	/*
> >  	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
> >  	 * then nothing to do.
> >  	 */
> > -	if (!rcu_is_nocb_cpu(cpu) || rdp_spawn->nocb_cb_kthread)
> > +	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
> >  		return;
> >  
> >  	/* If we didn't spawn the GP kthread first, reorganize! */
> > -	rdp_old_leader = rdp_spawn->nocb_gp_rdp;
> > -	if (rdp_old_leader != rdp_spawn && !rdp_old_leader->nocb_cb_kthread) {
> > -		rdp_last = NULL;
> > -		rdp = rdp_old_leader;
> > -		do {
> > -			rdp->nocb_gp_rdp = rdp_spawn;
> > -			if (rdp_last && rdp != rdp_spawn)
> > -				rdp_last->nocb_next_cb_rdp = rdp;
> > -			if (rdp == rdp_spawn) {
> > -				rdp = rdp->nocb_next_cb_rdp;
> > -			} else {
> > -				rdp_last = rdp;
> > -				rdp = rdp->nocb_next_cb_rdp;
> > -				rdp_last->nocb_next_cb_rdp = NULL;
> > -			}
> > -		} while (rdp);
> > -		rdp_spawn->nocb_next_cb_rdp = rdp_old_leader;
> > +	rdp_gp = rdp->nocb_gp_rdp;
> > +	if (!rdp_gp->nocb_gp_kthread) {
> > +		t = kthread_run(rcu_nocb_gp_kthread, rdp_gp,
> > +				"rcuog/%d", rdp_gp->cpu);
> > +		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__))
> > +			return;
> > +		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
> >  	}
> >  
> >  	/* Spawn the kthread for this CPU. */
> > -	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
> > +	t = kthread_run(rcu_nocb_cb_kthread, rdp,
> >  			"rcuo%c/%d", rcu_state.abbr, cpu);
> > -	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo kthread, OOM is now expected behavior\n", __func__))
> > +	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> >  		return;
> > -	WRITE_ONCE(rdp_spawn->nocb_cb_kthread, t);
> > +	WRITE_ONCE(rdp->nocb_cb_kthread, t);
> > +	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> >  }
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
> 
