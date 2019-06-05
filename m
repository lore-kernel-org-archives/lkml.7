Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C8C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC420870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWAd2dqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFENYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:24:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfFENXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oXhu2RnmN1bjxijZ/YxDd0PUyqgLkr/tTV2k0tXNHQY=; b=OWAd2dqn3JTpdIxLX067SQYUf9
        PZ56BBilq2YrfIyn67nOwVAkBK+nqtum30JYfw2rgDcGwKI29tme2AmwygnPeAEfvQxB4N1J5HwIr
        dSIFwLocNtbk+68la/Svz+fOXYc2MOqRcA97NP7KSF2/38gzY5VAjzrbZok0gDJjGm3GCXnJZbVZF
        Yo7CdUJQ8wvPFVbnAbY0TZ0vMqpb6XDV22htemyXZuX+GVDikYvsKK1od9AttHr9sRYV1euL/2w8I
        0m+e/wjBR6W/foS0FzJxpttQRP932VyJzAZ6UC69RrPrGiJJcWRjWnjGm8OL7dx7y2GoDudBbff2h
        lKlPg4yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsH-0004qN-Bw; Wed, 05 Jun 2019 13:22:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 782F8203C05D7; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.711054227@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:56 +0200
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
Subject: [PATCH 03/15] x86/kprobes: Fix frame pointer annotations
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kprobe trampolines have a FRAME_POINTER annotation that makes no
sense. It marks the frame in the middle of pt_regs, at the place of
saving BP.

Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
from the respective entry_*.S.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/common.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -5,15 +5,10 @@
 /* Kprobes and Optprobes common header */
 
 #include <asm/asm.h>
-
-#ifdef CONFIG_FRAME_POINTER
-# define SAVE_RBP_STRING "	push %" _ASM_BP "\n" \
-			 "	mov  %" _ASM_SP ", %" _ASM_BP "\n"
-#else
-# define SAVE_RBP_STRING "	push %" _ASM_BP "\n"
-#endif
+#include <asm/frame.h>
 
 #ifdef CONFIG_X86_64
+
 #define SAVE_REGS_STRING			\
 	/* Skip cs, ip, orig_ax. */		\
 	"	subq $24, %rsp\n"		\
@@ -27,11 +22,13 @@
 	"	pushq %r10\n"			\
 	"	pushq %r11\n"			\
 	"	pushq %rbx\n"			\
-	SAVE_RBP_STRING				\
+	"	pushq %rbp\n"			\
 	"	pushq %r12\n"			\
 	"	pushq %r13\n"			\
 	"	pushq %r14\n"			\
-	"	pushq %r15\n"
+	"	pushq %r15\n"			\
+	ENCODE_FRAME_POINTER
+
 #define RESTORE_REGS_STRING			\
 	"	popq %r15\n"			\
 	"	popq %r14\n"			\
@@ -51,19 +48,22 @@
 	/* Skip orig_ax, ip, cs */		\
 	"	addq $24, %rsp\n"
 #else
+
 #define SAVE_REGS_STRING			\
 	/* Skip cs, ip, orig_ax and gs. */	\
-	"	subl $16, %esp\n"		\
+	"	subl $4*4, %esp\n"		\
 	"	pushl %fs\n"			\
 	"	pushl %es\n"			\
 	"	pushl %ds\n"			\
 	"	pushl %eax\n"			\
-	SAVE_RBP_STRING				\
+	"	pushl %ebp\n"			\
 	"	pushl %edi\n"			\
 	"	pushl %esi\n"			\
 	"	pushl %edx\n"			\
 	"	pushl %ecx\n"			\
-	"	pushl %ebx\n"
+	"	pushl %ebx\n"			\
+	ENCODE_FRAME_POINTER
+
 #define RESTORE_REGS_STRING			\
 	"	popl %ebx\n"			\
 	"	popl %ecx\n"			\


