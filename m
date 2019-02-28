Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA501218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374072;
	bh=5g+bhxB7HIyJ87MQC2jD+3vH0+PNhZPpYCV8j0ctRV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfeAda2NG3QdRA+X9epdIv45L29OCIuHPKunPUwQtMb6eXVRWoPC6DeEht5GD0o/b
	 XuYcg/6QhtbAn/uhsXD65MsPDVaeCAbOnY37Qd88sA7eTcOvdK2r9PSAS6VwgID+Sq
	 FSbWX1xiscQgYp1CDhpihpPLP6Q1DGwPE4+kzQEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfB1ROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbfB1RO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:27 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847B5218CD;
        Thu, 28 Feb 2019 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374066;
        bh=5g+bhxB7HIyJ87MQC2jD+3vH0+PNhZPpYCV8j0ctRV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1U7EY+TyKfv2DCELBDtJytwKsoESUQcgubW9ohLsWcihCth4jkuK1zgxuaoppmEeK
         3/TpxMXx3ALv2NN5maH2CxIVvh6m+lQlNlcGK7cEtApiMJc2k85d9sOD3KQ7RQCj/t
         0ZynpltU6Xs52OlMVWFlZczu2Hkf1URiD4Y87fyw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 27/37] softirq: Check enabled vectors before processing
Date:   Thu, 28 Feb 2019 18:12:32 +0100
Message-Id: <20190228171242.32144-28-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to process softirqs if none of those pending are
enabled. Check about that early to avoid unnecessary overhead.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/interrupt.h |  5 +++++
 kernel/softirq.c          | 21 +++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1f4bd62ae218..2bb8b7fcfb15 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -510,6 +510,11 @@ static inline void softirq_pending_set_mask(unsigned int pending)
 }
 #endif /* local_softirq_data */
 
+static inline int softirq_pending_enabled(void)
+{
+	return local_softirq_pending() & local_softirq_enabled();
+}
+
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
  */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index e957615102dc..6c703bbb718b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -183,7 +183,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	preempt_count_sub(cnt - 1);
 
-	if (unlikely(!in_interrupt() && local_softirq_pending())) {
+	if (unlikely(!in_interrupt() && softirq_pending_enabled())) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
 		 * as we may be calling this deep in a task call stack already.
@@ -252,7 +252,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
-	__u32 pending;
+	__u32 pending, enabled;
 	int softirq_bit;
 
 	/*
@@ -262,7 +262,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
-	pending = local_softirq_pending();
+	enabled = local_softirq_enabled();
+	pending = local_softirq_pending() & enabled;
 	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
@@ -270,7 +271,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	softirq_pending_clear_mask(SOFTIRQ_ALL_MASK);
+	softirq_pending_clear_mask(pending);
 
 	local_irq_enable();
 
@@ -307,7 +308,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		rcu_softirq_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
+	pending = local_softirq_pending() & enabled;
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
@@ -333,7 +334,7 @@ asmlinkage __visible void do_softirq(void)
 
 	local_irq_save(flags);
 
-	pending = local_softirq_pending();
+	pending = softirq_pending_enabled();
 
 	if (pending && !ksoftirqd_running(pending))
 		do_softirq_own_stack();
@@ -362,7 +363,7 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running(local_softirq_pending()))
+	if (ksoftirqd_running(softirq_pending_enabled()))
 		return;
 
 	if (!force_irqthreads) {
@@ -411,7 +412,7 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
+	if (!in_interrupt() && softirq_pending_enabled())
 		invoke_softirq();
 
 	tick_irq_exit();
@@ -642,13 +643,13 @@ void __init softirq_init(void)
 
 static int ksoftirqd_should_run(unsigned int cpu)
 {
-	return local_softirq_pending();
+	return softirq_pending_enabled();
 }
 
 static void run_ksoftirqd(unsigned int cpu)
 {
 	local_irq_disable();
-	if (local_softirq_pending()) {
+	if (softirq_pending_enabled()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
-- 
2.21.0

