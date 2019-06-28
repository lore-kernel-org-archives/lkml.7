Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537DEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F0B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWn2FVCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF1NgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1NgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZMJ2WTuR/Pb+R47RoDQvzzTFX7GwJS550UQrwh39ark=; b=GWn2FVCas6PrLzyvHfQ2w63zzf
        PaZ1MNp0nIGROWlEzI1+bGDcQYPY4k1hY+WJA0oA9PnReItGuGUwKXuAWbeHi9lr+FQTOo4kFOLfZ
        mN4UeuXGB8P+sDAYk9EFPenuh3Iz7WcHpa4qg6+wTM44Qt3ZtY2zypdhHCoj5VdJzwo4GPnwuJCH2
        4m0St+ZhVs7m3xtE6RVoJ+BKpksciSeU0F5e9e30PKUiPpXvfvUsx+GmSW4sb2Ea3nemwUtPuyf0p
        u4bqNhMSrsI9Z4fDLxanKkjB915WSwinYI/ZkEy8x4fPfKqty3TFIc+0lVLfy/hD5K/xlbhmqHyhX
        C46ddWmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2s-0000nE-Cf; Fri, 28 Jun 2019 13:36:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 91E9B20AB8993; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.773901511@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:19 +0200
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
Subject: [RFC][PATCH 6/8] jump_label, x86: Add variable length patching support
References: <20190628102113.360432762@infradead.org>
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
 arch/x86/include/asm/jump_label.h |    6 +-
 arch/x86/include/asm/nops.h       |    1 
 arch/x86/kernel/jump_label.c      |   77 +++++++++++++++++++++++---------------
 3 files changed, 53 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -7,9 +7,11 @@
 #define JUMP_LABEL_NOP_SIZE 5
 
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
@@ -17,49 +17,67 @@
 #include <asm/text-patching.h>
 
 union jump_code_union {
-	char code[JUMP_LABEL_NOP_SIZE];
+	char code[JMP32_INSN_SIZE];
 	struct {
-		char jump;
-		int offset;
+		char opcode;
+		union {
+			s8	d8;
+			s32	d32;
+		};
 	} __attribute__((packed));
 };
 
-static void __jump_label_set_jump_code(struct jump_entry *entry,
-				       enum jump_label_type type,
-				       union jump_code_union *code,
-				       int init)
+static inline bool __jump_disp_is_byte(s32 disp)
 {
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	unsigned char *ip = (void *)jump_entry_code(entry);
+	return false;
+}
+
+static int __jump_label_set_jump_code(struct jump_entry *entry,
+				      enum jump_label_type type,
+				      union jump_code_union *code,
+				      int init)
+{
+	static unsigned char default_nop2[] = { STATIC_KEY_NOP2 };
+	static unsigned char default_nop5[] = { STATIC_KEY_NOP5 };
+	s32 disp = jump_entry_target(entry) - jump_entry_code(entry);
+	void *ip = (void *)jump_entry_code(entry);
+	const unsigned char *nop;
 	const void *expect;
-	int line;
+	int line, size;
 
-	code->jump = 0xe9;
-	code->offset = jump_entry_target(entry) -
-		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
-
-	if (init) {
-		expect = default_nop; line = __LINE__;
-	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
+	if (__jump_disp_is_byte(disp)) {
+		size = JMP8_INSN_SIZE;
+		code->opcode = JMP8_INSN_OPCODE;
+		code->d8 = disp - size;
+		nop = init ? default_nop2 : ideal_nops[2];
+	} else {
+		size = JMP32_INSN_SIZE;
+		code->opcode = JMP32_INSN_OPCODE;
+		code->d32 = disp - size;
+		nop = init ? default_nop5 : ideal_nops[NOP_ATOMIC5];
+	}
+
+	if (init || type == JUMP_LABEL_JMP) {
+		expect = nop; line = __LINE__;
 	} else {
 		expect = code->code; line = __LINE__;
 	}
 
-	if (memcmp(ip, expect, JUMP_LABEL_NOP_SIZE)) {
+	if (memcmp(ip, expect, size)) {
 		/*
 		 * The location is not an op that we were expecting.
 		 * Something went wrong. Crash the box, as something could be
 		 * corrupting the kernel.
 		 */
-		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d type:%d\n",
-				ip, ip, ip, expect, line, init, type);
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) line:%d init:%d size:%d type:%d\n",
+			ip, ip, ip, expect, line, init, size, type);
 		BUG();
 	}
 
 	if (type == JUMP_LABEL_NOP)
-		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+		memcpy(code, nop, size);
+
+	return size;
 }
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
@@ -67,8 +85,9 @@ static void __ref __jump_label_transform
 					 int init)
 {
 	union jump_code_union code;
+	int size;
 
-	__jump_label_set_jump_code(entry, type, &code, init);
+	size = __jump_label_set_jump_code(entry, type, &code, init);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -82,12 +101,11 @@ static void __ref __jump_label_transform
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), &code,
-				JUMP_LABEL_NOP_SIZE);
+		text_poke_early((void *)jump_entry_code(entry), &code, size);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), &code, size, NULL);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
@@ -107,6 +125,7 @@ bool arch_jump_label_transform_queue(str
 {
 	struct text_poke_loc *tp;
 	void *entry_code;
+	int size;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -143,10 +162,10 @@ bool arch_jump_label_transform_queue(str
 			return false;
 	}
 
-	__jump_label_set_jump_code(entry, type,
+	size = __jump_label_set_jump_code(entry, type,
 				   (union jump_code_union *)&tp->text, 0);
 
-	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_loc_init(tp, entry_code, NULL, size, NULL);
 
 	tp_vec_nr++;
 


