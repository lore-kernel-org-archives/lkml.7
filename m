Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E27C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EE92086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DSrots28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfFENXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbfFENXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5bqcevd3/vd3K9kcANMub1p7PmIO2FY3TmZar48KLsQ=; b=DSrots28hWrcs8cOLDaIVe+mWk
        eqqgwt2jE58mqhfnzpspifGwYaoaOXai1AH6S4y8L9jQaT97dGVEjdMfiQJpEEF4SLf7r6bfy3kit
        j3PJqydR1Co28Chc6oUJFh1o/tPJ9w/532KB0FB/rUywPvGucVLAdkeZ/uFaddGGHkAuTHm5v4OM1
        EOZpKpOOMIypymlT7Qm9qlhm9bBsw1cX21xwILLJuk7w5UoKn+Ql70VTCVT2dJHlIvvE2NdTVllvq
        pbkK2N6Gk6ENQpPD0jBQ/Hr0ROTd6flCLmon0J+/34YnebqlF874sG+mKRPxdx2CokSnPLmBfD5nR
        0uWGmegw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsH-0004qM-Cb; Wed, 05 Jun 2019 13:22:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7C08C200DCF2B; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.770117090@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:57 +0200
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
Subject: [PATCH 04/15] x86/ftrace: Add pt_regs frame annotations
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FRAME_POINTER, we should mark pt_regs frames.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_32.S |    3 +++
 arch/x86/kernel/ftrace_64.S |    3 +++
 2 files changed, 6 insertions(+)

--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
+#include <asm/frame.h>
 
 # define function_hook	__fentry__
 EXPORT_SYMBOL(__fentry__)
@@ -116,6 +117,8 @@ ENTRY(ftrace_regs_caller)
 	pushl	%ecx
 	pushl	%ebx
 
+	ENCODE_FRAME_POINTER
+
 	movl	12*4(%esp), %eax		/* Load ip (1st parameter) */
 	subl	$MCOUNT_INSN_SIZE, %eax		/* Adjust ip */
 	movl	15*4(%esp), %edx		/* Load parent ip (2nd parameter) */
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/frame.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -203,6 +204,8 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	ENCODE_FRAME_POINTER
+
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 


