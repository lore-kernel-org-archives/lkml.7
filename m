Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34851C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AD22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfFYQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbfFYQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:53:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PGqGiV067879;
        Tue, 25 Jun 2019 12:52:41 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbp92k4mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 12:52:40 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5PGoMOM029297;
        Tue, 25 Jun 2019 16:52:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by71dyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 16:52:39 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PGqcUG46793154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 16:52:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D62A1B2064;
        Tue, 25 Jun 2019 16:52:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8DB3B2067;
        Tue, 25 Jun 2019 16:52:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 16:52:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CF92616C1854; Tue, 25 Jun 2019 09:52:38 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:52:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625165238.GJ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
 <20190625122514.GA23880@lenoir>
 <20190625135430.GW26519@linux.ibm.com>
 <20190625140538.GC3419@hirez.programming.kicks-ass.net>
 <20190625141624.GX26519@linux.ibm.com>
 <20190625162058.GB23880@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625162058.GB23880@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:20:59PM +0200, Frederic Weisbecker wrote:
> On Tue, Jun 25, 2019 at 07:16:24AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2019 at 04:05:38PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 25, 2019 at 06:54:30AM -0700, Paul E. McKenney wrote:
> > > > And it allows dispensing with the initialization.  How about like
> > > > the following?
> > > 
> > > Looks good to me!
> > 
> > Limited rcutorture testing looking good thus far.  Here is hoping!
> > 
> > Frederic, you OK with this approach?
> 
> Yep, all good!

Very well, the commit is as shown below.  This is on current -rcu,
but feel free to take it if you would like, Peter.  Just let me know
and I will mark it so that I don't push it myself.  (I need to keep
it in -rcu until I rebase onto a version of mainline that contains
it so as to avoid spurious rcutorture failures.)

							Thanx, Paul

------------------------------------------------------------------------

commit b02b73cc95b6e3d912f36de20116b520cc3072c7
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Thu May 30 05:39:25 2019 -0700

    time/tick-broadcast: Fix tick_broadcast_offline() lockdep complaint
    
    The TASKS03 and TREE04 rcutorture scenarios produce the following
    lockdep complaint:
    
    ------------------------------------------------------------------------
    
    ================================
    WARNING: inconsistent lock state
    5.2.0-rc1+ #513 Not tainted
    --------------------------------
    inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
    migration/1/14 [HC0[0]:SC0[0]:HE1:SE1] takes:
    (____ptrval____) (tick_broadcast_lock){?...}, at: tick_broadcast_offline+0xf/0x70
    {IN-HARDIRQ-W} state was registered at:
      lock_acquire+0xb0/0x1c0
      _raw_spin_lock_irqsave+0x3c/0x50
      tick_broadcast_switch_to_oneshot+0xd/0x40
      tick_switch_to_oneshot+0x4f/0xd0
      hrtimer_run_queues+0xf3/0x130
      run_local_timers+0x1c/0x50
      update_process_times+0x1c/0x50
      tick_periodic+0x26/0xc0
      tick_handle_periodic+0x1a/0x60
      smp_apic_timer_interrupt+0x80/0x2a0
      apic_timer_interrupt+0xf/0x20
      _raw_spin_unlock_irqrestore+0x4e/0x60
      rcu_nocb_gp_kthread+0x15d/0x590
      kthread+0xf3/0x130
      ret_from_fork+0x3a/0x50
    irq event stamp: 171
    hardirqs last  enabled at (171): [<ffffffff8a201a37>] trace_hardirqs_on_thunk+0x1a/0x1c
    hardirqs last disabled at (170): [<ffffffff8a201a53>] trace_hardirqs_off_thunk+0x1a/0x1c
    softirqs last  enabled at (0): [<ffffffff8a264ee0>] copy_process.part.56+0x650/0x1cb0
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    
    other info that might help us debug this:
     Possible unsafe locking scenario:
    
           CPU0
           ----
      lock(tick_broadcast_lock);
      <Interrupt>
        lock(tick_broadcast_lock);
    
     *** DEADLOCK ***
    
    1 lock held by migration/1/14:
     #0: (____ptrval____) (clockevents_lock){+.+.}, at: tick_offline_cpu+0xf/0x30
    
    stack backtrace:
    CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.2.0-rc1+ #513
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
    Call Trace:
     dump_stack+0x5e/0x8b
     print_usage_bug+0x1fc/0x216
     ? print_shortest_lock_dependencies+0x1b0/0x1b0
     mark_lock+0x1f2/0x280
     __lock_acquire+0x1e0/0x18f0
     ? __lock_acquire+0x21b/0x18f0
     ? _raw_spin_unlock_irqrestore+0x4e/0x60
     lock_acquire+0xb0/0x1c0
     ? tick_broadcast_offline+0xf/0x70
     _raw_spin_lock+0x33/0x40
     ? tick_broadcast_offline+0xf/0x70
     tick_broadcast_offline+0xf/0x70
     tick_offline_cpu+0x16/0x30
     take_cpu_down+0x7d/0xa0
     multi_cpu_stop+0xa2/0xe0
     ? cpu_stop_queue_work+0xc0/0xc0
     cpu_stopper_thread+0x6d/0x100
     smpboot_thread_fn+0x169/0x240
     kthread+0xf3/0x130
     ? sort_range+0x20/0x20
     ? kthread_cancel_delayed_work_sync+0x10/0x10
     ret_from_fork+0x3a/0x50
    
    ------------------------------------------------------------------------
    
    To reproduce, run the following rcutorture test:
    
            tools/testing/selftests/rcutorture/bin/kvm.sh --duration 5 --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --configs "TASKS03 TREE04"
    
    It turns out that tick_broadcast_offline() was an innocent bystander.
    After all, interrupts are supposed to be disabled throughout
    take_cpu_down(), and therefore should have been disabled upon entry to
    tick_offline_cpu() and thus to tick_broadcast_offline().  This suggests
    that one of the CPU-hotplug notifiers was incorrectly enabling interrupts,
    and leaving them enabled on return.
    
    Some debugging code showed that the culprit was sched_cpu_dying().
    It had irqs enabled after return from sched_tick_stop().  Which in turn
    had irqs enabled after return from cancel_delayed_work_sync().  Which is a
    wrapper around __cancel_work_timer().  Which can sleep in the case where
    something else is concurrently trying to cancel the same delayed work,
    and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
    idea when you are invoked from take_cpu_down(), regardless of the state
    you leave interrupts in upon return.
    
    Code inspection located no reason why the delayed work absolutely
    needed to be canceled from sched_tick_stop():  The work is not
    bound to the outgoing CPU by design, given that the whole point is
    to collect statistics without disturbing the outgoing CPU.
    
    This commit therefore simply drops the cancel_delayed_work_sync() from
    sched_tick_stop().  Instead, a new ->state field is added to the tick_work
    structure so that the delayed-work handler function sched_tick_remote()
    can avoid reposting itself.  A cpu_is_offline() check is also added to
    sched_tick_remote() to avoid mucking with the state of an offlined CPU
    (though it does appear safe to do so).  The sched_tick_start() and
    sched_tick_stop() functions also update ->state, and sched_tick_start()
    also schedules the delayed work if ->state indicates that it is not
    already in flight.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    [ paulmck: Apply Peter Zijlstra and Frederic Weisbecker atomics feedback. ]
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..d7be6d4b6a0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3050,8 +3050,36 @@ void scheduler_tick(void)
 
 struct tick_work {
 	int			cpu;
+	atomic_t		state;
 	struct delayed_work	work;
 };
+/* Values for ->state, see diagram below. */
+#define TICK_SCHED_REMOTE_OFFLINE	0
+#define TICK_SCHED_REMOTE_OFFLINING	1
+#define TICK_SCHED_REMOTE_RUNNING	2
+
+/*
+ * State diagram for ->state:
+ *
+ *
+ *          TICK_SCHED_REMOTE_OFFLINE
+ *                    |   ^
+ *                    |   |
+ *                    |   | sched_tick_remote()
+ *                    |   |
+ *                    |   |
+ *                    +--TICK_SCHED_REMOTE_OFFLINING
+ *                    |   ^
+ *                    |   |
+ * sched_tick_start() |   | sched_tick_stop()
+ *                    |   |
+ *                    V   |
+ *          TICK_SCHED_REMOTE_RUNNING
+ *
+ *
+ * Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
+ * and sched_tick_start() are happy to leave the state in RUNNING.
+ */
 
 static struct tick_work __percpu *tick_work_cpu;
 
@@ -3064,6 +3092,7 @@ static void sched_tick_remote(struct work_struct *work)
 	struct task_struct *curr;
 	struct rq_flags rf;
 	u64 delta;
+	int os;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3077,7 +3106,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr))
+	if (is_idle_task(curr) || cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
@@ -3097,13 +3126,18 @@ static void sched_tick_remote(struct work_struct *work)
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
-	 * to keep scheduler internal stats reasonably up to date.
+	 * to keep scheduler internal stats reasonably up to date.  But
+	 * first update state to reflect hotplug activity if required.
 	 */
-	queue_delayed_work(system_unbound_wq, dwork, HZ);
+	os = atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
+	if (os == TICK_SCHED_REMOTE_RUNNING)
+		queue_delayed_work(system_unbound_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3112,15 +3146,20 @@ static void sched_tick_start(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	twork->cpu = cpu;
-	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
+	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
+	if (os == TICK_SCHED_REMOTE_OFFLINE) {
+		twork->cpu = cpu;
+		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
+		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void sched_tick_stop(int cpu)
 {
 	struct tick_work *twork;
+	int os;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
 		return;
@@ -3128,7 +3167,10 @@ static void sched_tick_stop(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	cancel_delayed_work_sync(&twork->work);
+	/* There cannot be competing actions, but don't rely on stop-machine. */
+	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_OFFLINING);
+	WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
+	/* Don't cancel, as this would mess up the state machine. */
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
@@ -3136,7 +3178,6 @@ int __init sched_tick_offload_init(void)
 {
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
-
 	return 0;
 }
 
