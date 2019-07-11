Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FDCC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3B12166E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrnVCzPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfGKLwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:52:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfGKLwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x/vGwDcUvq5XOKlVFW/Vxp48Js2QfW22vkKigRIutgY=; b=GrnVCzPQ7hidgY3kKcg1CF7QWa
        mvonGcnYzTy++1P1MRHA3l1w6zYUkk+ZsllnYPmJiisSBmY0vU0TAopq9dE8u5xDt8ht1D+NS/2bq
        XO9uN22m/oH4inSb4eBS0Zm/fbHwKHDJfu8KiIMOrnsC7Os6nvSZQEf2hKCS5G/c4EJyYqK3fXmrG
        FMGuKIvJuPgDQMRSiCaIZVQQU1oRX0/hu0Uwm58uh61xGjKMM16VxCkB0VragIQqZi0DZuHvUgu71
        HKMO6QWqjg9JHCNofo8DW9JU97+xAn3nK4o1VVRX2AozXLZcJi07Frgj0uLXk0Fp0+CCGGUurny+U
        jiZoUGvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXc3-0003MB-Rr; Thu, 11 Jul 2019 11:51:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC91220B53B62; Thu, 11 Jul 2019 13:51:44 +0200 (CEST)
Message-Id: <20190711114336.002429503@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Jul 2019 13:40:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v3 3/6] x86/entry/64: Simplify idtentry a little
References: <20190711114054.406765395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bunch of duplication in idtentry, namely the
.Lfrom_usermode_switch_stack is a paranoid=0 copy of the normal flow.

Make this explicit by creating a idtentry_part helper macro.

Acked-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |  102 +++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 54 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -864,6 +864,52 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
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
+	/* this procedure expect "no swapgs" flag in ebx */
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
@@ -934,47 +980,7 @@ ENTRY(\sym)
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
-	/* these procedures expect "no swapgs" flag in ebx */
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
+	idtentry_part \do_sym, \has_error_code, paranoid=0
 	.endif
 
-	call	\do_sym
-
-	jmp	error_exit
-	.endif
 _ASM_NOKPROBE(\sym)
 END(\sym)
 .endm


