Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33AFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C22206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKMVC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38876 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKMVCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:21 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmJ-00066L-Gs; Wed, 13 Nov 2019 22:02:15 +0100
Message-Id: <20191113210104.002114856@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 03/20] x86/cpu: Unify cpu_init()
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Similar to copy_thread_tls() the 32bit and 64bit implementations of
cpu_init() are very similar and unification avoids duplicate changes in the
future.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>

---
V2: Fix 32bit build by removing the pointless #ifdef around the uv header include.
---
 arch/x86/kernel/cpu/common.c |  175 ++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 109 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -53,10 +53,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
-
-#ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/uv/uv.h>
-#endif
 
 #include "cpu.h"
 
@@ -1749,7 +1746,7 @@ static void wait_for_master_cpu(int cpu)
 }
 
 #ifdef CONFIG_X86_64
-static void setup_getcpu(int cpu)
+static inline void setup_getcpu(int cpu)
 {
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
@@ -1769,7 +1766,43 @@ static void setup_getcpu(int cpu)
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPUNODE, &d, DESCTYPE_S);
 }
+
+static inline void ucode_cpu_init(int cpu)
+{
+	if (cpu)
+		load_ucode_ap();
+}
+
+static inline void tss_setup_ist(struct tss_struct *tss)
+{
+	/* Set up the per-CPU TSS IST stacks */
+	tss->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
+	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
+	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
+	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+}
+
+static inline void gdt_setup_doublefault_tss(int cpu) { }
+
+#else /* CONFIG_X86_64 */
+
+static inline void setup_getcpu(int cpu) { }
+
+static inline void ucode_cpu_init(int cpu)
+{
+	show_ucode_info_early();
+}
+
+static inline void tss_setup_ist(struct tss_struct *tss) { }
+
+static inline void gdt_setup_doublefault_tss(int cpu)
+{
+#ifdef CONFIG_DOUBLEFAULT
+	/* Set up the doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
+}
+#endif /* !CONFIG_X86_64 */
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
@@ -1777,21 +1810,15 @@ static void setup_getcpu(int cpu)
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
  */
-#ifdef CONFIG_X86_64
-
 void cpu_init(void)
 {
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
-	struct task_struct *me;
-	struct tss_struct *t;
-	int i;
 
 	wait_for_master_cpu(cpu);
 
-	if (cpu)
-		load_ucode_ap();
-
-	t = &per_cpu(cpu_tss_rw, cpu);
+	ucode_cpu_init(cpu);
 
 #ifdef CONFIG_NUMA
 	if (this_cpu_read(numa_node) == 0 &&
@@ -1800,63 +1827,48 @@ void cpu_init(void)
 #endif
 	setup_getcpu(cpu);
 
-	me = current;
-
 	pr_debug("Initializing CPU#%d\n", cpu);
 
-	cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
+	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
+		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
 	 * and set up the GDT descriptor:
 	 */
-
 	switch_to_new_gdt(cpu);
-	loadsegment(fs, 0);
-
 	load_current_idt();
 
-	memset(me->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
-	syscall_init();
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		loadsegment(fs, 0);
+		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
+		syscall_init();
+
+		wrmsrl(MSR_FS_BASE, 0);
+		wrmsrl(MSR_KERNEL_GS_BASE, 0);
+		barrier();
 
-	wrmsrl(MSR_FS_BASE, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, 0);
-	barrier();
-
-	x86_configure_nx();
-	x2apic_setup();
-
-	/*
-	 * set up and load the per-CPU TSS
-	 */
-	if (!t->x86_tss.ist[0]) {
-		t->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
-		t->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
-		t->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
-		t->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+		x2apic_setup();
 	}
 
-	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
-
-	/*
-	 * <= is required because the CPU will access up to
-	 * 8 bits beyond the end of the IO permission bitmap.
-	 */
-	for (i = 0; i <= IO_BITMAP_LONGS; i++)
-		t->io_bitmap[i] = ~0UL;
-
 	mmgrab(&init_mm);
-	me->active_mm = &init_mm;
-	BUG_ON(me->mm);
+	cur->active_mm = &init_mm;
+	BUG_ON(cur->mm);
 	initialize_tlbstate_and_flush();
-	enter_lazy_tlb(&init_mm, me);
+	enter_lazy_tlb(&init_mm, cur);
 
-	/*
-	 * Initialize the TSS.  sp0 points to the entry trampoline stack
-	 * regardless of what task is running.
-	 */
+	/* Initialize the TSS. */
+	tss_setup_ist(tss);
+	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
+	memset(tss->io_bitmap, 0xff, sizeof(tss->io_bitmap));
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
+
 	load_TR_desc();
+	/*
+	 * sp0 points to the entry trampoline stack regardless of what task
+	 * is running.
+	 */
 	load_sp0((unsigned long)(cpu_entry_stack(cpu) + 1));
 
 	load_mm_ldt(&init_mm);
@@ -1864,6 +1876,8 @@ void cpu_init(void)
 	clear_all_debug_regs();
 	dbg_restore_debug_regs();
 
+	gdt_setup_doublefault_tss(cpu);
+
 	fpu__init_cpu();
 
 	if (is_uv_system())
@@ -1872,63 +1886,6 @@ void cpu_init(void)
 	load_fixmap_gdt(cpu);
 }
 
-#else
-
-void cpu_init(void)
-{
-	int cpu = smp_processor_id();
-	struct task_struct *curr = current;
-	struct tss_struct *t = &per_cpu(cpu_tss_rw, cpu);
-
-	wait_for_master_cpu(cpu);
-
-	show_ucode_info_early();
-
-	pr_info("Initializing CPU#%d\n", cpu);
-
-	if (cpu_feature_enabled(X86_FEATURE_VME) ||
-	    boot_cpu_has(X86_FEATURE_TSC) ||
-	    boot_cpu_has(X86_FEATURE_DE))
-		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-
-	load_current_idt();
-	switch_to_new_gdt(cpu);
-
-	/*
-	 * Set up and load the per-CPU TSS and LDT
-	 */
-	mmgrab(&init_mm);
-	curr->active_mm = &init_mm;
-	BUG_ON(curr->mm);
-	initialize_tlbstate_and_flush();
-	enter_lazy_tlb(&init_mm, curr);
-
-	/*
-	 * Initialize the TSS.  sp0 points to the entry trampoline stack
-	 * regardless of what task is running.
-	 */
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
-	load_TR_desc();
-	load_sp0((unsigned long)(cpu_entry_stack(cpu) + 1));
-
-	load_mm_ldt(&init_mm);
-
-	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
-
-#ifdef CONFIG_DOUBLEFAULT
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-#endif
-
-	clear_all_debug_regs();
-	dbg_restore_debug_regs();
-
-	fpu__init_cpu();
-
-	load_fixmap_gdt(cpu);
-}
-#endif
-
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU




