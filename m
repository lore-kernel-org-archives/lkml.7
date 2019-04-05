Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08ADC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DB218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfDEPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48969 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731667AbfDEPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQV4-0005vp-4y; Fri, 05 Apr 2019 17:11:26 +0200
Message-Id: <20190405150930.878379117@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 27/29] x86/irq/64: Split the IRQ stack into its own pages
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Currently the IRQ stack is hardcoded as the first page of the percpu area,
and the stack canary lives on the IRQ stack.  The former gets in the way of
adding an IRQ stack guard page, and the latter is a potential weakness in
the stack canary mechanism.

Split the IRQ stack into its own private percpu pages.

[ tglx: Make 64 and 32 bit share struct irq_stack ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S             |    4 +--
 arch/x86/include/asm/processor.h      |   35 ++++++++++++++++------------------
 arch/x86/include/asm/stackprotector.h |    6 ++---
 arch/x86/kernel/asm-offsets_64.c      |    2 -
 arch/x86/kernel/cpu/common.c          |   10 +++------
 arch/x86/kernel/head_64.S             |    2 -
 arch/x86/kernel/irq_64.c              |    2 +
 arch/x86/kernel/setup_percpu.c        |    5 +---
 arch/x86/kernel/vmlinux.lds.S         |    7 +++---
 arch/x86/tools/relocs.c               |    2 -
 arch/x86/xen/xen-head.S               |   10 ++++-----
 11 files changed, 42 insertions(+), 43 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -298,7 +298,7 @@ ENTRY(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(irq_stack_union)+stack_canary_offset
+	movq	%rbx, PER_CPU_VAR(fixed_percpu_data) + stack_canary_offset
 #endif
 
 #ifdef CONFIG_RETPOLINE
@@ -430,7 +430,7 @@ END(irq_entries_start)
 	 * it before we actually move ourselves to the IRQ stack.
 	 */
 
-	movq	\old_rsp, PER_CPU_VAR(irq_stack_union + IRQ_STACK_SIZE - 8)
+	movq	\old_rsp, PER_CPU_VAR(irq_stack_backing_store + IRQ_STACK_SIZE - 8)
 	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
 
 #ifdef CONFIG_DEBUG_ENTRY
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -367,6 +367,13 @@ DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_
 #define __KERNEL_TSS_LIMIT	\
 	(IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1)
 
+/* Per CPU interrupt stacks */
+struct irq_stack {
+	char		stack[IRQ_STACK_SIZE];
+} __aligned(IRQ_STACK_SIZE);
+
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+
 #ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
 #else
@@ -375,28 +382,27 @@ DECLARE_PER_CPU(unsigned long, cpu_curre
 #endif
 
 #ifdef CONFIG_X86_64
-union irq_stack_union {
-	char irq_stack[IRQ_STACK_SIZE];
+struct fixed_percpu_data {
 	/*
 	 * GCC hardcodes the stack canary as %gs:40.  Since the
 	 * irq_stack is the object at %gs:0, we reserve the bottom
 	 * 48 bytes of the irq stack for the canary.
 	 */
-	struct {
-		char gs_base[40];
-		unsigned long stack_canary;
-	};
+	char		gs_base[40];
+	unsigned long	stack_canary;
 };
 
-DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_union);
+DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
+DECLARE_INIT_PER_CPU(fixed_percpu_data);
+
+DECLARE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store);
+DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(irq_stack_union.gs_base, cpu);
+	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(char *, hardirq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
 
@@ -418,14 +424,7 @@ struct stack_canary {
 };
 DECLARE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
-/*
- * per-CPU IRQ handling stacks
- */
-struct irq_stack {
-	char			stack[IRQ_STACK_SIZE];
-} __aligned(IRQ_STACK_SIZE);
-
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+/* Per CPU softirq stack pointer */
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* X86_64 */
 
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -13,7 +13,7 @@
  * On x86_64, %gs is shared by percpu area and stack canary.  All
  * percpu symbols are zero based and %gs points to the base of percpu
  * area.  The first occupant of the percpu area is always
- * irq_stack_union which contains stack_canary at offset 40.  Userland
+ * fixed_percpu_data which contains stack_canary at offset 40.  Userland
  * %gs is always saved and restored on kernel entry and exit using
  * swapgs, so stack protector doesn't add any complexity there.
  *
@@ -64,7 +64,7 @@ static __always_inline void boot_init_st
 	u64 tsc;
 
 #ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(union irq_stack_union, stack_canary) != 40);
+	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
 #endif
 	/*
 	 * We both use the random pool and the current TSC as a source
@@ -79,7 +79,7 @@ static __always_inline void boot_init_st
 
 	current->stack_canary = canary;
 #ifdef CONFIG_X86_64
-	this_cpu_write(irq_stack_union.stack_canary, canary);
+	this_cpu_write(fixed_percpu_data.stack_canary, canary);
 #else
 	this_cpu_write(stack_canary.canary, canary);
 #endif
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -73,7 +73,7 @@ int main(void)
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
-	DEFINE(stack_canary_offset, offsetof(union irq_stack_union, stack_canary));
+	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
 #endif
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1498,9 +1498,9 @@ static __init int setup_clearcpuid(char
 __setup("clearcpuid=", setup_clearcpuid);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(union irq_stack_union,
-		     irq_stack_union) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(irq_stack_union);
+DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
+		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
 
 /*
  * The following percpu variables are hot.  Align current_task to
@@ -1510,9 +1510,7 @@ DEFINE_PER_CPU(struct task_struct *, cur
 	&init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 
-DEFINE_PER_CPU(char *, hardirq_stack_ptr) =
-	init_per_cpu_var(irq_stack_union.irq_stack) + IRQ_STACK_SIZE;
-
+DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -265,7 +265,7 @@ ENDPROC(start_cpu0)
 	GLOBAL(initial_code)
 	.quad	x86_64_start_kernel
 	GLOBAL(initial_gs)
-	.quad	INIT_PER_CPU_VAR(irq_stack_union)
+	.quad	INIT_PER_CPU_VAR(fixed_percpu_data)
 	GLOBAL(initial_stack)
 	/*
 	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -23,6 +23,8 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
+DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
+
 int sysctl_panic_on_stackoverflow;
 
 /*
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -245,9 +245,8 @@ void __init setup_per_cpu_areas(void)
 			early_per_cpu_map(x86_cpu_to_logical_apicid, cpu);
 #endif
 #ifdef CONFIG_X86_64
-		per_cpu(hardirq_stack_ptr, cpu) =
-			per_cpu(irq_stack_union.irq_stack, cpu) +
-			IRQ_STACK_SIZE;
+		per_cpu(hardirq_stack_ptr, cpu) = (struct irq_stack *)
+			per_cpu_ptr(&irq_stack_backing_store, cpu) + 1;
 #endif
 #ifdef CONFIG_NUMA
 		per_cpu(x86_cpu_to_node_map, cpu) =
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -403,7 +403,8 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_union);
+INIT_PER_CPU(fixed_percpu_data);
+INIT_PER_CPU(irq_stack_backing_store);
 
 /*
  * Build-time check on the image size:
@@ -412,8 +413,8 @@ INIT_PER_CPU(irq_stack_union);
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
 #ifdef CONFIG_SMP
-. = ASSERT((irq_stack_union == 0),
-           "irq_stack_union is not at start of per-cpu area");
+. = ASSERT((fixed_percpu_data == 0),
+           "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
 #endif /* CONFIG_X86_32 */
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -738,7 +738,7 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__irq_stack_union
+ *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -40,13 +40,13 @@ ENTRY(startup_xen)
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to the bottom of the irqstack
-	 * union.  If the stack protector canary is enabled, it is
-	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
-	 * init data section till per cpu areas are set up.
+	 * The base of %gs always points to fixed_percpu_data.  If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
+	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
 	cdq
 	wrmsr
 #endif


