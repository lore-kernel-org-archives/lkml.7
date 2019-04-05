Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8642175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfDEPMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:12:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48922 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbfDEPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:20 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUw-0005tk-FN; Fri, 05 Apr 2019 17:11:18 +0200
Message-Id: <20190405150930.129884669@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 19/29] x86/exceptions: Split debug IST stack
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug IST stack is actually two separate debug stacks to handle #DB
recursion. This is required because the CPU starts always at top of stack
on exception entry, which means on #DB recursion the second #DB would
overwrite the stack of the first.

The low level entry code therefore adjusts the top of stack on entry so a
secondary #DB starts from a different stack page. But the stack pages are
adjacent without a guard page between them.

Split the debug stack into 3 stacks which are separated by guard pages. The
3rd stack is never mapped into the cpu_entry_area and is only there to
catch triple #DB nesting:

      --- top of DB_stack	<- Initial stack
      --- end of DB_stack
      	  guard page

      --- top of DB1_stack	<- Top of stack after entering first #DB
      --- end of DB1_stack
      	  guard page

      --- top of DB2_stack	<- Top of stack after entering second #DB
      --- end of DB2_stack	   
      	  guard page

If DB2 would not act as the final guard hole, a second #DB would point the
top of #DB stack to the stack below #DB1 which would be valid and not catch
the not so desired triple nesting.

The backing store does not allocate any memory for DB2 and its guard page
as it is not going to be mapped into the cpu_entry_area.

 - Adjust the low level entry code so it adjusts top of #DB with the offset
   between the stacks instead of exception stack size.

 - Make the dumpstack code aware of the new stacks.

 - Adjust the in_debug_stack() implementation and move it into the NMI code
   where it belongs. As this is NMI hotpath code, it just checks the full
   area between top of DB_stack and bottom of DB1_stack without checking
   for the guard page. That's correct because the NMI cannot hit a
   stackpointer pointing to the guard page between DB and DB1 stack.  Even
   if it would, then the NMI operation still is unaffected, but the resume
   of the debug exception on the topmost DB stack will crash by touching
   the guard page.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/x86/kernel-stacks       |    7 ++++++-
 arch/x86/entry/entry_64.S             |    8 ++++----
 arch/x86/include/asm/cpu_entry_area.h |   21 ++++++++++++++++-----
 arch/x86/include/asm/debugreg.h       |    2 --
 arch/x86/include/asm/page_64_types.h  |    3 ---
 arch/x86/kernel/asm-offsets_64.c      |    2 ++
 arch/x86/kernel/cpu/common.c          |   11 -----------
 arch/x86/kernel/dumpstack_64.c        |   12 ++++++++----
 arch/x86/kernel/nmi.c                 |   20 +++++++++++++++++++-
 arch/x86/mm/cpu_entry_area.c          |    4 +++-
 10 files changed, 58 insertions(+), 32 deletions(-)

--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks
@@ -76,7 +76,7 @@ The currently assigned IST stacks are :-
   middle of switching stacks.  Using IST for NMI events avoids making
   assumptions about the previous state of the kernel stack.
 
-* ISTACK_DB.  DEBUG_STKSZ
+* ISTACK_DB.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for hardware debug interrupts (interrupt 1) and for software
   debug interrupts (INT3).
@@ -86,6 +86,11 @@ The currently assigned IST stacks are :-
   avoids making assumptions about the previous state of the kernel
   stack.
 
+  To handle nested #DB correctly there exist two instances of DB stacks. On
+  #DB entry the IST stackpointer for #DB is switched to the second instance
+  so a nested #DB starts from a clean stack. The nested #DB switches to
+  the IST stackpointer to a guard hole to catch triple nesting.
+
 * ISTACK_MCE.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for interrupt 18 - Machine Check Exception (#MC).
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -879,7 +879,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -925,13 +925,13 @@ ENTRY(\sym)
 	.endif
 
 	.if \shift_ist != -1
-	subq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
+	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
 	call	\do_sym
 
 	.if \shift_ist != -1
-	addq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
+	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
 	/* these procedures expect "no swapgs" flag in ebx */
@@ -1129,7 +1129,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB
+idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -9,25 +9,34 @@
 
 #ifdef CONFIG_X86_64
 
-/* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize)		\
+/*
+ * Macro to enforce the same ordering and stack sizes.
+ *
+ * Note: DB2 stack is never mapped into the cpu_entry_area. It's there to
+ * catch triple nesting of #DB.
+ */
+#define ESTACKS_MEMBERS(guardsize, db2_holesize)\
 	char	DF_stack[EXCEPTION_STKSZ];	\
 	char	DF_stack_guard[guardsize];	\
 	char	NMI_stack[EXCEPTION_STKSZ];	\
 	char	NMI_stack_guard[guardsize];	\
-	char	DB_stack[DEBUG_STKSZ];		\
+	char	DB2_stack[db2_holesize];	\
+	char	DB2_stack_guard[guardsize];	\
+	char	DB1_stack[EXCEPTION_STKSZ];	\
+	char	DB1_stack_guard[guardsize];	\
+	char	DB_stack[EXCEPTION_STKSZ];	\
 	char	DB_stack_guard[guardsize];	\
 	char	MCE_stack[EXCEPTION_STKSZ];	\
 	char	MCE_stack_guard[guardsize];	\
 
 /* The exception stacks linear storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0)
+	ESTACKS_MEMBERS(0, 0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE)
+	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
 };
 
 /*
@@ -36,6 +45,8 @@ struct cea_exception_stacks {
 enum exception_stack_ordering {
 	ISTACK_DF,
 	ISTACK_NMI,
+	ISTACK_DB2,
+	ISTACK_DB1,
 	ISTACK_DB,
 	ISTACK_MCE,
 	N_EXCEPTION_STACKS
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -104,11 +104,9 @@ static inline void debug_stack_usage_dec
 {
 	__this_cpu_dec(debug_stack_usage);
 }
-int is_debug_stack(unsigned long addr);
 void debug_stack_set_zero(void);
 void debug_stack_reset(void);
 #else /* !X86_64 */
-static inline int is_debug_stack(unsigned long addr) { return 0; }
 static inline void debug_stack_set_zero(void) { }
 static inline void debug_stack_reset(void) { }
 static inline void debug_stack_usage_inc(void) { }
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -19,9 +19,6 @@
 #define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
-#define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
-#define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
-
 #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
 #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)
 
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -68,6 +68,8 @@ int main(void)
 #undef ENTRY
 
 	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
+	DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
+	       offsetof(struct cea_exception_stacks, DB1_stack));
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1549,17 +1549,7 @@ void syscall_init(void)
 	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
 }
 
-static DEFINE_PER_CPU(unsigned long, debug_stack_addr);
 DEFINE_PER_CPU(int, debug_stack_usage);
-
-int is_debug_stack(unsigned long addr)
-{
-	return __this_cpu_read(debug_stack_usage) ||
-		(addr <= __this_cpu_read(debug_stack_addr) &&
-		 addr > (__this_cpu_read(debug_stack_addr) - DEBUG_STKSZ));
-}
-NOKPROBE_SYMBOL(is_debug_stack);
-
 DEFINE_PER_CPU(u32, debug_idt_ctr);
 
 void debug_stack_set_zero(void)
@@ -1735,7 +1725,6 @@ void cpu_init(void)
 		t->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
 		t->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
 		t->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
-		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[IST_INDEX_DB];
 	}
 
 	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -19,16 +19,18 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 
-static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
+static const char *exception_stack_names[] = {
 		[ ISTACK_DF	]	= "#DF",
 		[ ISTACK_NMI	]	= "NMI",
+		[ ISTACK_DB2	]	= "#DB2",
+		[ ISTACK_DB1	]	= "#DB1",
 		[ ISTACK_DB	]	= "#DB",
 		[ ISTACK_MCE	]	= "#MC",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -58,9 +60,11 @@ struct estack_layout {
 	.end	= offsetof(struct cea_exception_stacks, x## _stack_guard) \
 	}
 
-static const struct estack_layout layout[N_EXCEPTION_STACKS] = {
+static const struct estack_layout layout[] = {
 	[ ISTACK_DF	]	= ESTACK_ENTRY(DF),
 	[ ISTACK_NMI	]	= ESTACK_ENTRY(NMI),
+	[ ISTACK_DB2	]	= { .begin = 0, .end = 0},
+	[ ISTACK_DB1	]	= ESTACK_ENTRY(DB1),
 	[ ISTACK_DB	]	= ESTACK_ENTRY(DB),
 	[ ISTACK_MCE	]	= ESTACK_ENTRY(MCE),
 };
@@ -71,7 +75,7 @@ static bool in_exception_stack(unsigned
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
 
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -21,13 +21,14 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/atomic.h>
 #include <linux/sched/clock.h>
 
 #if defined(CONFIG_EDAC)
 #include <linux/edac.h>
 #endif
 
-#include <linux/atomic.h>
+#include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/mach_traps.h>
 #include <asm/nmi.h>
@@ -487,6 +488,23 @@ static DEFINE_PER_CPU(unsigned long, nmi
  * switch back to the original IDT.
  */
 static DEFINE_PER_CPU(int, update_debug_stack);
+
+static bool notrace is_debug_stack(unsigned long addr)
+{
+	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
+	unsigned long top = CEA_ESTACK_TOP(cs, DB);
+	unsigned long bot = CEA_ESTACK_BOT(cs, DB1);
+
+	if (__this_cpu_read(debug_stack_usage))
+		return true;
+	/*
+	 * Note, this covers the guard page between DB and DB1 as well to
+	 * avoid two checks. But by all means @addr can never point into
+	 * the guard page.
+	 */
+	return addr > bot && addr < top;
+}
+NOKPROBE_SYMBOL(is_debug_stack);
 #endif
 
 dotraplinkage notrace void
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -98,10 +98,12 @@ static void __init percpu_setup_exceptio
 
 	/*
 	 * The exceptions stack mappings in the per cpu area are protected
-	 * by guard pages so each stack must be mapped separately.
+	 * by guard pages so each stack must be mapped separately. DB2 is
+	 * not mapped; it just exists to catch triple nesting of #DB.
 	 */
 	cea_map_stack(DF);
 	cea_map_stack(NMI);
+	cea_map_stack(DB1);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 }


