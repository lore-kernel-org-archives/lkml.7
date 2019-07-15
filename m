Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D66C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF587206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfGOLhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfGOLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 994F2AC58;
        Mon, 15 Jul 2019 11:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 1/2] x86/xen: remove 32-bit Xen PV guest support
Date:   Mon, 15 Jul 2019 13:37:38 +0200
Message-Id: <20190715113739.17694-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190715113739.17694-1-jgross@suse.com>
References: <20190715113739.17694-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen is requiring 64-bit machines today. There is no need to carry the
burden of 32-bit PV guest support in the kernel any longer, as new
guests can be either HVM or PVH, or they can use a 64 bit kernel.

Remove the 32-bit Xen PV support from the kernel.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/entry_32.S      |  93 ------------
 arch/x86/include/asm/proto.h   |   2 +-
 arch/x86/include/asm/segment.h |   2 +-
 arch/x86/include/asm/traps.h   |   2 +-
 arch/x86/xen/Kconfig           |   3 +-
 arch/x86/xen/Makefile          |   4 +-
 arch/x86/xen/apic.c            |  17 ---
 arch/x86/xen/enlighten_pv.c    |  45 +-----
 arch/x86/xen/mmu_pv.c          | 326 ++++-------------------------------------
 arch/x86/xen/p2m.c             |   4 -
 arch/x86/xen/setup.c           |  44 +-----
 arch/x86/xen/smp_pv.c          |  19 +--
 arch/x86/xen/xen-asm.S         |  14 --
 arch/x86/xen/xen-asm_32.S      | 207 --------------------------
 arch/x86/xen/xen-head.S        |   6 -
 arch/x86/xen/xen-ops.h         |   5 -
 drivers/xen/Kconfig            |   4 +-
 17 files changed, 42 insertions(+), 755 deletions(-)
 delete mode 100644 arch/x86/xen/xen-asm_32.S

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7b23431be5cb..d4464af28212 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -787,16 +787,6 @@ GLOBAL(__begin_SYSENTER_singlestep_region)
  * will ignore all of the single-step traps generated in this range.
  */
 
-#ifdef CONFIG_XEN_PV
-/*
- * Xen doesn't set %esp to be precisely what the normal SYSENTER
- * entry point expects, so fix it up before using the normal path.
- */
-ENTRY(xen_sysenter_target)
-	addl	$5*4, %esp			/* remove xen-provided frame */
-	jmp	.Lsysenter_past_esp
-#endif
-
 /*
  * 32-bit SYSENTER entry.
  *
@@ -1249,89 +1239,6 @@ ENTRY(spurious_interrupt_bug)
 	jmp	common_exception
 END(spurious_interrupt_bug)
 
-#ifdef CONFIG_XEN_PV
-ENTRY(xen_hypervisor_callback)
-	pushl	$-1				/* orig_ax = -1 => not a system call */
-	SAVE_ALL
-	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
-
-	/*
-	 * Check to see if we got the event in the critical
-	 * region in xen_iret_direct, after we've reenabled
-	 * events and checked for pending events.  This simulates
-	 * iret instruction's behaviour where it delivers a
-	 * pending interrupt when enabling interrupts:
-	 */
-	movl	PT_EIP(%esp), %eax
-	cmpl	$xen_iret_start_crit, %eax
-	jb	1f
-	cmpl	$xen_iret_end_crit, %eax
-	jae	1f
-
-	jmp	xen_iret_crit_fixup
-
-ENTRY(xen_do_upcall)
-1:	mov	%esp, %eax
-	call	xen_evtchn_do_upcall
-#ifndef CONFIG_PREEMPT
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	ret_from_intr
-ENDPROC(xen_hypervisor_callback)
-
-/*
- * Hypervisor uses this for application faults while it executes.
- * We get here for two reasons:
- *  1. Fault while reloading DS, ES, FS or GS
- *  2. Fault while executing IRET
- * Category 1 we fix up by reattempting the load, and zeroing the segment
- * register if the load fails.
- * Category 2 we fix up by jumping to do_iret_error. We cannot use the
- * normal Linux return path in this case because if we use the IRET hypercall
- * to pop the stack frame we end up in an infinite loop of failsafe callbacks.
- * We distinguish between categories by maintaining a status value in EAX.
- */
-ENTRY(xen_failsafe_callback)
-	pushl	%eax
-	movl	$1, %eax
-1:	mov	4(%esp), %ds
-2:	mov	8(%esp), %es
-3:	mov	12(%esp), %fs
-4:	mov	16(%esp), %gs
-	/* EAX == 0 => Category 1 (Bad segment)
-	   EAX != 0 => Category 2 (Bad IRET) */
-	testl	%eax, %eax
-	popl	%eax
-	lea	16(%esp), %esp
-	jz	5f
-	jmp	iret_exc
-5:	pushl	$-1				/* orig_ax = -1 => not a system call */
-	SAVE_ALL
-	ENCODE_FRAME_POINTER
-	jmp	ret_from_exception
-
-.section .fixup, "ax"
-6:	xorl	%eax, %eax
-	movl	%eax, 4(%esp)
-	jmp	1b
-7:	xorl	%eax, %eax
-	movl	%eax, 8(%esp)
-	jmp	2b
-8:	xorl	%eax, %eax
-	movl	%eax, 12(%esp)
-	jmp	3b
-9:	xorl	%eax, %eax
-	movl	%eax, 16(%esp)
-	jmp	4b
-.previous
-	_ASM_EXTABLE(1b, 6b)
-	_ASM_EXTABLE(2b, 7b)
-	_ASM_EXTABLE(3b, 8b)
-	_ASM_EXTABLE(4b, 9b)
-ENDPROC(xen_failsafe_callback)
-#endif /* CONFIG_XEN_PV */
-
 #ifdef CONFIG_XEN_PVHVM
 BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 		 xen_evtchn_do_upcall)
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 6e81788a30c1..e5a13a138b01 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -25,7 +25,7 @@ void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
 void entry_INT80_compat(void);
-#if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
+#if defined(CONFIG_XEN_PV)
 void xen_entry_INT80_compat(void);
 #endif
 #endif
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index ac3892920419..7f485fadfe6e 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -289,7 +289,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 extern const char early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
 extern void early_ignore_irq(void);
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
+#if defined(CONFIG_XEN_PV)
 extern const char xen_early_idt_handler_array[NUM_EXCEPTION_VECTORS][XEN_EARLY_IDT_HANDLER_SIZE];
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7d6f3f3fad78..2b142e58657e 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -36,7 +36,7 @@ asmlinkage void machine_check(void);
 #endif /* CONFIG_X86_MCE */
 asmlinkage void simd_coprocessor_error(void);
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
+#if defined(CONFIG_XEN_PV)
 asmlinkage void xen_divide_error(void);
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index e07abefd3d26..dbd7cd38b914 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,6 +18,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	depends on X86_64
 	select PARAVIRT_XXL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
@@ -49,7 +50,7 @@ config XEN_PVHVM_SMP
 
 config XEN_512GB
 	bool "Limit Xen pv-domain memory to 512GB"
-	depends on XEN_PV && X86_64
+	depends on XEN_PV
 	default y
 	help
 	  Limit paravirtualized user domains to 512GB of RAM.
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 084de77a109e..d42737f31304 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
+OBJECT_FILES_NON_STANDARD_xen-asm_64.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -34,7 +34,7 @@ obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
 obj-$(CONFIG_XEN_PV)		+= irq.o
 obj-$(CONFIG_XEN_PV)		+= multicalls.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm.o
-obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
+obj-$(CONFIG_XEN_PV)		+= xen-asm_64.o
 
 obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 5e53bfbe5823..ea6e9c54da9d 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -58,10 +58,6 @@ static u32 xen_apic_read(u32 reg)
 
 	if (reg == APIC_LVR)
 		return 0x14;
-#ifdef CONFIG_X86_32
-	if (reg == APIC_LDR)
-		return SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
-#endif
 	if (reg != APIC_ID)
 		return 0;
 
@@ -127,14 +123,6 @@ static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
 	return initial_apic_id >> index_msb;
 }
 
-#ifdef CONFIG_X86_32
-static int xen_x86_32_early_logical_apicid(int cpu)
-{
-	/* Match with APIC_LDR read. Otherwise setup_local_APIC complains. */
-	return 1 << cpu;
-}
-#endif
-
 static void xen_noop(void)
 {
 }
@@ -197,11 +185,6 @@ static struct apic xen_pv_apic = {
 	.icr_write 			= xen_apic_icr_write,
 	.wait_icr_idle 			= xen_noop,
 	.safe_wait_icr_idle 		= xen_safe_apic_wait_icr_idle,
-
-#ifdef CONFIG_X86_32
-	/* generic_processor_info and setup_local_APIC. */
-	.x86_32_early_logical_apicid	= xen_x86_32_early_logical_apicid,
-#endif
 };
 
 static void __init xen_apic_check(void)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4722ba2966ac..cc14bf6354b6 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -545,13 +545,8 @@ static void xen_load_tls(struct thread_struct *t, unsigned int cpu)
 	 * exception between the new %fs descriptor being loaded and
 	 * %fs being effectively cleared at __switch_to().
 	 */
-	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_CPU) {
-#ifdef CONFIG_X86_32
-		lazy_load_gs(0);
-#else
+	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_CPU)
 		loadsegment(fs, 0);
-#endif
-	}
 
 	xen_mc_batch();
 
@@ -562,13 +557,11 @@ static void xen_load_tls(struct thread_struct *t, unsigned int cpu)
 	xen_mc_issue(PARAVIRT_LAZY_CPU);
 }
 
-#ifdef CONFIG_X86_64
 static void xen_load_gs_index(unsigned int idx)
 {
 	if (HYPERVISOR_set_segment_base(SEGBASE_GS_USER_SEL, idx))
 		BUG();
 }
-#endif
 
 static void xen_write_ldt_entry(struct desc_struct *dt, int entrynum,
 				const void *ptr)
@@ -587,7 +580,6 @@ static void xen_write_ldt_entry(struct desc_struct *dt, int entrynum,
 	preempt_enable();
 }
 
-#ifdef CONFIG_X86_64
 struct trap_array_entry {
 	void (*orig)(void);
 	void (*xen)(void);
@@ -657,7 +649,6 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
 
 	return true;
 }
-#endif
 
 static int cvt_gate_to_trap(int vector, const gate_desc *val,
 			    struct trap_info *info)
@@ -670,10 +661,8 @@ static int cvt_gate_to_trap(int vector, const gate_desc *val,
 	info->vector = vector;
 
 	addr = gate_offset(val);
-#ifdef CONFIG_X86_64
 	if (!get_trap_addr((void **)&addr, val->bits.ist))
 		return 0;
-#endif	/* CONFIG_X86_64 */
 	info->address = addr;
 
 	info->cs = gate_segment(val);
@@ -877,7 +866,7 @@ static void xen_write_cr4(unsigned long cr4)
 
 	native_write_cr4(cr4);
 }
-#ifdef CONFIG_X86_64
+
 static inline unsigned long xen_read_cr8(void)
 {
 	return 0;
@@ -886,7 +875,6 @@ static inline void xen_write_cr8(unsigned long val)
 {
 	BUG_ON(val);
 }
-#endif
 
 static u64 xen_read_msr_safe(unsigned int msr, int *err)
 {
@@ -911,7 +899,6 @@ static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
 	ret = 0;
 
 	switch (msr) {
-#ifdef CONFIG_X86_64
 		unsigned which;
 		u64 base;
 
@@ -924,7 +911,6 @@ static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
 		if (HYPERVISOR_set_segment_base(which, base) != 0)
 			ret = -EIO;
 		break;
-#endif
 
 	case MSR_STAR:
 	case MSR_CSTAR:
@@ -1005,9 +991,7 @@ void __init xen_setup_vcpu_info_placement(void)
 static const struct pv_info xen_info __initconst = {
 	.shared_kernel_pmd = 0,
 
-#ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = FLAT_USER_CS64,
-#endif
 	.name = "Xen",
 };
 
@@ -1022,10 +1006,8 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.write_cr4 = xen_write_cr4,
 
-#ifdef CONFIG_X86_64
 	.read_cr8 = xen_read_cr8,
 	.write_cr8 = xen_write_cr8,
-#endif
 
 	.wbinvd = native_wbinvd,
 
@@ -1038,18 +1020,14 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.read_pmc = xen_read_pmc,
 
 	.iret = xen_iret,
-#ifdef CONFIG_X86_64
 	.usergs_sysret64 = xen_sysret64,
-#endif
 
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
 	.load_gdt = xen_load_gdt,
 	.load_idt = xen_load_idt,
 	.load_tls = xen_load_tls,
-#ifdef CONFIG_X86_64
 	.load_gs_index = xen_load_gs_index,
-#endif
 
 	.alloc_ldt = xen_alloc_ldt,
 	.free_ldt = xen_free_ldt,
@@ -1312,15 +1290,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* keep using Xen gdt for now; no urgent need to change it */
 
-#ifdef CONFIG_X86_32
-	pv_info.kernel_rpl = 1;
-	if (xen_feature(XENFEAT_supervisor_mode_kernel))
-		pv_info.kernel_rpl = 0;
-#else
 	pv_info.kernel_rpl = 0;
-#endif
-	/* set the limit of our address space */
-	xen_reserve_top();
 
 	/*
 	 * We used to do this in xen_arch_setup, but that is too late
@@ -1332,13 +1302,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	if (rc != 0)
 		xen_raw_printk("physdev_op failed %d\n", rc);
 
-#ifdef CONFIG_X86_32
-	/* set up basic CPUID stuff */
-	cpu_detect(&new_cpu_data);
-	set_cpu_cap(&new_cpu_data, X86_FEATURE_FPU);
-	new_cpu_data.x86_capability[CPUID_1_EDX] = cpuid_edx(1);
-#endif
-
 	if (xen_start_info->mod_start) {
 	    if (xen_start_info->flags & SIF_MOD_START_PFN)
 		initrd_start = PFN_PHYS(xen_start_info->mod_start);
@@ -1406,12 +1369,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	xen_efi_init(&boot_params);
 
 	/* Start the world */
-#ifdef CONFIG_X86_32
-	i386_start_kernel();
-#else
 	cr4_init_shadow(); /* 32b kernel does this in i386_start_kernel() */
 	x86_64_start_reservations((char *)__pa_symbol(&boot_params));
-#endif
 }
 
 static int xen_cpu_up_prepare_pv(unsigned int cpu)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index beb44e22afdf..d6718782b123 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -86,19 +86,8 @@
 #include "mmu.h"
 #include "debugfs.h"
 
-#ifdef CONFIG_X86_32
-/*
- * Identity map, in addition to plain kernel map.  This needs to be
- * large enough to allocate page table pages to allocate the rest.
- * Each page can map 2MB.
- */
-#define LEVEL1_IDENT_ENTRIES	(PTRS_PER_PTE * 4)
-static RESERVE_BRK_ARRAY(pte_t, level1_ident_pgt, LEVEL1_IDENT_ENTRIES);
-#endif
-#ifdef CONFIG_X86_64
 /* l3 pud for userspace vsyscall mapping */
 static pud_t level3_user_vsyscall[PTRS_PER_PUD] __page_aligned_bss;
-#endif /* CONFIG_X86_64 */
 
 /*
  * Protects atomic reservation decrease/increase against concurrent increases.
@@ -439,26 +428,6 @@ static void xen_set_pud(pud_t *ptr, pud_t val)
 	xen_set_pud_hyper(ptr, val);
 }
 
-#ifdef CONFIG_X86_PAE
-static void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
-{
-	trace_xen_mmu_set_pte_atomic(ptep, pte);
-	__xen_set_pte(ptep, pte);
-}
-
-static void xen_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	trace_xen_mmu_pte_clear(mm, addr, ptep);
-	__xen_set_pte(ptep, native_make_pte(0));
-}
-
-static void xen_pmd_clear(pmd_t *pmdp)
-{
-	trace_xen_mmu_pmd_clear(pmdp);
-	set_pmd(pmdp, __pmd(0));
-}
-#endif	/* CONFIG_X86_PAE */
-
 __visible pmd_t xen_make_pmd(pmdval_t pmd)
 {
 	pmd = pte_pfn_to_mfn(pmd);
@@ -466,7 +435,6 @@ __visible pmd_t xen_make_pmd(pmdval_t pmd)
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_make_pmd);
 
-#ifdef CONFIG_X86_64
 __visible pudval_t xen_pud_val(pud_t pud)
 {
 	return pte_mfn_to_pfn(pud.pud);
@@ -571,7 +539,6 @@ __visible p4d_t xen_make_p4d(p4dval_t p4d)
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_make_p4d);
 #endif  /* CONFIG_PGTABLE_LEVELS >= 5 */
-#endif	/* CONFIG_X86_64 */
 
 static int xen_pmd_walk(struct mm_struct *mm, pmd_t *pmd,
 		int (*func)(struct mm_struct *mm, struct page *, enum pt_level),
@@ -654,14 +621,12 @@ static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
 	limit--;
 	BUG_ON(limit >= FIXADDR_TOP);
 
-#ifdef CONFIG_X86_64
 	/*
 	 * 64-bit has a great big hole in the middle of the address
 	 * space, which contains the Xen mappings.
 	 */
 	hole_low = pgd_index(GUARD_HOLE_BASE_ADDR);
 	hole_high = pgd_index(GUARD_HOLE_END_ADDR);
-#endif
 
 	nr = pgd_index(limit) + 1;
 	for (i = 0; i < nr; i++) {
@@ -800,7 +765,6 @@ static void __xen_pgd_pin(struct mm_struct *mm, pgd_t *pgd)
 		xen_mc_batch();
 	}
 
-#ifdef CONFIG_X86_64
 	{
 		pgd_t *user_pgd = xen_get_user_pgd(pgd);
 
@@ -812,14 +776,6 @@ static void __xen_pgd_pin(struct mm_struct *mm, pgd_t *pgd)
 				   PFN_DOWN(__pa(user_pgd)));
 		}
 	}
-#else /* CONFIG_X86_32 */
-#ifdef CONFIG_X86_PAE
-	/* Need to make sure unshared kernel PMD is pinnable */
-	xen_pin_page(mm, pgd_page(pgd[pgd_index(TASK_SIZE)]),
-		     PT_PMD);
-#endif
-	xen_do_pin(MMUEXT_PIN_L3_TABLE, PFN_DOWN(__pa(pgd)));
-#endif /* CONFIG_X86_64 */
 	xen_mc_issue(0);
 }
 
@@ -870,9 +826,7 @@ static int __init xen_mark_pinned(struct mm_struct *mm, struct page *page,
 static void __init xen_after_bootmem(void)
 {
 	static_branch_enable(&xen_struct_pages_ready);
-#ifdef CONFIG_X86_64
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
-#endif
 	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
 }
 
@@ -919,29 +873,18 @@ static int xen_unpin_page(struct mm_struct *mm, struct page *page,
 /* Release a pagetables pages back as normal RW */
 static void __xen_pgd_unpin(struct mm_struct *mm, pgd_t *pgd)
 {
+	pgd_t *user_pgd = xen_get_user_pgd(pgd);
+
 	trace_xen_mmu_pgd_unpin(mm, pgd);
 
 	xen_mc_batch();
 
 	xen_do_pin(MMUEXT_UNPIN_TABLE, PFN_DOWN(__pa(pgd)));
 
-#ifdef CONFIG_X86_64
-	{
-		pgd_t *user_pgd = xen_get_user_pgd(pgd);
-
-		if (user_pgd) {
-			xen_do_pin(MMUEXT_UNPIN_TABLE,
-				   PFN_DOWN(__pa(user_pgd)));
-			xen_unpin_page(mm, virt_to_page(user_pgd), PT_PGD);
-		}
+	if (user_pgd) {
+		xen_do_pin(MMUEXT_UNPIN_TABLE, PFN_DOWN(__pa(user_pgd)));
+		xen_unpin_page(mm, virt_to_page(user_pgd), PT_PGD);
 	}
-#endif
-
-#ifdef CONFIG_X86_PAE
-	/* Need to make sure unshared kernel PMD is unpinned */
-	xen_unpin_page(mm, pgd_page(pgd[pgd_index(TASK_SIZE)]),
-		       PT_PMD);
-#endif
 
 	__xen_pgd_walk(mm, pgd, xen_unpin_page, USER_LIMIT);
 
@@ -1089,7 +1032,6 @@ static void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
 		BUG();
 }
 
-#ifdef CONFIG_X86_64
 static void __init xen_cleanhighmap(unsigned long vaddr,
 				    unsigned long vaddr_end)
 {
@@ -1273,17 +1215,15 @@ static void __init xen_pagetable_cleanhighmap(void)
 	xen_cleanhighmap(addr, roundup(addr + size, PMD_SIZE * 2));
 	xen_start_info->pt_base = (unsigned long)__va(__pa(xen_start_info->pt_base));
 }
-#endif
 
 static void __init xen_pagetable_p2m_setup(void)
 {
 	xen_vmalloc_p2m_tree();
 
-#ifdef CONFIG_X86_64
 	xen_pagetable_p2m_free();
 
 	xen_pagetable_cleanhighmap();
-#endif
+
 	/* And revector! Bye bye old array */
 	xen_start_info->mfn_list = (unsigned long)xen_p2m_addr;
 }
@@ -1430,6 +1370,8 @@ static void __xen_write_cr3(bool kernel, unsigned long cr3)
 }
 static void xen_write_cr3(unsigned long cr3)
 {
+	pgd_t *user_pgd = xen_get_user_pgd(__va(cr3));
+
 	BUG_ON(preemptible());
 
 	xen_mc_batch();  /* disables interrupts */
@@ -1440,20 +1382,14 @@ static void xen_write_cr3(unsigned long cr3)
 
 	__xen_write_cr3(true, cr3);
 
-#ifdef CONFIG_X86_64
-	{
-		pgd_t *user_pgd = xen_get_user_pgd(__va(cr3));
-		if (user_pgd)
-			__xen_write_cr3(false, __pa(user_pgd));
-		else
-			__xen_write_cr3(false, 0);
-	}
-#endif
+	if (user_pgd)
+		__xen_write_cr3(false, __pa(user_pgd));
+	else
+		__xen_write_cr3(false, 0);
 
 	xen_mc_issue(PARAVIRT_LAZY_CPU);  /* interrupts restored */
 }
 
-#ifdef CONFIG_X86_64
 /*
  * At the start of the day - when Xen launches a guest, it has already
  * built pagetables for the guest. We diligently look over them
@@ -1488,49 +1424,39 @@ static void __init xen_write_cr3_init(unsigned long cr3)
 
 	xen_mc_issue(PARAVIRT_LAZY_CPU);  /* interrupts restored */
 }
-#endif
 
 static int xen_pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd = mm->pgd;
-	int ret = 0;
+	int ret = -ENOMEM;
+	struct page *page = virt_to_page(pgd);
+	pgd_t *user_pgd;
 
 	BUG_ON(PagePinned(virt_to_page(pgd)));
+	BUG_ON(page->private != 0);
 
-#ifdef CONFIG_X86_64
-	{
-		struct page *page = virt_to_page(pgd);
-		pgd_t *user_pgd;
-
-		BUG_ON(page->private != 0);
-
-		ret = -ENOMEM;
-
-		user_pgd = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-		page->private = (unsigned long)user_pgd;
+	user_pgd = (pgd_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	page->private = (unsigned long)user_pgd;
 
-		if (user_pgd != NULL) {
+	if (user_pgd != NULL) {
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
-			user_pgd[pgd_index(VSYSCALL_ADDR)] =
-				__pgd(__pa(level3_user_vsyscall) | _PAGE_TABLE);
+		user_pgd[pgd_index(VSYSCALL_ADDR)] =
+			__pgd(__pa(level3_user_vsyscall) | _PAGE_TABLE);
 #endif
-			ret = 0;
-		}
-
-		BUG_ON(PagePinned(virt_to_page(xen_get_user_pgd(pgd))));
+		ret = 0;
 	}
-#endif
+
+	BUG_ON(PagePinned(virt_to_page(xen_get_user_pgd(pgd))));
+
 	return ret;
 }
 
 static void xen_pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-#ifdef CONFIG_X86_64
 	pgd_t *user_pgd = xen_get_user_pgd(pgd);
 
 	if (user_pgd)
 		free_page((unsigned long)user_pgd);
-#endif
 }
 
 /*
@@ -1549,7 +1475,6 @@ static void xen_pgd_free(struct mm_struct *mm, pgd_t *pgd)
  */
 __visible pte_t xen_make_pte_init(pteval_t pte)
 {
-#ifdef CONFIG_X86_64
 	unsigned long pfn;
 
 	/*
@@ -1563,7 +1488,7 @@ __visible pte_t xen_make_pte_init(pteval_t pte)
 	    pfn >= xen_start_info->first_p2m_pfn &&
 	    pfn < xen_start_info->first_p2m_pfn + xen_start_info->nr_p2m_frames)
 		pte &= ~_PAGE_RW;
-#endif
+
 	pte = pte_pfn_to_mfn(pte);
 	return native_make_pte(pte);
 }
@@ -1571,13 +1496,6 @@ PV_CALLEE_SAVE_REGS_THUNK(xen_make_pte_init);
 
 static void __init xen_set_pte_init(pte_t *ptep, pte_t pte)
 {
-#ifdef CONFIG_X86_32
-	/* If there's an existing pte, then don't allow _PAGE_RW to be set */
-	if (pte_mfn(pte) != INVALID_P2M_ENTRY
-	    && pte_val_ma(*ptep) & _PAGE_PRESENT)
-		pte = __pte_ma(((pte_val_ma(*ptep) & _PAGE_RW) | ~_PAGE_RW) &
-			       pte_val_ma(pte));
-#endif
 	__xen_set_pte(ptep, pte);
 }
 
@@ -1712,7 +1630,6 @@ static void xen_release_pmd(unsigned long pfn)
 	xen_release_ptpage(pfn, PT_PMD);
 }
 
-#ifdef CONFIG_X86_64
 static void xen_alloc_pud(struct mm_struct *mm, unsigned long pfn)
 {
 	xen_alloc_ptpage(mm, pfn, PT_PUD);
@@ -1722,20 +1639,6 @@ static void xen_release_pud(unsigned long pfn)
 {
 	xen_release_ptpage(pfn, PT_PUD);
 }
-#endif
-
-void __init xen_reserve_top(void)
-{
-#ifdef CONFIG_X86_32
-	unsigned long top = HYPERVISOR_VIRT_START;
-	struct xen_platform_parameters pp;
-
-	if (HYPERVISOR_xen_version(XENVER_platform_parameters, &pp) == 0)
-		top = pp.virt_start;
-
-	reserve_top_address(-top);
-#endif	/* CONFIG_X86_32 */
-}
 
 /*
  * Like __va(), but returns address in the kernel mapping (which is
@@ -1743,11 +1646,7 @@ void __init xen_reserve_top(void)
  */
 static void * __init __ka(phys_addr_t paddr)
 {
-#ifdef CONFIG_X86_64
 	return (void *)(paddr + __START_KERNEL_map);
-#else
-	return __va(paddr);
-#endif
 }
 
 /* Convert a machine address to physical address */
@@ -1781,56 +1680,7 @@ static void __init set_page_prot(void *addr, pgprot_t prot)
 {
 	return set_page_prot_flags(addr, prot, UVMF_NONE);
 }
-#ifdef CONFIG_X86_32
-static void __init xen_map_identity_early(pmd_t *pmd, unsigned long max_pfn)
-{
-	unsigned pmdidx, pteidx;
-	unsigned ident_pte;
-	unsigned long pfn;
-
-	level1_ident_pgt = extend_brk(sizeof(pte_t) * LEVEL1_IDENT_ENTRIES,
-				      PAGE_SIZE);
-
-	ident_pte = 0;
-	pfn = 0;
-	for (pmdidx = 0; pmdidx < PTRS_PER_PMD && pfn < max_pfn; pmdidx++) {
-		pte_t *pte_page;
-
-		/* Reuse or allocate a page of ptes */
-		if (pmd_present(pmd[pmdidx]))
-			pte_page = m2v(pmd[pmdidx].pmd);
-		else {
-			/* Check for free pte pages */
-			if (ident_pte == LEVEL1_IDENT_ENTRIES)
-				break;
-
-			pte_page = &level1_ident_pgt[ident_pte];
-			ident_pte += PTRS_PER_PTE;
-
-			pmd[pmdidx] = __pmd(__pa(pte_page) | _PAGE_TABLE);
-		}
-
-		/* Install mappings */
-		for (pteidx = 0; pteidx < PTRS_PER_PTE; pteidx++, pfn++) {
-			pte_t pte;
-
-			if (pfn > max_pfn_mapped)
-				max_pfn_mapped = pfn;
-
-			if (!pte_none(pte_page[pteidx]))
-				continue;
-
-			pte = pfn_pte(pfn, PAGE_KERNEL_EXEC);
-			pte_page[pteidx] = pte;
-		}
-	}
 
-	for (pteidx = 0; pteidx < ident_pte; pteidx += PTRS_PER_PTE)
-		set_page_prot(&level1_ident_pgt[pteidx], PAGE_KERNEL_RO);
-
-	set_page_prot(pmd, PAGE_KERNEL_RO);
-}
-#endif
 void __init xen_setup_machphys_mapping(void)
 {
 	struct xen_machphys_mapping mapping;
@@ -1841,13 +1691,8 @@ void __init xen_setup_machphys_mapping(void)
 	} else {
 		machine_to_phys_nr = MACH2PHYS_NR_ENTRIES;
 	}
-#ifdef CONFIG_X86_32
-	WARN_ON((machine_to_phys_mapping + (machine_to_phys_nr - 1))
-		< machine_to_phys_mapping);
-#endif
 }
 
-#ifdef CONFIG_X86_64
 static void __init convert_pfn_mfn(void *v)
 {
 	pte_t *pte = v;
@@ -2178,105 +2023,6 @@ void __init xen_relocate_p2m(void)
 	xen_start_info->nr_p2m_frames = n_frames;
 }
 
-#else	/* !CONFIG_X86_64 */
-static RESERVE_BRK_ARRAY(pmd_t, initial_kernel_pmd, PTRS_PER_PMD);
-static RESERVE_BRK_ARRAY(pmd_t, swapper_kernel_pmd, PTRS_PER_PMD);
-RESERVE_BRK(fixup_kernel_pmd, PAGE_SIZE);
-RESERVE_BRK(fixup_kernel_pte, PAGE_SIZE);
-
-static void __init xen_write_cr3_init(unsigned long cr3)
-{
-	unsigned long pfn = PFN_DOWN(__pa(swapper_pg_dir));
-
-	BUG_ON(read_cr3_pa() != __pa(initial_page_table));
-	BUG_ON(cr3 != __pa(swapper_pg_dir));
-
-	/*
-	 * We are switching to swapper_pg_dir for the first time (from
-	 * initial_page_table) and therefore need to mark that page
-	 * read-only and then pin it.
-	 *
-	 * Xen disallows sharing of kernel PMDs for PAE
-	 * guests. Therefore we must copy the kernel PMD from
-	 * initial_page_table into a new kernel PMD to be used in
-	 * swapper_pg_dir.
-	 */
-	swapper_kernel_pmd =
-		extend_brk(sizeof(pmd_t) * PTRS_PER_PMD, PAGE_SIZE);
-	copy_page(swapper_kernel_pmd, initial_kernel_pmd);
-	swapper_pg_dir[KERNEL_PGD_BOUNDARY] =
-		__pgd(__pa(swapper_kernel_pmd) | _PAGE_PRESENT);
-	set_page_prot(swapper_kernel_pmd, PAGE_KERNEL_RO);
-
-	set_page_prot(swapper_pg_dir, PAGE_KERNEL_RO);
-	xen_write_cr3(cr3);
-	pin_pagetable_pfn(MMUEXT_PIN_L3_TABLE, pfn);
-
-	pin_pagetable_pfn(MMUEXT_UNPIN_TABLE,
-			  PFN_DOWN(__pa(initial_page_table)));
-	set_page_prot(initial_page_table, PAGE_KERNEL);
-	set_page_prot(initial_kernel_pmd, PAGE_KERNEL);
-
-	pv_ops.mmu.write_cr3 = &xen_write_cr3;
-}
-
-/*
- * For 32 bit domains xen_start_info->pt_base is the pgd address which might be
- * not the first page table in the page table pool.
- * Iterate through the initial page tables to find the real page table base.
- */
-static phys_addr_t __init xen_find_pt_base(pmd_t *pmd)
-{
-	phys_addr_t pt_base, paddr;
-	unsigned pmdidx;
-
-	pt_base = min(__pa(xen_start_info->pt_base), __pa(pmd));
-
-	for (pmdidx = 0; pmdidx < PTRS_PER_PMD; pmdidx++)
-		if (pmd_present(pmd[pmdidx]) && !pmd_large(pmd[pmdidx])) {
-			paddr = m2p(pmd[pmdidx].pmd);
-			pt_base = min(pt_base, paddr);
-		}
-
-	return pt_base;
-}
-
-void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
-{
-	pmd_t *kernel_pmd;
-
-	kernel_pmd = m2v(pgd[KERNEL_PGD_BOUNDARY].pgd);
-
-	xen_pt_base = xen_find_pt_base(kernel_pmd);
-	xen_pt_size = xen_start_info->nr_pt_frames * PAGE_SIZE;
-
-	initial_kernel_pmd =
-		extend_brk(sizeof(pmd_t) * PTRS_PER_PMD, PAGE_SIZE);
-
-	max_pfn_mapped = PFN_DOWN(xen_pt_base + xen_pt_size + 512 * 1024);
-
-	copy_page(initial_kernel_pmd, kernel_pmd);
-
-	xen_map_identity_early(initial_kernel_pmd, max_pfn);
-
-	copy_page(initial_page_table, pgd);
-	initial_page_table[KERNEL_PGD_BOUNDARY] =
-		__pgd(__pa(initial_kernel_pmd) | _PAGE_PRESENT);
-
-	set_page_prot(initial_kernel_pmd, PAGE_KERNEL_RO);
-	set_page_prot(initial_page_table, PAGE_KERNEL_RO);
-	set_page_prot(empty_zero_page, PAGE_KERNEL_RO);
-
-	pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, PFN_DOWN(__pa(pgd)));
-
-	pin_pagetable_pfn(MMUEXT_PIN_L3_TABLE,
-			  PFN_DOWN(__pa(initial_page_table)));
-	xen_write_cr3(__pa(initial_page_table));
-
-	memblock_reserve(xen_pt_base, xen_pt_size);
-}
-#endif	/* CONFIG_X86_64 */
-
 void __init xen_reserve_special_pages(void)
 {
 	phys_addr_t paddr;
@@ -2310,12 +2056,7 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 
 	switch (idx) {
 	case FIX_BTMAP_END ... FIX_BTMAP_BEGIN:
-#ifdef CONFIG_X86_32
-	case FIX_WP_TEST:
-# ifdef CONFIG_HIGHMEM
-	case FIX_KMAP_BEGIN ... FIX_KMAP_END:
-# endif
-#elif defined(CONFIG_X86_VSYSCALL_EMULATION)
+#if defined(CONFIG_X86_VSYSCALL_EMULATION)
 	case VSYSCALL_PAGE:
 #endif
 		/* All local page mappings */
@@ -2367,9 +2108,7 @@ static void __init xen_post_allocator_init(void)
 	pv_ops.mmu.set_pte = xen_set_pte;
 	pv_ops.mmu.set_pmd = xen_set_pmd;
 	pv_ops.mmu.set_pud = xen_set_pud;
-#ifdef CONFIG_X86_64
 	pv_ops.mmu.set_p4d = xen_set_p4d;
-#endif
 
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
@@ -2377,15 +2116,11 @@ static void __init xen_post_allocator_init(void)
 	pv_ops.mmu.alloc_pmd = xen_alloc_pmd;
 	pv_ops.mmu.release_pte = xen_release_pte;
 	pv_ops.mmu.release_pmd = xen_release_pmd;
-#ifdef CONFIG_X86_64
 	pv_ops.mmu.alloc_pud = xen_alloc_pud;
 	pv_ops.mmu.release_pud = xen_release_pud;
-#endif
 	pv_ops.mmu.make_pte = PV_CALLEE_SAVE(xen_make_pte);
 
-#ifdef CONFIG_X86_64
 	pv_ops.mmu.write_cr3 = &xen_write_cr3;
-#endif
 }
 
 static void xen_leave_lazy_mmu(void)
@@ -2430,17 +2165,11 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.make_pte = PV_CALLEE_SAVE(xen_make_pte_init),
 	.make_pgd = PV_CALLEE_SAVE(xen_make_pgd),
 
-#ifdef CONFIG_X86_PAE
-	.set_pte_atomic = xen_set_pte_atomic,
-	.pte_clear = xen_pte_clear,
-	.pmd_clear = xen_pmd_clear,
-#endif	/* CONFIG_X86_PAE */
 	.set_pud = xen_set_pud_hyper,
 
 	.make_pmd = PV_CALLEE_SAVE(xen_make_pmd),
 	.pmd_val = PV_CALLEE_SAVE(xen_pmd_val),
 
-#ifdef CONFIG_X86_64
 	.pud_val = PV_CALLEE_SAVE(xen_pud_val),
 	.make_pud = PV_CALLEE_SAVE(xen_make_pud),
 	.set_p4d = xen_set_p4d_hyper,
@@ -2452,7 +2181,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.p4d_val = PV_CALLEE_SAVE(xen_p4d_val),
 	.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
 #endif
-#endif	/* CONFIG_X86_64 */
 
 	.activate_mm = xen_activate_mm,
 	.dup_mmap = xen_dup_mmap,
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 95ce9b5be411..a6cd2936d214 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -379,12 +379,8 @@ static void __init xen_rebuild_p2m_list(unsigned long *p2m)
 
 		if (type == P2M_TYPE_PFN || i < chunk) {
 			/* Use initial p2m page contents. */
-#ifdef CONFIG_X86_64
 			mfns = alloc_p2m_page();
 			copy_page(mfns, xen_p2m_addr + pfn);
-#else
-			mfns = xen_p2m_addr + pfn;
-#endif
 			ptep = populate_extra_pte((unsigned long)(p2m + pfn));
 			set_pte(ptep,
 				pfn_pte(PFN_DOWN(__pa(mfns)), PAGE_KERNEL));
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 548d1e0a5ba1..ff401026ad84 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -544,13 +544,10 @@ static unsigned long __init xen_get_pages_limit(void)
 {
 	unsigned long limit;
 
-#ifdef CONFIG_X86_32
-	limit = GB(64) / PAGE_SIZE;
-#else
 	limit = MAXMEM / PAGE_SIZE;
 	if (!xen_initial_domain() && xen_512gb_limit)
 		limit = GB(512) / PAGE_SIZE;
-#endif
+
 	return limit;
 }
 
@@ -721,17 +718,8 @@ static void __init xen_reserve_xen_mfnlist(void)
 	if (!xen_is_e820_reserved(start, size))
 		return;
 
-#ifdef CONFIG_X86_32
-	/*
-	 * Relocating the p2m on 32 bit system to an arbitrary virtual address
-	 * is not supported, so just give up.
-	 */
-	xen_raw_console_write("Xen hypervisor allocated p2m list conflicts with E820 map\n");
-	BUG();
-#else
 	xen_relocate_p2m();
 	memblock_free(start, size);
-#endif
 }
 
 /**
@@ -920,20 +908,6 @@ char * __init xen_memory_setup(void)
 	return "Xen";
 }
 
-/*
- * Set the bit indicating "nosegneg" library variants should be used.
- * We only need to bother in pure 32-bit mode; compat 32-bit processes
- * can have un-truncated segments, so wrapping around is allowed.
- */
-static void __init fiddle_vdso(void)
-{
-#ifdef CONFIG_X86_32
-	u32 *mask = vdso_image_32.data +
-		vdso_image_32.sym_VDSO32_NOTE_MASK;
-	*mask |= 1 << VDSO_NOTE_NONEGSEG_BIT;
-#endif
-}
-
 static int register_callback(unsigned type, const void *func)
 {
 	struct callback_register callback = {
@@ -948,25 +922,17 @@ static int register_callback(unsigned type, const void *func)
 void xen_enable_sysenter(void)
 {
 	int ret;
-	unsigned sysenter_feature;
-
-#ifdef CONFIG_X86_32
-	sysenter_feature = X86_FEATURE_SEP;
-#else
-	sysenter_feature = X86_FEATURE_SYSENTER32;
-#endif
 
-	if (!boot_cpu_has(sysenter_feature))
+	if (!boot_cpu_has(X86_FEATURE_SYSENTER32))
 		return;
 
 	ret = register_callback(CALLBACKTYPE_sysenter, xen_sysenter_target);
-	if(ret != 0)
-		setup_clear_cpu_cap(sysenter_feature);
+	if (ret != 0)
+		setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
 }
 
 void xen_enable_syscall(void)
 {
-#ifdef CONFIG_X86_64
 	int ret;
 
 	ret = register_callback(CALLBACKTYPE_syscall, xen_syscall_target);
@@ -982,7 +948,6 @@ void xen_enable_syscall(void)
 		if (ret != 0)
 			setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 	}
-#endif /* CONFIG_X86_64 */
 }
 
 void __init xen_pvmmu_arch_setup(void)
@@ -1022,7 +987,6 @@ void __init xen_arch_setup(void)
 	disable_cpuidle();
 	disable_cpufreq();
 	WARN_ON(xen_set_default_idle());
-	fiddle_vdso();
 #ifdef CONFIG_NUMA
 	numa_off = 1;
 #endif
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 590fcf863006..20977a242003 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -208,15 +208,6 @@ static void __init xen_pv_smp_prepare_boot_cpu(void)
 		 * sure the old memory can be recycled. */
 		make_lowmem_page_readwrite(xen_initial_gdt);
 
-#ifdef CONFIG_X86_32
-	/*
-	 * Xen starts us with XEN_FLAT_RING1_DS, but linux code
-	 * expects __USER_DS
-	 */
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-#endif
-
 	xen_filter_cpu_maps();
 	xen_setup_vcpu_info_placement();
 
@@ -296,10 +287,6 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 
 	gdt = get_cpu_gdt_rw(cpu);
 
-#ifdef CONFIG_X86_32
-	ctxt->user_regs.fs = __KERNEL_PERCPU;
-	ctxt->user_regs.gs = __KERNEL_STACK_CANARY;
-#endif
 	memset(&ctxt->fpu_ctxt, 0, sizeof(ctxt->fpu_ctxt));
 
 	/*
@@ -337,12 +324,8 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 	ctxt->kernel_ss = __KERNEL_DS;
 	ctxt->kernel_sp = task_top_of_stack(idle);
 
-#ifdef CONFIG_X86_32
-	ctxt->event_callback_cs     = __KERNEL_CS;
-	ctxt->failsafe_callback_cs  = __KERNEL_CS;
-#else
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
-#endif
+
 	ctxt->event_callback_eip    =
 		(unsigned long)xen_hypervisor_callback;
 	ctxt->failsafe_callback_eip =
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 8019edd0125c..54e1e9ca35a4 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -75,11 +75,7 @@ ENTRY(xen_save_fl_direct)
  */
 ENTRY(xen_restore_fl_direct)
 	FRAME_BEGIN
-#ifdef CONFIG_X86_64
 	testw $X86_EFLAGS_IF, %di
-#else
-	testb $X86_EFLAGS_IF>>8, %ah
-#endif
 	setz PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
 	/*
 	 * Preempt here doesn't matter because that will deal with any
@@ -103,15 +99,6 @@ ENTRY(xen_restore_fl_direct)
  */
 ENTRY(check_events)
 	FRAME_BEGIN
-#ifdef CONFIG_X86_32
-	push %eax
-	push %ecx
-	push %edx
-	call xen_force_evtchn_callback
-	pop %edx
-	pop %ecx
-	pop %eax
-#else
 	push %rax
 	push %rcx
 	push %rdx
@@ -131,7 +118,6 @@ ENTRY(check_events)
 	pop %rdx
 	pop %rcx
 	pop %rax
-#endif
 	FRAME_END
 	ret
 ENDPROC(check_events)
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
deleted file mode 100644
index c15db060a242..000000000000
--- a/arch/x86/xen/xen-asm_32.S
+++ /dev/null
@@ -1,207 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Asm versions of Xen pv-ops, suitable for direct use.
- *
- * We only bother with direct forms (ie, vcpu in pda) of the
- * operations here; the indirect forms are better handled in C.
- */
-
-#include <asm/thread_info.h>
-#include <asm/processor-flags.h>
-#include <asm/segment.h>
-#include <asm/asm.h>
-
-#include <xen/interface/xen.h>
-
-#include <linux/linkage.h>
-
-/* Pseudo-flag used for virtual NMI, which we don't implement yet */
-#define XEN_EFLAGS_NMI  0x80000000
-
-/*
- * This is run where a normal iret would be run, with the same stack setup:
- *	8: eflags
- *	4: cs
- *	esp-> 0: eip
- *
- * This attempts to make sure that any pending events are dealt with
- * on return to usermode, but there is a small window in which an
- * event can happen just before entering usermode.  If the nested
- * interrupt ends up setting one of the TIF_WORK_MASK pending work
- * flags, they will not be tested again before returning to
- * usermode. This means that a process can end up with pending work,
- * which will be unprocessed until the process enters and leaves the
- * kernel again, which could be an unbounded amount of time.  This
- * means that a pending signal or reschedule event could be
- * indefinitely delayed.
- *
- * The fix is to notice a nested interrupt in the critical window, and
- * if one occurs, then fold the nested interrupt into the current
- * interrupt stack frame, and re-process it iteratively rather than
- * recursively.  This means that it will exit via the normal path, and
- * all pending work will be dealt with appropriately.
- *
- * Because the nested interrupt handler needs to deal with the current
- * stack state in whatever form its in, we keep things simple by only
- * using a single register which is pushed/popped on the stack.
- */
-
-.macro POP_FS
-1:
-	popw %fs
-.pushsection .fixup, "ax"
-2:	movw $0, (%esp)
-	jmp 1b
-.popsection
-	_ASM_EXTABLE(1b,2b)
-.endm
-
-ENTRY(xen_iret)
-	/* test eflags for special cases */
-	testl $(X86_EFLAGS_VM | XEN_EFLAGS_NMI), 8(%esp)
-	jnz hyper_iret
-
-	push %eax
-	ESP_OFFSET=4	# bytes pushed onto stack
-
-	/* Store vcpu_info pointer for easy access */
-#ifdef CONFIG_SMP
-	pushw %fs
-	movl $(__KERNEL_PERCPU), %eax
-	movl %eax, %fs
-	movl %fs:xen_vcpu, %eax
-	POP_FS
-#else
-	movl %ss:xen_vcpu, %eax
-#endif
-
-	/* check IF state we're restoring */
-	testb $X86_EFLAGS_IF>>8, 8+1+ESP_OFFSET(%esp)
-
-	/*
-	 * Maybe enable events.  Once this happens we could get a
-	 * recursive event, so the critical region starts immediately
-	 * afterwards.  However, if that happens we don't end up
-	 * resuming the code, so we don't have to be worried about
-	 * being preempted to another CPU.
-	 */
-	setz %ss:XEN_vcpu_info_mask(%eax)
-xen_iret_start_crit:
-
-	/* check for unmasked and pending */
-	cmpw $0x0001, %ss:XEN_vcpu_info_pending(%eax)
-
-	/*
-	 * If there's something pending, mask events again so we can
-	 * jump back into xen_hypervisor_callback. Otherwise do not
-	 * touch XEN_vcpu_info_mask.
-	 */
-	jne 1f
-	movb $1, %ss:XEN_vcpu_info_mask(%eax)
-
-1:	popl %eax
-
-	/*
-	 * From this point on the registers are restored and the stack
-	 * updated, so we don't need to worry about it if we're
-	 * preempted
-	 */
-iret_restore_end:
-
-	/*
-	 * Jump to hypervisor_callback after fixing up the stack.
-	 * Events are masked, so jumping out of the critical region is
-	 * OK.
-	 */
-	je xen_hypervisor_callback
-
-1:	iret
-xen_iret_end_crit:
-	_ASM_EXTABLE(1b, iret_exc)
-
-hyper_iret:
-	/* put this out of line since its very rarely used */
-	jmp hypercall_page + __HYPERVISOR_iret * 32
-
-	.globl xen_iret_start_crit, xen_iret_end_crit
-
-/*
- * This is called by xen_hypervisor_callback in entry.S when it sees
- * that the EIP at the time of interrupt was between
- * xen_iret_start_crit and xen_iret_end_crit.  We're passed the EIP in
- * %eax so we can do a more refined determination of what to do.
- *
- * The stack format at this point is:
- *	----------------
- *	 ss		: (ss/esp may be present if we came from usermode)
- *	 esp		:
- *	 eflags		}  outer exception info
- *	 cs		}
- *	 eip		}
- *	---------------- <- edi (copy dest)
- *	 eax		:  outer eax if it hasn't been restored
- *	----------------
- *	 eflags		}  nested exception info
- *	 cs		}   (no ss/esp because we're nested
- *	 eip		}    from the same ring)
- *	 orig_eax	}<- esi (copy src)
- *	 - - - - - - - -
- *	 fs		}
- *	 es		}
- *	 ds		}  SAVE_ALL state
- *	 eax		}
- *	  :		:
- *	 ebx		}<- esp
- *	----------------
- *
- * In order to deliver the nested exception properly, we need to shift
- * everything from the return addr up to the error code so it sits
- * just under the outer exception info.  This means that when we
- * handle the exception, we do it in the context of the outer
- * exception rather than starting a new one.
- *
- * The only caveat is that if the outer eax hasn't been restored yet
- * (ie, it's still on stack), we need to insert its value into the
- * SAVE_ALL state before going on, since it's usermode state which we
- * eventually need to restore.
- */
-ENTRY(xen_iret_crit_fixup)
-	/*
-	 * Paranoia: Make sure we're really coming from kernel space.
-	 * One could imagine a case where userspace jumps into the
-	 * critical range address, but just before the CPU delivers a
-	 * GP, it decides to deliver an interrupt instead.  Unlikely?
-	 * Definitely.  Easy to avoid?  Yes.  The Intel documents
-	 * explicitly say that the reported EIP for a bad jump is the
-	 * jump instruction itself, not the destination, but some
-	 * virtual environments get this wrong.
-	 */
-	movl PT_CS(%esp), %ecx
-	andl $SEGMENT_RPL_MASK, %ecx
-	cmpl $USER_RPL, %ecx
-	je 2f
-
-	lea PT_ORIG_EAX(%esp), %esi
-	lea PT_EFLAGS(%esp), %edi
-
-	/*
-	 * If eip is before iret_restore_end then stack
-	 * hasn't been restored yet.
-	 */
-	cmp $iret_restore_end, %eax
-	jae 1f
-
-	movl 0+4(%edi), %eax		/* copy EAX (just above top of frame) */
-	movl %eax, PT_EAX(%esp)
-
-	lea ESP_OFFSET(%edi), %edi	/* move dest up over saved regs */
-
-	/* set up the copy */
-1:	std
-	mov $PT_EIP / 4, %ecx		/* saved regs up to orig_eax */
-	rep movsl
-	cld
-
-	lea 4(%edi), %esp		/* point esp to new frame */
-2:	jmp xen_do_upcall
-
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index c1d8b90aa4e2..03a7af6b7453 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -37,7 +37,6 @@ ENTRY(startup_xen)
 	mov %_ASM_SI, xen_start_info
 	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
 
-#ifdef CONFIG_X86_64
 	/* Set up %gs.
 	 *
 	 * The base of %gs always points to fixed_percpu_data.  If the
@@ -49,7 +48,6 @@ ENTRY(startup_xen)
 	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
 	cdq
 	wrmsr
-#endif
 
 	jmp xen_start_kernel
 END(startup_xen)
@@ -75,13 +73,9 @@ END(hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
-#ifdef CONFIG_X86_32
-	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __PAGE_OFFSET)
-#else
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
 	/* Map the p2m table to a 512GB-aligned user address. */
 	ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
-#endif
 #ifdef CONFIG_XEN_PV
 	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
 #endif
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 2f111f47ba98..cfe9170e3970 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -12,10 +12,8 @@ extern const char xen_hypervisor_callback[];
 extern const char xen_failsafe_callback[];
 
 void xen_sysenter_target(void);
-#ifdef CONFIG_X86_64
 void xen_syscall_target(void);
 void xen_syscall32_target(void);
-#endif
 
 extern void *xen_initial_gdt;
 
@@ -34,15 +32,12 @@ void xen_setup_mfn_list_list(void);
 void xen_build_mfn_list_list(void);
 void xen_setup_machphys_mapping(void);
 void xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn);
-void xen_reserve_top(void);
 void __init xen_reserve_special_pages(void);
 void __init xen_pt_check_e820(void);
 
 void xen_mm_pin_all(void);
 void xen_mm_unpin_all(void);
-#ifdef CONFIG_X86_64
 void __init xen_relocate_p2m(void);
-#endif
 
 bool __init xen_is_e820_reserved(phys_addr_t start, phys_addr_t size);
 unsigned long __ref xen_chk_extra_mem(unsigned long pfn);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index ec6558b79e9d..c359a2c04d80 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -63,9 +63,7 @@ config XEN_BALLOON_MEMORY_HOTPLUG
 
 config XEN_BALLOON_MEMORY_HOTPLUG_LIMIT
 	int "Hotplugged memory limit (in GiB) for a PV guest"
-	default 512 if X86_64
-	default 4 if X86_32
-	range 0 64 if X86_32
+	default 512
 	depends on XEN_HAVE_PVMMU
 	depends on XEN_BALLOON_MEMORY_HOTPLUG
 	help
-- 
2.16.4

