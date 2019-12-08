Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF1C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D882071A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLHO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:59:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfLHO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy1F-0000ed-0R; Sun, 08 Dec 2019 15:58:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89DFE1C2893;
        Sun,  8 Dec 2019 15:58:35 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:35 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, arm64: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-3-bigeasy@linutronix.de>
References: <20191015191821.11479-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711542.21853.1019709376413820687.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7ef858dad9fa6cabfe3b78997c3114cd641de6e3
Gitweb:        https://git.kernel.org/tip/7ef858dad9fa6cabfe3b78997c3114cd641de6e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:32 +01:00

sched/rt, arm64: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the Kconfig dependency, entry code and preemption handling over
to use CONFIG_PREEMPTION. Add PREEMPT_RT output in show_stack().

[bigeasy: +traps.c, Kconfig]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20191015191821.11479-3-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/Kconfig                 | 52 ++++++++++++++---------------
 arch/arm64/crypto/sha256-glue.c    |  2 +-
 arch/arm64/include/asm/assembler.h |  6 +--
 arch/arm64/include/asm/preempt.h   |  4 +-
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/kernel/traps.c          |  3 ++-
 6 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b4476..3ab0585 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -34,32 +34,32 @@ config ARM64
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_INLINE_READ_LOCK if !PREEMPT
-	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
-	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPT
-	select ARCH_INLINE_READ_UNLOCK if !PREEMPT
-	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPT
-	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPT
-	select ARCH_INLINE_WRITE_LOCK if !PREEMPT
-	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPT
-	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPT
-	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPT
-	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
-	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
-	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPT
-	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPT
-	select ARCH_INLINE_SPIN_LOCK if !PREEMPT
-	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPT
-	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPT
-	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPT
-	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPT
-	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPT
-	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPT
+	select ARCH_INLINE_READ_LOCK if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index e273fac..999da59 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -97,7 +97,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
 		 * input when running on a preemptible kernel, but process the
 		 * data block by block instead.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT) &&
+		if (IS_ENABLED(CONFIG_PREEMPTION) &&
 		    chunk + sctx->count % SHA256_BLOCK_SIZE > SHA256_BLOCK_SIZE)
 			chunk = SHA256_BLOCK_SIZE -
 				sctx->count % SHA256_BLOCK_SIZE;
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index b8cf7c8..2cc0dd8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -699,8 +699,8 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
  * where <label> is optional, and marks the point where execution will resume
  * after a yield has been performed. If omitted, execution resumes right after
  * the endif_yield_neon invocation. Note that the entire sequence, including
- * the provided patchup code, will be omitted from the image if CONFIG_PREEMPT
- * is not defined.
+ * the provided patchup code, will be omitted from the image if
+ * CONFIG_PREEMPTION is not defined.
  *
  * As a convenience, in the case where no patchup code is required, the above
  * sequence may be abbreviated to
@@ -728,7 +728,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endm
 
 	.macro		if_will_cond_yield_neon
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	get_current_task	x0
 	ldr		x0, [x0, #TSK_TI_PREEMPT]
 	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index d499516..80e946b 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -79,11 +79,11 @@ static inline bool should_resched(int preempt_offset)
 	return pc == preempt_offset;
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 583f71a..6fcb62d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -604,7 +604,7 @@ el1_irq:
 
 	irq_handler
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	/*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 73caf35..cf402be 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -144,9 +144,12 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
+#elif defined(CONFIG_PREEMPT_RT)
+#define S_PREEMPT " PREEMPT_RT"
 #else
 #define S_PREEMPT ""
 #endif
+
 #define S_SMP " SMP"
 
 static int __die(const char *str, int err, struct pt_regs *regs)
