Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE532173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dX/Gy4VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJGLYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p7FjJgNnn5OHwOtLaq4hzXDgz/DsvNHQdr7hvgpnAVk=; b=dX/Gy4VIQsm7LD32qRGElJCioy
        cQRQqUUJIYBB2np19fm+Habaj8jx6bBs5Lemse5hIv+D+tGzlcboMRYH2J9OmM3lHE//Au0KV6nnL
        WddgAH2qQDOvHhwd7LLe2rrpqMJOV0MhSOUH8YpJyKi4c9lo2bg6EmW/H9I1vCcmmO3H3Zr3bG/VJ
        L9SrTdPsR1Nc/dqkJ6XpoyhvHnrBu3EhJBvTJAXaW+ZS+8w+T2wspPDPSIe51Aa7BZaZ3giax93MN
        HLQb9GEyWCN/gDH4fvg6JOdCuNwIbllADh0hm6a3vHnEIZW6aJwm9MY/73o8aTNl5jOHEvxlB5BPq
        +PMzDpXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0002B5-4Q; Mon, 07 Oct 2019 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD4443060E4;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7861220244F8D; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081945.05309765.9@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 4/6] x86/alternatives: Add and use text_gen_insn() helper
References: <20191007081716.07616230.8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple helper function to create common instruction
encodings.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/text-patching.h |    2 +
 arch/x86/kernel/alternative.c        |   36 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/jump_label.c         |   31 ++++++++++--------------------
 arch/x86/kernel/kprobes/opt.c        |    7 ------
 4 files changed, 50 insertions(+), 26 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -49,6 +49,8 @@ extern void text_poke_bp(void *addr, con
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
+extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1237,3 +1237,39 @@ void text_poke_bp(void *addr, const void
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
+
+union text_poke_insn {
+	u8 text[POKE_MAX_OPCODE_SIZE];
+	struct {
+		u8 opcode;
+		s32 disp;
+	} __attribute__((packed));
+};
+
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* text_mutex */
+	int size = 0;
+
+	lockdep_assert_held(&text_mutex);
+
+	insn.opcode = opcode;
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
+	if (size > 1) {
+		insn.disp = (long)dest - (long)(addr + size);
+		if (size == 2)
+			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+	}
+
+	return &insn.text;
+}
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,15 +16,7 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-union jump_code_union {
-	char code[JUMP_LABEL_NOP_SIZE];
-	struct {
-		char jump;
-		int offset;
-	} __attribute__((packed));
-};
-
-static void bug_at(unsigned char *ip, int line)
+static void bug_at(const void *ip, int line)
 {
 	/*
 	 * The location is not an op that we were expecting.
@@ -38,33 +30,32 @@ static void bug_at(unsigned char *ip, in
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
-	static union jump_code_union code; /* relies on text_mutex */
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect;
+	const void *expect, *code;
+	const void *addr, *dest;
 	int line;
 
-	lockdep_assert_held(&text_mutex);
+	addr = (void *)jump_entry_code(entry);
+	dest = (void *)jump_entry_target(entry);
 
-	code.jump = JMP32_INSN_OPCODE;
-	code.offset = jump_entry_target(entry) -
-		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
 		expect = ideal_nop; line = __LINE__;
 	} else {
-		expect = code.code; line = __LINE__;
+		expect = code; line = __LINE__;
 	}
 
-	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
-		bug_at((void *)jump_entry_code(entry), line);
+	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
+		bug_at(addr, line);
 
 	if (type == JUMP_LABEL_NOP)
-		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+		code = ideal_nop;
 
-	return &code;
+	return code;
 }
 
 static void inline __jump_label_transform(struct jump_entry *entry,
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -447,18 +447,13 @@ void arch_optimize_kprobes(struct list_h
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	u8 insn_buff[RELATIVEJUMP_SIZE];
-	u8 emulate_buff[RELATIVEJUMP_SIZE];
 
 	/* Set int3 to first byte for kprobes */
 	insn_buff[0] = BREAKPOINT_INSTRUCTION;
 	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
 
-	emulate_buff[0] = RELATIVEJUMP_OPCODE;
-	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
-			((long)op->kp.addr + RELATIVEJUMP_SIZE));
-
 	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-		     emulate_buff);
+		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
 }
 
 /*


