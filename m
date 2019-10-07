Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB4CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85852173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPSzLMSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfJGLZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B6EVgZuFd5eGpVUt6XnGLzokt7poarlS/kHE8aGQTN4=; b=NPSzLMSz4FPYvqhNc09HjXSttE
        XMXb45zhmqJeVjFzJZOD9tFLRIDN0kFbd70yiFa1F83IoSlKVt6tMCwQQETM3uYXZcpcNVtdD9Pui
        wJvJyPwGa300BJHbmALhrbCbgYfpU9Kyb/hjLhrGEhZ8w0SMoVKxosBM81+r+TLX7aQZrzZ6b0mdQ
        IFiFVrWk0JPABuqqGOmlutucFxxwNvcIwFNQ7ZojszbjVpZ6jnRtVydEx96bpGKrTNWy6x/5F6XPw
        xCd9xDyGZJHMcbXWm1sEopeTMR8jj8LWS0cCT8uvjCCP7PsBFGs7vqCPz/usTSM6cCZgtYkF/Q/6q
        d2cRaimw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003HJ-S2; Mon, 07 Oct 2019 11:23:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 552083073C6;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 08E9020244E48; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.11817198.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 6/9] jump_label, x86: Add variable length patching support
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the patching to to emit 2 byte JMP/NOP instruction in
addition to the 5 byte JMP/NOP we already did. This allows for more
compact code.

This code is not yet used, as we don't emit shorter code at compile
time yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |    8 +++--
 arch/x86/include/asm/nops.h       |    1 
 arch/x86/kernel/jump_label.c      |   60 ++++++++++++++++++++++++--------------
 3 files changed, 45 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -5,9 +5,11 @@
 #define HAVE_JUMP_LABEL_BATCH
 
 #ifdef CONFIG_X86_64
-# define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
+# define STATIC_KEY_NOP2 P6_NOP2
+# define STATIC_KEY_NOP5 P6_NOP5_ATOMIC
 #else
-# define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
+# define STATIC_KEY_NOP2 GENERIC_NOP2
+# define STATIC_KEY_NOP5 GENERIC_NOP5_ATOMIC
 #endif
 
 #include <asm/asm.h>
@@ -29,7 +31,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".byte " __stringify(STATIC_KEY_NOP5) "\n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -5,6 +5,7 @@
 /*
  * Define nops for use with alternative() and for tracing.
  *
+ * *_NOP2 must be a single instruction
  * *_NOP5_ATOMIC must be a single instruction.
  */
 
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -21,50 +21,70 @@ int arch_jump_entry_size(struct jump_ent
 	return JMP32_INSN_SIZE;
 }
 
-static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
+struct jump_label_patch {
+	const void *code;
+	int size;
+};
+
+static struct jump_label_patch
+__jump_label_patch(struct jump_entry *entry, enum jump_label_type type, int init)
 {
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect, *code;
+	const unsigned char default_nop2[] = { STATIC_KEY_NOP2 };
+	const unsigned char default_nop5[] = { STATIC_KEY_NOP5 };
+	const void *expect, *code, *nop, *default_nop;
 	const void *addr, *dest;
-	int line;
+	int line, size;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
-	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+	size = arch_jump_entry_size(entry);
+	switch (size) {
+	case JMP8_INSN_SIZE:
+		code = text_gen_insn(JMP8_INSN_OPCODE, addr, dest);
+		default_nop = default_nop2;
+		nop = ideal_nops[2];
+		break;
+
+	case JMP32_INSN_SIZE:
+		code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+		default_nop = default_nop5;
+		nop = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	default: BUG();
+	}
 
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+		expect = nop; line = __LINE__;
 	} else {
 		expect = code; line = __LINE__;
 	}
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+	if (memcmp(addr, expect, size)) {
 		/*
 		 * The location is not an op that we were expecting.
 		 * Something went wrong. Crash the box, as something could be
 		 * corrupting the kernel.
 		 */
-		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d type:%d\n",
-				addr, addr, addr, expect, line, init, type);
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d size:%d type:%d\n",
+				addr, addr, addr, expect, line, init, size, type);
 		BUG();
 	}
 
 	if (type == JUMP_LABEL_NOP)
-		code = ideal_nop;
+		code = nop;
 
-	return code;
+	return (struct jump_label_patch){.code = code, .size = size};
 }
 
 static void inline __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type, init);
+	const struct jump_label_patch jlp = __jump_label_patch(entry, type, init);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -78,12 +98,11 @@ static void inline __jump_label_transfor
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), opcode,
-				JUMP_LABEL_NOP_SIZE);
+		text_poke_early((void *)jump_entry_code(entry), jlp.code, jlp.size);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 }
 
 static void __ref jump_label_transform(struct jump_entry *entry,
@@ -104,7 +123,7 @@ void arch_jump_label_transform(struct ju
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	const void *opcode;
+	struct jump_label_patch jlp;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -115,9 +134,8 @@ bool arch_jump_label_transform_queue(str
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type, 0);
-	text_poke_queue((void *)jump_entry_code(entry),
-			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	jlp = __jump_label_patch(entry, type, 0);
+	text_poke_queue((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 	mutex_unlock(&text_mutex);
 	return true;
 }


