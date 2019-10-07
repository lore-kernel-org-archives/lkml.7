Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B4C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3A21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fGuXWJGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJGLYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfJGLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PHs/oFo3plFXxbQavWXUoMNa5Ezi2fwzEJWXbs93ioY=; b=fGuXWJGK8dLkVHKJ8unmoO2JGz
        H8Zg4WkBVt7RfcYYtu5+niRb5wxGOJay29/rAu1dFnnFTRXKj+XkwRkgUumglNY43LQKtvHD1J1Yv
        gb5HOOVCuMOxiXdi+dC4BKuYMGYdBor/B+SvOj7iUPo0D5wPYnBP02Z7OZnlKxZ+ftJXD05rWTbv4
        tfTTN3jZBX+xflf6RQOklqw6AVKrs+A9kuYCfBRFbiRygVoNCZ/jxXLte5YNHXaJArTeiVUOy/0J8
        DVb6z0BHCml2qTGumJTf+tAkdjsQ491WSSDZQ9hWGsoqGkU3inGge5luubIN7AT6yWJqCpvCTastO
        YpldqEyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0002B4-3s; Mon, 07 Oct 2019 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 848D7301B59;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6AF9520245760; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081944.88332264.2@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate instructions
References: <20191007081716.07616230.8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for static_call and variable size jump_label support,
teach text_poke_bp() to emulate instructions, namely:

  JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5, INT3

The current text_poke_bp() takes a @handler argument which is used as
a jump target when the temporary INT3 is hit by a different CPU.

When patching CALL instructions, this doesn't work because we'd miss
the PUSH of the return address. Instead, teach poke_int3_handler() to
emulate an instruction, typically the instruction we're patching in.

This fits almost all text_poke_bp() users, except
arch_unoptimize_kprobe() which restores random text, and for that site
we have to build an explicit emulate instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 arch/x86/include/asm/text-patching.h |   24 ++++--
 arch/x86/kernel/alternative.c        |  132 ++++++++++++++++++++++++++---------
 arch/x86/kernel/jump_label.c         |    9 --
 arch/x86/kernel/kprobes/opt.c        |   11 ++
 4 files changed, 130 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -26,10 +26,11 @@ static inline void apply_paravirt(struct
 #define POKE_MAX_OPCODE_SIZE	5
 
 struct text_poke_loc {
-	void *detour;
 	void *addr;
-	size_t len;
-	const char opcode[POKE_MAX_OPCODE_SIZE];
+	int len;
+	s32 rel32;
+	u8 opcode;
+	const char text[POKE_MAX_OPCODE_SIZE];
 };
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -51,8 +52,10 @@ extern void text_poke_early(void *addr,
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
+extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+			       const void *opcode, size_t len, const void *emulate);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
@@ -63,8 +66,17 @@ static inline void int3_emulate_jmp(stru
 	regs->ip = ip;
 }
 
-#define INT3_INSN_SIZE 1
-#define CALL_INSN_SIZE 5
+#define INT3_INSN_SIZE		1
+#define INT3_INSN_OPCODE	0xCC
+
+#define CALL_INSN_SIZE		5
+#define CALL_INSN_OPCODE	0xE8
+
+#define JMP32_INSN_SIZE		5
+#define JMP32_INSN_OPCODE	0xE9
+
+#define JMP8_INSN_SIZE		2
+#define JMP8_INSN_OPCODE	0xEB
 
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -956,16 +956,15 @@ NOKPROBE_SYMBOL(patch_cmp);
 int poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_loc *tp;
-	unsigned char int3 = 0xcc;
 	void *ip;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching.nr_entries.
 	 *
-	 * 	nr_entries != 0			INT3
-	 * 	WMB				RMB
-	 * 	write INT3			if (nr_entries)
+	 *	nr_entries != 0			INT3
+	 *	WMB				RMB
+	 *	write INT3			if (nr_entries)
 	 *
 	 * Idem for other elements in bp_patching.
 	 */
@@ -978,9 +977,9 @@ int poke_int3_handler(struct pt_regs *re
 		return 0;
 
 	/*
-	 * Discount the sizeof(int3). See text_poke_bp_batch().
+	 * Discount the INT3. See text_poke_bp_batch().
 	 */
-	ip = (void *) regs->ip - sizeof(int3);
+	ip = (void *) regs->ip - INT3_INSN_SIZE;
 
 	/*
 	 * Skip the binary search if there is a single member in the vector.
@@ -997,8 +996,28 @@ int poke_int3_handler(struct pt_regs *re
 			return 0;
 	}
 
-	/* set up the specified breakpoint detour */
-	regs->ip = (unsigned long) tp->detour;
+	ip += tp->len;
+
+	switch (tp->opcode) {
+	case INT3_INSN_OPCODE:
+		/*
+		 * Someone poked an explicit INT3, they'll want to handle it,
+		 * do not consume.
+		 */
+		return 0;
+
+	case CALL_INSN_OPCODE:
+		int3_emulate_call(regs, (long)ip + tp->rel32);
+		break;
+
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		int3_emulate_jmp(regs, (long)ip + tp->rel32);
+		break;
+
+	default:
+		BUG();
+	}
 
 	return 1;
 }
@@ -1014,7 +1033,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  * synchronization using int3 breakpoint.
  *
  * The way it is done:
- * 	- For each entry in the vector:
+ *	- For each entry in the vector:
  *		- add a int3 trap to the address that will be patched
  *	- sync cores
  *	- For each entry in the vector:
@@ -1027,9 +1046,9 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  */
 void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
-	int patched_all_but_first = 0;
-	unsigned char int3 = 0xcc;
+	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
+	int do_sync;
 
 	lockdep_assert_held(&text_mutex);
 
@@ -1053,16 +1072,16 @@ void text_poke_bp_batch(struct text_poke
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
-	for (i = 0; i < nr_entries; i++) {
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		if (tp[i].len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
-				  (const char *)tp[i].opcode + sizeof(int3),
+				  (const char *)tp[i].text + sizeof(int3),
 				  tp[i].len - sizeof(int3));
-			patched_all_but_first++;
+			do_sync++;
 		}
 	}
 
-	if (patched_all_but_first) {
+	if (do_sync) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -1075,10 +1094,17 @@ void text_poke_bp_batch(struct text_poke
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
 	 */
-	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		if (tp[i].text[0] == INT3_INSN_OPCODE)
+			continue;
+
+		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		do_sync++;
+	}
+
+	if (do_sync)
+		on_each_cpu(do_sync_core, NULL, 1);
 
-	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
@@ -1087,6 +1113,60 @@ void text_poke_bp_batch(struct text_poke
 	bp_patching.nr_entries = 0;
 }
 
+void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+			const void *opcode, size_t len, const void *emulate)
+{
+	struct insn insn;
+
+	if (!opcode)
+		opcode = (void *)tp->text;
+	else
+		memcpy((void *)tp->text, opcode, len);
+
+	if (!emulate)
+		emulate = opcode;
+
+	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+
+	BUG_ON(!insn_complete(&insn));
+	BUG_ON(len != insn.length);
+
+	tp->addr = addr;
+	tp->len = len;
+	tp->opcode = insn.opcode.bytes[0];
+
+	switch (tp->opcode) {
+	case INT3_INSN_OPCODE:
+		break;
+
+	case CALL_INSN_OPCODE:
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		tp->rel32 = insn.immediate.value;
+		break;
+
+	default: /* assume NOP */
+		switch (len) {
+		case 2: /* NOP2 -- emulate as JMP8+0 */
+			BUG_ON(memcmp(emulate, ideal_nops[len], len));
+			tp->opcode = JMP8_INSN_OPCODE;
+			tp->rel32 = 0;
+			break;
+
+		case 5: /* NOP5 -- emulate as JMP32+0 */
+			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+			tp->opcode = JMP32_INSN_OPCODE;
+			tp->rel32 = 0;
+			break;
+
+		default: /* unknown instruction */
+			BUG();
+		}
+		break;
+	}
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -1098,20 +1178,10 @@ void text_poke_bp_batch(struct text_poke
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct text_poke_loc tp = {
-		.detour = handler,
-		.addr = addr,
-		.len = len,
-	};
-
-	if (len > POKE_MAX_OPCODE_SIZE) {
-		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
-		return;
-	}
-
-	memcpy((void *)tp.opcode, opcode, len);
+	struct text_poke_loc tp;
 
+	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -89,8 +89,7 @@ static void __ref __jump_label_transform
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
-		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
@@ -147,11 +146,9 @@ bool arch_jump_label_transform_queue(str
 	}
 
 	__jump_label_set_jump_code(entry, type,
-				   (union jump_code_union *) &tp->opcode, 0);
+				   (union jump_code_union *)&tp->text, 0);
 
-	tp->addr = entry_code;
-	tp->detour = entry_code + JUMP_LABEL_NOP_SIZE;
-	tp->len = JUMP_LABEL_NOP_SIZE;
+	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
 
 	tp_vec_nr++;
 
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -437,8 +437,7 @@ void arch_optimize_kprobes(struct list_h
 		insn_buff[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-			     op->optinsn.insn);
+		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE, NULL);
 
 		list_del_init(&op->list);
 	}
@@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 emulate_buff[RELATIVEJUMP_SIZE];
 
 	/* Set int3 to first byte for kprobes */
 	insn_buff[0] = BREAKPOINT_INSTRUCTION;
 	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+
+	emulate_buff[0] = RELATIVEJUMP_OPCODE;
+	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
+			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+
 	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-		     op->optinsn.insn);
+		     emulate_buff);
 }
 
 /*


