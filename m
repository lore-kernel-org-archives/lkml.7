Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97DC17446
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E58221655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zy1aIrre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKKOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfKKOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hR15cx1gQQfqLF615mIdMfcZLwwoT1GBRsMz1InbxbM=; b=Zy1aIrre5VIcYnOdB+IsrxnNmA
        WARMR9XTvuszSpwWb583BoRttglPCjfoIHQwq6JxrBAEbO1ttoxyzdOdsNndCssipukYJfanYeyDN
        +eeC8z3yQNBsD3ICUPyW2k83dBId2yMGACWTfFBO2alrys7bsFJ3GwSVPMvrIFj1fBdl0eNrCQK4i
        Iz5Y/yiCr7D0tsfTJCWcOkidsxR6MMLnAaOm6xomQcrS0zANnY4m/k3HBokR2ZbRygw9PhgxzrCGL
        FxsvBhfq6pMMZsAY8fXhYJ5QeaiH5ydyz7Z3LA4XtI307JG18CUcLVxMn+urzKHuR9VLRiVgdTo3T
        rjM/dx9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyB-0006a4-KY; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C0683060B4;
        Mon, 11 Nov 2019 15:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7606029980EFB; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132457.646280715@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:12:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 03/17] x86/alternatives,jump_label: Provide better text_poke() batching interface
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding another text_poke_bp_batch() user made me realize the interface
is all sorts of wrong. The text poke vector should be internal to the
implementation.

This then results in a trivial interface:

  text_poke_queue()  - which has the 'normal' text_poke_bp() interface
  text_poke_finish() - which takes no arguments and flushes any
                       pending text_poke()s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/include/asm/text-patching.h |   15 +----
 arch/x86/kernel/alternative.c        |   64 ++++++++++++++++++++--
 arch/x86/kernel/jump_label.c         |   99 ++++++++++++-----------------------
 3 files changed, 96 insertions(+), 82 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -25,14 +25,6 @@ static inline void apply_paravirt(struct
  */
 #define POKE_MAX_OPCODE_SIZE	5
 
-struct text_poke_loc {
-	void *addr;
-	int len;
-	s32 rel32;
-	u8 opcode;
-	const u8 text[POKE_MAX_OPCODE_SIZE];
-};
-
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
@@ -53,9 +45,10 @@ extern void *text_poke(void *addr, const
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
-extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
-extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-			       const void *opcode, size_t len, const void *emulate);
+
+extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
+extern void text_poke_finish(void);
+
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,6 +936,14 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+struct text_poke_loc {
+	void *addr;
+	int len;
+	s32 rel32;
+	u8 opcode;
+	const u8 text[POKE_MAX_OPCODE_SIZE];
+};
+
 static struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
@@ -1023,6 +1031,10 @@ int poke_int3_handler(struct pt_regs *re
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
+static struct text_poke_loc tp_vec[TP_VEC_MAX];
+static int tp_vec_nr;
+
 /**
  * text_poke_bp_batch() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
@@ -1044,7 +1056,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *		  replacing opcode
  *	- sync cores
  */
-void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
+static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -1118,11 +1130,7 @@ void text_poke_loc_init(struct text_poke
 {
 	struct insn insn;
 
-	if (!opcode)
-		opcode = (void *)tp->text;
-	else
-		memcpy((void *)tp->text, opcode, len);
-
+	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;
 
@@ -1167,6 +1175,50 @@ void text_poke_loc_init(struct text_poke
 	}
 }
 
+/*
+ * We hard rely on the tp_vec being ordered; ensure this is so by flushing
+ * early if needed.
+ */
+static bool tp_order_fail(void *addr)
+{
+	struct text_poke_loc *tp;
+
+	if (!tp_vec_nr)
+		return false;
+
+	if (!addr) /* force */
+		return true;
+
+	tp = &tp_vec[tp_vec_nr - 1];
+	if ((unsigned long)tp->addr > (unsigned long)addr)
+		return true;
+
+	return false;
+}
+
+static void text_poke_flush(void *addr)
+{
+	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
+		text_poke_bp_batch(tp_vec, tp_vec_nr);
+		tp_vec_nr = 0;
+	}
+}
+
+void text_poke_finish(void)
+{
+	text_poke_flush(NULL);
+}
+
+void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
+{
+	struct text_poke_loc *tp;
+
+	text_poke_flush(addr);
+
+	tp = &tp_vec[tp_vec_nr++];
+	text_poke_loc_init(tp, addr, opcode, len, emulate);
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, in
 	BUG();
 }
 
-static void __jump_label_set_jump_code(struct jump_entry *entry,
-				       enum jump_label_type type,
-				       union jump_code_union *code,
-				       int init)
+static const void *
+__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
+	static union jump_code_union code; /* relies on text_mutex */
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect;
 	int line;
 
-	code->jump = 0xe9;
-	code->offset = jump_entry_target(entry) -
+	lockdep_assert_held(&text_mutex);
+
+	code.jump = JMP32_INSN_OPCODE;
+	code.offset = jump_entry_target(entry) -
 		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (init) {
@@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(s
 	} else if (type == JUMP_LABEL_JMP) {
 		expect = ideal_nop; line = __LINE__;
 	} else {
-		expect = code->code; line = __LINE__;
+		expect = code.code; line = __LINE__;
 	}
 
 	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
 		bug_at((void *)jump_entry_code(entry), line);
 
 	if (type == JUMP_LABEL_NOP)
-		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+
+	return &code;
 }
 
-static void __ref __jump_label_transform(struct jump_entry *entry,
-					 enum jump_label_type type,
-					 int init)
+static void inline __jump_label_transform(struct jump_entry *entry,
+					  enum jump_label_type type,
+					  int init)
 {
-	union jump_code_union code;
-
-	__jump_label_set_jump_code(entry, type, &code, init);
+	const void *opcode = __jump_label_set_jump_code(entry, type, init);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -84,31 +85,33 @@ static void __ref __jump_label_transform
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), &code,
+		text_poke_early((void *)jump_entry_code(entry), opcode,
 				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
 }
 
-void arch_jump_label_transform(struct jump_entry *entry,
-			       enum jump_label_type type)
+static void __ref jump_label_transform(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       int init)
 {
 	mutex_lock(&text_mutex);
-	__jump_label_transform(entry, type, 0);
+	__jump_label_transform(entry, type, init);
 	mutex_unlock(&text_mutex);
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
-static struct text_poke_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	jump_label_transform(entry, type, 0);
+}
 
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	struct text_poke_loc *tp;
-	void *entry_code;
+	const void *opcode;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -118,53 +121,19 @@ bool arch_jump_label_transform_queue(str
 		return true;
 	}
 
-	/*
-	 * No more space in the vector, tell upper layer to apply
-	 * the queue before continuing.
-	 */
-	if (tp_vec_nr == TP_VEC_MAX)
-		return false;
-
-	tp = &tp_vec[tp_vec_nr];
-
-	entry_code = (void *)jump_entry_code(entry);
-
-	/*
-	 * The INT3 handler will do a bsearch in the queue, so we need entries
-	 * to be sorted. We can survive an unsorted list by rejecting the entry,
-	 * forcing the generic jump_label code to apply the queue. Warning once,
-	 * to raise the attention to the case of an unsorted entry that is
-	 * better not happen, because, in the worst case we will perform in the
-	 * same way as we do without batching - with some more overhead.
-	 */
-	if (tp_vec_nr > 0) {
-		int prev = tp_vec_nr - 1;
-		struct text_poke_loc *prev_tp = &tp_vec[prev];
-
-		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
-			return false;
-	}
-
-	__jump_label_set_jump_code(entry, type,
-				   (union jump_code_union *)&tp->text, 0);
-
-	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
-
-	tp_vec_nr++;
-
+	mutex_lock(&text_mutex);
+	opcode = __jump_label_set_jump_code(entry, type, 0);
+	text_poke_queue((void *)jump_entry_code(entry),
+			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	mutex_unlock(&text_mutex);
 	return true;
 }
 
 void arch_jump_label_transform_apply(void)
 {
-	if (!tp_vec_nr)
-		return;
-
 	mutex_lock(&text_mutex);
-	text_poke_bp_batch(tp_vec, tp_vec_nr);
+	text_poke_finish();
 	mutex_unlock(&text_mutex);
-
-	tp_vec_nr = 0;
 }
 
 static enum {
@@ -193,5 +162,5 @@ __init_or_module void arch_jump_label_tr
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, 1);
+		jump_label_transform(entry, type, 1);
 }


