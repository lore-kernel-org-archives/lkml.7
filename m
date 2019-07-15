Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E93C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606AE206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfGOLhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:37:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729533AbfGOLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAD3EAE8B;
        Mon, 15 Jul 2019 11:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alok Kataria <akataria@vmware.com>
Subject: [PATCH 2/2] x86/paravirt: remove 32-bit support from PARAVIRT_XXL
Date:   Mon, 15 Jul 2019 13:37:39 +0200
Message-Id: <20190715113739.17694-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190715113739.17694-1-jgross@suse.com>
References: <20190715113739.17694-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last 32-bit user of stuff under CONFIG_PARAVIRT_XXL is gone.

Remove 32-bit specific parts.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/paravirt.h             | 105 ++++------------------------
 arch/x86/include/asm/paravirt_types.h       |  20 ------
 arch/x86/include/asm/pgtable-3level_types.h |   5 --
 arch/x86/kernel/cpu/common.c                |   8 ---
 arch/x86/kernel/paravirt.c                  |  17 -----
 arch/x86/kernel/paravirt_patch_32.c         |  36 +---------
 7 files changed, 15 insertions(+), 177 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..36f4ce1405cb 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -17,6 +17,7 @@
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
 #undef CONFIG_NR_CPUS
+#undef CONFIG_PARAVIRT_XXL
 
 #define CONFIG_X86_32 1
 #define CONFIG_PGTABLE_LEVELS 2
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c25c38a05c1c..60dfa93313a9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -139,7 +139,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-#ifdef CONFIG_X86_64
 static inline unsigned long read_cr8(void)
 {
 	return PVOP_CALL0(unsigned long, cpu.read_cr8);
@@ -149,7 +148,6 @@ static inline void write_cr8(unsigned long x)
 {
 	PVOP_VCALL1(cpu.write_cr8, x);
 }
-#endif
 
 static inline void arch_safe_halt(void)
 {
@@ -283,12 +281,10 @@ static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 	PVOP_VCALL2(cpu.load_tls, t, cpu);
 }
 
-#ifdef CONFIG_X86_64
 static inline void load_gs_index(unsigned int gs)
 {
 	PVOP_VCALL1(cpu.load_gs_index, gs);
 }
-#endif
 
 static inline void write_ldt_entry(struct desc_struct *dt, int entry,
 				   const void *desc)
@@ -375,50 +371,28 @@ static inline pte_t __pte(pteval_t val)
 {
 	pteval_t ret;
 
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, mmu.make_pte, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
+	ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
 
 	return (pte_t) { .pte = ret };
 }
 
 static inline pteval_t pte_val(pte_t pte)
 {
-	pteval_t ret;
-
-	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, mmu.pte_val,
-				   pte.pte, (u64)pte.pte >> 32);
-	else
-		ret = PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
-
-	return ret;
+	return PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
 }
 
 static inline pgd_t __pgd(pgdval_t val)
 {
 	pgdval_t ret;
 
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pgdval_t, mmu.make_pgd, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val);
+	ret = PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val);
 
 	return (pgd_t) { ret };
 }
 
 static inline pgdval_t pgd_val(pgd_t pgd)
 {
-	pgdval_t ret;
-
-	if (sizeof(pgdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pgdval_t, mmu.pgd_val,
-				    pgd.pgd, (u64)pgd.pgd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
-
-	return ret;
+	return PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
@@ -435,79 +409,48 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned
 static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 					   pte_t *ptep, pte_t old_pte, pte_t pte)
 {
-
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_ops.mmu.ptep_modify_prot_commit(vma, addr, ptep, pte);
-	else
-		PVOP_VCALL4(mmu.ptep_modify_prot_commit,
-			    vma, addr, ptep, pte.pte);
+	PVOP_VCALL4(mmu.ptep_modify_prot_commit, vma, addr, ptep, pte.pte);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	if (sizeof(pteval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pte, ptep, pte.pte, (u64)pte.pte >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
+	PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
 }
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	if (sizeof(pteval_t) > sizeof(long))
-		/* 5 arg words */
-		pv_ops.mmu.set_pte_at(mm, addr, ptep, pte);
-	else
-		PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
+	PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	pmdval_t val = native_pmd_val(pmd);
 
-	if (sizeof(pmdval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pmd, pmdp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pmd, pmdp, val);
+	PVOP_VCALL2(mmu.set_pmd, pmdp, val);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 3
 static inline pmd_t __pmd(pmdval_t val)
 {
 	pmdval_t ret;
 
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pmdval_t, mmu.make_pmd, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val);
+	ret = PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val);
 
 	return (pmd_t) { ret };
 }
 
 static inline pmdval_t pmd_val(pmd_t pmd)
 {
-	pmdval_t ret;
-
-	if (sizeof(pmdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pmdval_t, mmu.pmd_val,
-				    pmd.pmd, (u64)pmd.pmd >> 32);
-	else
-		ret =  PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
-
-	return ret;
+	return PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	pudval_t val = native_pud_val(pud);
 
-	if (sizeof(pudval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_pud, pudp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_pud, pudp, val);
+	PVOP_VCALL2(mmu.set_pud, pudp, val);
 }
-#if CONFIG_PGTABLE_LEVELS >= 4
+
 static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
@@ -572,29 +515,6 @@ static inline void p4d_clear(p4d_t *p4dp)
 	set_p4d(p4dp, __p4d(0));
 }
 
-#endif	/* CONFIG_PGTABLE_LEVELS == 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
-#ifdef CONFIG_X86_PAE
-/* Special-case pte-setting operations for PAE, which can't update a
-   64-bit pte atomically */
-static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
-{
-	PVOP_VCALL3(mmu.set_pte_atomic, ptep, pte.pte, pte.pte >> 32);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t *ptep)
-{
-	PVOP_VCALL3(mmu.pte_clear, mm, addr, ptep);
-}
-
-static inline void pmd_clear(pmd_t *pmdp)
-{
-	PVOP_VCALL1(mmu.pmd_clear, pmdp);
-}
-#else  /* !CONFIG_X86_PAE */
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	set_pte(ptep, pte);
@@ -610,7 +530,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 {
 	set_pmd(pmdp, __pmd(0));
 }
-#endif	/* CONFIG_X86_PAE */
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2474e434a6f7..b73d79091a0b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -71,9 +71,7 @@ struct pv_info {
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
 
-#ifdef CONFIG_X86_64
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
-#endif
 #endif
 
 	const char *name;
@@ -119,10 +117,8 @@ struct pv_cpu_ops {
 
 	void (*write_cr4)(unsigned long);
 
-#ifdef CONFIG_X86_64
 	unsigned long (*read_cr8)(void);
 	void (*write_cr8)(unsigned long);
-#endif
 
 	/* Segment descriptor handling */
 	void (*load_tr_desc)(void);
@@ -131,9 +127,7 @@ struct pv_cpu_ops {
 	void (*set_ldt)(const void *desc, unsigned entries);
 	unsigned long (*store_tr)(void);
 	void (*load_tls)(struct thread_struct *t, unsigned int cpu);
-#ifdef CONFIG_X86_64
 	void (*load_gs_index)(unsigned int idx);
-#endif
 	void (*write_ldt_entry)(struct desc_struct *ldt, int entrynum,
 				const void *desc);
 	void (*write_gdt_entry)(struct desc_struct *,
@@ -266,21 +260,11 @@ struct pv_mmu_ops {
 	struct paravirt_callee_save pgd_val;
 	struct paravirt_callee_save make_pgd;
 
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	void (*set_pte_atomic)(pte_t *ptep, pte_t pteval);
-	void (*pte_clear)(struct mm_struct *mm, unsigned long addr,
-			  pte_t *ptep);
-	void (*pmd_clear)(pmd_t *pmdp);
-
-#endif	/* CONFIG_X86_PAE */
-
 	void (*set_pud)(pud_t *pudp, pud_t pudval);
 
 	struct paravirt_callee_save pmd_val;
 	struct paravirt_callee_save make_pmd;
 
-#if CONFIG_PGTABLE_LEVELS >= 4
 	struct paravirt_callee_save pud_val;
 	struct paravirt_callee_save make_pud;
 
@@ -293,10 +277,6 @@ struct pv_mmu_ops {
 	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
 #endif	/* CONFIG_PGTABLE_LEVELS >= 5 */
 
-#endif	/* CONFIG_PGTABLE_LEVELS >= 4 */
-
-#endif	/* CONFIG_PGTABLE_LEVELS >= 3 */
-
 	struct pv_lazy_ops lazy_mode;
 
 	/* dom0 ops */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 33845d36897c..3955770d1a4d 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -20,12 +20,7 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT_XXL
-#define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
-				 (pv_info.shared_kernel_pmd)))
-#else
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
-#endif
 
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2c57fffebf9b..a34246b01458 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1257,15 +1257,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	 * ESPFIX issue, we can change this.
 	 */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_PARAVIRT_XXL
-	do {
-		extern void native_iret(void);
-		if (pv_ops.cpu.iret == native_iret)
-			set_cpu_bug(c, X86_BUG_ESPFIX);
-	} while (0);
-# else
 	set_cpu_bug(c, X86_BUG_ESPFIX);
-# endif
 #endif
 }
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 06f6bb48d018..c9451267b4a3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -284,10 +284,8 @@ struct pv_info pv_info = {
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
-#ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = __USER_CS,
 #endif
-#endif
 };
 
 /* 64-bit pagetable entries */
@@ -311,10 +309,8 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-#ifdef CONFIG_X86_64
 	.cpu.read_cr8		= native_read_cr8,
 	.cpu.write_cr8		= native_write_cr8,
-#endif
 	.cpu.wbinvd		= native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
@@ -327,9 +323,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.load_idt		= native_load_idt,
 	.cpu.store_tr		= native_store_tr,
 	.cpu.load_tls		= native_load_tls,
-#ifdef CONFIG_X86_64
 	.cpu.load_gs_index	= native_load_gs_index,
-#endif
 	.cpu.write_ldt_entry	= native_write_ldt_entry,
 	.cpu.write_gdt_entry	= native_write_gdt_entry,
 	.cpu.write_idt_entry	= native_write_idt_entry,
@@ -339,9 +333,7 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-#ifdef CONFIG_X86_64
 	.cpu.usergs_sysret64	= native_usergs_sysret64,
-#endif
 	.cpu.iret		= native_iret,
 	.cpu.swapgs		= native_swapgs,
 
@@ -394,18 +386,11 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.ptep_modify_prot_start	= __ptep_modify_prot_start,
 	.mmu.ptep_modify_prot_commit	= __ptep_modify_prot_commit,
 
-#if CONFIG_PGTABLE_LEVELS >= 3
-#ifdef CONFIG_X86_PAE
-	.mmu.set_pte_atomic	= native_set_pte_atomic,
-	.mmu.pte_clear		= native_pte_clear,
-	.mmu.pmd_clear		= native_pmd_clear,
-#endif
 	.mmu.set_pud		= native_set_pud,
 
 	.mmu.pmd_val		= PTE_IDENT,
 	.mmu.make_pmd		= PTE_IDENT,
 
-#if CONFIG_PGTABLE_LEVELS >= 4
 	.mmu.pud_val		= PTE_IDENT,
 	.mmu.make_pud		= PTE_IDENT,
 
@@ -417,8 +402,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.set_pgd		= native_set_pgd,
 #endif /* CONFIG_PGTABLE_LEVELS >= 5 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 4 */
-#endif /* CONFIG_PGTABLE_LEVELS >= 3 */
 
 	.mmu.pte_val		= PTE_IDENT,
 	.mmu.pgd_val		= PTE_IDENT,
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index de138d3912e4..f46a700d781a 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,23 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/paravirt.h>
 
-#ifdef CONFIG_PARAVIRT_XXL
-DEF_NATIVE(irq, irq_disable, "cli");
-DEF_NATIVE(irq, irq_enable, "sti");
-DEF_NATIVE(irq, restore_fl, "push %eax; popf");
-DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
-DEF_NATIVE(cpu, iret, "iret");
-DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
-
-unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
-{
-	/* arg in %edx:%eax, return in %edx:%eax */
-	return 0;
-}
-#endif
-
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
 DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
@@ -28,22 +11,8 @@ extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 {
-#define PATCH_SITE(ops, x)					\
-	case PARAVIRT_PATCH(ops.x):				\
-		return paravirt_patch_insns(ibuf, len, start_##ops##_##x, end_##ops##_##x)
-
-	switch (type) {
-#ifdef CONFIG_PARAVIRT_XXL
-		PATCH_SITE(irq, irq_disable);
-		PATCH_SITE(irq, irq_enable);
-		PATCH_SITE(irq, restore_fl);
-		PATCH_SITE(irq, save_fl);
-		PATCH_SITE(cpu, iret);
-		PATCH_SITE(mmu, read_cr2);
-		PATCH_SITE(mmu, read_cr3);
-		PATCH_SITE(mmu, write_cr3);
-#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
+	switch (type) {
 	case PARAVIRT_PATCH(lock.queued_spin_unlock):
 		if (pv_is_native_spin_unlock())
 			return paravirt_patch_insns(ibuf, len,
@@ -57,11 +26,10 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 						    start_lock_vcpu_is_preempted,
 						    end_lock_vcpu_is_preempted);
 		break;
-#endif
 
 	default:
 		break;
 	}
-#undef PATCH_SITE
+#endif
 	return paravirt_patch_default(type, ibuf, addr, len);
 }
-- 
2.16.4

