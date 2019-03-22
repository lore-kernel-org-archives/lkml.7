Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A807C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E08B218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCVQZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:25:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbfCVQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:25:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MGEEvT001216
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:25:50 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd16ce4dp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:25:49 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 16:25:46 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 16:25:42 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MGPhri22675574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 16:25:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 861E1B2065;
        Fri, 22 Mar 2019 16:25:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57262B205F;
        Fri, 22 Mar 2019 16:25:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 16:25:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B8AAA16C2A5D; Fri, 22 Mar 2019 09:26:35 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:26:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190320234601.GQ4102@linux.ibm.com>
 <20190321233244.GA11476@linux.ibm.com>
 <20190322134207.GA56461@google.com>
 <20190322145823.GM4102@linux.ibm.com>
 <20190322155049.GA86662@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322155049.GA86662@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032216-0060-0000-0000-00000320BD12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010795; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178095; UDB=6.00616339; IPR=6.00958793;
 MB=3.00026111; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 16:25:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032216-0061-0000-0000-000048B20F97
Message-Id: <20190322162635.GP4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:50:49AM -0400, Joel Fernandes wrote:
> On Fri, Mar 22, 2019 at 07:58:23AM -0700, Paul E. McKenney wrote:
> [snip]
> > > > >  #ifdef CONFIG_RCU_NOCB_CPU
> > > > >  static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
> > > > > @@ -94,6 +72,8 @@ static void __init rcu_bootup_announce_oddness(void)
> > > > >  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
> > > > >  	if (gp_cleanup_delay)
> > > > >  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
> > > > > +	if (!use_softirq)
> > > > > +		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
> > > > >  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> > > > >  		pr_info("\tRCU debug extended QS entry/exit.\n");
> > > > >  	rcupdate_announce_bootup_oddness();
> > > > > @@ -629,7 +609,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > > > >  		/* Need to defer quiescent state until everything is enabled. */
> > > > >  		if (irqs_were_disabled) {
> > > > >  			/* Enabling irqs does not reschedule, so... */
> > > > > -			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > > +			if (!use_softirq)
> > > > > +				raise_softirq_irqoff(RCU_SOFTIRQ);
> > > > > +			else
> > > > > +				invoke_rcu_core();
> > > > 
> > > > This can result in deadlock.  This happens when the scheduler invokes
> > > > rcu_read_unlock() with one of the rq or pi locks held, which means that
> > > > interrupts are disabled.  And it also means that the wakeup done in
> > > > invoke_rcu_core() could go after the same rq or pi lock.
> > > > 
> > > > What we really need here is some way to make soemthing happen on this
> > > > CPU just after interrupts are re-enabled.  Here are the options I see:
> > > > 
> > > > 1.	Do set_tsk_need_resched() and set_preempt_need_resched(),
> > > > 	just like in the "else" clause below.  This sort of works, but
> > > > 	relies on some later interrupt or similar to get things started.
> > > > 	This is just fine for normal grace periods, but not so much for
> > > > 	expedited grace periods.
> > > > 
> > > > 2.	IPI some other CPU and have it IPI us back.  Not such a good plan
> > > > 	when running an SMP kernel on a single CPU.
> > > > 
> > > > 3.	Have a "stub" RCU_SOFTIRQ that contains only the following:
> > > > 
> > > > 	/* Report any deferred quiescent states if preemption enabled. */
> > > > 	if (!(preempt_count() & PREEMPT_MASK)) {
> > > > 		rcu_preempt_deferred_qs(current);
> > > > 	} else if (rcu_preempt_need_deferred_qs(current)) {
> > > > 		set_tsk_need_resched(current);
> > > > 		set_preempt_need_resched();
> > > > 	}
> > > > 
> > > > 4.	Except that raise_softirq_irqoff() could potentially have this
> > > > 	same problem if rcu_read_unlock() is invoked at process level
> > > > 	from the scheduler with either rq or pi locks held.  :-/
> > > > 
> > > > 	Which raises the question "why aren't I seeing hangs and
> > > > 	lockdep splats?"
> > > 
> > > Interesting, could it be you're not seeing a hang in the regular case,
> > > because enqueuing ksoftirqd on the same CPU as where the rcu_read_unlock is
> > > happening is a rare event? First, ksoftirqd has to even be awakened in the
> > > first place. On the other hand, with the new code the thread is always awaked
> > > and is more likely to run into the issue you found?
> > 
> > No, in many cases, including the self-deadlock that showed up last night,
> > raise_softirq_irqoff() will simply set a bit in a per-CPU variable.
> > One case where this happens is when called from an interrupt handler.
> 
> I think we are saying the same thing, in some cases ksoftirqd will be
> awakened and some case it will not. I will go through all scenarios to
> convince myself it is safe, if I find some issue I will let you know.

I am suspecting that raise_softirq_irqsoff() is in fact unsafe, just
only very rarely unsafe.

> > > The lockdep splats should be a more common occurence though IMO. If you could
> > > let me know which RCU config is hanging, I can try to debug this at my end as
> > > well.
> > 
> > TREE01, TREE02, TREE03, and TREE09.  I would guess that TREE08 would also
> > do the same thing, given that it also sets PREEMPT=y and tests Tree RCU.
> > 
> > Please see the patch I posted and tested overnight.  I suspect that there
> > is a better fix, but this does at least seem to suppress the error.
> 
> Ok, will do.
> 
> > > > Also, having lots of non-migratable timers might be considered unfriendly,
> > > > though they shouldn't be -that- heavily utilized.  Yet, anyway...
> > > > I could try adding logic to local_irq_enable() and local_irq_restore(),
> > > > but that probably wouldn't go over all that well.  Besides, sometimes
> > > > interrupt enabling happens in assembly language.
> > > > 
> > > > It is quite likely that delays to expedited grace periods wouldn't
> > > > happen all that often.  First, the grace period has to start while
> > > > the CPU itself (not some blocked task) is in an RCU read-side critical
> > > > section, second, that critical section cannot be preempted, and third
> > > > the rcu_read_unlock() must run with interrupts disabled.
> > > > 
> > > > Ah, but that sequence of events is not supposed to happen with the
> > > > scheduler lock!
> > > > 
> > > > From Documentation/RCU/Design/Requirements/Requirements.html:
> > > > 
> > > > 	It is forbidden to hold any of scheduler's runqueue or
> > > > 	priority-inheritance spinlocks across an rcu_read_unlock()
> > > > 	unless interrupts have been disabled across the entire RCU
> > > > 	read-side critical section, that is, up to and including the
> > > > 	matching rcu_read_lock().
> > > > 
> > > > Here are the reasons we even get to rcu_read_unlock_special():
> > > > 
> > > > 1.	The just-ended RCU read-side critical section was preempted.
> > > > 	This clearly cannot happen if interrupts are disabled across
> > > > 	the entire critical section.
> > > > 
> > > > 2.	The scheduling-clock interrupt noticed that this critical
> > > > 	section has been taking a long time.  But scheduling-clock
> > > > 	interrupts also cannot happen while interrupts are disabled.
> > > > 
> > > > 3.	An expedited grace periods started during this critical
> > > > 	section.  But if that happened, the corresponding IPI would
> > > > 	have waited until this CPU enabled interrupts, so this
> > > > 	cannot happen either.
> > > > 
> > > > So the call to invoke_rcu_core() should be OK after all.
> > > > 
> > > > Which is a bit of a disappointment, given that I am still seeing hangs!
> > > 
> > > Oh ok, discount whatever I just said then ;-) Indeed I remember this
> > > requirement too now. Your neat documentation skills are indeed life saving :D
> > 
> > No, this did turn out to be the problem area.  Or at least one of the
> > problem areas.  Again, see my earlier email.
> 
> Ok. Too many emails so I got confused :-D. I also forgot which version of the
> patch are we testing since I don't think an updated one was posted. But I
> will refer to your last night diff dig out the base patch from your git tree,
> no problem.
> 
> > > > I might replace this invoke_rcu_core() with set_tsk_need_resched() and
> > > > set_preempt_need_resched() to see if that gets rid of the hangs, but
> > > > first...
> > > 
> > > Could we use the NMI watchdog to dump the stack at the time of the hang? May
> > > be a deadlock will present on the stack (I think its config is called
> > > HARDLOCKUP_DETECTOR or something).
> > 
> > Another approach would be to instrument the locking code that notices
> > the recursive acquisition.  Or to run lockdep...  Because none of the
> > failing scenarios enable lockdep!  ;-)
> 
> I was wondering why lockdep is not always turned on in your testing. Is it
> due to performance concerns?

Because I also need to test without lockdep.  I sometimes use
"--kconfig CONFIG_PROVE_LOCKING=y" to force lockdep everywhere on
a particular rcutorture run, though.  Like on the run that I just
now started.  ;-)

							Thanx, Paul

