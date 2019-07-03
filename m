Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DCA21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNM6bhMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:28:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=From:Content-Type:MIME-Version:
        References:Subject:Cc:To:Date:Message-Id:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YPFbFVE4ekqzLPmKu9m6wIcdMQXnqOhbzRCluLZx8iQ=; b=lNM6bhMKd4ql
        mLX5tfSMk/K6wYpghkpmDSI+0pi9JFSAYpts+VXXlu0tJ4P7KFyZIriyJiGS3r2md0oCEQD0trckR
        IyP3jyeYKu5bhKtgGwTzmWPZI8uXA+TfRoHcHPe+UvCW5C9mgT8Guic9zzmWYJk4mgVepOWypVyTg
        OP1kfZCSirs4h4phIeo8mGLqmGrRxTfT0bZ6P+dV9mAoZ+3J/rSkcmCsiOtLgjX1iPkiAS5dlENmN
        19eNJmHLEzybS24iD0hik0dcE3B5lUQzy771oxxIT++JAbONIABSbf5DMyyY/9FsVfvttjcdtSm9C
        VA0+m+WWlpwCYj7fjSexog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hicV1-0006sK-Im; Wed, 03 Jul 2019 10:28:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C210A202B4822; Wed,  3 Jul 2019 12:28:25 +0200 (CEST)
Message-Id: <20190703102807.475869328@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:27:32 +0200
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH 1/3] x86/paravirt: Make read_cr2() CALLEE_SAVE
References: <20190703102731.236024951@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From:   root <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one paravirt read_cr2() implementation (Xen) is actually quite
trivial and doesn't need to clobber anything other than the return
register. By making read_cr2() CALLEE_SAVE we avoid all the PUSH/POP
nonsense and allow more convenient use from assembly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h              |    6 ++++++
 arch/x86/include/asm/paravirt.h       |   22 +++++++++++++---------
 arch/x86/include/asm/paravirt_types.h |    2 +-
 arch/x86/kernel/asm-offsets.c         |    1 +
 arch/x86/kernel/head_64.S             |    4 +---
 arch/x86/kernel/paravirt.c            |    2 +-
 arch/x86/xen/enlighten_pv.c           |    3 ++-
 arch/x86/xen/mmu_pv.c                 |   12 +-----------
 arch/x86/xen/xen-asm.S                |   17 +++++++++++++++++
 arch/x86/xen/xen-ops.h                |    3 +++
 10 files changed, 46 insertions(+), 26 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -383,3 +383,9 @@ For 32-bit we have the following convent
 .Lafter_call_\@:
 #endif
 .endm
+
+#ifdef CONFIG_PARAVIRT_XXL
+#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
+#else
+#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
+#endif
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -116,7 +116,7 @@ static inline void write_cr0(unsigned lo
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, mmu.read_cr2);
+	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
@@ -909,13 +909,7 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
 		 )
-#endif
-
-#define GET_CR2_INTO_RAX				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
@@ -929,9 +923,19 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
-#endif
+#endif /* CONFIG_PARAVIRT_XXL */
+#endif	/* CONFIG_X86_64 */
+
+#ifdef CONFIG_PARAVIRT_XXL
+
+#define GET_CR2_INTO_AX							\
+	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
+		  ANNOTATE_RETPOLINE_SAFE;				\
+		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
+		 )
+
+#endif /* CONFIG_PARAVIRT_XXL */
 
-#endif	/* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -220,7 +220,7 @@ struct pv_mmu_ops {
 	void (*exit_mmap)(struct mm_struct *mm);
 
 #ifdef CONFIG_PARAVIRT_XXL
-	unsigned long (*read_cr2)(void);
+	struct paravirt_callee_save read_cr2;
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -76,6 +76,7 @@ static void __used common(void)
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
 	OFFSET(XEN_vcpu_info_pending, vcpu_info, evtchn_upcall_pending);
+	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
 	BLANK();
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -29,9 +29,7 @@
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
-#define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
-#define GET_CR2_INTO(reg) movq %cr2, reg
 #define INTERRUPT_RETURN iretq
 #endif
 
@@ -323,7 +321,7 @@ END(early_idt_handler_array)
 
 	cmpq $14,%rsi		/* Page fault? */
 	jnz 10f
-	GET_CR2_INTO(%rdi)	/* Can clobber any volatile register if pv */
+	GET_CR2_INTO(%rdi)	/* can clobber %rax if pv */
 	call early_make_pgtable
 	andl %eax,%eax
 	jz 20f			/* All good */
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -370,7 +370,7 @@ struct paravirt_patch_template pv_ops =
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= native_read_cr2,
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -998,7 +998,8 @@ void __init xen_setup_vcpu_info_placemen
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
 			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
+		pv_ops.mmu.read_cr2 =
+			__PV_IS_CALLEE_SAVE(xen_read_cr2_direct);
 	}
 }
 
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1307,16 +1307,6 @@ static void xen_write_cr2(unsigned long
 	this_cpu_read(xen_vcpu)->arch.cr2 = cr2;
 }
 
-static unsigned long xen_read_cr2(void)
-{
-	return this_cpu_read(xen_vcpu)->arch.cr2;
-}
-
-unsigned long xen_read_cr2_direct(void)
-{
-	return this_cpu_read(xen_vcpu_info.arch.cr2);
-}
-
 static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
@@ -2397,7 +2387,7 @@ static void xen_leave_lazy_mmu(void)
 }
 
 static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = xen_read_cr2,
+	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
 	.write_cr2 = xen_write_cr2,
 
 	.read_cr3 = xen_read_cr3,
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -10,6 +10,7 @@
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/asm.h>
 
 #include <linux/linkage.h>
 
@@ -135,3 +136,19 @@ ENTRY(check_events)
 	FRAME_END
 	ret
 ENDPROC(check_events)
+
+ENTRY(xen_read_cr2)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
+	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2);
+
+ENTRY(xen_read_cr2_direct)
+	FRAME_BEGIN
+	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2_direct);
+
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -134,6 +134,9 @@ __visible void xen_irq_disable_direct(vo
 __visible unsigned long xen_save_fl_direct(void);
 __visible void xen_restore_fl_direct(unsigned long);
 
+__visible unsigned long xen_read_cr2(void);
+__visible unsigned long xen_read_cr2_direct(void);
+
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
 __visible void xen_sysret32(void);


