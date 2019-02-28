Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8770A218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374039;
	bh=oLV0jSajAg2rkk7VkuTEQcGuUajsksbazOyHIbaB6Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvBtJnzBlLdyzuicj+ZSIgeT2cSnWkYT6RxmhTi5MaextelLo04nOw4aMPwMGMYro
	 hNbD9PZbuengeSGjv0Jqz5f4ohKUHrCrjejU0BB00Ng3fcZAIBC7lrD89SvcChWz3T
	 N8AGc/jt3oMkcc9psQA3zPIKyswayWS1uIPYPj/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfB1RN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732988AbfB1RNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:51 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA4E218CD;
        Thu, 28 Feb 2019 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374030;
        bh=oLV0jSajAg2rkk7VkuTEQcGuUajsksbazOyHIbaB6Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2LOPlW79AgSMLHQr45Ch/qlqkj4XKys39NdH3O0GCW+V00gzP4KAW8OJwOvYvLzrg
         OlBRmn4ZtmV8rWIxiMVAh99Rw1ivarfS51PTAiL5uJcenemmg8wD6nQehAhBa3RnUN
         jXkKl2dyubkXAASmwnvxYhC0doqGO8f2b1wqkFgE=
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
Subject: [PATCH 17/37] arch/softirq: Rename softirq_pending fields to softirq_data
Date:   Thu, 28 Feb 2019 18:12:22 +0100
Message-Id: <20190228171242.32144-18-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to extend the softirq bits with an enabled vector mask.
Provide the field with a more generic name to later layout the pending
states on the lower bits and the enabled states on the higher bits.

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
 arch/arm/include/asm/hardirq.h      |  2 +-
 arch/arm64/include/asm/hardirq.h    |  2 +-
 arch/h8300/kernel/asm-offsets.c     |  2 +-
 arch/ia64/include/asm/hardirq.h     |  2 +-
 arch/ia64/include/asm/processor.h   |  2 +-
 arch/m68k/include/asm/hardirq.h     |  2 +-
 arch/m68k/kernel/asm-offsets.c      |  2 +-
 arch/parisc/include/asm/hardirq.h   |  2 +-
 arch/powerpc/include/asm/hardirq.h  |  2 +-
 arch/s390/include/asm/hardirq.h     |  6 +++---
 arch/s390/include/asm/lowcore.h     |  2 +-
 arch/sh/include/asm/hardirq.h       |  2 +-
 arch/sparc/include/asm/cpudata_64.h |  2 +-
 arch/sparc/include/asm/hardirq_64.h |  4 ++--
 arch/um/include/asm/hardirq.h       |  2 +-
 arch/x86/include/asm/hardirq.h      |  2 +-
 include/asm-generic/hardirq.h       |  2 +-
 include/linux/interrupt.h           | 10 +++++-----
 18 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23eaa6072..e5b06dd41b88 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -9,7 +9,7 @@
 #define NR_IPI	7
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 #ifdef CONFIG_SMP
 	unsigned int ipi_irqs[NR_IPI];
 #endif
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 1473fc2f7ab7..e9add887e2f2 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -23,7 +23,7 @@
 #define NR_IPI	7
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int ipi_irqs[NR_IPI];
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/h8300/kernel/asm-offsets.c b/arch/h8300/kernel/asm-offsets.c
index 85e60509f0a8..719d4cff704e 100644
--- a/arch/h8300/kernel/asm-offsets.c
+++ b/arch/h8300/kernel/asm-offsets.c
@@ -32,7 +32,7 @@ int main(void)
 
 	/* offsets into the irq_cpustat_t struct */
 	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t,
-						 __softirq_pending));
+						 __softirq_data));
 
 	/* offsets into the thread struct */
 	OFFSET(THREAD_KSP, thread_struct, ksp);
diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index ccde7c2ba00f..004f6093a11a 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending_ref	ia64_cpu_info.softirq_pending
+#define local_softirq_data_ref	ia64_cpu_info.softirq_data
 
 #include <linux/threads.h>
 #include <linux/irq.h>
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index c91ef98ed6bf..72a70c42b701 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -188,7 +188,7 @@ union  ia64_rr {
  * state comes earlier:
  */
 struct cpuinfo_ia64 {
-	unsigned int softirq_pending;
+	unsigned int softirq_data;
 	unsigned long itm_delta;	/* # of clock cycles between clock ticks */
 	unsigned long itm_next;		/* interval timer mask value to use for next clock tick */
 	unsigned long nsec_per_cyc;	/* (1000000000<<IA64_NSEC_PER_CYC_SHIFT)/itc_freq */
diff --git a/arch/m68k/include/asm/hardirq.h b/arch/m68k/include/asm/hardirq.h
index 11793165445d..6ad364cc3799 100644
--- a/arch/m68k/include/asm/hardirq.h
+++ b/arch/m68k/include/asm/hardirq.h
@@ -15,7 +15,7 @@ static inline void ack_bad_irq(unsigned int irq)
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index ccea355052ef..93b6bea52c8b 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -64,7 +64,7 @@ int main(void)
 #endif
 
 	/* offsets into the irq_cpustat_t struct */
-	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
+	DEFINE(CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_data));
 
 	/* signal defines */
 	DEFINE(LSIGSEGV, SIGSEGV);
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 1a1235a9d533..28d8ceeab077 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -17,7 +17,7 @@
 #endif
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int kernel_stack_usage;
 	unsigned int irq_stack_usage;
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f1e9067bd5ac..d3a896b402da 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int timer_irqs_event;
 	unsigned int broadcast_irqs_event;
 	unsigned int timer_irqs_others;
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0674..e26325fe287d 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -13,9 +13,9 @@
 
 #include <asm/lowcore.h>
 
-#define local_softirq_pending() (S390_lowcore.softirq_pending)
-#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
-#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
+#define local_softirq_pending() (S390_lowcore.softirq_data)
+#define set_softirq_pending(x) (S390_lowcore.softirq_data = (x))
+#define or_softirq_pending(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index cc0947e08b6f..0b6f519a38df 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -127,7 +127,7 @@ struct lowcore {
 
 	/* SMP info area */
 	__u32	cpu_nr;				/* 0x0398 */
-	__u32	softirq_pending;		/* 0x039c */
+	__u32	softirq_data;			/* 0x039c */
 	__u32	preempt_count;			/* 0x03a0 */
 	__u32	spinlock_lockval;		/* 0x03a4 */
 	__u32	spinlock_index;			/* 0x03a8 */
diff --git a/arch/sh/include/asm/hardirq.h b/arch/sh/include/asm/hardirq.h
index edaea3559a23..e364a63babd3 100644
--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 	unsigned int __nmi_count;		/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;
 
diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 9c3fc03abe9a..9e52c6bf69b9 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -11,7 +11,7 @@
 
 typedef struct {
 	/* Dcache line 1 */
-	unsigned int	__softirq_pending; /* must be 1st, see rtrap.S */
+	unsigned int	__softirq_data; /* must be 1st, see rtrap.S */
 	unsigned int	__nmi_count;
 	unsigned long	clock_tick;	/* %tick's per second */
 	unsigned long	__pad;
diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index 75b92bfe04b5..8ff0458870e1 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -11,8 +11,8 @@
 
 #define __ARCH_IRQ_STAT
 
-#define local_softirq_pending_ref \
-	__cpu_data.__softirq_pending
+#define local_softirq_data_ref \
+	__cpu_data.__softirq_data
 
 void ack_bad_irq(unsigned int irq);
 
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796d26fd..96844938b92e 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index a8e8e126b421..875f7de3b65b 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214dfc10b..4ea87b50a257 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	unsigned int __softirq_data;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e871f361f1f1..a32bdd9bb103 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -449,13 +449,13 @@ extern bool force_irqthreads;
 
 #ifndef local_softirq_pending
 
-#ifndef local_softirq_pending_ref
-#define local_softirq_pending_ref irq_stat.__softirq_pending
+#ifndef local_softirq_data_ref
+#define local_softirq_data_ref irq_stat.__softirq_data
 #endif
 
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
-#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
+#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
 
 #endif /* local_softirq_pending */
 
-- 
2.21.0

