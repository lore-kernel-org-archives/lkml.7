Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE11C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5682087E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCJLeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:34:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfCJLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:33:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiI-00006g-CM; Sun, 10 Mar 2019 12:33:54 +0100
Subject: [GIT pull] x86 fixes for 5.1
Message-ID: <155221755097.13878.7155925164144552845.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
Date:   Sun, 10 Mar 2019 12:33:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of fixes for x86:

 - Make the unwinder more robust when it encounters a NULL pointer call, so
   the backtrace becomes more useful

 - Fix the bogus ORC unwind table alignment

 - Prevent kernel panic during kexec on HyperV caused by a cleared but not
   disabled hypercall page.

 - Remove the now pointless stacksize increase for KASAN_EXTRA, as
   KASAN_EXTRA is gone.

 - Remove unused variables from the x86 memory management code.

Thanks,

	tglx

------------------>
Jann Horn (2):
      x86/unwind: Handle NULL pointer calls better in frame unwinder
      x86/unwind: Add hardcoded ORC entry for NULL

Josh Poimboeuf (1):
      x86/unwind/orc: Fix ORC unwind table alignment

Kairui Song (1):
      x86/hyperv: Fix kernel panic when kexec on HyperV

Qian Cai (3):
      Revert "x86_64: Increase stack size for KASAN_EXTRA"
      x86/mm: Remove unused variable 'cpu'
      x86/mm: Remove unused variable 'old_pte'


 arch/x86/hyperv/hv_init.c            |  7 +++++++
 arch/x86/include/asm/page_64_types.h |  4 ----
 arch/x86/include/asm/unwind.h        |  6 ++++++
 arch/x86/kernel/unwind_frame.c       | 25 ++++++++++++++++++++++---
 arch/x86/kernel/unwind_orc.c         | 17 +++++++++++++++++
 arch/x86/mm/pageattr.c               |  4 ++--
 arch/x86/mm/tlb.c                    |  3 ---
 include/asm-generic/vmlinux.lds.h    |  2 +-
 8 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..d3f42b6bbdac 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -406,6 +406,13 @@ void hyperv_cleanup(void)
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
+	/*
+	 * Reset hypercall page reference before reset the page,
+	 * let hypercall operations fail safely rather than
+	 * panic the kernel for using invalid hypercall page
+	 */
+	hv_hypercall_pg = NULL;
+
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 0ce558a8150d..8f657286d599 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,11 +7,7 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_KASAN_EXTRA
-#define KASAN_STACK_ORDER 2
-#else
 #define KASAN_STACK_ORDER 1
-#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 1f86e1b0a5cd..499578f7e6d7 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -23,6 +23,12 @@ struct unwind_state {
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
+	/*
+	 * If non-NULL: The current frame is incomplete and doesn't contain a
+	 * valid BP. When looking for the next frame, use this instead of the
+	 * non-existent saved BP.
+	 */
+	unsigned long *next_bp;
 	struct pt_regs *regs;
 #else
 	unsigned long *sp;
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 3dc26f95d46e..9b9fd4826e7a 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -320,10 +320,14 @@ bool unwind_next_frame(struct unwind_state *state)
 	}
 
 	/* Get the next frame pointer: */
-	if (state->regs)
+	if (state->next_bp) {
+		next_bp = state->next_bp;
+		state->next_bp = NULL;
+	} else if (state->regs) {
 		next_bp = (unsigned long *)state->regs->bp;
-	else
+	} else {
 		next_bp = (unsigned long *)READ_ONCE_TASK_STACK(state->task, *state->bp);
+	}
 
 	/* Move to the next frame if it's safe: */
 	if (!update_stack_state(state, next_bp))
@@ -398,6 +402,21 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 
 	bp = get_frame_pointer(task, regs);
 
+	/*
+	 * If we crash with IP==0, the last successfully executed instruction
+	 * was probably an indirect function call with a NULL function pointer.
+	 * That means that SP points into the middle of an incomplete frame:
+	 * *SP is a return pointer, and *(SP-sizeof(unsigned long)) is where we
+	 * would have written a frame pointer if we hadn't crashed.
+	 * Pretend that the frame is complete and that BP points to it, but save
+	 * the real BP so that we can use it when looking for the next frame.
+	 */
+	if (regs && regs->ip == 0 &&
+	    (unsigned long *)kernel_stack_pointer(regs) >= first_frame) {
+		state->next_bp = bp;
+		bp = ((unsigned long *)kernel_stack_pointer(regs)) - 1;
+	}
+
 	/* Initialize stack info and make sure the frame data is accessible: */
 	get_stack_info(bp, state->task, &state->stack_info,
 		       &state->stack_mask);
@@ -410,7 +429,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	 */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->bp < first_frame))
+			(state->next_bp == NULL && state->bp < first_frame)))
 		unwind_next_frame(state);
 }
 EXPORT_SYMBOL_GPL(__unwind_start);
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 26038eacf74a..89be1be1790c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -113,6 +113,20 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
 }
 #endif
 
+/*
+ * If we crash with IP==0, the last successfully executed instruction
+ * was probably an indirect function call with a NULL function pointer,
+ * and we don't have unwind information for NULL.
+ * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
+ * pointer into its parent and then continue normally from there.
+ */
+static struct orc_entry null_orc_entry = {
+	.sp_offset = sizeof(long),
+	.sp_reg = ORC_REG_SP,
+	.bp_reg = ORC_REG_UNDEFINED,
+	.type = ORC_TYPE_CALL
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -120,6 +134,9 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (!orc_init)
 		return NULL;
 
+	if (ip == 0)
+		return &null_orc_entry;
+
 	/* For non-init vmlinux addresses, use the fast lookup table: */
 	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
 		unsigned int idx, start, stop;
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 14e6119838a6..4c570612e24e 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -738,7 +738,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 {
 	unsigned long numpages, pmask, psize, lpaddr, pfn, old_pfn;
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
-	pte_t new_pte, old_pte, *tmp;
+	pte_t new_pte, *tmp;
 	enum pg_level level;
 
 	/*
@@ -781,7 +781,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	 * Convert protection attributes to 4k-format, as cpa->mask* are set
 	 * up accordingly.
 	 */
-	old_pte = *kpte;
+
 	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8f0bef..bc4bc7b2f075 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -685,9 +685,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
-		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
 			smp_call_function_many(cpumask, flush_tlb_func_remote,
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -733,7 +733,7 @@
 		KEEP(*(.orc_unwind_ip))					\
 		__stop_orc_unwind_ip = .;				\
 	}								\
-	. = ALIGN(6);							\
+	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
 		__start_orc_unwind = .;					\
 		KEEP(*(.orc_unwind))					\

