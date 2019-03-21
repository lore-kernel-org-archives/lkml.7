Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974A221900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCFqb7o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfCURWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:22:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfCURWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z+N/akuzQ8BzxkeqGmX4d6KWUagaOGRUdI3NkPF3IPw=; b=DCFqb7o1qfh45cRBaEGJivBHW
        VInlPWZYYWkAXj+D+U96+2lY21VAXRYCRX7Lzf+jibjlOyNk5S5aew2E2Anpp/OuS4rFuWeqHesYx
        N/d+OLLrhMU5lmMRpIWnNJWFdclYMRCPgBjn/bPT2FP8g9VV7RypK6eSk8VyrdgH0/gXxqQ0gDbKb
        PdWYflM0aeuIgaWfOUjbPYC64FQQM0jqir5mPe6oHe2PCuNF0Qy8wGLt1tBuTzBcm3thc3A3weY0M
        qn9fAao58hp3DDTjQD82pm/cwBCLSaLOrpE1CzSxhTVptOaTJ5NBF3p+apZolKXIQDHa0gCd/n4dq
        Q2Lx2K4cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h71OG-0001Bm-To; Thu, 21 Mar 2019 17:22:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D9EA203CBE18; Thu, 21 Mar 2019 18:22:03 +0100 (CET)
Date:   Thu, 21 Mar 2019 18:22:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321172203.GS5996@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321093242.4a948198@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:32:42AM -0400, Steven Rostedt wrote:
> On Thu, 21 Mar 2019 11:45:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > -	.if \paranoid
> > +	.if \read_cr2
> > +	mov	%cr2, %rdx			/* XXX paravirt crap */
> > +	.endif
> > +
> 
> I'm guessing this breaks paravirt, as that's one reason I didn't add
> the read_rc in assembly.

Still completely missing 32bit support.. but this has paravirt bits on.

It changes the read_cr2 stuff to CALLEE_SAVED and implements it in asm
to only require AX, this means that asm can use it without it clobbering
all volatile regs.

My compiler also tripped over the KVM asyn pagefault stuff, which I also
converted to use the new form.

Again, completely untested. And given that the last one just worked,
this one will _have_ to explode and let the magic smoke out :-)

---
 arch/x86/entry/entry_64.S             | 36 ++++++++++++++++++++++-------------
 arch/x86/include/asm/kvm_para.h       |  2 +-
 arch/x86/include/asm/paravirt.h       | 10 ++++++----
 arch/x86/include/asm/paravirt_types.h |  2 +-
 arch/x86/include/asm/traps.h          |  2 +-
 arch/x86/kernel/asm-offsets.c         |  1 +
 arch/x86/kernel/head_64.S             |  2 +-
 arch/x86/kernel/kvm.c                 |  8 ++++----
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/mm/fault.c                   |  3 +--
 arch/x86/xen/enlighten_pv.c           |  3 ++-
 arch/x86/xen/mmu_pv.c                 | 12 +-----------
 arch/x86/xen/xen-asm.S                | 25 ++++++++++++++++++++++++
 arch/x86/xen/xen-ops.h                |  3 +++
 14 files changed, 71 insertions(+), 40 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..40a0af6ae862 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -42,6 +42,12 @@
 
 #include "calling.h"
 
+#ifdef CONFIG_PARAVIRT_XXL
+#define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
+#else
+#define GET_CR2_INTO(reg) movq %cr2, reg
+#endif
+
 .code64
 .section .entry.text, "ax"
 
@@ -879,7 +885,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 read_cr2=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -901,18 +907,28 @@ ENTRY(\sym)
 
 	.if \paranoid
 	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 	.else
 	call	error_entry
+	/* returned flag: ebx=1: CALL_enter_from_user_mode, ebx=0: don't need it */
 	.endif
 	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 
-	.if \paranoid
+	.if \read_cr2
+	GET_CR2_INTO(%rdx);			/* can clobber %rax */
+	.endif
+
 	.if \shift_ist != -1
 	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
 	.else
 	TRACE_IRQS_OFF
 	.endif
+
+	.if \paranoid == 0
+	testl	%ebx, %ebx
+	jz	.Lno_context_tracking_\@
+	CALL_enter_from_user_mode
+.Lno_context_tracking_\@:
 	.endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer */
@@ -1140,10 +1156,10 @@ idtentry xenint3		do_int3			has_error_code=0
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
 
 #ifdef CONFIG_KVM_GUEST
-idtentry async_page_fault	do_async_page_fault	has_error_code=1
+idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
 #endif
 
 #ifdef CONFIG_X86_MCE
@@ -1243,17 +1259,11 @@ ENTRY(error_entry)
 	ENCODE_FRAME_POINTER
 	pushq	%r12
 
-	/*
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).
-	 */
-	TRACE_IRQS_OFF
-	CALL_enter_from_user_mode
+	mov	$1, %ebx			/* CALL_enter_from_user_mode */
 	ret
 
 .Lerror_entry_done:
-	TRACE_IRQS_OFF
+	xorl	%ebx, %ebx
 	ret
 
 	/*
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 5ed3cf1c3934..9b4df6eaa11a 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -92,7 +92,7 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
 void kvm_async_pf_task_wake(u32 token);
 u32 kvm_read_and_reset_pf_reason(void);
 extern void kvm_disable_steal_time(void);
-void do_async_page_fault(struct pt_regs *regs, unsigned long error_code);
+void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..a0f25b9af88c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -116,7 +116,7 @@ static inline void write_cr0(unsigned long x)
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, mmu.read_cr2);
+	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
@@ -911,9 +911,11 @@ extern void default_banner(void);
 		 )
 #endif
 
-#define GET_CR2_INTO_RAX				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
+#define GET_CR2_INTO_RAX						\
+	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
+		  ANNOTATE_RETPOLINE_SAFE;				\
+		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
+		 )
 
 #ifdef CONFIG_PARAVIRT_XXL
 #define USERGS_SYSRET64							\
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..8e46f1b764a3 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -220,7 +220,7 @@ struct pv_mmu_ops {
 	void (*exit_mmap)(struct mm_struct *mm);
 
 #ifdef CONFIG_PARAVIRT_XXL
-	unsigned long (*read_cr2)(void);
+	struct paravirt_callee_save read_cr2;
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7d6f3f3fad78..1530909fbf70 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -81,7 +81,7 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
 #endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
-dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 168543d077d7..851199e5b478 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -77,6 +77,7 @@ static void __used common(void)
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
 	OFFSET(XEN_vcpu_info_pending, vcpu_info, evtchn_upcall_pending);
+	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
 	BLANK();
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d1dbe8e4eb82..7f21e16315d3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -323,7 +323,7 @@ END(early_idt_handler_array)
 
 	cmpq $14,%rsi		/* Page fault? */
 	jnz 10f
-	GET_CR2_INTO(%rdi)	/* Can clobber any volatile register if pv */
+	GET_CR2_INTO(%rdi)	/* can clobber %rax if pv */
 	call early_make_pgtable
 	andl %eax,%eax
 	jz 20f			/* All good */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5c93a65ee1e5..6396f1628c63 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -255,23 +255,23 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
 NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
 
 dotraplinkage void
-do_async_page_fault(struct pt_regs *regs, unsigned long error_code)
+do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	enum ctx_state prev_state;
 
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
-		do_page_fault(regs, error_code);
+		do_page_fault(regs, error_code, address);
 		break;
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
 		/* page is swapped out by the host. */
 		prev_state = exception_enter();
-		kvm_async_pf_task_wait((u32)read_cr2(), !user_mode(regs));
+		kvm_async_pf_task_wait((u32)address, !user_mode(regs));
 		exception_exit(prev_state);
 		break;
 	case KVM_PV_REASON_PAGE_READY:
 		rcu_irq_enter();
-		kvm_async_pf_task_wake((u32)read_cr2());
+		kvm_async_pf_task_wake((u32)address);
 		rcu_irq_exit();
 		break;
 	}
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c0e0101133f3..e853d129f100 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -382,7 +382,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.exit_mmap		= paravirt_nop,
 
 #ifdef CONFIG_PARAVIRT_XXL
-	.mmu.read_cr2		= native_read_cr2,
+	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(native_read_cr2),
 	.mmu.write_cr2		= native_write_cr2,
 	.mmu.read_cr3		= __native_read_cr3,
 	.mmu.write_cr3		= native_write_cr3,
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..aac7a74869a2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1560,9 +1560,8 @@ trace_page_fault_entries(unsigned long address, struct pt_regs *regs,
  * exception_{enter,exit}() contains all sorts of tracepoints.
  */
 dotraplinkage void notrace
-do_page_fault(struct pt_regs *regs, unsigned long error_code)
+do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	unsigned long address = read_cr2(); /* Get the faulting address */
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c54a493e139a..f90a1b67f924 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -998,7 +998,8 @@ void __init xen_setup_vcpu_info_placement(void)
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
 			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
+		pv_ops.mmu.read_cr2 =
+			__PV_IS_CALLEE_SAVE(xen_read_cr2_direct);
 	}
 }
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a21e1734fc1f..921e727305bc 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1307,16 +1307,6 @@ static void xen_write_cr2(unsigned long cr2)
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
@@ -2399,7 +2389,7 @@ static void xen_leave_lazy_mmu(void)
 }
 
 static const struct pv_mmu_ops xen_mmu_ops __initconst = {
-	.read_cr2 = xen_read_cr2,
+	.read_cr2 = __PV_IS_CALLEE_SAVE(xen_read_cr2),
 	.write_cr2 = xen_write_cr2,
 
 	.read_cr3 = xen_read_cr3,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 8019edd0125c..673b93d56c8a 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -135,3 +135,28 @@ ENTRY(check_events)
 	FRAME_END
 	ret
 ENDPROC(check_events)
+
+ENTRY(xen_read_cr2)
+	FRAME_BEGIN
+#ifdef CONFIG_X86_64
+	movq	PER_CPU_VAR(xen_vcpu), %rax
+	movq	XEN_vcpu_info_arch_cr2(%rax), %rax
+#else
+	movl	PER_CPU_VAR(xen_vcpu), %eax
+	movl	XEN_vcpu_info_arch_cr2(%eax), %eax
+#endif
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2);
+
+ENTRY(xen_read_cr2_direct)
+	FRAME_BEGIN
+#ifdef CONFIG_X86_64
+	movq	PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %rax
+#else
+	movl	PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %eax
+#endif
+	FRAME_END
+	ret
+	ENDPROC(xen_read_cr2_direct);
+
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0e60bd918695..38767bbe0034 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -134,6 +134,9 @@ __visible void xen_irq_disable_direct(void);
 __visible unsigned long xen_save_fl_direct(void);
 __visible void xen_restore_fl_direct(unsigned long);
 
+__visible unsigned long xen_read_cr2(void);
+__visible unsigned long xen_read_cr2_direct(void);
+
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
 __visible void xen_sysret32(void);
