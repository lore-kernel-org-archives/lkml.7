Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5021897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fP3hgVly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504744AbfJRHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504530AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RHzN5RoqfKMzCrKJWQ/omaWzsFYBKA0JN52zKhgDx48=; b=fP3hgVlymRYQElvGyA4bjcSECO
        gv/HoKxMf/oHEZ2x2l/O3ml1NmWwPGhL5rXas4av2h1EjKfd4x/7asJjfgssOGtRIWVo5rWPz2vSM
        dWk9/VlJ6kxji8oddXkMJz9nVu+RVpWdi6q5gCL0zg93mp/Eh3gtg1mI5hdPVPUeTGgXiwgm0GBmB
        p4h3ibz8UH9+RfnFfsfAZR7+6XcMiKHVyDCRRL9Iw8kFvo9uLz4g7QQr1Qw3qu13AKKMNhgc6MnqT
        3HWIgldAWWYLscDXDs+vqotLaafZnzBm7T688WOs++IybqdHU93Mq8hjGRECLefc+Gxr6E4UAUeQX
        LY2RCx4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2c-0001NE-5d; Fri, 18 Oct 2019 07:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBD98306BB5;
        Fri, 18 Oct 2019 09:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4A02C2B178112; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.343234882@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 07/16] x86/alternative: Add text_opcode_size()
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a common helper to map *_INSN_OPCODE to *_INSN_SIZE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   43 +++++++++++++++++++++++++----------
 arch/x86/kernel/alternative.c        |   12 ---------
 2 files changed, 32 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -49,18 +49,6 @@ extern void text_poke_bp(void *addr, con
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
-extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
-
-extern int after_bootmem;
-extern __ro_after_init struct mm_struct *poking_mm;
-extern __ro_after_init unsigned long poking_addr;
-
-#ifndef CONFIG_UML_X86
-static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
-{
-	regs->ip = ip;
-}
-
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
@@ -73,6 +61,37 @@ static inline void int3_emulate_jmp(stru
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+static inline int text_opcode_size(u8 opcode)
+{
+	int size = 0;
+
+#define __CASE(insn)	\
+	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
+
+	switch(opcode) {
+	__CASE(INT3);
+	__CASE(CALL);
+	__CASE(JMP32);
+	__CASE(JMP8);
+	}
+
+#undef __CASE
+
+	return size;
+}
+
+extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+
+extern int after_bootmem;
+extern __ro_after_init struct mm_struct *poking_mm;
+extern __ro_after_init unsigned long poking_addr;
+
+#ifndef CONFIG_UML_X86
+static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+{
+	regs->ip = ip;
+}
+
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1259,22 +1259,12 @@ union text_poke_insn {
 void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 {
 	static union text_poke_insn insn; /* text_mutex */
-	int size = 0;
+	int size = text_opcode_size(opcode);
 
 	lockdep_assert_held(&text_mutex);
 
 	insn.opcode = opcode;
 
-#define __CASE(insn)	\
-	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
-
-	switch(opcode) {
-	__CASE(INT3);
-	__CASE(CALL);
-	__CASE(JMP32);
-	__CASE(JMP8);
-	}
-
 	if (size > 1) {
 		insn.disp = (long)dest - (long)(addr + size);
 		if (size == 2)


