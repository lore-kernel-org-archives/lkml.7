Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97114C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695C021852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u1plHiUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfGDUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:03:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55208 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfGDUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dWuwoWPilizWWaBNsYsWRTHFOQnTIgYN+9VfDxisx4U=; b=u1plHiUa0Nx/7lklj1T47Uosra
        YtiUuZB9ASQbhxI8hvSzDNnzidOF8VZRsm4cvE5yHbEK+zHxtN90llcxR+5Kj+ewT1+/Q5QA9Sape
        xJ2S5wT+Fidm2M6Hsfvmz6zMDYYOZCnzsrcrN68zQRjISU2nfi3E6hSxM1u23JJ2rjbZGLSGb7ljP
        6icyi+VpINIcndP9jJbaPOLIPYIaxMj3A9QAkPMz3T6PSOQayXiij+PIxcXbJLqVbMpnyrXG/lsM3
        B3OhPQo7+q3UnDAW3s5DfjiSfTee6/26vOmzFzbB5wg1ESFrEcd6TAoHYllIN1TpVPN8nifxROh71
        O98e+7Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hj7wZ-0005eX-Kw; Thu, 04 Jul 2019 20:02:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46FA72059DEA9; Thu,  4 Jul 2019 22:02:58 +0200 (CEST)
Message-Id: <20190704200050.420328531@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 21:55:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v2 3/7] x86/entry/64: Simplify idtentry a little
References: <20190704195555.580363209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bunch of duplication in idtentry, namely the
.Lfrom_usermode_switch_stack is a paranoid=0 copy of the normal flow.

Make this explicit by creating a idtentry_part helper macro.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |  100 +++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -865,6 +865,51 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
+.macro idtentry_part do_sym, has_error_code:req, paranoid:req, shift_ist=-1, ist_offset=0
+
+	.if \paranoid
+	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
+	.else
+	call	error_entry
+	.endif
+	UNWIND_HINT_REGS
+
+	.if \paranoid
+	.if \shift_ist != -1
+	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
+	.else
+	TRACE_IRQS_OFF
+	.endif
+	.endif
+
+	movq	%rsp, %rdi			/* pt_regs pointer */
+
+	.if \has_error_code
+	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
+	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
+	.else
+	xorl	%esi, %esi			/* no error code */
+	.endif
+
+	.if \shift_ist != -1
+	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	call	\do_sym
+
+	.if \shift_ist != -1
+	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	.if \paranoid
+	jmp	paranoid_exit
+	.else
+	jmp	error_exit
+	.endif
+
+.endm
+
 /**
  * idtentry - Generate an IDT entry stub
  * @sym:		Name of the generated entry point
@@ -935,46 +980,7 @@ ENTRY(\sym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	.if \paranoid
-	call	paranoid_entry
-	.else
-	call	error_entry
-	.endif
-	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
-
-	.if \paranoid
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
-	TRACE_IRQS_OFF
-	.endif
-	.endif
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
-	.endif
-
-	.if \shift_ist != -1
-	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	call	\do_sym
-
-	.if \shift_ist != -1
-	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	.if \paranoid
-	jmp	paranoid_exit
-	.else
-	jmp	error_exit
-	.endif
+	idtentry_part \do_sym, \has_error_code, \paranoid, \shift_ist, \ist_offset
 
 	.if \paranoid == 1
 	/*
@@ -983,21 +989,9 @@ ENTRY(\sym)
 	 * run in real process context if user_mode(regs).
 	 */
 .Lfrom_usermode_switch_stack_\@:
-	call	error_entry
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
+	idtentry_part \do_sym, \has_error_code, 0
 	.endif
 
-	call	\do_sym
-
-	jmp	error_exit
-	.endif
 _ASM_NOKPROBE(\sym)
 END(\sym)
 .endm


