Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC44C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FD2216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C9hs+Xwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfGKLwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:52:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfGKLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Lg6AEmKC1pw8WVnE2EH0KgFz1occGChGUIXDu3OLUE=; b=C9hs+XwdONo6qucUYGD0FNLkAM
        MILWIZ2pAIrioz1Eb5vUHP4r7EYXeP84Vxm+PoucEEq8nWyen0uSSYx4nu4c8m6Lc4iRDgArHdR0x
        Rg8t0S/EIVcDHerh5+/k5lcMjHgmdNMWJUffCVwBZAXyDZyo6LrKi2i6HxrHweCmHctWxwdXH/YSR
        9hO4PszOCOWWM8x+VkhJJd7Ccx7wiqpI2hGl3wFipK/vwZ/ULy0yztk1aCATE9sI4XIE1yZ3P/7rt
        +19s8WklKgv9QY6Fkyqq6z75s2l5dRNf+kT/HluaQ6dzWb2sE1uGugDnr+ONVbMmu5KMX+dWuxen0
        UxCELdBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXc3-0003MD-Rs; Thu, 11 Jul 2019 11:51:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E74DB201247E6; Thu, 11 Jul 2019 13:51:44 +0200 (CEST)
Message-Id: <20190711114335.945136187@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Jul 2019 13:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v3 2/6] x86/entry/32: Simplify common_exception
References: <20190711114054.406765395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding one more option to SAVE_ALL we can make use of it in
common_exception and simplify things. This saves duplication later
where page_fault will no longer use common_exception.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -294,9 +294,11 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
 	cld
+.if \skip_gs == 0
 	PUSH_GS
+.endif
 	FIXUP_FRAME
 	pushl	%fs
 	pushl	%es
@@ -313,13 +315,13 @@
 	movl	%edx, %es
 	movl	$(__KERNEL_PERCPU), %edx
 	movl	%edx, %fs
+.if \skip_gs == 0
 	SET_KERNEL_GS %edx
-
+.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
 .endif
-
 .endm
 
 .macro SAVE_ALL_NMI cr3_reg:req
@@ -1448,32 +1450,20 @@ END(page_fault)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
-	FIXUP_FRAME
-	pushl	%fs
-	pushl	%es
-	pushl	%ds
-	pushl	%eax
-	movl	$(__USER_DS), %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	$(__KERNEL_PERCPU), %eax
-	movl	%eax, %fs
-	pushl	%ebp
-	pushl	%edi
-	pushl	%esi
-	pushl	%edx
-	pushl	%ecx
-	pushl	%ebx
-	SWITCH_TO_KERNEL_STACK
+	SAVE_ALL switch_stacks=1 skip_gs=1
 	ENCODE_FRAME_POINTER
-	cld
 	UNWIND_ESPFIX_STACK
+
+	/* fixup %gs */
 	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi


