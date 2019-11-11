Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9308FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662DE21925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wuNcjdj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKKOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfKKOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RHzN5RoqfKMzCrKJWQ/omaWzsFYBKA0JN52zKhgDx48=; b=wuNcjdj8oWYJ4Tgu4Udoy8EXNi
        6ESDoGboX5SXsH7Eh8mfnDYiPF7aJp0C85gMLjrYjk7KtWAgqUjFtmo35ij5DmPWXsKWyac23/0aR
        rUnM3jqkkrqn0qPYlOQe3Vr1dNbdAhp025uIHznrwMtNSUSugDC64ge/a0OCZq7X8zD+W68sV8Amg
        UT7/9fSfJLuQyjABkEb7rmnMY4mliUy/SZfu7K2LtVLzBHKxpn1+1PnJj3Xnf6VoZXv3gF94SbU6H
        4OZ4lQG2ykjQ/veoXJS2rany9PwGlT1jKorvgsSNKcdzZzXJ8byPpd7nbcFG/l8uGZ49Hi9JhLGRZ
        CyGXo3Og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyA-0003t5-RS; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8B32306DED;
        Mon, 11 Nov 2019 15:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 86E6D29980EFF; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132457.875666061@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:12:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 07/17] x86/alternative: Add text_opcode_size()
References: <20191111131252.921588318@infradead.org>
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


