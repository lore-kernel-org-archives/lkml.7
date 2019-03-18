Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D562083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfCRJlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:41:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:4490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfCRJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 02:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="329583747"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.146])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 02:41:33 -0700
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     luto@kernel.org
Cc:     luto@amacapital.net, jpoimboe@redhat.com, keescook@chromium.org,
        jannh@google.com, enrico.perla@intel.com, mingo@redhat.com,
        bp@alien8.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Date:   Mon, 18 Mar 2019 11:41:27 +0200
Message-Id: <20190318094128.1488-1-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_RANDOMIZE_KSTACK_OFFSET is selected,
the kernel stack offset is randomized upon each
entry to a system call after fixed location of pt_regs
struct.

This feature is based on the original idea from
the PaX's RANDKSTACK feature:
https://pax.grsecurity.net/docs/randkstack.txt
All the credits for the original idea goes to the PaX team.
However, the design and implementation of
RANDOMIZE_KSTACK_OFFSET differs greatly from the RANDKSTACK
feature (see below).

Reasoning for the feature:

This feature aims to make considerably harder various
stack-based attacks that rely on deterministic stack
structure.
We have had many of such attacks in past [1],[2],[3]
(just to name few), and as Linux kernel stack protections
have been constantly improving (vmap-based stack
allocation with guard pages, removal of thread_info,
STACKLEAK), attackers have to find new ways for their
exploits to work.

It is important to note that we currently cannot show
a concrete attack that would be stopped by this new
feature (given that other existing stack protections
are enabled), so this is an attempt to be on a proactive
side vs. catching up with existing successful exploits.

The main idea is that since the stack offset is
randomized upon each system call, it is very hard for
attacker to reliably land in any particular place on
the thread stack when attack is performed.
Also, since randomization is performed *after* pt_regs,
the ptrace-based approach to discover randomization
offset during a long-running syscall should not be
possible.

[1] jon.oberheide.org/files/infiltrate12-thestackisback.pdf
[2] jon.oberheide.org/files/stackjacking-infiltrate11.pdf
[3] googleprojectzero.blogspot.com/2016/06/exploiting-
recursion-in-linux-kernel_20.html

Design description:

During most of the kernel's execution, it runs on the "thread
stack", which is allocated at fork.c/dup_task_struct() and stored in
a per-task variable (tsk->stack). Since stack is growing downward,
the stack top can be always calculated using task_top_of_stack(tsk)
function, which essentially returns an address of tsk->stack + stack
size. When VMAP_STACK is enabled, the thread stack is allocated from
vmalloc space.

Thread stack is pretty deterministic on its structure - fixed in size,
and upon every entry from a userspace to kernel on a
syscall the thread stack is started to be constructed from an
address fetched from a per-cpu cpu_current_top_of_stack variable.
The first element to be pushed to the thread stack is the pt_regs struct
that stores all required CPU registers and sys call parameters.

The goal of RANDOMIZE_KSTACK_OFFSET feature is to add a random offset
after the pt_regs has been pushed to the stack and the rest of thread
stack (used during the syscall processing) every time a process issues
a syscall. The source of randomness can be taken either from rdtsc or
rdrand with performance implications listed below. The value of random
offset is stored in a callee-saved register (r15 currently) and the
maximum size of random offset is defined by __MAX_STACK_RANDOM_OFFSET
value, which currently equals to 0xFF0.

As a result this patch introduces 8 bits of randomness
(bits 4 - 11 are randomized, bits 0-3 must be zero due to stack alignment)
after pt_regs location on the thread stack.
The amount of randomness can be adjusted based on how much of the
stack space we wish/can trade for security.

The main issue with this approach is that it slightly breaks the
processing of last frame in the unwinder, so I have made a simple
fix to the frame pointer unwinder (I guess others should be fixed
similarly) and stack dump functionality to "jump" over the random hole
at the end. My way of solving this is probably far from ideal,
so I would really appreciate feedback on how to improve it.

Performance:

1) lmbench: ./lat_syscall -N 1000000 null
    base:                     Simple syscall: 0.1774 microseconds
    random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
    random_offset (rdrand): Simple syscall: 0.3702 microseconds

2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
    base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
    random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
    random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop

Comparison to grsecurity RANDKSTACK feature:

RANDKSTACK feature randomizes the location of the stack start
(cpu_current_top_of_stack), i.e. location of pt_regs structure
itself on the stack. Initially this patch followed the same approach,
but during the recent discussions [4], it has been determined
to be of a little value since, if ptrace functionality is available
for an attacker, he can use PTRACE_PEEKUSR/PTRACE_POKEUSR api to read/write
different offsets in the pt_regs struct, observe the cache
behavior of the pt_regs accesses, and figure out the random stack offset.

Another big difference is that randomization is done upon
syscall entry and not the exit, as with RANDKSTACK.

Also, as a result of the above two differences, the implementation
of RANDKSTACK and RANDOMIZE_KSTACK_OFFSET has nothing in common.

[4] https://www.openwall.com/lists/kernel-hardening/2019/02/08/6

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 arch/Kconfig                   | 15 +++++++++++++++
 arch/x86/Kconfig               |  1 +
 arch/x86/entry/calling.h       | 14 ++++++++++++++
 arch/x86/entry/entry_64.S      |  6 ++++++
 arch/x86/include/asm/frame.h   |  3 +++
 arch/x86/kernel/dumpstack.c    | 10 +++++++++-
 arch/x86/kernel/unwind_frame.c |  9 ++++++++-
 7 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..9a2557b0cfce 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -808,6 +808,21 @@ config VMAP_STACK
 	  the stack to map directly to the KASAN shadow map using a formula
 	  that is incorrect if the stack is in vmalloc space.
 
+config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	def_bool n
+	help
+	  An arch should select this symbol if it can support kernel stack
+	  offset randomization.
+
+config RANDOMIZE_KSTACK_OFFSET
+	default n
+	bool "Randomize kernel stack offset on syscall entry"
+	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	help
+	  Enable this if you want the randomize kernel stack offset upon
+	  each syscall entry. This causes kernel stack (after pt_regs) to
+	  have a randomized offset upon executing each system call.
+
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ade12ec4224b..5edcae945b73 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -131,6 +131,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET  if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index efb0d1b1f15f..68502645d812 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -345,6 +345,20 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
+.macro RANDOMIZE_KSTACK
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+	/* prepare a random offset in rax */
+	pushq %rax
+	xorq  %rax, %rax
+	ALTERNATIVE "rdtsc", "rdrand %rax", X86_FEATURE_RDRAND
+	andq  $__MAX_STACK_RANDOM_OFFSET, %rax
+
+	/* store offset in r15 */
+	movq  %rax, %r15
+	popq  %rax
+#endif
+.endm
+
 /*
  * This does 'call enter_from_user_mode' unless we can avoid it based on
  * kernel config or using the static jump infrastructure.
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..0816ec680c21 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -167,13 +167,19 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
+	RANDOMIZE_KSTACK		/* stores randomized offset in r15 */
+
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
 	movq	%rax, %rdi
 	movq	%rsp, %rsi
+	sub 	%r15, %rsp          /* substitute random offset from rsp */
 	call	do_syscall_64		/* returns with IRQs disabled */
 
+	/* need to restore the gap */
+	add 	%r15, %rsp       /* add random offset back to rsp */
+
 	TRACE_IRQS_IRETQ		/* we're about to change IF */
 
 	/*
diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 5cbce6fbb534..e1bb91504f6e 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -4,6 +4,9 @@
 
 #include <asm/asm.h>
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+#define __MAX_STACK_RANDOM_OFFSET 0xFF0
+#endif
 /*
  * These are stack frame creation macros.  They should be used by every
  * callable non-leaf asm function to make kernel stack traces more reliable.
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 2b5886401e5f..4146a4c3e9c6 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -192,7 +192,6 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 */
 	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
 		const char *stack_name;
-
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
 			/*
 			 * We weren't on a valid stack.  It's possible that
@@ -224,6 +223,9 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		 */
 		for (; stack < stack_info.end; stack++) {
 			unsigned long real_addr;
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+			unsigned long left_gap;
+#endif
 			int reliable = 0;
 			unsigned long addr = READ_ONCE_NOCHECK(*stack);
 			unsigned long *ret_addr_p =
@@ -272,6 +274,12 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			regs = unwind_get_entry_regs(&state, &partial);
 			if (regs)
 				show_regs_if_on_stack(&stack_info, regs, partial);
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+			left_gap = (unsigned long)regs - (unsigned long)stack;
+			/* if we reached last frame, jump over the random gap*/
+			if (left_gap < __MAX_STACK_RANDOM_OFFSET)
+				stack = (unsigned long *)regs--;
+#endif
 		}
 
 		if (stack_name)
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 3dc26f95d46e..656f36b1f1b3 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -98,7 +98,14 @@ static inline unsigned long *last_frame(struct unwind_state *state)
 
 static bool is_last_frame(struct unwind_state *state)
 {
-	return state->bp == last_frame(state);
+	if (state->bp == last_frame(state))
+		return true;
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+	if ((last_frame(state) - state->bp) < __MAX_STACK_RANDOM_OFFSET)
+		return true;
+#endif
+	return false;
+
 }
 
 #ifdef CONFIG_X86_32
-- 
2.17.1

