Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F682C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D350121882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCjDrfXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGDJTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:19:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfGDJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m/cJ+Oyjh+AqX5ae94L9uwUZUYLQVb7NP1Gac/yL2bc=; b=fCjDrfXN5aH1L05IEQk87tV3h
        Ua9WNfdAyclmsjUyUNyC5O1JOEND/cfwPELZo1wbg1nCh0Q6YfosjklPjej7wln4oTnT6pn50jciA
        NiHC59Ng3dpDlPPUsUJant2aZZYhoUfiQZAc7vP+ESvM4VsaG1gsySkPkJf86nyjAP62avUU72ils
        03g1TUk3rAXMEyfChlQ9rpeqLKgqTwVSlQpBXa55HAJWcR3yfEYf4IgNbf6en5B618EXrkMK+zOfR
        7PImb/TcyI4+sI63ZLtyCCMRUy+R3/aalfqUo4MMGRglVoQ1mxX4+RxhMcoWXHBBJpCH6/G2ssT09
        p514XcA+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hixte-0005tF-61; Thu, 04 Jul 2019 09:19:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BB7020215B9E; Thu,  4 Jul 2019 11:19:16 +0200 (CEST)
Date:   Thu, 4 Jul 2019 11:19:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190704091916.GI3463@hirez.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
 <20190703102807.588906400@infradead.org>
 <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
 <20190703164701.54ef979a@gandalf.local.home>
 <20190703220522.GK3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703220522.GK3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:05:22AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2019 at 04:47:01PM -0400, Steven Rostedt wrote:

> > Yeah, looks like we might be missing a TRACE_IRQS_OFF from the
> > from_usermode_stack_switch path.
> 
> Oh bugger, there's a second error_entry call.

---
Subject: x86/entry/64: Simplify idtentry a little
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jul 4 10:55:11 CEST 2019

There's a bunch of duplication in idtentry, namely the
.Lfrom_usermode_switch_stack is an explicit paranoid=0 copy of the
normal flow.

Make this explicit by creating a (idtentry_part) helper macro.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |  100 +++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 53 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -865,6 +865,51 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
+.macro idtentry_part has_error_code:req paranoid:req shift_ist:-1 ist_offset=0
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
+	idtentry_part has_error_code=\has_error_code paranoid=\paranoid shift_ist=\shift_ist ist_offset=\ist_offset
 
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
+	idtentry_part has_error_code=\has_error_code paranoid=0
 	.endif
 
-	call	\do_sym
-
-	jmp	error_exit
-	.endif
 _ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
