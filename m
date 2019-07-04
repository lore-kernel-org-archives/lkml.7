Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8490EC46495
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5669C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="botu6d6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfGDUDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:03:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=In1jl1lvP4qksN9cfTxgMyjB+e0oJR2lS+wCeE2o0oY=; b=botu6d6B6CMUGXxj5rzyodfv6V
        4FQQg22auuqeOB9mfe+O+tuSDCY54iVgct08YUbKjcwYsOvfAG+DCIWi2GrvAvDvc/hNdMGejusyr
        DwdJGC4lmkbujfrWLm+8IHKKMNkC5onW251n4KcQvO9nkljpHFyj4pr/yzbtPktTA/B3QUrDQxvgN
        ZZqFXyJGF8XCQBM7YYwudCXfdVbG5tOPXrWLyCeXYGCZ2rXE2WutLDJqvpuMsVgqaVOOKyShSHIXm
        /E+3urrkLke6/AbereMmMfnaNq+KosigCmdd0BwKhSH1NNdYQv8E5vwuv65MOiWMLbtD0tCjxn7Tp
        4aklcYjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hj7wa-0006lA-44; Thu, 04 Jul 2019 20:03:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B2502059DEAB; Thu,  4 Jul 2019 22:02:58 +0200 (CEST)
Message-Id: <20190704200050.477489028@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 21:55:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v2 4/7] x86/entry/64: Update comments and sanity tests for create_gap
References: <20190704195555.580363209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -913,15 +913,16 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 /**
  * idtentry - Generate an IDT entry stub
  * @sym:		Name of the generated entry point
- * @do_sym: 		C function to be called
- * @has_error_code: 	True if this IDT vector has an error code on the stack
- * @paranoid: 		non-zero means that this vector may be invoked from
+ * @do_sym:		C function to be called
+ * @has_error_code:	True if this IDT vector has an error code on the stack
+ * @paranoid:		non-zero means that this vector may be invoked from
  *			kernel mode with user GSBASE and/or user CR3.
  *			2 is special -- see below.
  * @shift_ist:		Set to an IST index if entries from kernel mode should
- *             		decrement the IST stack so that nested entries get a
+ *			decrement the IST stack so that nested entries get a
  *			fresh stack.  (This is for #DB, which has a nasty habit
- *             		of recursing.)
+ *			of recursing.)
+ * @create_gap:		create a 6-word stack gap when coming from kernel mode.
  *
  * idtentry generates an IDT stub that sets up a usable kernel context,
  * creates struct pt_regs, and calls @do_sym.  The stub has the following
@@ -951,10 +952,14 @@ ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
-	.if \shift_ist != -1 && \paranoid == 0
+	.if \shift_ist != -1 && \paranoid != 1
 	.error "using shift_ist requires paranoid=1"
 	.endif
 
+	.if \create_gap && \paranoid
+	.error "using create_gap requires paranoid=0"
+	.endif
+
 	ASM_CLAC
 
 	.if \has_error_code == 0


