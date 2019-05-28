Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD06C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347AA206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfE1PRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1PRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CD7130024D5;
        Tue, 28 May 2019 15:16:53 +0000 (UTC)
Received: from inkernel.default (ovpn-116-60.phx2.redhat.com [10.3.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 058137855C;
        Tue, 28 May 2019 15:16:50 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     williams@redhat.com, daniel@bristot.me,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping due to a preempt_counter change
Date:   Tue, 28 May 2019 17:16:23 +0200
Message-Id: <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
In-Reply-To: <cover.1559051152.git.bristot@redhat.com>
References: <cover.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 28 May 2019 15:17:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preempt_disable/enable tracepoint only traces in the disable <-> enable
case, which is correct. But think about this case:

---------------------------- %< ------------------------------
	THREAD					IRQ
	   |					 |
preempt_disable() {
    __preempt_count_add(1)
	------->	    smp_apic_timer_interrupt() {
				preempt_disable()
				    do not trace (preempt count >= 1)
				    ....
				preempt_enable()
				    do not trace (preempt count >= 1)
			    }
    trace_preempt_disable();
}
---------------------------- >% ------------------------------

The tracepoint will be skipped.

It is possible to observe this problem using this kernel module:

	http://bristot.me/files/efficient_verification/wip.tar.gz [*]

and doing the following trace:

	# cd /sys/kernel/debug/tracing/
	# echo 1 > snapshot
	# cat available_events | grep preempt_ > set_event
	# echo irq_vectors >> /sys/kernel/debug/tracing/set_event
	# insmod wip.ko
	/* wait for a snapshot creation */
	# tail -100 snapshot
		[...]
	    tail-5572  [001] ....1..  2888.401184: preempt_enable: caller=_raw_spin_unlock_irqrestore+0x2a/0x70 parent=          (null)
	    tail-5572  [001] ....1..  2888.401184: preempt_disable: caller=migrate_disable+0x8b/0x1e0 parent=migrate_disable+0x8b/0x1e0
	    tail-5572  [001] ....111  2888.401184: preempt_enable: caller=migrate_disable+0x12f/0x1e0 parent=migrate_disable+0x12f/0x1e0
	    tail-5572  [001] d..h212  2888.401189: local_timer_entry: vector=236
	    tail-5572  [001] dN.h512  2888.401192: process_event: event sched_waking not expected in the state preemptive
	    tail-5572  [001] dN.h512  2888.401200: <stack trace>
	 => process_event
	 => __handle_event
	 => ttwu_do_wakeup
	 => try_to_wake_up
	 => invoke_rcu_core
	 => rcu_check_callbacks
	 => update_process_times
	 => tick_sched_handle
	 => tick_sched_timer
	 => __hrtimer_run_queues
	 => hrtimer_interrupt
	 => smp_apic_timer_interrupt
	 => apic_timer_interrupt
	 => trace_event_raw_event_preemptirq_template
	 => trace_preempt_off
	 => get_page_from_freelist
	 => __alloc_pages_nodemask
	 => __handle_mm_fault
	 => handle_mm_fault
	 => __do_page_fault
	 => do_page_fault
	 => async_page_fault

To avoid skipping the trace, the change in the counter should be "atomic"
with the start/stop, w.r.t the interrupts.

Disable interrupts while the adding/starting stopping/subtracting.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: linux-kernel@vger.kernel.org
---
[*] with some luck we will talk about this at the Plumbers.

 kernel/sched/core.c | 48 +++++++++++++++++++++++++++++++++------------
 kernel/softirq.c    |  2 +-
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8c0b414e45dc..be4117d7384f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3163,6 +3163,16 @@ void preempt_latency_start(int val)
 	}
 }
 
+static inline void preempt_add_start_latency(int val)
+{
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	__preempt_count_add(val);
+	preempt_latency_start(val);
+	raw_local_irq_restore(flags);
+}
+
 void preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -3172,7 +3182,7 @@ void preempt_count_add(int val)
 	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
 		return;
 #endif
-	__preempt_count_add(val);
+	preempt_add_start_latency(val);
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
 	 * Spinlock count overflowing soon?
@@ -3180,7 +3190,6 @@ void preempt_count_add(int val)
 	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
 				PREEMPT_MASK - 10);
 #endif
-	preempt_latency_start(val);
 }
 EXPORT_SYMBOL(preempt_count_add);
 NOKPROBE_SYMBOL(preempt_count_add);
@@ -3195,6 +3204,16 @@ void preempt_latency_stop(int val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
+static inline void preempt_sub_stop_latency(int val)
+{
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	preempt_latency_stop(val);
+	__preempt_count_sub(val);
+	raw_local_irq_restore(flags);
+}
+
 void preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -3211,8 +3230,7 @@ void preempt_count_sub(int val)
 		return;
 #endif
 
-	preempt_latency_stop(val);
-	__preempt_count_sub(val);
+	preempt_sub_stop_latency(val);
 }
 EXPORT_SYMBOL(preempt_count_sub);
 NOKPROBE_SYMBOL(preempt_count_sub);
@@ -3220,6 +3238,16 @@ NOKPROBE_SYMBOL(preempt_count_sub);
 #else
 static inline void preempt_latency_start(int val) { }
 static inline void preempt_latency_stop(int val) { }
+
+static inline void preempt_sub_stop_latency(int val)
+{
+	__preempt_count_sub(val);
+}
+
+static inline void preempt_add_start_latency(int val)
+{
+	__preempt_count_add(val);
+}
 #endif
 
 static inline unsigned long get_preempt_disable_ip(struct task_struct *p)
@@ -3585,11 +3613,9 @@ static void __sched notrace preempt_schedule_common(void)
 		 * traced. The other to still record the preemption latency,
 		 * which can also be traced by the function tracer.
 		 */
-		preempt_disable_notrace();
-		preempt_latency_start(1);
+		preempt_add_start_latency(1);
 		__schedule(true);
-		preempt_latency_stop(1);
-		preempt_enable_no_resched_notrace();
+		preempt_sub_stop_latency(1);
 
 		/*
 		 * Check again in case we missed a preemption opportunity
@@ -3653,8 +3679,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 		 * traced. The other to still record the preemption latency,
 		 * which can also be traced by the function tracer.
 		 */
-		preempt_disable_notrace();
-		preempt_latency_start(1);
+		preempt_add_start_latency(1);
 		/*
 		 * Needs preempt disabled in case user_exit() is traced
 		 * and the tracer calls preempt_enable_notrace() causing
@@ -3664,8 +3689,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 		__schedule(true);
 		exception_exit(prev_ctx);
 
-		preempt_latency_stop(1);
-		preempt_enable_no_resched_notrace();
+		preempt_sub_stop_latency(1);
 	} while (need_resched());
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c9ad89c3dfed..9c64522ecc76 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -130,9 +130,9 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_off(ip);
-	raw_local_irq_restore(flags);
 
 	preempt_latency_start(cnt);
+	raw_local_irq_restore(flags);
 
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
-- 
2.20.1

