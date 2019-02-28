Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82035C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BB620857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374087;
	bh=sQDp6eT1VW58sIsrI5OiEDC38hPd+gTguu/n1tNGuWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JktwKmSWjH4En7fqsnz2Kmv4iWCQ3LSs8OZIV4zLXI6n3kpnExpHy0aEDGS2b+4Ag
	 vbUHCuCXayuOAdEqiiD0NHCjNVY1LaePG7bkBgziCGt2wbnpVY5Xl9GJK4bjg8q4P2
	 DdY4o4z/5EJl9/wjwnloyhfc4Y9AzvnnyrPp7wU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfB1ROp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388057AbfB1ROl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:41 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB5A218E0;
        Thu, 28 Feb 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374080;
        bh=sQDp6eT1VW58sIsrI5OiEDC38hPd+gTguu/n1tNGuWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2eXHf7UaFcudEez7cxzDWElsKaOjqCfhscextmZOYtKG8oP1coV/y2QNd7IEWXLuG
         H0gbllHoLWBmT9sovPOkY4vH5UM0RK5QRL0TOAGT8aQNY7Fb2md3f7PQnE+W5XnY74
         qoXC0dYVrwCSusCKBTkF8YvsXuZcj3gSErr15V6w=
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
Subject: [PATCH 31/37] softirq: Support per vector masking
Date:   Thu, 28 Feb 2019 18:12:36 +0100
Message-Id: <20190228171242.32144-32-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the low level APIs to support per-vector masking. In order
to allow these to properly nest with itself and with full softirq
masking APIs, we provide two mechanisms:

1) Self nesting: use a caller stack saved/restored state model similar to
  that of local_irq_save() and local_irq_restore():

      bh = local_bh_disable_mask(BIT(NET_RX_SOFTIRQ));
      [...]
          bh2 = local_bh_disable_mask(BIT(TIMER_SOFTIRQ));
          [...]
          local_bh_enable_mask(bh2);
      local_bh_enable_mask(bh);

2) Nest against full masking: save the per-vector disabled state prior
   to the first full disable operation and restore it on the last full
   enable operation:

      bh = local_bh_disable_mask(BIT(NET_RX_SOFTIRQ));
      [...]
          local_bh_disable() <---- save state with NET_RX_SOFTIRQ disabled
          [...]
          local_bh_enable() <---- restore state with NET_RX_SOFTIRQ disabled
      local_bh_enable_mask(bh);

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
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
 include/linux/bottom_half.h |  7 +++
 kernel/softirq.c            | 85 +++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index ef9e4c752f56..a6996e3f4526 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -35,6 +35,10 @@ static inline void local_bh_disable(void)
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+extern unsigned int local_bh_disable_mask(unsigned long ip,
+					  unsigned int cnt, unsigned int mask);
+
+
 extern void local_bh_enable_no_softirq(void);
 extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
@@ -48,4 +52,7 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+extern void local_bh_enable_mask(unsigned long ip, unsigned int cnt,
+				 unsigned int mask);
+
 #endif /* _LINUX_BH_H */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2cddaaff3bfa..bb841e5d9951 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -61,6 +61,7 @@ DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
 struct softirq_nesting {
 	unsigned int disabled_all;
+	unsigned int enabled_vector;
 };
 
 static DEFINE_PER_CPU(struct softirq_nesting, softirq_nesting);
@@ -110,8 +111,10 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
-void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+static unsigned int local_bh_disable_common(unsigned long ip, unsigned int cnt,
+					    bool per_vec, unsigned int vec_mask)
 {
+	unsigned int enabled;
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
 
@@ -127,10 +130,31 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 */
 	__preempt_count_add(cnt);
 
-	if (__this_cpu_inc_return(softirq_nesting.disabled_all) == 1) {
-		softirq_enabled_clear_mask(SOFTIRQ_ALL_MASK);
-		trace_softirqs_off(ip);
-	}
+	enabled = local_softirq_enabled();
+
+	/*
+	 * Handle nesting of full/per-vector masking. Per vector masking
+	 * takes effect only if full masking hasn't taken place yet.
+	 */
+	if (!__this_cpu_read(softirq_nesting.disabled_all)) {
+		if (enabled & vec_mask) {
+			softirq_enabled_clear_mask(vec_mask);
+			if (!local_softirq_enabled())
+				trace_softirqs_off(ip);
+		}
+
+		/*
+		 * Save the state prior to full masking. We'll restore it
+		 * on next non-nesting full unmasking in case some vectors
+		 * have been individually disabled before (case of full masking
+		 * nesting inside per-vector masked code).
+		 */
+		if (!per_vec)
+			__this_cpu_write(softirq_nesting.enabled_vector, enabled);
+        }
+
+	if (!per_vec)
+		__this_cpu_inc(softirq_nesting.disabled_all);
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	raw_local_irq_restore(flags);
@@ -142,15 +166,38 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 #endif
 		trace_preempt_off(CALLER_ADDR0, get_lock_parent_ip());
 	}
+
+	return enabled;
+}
+
+void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+{
+	local_bh_disable_common(ip, cnt, false, SOFTIRQ_ALL_MASK);
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
-static void local_bh_enable_common(unsigned long ip, unsigned int cnt)
+unsigned int local_bh_disable_mask(unsigned long ip, unsigned int cnt,
+				   unsigned int vec_mask)
 {
-	if (__this_cpu_dec_return(softirq_nesting.disabled_all))
-		return;
+	return local_bh_disable_common(ip, cnt, true, vec_mask);
+}
+EXPORT_SYMBOL(local_bh_disable_mask);
 
-	softirq_enabled_set(SOFTIRQ_ALL_MASK);
+static void local_bh_enable_common(unsigned long ip, unsigned int cnt,
+				   bool per_vec, unsigned int mask)
+{
+	/*
+	 * Restore the previous softirq mask state. If this was the last
+	 * full unmasking, restore what was saved.
+	 */
+	if (!per_vec) {
+		if (__this_cpu_dec_return(softirq_nesting.disabled_all))
+			return;
+		else
+			mask = __this_cpu_read(softirq_nesting.enabled_vector);
+	}
+
+	softirq_enabled_set(mask);
 	trace_softirqs_on(ip);
 }
 
@@ -161,7 +208,7 @@ static void __local_bh_enable_no_softirq(unsigned int cnt)
 	if (preempt_count() == cnt)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
-	local_bh_enable_common(_RET_IP_, cnt);
+	local_bh_enable_common(_RET_IP_, cnt, false, SOFTIRQ_ALL_MASK);
 
 	__preempt_count_sub(cnt);
 }
@@ -177,14 +224,15 @@ void local_bh_enable_no_softirq(void)
 }
 EXPORT_SYMBOL(local_bh_enable_no_softirq);
 
-void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+static void local_bh_enable_ip_mask(unsigned long ip, unsigned int cnt,
+				    bool per_vec, unsigned int mask)
 {
 	WARN_ON_ONCE(in_irq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
 #endif
-	local_bh_enable_common(ip, cnt);
+	local_bh_enable_common(ip, cnt, per_vec, mask);
 
 	/*
 	 * Keep preemption disabled until we are done with
@@ -206,8 +254,21 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 #endif
 	preempt_check_resched();
 }
+
+void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+{
+	local_bh_enable_ip_mask(ip, cnt, false, SOFTIRQ_ALL_MASK);
+}
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+void local_bh_enable_mask(unsigned long ip, unsigned int cnt,
+			  unsigned int mask)
+{
+	local_bh_enable_ip_mask(ip, cnt, true, mask);
+}
+EXPORT_SYMBOL(local_bh_enable_mask);
+
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
-- 
2.21.0

