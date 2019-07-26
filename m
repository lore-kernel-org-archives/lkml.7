Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5926DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332E42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfGZVYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:24:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfGZVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7hA-000319-U1; Fri, 26 Jul 2019 23:24:09 +0200
Message-Id: <20190726212124.608488448@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 6/8] x86: Use CONFIG_PREEMPTION
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the entry code, preempt and kprobes conditionals over to
CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S      |    6 +++---
 arch/x86/entry/entry_64.S      |    4 ++--
 arch/x86/entry/thunk_32.S      |    2 +-
 arch/x86/entry/thunk_64.S      |    4 ++--
 arch/x86/include/asm/preempt.h |    2 +-
 arch/x86/kernel/kprobes/core.c |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -63,7 +63,7 @@
  * enough to patch inline, increasing performance.
  */
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 # define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
 # define preempt_stop(clobbers)
@@ -1084,7 +1084,7 @@ ENTRY(entry_INT80_32)
 	INTERRUPT_RETURN
 
 restore_all_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	.Lno_preempt
@@ -1364,7 +1364,7 @@ ENTRY(xen_hypervisor_callback)
 ENTRY(xen_do_upcall)
 1:	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	ret_from_intr
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -662,7 +662,7 @@ GLOBAL(swapgs_restore_regs_and_return_to
 
 /* Returning to kernel space */
 retint_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/* Interrupts are off */
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
@@ -1113,7 +1113,7 @@ ENTRY(xen_do_hypervisor_callback)		/* do
 	call	xen_evtchn_do_upcall
 	LEAVE_IRQ_STACK
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -34,7 +34,7 @@
 	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
 #endif
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	THUNK ___preempt_schedule, preempt_schedule
 	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
 	EXPORT_SYMBOL(___preempt_schedule)
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -46,7 +46,7 @@
 	THUNK lockdep_sys_exit_thunk,lockdep_sys_exit
 #endif
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	THUNK ___preempt_schedule, preempt_schedule
 	THUNK ___preempt_schedule_notrace, preempt_schedule_notrace
 	EXPORT_SYMBOL(___preempt_schedule)
@@ -55,7 +55,7 @@
 
 #if defined(CONFIG_TRACE_IRQFLAGS) \
  || defined(CONFIG_DEBUG_LOCK_ALLOC) \
- || defined(CONFIG_PREEMPT)
+ || defined(CONFIG_PREEMPTION)
 .L_restore:
 	popq %r11
 	popq %r10
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -102,7 +102,7 @@ static __always_inline bool should_resch
 	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
   extern asmlinkage void ___preempt_schedule(void);
 # define __preempt_schedule() \
 	asm volatile ("call ___preempt_schedule" : ASM_CALL_CONSTRAINT)
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -580,7 +580,7 @@ static void setup_singlestep(struct kpro
 	if (setup_detour_execution(p, regs, reenter))
 		return;
 
-#if !defined(CONFIG_PREEMPT)
+#if !defined(CONFIG_PREEMPTION)
 	if (p->ainsn.boostable && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)


