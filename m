Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C12207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLDIeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56452 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfLDIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:34:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6T-0005Na-Ct; Wed, 04 Dec 2019 09:33:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B84471C265E;
        Wed,  4 Dec 2019 09:33:37 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternatives, jump_label: Provide better
 text_poke() batching interface
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132457.646280715@infradead.org>
References: <20191111132457.646280715@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841762.21853.1501350726294283123.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     18cbc8bed0c70795d2064217c89894e28eafdf04
Gitweb:        https://git.kernel.org/tip/18cbc8bed0c70795d2064217c89894e28eafdf04
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 26 Aug 2019 13:38:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/alternatives, jump_label: Provide better text_poke() batching interface

Adding another text_poke_bp_batch() user made me realize the interface
is all sorts of wrong. The text poke vector should be internal to the
implementation.

This then results in a trivial interface:

  text_poke_queue()  - which has the 'normal' text_poke_bp() interface
  text_poke_finish() - which takes no arguments and flushes any
                       pending text_poke()s.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.646280715@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  15 +---
 arch/x86/kernel/alternative.c        |  64 +++++++++++++++--
 arch/x86/kernel/jump_label.c         |  99 ++++++++------------------
 3 files changed, 96 insertions(+), 82 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index ea91049..3bcd266 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -25,14 +25,6 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
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
@@ -53,9 +45,10 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ec463f..42e7f0a 100644
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
@@ -1023,6 +1031,10 @@ int poke_int3_handler(struct pt_regs *regs)
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
@@ -1118,11 +1130,7 @@ void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
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
 
@@ -1167,6 +1175,50 @@ void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
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
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index c1a8b9e..cf8c847 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, int line)
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
@@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(struct jump_entry *entry,
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
@@ -84,31 +85,33 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
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
@@ -118,53 +121,19 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
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
@@ -193,5 +162,5 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, 1);
+		jump_label_transform(entry, type, 1);
 }
