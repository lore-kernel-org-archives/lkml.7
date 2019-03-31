Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A53BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5F620870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfCaWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAien-0004qU-SK; Mon, 01 Apr 2019 00:10:26 +0200
Message-Id: <20190331215135.133741719@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 04/14] x86/exceptions: Make IST index zero based
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines for the exception stack (IST) array in the TSS are using the
SDM convention IST1 - IST7. That causes all sorts of code to subtract 1 for
array indices related to IST. That's confusing at best and does not provide
any value.

Make the indices zero based and fixup the usage sites. The only code which
needs to adjust the 0 based index is the interrupt descriptor setup which
needs to add 1 now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/x86/kernel-stacks      |    8 ++++----
 arch/x86/entry/entry_64.S            |    4 ++--
 arch/x86/include/asm/page_64_types.h |   13 ++++++++-----
 arch/x86/kernel/cpu/common.c         |    4 ++--
 arch/x86/kernel/dumpstack_64.c       |   14 +++++++-------
 arch/x86/kernel/idt.c                |   15 +++++++++------
 6 files changed, 32 insertions(+), 26 deletions(-)

--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks
@@ -59,7 +59,7 @@ If that assumption is ever broken then t
 
 The currently assigned IST stacks are :-
 
-* DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* DOUBLEFAULT_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for interrupt 8 - Double Fault Exception (#DF).
 
@@ -68,7 +68,7 @@ The currently assigned IST stacks are :-
   Using a separate stack allows the kernel to recover from it well enough
   in many cases to still output an oops.
 
-* NMI_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* NMI_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for non-maskable interrupts (NMI).
 
@@ -76,7 +76,7 @@ The currently assigned IST stacks are :-
   middle of switching stacks.  Using IST for NMI events avoids making
   assumptions about the previous state of the kernel stack.
 
-* DEBUG_STACK.  DEBUG_STKSZ
+* DEBUG_IST.  DEBUG_STKSZ
 
   Used for hardware debug interrupts (interrupt 1) and for software
   debug interrupts (INT3).
@@ -86,7 +86,7 @@ The currently assigned IST stacks are :-
   avoids making assumptions about the previous state of the kernel
   stack.
 
-* MCE_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* MCE_IST.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for interrupt 18 - Machine Check Exception (#MC).
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -841,7 +841,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 /*
  * Exception entry points.
  */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
+#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
 /**
  * idtentry - Generate an IDT entry stub
@@ -1129,7 +1129,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_IST
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -25,11 +25,14 @@
 #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
 #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)
 
-#define DOUBLEFAULT_STACK 1
-#define NMI_STACK 2
-#define DEBUG_STACK 3
-#define MCE_STACK 4
-#define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
+/*
+ * The index for the tss.ist[] array. The hardware limit is 7 entries.
+ */
+#define	DOUBLEFAULT_IST		0
+#define	NMI_IST			1
+#define	DEBUG_IST		2
+#define	MCE_IST			3
+#define	N_EXCEPTION_STACKS	4
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -516,7 +516,7 @@ DEFINE_PER_CPU(struct cpu_entry_area *,
  */
 static const unsigned int exception_stack_sizes[N_EXCEPTION_STACKS] = {
 	  [0 ... N_EXCEPTION_STACKS - 1]	= EXCEPTION_STKSZ,
-	  [DEBUG_STACK - 1]			= DEBUG_STKSZ
+	  [DEBUG_IST]				= DEBUG_STKSZ
 };
 #endif
 
@@ -1760,7 +1760,7 @@ void cpu_init(void)
 			estacks += exception_stack_sizes[v];
 			oist->ist[v] = t->x86_tss.ist[v] =
 					(unsigned long)estacks;
-			if (v == DEBUG_STACK-1)
+			if (v == DEBUG_IST)
 				per_cpu(debug_stack_addr, cpu) = (unsigned long)estacks;
 		}
 	}
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -18,16 +18,16 @@
 
 #include <asm/stacktrace.h>
 
-static char *exception_stack_names[N_EXCEPTION_STACKS] = {
-		[ DOUBLEFAULT_STACK-1	]	= "#DF",
-		[ NMI_STACK-1		]	= "NMI",
-		[ DEBUG_STACK-1		]	= "#DB",
-		[ MCE_STACK-1		]	= "#MC",
+static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
+		[ DOUBLEFAULT_IST	]	= "#DF",
+		[ NMI_IST		]	= "NMI",
+		[ DEBUG_IST		]	= "#DB",
+		[ MCE_IST		]	= "#MC",
 };
 
-static unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
+static const unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
 	[0 ... N_EXCEPTION_STACKS - 1]		= EXCEPTION_STKSZ,
-	[DEBUG_STACK - 1]			= DEBUG_STKSZ
+	[DEBUG_IST]				= DEBUG_STKSZ
 };
 
 const char *stack_type_name(enum stack_type type)
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -41,9 +41,12 @@ struct idt_data {
 #define SYSG(_vector, _addr)				\
 	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
 
-/* Interrupt gate with interrupt stack */
+/*
+ * Interrupt gate with interrupt stack. The _ist index is the index in
+ * the tss.ist[] array, but for the descriptor it needs to start at 1.
+ */
 #define ISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+	G(_vector, _addr, _ist + 1, GATE_INTERRUPT, DPL0, __KERNEL_CS)
 
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
@@ -180,11 +183,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,		DEBUG_STACK),
-	ISTG(X86_TRAP_NMI,	nmi,		NMI_STACK),
-	ISTG(X86_TRAP_DF,	double_fault,	DOUBLEFAULT_STACK),
+	ISTG(X86_TRAP_DB,	debug,		DEBUG_IST),
+	ISTG(X86_TRAP_NMI,	nmi,		NMI_IST),
+	ISTG(X86_TRAP_DF,	double_fault,	DOUBLEFAULT_IST),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	MCE_STACK),
+	ISTG(X86_TRAP_MC,	&machine_check,	MCE_IST),
 #endif
 };
 


