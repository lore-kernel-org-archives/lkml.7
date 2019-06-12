Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED44C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67C521019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9BX3RTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392092AbfFLRNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:13:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbfFLRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G9BfvvpK3W5i1Ovv5I0mEJOcjlkbTfgu/OcR2XE2wZs=; b=F9BX3RTLWOOl86yRj/sMnI5D3
        AWWTimp4YyHHUtYsJ9yOLBn/0VP9o/gbPWIlxrlSv40NFMO8gzH0YzNlfcmxsRDyexAw/tYApOr7g
        dt2QcskpAvb2wuo0mfGDWepWiVj4AQuz/LI0T1RhnLSw11ur4eYD56YLV/mF8prZ8Nfv/yXf/g8Ot
        01Un2863qDXU6s9OUBmOqtwuJKmx7SQsoDrK+ZCChbZvfZ2fF8SHkM/sDTFCi2X2Ozatox3K//04b
        GHPq6KjQa3EGWnMVCsWloEBsLHfeyesXqWhFJ0mZ5ARxz8VKTFWkcGSVLujiIHkLHwcl7Nlb50u56
        I6w3aaSxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb6nu-0007mf-CC; Wed, 12 Jun 2019 17:12:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DA1A20751BCC; Wed, 12 Jun 2019 19:07:12 +0200 (CEST)
Date:   Wed, 12 Jun 2019 19:07:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V6 0/6] x86/jump_label: Bound IPIs sent when updating a
 static key
Message-ID: <20190612170712.GJ3402@hirez.programming.kicks-ass.net>
References: <cover.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560325897.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:57:25AM +0200, Daniel Bristot de Oliveira wrote:
> Daniel Bristot de Oliveira (6):
>   jump_label: Add a jump_label_can_update() helper
>   x86/jump_label: Add a __jump_label_set_jump_code() helper
>   jump_label: Sort entries of the same key by the code
>   x86/alternative: Batch of patch operations
>   jump_label: Batch updates if arch supports it
>   x86/jump_label: Batch jump label updates
> 
>  arch/x86/include/asm/jump_label.h    |   2 +
>  arch/x86/include/asm/text-patching.h |  15 +++
>  arch/x86/kernel/alternative.c        | 154 +++++++++++++++++++++------
>  arch/x86/kernel/jump_label.c         | 110 ++++++++++++++++---
>  include/linux/jump_label.h           |   3 +
>  kernel/jump_label.c                  |  65 +++++++++--
>  6 files changed, 290 insertions(+), 59 deletions(-)

OK, so I like these. I did make me some change, but mostly cosmetic
(although patch #2 got a bigger shuffle than intended).

I've also done my text_poke_bp() emulation thing on top of this, to make
sure it all works properly. Funnily, that shrank the size of
text_poke_loc to 24 bytes and thus we now fit 170 locations in the one
page.

---
Subject: x86/alternatives: Teach text_poke_bp() to emulate instructions
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jun 5 10:48:37 CEST 2019

In preparation for static_call support, teach text_poke_bp() to
emulate instructions, including CALL.

The current text_poke_bp() takes a @handler argument which is used as
a jump target when the temporary INT3 is hit by a different CPU.

When patching CALL instructions, this doesn't work because we'd miss
the PUSH of the return address. Instead, teach poke_int3_handler() to
emulate an instruction, typically the instruction we're patching in.

This fits almost all text_poke_bp() users, except
arch_unoptimize_kprobe() which restores random text, and for that site
we have to build an explicit emulate instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   24 +++++++--
 arch/x86/kernel/alternative.c        |   88 +++++++++++++++++++++++++----------
 arch/x86/kernel/jump_label.c         |    9 +--
 arch/x86/kernel/kprobes/opt.c        |   11 +++-
 4 files changed, 93 insertions(+), 39 deletions(-)

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
+#define CALL_INSN_OPCODE	0xE9
+
+#define JMP32_INSN_SIZE		5
+#define JMP32_INSN_OPCODE	0xE8
+
+#define JMP8_INSN_SIZE		2
+#define JMP8_INSN_OPCODE	0xEB
 
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -941,16 +941,15 @@ NOKPROBE_SYMBOL(patch_cmp);
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
@@ -963,9 +962,9 @@ int poke_int3_handler(struct pt_regs *re
 		return 0;
 
 	/*
-	 * Discount the sizeof(int3). See text_poke_bp_batch().
+	 * Discount the INT3. See text_poke_bp_batch().
 	 */
-	ip = (void *) regs->ip - sizeof(int3);
+	ip = (void *) regs->ip - INT3_INSN_SIZE;
 
 	/*
 	 * Skip the binary search if there is a single member in the vector.
@@ -982,8 +981,22 @@ int poke_int3_handler(struct pt_regs *re
 			return 0;
 	}
 
-	/* set up the specified breakpoint detour */
-	regs->ip = (unsigned long) tp->detour;
+	ip += tp->len;
+
+	switch (tp->opcode) {
+	case CALL_INSN_OPCODE:
+		int3_emulate_call(regs, (long)ip + tp->rel32);
+		break;
+
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		int3_emulate_jmp(regs, (long)ip + tp->rel32);
+		break;
+
+	default: /* nop */
+		int3_emulate_jmp(regs, (long)ip);
+		break;
+	}
 
 	return 1;
 }
@@ -1012,8 +1025,8 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  */
 void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
+	unsigned char int3 = INT3_INSN_OPCODE;
 	int patched_all_but_first = 0;
-	unsigned char int3 = 0xcc;
 	unsigned int i;
 
 	lockdep_assert_held(&text_mutex);
@@ -1041,7 +1054,7 @@ void text_poke_bp_batch(struct text_poke
 	for (i = 0; i < nr_entries; i++) {
 		if (tp[i].len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
-				  (const char *)tp[i].opcode + sizeof(int3),
+				  (const char *)tp[i].text + sizeof(int3),
 				  tp[i].len - sizeof(int3));
 			patched_all_but_first++;
 		}
@@ -1061,7 +1074,7 @@ void text_poke_bp_batch(struct text_poke
 	 * replacing opcode.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
+		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
@@ -1072,6 +1085,43 @@ void text_poke_bp_batch(struct text_poke
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
+	case CALL_INSN_OPCODE:
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		tp->rel32 = insn.immediate.value;
+		break;
+
+	default:
+		BUG_ON(len != 5);
+		BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+		break;
+	}
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -1083,20 +1133,10 @@ void text_poke_bp_batch(struct text_poke
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
