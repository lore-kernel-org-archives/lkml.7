Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D29DC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C6D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0PwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:52:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbfF0PwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:52:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RFpfGL011526
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:52:22 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2td0qyg6eb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:52:22 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 16:52:21 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 16:52:18 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RFqIF550201082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 15:52:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE0FB206A;
        Thu, 27 Jun 2019 15:52:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF800B2065;
        Thu, 27 Jun 2019 15:52:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 15:52:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9F1B916C3305; Thu, 27 Jun 2019 08:52:19 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:52:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627074705.utzk757w4jgpiqtn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627074705.utzk757w4jgpiqtn@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062715-0060-0000-0000-0000035644AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011341; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224062; UDB=6.00644222; IPR=6.01005250;
 MB=3.00027492; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 15:52:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062715-0061-0000-0000-000049ED9C5A
Message-Id: <20190627155219.GT26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:47:05AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-06-26 09:25:58 [-0700], Paul E. McKenney wrote:
> > On Wed, Jun 26, 2019 at 03:54:47PM +0200, Sebastian Andrzej Siewior wrote:
> > > one of my boxes boots with "threadirqs" and since commit 05f415715ce45
> > > ("rcu: Speed up expedited GPs when interrupting RCU reader") I run
> > > reliably into the following deadlock:
> > > 
> > > | ============================================
> > > | WARNING: possible recursive locking detected
> > > | 5.2.0-rc6 #279 Not tainted
> > > | --------------------------------------------
> > > | (cron)/2109 is trying to acquire lock:
> > > | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > > |
> > > | but task is already holding lock:
> > > | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > > |
> > > | other info that might help us debug this:
> > > |  Possible unsafe locking scenario:
> > > |
> > > |        CPU0
> > > |        ----
> > > |   lock(&p->pi_lock);  
> > > |   lock(&p->pi_lock);  
> > > |
> > > |  *** DEADLOCK ***
> > > |
> > > |  May be due to missing lock nesting notation
> > > |
> > > | 4 locks held by (cron)/2109:
> > > |  #0: 00000000c0ae63d9 (&sb->s_type->i_mutex_key){++++}, at: iterate_dir+0x3d/0x170
> > > |  #1: 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> > > |  #2: 00000000f62f14cf (&rq->lock){-.-.}, at: try_to_wake_up+0x209/0x700
> > > |  #3: 000000000d32568e (rcu_read_lock){....}, at: cpuacct_charge+0x37/0x1e0
> > > |
> > > | stack backtrace:
> > > | CPU: 3 PID: 2109 Comm: (cron) Not tainted 5.2.0-rc6 #279
> > > | Call Trace:
> > > |  <IRQ>
> > > |  dump_stack+0x67/0x90 
> > > |  __lock_acquire.cold.63+0x142/0x23a
> > > |  lock_acquire+0x9b/0x1a0
> > > |  ? try_to_wake_up+0x37/0x700
> > > |  _raw_spin_lock_irqsave+0x33/0x50
> > > |  ? try_to_wake_up+0x37/0x700
> > > |  try_to_wake_up+0x37/0x700
> > > wake up ksoftirqd
> > > 
> > > |  rcu_read_unlock_special+0x61/0xa0
> > > |  __rcu_read_unlock+0x58/0x60
> > > |  cpuacct_charge+0xeb/0x1e0
> > > |  update_curr+0x15d/0x350
> > > |  enqueue_entity+0x115/0x7e0
> > > |  enqueue_task_fair+0x78/0x450
> > > |  activate_task+0x41/0x90
> > > |  ttwu_do_activate+0x49/0x80
> > > |  try_to_wake_up+0x23f/0x700
> > > 
> > > wake up ksoftirqd
> > > 
> > > |  irq_exit+0xba/0xc0   
> > > |  smp_apic_timer_interrupt+0xb2/0x2a0
> > > |  apic_timer_interrupt+0xf/0x20
> > > |  </IRQ>
> > > 
> > > based one the commit it seems the problem was always there but now the
> > > mix of raise_softirq_irqoff() and set_tsk_need_resched() seems to hit
> > > the window quite reliably. Replacing it with 
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 1102765f91fd1..baab36f4d0f45 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -627,14 +627,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > >         if (preempt_bh_were_disabled || irqs_were_disabled) {
> > >                 WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > >                 /* Need to defer quiescent state until everything is enabled. */
> > > -               if (irqs_were_disabled) {
> > > -                       /* Enabling irqs does not reschedule, so... */
> > > -                       raise_softirq_irqoff(RCU_SOFTIRQ);
> > > -               } else {
> > > -                       /* Enabling BH or preempt does reschedule, so... */
> > > -                       set_tsk_need_resched(current);
> > > -                       set_preempt_need_resched();
> > > -               }
> > > +               raise_softirq_irqoff(RCU_SOFTIRQ);
> > >                 local_irq_restore(flags);
> > >                 return;
> > >         }
> > > 
> > > will make it go away.
> > 
> > Color me confused.  Neither set_tsk_need_resched() nor
> > set_preempt_need_resched() acquire locks or do wakeups.
> 
> This is correct.
> 
> > Yet raise_softirq_irqoff() can do a wakeup if not called
> > from hardirq/softirq/NMI context, so I would instead expect
> > raise_softirq_irqoff() to be the source of troubles when
> > interrupts are threaded.
> 
> also correct and it is.
> 
> > What am I missing here?
> 
> Timing. If raise_softirq_irqoff() is always invoked then we end up in a
> state where the thread either isn't invoked or is already running and
> the wake up is skipped early (because ->state == TASK_RUNNING or
> something).
> Please be aware that timing is crucial here to trigger it. I have a
> test-case running as an init-script which triggers the bug. Running the
> tast-case later manually does not trigger it.
> 
> > > Any suggestions?
> > 
> > Does something like IRQ work help?  Please see -rcu commit 0864f057b050
> > ("rcu: Use irq_work to get scheduler's attention in clean context")
> > for one way of doing this.  Perhaps in combination with -rcu commit
> > a69987a515c8 ("rcu: Simplify rcu_read_unlock_special() deferred wakeups").
> 
> I don't think this will help. The problem is that irq_exit() invokes
> wake_up_process(ksoftirqd). This function will invoke itself on the same
> task as part of rcu_unlock() / rcu_read_unlock_special(). I don't think
> this changes here.

I could always just do a self-IPI.  :-/

Another approach would be to kick off a short-duration timer from
rcu_read_unlock_special().

Of course neither of these would help with irq_exit() invoking
wake_up_process(ksoftirqd).  Except that if we are doing an irq_exit(),
how is it that any of the scheduler rq/pi locks are held?

Am I right in guessing that the threaded interrupts increase the
probability of this sort of thing happening due to softirqs (but not
interrupts) being disabled while the interrupt is running in threaded
mode?  (Referring to the local_bh_disable() in irq_forced_thread_fn(),
although irq_thread() doesn't obviously disable bh.)

Thomas may need to order a large quantity of confused-color paint...

							Thanx, Paul

