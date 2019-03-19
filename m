Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43C920828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRTiafRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCSLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:17:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+tiSnus5J3PQhQEEFDwRC6NaI/H5uwN2fu5+i0zHVv0=; b=DRTiafRM68vDImSGc7klaJ/PA
        87lPiTC+U1QXiyt2Hk1yfPVPGeGYN+wEURtAqIAmdVAJfw/yKauWy4MFsbAY6tY9ihEgG2yApXAOp
        zt98KziqorqN+XyWrO4zKJ7UTBnbfsfkOZIM8SM5qrVaRbCebQUn0LCf5bdWGiwSbB7KrMJiJP2E7
        E44eKWHidrGo3DqLPpqBV6S2iMEtsP8lWFIEialVoVwzDX6+kl5j3TAo7P7q1hnNRYoSqvNVvCGEw
        9nN3kxINrx+HAYtli7J1gswjTWjg84fZiLzQl8BQW/jnHxrKf0gamJsrnGAFnfWsIhsP01SIx0GR0
        VPdQjipzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6CkX-0000wN-M6; Tue, 19 Mar 2019 11:17:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 340BE23E8CA31; Tue, 19 Mar 2019 12:17:40 +0100 (CET)
Date:   Tue, 19 Mar 2019 12:17:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        rostedt@goodmis.org
Subject: [PATCH 26/25] sched/x86_64: Don't save flags on context switch
Message-ID: <20190319111740.GZ6058@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318153840.906404905@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: sched/x86_64: Don't save flags on context switch
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Mar 19 11:35:46 CET 2019

Now that we have objtool validating AC=1 state for all x86_64 code,
we can once again guarantee clean flags on schedule.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        |    2 --
 arch/x86/include/asm/switch_to.h |    2 +-
 arch/x86/kernel/process_64.c     |    7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -291,7 +291,6 @@ ENTRY(__switch_to_asm)
 	pushq	%r13
 	pushq	%r14
 	pushq	%r15
-	pushfq
 
 	/* switch stack */
 	movq	%rsp, TASK_threadsp(%rdi)
@@ -314,7 +313,6 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
-	popfq
 	popq	%r15
 	popq	%r14
 	popq	%r13
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -40,13 +40,13 @@ asmlinkage void ret_from_fork(void);
  * order of the fields must match the code in __switch_to_asm().
  */
 struct inactive_task_frame {
-	unsigned long flags;
 #ifdef CONFIG_X86_64
 	unsigned long r15;
 	unsigned long r14;
 	unsigned long r13;
 	unsigned long r12;
 #else
+	unsigned long flags;
 	unsigned long si;
 	unsigned long di;
 #endif
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -393,13 +393,6 @@ int copy_thread_tls(unsigned long clone_
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
 
-	/*
-	 * For a new task use the RESET flags value since there is no before.
-	 * All the status flags are zero; DF and all the system flags must also
-	 * be 0, specifically IF must be 0 because we context switch to the new
-	 * task with interrupts disabled.
-	 */
-	frame->flags = X86_EFLAGS_FIXED;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
