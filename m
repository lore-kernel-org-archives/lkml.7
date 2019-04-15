Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A720825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfDOGJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:09:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:15451 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDOGJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 23:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,352,1549958400"; 
   d="scan'208";a="164772691"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.146])
  by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2019 23:09:30 -0700
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     luto@kernel.org
Cc:     luto@amacapital.net, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, keescook@chromium.org, jannh@google.com,
        enrico.perla@intel.com, mingo@redhat.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org,
        gregkh@linuxfoundation.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Date:   Mon, 15 Apr 2019 09:09:18 +0300
Message-Id: <20190415060918.3766-1-elena.reshetova@intel.com>
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
a syscall. The source of randomness can be taken either from prandom_u32()
pseudo random generator (not cryptographically secure). The offset is
added using alloca() call since it helps avoiding changes in assembly
syscall entry code and unwinder.

This is an example of produced assembly code for gcc x86_64:

...
  add_random_stack_offset();
0xffffffff810022e9 callq  0xffffffff81459570 <prandom_u32>
0xffffffff810022ee movzbl %al,%eax
0xffffffff810022f1 add    $0x16,%rax
0xffffffff810022f5 and    $0x1f8,%eax
0xffffffff810022fa sub    %rax,%rsp
0xffffffff810022fd lea    0xf(%rsp),%rax
0xffffffff81002302 and    $0xfffffffffffffff0,%rax
...

As a result of the above gcc-produce code this patch introduces
a bit more than 5 bits of randomness after pt_regs location on
the thread stack (33 different offsets are generated
randomly for x86_64 and 47 for i386).
The amount of randomness can be adjusted based on how much of the
stack space we wish/can trade for security.

Performance (x86_64 measuments only):

1) lmbench: ./lat_syscall -N 1000000 null
    base:                                        Simple syscall: 0.1774 microseconds
    random_offset (prandom_u32() every syscall): Simple syscall: 0.1822 microseconds

2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
    base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
    random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s = 166.26 nsec / loop

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
 arch/Kconfig            | 15 +++++++++++++++
 arch/x86/Kconfig        |  1 +
 arch/x86/entry/common.c | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

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
index ade12ec4224b..87e5444cd366 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -131,6 +131,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7bc105f47d21..076085611e94 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -35,6 +35,20 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+#include <linux/random.h>
+
+void *__builtin_alloca(size_t size);
+
+#define add_random_stack_offset() do {               \
+	size_t offset = ((size_t)prandom_u32()) % 256;   \
+	char *ptr = __builtin_alloca(offset);            \
+	asm volatile("":"=m"(*ptr));                     \
+} while (0)
+#else
+#define add_random_stack_offset() do {} while (0)
+#endif
+
 #ifdef CONFIG_CONTEXT_TRACKING
 /* Called on entry from user mode with IRQs off. */
 __visible inline void enter_from_user_mode(void)
@@ -273,6 +287,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
+	add_random_stack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	ti = current_thread_info();
@@ -344,6 +359,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
+	add_random_stack_offset();
 	enter_from_user_mode();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
@@ -360,6 +376,8 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 		vdso_image_32.sym_int80_landing_pad;
 
+	add_random_stack_offset();
+
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
 	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
-- 
2.17.1

