Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F37C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDBA218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tUwrWvnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGCK2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:28:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33224 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=From:Content-Type:MIME-Version:
        References:Subject:Cc:To:Date:Message-Id:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iVBwZmLYwKyzqu2qXp0eR/vORHeEgKn3hMY8ooPCZtM=; b=tUwrWvnL8bDP
        Kk5cmTh6C1IhEomhcUmf/5EKZy+Rsn2/C91qIQs1SMKtuP5jlwMj/LXZJsVYA63HaH6vqrJ/X+E/k
        V1LRPz9fka2Wy+u8zo07qN8DVlE4lIH/8GxQAyT+VaYz62gse6b43qg5HUS3c3fXdl1eScDAAXwk6
        6XdKSliIhiYjSE4KVA6yim/ZRFodjYIr3l2LwAHn3C7GB+QdzzApWJeO+xX3iJLxlvf3fHnB+N7hz
        sYR9ec/KSn9UJ/nqTnIA9XUVMwvuPO1GAzSrYzE0iTE5ee4f/af9HYzdm+yF6jgMAaeRkltQY/4RL
        oxpdVpeXApvszwJPQ2wWWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hicV2-0006Fb-A7; Wed, 03 Jul 2019 10:28:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C3FF5202173E0; Wed,  3 Jul 2019 12:28:25 +0200 (CEST)
Message-Id: <20190703102807.532454315@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:27:33 +0200
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH 2/3] x86/entry/32: Simplify common_exception
References: <20190703102731.236024951@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From:   root <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding one more option to SAVE_ALL we can make use of it in
common_exception and simplify things. This saves duplication later
where page_fault will no longer use common_exception.

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


