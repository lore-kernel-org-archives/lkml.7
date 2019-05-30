Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA921670
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfE3M6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:58:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726015AbfE3M6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:58:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UCihXI051104
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:58:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stfev99ke-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:58:11 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 13:58:11 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 13:58:09 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UCw8Pe20971532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:58:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B59CB205F;
        Thu, 30 May 2019 12:58:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F622B2064;
        Thu, 30 May 2019 12:58:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 12:58:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EB11E16C373B; Thu, 30 May 2019 05:58:09 -0700 (PDT)
Date:   Thu, 30 May 2019 05:58:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fweisbec@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Reply-To: paulmck@linux.ibm.com
References: <20190527143932.GA10527@linux.ibm.com>
 <alpine.DEB.2.21.1905281300340.1859@nanos.tec.linutronix.de>
 <20190529181941.GZ28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529181941.GZ28207@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053012-2213-0000-0000-00000397E991
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011184; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210745; UDB=6.00636133; IPR=6.00991779;
 MB=3.00027119; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 12:58:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053012-2214-0000-0000-00005EA2B9B2
Message-Id: <20190530125809.GA25376@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:19:41AM -0700, Paul E. McKenney wrote:
> On Tue, May 28, 2019 at 01:07:29PM -0700, Thomas Gleixner wrote:

[ . . . ]

> > What?
> > 
> > take_cpu_down() is called from multi_cpu_stop() with interrupts disabled.
> > 
> > So this is just papering over the fact that something called from
> > take_cpu_down() enabled interrupts. That needs to be found and fixed.
> 
> Just posting the information covered via IRC for posterity.
> 
> A bisection located commit a0e928ed7c60
> ("Merge branch 'timers-core-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").
> Yes, this is a merge commit, but both commits feeding into it are
> fine, but the merge fails.  There were no merge conflicts.
> 
> It turns out that tick_broadcast_offline() was in innocent bystander.
> After all, interrupts are supposed to be disabled throughout
> take_cpu_down(), and therefore should have been disabled upon entry to
> tick_offline_cpu() and thus to tick_broadcast_offline().
> 
> The function returning with irqs enabled was sched_cpu_dying().  It had
> irqs enabled after return from sched_tick_stop().  And it had irqs enabled
> after return from cancel_delayed_work_sync().  Which is a wrapper around
> __cancel_work_timer().  Which can sleep in the case where something else
> is concurrently trying to cancel the same delayed work, and sleeping is
> a decidedly bad idea when you are invoked from take_cpu_down().
> 
> None of these functions have been changed (at all!) in the past year,
> so my guess is that some other code was introduced that can race on
> __cancel_work_timer().  Except that I am not seeing any other call
> to cancel_delayed_work_sync().

And please see below for what might even be a proper patch.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 82801a716abf999d33846600a5d0faf7638a9b98
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
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..9a10ee9afcbf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3050,14 +3050,44 @@ void scheduler_tick(void)
 
 struct tick_work {
 	int			cpu;
+	int			state;
 	struct delayed_work	work;
 };
+// Values for ->state, see diagram below.
+#define TICK_SCHED_REMOTE_IDLE		0
+#define TICK_SCHED_REMOTE_RUNNING	1
+#define TICK_SCHED_REMOTE_OFFLINING	2
+
+// State diagram for ->state:
+//
+//
+//      +----->IDLE-----------------------------+
+//      |                                       |
+//      |                                       |
+//      |                                       | sched_tick_start()
+//      | sched_tick_remote()                   |
+//      |                                       |
+//      |                                       V
+//      |                        +---------->RUNNING
+//      |                        |              |
+//      |                        |              |
+//      |                        |              |
+//      |     sched_tick_start() |              | sched_tick_stop()
+//      |                        |              |
+//      |                        |              |
+//      |                        |              |
+//      +--------------------OFFLINING<---------+
+//
+//
+// Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
+// and sched_tick_start() are happy to leave the state in RUNNING.
 
 static struct tick_work __percpu *tick_work_cpu;
 
 static void sched_tick_remote(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
+	int os;
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
@@ -3077,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr))
+	if (is_idle_task(curr) || cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
@@ -3097,13 +3127,22 @@ static void sched_tick_remote(struct work_struct *work)
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
-	 * to keep scheduler internal stats reasonably up to date.
+	 * to keep scheduler internal stats reasonably up to date.  But
+	 * first update state to reflect hotplug activity if required.
 	 */
-	queue_delayed_work(system_unbound_wq, dwork, HZ);
+	do {
+		os = READ_ONCE(twork->state);
+		WARN_ON_ONCE(os == TICK_SCHED_REMOTE_IDLE);
+		if (os == TICK_SCHED_REMOTE_RUNNING)
+			break;
+	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_IDLE) != os);
+	if (os == TICK_SCHED_REMOTE_RUNNING)
+		queue_delayed_work(system_unbound_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3112,14 +3151,23 @@ static void sched_tick_start(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	twork->cpu = cpu;
-	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	do {
+		os = READ_ONCE(twork->state);
+		if (os == TICK_SCHED_REMOTE_RUNNING)
+			break;
+		// Either idle or offline for a short period
+	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_RUNNING) != os);
+	if (os == TICK_SCHED_REMOTE_IDLE) {
+		twork->cpu = cpu;
+		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
+		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void sched_tick_stop(int cpu)
 {
+	int os;
 	struct tick_work *twork;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
@@ -3128,7 +3176,13 @@ static void sched_tick_stop(int cpu)
 	WARN_ON_ONCE(!tick_work_cpu);
 
 	twork = per_cpu_ptr(tick_work_cpu, cpu);
-	cancel_delayed_work_sync(&twork->work);
+	// There cannot be competing actions, but don't rely on stop_machine.
+	do {
+		os = READ_ONCE(twork->state);
+		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
+		// Either idle or offline for a short period
+	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_OFFLINING) != os);
+	// Don't cancel, as this would mess up the state machine.
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 

