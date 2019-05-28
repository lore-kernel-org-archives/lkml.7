Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FEA206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfE1PQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfE1PQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE8A08112C;
        Tue, 28 May 2019 15:16:50 +0000 (UTC)
Received: from inkernel.default (ovpn-116-60.phx2.redhat.com [10.3.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EDDA7857F;
        Tue, 28 May 2019 15:16:44 +0000 (UTC)
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
Subject: [RFC 1/3] softirq: Use preempt_latency_stop/start to trace preemption
Date:   Tue, 28 May 2019 17:16:22 +0200
Message-Id: <b6bb4705efb0c01c11008ae3c46bc74555245303.1559051152.git.bristot@redhat.com>
In-Reply-To: <cover.1559051152.git.bristot@redhat.com>
References: <cover.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 28 May 2019 15:16:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prempt_disable/enable tracepoints occurs only in the preemption
enabled <-> disable transition. As preempt_latency_stop() and
preempt_latency_start() already do this control, avoid code
duplication by using these functions in the softirq code as well.

RFC: Should we move preempt_latency_start/preempt_latency_stop
to a trace source file... or even a header?

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
 kernel/sched/core.c |  4 ++--
 kernel/softirq.c    | 13 +++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..8c0b414e45dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3152,7 +3152,7 @@ static inline void sched_tick_stop(int cpu) { }
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
  */
-static inline void preempt_latency_start(int val)
+void preempt_latency_start(int val)
 {
 	if (preempt_count() == val) {
 		unsigned long ip = get_lock_parent_ip();
@@ -3189,7 +3189,7 @@ NOKPROBE_SYMBOL(preempt_count_add);
  * If the value passed in equals to the current preempt count
  * then we just enabled preemption. Stop timing the latency.
  */
-static inline void preempt_latency_stop(int val)
+void preempt_latency_stop(int val)
 {
 	if (preempt_count() == val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2c3382378d94..c9ad89c3dfed 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -108,6 +108,8 @@ static bool ksoftirqd_running(unsigned long pending)
  * where hardirqs are disabled legitimately:
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
+extern void preempt_latency_start(int val);
+extern void preempt_latency_stop(int val);
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -130,12 +132,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 		trace_softirqs_off(ip);
 	raw_local_irq_restore(flags);
 
-	if (preempt_count() == cnt) {
-#ifdef CONFIG_DEBUG_PREEMPT
-		current->preempt_disable_ip = get_lock_parent_ip();
-#endif
-		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
-	}
+	preempt_latency_start(cnt);
+
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
@@ -144,8 +142,7 @@ static void __local_bh_enable(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (preempt_count() == cnt)
-		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+	preempt_latency_stop(cnt);
 
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_on(_RET_IP_);
-- 
2.20.1

