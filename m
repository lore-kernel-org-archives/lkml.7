Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF5C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD821D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gT6smkdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfJGLYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfJGLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tzAbiVicHMi6ND4iTqQU3skxQnk4BXitqq07k8xRDK8=; b=gT6smkdqGc60sFQBgzK8F2MyB1
        KVXAWvxIgfCzFEmqpFoHJzl4lEQgJd2Fu+PZb4vFIq4lUjRFl7uTyWtx1BDew3pedrr17Qs5b/l4l
        jpxP4KhDO2D8rToeLWV768kDHCpV2rtZF2HsSU1OoHYjYAKKVfM7jP9rPvv8Tqar1Tameq9NbDWNB
        KpIoeHM7OEWphZK+zSouxGlpXmX+Ub608gYtlkLalG9h27MmRDI4NCMyjXEVip/jIgHBIZTUCK0bq
        0oyRR0gCl1tFThuffDtXflp5bZbb9/RfI0DQ4vQpllosCxIEFMzvoLO3E6xhD5jQnAKaRblFAaVex
        D5iaSIfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0002BJ-Ma; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43EC23072F4;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB2A320244E42; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007090011.83508177.5@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 1/9] jump_label, x86: Strip ASM jump_label support
References: <20191007084443.79370128.1@infradead.org>
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
@@ -337,7 +337,7 @@ For 32-bit we have the following convent
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


