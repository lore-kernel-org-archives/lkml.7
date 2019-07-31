Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BF7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="liqKgFpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfGaR7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:59:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaR7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:59:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHx8VV3777914
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:59:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHx8VV3777914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595949;
        bh=wZZLT9UmRiv9WZJWm3gpfB4v2A41cLmh9sH66SFpHuM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=liqKgFpzX3Yjtu4dZRFmD2QKkHZRUTY+1b7GuXBb79ExfnazoFc42LYpV17bErWXT
         o3/JNSybKyDo7yCwFEbtckP8tX+0SSNh8cFmQCS6/Mp8owDRu/hxXUfdyzhQjYN3/0
         kAuMgzriOJDEGkxsXh3rGBLlf6stawwzNWAw4Ek9NPyCHvMUlZ+BOYLY9bQt/MqZZn
         m9wlOLZIg1qPUqmqMcT41rFbRzUSk7XSqF4REFWE2Oryplgspb/mYU3aIAHu+bbbx/
         Ehr+xe4SxYjbxBWnZXQiLSPeLmkZdGyk5jVFFwB7I42siR7BCDULW1b35QEZmB7ljX
         MNcjqaz85XQlA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHx7s53777911;
        Wed, 31 Jul 2019 10:59:07 -0700
Date:   Wed, 31 Jul 2019 10:59:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-48593975aeee548f25e256c515fd1d1e3fb2cc20@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.ibm.com, pbonzini@redhat.com, hpa@zytor.com,
        mingo@kernel.org, mhiramat@kernel.org
Reply-To: rostedt@goodmis.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, pbonzini@redhat.com, paulmck@linux.ibm.com,
          mhiramat@kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190726212124.608488448@linutronix.de>
References: <20190726212124.608488448@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] x86: Use CONFIG_PREEMPTION
Git-Commit-ID: 48593975aeee548f25e256c515fd1d1e3fb2cc20
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  48593975aeee548f25e256c515fd1d1e3fb2cc20
Gitweb:     https://git.kernel.org/tip/48593975aeee548f25e256c515fd1d1e3fb2cc20
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:42 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:35 +0200

x86: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the entry code, preempt and kprobes conditionals over to
CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.608488448@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_32.S      | 6 +++---
 arch/x86/entry/entry_64.S      | 4 ++--
 arch/x86/entry/thunk_32.S      | 2 +-
 arch/x86/entry/thunk_64.S      | 4 ++--
 arch/x86/include/asm/preempt.h | 2 +-
 arch/x86/kernel/kprobes/core.c | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4f86928246e7..f83ca5aa8b77 100644
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
@@ -1084,7 +1084,7 @@ restore_all:
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3f5a978a02a7..9701464341e4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -662,7 +662,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 
 /* Returning to kernel space */
 retint_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/* Interrupts are off */
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
@@ -1113,7 +1113,7 @@ ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
 	call	xen_evtchn_do_upcall
 	LEAVE_IRQ_STACK
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index cb3464525b37..2713490611a3 100644
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
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index cc20465b2867..ea5c4167086c 100644
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
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 99a7fa9ab0a3..3d4cb83a8828 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -102,7 +102,7 @@ static __always_inline bool should_resched(int preempt_offset)
 	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
   extern asmlinkage void ___preempt_schedule(void);
 # define __preempt_schedule() \
 	asm volatile ("call ___preempt_schedule" : ASM_CALL_CONSTRAINT)
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0e0b08008b5a..43fc13c831af 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -580,7 +580,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 	if (setup_detour_execution(p, regs, reenter))
 		return;
 
-#if !defined(CONFIG_PREEMPT)
+#if !defined(CONFIG_PREEMPTION)
 	if (p->ainsn.boostable && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)
