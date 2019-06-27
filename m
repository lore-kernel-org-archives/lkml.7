Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A4C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420F52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfF0Rih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:38:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbfF0Rig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:38:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RHcQOc020517
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:38:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2td0qymy88-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:38:35 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 18:38:33 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 18:38:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RHcTdE36176382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 17:38:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB3DB2066;
        Thu, 27 Jun 2019 17:38:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CF97B205F;
        Thu, 27 Jun 2019 17:38:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 17:38:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 18F2216C1C01; Thu, 27 Jun 2019 10:38:31 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:38:31 -0700
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
Reply-To: paulmck@linux.ibm.com
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062717-0072-0000-0000-00000441C9FA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011342; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224097; UDB=6.00644243; IPR=6.01005286;
 MB=3.00027492; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 17:38:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062717-0073-0000-0000-00004CB1F7E0
Message-Id: <20190627173831.GW26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:47:24PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 11:55 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 11:30:31AM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> > > > On Thu, 27 Jun 2019 10:24:36 -0400
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > > > What am I missing here?
> > > > >
> > > > > This issue I think is
> > > > >
> > > > > (in normal process context)
> > > > > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > > > >                      // but this was done in normal process context,
> > > > >                      // not from IRQ handler
> > > > > rcu_read_lock();
> > > > >           <---------- IPI comes in and sets exp_hint
> > > >
> > > > How would an IPI come in here with interrupts disabled?
> > > >
> > > > -- Steve
> > >
> > > This is true, could it be rcu_read_unlock_special() got called for some
> > > *other* reason other than the IPI then?
> > >
> > > Per Sebastian's stack trace of the recursive lock scenario, it is happening
> > > during cpu_acct_charge() which is called with the rq_lock held.
> > >
> > > The only other reasons I know off to call rcu_read_unlock_special() are if
> > > 1. the tick indicated that the CPU has to report a QS
> > > 2. an IPI in the middle of the reader section for expedited GPs
> > > 3. preemption in the middle of a preemptible RCU reader section
> >
> > 4. Some previous reader section was IPIed or preempted, but either
> >    interrupts, softirqs, or preemption was disabled across the
> >    rcu_read_unlock() of that previous reader section.
> 
> Hi Paul, I did not fully understand 4. The previous RCU reader section
> could not have been IPI'ed or been preempted if interrupts were
> disabled across. Also, if softirq/preempt is disabled across the
> previous reader section, the previous reader could not be preempted in
> these case.

Like this, courtesy of the consolidation of RCU flavors:

	previous_reader()
	{
		rcu_read_lock();
		do_something(); /* Preemption happened here. */
		local_irq_disable(); /* Cannot be the scheduler! */
		do_something_else();
		rcu_read_unlock();  /* Must defer QS, task still queued. */
		do_some_other_thing();
		local_irq_enable();
	}

	current_reader() /* QS from previous_reader() is still deferred. */
	{
		local_irq_disable();  /* Might be the scheduler. */
		do_whatever();
		rcu_read_lock();
		do_whatever_else();
		rcu_read_unlock();  /* Must still defer reporting QS. */
		do_whatever_comes_to_mind();
		local_irq_enable();
	}

Both instances of rcu_read_unlock() need to cause some later thing
to report the quiescent state, and in some cases it will do a wakeup.
Now, previous_reader()'s IRQ disabling cannot be due to scheduler rq/pi
locks due to the rule about holding them across the entire RCU reader
if they are held across the rcu_read_unlock().  But current_reader()'s
IRQ disabling might well be due to the scheduler rq/pi locks, so
current_reader() must be careful about doing wakeups.

> That leaves us with the only scenario where the previous reader was
> IPI'ed while softirq/preempt was disabled across it. Is that what you
> meant?

No, but that can also happen.

>        But in this scenario, the previous reader should have set
> exp_hint to false in the previous reader's rcu_read_unlock_special()
> invocation itself. So I would think t->rcu_read_unlock_special should
> be 0 during the new reader's invocation thus I did not understand how
> rcu_read_unlock_special can be called because of a previous reader.

Yes, exp_hint would unconditionally be set to false in the first
reader's rcu_read_unlock().  But .blocked won't be.

> I'll borrow some of that confused color paint if you don't mind ;-)
> And we should document this somewhere for future sanity preservation
> :-D

Or adjust the code and requirements to make it more sane, if feasible.

My current (probably wildly unreliable) guess that the conditions in
rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
implies a hardirq context, in other words that in_irq() would return
false from a threaded interrupt handler.  If in_irq() instead returns
true from within a threaded interrupt handler, then this code in
rcu_read_unlock_special() needs fixing:

		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
			// Using softirq, safe to awaken, and we get
			// no help from enabling irqs, unlike bh/preempt.
			raise_softirq_irqoff(RCU_SOFTIRQ);

The fix would be replacing the calls to in_irq() with something that
returns true only if called from within a hardirq context.

Thoughts?

Ugh.  Same question about IRQ work.  Will the current use of it by
rcu_read_unlock_special() cause breakage in the presence of threaded
interrupt handlers?

							Thanx, Paul

> thanks,
>  - Joel
> 
> 
> 
> >
> > I -think- that this is what Sebastian is seeing.
> >
> >                                                         Thanx, Paul
> >
> > > 1. and 2. are not possible because interrupts are disabled, that's why the
> > > wakeup_softirq even happened.
> > > 3. is not possible because we are holding rq_lock in the RCU reader section.
> > >
> > > So I am at a bit of a loss how this can happen :-(
> > >
> > > Spurious call to rcu_read_unlock_special() may be when it should not have
> > > been called?
> > >
> > > thanks,
> > >
> > > - Joel

