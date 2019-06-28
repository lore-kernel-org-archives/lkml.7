Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD512C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F84214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9HkHdbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1Ng3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfF1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HtM6ACIkbeZKtDkvGjHHb3Ye2jYoNIMulX0HoLqvqr4=; b=Q9HkHdbLXjOD4nKgHzL1N/ZzLu
        1FDz/r89kJcS37yeGP8jWU23mGIjA8adwOxV1GYW3xBoibCtcr+Tj6WrL/o6DyrLdgXnGR1/qLZSa
        pgqHPhf5hpRZTIMuEJNbaDVgTdK9e9FK1v3X5gdMNjCvwulM3PU5QGfswq5Ee+CbscwvSD9wL7mrV
        u+Epi4S06CmNPXem6FyB2OCQQfsX/5p5Y8ov9NNltwMiidXOw318RWEb3R+8gTt0MIjyRWa/FVQrv
        U8z6B7kYFLP6vlnrnd9Nt2mCKJF6jQ9MR4QB/4ezqarxA7zNxYBW1J8qmq8dh2FOqx+XkWtDb9Pah
        KW7MxOdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2r-0006t2-1s; Fri, 28 Jun 2019 13:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7BC1C20AB898E; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.546149747@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC][PATCH 2/8] jump_label, x86: Strip ASM jump_label support
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepration for variable size jump_label support; remove all ASM
bits that are not used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h          |    2 +-
 arch/x86/include/asm/jump_label.h |   28 ++++------------------------
 2 files changed, 5 insertions(+), 25 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -377,7 +377,7 @@ For 32-bit we have the following convent
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef CONFIG_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
+	STATIC_BRANCH_FALSE_LIKELY .Lafter_call_\@, context_tracking_enabled
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -55,36 +55,16 @@ static __always_inline bool arch_static_
 
 #else	/* __ASSEMBLY__ */
 
-.macro STATIC_JUMP_IF_TRUE target, key, def
+.macro STATIC_BRANCH_FALSE_LIKELY target, key
 .Lstatic_jump_\@:
-	.if \def
 	/* Equivalent to "jmp.d32 \target" */
 	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
+	.long		\target - (. + 4)
 
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
+	.long		.Lstatic_jump_\@ - .
+	.long		\target - .
 	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm


