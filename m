Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF544C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963C021852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0B/KrdV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfGDUEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:04:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfGDUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d5fEomzm2WlXF0OHxmb/BtkSVx0kvKPLQ5xZaii3quE=; b=0B/KrdV3ne1ihVC83PoZrvVJHe
        F/ytEGMxELyTK4C2QtxDr/BTyKsaNn5xk+4NsaWDDuXk1hnridqkFmnjGsdnIgP9m8s+1/PwWEQe4
        pOtuy6AmoTHc35ybj6pCiz7MGc9sHE55tnqnS+R8eaY2zW2HbqZCSY2KLPJhlLbs4nKEsQTw9otOi
        1N0Xv3waoWnB14Rki6Q9kEviS1zNH8F03JNynswDGRRcieSKjV1l0SYxBmU1WhkFtyYJpIlov/8g0
        CkwV3w+wqgsBIbj2yhPvy9SBfqB1Oar3YpYtuu5bqLJz2tE07ebFJ6k4cCFNH/OkdCyOoJaBD1Kho
        H11Z9B/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hj7wb-0005ei-Aq; Thu, 04 Jul 2019 20:03:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5369D2059DEDC; Thu,  4 Jul 2019 22:02:58 +0200 (CEST)
Message-Id: <20190704200050.591915266@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 21:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v2 6/7] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
References: <20190704195555.580363209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since INT3/#BP no longer runs on an IST, this workaround is no longer
required.

Tested by running lockdep+ftrace as described in the initial commit:

  5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   46 ++--------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -68,44 +68,6 @@ END(native_usergs_sysret64)
 .endm
 
 /*
- * When dynamic function tracer is enabled it will add a breakpoint
- * to all locations that it is about to modify, sync CPUs, update
- * all the code, sync CPUs, then remove the breakpoints. In this time
- * if lockdep is enabled, it might jump back into the debug handler
- * outside the updating of the IST protection. (TRACE_IRQS_ON/OFF).
- *
- * We need to change the IDT table before calling TRACE_IRQS_ON/OFF to
- * make sure the stack pointer does not get reset back to the top
- * of the debug stack, and instead just reuses the current stack.
- */
-#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_TRACE_IRQFLAGS)
-
-.macro TRACE_IRQS_OFF_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_OFF
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_ON_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_ON
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_IRETQ_DEBUG
-	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
-	jnc	1f
-	TRACE_IRQS_ON_DEBUG
-1:
-.endm
-
-#else
-# define TRACE_IRQS_OFF_DEBUG			TRACE_IRQS_OFF
-# define TRACE_IRQS_ON_DEBUG			TRACE_IRQS_ON
-# define TRACE_IRQS_IRETQ_DEBUG			TRACE_IRQS_IRETQ
-#endif
-
-/*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
  * This is the only entry point used for 64-bit system calls.  The
@@ -879,11 +841,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	GET_CR2_INTO(%rdx);			/* can clobber %rax */
 	.endif
 
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
 	TRACE_IRQS_OFF
-	.endif
 
 	.if \paranoid == 0
 	testb	$3, CS(%rsp)
@@ -1292,7 +1250,7 @@ END(paranoid_entry)
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF_DEBUG
+	TRACE_IRQS_OFF
 
 	/* Handle GS depending on FSGSBASE availability */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "nop",X86_FEATURE_FSGSBASE
@@ -1312,7 +1270,7 @@ ENTRY(paranoid_exit)
 	jmp	.Lparanoid_exit_restore
 
 .Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
+	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 


