Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7268820665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFZQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:27:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbfFZQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:27:10 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QGMU4S010958;
        Wed, 26 Jun 2019 12:26:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tc9u0y0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 12:26:00 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5QGNWkr013933;
        Wed, 26 Jun 2019 12:25:59 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tc9u0y0p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 12:25:59 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5QGOmJo001080;
        Wed, 26 Jun 2019 16:25:58 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2t9by78acx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 16:25:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QGPvxZ50200858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 16:25:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2A54B205F;
        Wed, 26 Jun 2019 16:25:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E24B2065;
        Wed, 26 Jun 2019 16:25:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 16:25:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0353216C2F90; Wed, 26 Jun 2019 09:25:58 -0700 (PDT)
Date:   Wed, 26 Jun 2019 09:25:58 -0700
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
Message-ID: <20190626162558.GY26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:54:47PM +0200, Sebastian Andrzej Siewior wrote:
> one of my boxes boots with "threadirqs" and since commit 05f415715ce45
> ("rcu: Speed up expedited GPs when interrupting RCU reader") I run
> reliably into the following deadlock:
> 
> | ============================================
> | WARNING: possible recursive locking detected
> | 5.2.0-rc6 #279 Not tainted
> | --------------------------------------------
> | (cron)/2109 is trying to acquire lock:
> | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> |
> | but task is already holding lock:
> | 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> |
> | other info that might help us debug this:
> |  Possible unsafe locking scenario:
> |
> |        CPU0
> |        ----
> |   lock(&p->pi_lock);  
> |   lock(&p->pi_lock);  
> |
> |  *** DEADLOCK ***
> |
> |  May be due to missing lock nesting notation
> |
> | 4 locks held by (cron)/2109:
> |  #0: 00000000c0ae63d9 (&sb->s_type->i_mutex_key){++++}, at: iterate_dir+0x3d/0x170
> |  #1: 0000000088464daa (&p->pi_lock){-.-.}, at: try_to_wake_up+0x37/0x700
> |  #2: 00000000f62f14cf (&rq->lock){-.-.}, at: try_to_wake_up+0x209/0x700
> |  #3: 000000000d32568e (rcu_read_lock){....}, at: cpuacct_charge+0x37/0x1e0
> |
> | stack backtrace:
> | CPU: 3 PID: 2109 Comm: (cron) Not tainted 5.2.0-rc6 #279
> | Call Trace:
> |  <IRQ>
> |  dump_stack+0x67/0x90 
> |  __lock_acquire.cold.63+0x142/0x23a
> |  lock_acquire+0x9b/0x1a0
> |  ? try_to_wake_up+0x37/0x700
> |  _raw_spin_lock_irqsave+0x33/0x50
> |  ? try_to_wake_up+0x37/0x700
> |  try_to_wake_up+0x37/0x700
> wake up ksoftirqd
> 
> |  rcu_read_unlock_special+0x61/0xa0
> |  __rcu_read_unlock+0x58/0x60
> |  cpuacct_charge+0xeb/0x1e0
> |  update_curr+0x15d/0x350
> |  enqueue_entity+0x115/0x7e0
> |  enqueue_task_fair+0x78/0x450
> |  activate_task+0x41/0x90
> |  ttwu_do_activate+0x49/0x80
> |  try_to_wake_up+0x23f/0x700
> 
> wake up ksoftirqd
> 
> |  irq_exit+0xba/0xc0   
> |  smp_apic_timer_interrupt+0xb2/0x2a0
> |  apic_timer_interrupt+0xf/0x20
> |  </IRQ>
> 
> based one the commit it seems the problem was always there but now the
> mix of raise_softirq_irqoff() and set_tsk_need_resched() seems to hit
> the window quite reliably. Replacing it with 
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1102765f91fd1..baab36f4d0f45 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -627,14 +627,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>         if (preempt_bh_were_disabled || irqs_were_disabled) {
>                 WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>                 /* Need to defer quiescent state until everything is enabled. */
> -               if (irqs_were_disabled) {
> -                       /* Enabling irqs does not reschedule, so... */
> -                       raise_softirq_irqoff(RCU_SOFTIRQ);
> -               } else {
> -                       /* Enabling BH or preempt does reschedule, so... */
> -                       set_tsk_need_resched(current);
> -                       set_preempt_need_resched();
> -               }
> +               raise_softirq_irqoff(RCU_SOFTIRQ);
>                 local_irq_restore(flags);
>                 return;
>         }
> 
> will make it go away.

Color me confused.  Neither set_tsk_need_resched() nor
set_preempt_need_resched() acquire locks or do wakeups.
Yet raise_softirq_irqoff() can do a wakeup if not called
from hardirq/softirq/NMI context, so I would instead expect
raise_softirq_irqoff() to be the source of troubles when
interrupts are threaded.

What am I missing here?

> Any suggestions?

Does something like IRQ work help?  Please see -rcu commit 0864f057b050
("rcu: Use irq_work to get scheduler's attention in clean context")
for one way of doing this.  Perhaps in combination with -rcu commit
a69987a515c8 ("rcu: Simplify rcu_read_unlock_special() deferred wakeups").

							Thanx, Paul
