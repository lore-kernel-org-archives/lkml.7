Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1139C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fUC/0wOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1NgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1NgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PBCXNPhXznSRLpWZ9dW03ymmoYfbGlwE23D94T1zegA=; b=fUC/0wOVuJpVlWIBVBvOevCS5E
        sb+a257Ku+6xC+bWaAe/F6crBvSiNS70oxlMCHYPXymMMhHgtOn18d5+Nmx2GXanXljGwZ31IaQ8i
        /YXg8q+oGgfDQT96+BxE7WXyXFnO0fRpt8ukWq5myrQPsjlKDsRQaPChcmlYWTZy0bSFjf5D4j4E1
        h/IeRbkHZi3KlkFIJKXGZGESdiwUuHh7tfh1wTBXYISwp7RXeDslBbiggUCUs3p4ACbee1PIhnEqP
        AcrqgciUx/BvGKpn7kc6rDI1St7NnD5czYhMfH5ID4Y3H/Hl9Jvo0PUdezua80yOAVLgCVc7vEhM9
        CHb+tHsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2s-0000nF-HO; Fri, 28 Jun 2019 13:36:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9644B20AB8994; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.830851505@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:20 +0200
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
Subject: [RFC][PATCH 7/8] jump_label, x86: Introduce jump_entry_size()
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows architectures to have variable sized jumps.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |    4 ++--
 arch/x86/kernel/jump_label.c      |    8 ++++++++
 include/linux/jump_label.h        |    9 +++++++++
 kernel/jump_label.c               |    2 +-
 4 files changed, 20 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,8 +4,6 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#define JUMP_LABEL_NOP_SIZE 5
-
 #ifdef CONFIG_X86_64
 # define STATIC_KEY_NOP2 P6_NOP2
 # define STATIC_KEY_NOP5 P6_NOP5_ATOMIC
@@ -55,6 +53,8 @@ static __always_inline bool arch_static_
 	return true;
 }
 
+extern int arch_jump_entry_size(struct jump_entry *entry);
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_BRANCH_FALSE_LIKELY target, key
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -32,6 +32,14 @@ static inline bool __jump_disp_is_byte(s
 	return false;
 }
 
+int arch_jump_entry_size(struct jump_entry *entry)
+{
+	s32 disp = jump_entry_target(entry) - jump_entry_code(entry);
+	if (__jump_disp_is_byte(disp))
+		return JMP8_INSN_SIZE;
+	return JMP32_INSN_SIZE;
+}
+
 static int __jump_label_set_jump_code(struct jump_entry *entry,
 				      enum jump_label_type type,
 				      union jump_code_union *code,
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -176,6 +176,15 @@ static inline void jump_entry_set_init(s
 	entry->key |= 2;
 }
 
+static inline int jump_entry_size(struct jump_entry *entry)
+{
+#ifdef JUMP_LABEL_NOP_SIZE
+	return JUMP_LABEL_NOP_SIZE;
+#else
+	return arch_jump_entry_size(entry);
+#endif
+}
+
 #endif
 #endif
 
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit)
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
 	if (jump_entry_code(entry) <= (unsigned long)end &&
-	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	    jump_entry_code(entry) + jump_entry_size(entry) > (unsigned long)start)
 		return 1;
 
 	return 0;


