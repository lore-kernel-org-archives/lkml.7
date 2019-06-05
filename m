Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D7C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3BB2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sU7AoaR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfFENXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfFENXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N+L4hncPrLT3YUw3a9VAy36wpeglIBN4ooUYuEyD+Zg=; b=sU7AoaR6XP70/tJhp2u/GbFRde
        RTKU51MaT9Cng0tVNUUKO/Ws4K4pO3OYm09DKcxV3clxcQFDMKW3xuSE/AFdouNIHTJgS6Sl45H2n
        QcCJl2Aua9sR+9uA1L+WZnjDJ9huFWsf4F9tERmWgNmwr9hw1Rz+3Q9SPfBQiXOpJVjBUZVgoktKH
        ijnIwToxQNsCpppxzUwFAJdt2ccAbJ9AtqKaoOnRY9vL77dyIdAcHI57noOy3kIPsIGk/EyyPy220
        ErMmxIx8RIXErC8p4GtvbNJF6fPs2mDUKY0rArA6doGIOfG183I5FpR0ORHZf2dhIsgccteXK/+/u
        b9TFoEqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rO-2f; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7158B202D0BA0; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.591902815@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 01/15] x86/entry/32: Clean up return from interrupt preemption path
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code flow around the return from interrupt preemption point seems
needlesly complicated.

There is only one site jumping to resume_kernel, and none (outside of
resume_kernel) jumping to restore_all_kernel. Inline resume_kernel
in restore_all_kernel and avoid the CONFIG_PREEMPT dependent label.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -67,7 +67,6 @@
 # define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
 # define preempt_stop(clobbers)
-# define resume_kernel		restore_all_kernel
 #endif
 
 .macro TRACE_IRQS_IRET
@@ -755,7 +754,7 @@ END(ret_from_fork)
 	andl	$SEGMENT_RPL_MASK, %eax
 #endif
 	cmpl	$USER_RPL, %eax
-	jb	resume_kernel			# not returning to v8086 or userspace
+	jb	restore_all_kernel		# not returning to v8086 or userspace
 
 ENTRY(resume_userspace)
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -765,18 +764,6 @@ ENTRY(resume_userspace)
 	jmp	restore_all
 END(ret_from_exception)
 
-#ifdef CONFIG_PREEMPT
-ENTRY(resume_kernel)
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	restore_all_kernel
-	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
-	jz	restore_all_kernel
-	call	preempt_schedule_irq
-	jmp	restore_all_kernel
-END(resume_kernel)
-#endif
-
 GLOBAL(__begin_SYSENTER_singlestep_region)
 /*
  * All code from here through __end_SYSENTER_singlestep_region is subject
@@ -1027,6 +1014,15 @@ ENTRY(entry_INT80_32)
 	INTERRUPT_RETURN
 
 restore_all_kernel:
+#ifdef CONFIG_PREEMPT
+	DISABLE_INTERRUPTS(CLBR_ANY)
+	cmpl	$0, PER_CPU_VAR(__preempt_count)
+	jnz	.Lno_preempt
+	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
+	jz	.Lno_preempt
+	call	preempt_schedule_irq
+.Lno_preempt:
+#endif
 	TRACE_IRQS_IRET
 	PARANOID_EXIT_TO_KERNEL_MODE
 	BUG_IF_WRONG_CR3


