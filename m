Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75035C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340C6214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfIPNiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:38:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39257 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbfIPNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:38:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCW-0006vg-5q; Mon, 16 Sep 2019 15:37:56 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for 5.4-rc1
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Message-ID: <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

up to:  743dac494d61: x86/apic/vector: Warn when vector space exhaustion breaks affinity

The x86/apic related changes contain:

  - Cleanup the apic IPI implementation by removing duplicated code and
    consolidating the functions into the APIC core.

  - Implement a safe variant of the IPI broadcast mode. Contrary to earlier
    attempts this uses the core tracking of which CPUs have been brought
    online at least once so that a broadcast does not end up in some dead
    end in BIOS/SMM code when the CPU is still waiting for init. Once all
    CPUs have been brought up once, IPI broadcasting is enabled. Before
    that regular one by one IPIs are issued.

    This pulls in two commits from the smp/hotplug branch.

  - Drop the paravirt CR8 related functions as they have no user anymore

  - Initialize the APIC TPR to block interrupt 16-31 as they are reserved
    for CPU exceptions and should never be raised by any well behaving
    device.

  - Emit a warning when vector space exhaustion breaks the admin set
    affinity of an interrupt.

  - Make sure to use the NMI fallback when shutdown via reboot vector IPI
    fails. The original code had conditions which prevent the code path to
    be reached.

  - Annotate various APIC config variables as RO after init.

Thanks,

	tglx

------------------>
Andrew Cooper (1):
      x86/paravirt: Drop {read,write}_cr8() hooks

Andy Lutomirski (1):
      x86/apic: Initialize TPR to block interrupts 16-31

Grzegorz Halat (1):
      x86/reboot: Always use NMI fallback when shutdown via reboot vector IPI fails

Neil Horman (1):
      x86/apic/vector: Warn when vector space exhaustion breaks affinity

Sean Christopherson (1):
      x86/apic: Annotate global config variables as "read-only after init"

Thomas Gleixner (25):
      smp/hotplug: Track booted once CPUs in a cpumask
      cpumask: Implement cpumask_or_equal()
      x86/kgbd: Use NMI_VECTOR not APIC_DM_NMI
      x86/apic: Invoke perf_events_lapic_init() after enabling APIC
      x86/apic: Soft disable APIC before initializing it
      x86/apic: Make apic_pending_intr_clear() more robust
      x86/apic: Move IPI inlines into ipi.c
      x86/apic: Cleanup the include maze
      x86/apic: Move ipi header into apic directory
      x86/apic: Move apic_flat_64 header into apic directory
      x86/apic: Consolidate the apic local headers
      x86/apic/uv: Make x2apic_extra_bits static
      x86/cpu: Move arch_smt_update() to a neutral place
      x86/hotplug: Silence APIC and NMI when CPU is dead
      x86/apic: Remove dest argument from __default_send_IPI_shortcut()
      x86/apic: Add NMI_VECTOR wait to IPI shorthand
      x86/apic: Move no_ipi_broadcast() out of 32bit
      x86/apic: Add static key to Control IPI shorthands
      x86/apic: Provide and use helper for send_IPI_allbutself()
      x86/smp: Move smp_function_call implementations into IPI code
      x86/smp: Enhance native_send_call_func_ipi()
      x86/apic: Remove the shorthand decision logic
      x86/apic: Share common IPI helpers
      x86/apic/flat64: Remove the IPI shorthand decision logic
      x86/apic/x2apic: Implement IPI shorthands support


 arch/x86/include/asm/apic.h           |  11 +-
 arch/x86/include/asm/apic_flat_64.h   |   8 --
 arch/x86/include/asm/bugs.h           |   2 +
 arch/x86/include/asm/ipi.h            | 109 --------------------
 arch/x86/include/asm/paravirt.h       |  12 ---
 arch/x86/include/asm/paravirt_types.h |   5 -
 arch/x86/include/asm/smp.h            |   1 +
 arch/x86/include/asm/special_insns.h  |  24 -----
 arch/x86/include/asm/suspend_64.h     |   2 +-
 arch/x86/kernel/apic/apic.c           | 188 +++++++++++++++++++++-------------
 arch/x86/kernel/apic/apic_flat_64.c   |  66 ++----------
 arch/x86/kernel/apic/apic_noop.c      |  18 +---
 arch/x86/kernel/apic/apic_numachip.c  |   8 +-
 arch/x86/kernel/apic/bigsmp_32.c      |   9 +-
 arch/x86/kernel/apic/ipi.c            | 174 +++++++++++++++++++++++--------
 arch/x86/kernel/apic/local.h          |  68 ++++++++++++
 arch/x86/kernel/apic/probe_32.c       |  41 +-------
 arch/x86/kernel/apic/probe_64.c       |  21 +---
 arch/x86/kernel/apic/vector.c         |  11 ++
 arch/x86/kernel/apic/x2apic.h         |   9 --
 arch/x86/kernel/apic/x2apic_cluster.c |  20 ++--
 arch/x86/kernel/apic/x2apic_phys.c    |  23 +++--
 arch/x86/kernel/apic/x2apic_uv_x.c    |  30 +-----
 arch/x86/kernel/asm-offsets_64.c      |   1 -
 arch/x86/kernel/cpu/bugs.c            |   2 +-
 arch/x86/kernel/cpu/common.c          |  11 ++
 arch/x86/kernel/kgdb.c                |   2 +-
 arch/x86/kernel/nmi.c                 |   3 +
 arch/x86/kernel/paravirt.c            |   4 -
 arch/x86/kernel/reboot.c              |   7 +-
 arch/x86/kernel/smp.c                 |  88 +++++-----------
 arch/x86/kernel/smpboot.c             |   7 +-
 arch/x86/power/cpu.c                  |   4 -
 arch/x86/xen/enlighten_pv.c           |  15 ---
 include/linux/bitmap.h                |  23 +++++
 include/linux/cpumask.h               |  16 +++
 kernel/cpu.c                          |  11 +-
 lib/bitmap.c                          |  20 ++++
 38 files changed, 498 insertions(+), 576 deletions(-)
 delete mode 100644 arch/x86/include/asm/apic_flat_64.h
 delete mode 100644 arch/x86/include/asm/ipi.h
 create mode 100644 arch/x86/kernel/apic/local.h
 delete mode 100644 arch/x86/kernel/apic/x2apic.h

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e647aa095867..2ebc17d9c72c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -136,6 +136,7 @@ extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
 extern void disable_local_APIC(void);
+extern void apic_soft_disable(void);
 extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
@@ -176,6 +177,8 @@ extern void lapic_online(void);
 extern void lapic_offline(void);
 extern bool apic_needs_pit(void);
 
+extern void apic_send_IPI_allbutself(unsigned int vector);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
@@ -465,12 +468,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
 
-#ifdef CONFIG_X86_64
-extern void apic_send_IPI_self(int vector);
-
-DECLARE_PER_CPU(int, x2apic_extra_bits);
-#endif
-
 extern void generic_bigsmp_probe(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -506,8 +503,10 @@ extern int default_check_phys_apicid_present(int phys_apicid);
 
 #ifdef CONFIG_SMP
 bool apic_id_is_primary_thread(unsigned int id);
+void apic_smt_update(void);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
+static inline void apic_smt_update(void) { }
 #endif
 
 extern void irq_enter(void);
diff --git a/arch/x86/include/asm/apic_flat_64.h b/arch/x86/include/asm/apic_flat_64.h
deleted file mode 100644
index d3a2b3876ce6..000000000000
--- a/arch/x86/include/asm/apic_flat_64.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_APIC_FLAT_64_H
-#define _ASM_X86_APIC_FLAT_64_H
-
-extern void flat_init_apic_ldr(void);
-
-#endif
-
diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 542509b53e0f..794eb2129bc6 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -18,4 +18,6 @@ int ppro_with_ram_bug(void);
 static inline int ppro_with_ram_bug(void) { return 0; }
 #endif
 
+extern void cpu_bugs_smt_update(void);
+
 #endif /* _ASM_X86_BUGS_H */
diff --git a/arch/x86/include/asm/ipi.h b/arch/x86/include/asm/ipi.h
deleted file mode 100644
index f73076be546a..000000000000
--- a/arch/x86/include/asm/ipi.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _ASM_X86_IPI_H
-#define _ASM_X86_IPI_H
-
-#ifdef CONFIG_X86_LOCAL_APIC
-
-/*
- * Copyright 2004 James Cleverdon, IBM.
- *
- * Generic APIC InterProcessor Interrupt code.
- *
- * Moved to include file by James Cleverdon from
- * arch/x86-64/kernel/smp.c
- *
- * Copyrights from kernel/smp.c:
- *
- * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
- * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
- * (c) 2002,2003 Andi Kleen, SuSE Labs.
- */
-
-#include <asm/hw_irq.h>
-#include <asm/apic.h>
-#include <asm/smp.h>
-
-/*
- * the following functions deal with sending IPIs between CPUs.
- *
- * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
- */
-
-static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
-					 unsigned int dest)
-{
-	unsigned int icr = shortcut | dest;
-
-	switch (vector) {
-	default:
-		icr |= APIC_DM_FIXED | vector;
-		break;
-	case NMI_VECTOR:
-		icr |= APIC_DM_NMI;
-		break;
-	}
-	return icr;
-}
-
-static inline int __prepare_ICR2(unsigned int mask)
-{
-	return SET_APIC_DEST_FIELD(mask);
-}
-
-static inline void __xapic_wait_icr_idle(void)
-{
-	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
-		cpu_relax();
-}
-
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
-
-/*
- * This is used to send an IPI with no shorthand notation (the destination is
- * specified in bits 56 to 63 of the ICR).
- */
-void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest);
-
-extern void default_send_IPI_single(int cpu, int vector);
-extern void default_send_IPI_single_phys(int cpu, int vector);
-extern void default_send_IPI_mask_sequence_phys(const struct cpumask *mask,
-						 int vector);
-extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
-							 int vector);
-
-/* Avoid include hell */
-#define NMI_VECTOR 0x02
-
-extern int no_broadcast;
-
-static inline void __default_local_send_IPI_allbutself(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector, apic->dest_logical);
-}
-
-static inline void __default_local_send_IPI_all(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector, apic->dest_logical);
-}
-
-#ifdef CONFIG_X86_32
-extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
-							 int vector);
-extern void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
-							 int vector);
-extern void default_send_IPI_mask_logical(const struct cpumask *mask,
-						 int vector);
-extern void default_send_IPI_allbutself(int vector);
-extern void default_send_IPI_all(int vector);
-extern void default_send_IPI_self(int vector);
-#endif
-
-#endif
-
-#endif /* _ASM_X86_IPI_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dce26f1d13e1..69089d46f128 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -139,18 +139,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-#ifdef CONFIG_X86_64
-static inline unsigned long read_cr8(void)
-{
-	return PVOP_CALL0(unsigned long, cpu.read_cr8);
-}
-
-static inline void write_cr8(unsigned long x)
-{
-	PVOP_VCALL1(cpu.write_cr8, x);
-}
-#endif
-
 static inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(irq.safe_halt);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 639b2df445ee..70b654f3ffe5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -119,11 +119,6 @@ struct pv_cpu_ops {
 
 	void (*write_cr4)(unsigned long);
 
-#ifdef CONFIG_X86_64
-	unsigned long (*read_cr8)(void);
-	void (*write_cr8)(unsigned long);
-#endif
-
 	/* Segment descriptor handling */
 	void (*load_tr_desc)(void);
 	void (*load_gdt)(const struct desc_ptr *);
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e1356a3b8223..e15f364efbcc 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -143,6 +143,7 @@ void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
+void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 219be88a59d2..6d37b8fcfc77 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -73,20 +73,6 @@ static inline unsigned long native_read_cr4(void)
 
 void native_write_cr4(unsigned long val);
 
-#ifdef CONFIG_X86_64
-static inline unsigned long native_read_cr8(void)
-{
-	unsigned long cr8;
-	asm volatile("movq %%cr8,%0" : "=r" (cr8));
-	return cr8;
-}
-
-static inline void native_write_cr8(unsigned long val)
-{
-	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
-}
-#endif
-
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 static inline u32 rdpkru(void)
 {
@@ -200,16 +186,6 @@ static inline void wbinvd(void)
 
 #ifdef CONFIG_X86_64
 
-static inline unsigned long read_cr8(void)
-{
-	return native_read_cr8();
-}
-
-static inline void write_cr8(unsigned long x)
-{
-	native_write_cr8(x);
-}
-
 static inline void load_gs_index(unsigned selector)
 {
 	native_load_gs_index(selector);
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index a7af9f53c0cb..35bb35d28733 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -34,7 +34,7 @@ struct saved_context {
 	 */
 	unsigned long kernelmode_gs_base, usermode_gs_base, fs_base;
 
-	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f5291362da1a..3a31875bd0a3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -65,10 +65,10 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid = -1U;
+unsigned int boot_cpu_physical_apicid __ro_after_init = -1U;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
-u8 boot_cpu_apic_version;
+u8 boot_cpu_apic_version __ro_after_init;
 
 /*
  * The highest APIC ID seen during enumeration.
@@ -85,13 +85,13 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
+static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
  */
-static int apic_extnmi = APIC_EXTNMI_BSP;
+static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
 
 /*
  * Map cpu index to physical APIC ID
@@ -114,7 +114,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid, BAD_APICID);
 
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
-static int enabled_via_apicbase;
+static int enabled_via_apicbase __ro_after_init;
 
 /*
  * Handle interrupt mode configuration register (IMCR).
@@ -172,23 +172,23 @@ static __init int setup_apicpmtimer(char *s)
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
-unsigned long mp_lapic_addr;
-int disable_apic;
+unsigned long mp_lapic_addr __ro_after_init;
+int disable_apic __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
 /* Local APIC timer works in C2 */
-int local_apic_timer_c2_ok;
+int local_apic_timer_c2_ok __ro_after_init;
 EXPORT_SYMBOL_GPL(local_apic_timer_c2_ok);
 
 /*
  * Debug level, exported for io_apic.c
  */
-int apic_verbosity;
+int apic_verbosity __ro_after_init;
 
-int pic_mode;
+int pic_mode __ro_after_init;
 
 /* Have we found an MP table */
-int smp_found_config;
+int smp_found_config __ro_after_init;
 
 static struct resource lapic_resource = {
 	.name = "Local APIC",
@@ -199,7 +199,7 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys;
+static unsigned long apic_phys __ro_after_init;
 
 /*
  * Get the LAPIC version
@@ -1182,25 +1182,38 @@ void clear_local_APIC(void)
 }
 
 /**
- * disable_local_APIC - clear and disable the local APIC
+ * apic_soft_disable - Clears and software disables the local APIC on hotplug
+ *
+ * Contrary to disable_local_APIC() this does not touch the enable bit in
+ * MSR_IA32_APICBASE. Clearing that bit on systems based on the 3 wire APIC
+ * bus would require a hardware reset as the APIC would lose track of bus
+ * arbitration. On systems with FSB delivery APICBASE could be disabled,
+ * but it has to be guaranteed that no interrupt is sent to the APIC while
+ * in that state and it's not clear from the SDM whether it still responds
+ * to INIT/SIPI messages. Stay on the safe side and use software disable.
  */
-void disable_local_APIC(void)
+void apic_soft_disable(void)
 {
-	unsigned int value;
-
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
-		return;
+	u32 value;
 
 	clear_local_APIC();
 
-	/*
-	 * Disable APIC (implies clearing of registers
-	 * for 82489DX!).
-	 */
+	/* Soft disable APIC (implies clearing of registers for 82489DX!). */
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_SPIV_APIC_ENABLED;
 	apic_write(APIC_SPIV, value);
+}
+
+/**
+ * disable_local_APIC - clear and disable the local APIC
+ */
+void disable_local_APIC(void)
+{
+	/* APIC hasn't been mapped yet */
+	if (!x2apic_mode && !apic_phys)
+		return;
+
+	apic_soft_disable();
 
 #ifdef CONFIG_X86_32
 	/*
@@ -1265,7 +1278,7 @@ void __init sync_Arb_IDs(void)
 			APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
 
-enum apic_intr_mode_id apic_intr_mode;
+enum apic_intr_mode_id apic_intr_mode __ro_after_init;
 
 static int __init apic_intr_mode_select(void)
 {
@@ -1453,54 +1466,72 @@ static void lapic_setup_esr(void)
 			oldvalue, value);
 }
 
-static void apic_pending_intr_clear(void)
+#define APIC_IR_REGS		APIC_ISR_NR
+#define APIC_IR_BITS		(APIC_IR_REGS * 32)
+#define APIC_IR_MAPSIZE		(APIC_IR_BITS / BITS_PER_LONG)
+
+union apic_ir {
+	unsigned long	map[APIC_IR_MAPSIZE];
+	u32		regs[APIC_IR_REGS];
+};
+
+static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
 {
-	long long max_loops = cpu_khz ? cpu_khz : 1000000;
-	unsigned long long tsc = 0, ntsc;
-	unsigned int queued;
-	unsigned long value;
-	int i, j, acked = 0;
+	int i, bit;
+
+	/* Read the IRRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		irr->regs[i] = apic_read(APIC_IRR + i * 0x10);
+
+	/* Read the ISRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		isr->regs[i] = apic_read(APIC_ISR + i * 0x10);
 
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		tsc = rdtsc();
 	/*
-	 * After a crash, we no longer service the interrupts and a pending
-	 * interrupt from previous kernel might still have ISR bit set.
-	 *
-	 * Most probably by now CPU has serviced that pending interrupt and
-	 * it might not have done the ack_APIC_irq() because it thought,
-	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
-	 * does not clear the ISR bit and cpu thinks it has already serivced
-	 * the interrupt. Hence a vector might get locked. It was noticed
-	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 * If the ISR map is not empty. ACK the APIC and run another round
+	 * to verify whether a pending IRR has been unblocked and turned
+	 * into a ISR.
 	 */
-	do {
-		queued = 0;
-		for (i = APIC_ISR_NR - 1; i >= 0; i--)
-			queued |= apic_read(APIC_IRR + i*0x10);
-
-		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
-			value = apic_read(APIC_ISR + i*0x10);
-			for_each_set_bit(j, &value, 32) {
-				ack_APIC_irq();
-				acked++;
-			}
-		}
-		if (acked > 256) {
-			pr_err("LAPIC pending interrupts after %d EOI\n", acked);
-			break;
-		}
-		if (queued) {
-			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
-				ntsc = rdtsc();
-				max_loops = (long long)cpu_khz << 10;
-				max_loops -= ntsc - tsc;
-			} else {
-				max_loops--;
-			}
-		}
-	} while (queued && max_loops > 0);
-	WARN_ON(max_loops <= 0);
+	if (!bitmap_empty(isr->map, APIC_IR_BITS)) {
+		/*
+		 * There can be multiple ISR bits set when a high priority
+		 * interrupt preempted a lower priority one. Issue an ACK
+		 * per set bit.
+		 */
+		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
+			ack_APIC_irq();
+		return true;
+	}
+
+	return !bitmap_empty(irr->map, APIC_IR_BITS);
+}
+
+/*
+ * After a crash, we no longer service the interrupts and a pending
+ * interrupt from previous kernel might still have ISR bit set.
+ *
+ * Most probably by now the CPU has serviced that pending interrupt and it
+ * might not have done the ack_APIC_irq() because it thought, interrupt
+ * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
+ * the ISR bit and cpu thinks it has already serivced the interrupt. Hence
+ * a vector might get locked. It was noticed for timer irq (vector
+ * 0x31). Issue an extra EOI to clear ISR.
+ *
+ * If there are pending IRR bits they turn into ISR bits after a higher
+ * priority ISR bit has been acked.
+ */
+static void apic_pending_intr_clear(void)
+{
+	union apic_ir irr, isr;
+	unsigned int i;
+
+	/* 512 loops are way oversized and give the APIC a chance to obey. */
+	for (i = 0; i < 512; i++) {
+		if (!apic_check_and_ack(&irr, &isr))
+			return;
+	}
+	/* Dump the IRR/ISR content if that failed */
+	pr_warn("APIC: Stale IRR: %256pb ISR: %256pb\n", irr.map, isr.map);
 }
 
 /**
@@ -1517,12 +1548,19 @@ static void setup_local_APIC(void)
 	int logical_apicid, ldr_apicid;
 #endif
 
-
 	if (disable_apic) {
 		disable_ioapic_support();
 		return;
 	}
 
+	/*
+	 * If this comes from kexec/kcrash the APIC might be enabled in
+	 * SPIV. Soft disable it before doing further initialization.
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_SPIV_APIC_ENABLED;
+	apic_write(APIC_SPIV, value);
+
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (lapic_is_integrated() && apic->disable_esr) {
@@ -1532,8 +1570,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	perf_events_lapic_init();
-
 	/*
 	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
@@ -1561,13 +1597,17 @@ static void setup_local_APIC(void)
 #endif
 
 	/*
-	 * Set Task Priority to 'accept all'. We never change this
-	 * later on.
+	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
+	 * vector in the 16-31 range could be delivered if TPR == 0, but we
+	 * would think it's an exception and terrible things will happen.  We
+	 * never change this later on.
 	 */
 	value = apic_read(APIC_TASKPRI);
 	value &= ~APIC_TPRI_MASK;
+	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
+	/* Clear eventually stale ISR/IRR bits */
 	apic_pending_intr_clear();
 
 	/*
@@ -1614,6 +1654,8 @@ static void setup_local_APIC(void)
 	value |= SPURIOUS_APIC_VECTOR;
 	apic_write(APIC_SPIV, value);
 
+	perf_events_lapic_init();
+
 	/*
 	 * Set up LVT0, LVT1:
 	 *
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index bbdca603f94a..7862b152a052 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,21 +8,14 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/acpi.h>
-#include <linux/errno.h>
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
 #include <linux/export.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
-#include <asm/ipi.h>
-#include <asm/apic.h>
-#include <asm/apic_flat_64.h>
 #include <asm/jailhouse_para.h>
+#include <asm/apic.h>
+
+#include "local.h"
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
@@ -83,35 +76,6 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	_flat_send_IPI_mask(mask, vector);
 }
 
-static void flat_send_IPI_allbutself(int vector)
-{
-	int cpu = smp_processor_id();
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || vector == NMI_VECTOR) {
-		if (!cpumask_equal(cpu_online_mask, cpumask_of(cpu))) {
-			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
-
-			if (cpu < BITS_PER_LONG)
-				__clear_bit(cpu, &mask);
-
-			_flat_send_IPI_mask(mask, vector);
-		}
-	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT,
-					    vector, apic->dest_logical);
-	}
-}
-
-static void flat_send_IPI_all(int vector)
-{
-	if (vector == NMI_VECTOR) {
-		flat_send_IPI_mask(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC,
-					    vector, apic->dest_logical);
-	}
-}
-
 static unsigned int flat_get_apic_id(unsigned long x)
 {
 	return (x >> 24) & 0xFF;
@@ -173,9 +137,9 @@ static struct apic apic_flat __ro_after_init = {
 	.send_IPI			= default_send_IPI_single,
 	.send_IPI_mask			= flat_send_IPI_mask,
 	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= flat_send_IPI_allbutself,
-	.send_IPI_all			= flat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
@@ -225,16 +189,6 @@ static void physflat_init_apic_ldr(void)
 	 */
 }
 
-static void physflat_send_IPI_allbutself(int vector)
-{
-	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
-}
-
-static void physflat_send_IPI_all(int vector)
-{
-	default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
-}
-
 static int physflat_probe(void)
 {
 	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
@@ -276,9 +230,9 @@ static struct apic apic_physflat __ro_after_init = {
 	.send_IPI			= default_send_IPI_single_phys,
 	.send_IPI_mask			= default_send_IPI_mask_sequence_phys,
 	.send_IPI_mask_allbutself	= default_send_IPI_mask_allbutself_phys,
-	.send_IPI_allbutself		= physflat_send_IPI_allbutself,
-	.send_IPI_all			= physflat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 5078b5ce63a7..98c9bb75d185 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -9,25 +9,9 @@
  * to not uglify the caller's code and allow to call (some) apic routines
  * like self-ipi, etc...
  */
-
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
 
-#include <linux/smp.h>
-#include <asm/ipi.h>
-
-#include <linux/interrupt.h>
-#include <asm/acpi.h>
-#include <asm/e820/api.h>
+#include <asm/apic.h>
 
 static void noop_init_apic_ldr(void) { }
 static void noop_send_IPI(int cpu, int vector) { }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index a5464b8b6c46..cdf45b4700f2 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -10,15 +10,15 @@
  * Send feedback to <support@numascale.com>
  *
  */
-
+#include <linux/types.h>
 #include <linux/init.h>
 
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
-#include <asm/ipi.h>
-#include <asm/apic_flat_64.h>
+
 #include <asm/pgtable.h>
-#include <asm/pci_x86.h>
+
+#include "local.h"
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index afee386ff711..9703b552f25a 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -4,18 +4,13 @@
  *
  * Drives the local APIC in "clustered mode".
  */
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/smp.h>
 
-#include <asm/apicdef.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "local.h"
 
 static unsigned bigsmp_get_apic_id(unsigned long x)
 {
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 82f9244fe61f..6ca0f91372fd 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,24 +1,113 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #include <linux/cpumask.h>
-#include <linux/interrupt.h>
-
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/kernel_stat.h>
-#include <linux/mc146818rtc.h>
-#include <linux/cache.h>
-#include <linux/cpu.h>
-
-#include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/tlbflush.h>
-#include <asm/mmu_context.h>
-#include <asm/apic.h>
-#include <asm/proto.h>
-#include <asm/ipi.h>
-
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
+#include <linux/smp.h>
+
+#include "local.h"
+
+DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
+#ifdef CONFIG_SMP
+static int apic_ipi_shorthand_off __ro_after_init;
+
+static __init int apic_ipi_shorthand(char *str)
+{
+	get_option(&str, &apic_ipi_shorthand_off);
+	return 1;
+}
+__setup("no_ipi_broadcast=", apic_ipi_shorthand);
+
+static int __init print_ipi_mode(void)
+{
+	pr_info("IPI shorthand broadcast: %s\n",
+		apic_ipi_shorthand_off ? "disabled" : "enabled");
+	return 0;
+}
+late_initcall(print_ipi_mode);
+
+void apic_smt_update(void)
+{
+	/*
+	 * Do not switch to broadcast mode if:
+	 * - Disabled on the command line
+	 * - Only a single CPU is online
+	 * - Not all present CPUs have been at least booted once
+	 *
+	 * The latter is important as the local APIC might be in some
+	 * random state and a broadcast might cause havoc. That's
+	 * especially true for NMI broadcasting.
+	 */
+	if (apic_ipi_shorthand_off || num_online_cpus() == 1 ||
+	    !cpumask_equal(cpu_present_mask, &cpus_booted_once_mask)) {
+		static_branch_disable(&apic_use_ipi_shorthand);
+	} else {
+		static_branch_enable(&apic_use_ipi_shorthand);
+	}
+}
+
+void apic_send_IPI_allbutself(unsigned int vector)
+{
+	if (num_online_cpus() < 2)
+		return;
+
+	if (static_branch_likely(&apic_use_ipi_shorthand))
+		apic->send_IPI_allbutself(vector);
+	else
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+}
+
+/*
+ * Send a 'reschedule' IPI to another CPU. It goes straight through and
+ * wastes no time serializing anything. Worst case is that we lose a
+ * reschedule ...
+ */
+void native_smp_send_reschedule(int cpu)
+{
+	if (unlikely(cpu_is_offline(cpu))) {
+		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
+		return;
+	}
+	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
+}
+
+void native_send_call_func_single_ipi(int cpu)
+{
+	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+}
+
+void native_send_call_func_ipi(const struct cpumask *mask)
+{
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
+		unsigned int cpu = smp_processor_id();
+
+		if (!cpumask_or_equal(mask, cpumask_of(cpu), cpu_online_mask))
+			goto sendmask;
+
+		if (cpumask_test_cpu(cpu, mask))
+			apic->send_IPI_all(CALL_FUNCTION_VECTOR);
+		else if (num_online_cpus() > 1)
+			apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+		return;
+	}
+
+sendmask:
+	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+}
+
+#endif /* CONFIG_SMP */
+
+static inline int __prepare_ICR2(unsigned int mask)
+{
+	return SET_APIC_DEST_FIELD(mask);
+}
+
+static inline void __xapic_wait_icr_idle(void)
+{
+	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
+		cpu_relax();
+}
+
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
 	 * Subtle. In the case of the 'never do double writes' workaround
@@ -32,12 +121,16 @@ void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int
 	/*
 	 * Wait for idle.
 	 */
-	__xapic_wait_icr_idle();
+	if (unlikely(vector == NMI_VECTOR))
+		safe_apic_wait_icr_idle();
+	else
+		__xapic_wait_icr_idle();
 
 	/*
-	 * No need to touch the target chip field
+	 * No need to touch the target chip field. Also the destination
+	 * mode is ignored when a shorthand is used.
 	 */
-	cfg = __prepare_ICR(shortcut, vector, dest);
+	cfg = __prepare_ICR(shortcut, vector, 0);
 
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
@@ -133,6 +226,21 @@ void default_send_IPI_single(int cpu, int vector)
 	apic->send_IPI_mask(cpumask_of(cpu), vector);
 }
 
+void default_send_IPI_allbutself(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+}
+
+void default_send_IPI_all(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
+void default_send_IPI_self(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+}
+
 #ifdef CONFIG_X86_32
 
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
@@ -192,28 +300,6 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
-void default_send_IPI_allbutself(int vector)
-{
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (!(num_online_cpus() > 1))
-		return;
-
-	__default_local_send_IPI_allbutself(vector);
-}
-
-void default_send_IPI_all(int vector)
-{
-	__default_local_send_IPI_all(vector);
-}
-
-void default_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, apic->dest_logical);
-}
-
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
new file mode 100644
index 000000000000..04797f05ce94
--- /dev/null
+++ b/arch/x86/kernel/apic/local.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Historical copyright notices:
+ *
+ * Copyright 2004 James Cleverdon, IBM.
+ * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
+ * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
+ * (c) 2002,2003 Andi Kleen, SuSE Labs.
+ */
+
+#include <linux/jump_label.h>
+
+#include <asm/apic.h>
+
+/* APIC flat 64 */
+void flat_init_apic_ldr(void);
+
+/* X2APIC */
+int x2apic_apic_id_valid(u32 apicid);
+int x2apic_apic_id_registered(void);
+void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
+unsigned int x2apic_get_apic_id(unsigned long id);
+u32 x2apic_set_apic_id(unsigned int id);
+int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+void x2apic_send_IPI_self(int vector);
+void __x2apic_send_IPI_shorthand(int vector, u32 which);
+
+/* IPI */
+
+DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
+static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
+					 unsigned int dest)
+{
+	unsigned int icr = shortcut | dest;
+
+	switch (vector) {
+	default:
+		icr |= APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		icr |= APIC_DM_NMI;
+		break;
+	}
+	return icr;
+}
+
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
+
+/*
+ * This is used to send an IPI with no shorthand notation (the destination is
+ * specified in bits 56 to 63 of the ICR).
+ */
+void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest);
+
+void default_send_IPI_single(int cpu, int vector);
+void default_send_IPI_single_phys(int cpu, int vector);
+void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_allbutself(int vector);
+void default_send_IPI_all(int vector);
+void default_send_IPI_self(int vector);
+
+#ifdef CONFIG_X86_32
+void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
+#endif
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 1492799b8f43..0ac9fd667c99 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -6,51 +6,14 @@
  *
  * Generic x86 APIC driver probe layer.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/init.h>
 #include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
-
 #include <linux/smp.h>
-#include <asm/ipi.h>
 
-#include <linux/interrupt.h>
+#include <asm/apic.h>
 #include <asm/acpi.h>
-#include <asm/e820/api.h>
 
-#ifdef CONFIG_HOTPLUG_CPU
-#define DEFAULT_SEND_IPI	(1)
-#else
-#define DEFAULT_SEND_IPI	(0)
-#endif
-
-int no_broadcast = DEFAULT_SEND_IPI;
-
-static __init int no_ipi_broadcast(char *str)
-{
-	get_option(&str, &no_broadcast);
-	pr_info("Using %s mode\n",
-		no_broadcast ? "No IPI Broadcast" : "IPI Broadcast");
-	return 1;
-}
-__setup("no_ipi_broadcast=", no_ipi_broadcast);
-
-static int __init print_ipi_mode(void)
-{
-	pr_info("Using IPI %s mode\n",
-		no_broadcast ? "No-Shortcut" : "Shortcut");
-	return 0;
-}
-late_initcall(print_ipi_mode);
+#include "local.h"
 
 static int default_x86_32_early_logical_apicid(int cpu)
 {
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index e6560a02eb46..29f0e0984557 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -8,19 +8,9 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
-#include <linux/dmar.h>
-
-#include <asm/smp.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
-#include <asm/setup.h>
+
+#include "local.h"
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
@@ -46,13 +36,6 @@ void __init default_setup_apic_routing(void)
 		x86_platform.apic_post_init();
 }
 
-/* Same for both flat and physical. */
-
-void apic_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
-}
-
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	struct apic **drv;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fdacb864c3dd..2c5676b0a6e7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -398,6 +398,17 @@ static int activate_reserved(struct irq_data *irqd)
 		if (!irqd_can_reserve(irqd))
 			apicd->can_reserve = false;
 	}
+
+	/*
+	 * Check to ensure that the effective affinity mask is a subset
+	 * the user supplied affinity mask, and warn the user if it is not
+	 */
+	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
+			    irq_data_get_affinity_mask(irqd))) {
+		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
+			irqd->irq);
+	}
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/apic/x2apic.h b/arch/x86/kernel/apic/x2apic.h
deleted file mode 100644
index a49b3604027f..000000000000
--- a/arch/x86/kernel/apic/x2apic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* Common bits for X2APIC cluster/physical modes. */
-
-int x2apic_apic_id_valid(u32 apicid);
-int x2apic_apic_id_registered(void);
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
-unsigned int x2apic_get_apic_id(unsigned long id);
-u32 x2apic_set_apic_id(unsigned int id);
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
-void x2apic_send_IPI_self(int vector);
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 609e499387a1..45e92cba92f5 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
-#include <linux/irq.h>
-#include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/apic.h>
 
-#include <asm/smp.h>
-#include "x2apic.h"
+#include "local.h"
 
 struct cluster_mask {
 	unsigned int	clusterid;
@@ -84,12 +82,12 @@ x2apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index b5cf9e7b3830..bc9693841353 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -1,14 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
-#include <asm/ipi.h>
-#include "x2apic.h"
+#include "local.h"
 
 int x2apic_phys;
 
@@ -80,12 +75,12 @@ static void
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static void init_x2apic_ldr(void)
@@ -117,6 +112,14 @@ void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
 	native_x2apic_icr_write(cfg, apicid);
 }
 
+void __x2apic_send_IPI_shorthand(int vector, u32 which)
+{
+	unsigned long cfg = __prepare_ICR(which, vector, 0);
+
+	x2apic_wrmsr_fence();
+	native_x2apic_icr_write(cfg, 0);
+}
+
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1e225528f0d7..e6230af19864 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -7,42 +7,22 @@
  *
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
+#include <linux/crash_dump.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/hardirq.h>
 #include <linux/proc_fs.h>
-#include <linux/threads.h>
-#include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/cpu.h>
-#include <linux/init.h>
-#include <linux/io.h>
 #include <linux/pci.h>
-#include <linux/kdebug.h>
-#include <linux/delay.h>
-#include <linux/crash_dump.h>
-#include <linux/reboot.h>
-#include <linux/memory.h>
-#include <linux/numa.h>
 
+#include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
-#include <asm/current.h>
-#include <asm/pgtable.h>
 #include <asm/uv/bios.h>
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
-#include <asm/e820/api.h>
-#include <asm/ipi.h>
-#include <asm/smp.h>
-#include <asm/x86_init.h>
-#include <asm/nmi.h>
 
-DEFINE_PER_CPU(int, x2apic_extra_bits);
+static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
 static bool			uv_hubless_system;
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index d3d075226c0a..8b54d8e3a561 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -62,7 +62,6 @@ int main(void)
 	ENTRY(cr2);
 	ENTRY(cr3);
 	ENTRY(cr4);
-	ENTRY(cr8);
 	ENTRY(gdt_desc);
 	BLANK();
 #undef ENTRY
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 66ca906aa790..6d9636c2ca51 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -700,7 +700,7 @@ static void update_mds_branch_idle(void)
 
 #define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
 
-void arch_smt_update(void)
+void cpu_bugs_smt_update(void)
 {
 	/* Enhanced IBRS implies STIBP. No update required. */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 11472178e17f..e0489d2860d3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1945,3 +1945,14 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
+
+/*
+ * Invoked from core CPU hotplug code after hotplug operations
+ */
+void arch_smt_update(void)
+{
+	/* Handle the speculative execution misfeatures */
+	cpu_bugs_smt_update();
+	/* Check whether IPI broadcasting can be enabled */
+	apic_smt_update();
+}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 23297ea64f5f..c44fe7d8d9a4 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(APIC_DM_NMI);
+	apic_send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4df7705022b9..e676a9916c49 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -512,6 +512,9 @@ NOKPROBE_SYMBOL(is_debug_stack);
 dotraplinkage notrace void
 do_nmi(struct pt_regs *regs, long error_code)
 {
+	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
+		return;
+
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
 		this_cpu_write(nmi_state, NMI_LATCHED);
 		return;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 0aa6256eedd8..59d3d2763a9e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -311,10 +311,6 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-#ifdef CONFIG_X86_64
-	.cpu.read_cr8		= native_read_cr8,
-	.cpu.write_cr8		= native_write_cr8,
-#endif
 	.cpu.wbinvd		= native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 09d6bded3c1e..0cc7c0b106bb 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -828,11 +828,6 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	return NMI_HANDLED;
 }
 
-static void smp_send_nmi_allbutself(void)
-{
-	apic->send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * Halt all other CPUs, calling the specified function on each of them
  *
@@ -861,7 +856,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 */
 	wmb();
 
-	smp_send_nmi_allbutself();
+	apic_send_IPI_allbutself(NMI_VECTOR);
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f97e75c..b8d4e9c3c070 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -115,46 +115,6 @@
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
-/*
- * this function sends a 'reschedule' IPI to another CPU.
- * it goes straight through and wastes no time serializing
- * anything. Worst case is that we lose a reschedule ...
- */
-static void native_smp_send_reschedule(int cpu)
-{
-	if (unlikely(cpu_is_offline(cpu))) {
-		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
-		return;
-	}
-	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
-}
-
-void native_send_call_func_single_ipi(int cpu)
-{
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
-}
-
-void native_send_call_func_ipi(const struct cpumask *mask)
-{
-	cpumask_var_t allbutself;
-
-	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-		return;
-	}
-
-	cpumask_copy(allbutself, cpu_online_mask);
-	__cpumask_clear_cpu(smp_processor_id(), allbutself);
-
-	if (cpumask_equal(mask, allbutself) &&
-	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
-		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
-	else
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-
-	free_cpumask_var(allbutself);
-}
-
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	/* We are registered on stopping cpu too, avoid spurious NMI */
@@ -179,6 +139,12 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 	irq_exit();
 }
 
+static int register_stop_handler(void)
+{
+	return register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
+				    NMI_FLAG_FIRST, "smp_stop");
+}
+
 static void native_stop_other_cpus(int wait)
 {
 	unsigned long flags;
@@ -209,42 +175,44 @@ static void native_stop_other_cpus(int wait)
 		/* sync above data before sending IRQ */
 		wmb();
 
-		apic->send_IPI_allbutself(REBOOT_VECTOR);
+		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
-		 * Don't wait longer than a second if the caller
-		 * didn't ask us to wait.
+		 * Don't wait longer than a second for IPI completion. The
+		 * wait request is not checked here because that would
+		 * prevent an NMI shutdown attempt in case that not all
+		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (num_online_cpus() > 1 && timeout--)
 			udelay(1);
 	}
-	
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if ((num_online_cpus() > 1) && (!smp_no_nmi_ipi))  {
-		if (register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
-					 NMI_FLAG_FIRST, "smp_stop"))
-			/* Note: we ignore failures here */
-			/* Hope the REBOOT_IRQ is good enough */
-			goto finish;
 
-		/* sync above data before sending IRQ */
-		wmb();
-
-		pr_emerg("Shutting down cpus with NMI\n");
+	/* if the REBOOT_VECTOR didn't work, try with the NMI */
+	if (num_online_cpus() > 1) {
+		/*
+		 * If NMI IPI is enabled, try to register the stop handler
+		 * and send the IPI. In any case try to wait for the other
+		 * CPUs to stop.
+		 */
+		if (!smp_no_nmi_ipi && !register_stop_handler()) {
+			/* Sync above data before sending IRQ */
+			wmb();
 
-		apic->send_IPI_allbutself(NMI_VECTOR);
+			pr_emerg("Shutting down cpus with NMI\n");
 
+			apic_send_IPI_allbutself(NMI_VECTOR);
+		}
 		/*
-		 * Don't wait longer than a 10 ms if the caller
-		 * didn't ask us to wait.
+		 * Don't wait longer than 10 ms if the caller didn't
+		 * reqeust it. If wait is true, the machine hangs here if
+		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
 		while (num_online_cpus() > 1 && (wait || timeout--))
 			udelay(1);
 	}
 
-finish:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fdbd47ceb84d..c19f8e21b748 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1596,7 +1596,12 @@ int native_cpu_disable(void)
 	if (ret)
 		return ret;
 
-	clear_local_APIC();
+	/*
+	 * Disable the local APIC. Otherwise IPI broadcasts will reach
+	 * it. It still responds normally to INIT, NMI, SMI, and SIPI
+	 * messages.
+	 */
+	apic_soft_disable();
 	cpu_disable_common();
 
 	return 0;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 24b079e94bc2..1c58d8982728 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -122,9 +122,6 @@ static void __save_processor_state(struct saved_context *ctxt)
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = __read_cr3();
 	ctxt->cr4 = __read_cr4();
-#ifdef CONFIG_X86_64
-	ctxt->cr8 = read_cr8();
-#endif
 	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
 	msr_save_context(ctxt);
@@ -207,7 +204,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 #else
 /* CONFIG X86_64 */
 	wrmsrl(MSR_EFER, ctxt->efer);
-	write_cr8(ctxt->cr8);
 	__write_cr4(ctxt->cr4);
 #endif
 	write_cr3(ctxt->cr3);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7ceb32821093..58f79ab32358 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -877,16 +877,6 @@ static void xen_write_cr4(unsigned long cr4)
 
 	native_write_cr4(cr4);
 }
-#ifdef CONFIG_X86_64
-static inline unsigned long xen_read_cr8(void)
-{
-	return 0;
-}
-static inline void xen_write_cr8(unsigned long val)
-{
-	BUG_ON(val);
-}
-#endif
 
 static u64 xen_read_msr_safe(unsigned int msr, int *err)
 {
@@ -1023,11 +1013,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.write_cr4 = xen_write_cr4,
 
-#ifdef CONFIG_X86_64
-	.read_cr8 = xen_read_cr8,
-	.write_cr8 = xen_write_cr8,
-#endif
-
 	.wbinvd = native_wbinvd,
 
 	.read_msr = xen_read_msr,
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index f58e97446abc..90528f12bdfa 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -120,6 +120,10 @@ extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
 extern int __bitmap_equal(const unsigned long *bitmap1,
 			  const unsigned long *bitmap2, unsigned int nbits);
+extern bool __pure __bitmap_or_equal(const unsigned long *src1,
+				     const unsigned long *src2,
+				     const unsigned long *src3,
+				     unsigned int nbits);
 extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits);
 extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
@@ -321,6 +325,25 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+/**
+ * bitmap_or_equal - Check whether the or of two bitnaps is equal to a third
+ * @src1:	Pointer to bitmap 1
+ * @src2:	Pointer to bitmap 2 will be or'ed with bitmap 1
+ * @src3:	Pointer to bitmap 3. Compare to the result of *@src1 | *@src2
+ *
+ * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
+ */
+static inline bool bitmap_or_equal(const unsigned long *src1,
+				   const unsigned long *src2,
+				   const unsigned long *src3,
+				   unsigned int nbits)
+{
+	if (!small_const_nbits(nbits))
+		return __bitmap_or_equal(src1, src2, src3, nbits);
+
+	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
+}
+
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..0c7db5efe66c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -115,6 +115,8 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+extern cpumask_t cpus_booted_once_mask;
+
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 {
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
@@ -473,6 +475,20 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
 						 nr_cpumask_bits);
 }
 
+/**
+ * cpumask_or_equal - *src1p | *src2p == *src3p
+ * @src1p: the first input
+ * @src2p: the second input
+ * @src3p: the third input
+ */
+static inline bool cpumask_or_equal(const struct cpumask *src1p,
+				    const struct cpumask *src2p,
+				    const struct cpumask *src3p)
+{
+	return bitmap_or_equal(cpumask_bits(src1p), cpumask_bits(src2p),
+			       cpumask_bits(src3p), nr_cpumask_bits);
+}
+
 /**
  * cpumask_intersects - (*src1p & *src2p) != 0
  * @src1p: the first input
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e84c0873559e..05778e32674a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -62,7 +62,6 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
-	bool			booted_once;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -76,6 +75,10 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
+#ifdef CONFIG_SMP
+cpumask_t cpus_booted_once_mask;
+#endif
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -433,7 +436,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
 	 * core will shutdown the machine.
 	 */
-	return !per_cpu(cpuhp_state, cpu).booted_once;
+	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
@@ -1066,7 +1069,7 @@ void notify_cpu_starting(unsigned int cpu)
 	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
-	st->booted_once = true;
+	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
@@ -2334,7 +2337,7 @@ void __init boot_cpu_init(void)
 void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
-	this_cpu_write(cpuhp_state.booted_once, true);
+	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
diff --git a/lib/bitmap.c b/lib/bitmap.c
index bbe2589e8497..f9e834841e94 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -59,6 +59,26 @@ int __bitmap_equal(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
+bool __bitmap_or_equal(const unsigned long *bitmap1,
+		       const unsigned long *bitmap2,
+		       const unsigned long *bitmap3,
+		       unsigned int bits)
+{
+	unsigned int k, lim = bits / BITS_PER_LONG;
+	unsigned long tmp;
+
+	for (k = 0; k < lim; ++k) {
+		if ((bitmap1[k] | bitmap2[k]) != bitmap3[k])
+			return false;
+	}
+
+	if (!(bits % BITS_PER_LONG))
+		return true;
+
+	tmp = (bitmap1[k] | bitmap2[k]) ^ bitmap3[k];
+	return (tmp & BITMAP_LAST_WORD_MASK(bits)) == 0;
+}
+
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
 {
 	unsigned int k, lim = BITS_TO_LONGS(bits);


