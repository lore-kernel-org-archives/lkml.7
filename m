Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA023C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F96020854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbfJOTSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45612 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJOTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:36 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL2-00067i-HU; Tue, 15 Oct 2019 21:18:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/34] arm64: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:49 +0200
Message-Id: <20191015191821.11479-3-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the Kconfig dependency, entry code and preemption handling over
to use CONFIG_PREEMPTION. Add PREEMPT_RT output in show_stack().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +traps.c, Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/Kconfig                 | 52 +++++++++++++++---------------
 arch/arm64/crypto/sha256-glue.c    |  2 +-
 arch/arm64/include/asm/assembler.h |  6 ++--
 arch/arm64/include/asm/preempt.h   |  4 +--
 arch/arm64/kernel/entry.S          |  2 +-
 arch/arm64/kernel/traps.c          |  3 ++
 6 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 950a56b71ff0d..4a621d6c6e676 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -35,32 +35,32 @@ config ARM64
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
diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glu=
e.c
index e273faca924f9..999da59f03a9d 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -97,7 +97,7 @@ static int sha256_update_neon(struct shash_desc *desc, co=
nst u8 *data,
 		 * input when running on a preemptible kernel, but process the
 		 * data block by block instead.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT) &&
+		if (IS_ENABLED(CONFIG_PREEMPTION) &&
 		    chunk + sctx->count % SHA256_BLOCK_SIZE > SHA256_BLOCK_SIZE)
 			chunk =3D SHA256_BLOCK_SIZE -
 				sctx->count % SHA256_BLOCK_SIZE;
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/as=
sembler.h
index b8cf7c85ffa2a..2cc0dd8bd9f78 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -699,8 +699,8 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
  * where <label> is optional, and marks the point where execution will res=
ume
  * after a yield has been performed. If omitted, execution resumes right a=
fter
  * the endif_yield_neon invocation. Note that the entire sequence, includi=
ng
- * the provided patchup code, will be omitted from the image if CONFIG_PRE=
EMPT
- * is not defined.
+ * the provided patchup code, will be omitted from the image if
+ * CONFIG_PREEMPTION is not defined.
  *
  * As a convenience, in the case where no patchup code is required, the ab=
ove
  * sequence may be abbreviated to
@@ -728,7 +728,7 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endm
=20
 	.macro		if_will_cond_yield_neon
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	get_current_task	x0
 	ldr		x0, [x0, #TSK_TI_PREEMPT]
 	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/pree=
mpt.h
index d499516470149..80e946b2abee2 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -79,11 +79,11 @@ static inline bool should_resched(int preempt_offset)
 	return pc =3D=3D preempt_offset;
 }
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
=20
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e304fe04b098d..a3f5e757983ff 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -669,7 +669,7 @@ ENDPROC(el1_sync)
=20
 	irq_handler
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	/*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 34739e80211bc..0bf934257744d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -143,9 +143,12 @@ void show_stack(struct task_struct *tsk, unsigned long=
 *sp)
=20
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
+#elif defined(CONFIG_PREEMPT_RT)
+#define S_PREEMPT " PREEMPT_RT"
 #else
 #define S_PREEMPT ""
 #endif
+
 #define S_SMP " SMP"
=20
 static int __die(const char *str, int err, struct pt_regs *regs)
--=20
2.23.0

