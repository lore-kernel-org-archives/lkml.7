Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC652071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK0ITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0ITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXq-0002Pi-3t; Wed, 27 Nov 2019 09:19:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF4C11C004F;
        Wed, 27 Nov 2019 09:19:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:29 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/doublefault/32: Move #DF stack and TSS to
 cpu_entry_area
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276970.21853.12938909733558203382.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dc4e0021b00b5a4ecba56fae509217776592b0aa
Gitweb:        https://git.kernel.org/tip/dc4e0021b00b5a4ecba56fae509217776592b0aa
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 26 Nov 2019 18:27:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00

x86/doublefault/32: Move #DF stack and TSS to cpu_entry_area

There are three problems with the current layout of the doublefault
stack and TSS.  First, the TSS is only cacheline-aligned, which is
not enough -- if the hardware portion of the TSS (struct x86_hw_tss)
crosses a page boundary, horrible things happen [0].  Second, the
stack and TSS are global, so simultaneous double faults on different
CPUs will cause massive corruption.  Third, the whole mechanism
won't work if user CR3 is loaded, resulting in a triple fault [1].

Let the doublefault stack and TSS share a page (which prevents the
TSS from spanning a page boundary), make it percpu, and move it into
cpu_entry_area.  Teach the stack dump code about the doublefault
stack.

[0] Real hardware will read past the end of the page onto the next
    *physical* page if a task switch happens.  Virtual machines may
    have any number of bugs, and I would consider it reasonable for
    a VM to summarily kill the guest if it tries to task-switch to
    a page-spanning TSS.

[1] Real hardware triple faults.  At least some VMs seem to hang.
    I'm not sure what's going on.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpu_entry_area.h   | 12 +++++-
 arch/x86/include/asm/doublefault.h      | 13 +++++-
 arch/x86/include/asm/pgtable_32_types.h |  7 +--
 arch/x86/include/asm/processor.h        |  1 +-
 arch/x86/kernel/cpu/common.c            | 12 +-----
 arch/x86/kernel/doublefault_32.c        | 58 ++++++++++++++++--------
 arch/x86/kernel/dumpstack_32.c          | 30 ++++++++++++-
 arch/x86/mm/cpu_entry_area.c            | 14 +++++-
 8 files changed, 113 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/include/asm/doublefault.h

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index ea866c7..8047340 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -65,6 +65,13 @@ enum exception_stack_ordering {
 
 #endif
 
+#ifdef CONFIG_X86_32
+struct doublefault_stack {
+	unsigned long stack[(PAGE_SIZE - sizeof(struct x86_hw_tss)) / sizeof(unsigned long)];
+	struct x86_hw_tss tss;
+} __aligned(PAGE_SIZE);
+#endif
+
 /*
  * cpu_entry_area is a percpu region that contains things needed by the CPU
  * and early entry/exit code.  Real types aren't used for all fields here
@@ -86,6 +93,11 @@ struct cpu_entry_area {
 #endif
 	struct entry_stack_page entry_stack_page;
 
+#ifdef CONFIG_X86_32
+	char guard_doublefault_stack[PAGE_SIZE];
+	struct doublefault_stack doublefault_stack;
+#endif
+
 	/*
 	 * On x86_64, the TSS is mapped RO.  On x86_32, it's mapped RW because
 	 * we need task switches to work, and task switches write to the TSS.
diff --git a/arch/x86/include/asm/doublefault.h b/arch/x86/include/asm/doublefault.h
new file mode 100644
index 0000000..af9a14a
--- /dev/null
+++ b/arch/x86/include/asm/doublefault.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_DOUBLEFAULT_H
+#define _ASM_X86_DOUBLEFAULT_H
+
+#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+extern void doublefault_init_cpu_tss(void);
+#else
+static inline void doublefault_init_cpu_tss(void)
+{
+}
+#endif
+
+#endif /* _ASM_X86_DOUBLEFAULT_H */
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 19f5807..0416d42 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -41,10 +41,11 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 #endif
 
 /*
- * Define this here and validate with BUILD_BUG_ON() in pgtable_32.c
- * to avoid include recursion hell
+ * This is an upper bound on sizeof(struct cpu_entry_area) / PAGE_SIZE.
+ * Define this here and validate with BUILD_BUG_ON() in cpu_entry_area.c
+ * to avoid include recursion hell.
  */
-#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 41)
+#define CPU_ENTRY_AREA_PAGES	(NR_CPUS * 43)
 
 /* The +1 is for the readonly IDT page: */
 #define CPU_ENTRY_AREA_BASE	\
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f6c6300..0340aad 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -166,7 +166,6 @@ enum cpuid_regs_idx {
 extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
 
-extern struct x86_hw_tss	doublefault_tss;
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index baa2fed..2e4d902 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -24,6 +24,7 @@
 #include <asm/stackprotector.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
+#include <asm/doublefault.h>
 #include <asm/archrandom.h>
 #include <asm/hypervisor.h>
 #include <asm/processor.h>
@@ -1814,8 +1815,6 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
 }
 
-static inline void gdt_setup_doublefault_tss(int cpu) { }
-
 #else /* CONFIG_X86_64 */
 
 static inline void setup_getcpu(int cpu) { }
@@ -1827,13 +1826,6 @@ static inline void ucode_cpu_init(int cpu)
 
 static inline void tss_setup_ist(struct tss_struct *tss) { }
 
-static inline void gdt_setup_doublefault_tss(int cpu)
-{
-#ifdef CONFIG_DOUBLEFAULT
-	/* Set up the doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-#endif
-}
 #endif /* !CONFIG_X86_64 */
 
 static inline void tss_setup_io_bitmap(struct tss_struct *tss)
@@ -1923,7 +1915,7 @@ void cpu_init(void)
 	clear_all_debug_regs();
 	dbg_restore_debug_regs();
 
-	gdt_setup_doublefault_tss(cpu);
+	doublefault_init_cpu_tss();
 
 	fpu__init_cpu();
 
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 61c707c..4eecfe4 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -10,10 +10,6 @@
 #include <asm/processor.h>
 #include <asm/desc.h>
 
-#define DOUBLEFAULT_STACKSIZE (1024)
-static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
-#define STACK_START (unsigned long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
-
 #define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET + MAXMEM)
 
 static void doublefault_fn(void)
@@ -21,6 +17,8 @@ static void doublefault_fn(void)
 	struct desc_ptr gdt_desc = {0, 0};
 	unsigned long gdt, tss;
 
+	BUILD_BUG_ON(sizeof(struct doublefault_stack) != PAGE_SIZE);
+
 	native_store_gdt(&gdt_desc);
 	gdt = gdt_desc.address;
 
@@ -48,24 +46,46 @@ static void doublefault_fn(void)
 		cpu_relax();
 }
 
-struct x86_hw_tss doublefault_tss __cacheline_aligned = {
-	.sp0		= STACK_START,
-	.ss0		= __KERNEL_DS,
-	.ldt		= 0,
+DEFINE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack) = {
+	.tss = {
+                /*
+                 * No sp0 or ss0 -- we never run CPL != 0 with this TSS
+                 * active.  sp is filled in later.
+                 */
+		.ldt		= 0,
 	.io_bitmap_base	= IO_BITMAP_OFFSET_INVALID,
 
-	.ip		= (unsigned long) doublefault_fn,
-	/* 0x2 bit is always set */
-	.flags		= X86_EFLAGS_SF | 0x2,
-	.sp		= STACK_START,
-	.es		= __USER_DS,
-	.cs		= __KERNEL_CS,
-	.ss		= __KERNEL_DS,
-	.ds		= __USER_DS,
-	.fs		= __KERNEL_PERCPU,
+		.ip		= (unsigned long) doublefault_fn,
+		/* 0x2 bit is always set */
+		.flags		= X86_EFLAGS_SF | 0x2,
+		.es		= __USER_DS,
+		.cs		= __KERNEL_CS,
+		.ss		= __KERNEL_DS,
+		.ds		= __USER_DS,
+		.fs		= __KERNEL_PERCPU,
 #ifndef CONFIG_X86_32_LAZY_GS
-	.gs		= __KERNEL_STACK_CANARY,
+		.gs		= __KERNEL_STACK_CANARY,
 #endif
 
-	.__cr3		= __pa_nodebug(swapper_pg_dir),
+		.__cr3		= __pa_nodebug(swapper_pg_dir),
+	},
 };
+
+void doublefault_init_cpu_tss(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
+
+	/*
+	 * The linker isn't smart enough to initialize percpu variables that
+	 * point to other places in percpu space.
+	 */
+        this_cpu_write(doublefault_stack.tss.sp,
+                       (unsigned long)&cea->doublefault_stack.stack +
+                       sizeof(doublefault_stack.stack));
+
+	/* Set up doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS,
+		       &get_cpu_entry_area(cpu)->doublefault_stack.tss);
+
+}
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 64a59d7..8e3a8fe 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -29,6 +29,9 @@ const char *stack_type_name(enum stack_type type)
 	if (type == STACK_TYPE_ENTRY)
 		return "ENTRY_TRAMPOLINE";
 
+	if (type == STACK_TYPE_EXCEPTION)
+		return "#DF";
+
 	return NULL;
 }
 
@@ -82,6 +85,30 @@ static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 	return true;
 }
 
+static bool in_doublefault_stack(unsigned long *stack, struct stack_info *info)
+{
+#ifdef CONFIG_DOUBLEFAULT
+	struct cpu_entry_area *cea = get_cpu_entry_area(raw_smp_processor_id());
+	struct doublefault_stack *ss = &cea->doublefault_stack;
+
+	void *begin = ss->stack;
+	void *end = begin + sizeof(ss->stack);
+
+	if ((void *)stack < begin || (void *)stack >= end)
+		return false;
+
+	info->type	= STACK_TYPE_EXCEPTION;
+	info->begin	= begin;
+	info->end	= end;
+	info->next_sp	= (unsigned long *)this_cpu_read(cpu_tss_rw.x86_tss.sp);
+
+	return true;
+#else
+	return false;
+#endif
+}
+
+
 int get_stack_info(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info, unsigned long *visit_mask)
 {
@@ -105,6 +132,9 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	if (in_softirq_stack(stack, info))
 		goto recursion_check;
 
+	if (in_doublefault_stack(stack, info))
+		goto recursion_check;
+
 	goto unknown;
 
 recursion_check:
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 82ead8e..56f9189 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -17,6 +17,10 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 #endif
 
+#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
+#endif
+
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
 {
 	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cpu * CPU_ENTRY_AREA_SIZE;
@@ -108,7 +112,15 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	cea_map_stack(MCE);
 }
 #else
-static inline void percpu_setup_exception_stacks(unsigned int cpu) {}
+static inline void percpu_setup_exception_stacks(unsigned int cpu)
+{
+#ifdef CONFIG_DOUBLEFAULT
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
+
+	cea_map_percpu_pages(&cea->doublefault_stack,
+			     &per_cpu(doublefault_stack, cpu), 1, PAGE_KERNEL);
+#endif
+}
 #endif
 
 /* Setup the fixmap mappings only once per-processor */
