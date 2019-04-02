Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FEE2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDBUEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C3C7307C941;
        Tue,  2 Apr 2019 20:04:14 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943A36014A;
        Tue,  2 Apr 2019 20:04:09 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [RFC PATCH 1/7] x86/entry: Add support for early task context tracking
Date:   Tue,  2 Apr 2019 22:03:53 +0200
Message-Id: <90ce8a6a4ca02e1e8a2a43185f193cd72a59d020.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Apr 2019 20:04:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the identification of the context is made through the
preempt_counter, but it is set after the execution of the first functions
of the IRQ/NMI, causing potential problems in the identification of the
current status. For instance, ftrace/perf might drop events in the early
stage of IRQ/NMI handlers because the preempt_counter was not set.

The proposed approach is to use a dedicated per-cpu variable to keep
track of the context of execution, with values set before the execution
of the first C function of the interrupt handler.

This is a PoC in the x86_64.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/entry/entry_64.S       |  9 +++++++++
 arch/x86/include/asm/irqflags.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c    |  4 ++++
 include/linux/irqflags.h        |  4 ++++
 kernel/softirq.c                |  5 ++++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..1471b544241f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -545,6 +545,7 @@ ENTRY(interrupt_entry)
 	testb	$3, CS+8(%rsp)
 	jz	1f
 
+	TASK_CONTEXT_SET_BIT context=TASK_CTX_IRQ
 	/*
 	 * IRQ from user mode.
 	 *
@@ -561,6 +562,8 @@ ENTRY(interrupt_entry)
 
 1:
 	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
+
+	TASK_CONTEXT_SET_BIT context=TASK_CTX_IRQ
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
@@ -586,6 +589,7 @@ ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 
+	TASK_CONTEXT_RESET_BIT context=TASK_CTX_IRQ
 	LEAVE_IRQ_STACK
 
 	testb	$3, CS(%rsp)
@@ -780,6 +784,7 @@ ENTRY(\sym)
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
+	TASK_CONTEXT_RESET_BIT context=TASK_CTX_IRQ
 	jmp	ret_from_intr
 END(\sym)
 _ASM_NOKPROBE(\sym)
@@ -1403,9 +1408,11 @@ ENTRY(nmi)
 	 * done with the NMI stack.
 	 */
 
+	TASK_CONTEXT_SET_BIT context=TASK_CTX_NMI
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	do_nmi
+	TASK_CONTEXT_RESET_BIT context=TASK_CTX_NMI
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1615,10 +1622,12 @@ end_repeat_nmi:
 	call	paranoid_entry
 	UNWIND_HINT_REGS
 
+	TASK_CONTEXT_SET_BIT context=TASK_CTX_NMI
 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	do_nmi
+	TASK_CONTEXT_RESET_BIT context=TASK_CTX_NMI
 
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 058e40fed167..5a12bc3ea02b 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -3,6 +3,7 @@
 #define _X86_IRQFLAGS_H_
 
 #include <asm/processor-flags.h>
+#include <asm/percpu.h>
 
 #ifndef __ASSEMBLY__
 
@@ -202,4 +203,33 @@ static inline int arch_irqs_disabled(void)
 #endif
 #endif /* __ASSEMBLY__ */
 
+#ifdef CONFIG_X86_64
+/*
+ * NOTE: I know I need to implement this to the 32 bits as well.
+ * But... this is just a POC.
+ */
+#define ARCH_HAS_TASK_CONTEXT   1
+
+#define TASK_CTX_THREAD		0x0
+#define TASK_CTX_SOFTIRQ	0x1
+#define TASK_CTX_IRQ		0x2
+#define TASK_CTX_NMI		0x4
+
+#ifdef __ASSEMBLY__
+.macro TASK_CONTEXT_SET_BIT context:req
+	orb	$\context, PER_CPU_VAR(task_context)
+.endm
+
+.macro TASK_CONTEXT_RESET_BIT context:req
+	andb	$~\context, PER_CPU_VAR(task_context)
+.endm
+#else /* __ASSEMBLY__ */
+DECLARE_PER_CPU(unsigned char, task_context);
+
+static __always_inline void task_context_set(unsigned char context)
+{
+	raw_cpu_write_1(task_context, context);
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_X86_64 */
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..1acbec22319b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1531,6 +1531,8 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned char, task_context) __visible = 0;
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
@@ -1604,6 +1606,8 @@ EXPORT_PER_CPU_SYMBOL(current_task);
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned char, task_context) __visible = 0;
+
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..1c3473bbe5d2 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -168,4 +168,8 @@ do {						\
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
+#ifndef ARCH_HAS_TASK_CONTEXT
+#define task_context_set(context) do {} while (0)
+#endif
+
 #endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 10277429ed84..324de769dc07 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -410,8 +410,11 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
+	if (!in_interrupt() && local_softirq_pending()) {
+		task_context_set(TASK_CTX_SOFTIRQ);
 		invoke_softirq();
+		task_context_set(TASK_CTX_IRQ);
+	}
 
 	tick_irq_exit();
 	rcu_irq_exit();
-- 
2.20.1

