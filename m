Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C6C48BE7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7292064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfF0SmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:42:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfF0SmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:42:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RIbDqw071829;
        Thu, 27 Jun 2019 14:41:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td0mmqmju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 14:41:07 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5RIdflO079093;
        Thu, 27 Jun 2019 14:41:07 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td0mmqmj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 14:41:07 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5RIda18024206;
        Thu, 27 Jun 2019 18:41:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by7g8k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 18:41:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RIf5Sd53936468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 18:41:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3402CB206A;
        Thu, 27 Jun 2019 18:41:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069DDB2064;
        Thu, 27 Jun 2019 18:41:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 18:41:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1104E16C6BA0; Thu, 27 Jun 2019 11:41:07 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:41:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627184107.GA26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627181638.GA209455@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 10:38:31AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 12:47:24PM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 27, 2019 at 11:55 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > >
> > > > On Thu, Jun 27, 2019 at 11:30:31AM -0400, Joel Fernandes wrote:
> > > > > On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> > > > > > On Thu, 27 Jun 2019 10:24:36 -0400
> > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > > > What am I missing here?
> > > > > > >
> > > > > > > This issue I think is
> > > > > > >
> > > > > > > (in normal process context)
> > > > > > > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > > > > > >                      // but this was done in normal process context,
> > > > > > >                      // not from IRQ handler
> > > > > > > rcu_read_lock();
> > > > > > >           <---------- IPI comes in and sets exp_hint
> > > > > >
> > > > > > How would an IPI come in here with interrupts disabled?
> > > > > >
> > > > > > -- Steve
> > > > >
> > > > > This is true, could it be rcu_read_unlock_special() got called for some
> > > > > *other* reason other than the IPI then?
> > > > >
> > > > > Per Sebastian's stack trace of the recursive lock scenario, it is happening
> > > > > during cpu_acct_charge() which is called with the rq_lock held.
> > > > >
> > > > > The only other reasons I know off to call rcu_read_unlock_special() are if
> > > > > 1. the tick indicated that the CPU has to report a QS
> > > > > 2. an IPI in the middle of the reader section for expedited GPs
> > > > > 3. preemption in the middle of a preemptible RCU reader section
> > > >
> > > > 4. Some previous reader section was IPIed or preempted, but either
> > > >    interrupts, softirqs, or preemption was disabled across the
> > > >    rcu_read_unlock() of that previous reader section.
> > > 
> > > Hi Paul, I did not fully understand 4. The previous RCU reader section
> > > could not have been IPI'ed or been preempted if interrupts were
> > > disabled across. Also, if softirq/preempt is disabled across the
> > > previous reader section, the previous reader could not be preempted in
> > > these case.
> > 
> > Like this, courtesy of the consolidation of RCU flavors:
> > 
> > 	previous_reader()
> > 	{
> > 		rcu_read_lock();
> > 		do_something(); /* Preemption happened here. */
> > 		local_irq_disable(); /* Cannot be the scheduler! */
> > 		do_something_else();
> > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > 		do_some_other_thing();
> > 		local_irq_enable();
> > 	}
> > 
> > 	current_reader() /* QS from previous_reader() is still deferred. */
> > 	{
> > 		local_irq_disable();  /* Might be the scheduler. */
> > 		do_whatever();
> > 		rcu_read_lock();
> > 		do_whatever_else();
> > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > 		do_whatever_comes_to_mind();
> > 		local_irq_enable();
> > 	}
> > 
> > Both instances of rcu_read_unlock() need to cause some later thing
> > to report the quiescent state, and in some cases it will do a wakeup.
> > Now, previous_reader()'s IRQ disabling cannot be due to scheduler rq/pi
> > locks due to the rule about holding them across the entire RCU reader
> > if they are held across the rcu_read_unlock().  But current_reader()'s
> > IRQ disabling might well be due to the scheduler rq/pi locks, so
> > current_reader() must be careful about doing wakeups.
> 
> Makes sense now, thanks.
> 
> > > That leaves us with the only scenario where the previous reader was
> > > IPI'ed while softirq/preempt was disabled across it. Is that what you
> > > meant?
> > 
> > No, but that can also happen.
> > 
> > >        But in this scenario, the previous reader should have set
> > > exp_hint to false in the previous reader's rcu_read_unlock_special()
> > > invocation itself. So I would think t->rcu_read_unlock_special should
> > > be 0 during the new reader's invocation thus I did not understand how
> > > rcu_read_unlock_special can be called because of a previous reader.
> > 
> > Yes, exp_hint would unconditionally be set to false in the first
> > reader's rcu_read_unlock().  But .blocked won't be.
> 
> Makes sense.
> 
> > > I'll borrow some of that confused color paint if you don't mind ;-)
> > > And we should document this somewhere for future sanity preservation
> > > :-D
> > 
> > Or adjust the code and requirements to make it more sane, if feasible.
> > 
> > My current (probably wildly unreliable) guess that the conditions in
> > rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
> > implies a hardirq context, in other words that in_irq() would return
> > false from a threaded interrupt handler.  If in_irq() instead returns
> > true from within a threaded interrupt handler, then this code in
> > rcu_read_unlock_special() needs fixing:
> > 
> > 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > 			// Using softirq, safe to awaken, and we get
> > 			// no help from enabling irqs, unlike bh/preempt.
> > 			raise_softirq_irqoff(RCU_SOFTIRQ);
> > 
> > The fix would be replacing the calls to in_irq() with something that
> > returns true only if called from within a hardirq context.
> > Thoughts?
> 
> I am not sure if this will fix all cases though?
> 
> I think the crux of the problem is doing a recursive wake up. The threaded
> IRQ probably just happens to be causing it here, it seems to me this problem
> can also occur on a non-threaded irq system (say current_reader() in your
> example executed in a scheduler path in process-context and not from an
> interrupt). Is that not possible?

In the non-threaded case, invoking raise_softirq*() from hardirq context
just sets a bit in a per-CPU variable.  Now, to Sebastian's point, we
are only sort of in hardirq context in this case due to being called
from irq_exit(), but the failure we are seeing might well be a ways
downstream of the actual root-cause bug.

> I think the fix should be to prevent the wake-up not based on whether we are
> in hard/soft-interrupt mode but that we are doing the rcu_read_unlock() from
> a scheduler path (if we can detect that)

Or just don't do the wakeup at all, if it comes to that.  I don't know
of any way to determine whether rcu_read_unlock() is being called from
the scheduler, but it has been some time since I asked Peter Zijlstra
about that.

Of course, unconditionally refusing to do the wakeup might not be happy
thing for NO_HZ_FULL kernels that don't implement IRQ work.

> I lost track of this code:
>  		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
>  		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> 
> Was this patch posted to the list? I will blame it to try to get some
> context. It sounds like you added more conditions on when to kick the
> softirq.

This is from the dev branch of my -rcu tree.  It has at least one
patch in this area that is currently slated for v5.4, so I would not
have sent that as part of an official patch series.

> > Ugh.  Same question about IRQ work.  Will the current use of it by
> > rcu_read_unlock_special() cause breakage in the presence of threaded
> > interrupt handlers?
> 
> /me needs to understand why the irq work stuff was added here as well. Have
> my work cut out for the day! ;-)

New code, so more likely to contain bugs than usual.  ;-)

The point was to get a wakeup soonish without risk of rq/pi deadlocks.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > thanks,
> > >  - Joel
> > > 
> > > 
> > > 
> > > >
> > > > I -think- that this is what Sebastian is seeing.
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > 1. and 2. are not possible because interrupts are disabled, that's why the
> > > > > wakeup_softirq even happened.
> > > > > 3. is not possible because we are holding rq_lock in the RCU reader section.
> > > > >
> > > > > So I am at a bit of a loss how this can happen :-(
> > > > >
> > > > > Spurious call to rcu_read_unlock_special() may be when it should not have
> > > > > been called?
> > > > >
> > > > > thanks,
> > > > >
> > > > > - Joel
> > 
> 
