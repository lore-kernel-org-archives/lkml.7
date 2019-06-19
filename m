Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04051C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC07C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560930572;
	bh=jFjt4mOUZ7RInGkZfou5f9uaL/3OjrrYf5P0awFtrOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2plPwTqkIqxpBE0X3zxf+QI1+AbAXn/9b1svldIoz8OxWftVRlQUUlD3i6HiVk6kj
	 K6FgFffL7bD9WXQHmtXIPJeEHlqWMW0iEMZuKxwdmm9Z3448iRmUxGGmg0HH73F2gC
	 q2msqpLl5UVG0VDvB7wK1yE5hCbdpeNiGVEX9+tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfFSHtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbfFSHta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:30 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3921C21479;
        Wed, 19 Jun 2019 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560930569;
        bh=jFjt4mOUZ7RInGkZfou5f9uaL/3OjrrYf5P0awFtrOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xskst31QS7cfbm5NFYG3ZQQns3J4QUsbU79eQszb69fcTqYlNHbfgJUVOJaTSxXMK
         VEcXjoiFfEQP6LDlwp+rS3mMUx+NgZ5NLOpRmcxcMFB0KVNhgoXx1GINV9tIqxdrqd
         6G1RzhSoTbGt3Csbt4TsKp0Q8Ad1or+qayF1RUDg=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/4] csky: Revert mmu ASID mechanism
Date:   Wed, 19 Jun 2019 15:49:10 +0800
Message-Id: <1560930553-26502-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560930553-26502-1-git-send-email-guoren@kernel.org>
References: <1560930553-26502-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Current C-SKY ASID mechanism is from mips and it doesn't work well
in a multi-core case. ASID per core mechanism is not suitable for
C-SKY SMP tlb maintain operations, eg: tlbi.vas need share the same
asid in all processors and it'll invalid the tlb entry in all cores
with the same asid.

This patch is prepare for new ASID mechanism.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/mmu.h         |   1 -
 arch/csky/include/asm/mmu_context.h | 112 ++-------------------
 arch/csky/include/asm/pgtable.h     |   2 -
 arch/csky/kernel/smp.c              |   2 -
 arch/csky/mm/init.c                 |   2 -
 arch/csky/mm/tlb.c                  | 190 ++----------------------------------
 6 files changed, 14 insertions(+), 295 deletions(-)

diff --git a/arch/csky/include/asm/mmu.h b/arch/csky/include/asm/mmu.h
index cb34467..06f509a 100644
--- a/arch/csky/include/asm/mmu.h
+++ b/arch/csky/include/asm/mmu.h
@@ -5,7 +5,6 @@
 #define __ASM_CSKY_MMU_H
 
 typedef struct {
-	unsigned long asid[NR_CPUS];
 	void *vdso;
 } mm_context_t;
 
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index 734db3a1..86dde48 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -16,122 +16,24 @@
 
 #define TLBMISS_HANDLER_SETUP_PGD(pgd) \
 	setup_pgd(__pa(pgd), false)
+
 #define TLBMISS_HANDLER_SETUP_PGD_KERNEL(pgd) \
 	setup_pgd(__pa(pgd), true)
 
-#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
-#define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
-
-#define ASID_FIRST_VERSION	(1 << CONFIG_CPU_ASID_BITS)
-#define ASID_INC		0x1
-#define ASID_MASK		(ASID_FIRST_VERSION - 1)
-#define ASID_VERSION_MASK	~ASID_MASK
+#define init_new_context(tsk,mm)	0
+#define activate_mm(prev,next)		switch_mm(prev, next, current)
 
 #define destroy_context(mm)		do {} while (0)
 #define enter_lazy_tlb(mm, tsk)		do {} while (0)
 #define deactivate_mm(tsk, mm)		do {} while (0)
 
-/*
- *  All unused by hardware upper bits will be considered
- *  as a software asid extension.
- */
-static inline void
-get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
-{
-	unsigned long asid = asid_cache(cpu);
-
-	asid += ASID_INC;
-	if (!(asid & ASID_MASK)) {
-		flush_tlb_all();	/* start new asid cycle */
-		if (!asid)		/* fix version if needed */
-			asid = ASID_FIRST_VERSION;
-	}
-	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
-}
-
-/*
- * Initialize the context related info for a new mm_struct
- * instance.
- */
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	int i;
-
-	for_each_online_cpu(i)
-		cpu_context(i, mm) = 0;
-	return 0;
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			struct task_struct *tsk)
-{
-	unsigned int cpu = smp_processor_id();
-	unsigned long flags;
-
-	local_irq_save(flags);
-	/* Check if our ASID is of an older version and thus invalid */
-	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
-		get_new_mmu_context(next, cpu);
-	write_mmu_entryhi(cpu_asid(cpu, next));
-	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
-
-	/*
-	 * Mark current->active_mm as not "active" anymore.
-	 * We don't want to mislead possible IPI tlb flush routines.
-	 */
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
-	cpumask_set_cpu(cpu, mm_cpumask(next));
-
-	local_irq_restore(flags);
-}
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
 static inline void
-activate_mm(struct mm_struct *prev, struct mm_struct *next)
+switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	  struct task_struct *tsk)
 {
-	unsigned long flags;
-	int cpu = smp_processor_id();
-
-	local_irq_save(flags);
+	if (prev != next)
+		tlb_invalid_all();
 
-	/* Unconditionally get a new ASID.  */
-	get_new_mmu_context(next, cpu);
-
-	write_mmu_entryhi(cpu_asid(cpu, next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
-
-	/* mark mmu ownership change */
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
-	cpumask_set_cpu(cpu, mm_cpumask(next));
-
-	local_irq_restore(flags);
 }
-
-/*
- * If mm is currently active_mm, we can't really drop it. Instead,
- * we will get a new one for it.
- */
-static inline void
-drop_mmu_context(struct mm_struct *mm, unsigned int cpu)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
-		get_new_mmu_context(mm, cpu);
-		write_mmu_entryhi(cpu_asid(cpu, mm));
-	} else {
-		/* will get a new context next time */
-		cpu_context(cpu, mm) = 0;
-	}
-
-	local_irq_restore(flags);
-}
-
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index dcea277..c429a6f 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -290,8 +290,6 @@ static inline pte_t *pte_offset(pmd_t *dir, unsigned long address)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init(void);
 
-extern void show_jtlb_table(void);
-
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *pte);
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b07a534..b753d38 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -212,8 +212,6 @@ void csky_start_secondary(void)
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
 	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
 
-	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
-
 #ifdef CONFIG_CPU_HAS_FPU
 	init_fpu();
 #endif
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 66e5970..eb0dc9e 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -114,8 +114,6 @@ void __init pre_mmu_init(void)
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
 	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
 
-	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
-
 	/* Setup page mask to 4k */
 	write_mmu_pagemask(0);
 }
diff --git a/arch/csky/mm/tlb.c b/arch/csky/mm/tlb.c
index 08b8394..efae81c 100644
--- a/arch/csky/mm/tlb.c
+++ b/arch/csky/mm/tlb.c
@@ -10,8 +10,6 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 
-#define CSKY_TLB_SIZE CONFIG_CPU_TLB_SIZE
-
 void flush_tlb_all(void)
 {
 	tlb_invalid_all();
@@ -19,201 +17,27 @@ void flush_tlb_all(void)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	int cpu = smp_processor_id();
-
-	if (cpu_context(cpu, mm) != 0)
-		drop_mmu_context(mm, cpu);
-
 	tlb_invalid_all();
 }
 
-#define restore_asid_inv_utlb(oldpid, newpid) \
-do { \
-	if ((oldpid & ASID_MASK) == newpid) \
-		write_mmu_entryhi(oldpid + 1); \
-	write_mmu_entryhi(oldpid); \
-} while (0)
-
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			   unsigned long end)
+			unsigned long end)
 {
-	struct mm_struct *mm = vma->vm_mm;
-	int cpu = smp_processor_id();
-
-	if (cpu_context(cpu, mm) != 0) {
-		unsigned long size, flags;
-		int newpid = cpu_asid(cpu, mm);
-
-		local_irq_save(flags);
-		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-		size = (size + 1) >> 1;
-		if (size <= CSKY_TLB_SIZE/2) {
-			start &= (PAGE_MASK << 1);
-			end += ((PAGE_SIZE << 1) - 1);
-			end &= (PAGE_MASK << 1);
-#ifdef CONFIG_CPU_HAS_TLBI
-			while (start < end) {
-				asm volatile("tlbi.vaas %0"
-					     ::"r"(start | newpid));
-				start += (PAGE_SIZE << 1);
-			}
-			sync_is();
-#else
-			{
-			int oldpid = read_mmu_entryhi();
-
-			while (start < end) {
-				int idx;
-
-				write_mmu_entryhi(start | newpid);
-				start += (PAGE_SIZE << 1);
-				tlb_probe();
-				idx = read_mmu_index();
-				if (idx >= 0)
-					tlb_invalid_indexed();
-			}
-			restore_asid_inv_utlb(oldpid, newpid);
-			}
-#endif
-		} else {
-			drop_mmu_context(mm, cpu);
-		}
-		local_irq_restore(flags);
-	}
+	tlb_invalid_all();
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	unsigned long size, flags;
-
-	local_irq_save(flags);
-	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-	if (size <= CSKY_TLB_SIZE) {
-		start &= (PAGE_MASK << 1);
-		end += ((PAGE_SIZE << 1) - 1);
-		end &= (PAGE_MASK << 1);
-#ifdef CONFIG_CPU_HAS_TLBI
-		while (start < end) {
-			asm volatile("tlbi.vaas %0"::"r"(start));
-			start += (PAGE_SIZE << 1);
-		}
-		sync_is();
-#else
-		{
-		int oldpid = read_mmu_entryhi();
-
-		while (start < end) {
-			int idx;
-
-			write_mmu_entryhi(start);
-			start += (PAGE_SIZE << 1);
-			tlb_probe();
-			idx = read_mmu_index();
-			if (idx >= 0)
-				tlb_invalid_indexed();
-		}
-		restore_asid_inv_utlb(oldpid, 0);
-		}
-#endif
-	} else {
-		flush_tlb_all();
-	}
-
-	local_irq_restore(flags);
+	tlb_invalid_all();
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	int cpu = smp_processor_id();
-	int newpid = cpu_asid(cpu, vma->vm_mm);
-
-	if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
-		page &= (PAGE_MASK << 1);
-
-#ifdef CONFIG_CPU_HAS_TLBI
-		asm volatile("tlbi.vaas %0"::"r"(page | newpid));
-		sync_is();
-#else
-		{
-		int oldpid, idx;
-		unsigned long flags;
-
-		local_irq_save(flags);
-		oldpid = read_mmu_entryhi();
-		write_mmu_entryhi(page | newpid);
-		tlb_probe();
-		idx = read_mmu_index();
-		if (idx >= 0)
-			tlb_invalid_indexed();
-
-		restore_asid_inv_utlb(oldpid, newpid);
-		local_irq_restore(flags);
-		}
-#endif
-	}
+	tlb_invalid_all();
 }
 
-/*
- * Remove one kernel space TLB entry.  This entry is assumed to be marked
- * global so we don't do the ASID thing.
- */
-void flush_tlb_one(unsigned long page)
+void flush_tlb_one(unsigned long addr)
 {
-	int oldpid;
-
-	oldpid = read_mmu_entryhi();
-	page &= (PAGE_MASK << 1);
-
-#ifdef CONFIG_CPU_HAS_TLBI
-	page = page | (oldpid & 0xfff);
-	asm volatile("tlbi.vaas %0"::"r"(page));
-	sync_is();
-#else
-	{
-	int idx;
-	unsigned long flags;
-
-	page = page | (oldpid & 0xff);
-
-	local_irq_save(flags);
-	write_mmu_entryhi(page);
-	tlb_probe();
-	idx = read_mmu_index();
-	if (idx >= 0)
-		tlb_invalid_indexed();
-	restore_asid_inv_utlb(oldpid, oldpid);
-	local_irq_restore(flags);
-	}
-#endif
+	tlb_invalid_all();
 }
 EXPORT_SYMBOL(flush_tlb_one);
-
-/* show current 32 jtlbs */
-void show_jtlb_table(void)
-{
-	unsigned long flags;
-	int entryhi, entrylo0, entrylo1;
-	int entry;
-	int oldpid;
-
-	local_irq_save(flags);
-	entry = 0;
-	pr_info("\n\n\n");
-
-	oldpid = read_mmu_entryhi();
-	while (entry < CSKY_TLB_SIZE) {
-		write_mmu_index(entry);
-		tlb_read();
-		entryhi = read_mmu_entryhi();
-		entrylo0 = read_mmu_entrylo0();
-		entrylo0 = entrylo0;
-		entrylo1 = read_mmu_entrylo1();
-		entrylo1 = entrylo1;
-		pr_info("jtlb[%d]:	entryhi - 0x%x;	entrylo0 - 0x%x;"
-			"	entrylo1 - 0x%x\n",
-			entry, entryhi, entrylo0, entrylo1);
-		entry++;
-	}
-	write_mmu_entryhi(oldpid);
-	local_irq_restore(flags);
-}
-- 
2.7.4

