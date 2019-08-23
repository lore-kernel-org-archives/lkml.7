Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A87C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4306E21726
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHXGNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:13:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40675 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHXGNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:13:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so6887422pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLsAZpPUSLCjP+n1AooU4bL1VvUeXeMxazo5ldDPPmE=;
        b=gs+OucbmSZVzYw3+NzIr7e8F8uUJtlhle2M9ThS2w/oIxoMYoYLUUl2K9L9l9N7Z4P
         DkjDNaGbWWD4IK/uNX5veP9+owTS0Lk5umWaxc1AyQkyCXlkb0ssLtWEsGAsauyCJR5T
         +hQxDbv1NmGSedauiPCrfyhsceVizC0jVN5JGkhQkRdwVxcrUx7Pqp+F3PMi3xKeUgd3
         orBsD7lAG/9kjddq4UYXwB4GAzziQyjWCjqyqYkqWj4BzUZYafDxUzXPAOhx08YohBvQ
         /IYajrL1D7FNjBSSgtUk4tRrtgbsWaXOlgUs5DncGWm8WngDjlvt757hwnVyjM1nY+b0
         X/Hw==
X-Gm-Message-State: APjAAAWr/NPEgwMawZAcU2XRvu8t6f6ypVaiCOl0U3mxvi88R/NaCSK+
        2QLLsfq/xWTVSTwM0MuQTvpLC1fSaiTTMw==
X-Google-Smtp-Source: APXvYqztBWtL/ZWq1zYhPcgwQzhLCwSR/CXRMLofCCmXPflFrEwyN3XCLpkSO/s//mXnDjPqd38Vpw==
X-Received: by 2002:a17:902:6a8c:: with SMTP id n12mr8568059plk.159.1566627204320;
        Fri, 23 Aug 2019 23:13:24 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o9sm3691360pgv.19.2019.08.23.23.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:13:23 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
Date:   Fri, 23 Aug 2019 15:52:47 -0700
Message-Id: <20190823225248.15597-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823225248.15597-1-namit@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INVPCID is considerably slower than INVLPG of a single PTE. Using it to
flush the user page-tables when PTI is enabled therefore introduces
significant overhead.

Instead, unless page-tables are released, it is possible to defer the
flushing of the user page-tables until the time the code returns to
userspace. These page tables are not in use, so deferring them is not a
security hazard. When CR3 is loaded, as part of returning to userspace,
use INVLPG to flush the relevant PTEs. Use LFENCE to prevent speculative
executions that skip INVLPG.

There are some caveats, which sometime require a full TLB flush of the
user page-tables. There are some (uncommon) code-paths that reload CR3
in which there is not stack. If a context-switch happens and there are
pending flushes, tracking which TLB flushes are later needed is
complicated and expensive. If there are multiple TLB flushes of
different ranges before the kernel returns to userspace, the overhead of
tracking them can exceed the benefit.

In these cases, perform a full TLB flush. It is possible to avoid them
in some cases, but the benefit in doing so is questionable.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/calling.h        | 52 ++++++++++++++++++++++--
 arch/x86/include/asm/tlbflush.h | 30 +++++++++++---
 arch/x86/kernel/asm-offsets.c   |  3 ++
 arch/x86/mm/tlb.c               | 70 +++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 515c0ceeb4a3..a4d46416853d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/tlbflush.h>
 
 /*
 
@@ -205,7 +206,16 @@ For 32-bit we have the following conventions - kernel is built with
 #define THIS_CPU_user_pcid_flush_mask   \
 	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_pcid_flush_mask
 
-.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
+#define THIS_CPU_user_flush_start	\
+	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_flush_start
+
+#define THIS_CPU_user_flush_end	\
+	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_flush_end
+
+#define THIS_CPU_user_flush_stride_shift	\
+	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_flush_stride_shift
+
+.macro SWITCH_TO_USER_CR3 scratch_reg:req scratch_reg2:req has_stack:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 	mov	%cr3, \scratch_reg
 
@@ -221,9 +231,41 @@ For 32-bit we have the following conventions - kernel is built with
 
 	/* Flush needed, clear the bit */
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
+.if \has_stack
+	cmpq	$(TLB_FLUSH_ALL), THIS_CPU_user_flush_end
+	jnz	.Lpartial_flush_\@
+.Ldo_full_flush_\@:
+.endif
 	movq	\scratch_reg2, \scratch_reg
 	jmp	.Lwrcr3_pcid_\@
-
+.if \has_stack
+.Lpartial_flush_\@:
+	/* Prepare CR3 with PGD of user, and no flush set */
+	orq	$(PTI_USER_PGTABLE_AND_PCID_MASK), \scratch_reg2
+	SET_NOFLUSH_BIT \scratch_reg2
+	pushq	%rsi
+	pushq	%rbx
+	pushq	%rcx
+	movb	THIS_CPU_user_flush_stride_shift, %cl
+	movq	$1, %rbx
+	shl	%cl, %rbx
+	movq	THIS_CPU_user_flush_start, %rsi
+	movq	THIS_CPU_user_flush_end, %rcx
+	/* Load the new cr3 and flush */
+	mov	\scratch_reg2, %cr3
+.Lflush_loop_\@:
+	invlpg	(%rsi)
+	addq	%rbx, %rsi
+	cmpq	%rsi, %rcx
+	ja	.Lflush_loop_\@
+	/* Prevent speculatively skipping flushes */
+	lfence
+
+	popq	%rcx
+	popq	%rbx
+	popq	%rsi
+	jmp	.Lend_\@
+.endif
 .Lnoflush_\@:
 	movq	\scratch_reg2, \scratch_reg
 	SET_NOFLUSH_BIT \scratch_reg
@@ -239,9 +281,13 @@ For 32-bit we have the following conventions - kernel is built with
 .Lend_\@:
 .endm
 
+.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
+	SWITCH_TO_USER_CR3 scratch_reg=\scratch_reg scratch_reg2=%rax has_stack=0
+.endm
+
 .macro SWITCH_TO_USER_CR3_STACK	scratch_reg:req
 	pushq	%rax
-	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=\scratch_reg scratch_reg2=%rax
+	SWITCH_TO_USER_CR3 scratch_reg=\scratch_reg scratch_reg2=%rax has_stack=1
 	popq	%rax
 .endm
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 421bc82504e2..da56aa3ccd07 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_X86_TLBFLUSH_H
 #define _ASM_X86_TLBFLUSH_H
 
+#define TLB_FLUSH_ALL	-1UL
+
+#ifndef __ASSEMBLY__
+
 #include <linux/mm.h>
 #include <linux/sched.h>
 
@@ -222,6 +226,10 @@ struct tlb_state {
 	 * context 0.
 	 */
 	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
+
+	unsigned long user_flush_start;
+	unsigned long user_flush_end;
+	unsigned long user_flush_stride_shift;
 };
 DECLARE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate);
 
@@ -373,6 +381,16 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 
 extern void initialize_tlbstate_and_flush(void);
 
+static unsigned long *this_cpu_user_pcid_flush_mask(void)
+{
+	return (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask);
+}
+
+static inline void set_pending_user_pcid_flush(u16 asid)
+{
+	__set_bit(kern_pcid(asid), this_cpu_user_pcid_flush_mask());
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -395,8 +413,10 @@ static inline void invalidate_user_asid(u16 asid)
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	__set_bit(kern_pcid(asid),
-		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
+	set_pending_user_pcid_flush(asid);
+
+	/* Mark the flush as global */
+	__this_cpu_write(cpu_tlbstate.user_flush_end, TLB_FLUSH_ALL);
 }
 
 /*
@@ -516,8 +536,6 @@ static inline void __flush_tlb_one_kernel(unsigned long addr)
 	invalidate_other_asid();
 }
 
-#define TLB_FLUSH_ALL	-1UL
-
 /*
  * TLB flushing:
  *
@@ -580,7 +598,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 }
 
 void native_flush_tlb_multi(const struct cpumask *cpumask,
-			     const struct flush_tlb_info *info);
+			    const struct flush_tlb_info *info);
 
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
@@ -610,4 +628,6 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 	tlb_remove_page(tlb, (void *)(page))
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 5c7ee3df4d0b..bfbe393a5f46 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -95,6 +95,9 @@ static void __used common(void)
 
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
+	OFFSET(TLB_STATE_user_flush_start, tlb_state, user_flush_start);
+	OFFSET(TLB_STATE_user_flush_end, tlb_state, user_flush_end);
+	OFFSET(TLB_STATE_user_flush_stride_shift, tlb_state, user_flush_stride_shift);
 
 	/* Layout info for cpu_entry_area */
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ad15fc2c0790..31260c55d597 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -407,6 +407,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
+		/*
+		 * If the indication of partial flush is on, setting the end to
+		 * TLB_FLUSH_ALL would mark a full flush is need. Do it
+		 * unconditionally, since anyhow it is benign.  Alternatively,
+		 * we could conditionally flush the deferred range, but it is
+		 * likely to perform worse.
+		 */
+		if (static_cpu_has(X86_FEATURE_PTI))
+			__this_cpu_write(cpu_tlbstate.user_flush_end, TLB_FLUSH_ALL);
+
 		/* Let nmi_uaccess_okay() know that we're changing CR3. */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
@@ -512,6 +522,58 @@ void initialize_tlbstate_and_flush(void)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
 }
 
+/*
+ * Defer the TLB flush to the point we return to userspace.
+ */
+static void flush_user_tlb_deferred(u16 asid, unsigned long start,
+				    unsigned long end, u8 stride_shift)
+{
+	unsigned long prev_start, prev_end;
+	u8 prev_stride_shift;
+
+	/*
+	 * Check if this is the first deferred flush of the user page tables.
+	 * If it is the first one, we simply record the pending flush.
+	 */
+	if (!test_bit(kern_pcid(asid), this_cpu_user_pcid_flush_mask())) {
+		__this_cpu_write(cpu_tlbstate.user_flush_start, start);
+		__this_cpu_write(cpu_tlbstate.user_flush_end, end);
+		__this_cpu_write(cpu_tlbstate.user_flush_stride_shift, stride_shift);
+		set_pending_user_pcid_flush(asid);
+		return;
+	}
+
+	prev_end = __this_cpu_read(cpu_tlbstate.user_flush_end);
+	prev_start = __this_cpu_read(cpu_tlbstate.user_flush_start);
+	prev_stride_shift = __this_cpu_read(cpu_tlbstate.user_flush_stride_shift);
+
+	/* If we already have a full pending flush, we are done */
+	if (prev_end == TLB_FLUSH_ALL)
+		return;
+
+	/*
+	 * We already have a pending flush, check if we can merge with the
+	 * previous one.
+	 */
+	if (start >= prev_start && stride_shift == prev_stride_shift) {
+		/*
+		 * Unlikely, but if the new range falls inside the old range we
+		 * are done. This check is required for correctness.
+		 */
+		if (end < prev_end)
+			return;
+
+		/* Check if a single range can also hold this flush. */
+		if ((end - prev_start) >> stride_shift < tlb_single_page_flush_ceiling) {
+			__this_cpu_write(cpu_tlbstate.user_flush_end, end);
+			return;
+		}
+	}
+
+	/* We cannot merge. Do a full flush instead */
+	__this_cpu_write(cpu_tlbstate.user_flush_end, TLB_FLUSH_ALL);
+}
+
 static void flush_tlb_user_pt_range(u16 asid, const struct flush_tlb_info *f)
 {
 	unsigned long start, end, addr;
@@ -528,6 +590,14 @@ static void flush_tlb_user_pt_range(u16 asid, const struct flush_tlb_info *f)
 	end = f->end;
 	stride_shift = f->stride_shift;
 
+	/*
+	 * We can defer flushes as long as page-tables were not freed.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64) && !f->freed_tables) {
+		flush_user_tlb_deferred(asid, start, end, stride_shift);
+		return;
+	}
+
 	/*
 	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
 	 * Just use invalidate_user_asid() in case we are called early.
-- 
2.17.1

