Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41AB21915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMBchcBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfCUKpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:45:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vvcZGFxkcxBKT7DIR2f3M9/QIK7k0YfNJ8fLrzaqX+k=; b=MMBchcBLhIFX3P/7Pv84VHgE4
        ZXWp2Nk+tChXBQW0NaVGHBQ390wf8FiWsfofiUJ7ivU1/ZLyvKiZ6y4P1TV8o7rH6otAMvf0iBRXS
        2GjnZ5JbqiJCpbm+gT7OxHJ/phbvI/MwVvkKkFFdO7eYkIuMO7pcDUdmE7ho0WwZvn7sYQH0crdl2
        d6D33UGySP/9bIckGhqfcOMgKFHqI53cC5NzLYyj2fU8RJ1dzi97Y4BLO5ZRa6EQ7GuMsETrywvGj
        HSthV+hXNlQtLEqHIZNBkdJvAp5WFCNL5IsUyocy+aCJLBDvSPkdd7EcriObb8VTRdp+oxDAwUK2o
        SiKOkEI7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6vCJ-00009E-Q1; Thu, 21 Mar 2019 10:45:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1961F285855B8; Thu, 21 Mar 2019 11:45:17 +0100 (CET)
Date:   Thu, 21 Mar 2019 11:45:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321104517.GM6521@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321090241.GL6521@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:02:41AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 21, 2019 at 09:33:17AM +0100, Peter Zijlstra wrote:
> 
> I'm thinking this problem wasn't new.
> 
> > idtentry page_fault             do_page_fault           has_error_code=1
> >   call error_entry
> >     TRACE_IRQS_OFF
> >       call trace_hardirqs_off*
> >         <tracer stuff>
> > 	  <fault> # modifies CR2
> 
>       CALL_enter_from_user_mode
>         __context_tracking_exit()
> 	  trace_user_exit(0)
> 	    #PF
> 
> >   call do_page_fault
> >     address = read_cr2(); /* whoopsie */
> 
> And that also isn't fixed by your patch.
> 
> I'm trying to make idtentry put cr2 in rdx, such that do_page_fault()
> takes address as a 3rd argument, but I'm still fighting that context
> tracking nonsense.
> 

Something a little like so; completely untested and obviously needs
32bit changes too.

---
 arch/x86/entry/entry_64.S | 28 ++++++++++++++++------------
 arch/x86/mm/fault.c       |  3 +--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..776dbe7ba72e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -879,7 +879,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 read_cr2=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -901,18 +901,28 @@ ENTRY(\sym)
 
 	.if \paranoid
 	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 	.else
 	call	error_entry
+	/* returned flag: ebx=1: CALL_enter_from_user_mode, ebx=0: don't need it */
 	.endif
 	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
 
-	.if \paranoid
+	.if \read_cr2
+	mov	%cr2, %rdx			/* XXX paravirt crap */
+	.endif
+
 	.if \shift_ist != -1
 	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
 	.else
 	TRACE_IRQS_OFF
 	.endif
+
+	.if \paranoid == 0
+	testl	%ebx, %ebx
+	jz	.Lno_context_tracking_\@
+	CALL_enter_from_user_mode
+.Lno_context_tracking_\@:
 	.endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer */
@@ -1140,7 +1150,7 @@ idtentry xenint3		do_int3			has_error_code=0
 #endif
 
 idtentry general_protection	do_general_protection	has_error_code=1
-idtentry page_fault		do_page_fault		has_error_code=1
+idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
 
 #ifdef CONFIG_KVM_GUEST
 idtentry async_page_fault	do_async_page_fault	has_error_code=1
@@ -1243,17 +1253,11 @@ ENTRY(error_entry)
 	ENCODE_FRAME_POINTER
 	pushq	%r12
 
-	/*
-	 * We need to tell lockdep that IRQs are off.  We can't do this until
-	 * we fix gsbase, and we should do it before enter_from_user_mode
-	 * (which can take locks).
-	 */
-	TRACE_IRQS_OFF
-	CALL_enter_from_user_mode
+	mov	$1, %ebx			/* CALL_enter_from_user_mode */
 	ret
 
 .Lerror_entry_done:
-	TRACE_IRQS_OFF
+	xorl	%ebx, %ebx
 	ret
 
 	/*
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..aac7a74869a2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1560,9 +1560,8 @@ trace_page_fault_entries(unsigned long address, struct pt_regs *regs,
  * exception_{enter,exit}() contains all sorts of tracepoints.
  */
 dotraplinkage void notrace
-do_page_fault(struct pt_regs *regs, unsigned long error_code)
+do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	unsigned long address = read_cr2(); /* Get the faulting address */
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
