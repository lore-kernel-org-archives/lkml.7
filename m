Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46395C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8E1206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfE1PRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29101 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1PRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:17:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6044A9FFCC;
        Tue, 28 May 2019 15:17:02 +0000 (UTC)
Received: from inkernel.default (ovpn-116-60.phx2.redhat.com [10.3.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C70F97856B;
        Tue, 28 May 2019 15:16:53 +0000 (UTC)
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
Subject: [RFC 3/3] preempt_tracer: Use a percpu variable to control traceble calls
Date:   Tue, 28 May 2019 17:16:24 +0200
Message-Id: <9b0698774be3bb406e2b8b2c12dc1fb91532bff0.1559051152.git.bristot@redhat.com>
In-Reply-To: <cover.1559051152.git.bristot@redhat.com>
References: <cover.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 28 May 2019 15:17:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preempt_disable tracepoint only traces in the disable <-> enable case.
Which is correct, but think about this case:

--------------------------- %< ----------------------
	 THREAD					IRQ
	   |					 |
preempt_disable_notrace() {
    __preempt_count_add(1)
}

/* preemption disabled/IRQs enabled */

	------->		smp_apic_timer_interrupt() {
				    preempt_disable() {
					do not trace (preempt count >= 1)
				    }
				    ....
				    preempt_enable() {
						do not trace (preempt count >= 1)
				    }
	<-------		}
preempt_enable_notrace() {
    __preempt_count_sub(1)
}
--------------------------- >% ----------------------

The non-traceble preempt_disable can hide a legit preempt_disable (which
is worth tracing).

It is possible to observe this problem using this kernel module:

    http://bristot.me/files/efficient_verification/wip.tar.gz

and doing the following trace:

	# cd /sys/kernel/debug/tracing/
	# echo 1 > snapshot
	# cat available_events | grep preempt_ > set_event
	# echo irq_vectors >> /sys/kernel/debug/tracing/set_event
	# insmod wip.ko
	/* wait for a snapshot creation */
	# tail -100 snapshot
	    sshd-1159  [000] d...1..  2440.866116: preempt_enable: caller=migrate_enable+0x1bb/0x330 parent=migrate_enable+0x1bb/0x330
	    sshd-1159  [000] d..h1..  2440.866122: local_timer_entry: vector=236
	    sshd-1159  [000] d..h1..  2440.866127: local_timer_exit: vector=236
	    sshd-1159  [000] d.L.4..  2440.866129: process_event: event sched_waking not expected in the state preemptive
	    sshd-1159  [000] d.L.4..  2440.866137: <stack trace>
	 => process_event
	 => __handle_event
	 => ttwu_do_wakeup
	 => try_to_wake_up
	 => irq_exit
	 => smp_apic_timer_interrupt
	 => apic_timer_interrupt
	 => kvm_clock_read
	 => ktime_get_with_offset
	 => posix_get_boottime
	 => __x64_sys_clock_gettime
	 => do_syscall_64
	 => entry_SYSCALL_64_after_hwframe

and kvm_clock_read() disables preemption without tracing:

--------------------------- %< ----------------------
static u64 kvm_clock_read(void)
{
	u64 ret;

	preempt_disable_notrace();
	ret = pvclock_clocksource_read(this_cpu_pvti());
	preempt_enable_notrace();
	return ret;
}
--------------------------- >% ----------------------

Use a percpu variable for the traced preempt_disable/enable, and use it
to decide whether trace or not.

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
 kernel/sched/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be4117d7384f..2e07d4174778 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3148,19 +3148,25 @@ static inline void sched_tick_stop(int cpu) { }
 
 #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
 				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
+
+DEFINE_PER_CPU(int, __traced_preempt_count) = 0;
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
  */
 void preempt_latency_start(int val)
 {
-	if (preempt_count() == val) {
+	int curr = this_cpu_read(__traced_preempt_count);
+
+	if (!curr) {
 		unsigned long ip = get_lock_parent_ip();
 #ifdef CONFIG_DEBUG_PREEMPT
 		current->preempt_disable_ip = ip;
 #endif
 		trace_preempt_off(CALLER_ADDR0, ip);
 	}
+
+	this_cpu_write(__traced_preempt_count, curr + val);
 }
 
 static inline void preempt_add_start_latency(int val)
@@ -3200,8 +3206,12 @@ NOKPROBE_SYMBOL(preempt_count_add);
  */
 void preempt_latency_stop(int val)
 {
-	if (preempt_count() == val)
+	int curr = this_cpu_read(__traced_preempt_count) - val;
+
+	if (!curr)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
+	this_cpu_write(__traced_preempt_count, curr);
 }
 
 static inline void preempt_sub_stop_latency(int val)
-- 
2.20.1

