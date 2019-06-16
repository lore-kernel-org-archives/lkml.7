Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373AC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC57821841
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFPLdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 07:33:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 07:33:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcTPE-0008Nu-FU; Sun, 16 Jun 2019 13:33:04 +0200
Date:   Sun, 16 Jun 2019 11:29:52 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86 fixes for 5.2
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
Message-ID: <156068459205.30217.5408680705089895210.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  78f4e932f776: x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback

The accumulated fixes from this and last week:

 - Fix vmalloc TLB flush and map range calculations which lead to stale
   TLBs, spurious faults and other hard to diagnose issues.

 - Use fault_in_pages_writable() for prefaulting the user stack in the FPU
   code as it's less fragile as the current solution

 - Use the PF_KTHREAD flag when checking for a kernel thread instead of
   current->mm as the latter can give the wrong answer due to use_mm()

 - Compute the vmemmap size correctly for KASLR and 5-Level paging. Otherwise
   this can end up with a way to small vmemmap area.

 - Make KASAN and 5-level paging work again by making sure that all invalid
   bits are masked out when computing the P4D offset. This worked before
   but got broken recently when the LDT remap area was moved.

 - Prevent a NULL pointer dereference in the resource control code which
   can be triggered with certain mount options when the requested resource
   is not available.

 - Enforce ordering of microcode loading vs. perf initialization on
   secondary CPUs. Otherwise perf tries to access a non-existing MSR as the
   boot CPU marked it as available.

 - Don't stop the resource control group walk early otherwise the control
   bitmaps are not updated correctly and become inconsistent.

 - Unbreak kgdb by returning 0 on success from kgdb_arch_set_breakpoint()
   instead of an error code.

 - Add more Icelake CPU model defines so depending changes can be queued in
   other trees

Thanks,

	tglx

------------------>
Andrey Ryabinin (1):
      x86/kasan: Fix boot with 5-level paging and KASAN

Baoquan He (1):
      x86/mm/KASLR: Compute the size of the vmemmap section properly

Borislav Petkov (1):
      x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback

Christoph Hellwig (1):
      x86/fpu: Don't use current->mm to check for a kthread

Hugh Dickins (1):
      x86/fpu: Use fault_in_pages_writeable() for pre-faulting

James Morse (1):
      x86/resctrl: Don't stop walking closids when a locksetup group is found

Kan Liang (1):
      x86/CPU: Add more Icelake model numbers

Matt Mullins (1):
      x86/kgdb: Return 0 from kgdb_arch_set_breakpoint()

Prarit Bhargava (1):
      x86/resctrl: Prevent NULL pointer dereference when local MBM is disabled

Rick Edgecombe (2):
      mm/vmalloc: Fix calculation of direct map addr range
      mm/vmalloc: Avoid rare case of flushing TLB with weird arguments

Sebastian Andrzej Siewior (1):
      x86/fpu: Update kernel's FPU state before using for the fsave header


 arch/x86/include/asm/fpu/internal.h    |  6 +++---
 arch/x86/include/asm/intel-family.h    |  3 +++
 arch/x86/kernel/cpu/microcode/core.c   |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++++++-
 arch/x86/kernel/fpu/core.c             |  2 +-
 arch/x86/kernel/fpu/signal.c           | 16 +++++++---------
 arch/x86/kernel/kgdb.c                 |  2 +-
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/x86/mm/kaslr.c                    | 11 ++++++++++-
 include/linux/cpuhotplug.h             |  1 +
 mm/vmalloc.c                           | 14 ++++++++------
 12 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 9e27fa05a7ae..4c95c365058a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -536,7 +536,7 @@ static inline void __fpregs_load_activate(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->mm == NULL))
+	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
@@ -567,11 +567,11 @@ static inline void __fpregs_load_activate(void)
  * otherwise.
  *
  * The FPU context is only stored/restored for a user task and
- * ->mm is used to distinguish between kernel and user threads.
+ * PF_KTHREAD is used to distinguish between kernel and user threads.
  */
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU) && current->mm) {
+	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9f15384c504a..310118805f57 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,6 +52,9 @@
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
+#define INTEL_FAM6_ICELAKE_X		0x6A
+#define INTEL_FAM6_ICELAKE_XEON_D	0x6C
+#define INTEL_FAM6_ICELAKE_DESKTOP	0x7D
 #define INTEL_FAM6_ICELAKE_MOBILE	0x7E
 
 /* "Small Core" Processors (Atom) */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 70a04436380e..a813987b5552 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -872,7 +872,7 @@ int __init microcode_init(void)
 		goto out_ucode_group;
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
+	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1573a0a6b525..ff6e8e561405 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -368,6 +368,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
+	if (!is_mbm_local_enabled())
+		return;
+
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 333c177a2471..869cbef5da81 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2542,7 +2542,12 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
 			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
-				break;
+				/*
+				 * ctrl values for locksetup aren't relevant
+				 * until the schemata is written, and the mode
+				 * becomes RDT_MODE_PSEUDO_LOCKED.
+				 */
+				continue;
 			/*
 			 * If CDP is active include peer domain's
 			 * usage to ensure there is no overlap
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 466fca686fb9..649fbc3fcf9f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -102,7 +102,7 @@ static void __kernel_fpu_begin(void)
 
 	kernel_fpu_disable();
 
-	if (current->mm) {
+	if (!(current->flags & PF_KTHREAD)) {
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
 			set_thread_flag(TIF_NEED_FPU_LOAD);
 			/*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5a8d118bc423..0071b794ed19 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -5,6 +5,7 @@
 
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/pagemap.h>
 
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
@@ -61,6 +62,11 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
+		fpregs_lock();
+		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+			copy_fxregs_to_kernel(&tsk->thread.fpu);
+		fpregs_unlock();
+
 		convert_from_fxsr(&env, tsk);
 
 		if (__copy_to_user(buf, &env, sizeof(env)) ||
@@ -189,15 +195,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret == nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9a8c1648fc9a..6690c5652aeb 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -758,7 +758,7 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		       BREAK_INSTR_SIZE);
 	bpt->type = BP_POKE_BREAKPOINT;
 
-	return err;
+	return 0;
 }
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 8dc0fc0b1382..296da58f3013 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -199,7 +199,7 @@ static inline p4d_t *early_p4d_offset(pgd_t *pgd, unsigned long addr)
 	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
 
-	p4d = __pa_nodebug(pgd_val(*pgd)) & PTE_PFN_MASK;
+	p4d = pgd_val(*pgd) & PTE_PFN_MASK;
 	p4d += __START_KERNEL_map - phys_base;
 	return (p4d_t *)p4d + p4d_index(addr);
 }
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc3f058bdf9b..dc6182eecefa 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
 } kaslr_regions[] = {
 	{ &page_offset_base, 0 },
 	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 1 },
+	{ &vmemmap_base, 0 },
 };
 
 /* Get size in bytes used by the memory region */
@@ -78,6 +78,7 @@ void __init kernel_randomize_memory(void)
 	unsigned long rand, memory_tb;
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
+	unsigned long vmemmap_size;
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -109,6 +110,14 @@ void __init kernel_randomize_memory(void)
 	if (memory_tb < kaslr_regions[0].size_tb)
 		kaslr_regions[0].size_tb = memory_tb;
 
+	/*
+	 * Calculate the vmemmap region size in TBs, aligned to a TB
+	 * boundary.
+	 */
+	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
+			sizeof(struct page);
+	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
+
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6a381594608c..5c6062206760 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -101,6 +101,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
+	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7350a124524b..4c9e150e5ad3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2123,9 +2123,9 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 /* Handle removing and resetting vm mappings related to the vm_struct. */
 static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 {
-	unsigned long addr = (unsigned long)area->addr;
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
+	int flush_dmap = 0;
 	int i;
 
 	/*
@@ -2135,8 +2135,8 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * execute permissions, without leaving a RW+X window.
 	 */
 	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		set_memory_nx(addr, area->nr_pages);
-		set_memory_rw(addr, area->nr_pages);
+		set_memory_nx((unsigned long)area->addr, area->nr_pages);
+		set_memory_rw((unsigned long)area->addr, area->nr_pages);
 	}
 
 	remove_vm_area(area->addr);
@@ -2160,9 +2160,11 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * the vm_unmap_aliases() flush includes the direct map.
 	 */
 	for (i = 0; i < area->nr_pages; i++) {
-		if (page_address(area->pages[i])) {
+		unsigned long addr = (unsigned long)page_address(area->pages[i]);
+		if (addr) {
 			start = min(addr, start);
-			end = max(addr, end);
+			end = max(addr + PAGE_SIZE, end);
+			flush_dmap = 1;
 		}
 	}
 
@@ -2172,7 +2174,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * reset the direct map permissions to the default.
 	 */
 	set_area_direct_map(area, set_direct_map_invalid_noflush);
-	_vm_unmap_aliases(start, end, 1);
+	_vm_unmap_aliases(start, end, flush_dmap);
 	set_area_direct_map(area, set_direct_map_default_noflush);
 }
 

