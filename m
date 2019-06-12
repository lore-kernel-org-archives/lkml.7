Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267521743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvhj05xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440143AbfFLQCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:02:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfFLQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iRB9bY0yofukCg7ZYWtAaN9VruHEMiFCNrE6quAofSI=; b=nvhj05xE1v2pqc81PRUYQoRhZ
        oNbN14RQM1yoVk+eH2KvfxX8nYW2TNuxGNxsStvAL/epwmO6WzY3dhJxMAPfShGft+vEqJ/5YnpH5
        rp/ISszi/p2RJVUFwVgyr1O6xNQZZswVEQyd/ZHWVTKH9gX86KtkWBXEJ9mXfSDmCrR50DxSviGm/
        XZV3O4XJ317dJtzczaU1w3QOcoR2vAxTvDgeZsd5+LFdFITml4Yd8HvF2aLLg4vQXP0SqDHFAnTKx
        heuDgcc1hLqQ2qb/2eA15fGA+/dRYkLAHo9yX2GFwMoyKITGU5fKN7vAd7GOpTRfHjSm7MbSJzf+N
        ta88K8YRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb5ga-0007YJ-BP; Wed, 12 Jun 2019 16:01:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A73552029B097; Wed, 12 Jun 2019 16:44:43 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190612144443.GM3463@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190611111410.366f4ced@gandalf.local.home>
 <20190611155248.GA3436@hirez.programming.kicks-ass.net>
 <20190611162128.GK3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611162128.GK3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:21:28PM +0200, Peter Zijlstra wrote:
> although at this point I'm
> thinking we should just used the instruction decode we have instead of
> playing iffy games with packed structures.

How's something like this? It accepts jmp/32 jmp/8 call and nop5_atomic.

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
 arch/x86/include/asm/text-patching.h |   15 +++++--
 arch/x86/kernel/alternative.c        |   73 +++++++++++++++++++++++++----------
 arch/x86/kernel/jump_label.c         |    3 -
 arch/x86/kernel/kprobes/opt.c        |   11 +++--
 4 files changed, 75 insertions(+), 27 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -37,7 +37,7 @@ extern void text_poke_early(void *addr,
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
@@ -48,8 +48,17 @@ static inline void int3_emulate_jmp(stru
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
+#define JMP_INSN_SIZE		5
+#define JMP_INSN_OPCODE		0xE9
+
+#define JMP8_INSN_SIZE		2
+#define JMP8_INSN_OPCODE	0xEB
 
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -920,31 +920,45 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
-static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static const void *bp_int3_addr;
+static const struct insn *bp_int3_insn;
 
 int poke_int3_handler(struct pt_regs *regs)
 {
+	long ip;
+
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * bp_patching_in_progress.
-	 *
-	 * 	in_progress = TRUE		INT3
-	 * 	WMB				RMB
-	 * 	write INT3			if (in_progress)
+	 * bp_int3_addr and bp_int3_insn:
 	 *
-	 * Idem for bp_int3_handler.
+	 *	bp_int3_{addr,insn) = ..	INT3
+	 *	WMB				RMB
+	 *	write INT3			if (insn)
 	 */
 	smp_rmb();
 
-	if (likely(!bp_patching_in_progress))
+	if (likely(!bp_int3_insn))
 		return 0;
 
 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	ip = regs->ip - INT3_INSN_SIZE + bp_int3_insn->length;
+
+	switch (bp_int3_insn->opcode.bytes[0]) {
+	case CALL_INSN_OPCODE:
+		int3_emulate_call(regs, ip + bp_int3_insn->immediate.value);
+		break;
+
+	case JMP_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		int3_emulate_jmp(regs, ip + bp_int3_insn->immediate.value);
+		break;
+
+	default: /* assume NOP */
+		int3_emulate_jmp(regs, ip);
+		break;
+	}
 
 	return 1;
 }
@@ -955,7 +969,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * @emulate:	opcode to emulate, when NULL use @opcode
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
@@ -970,19 +984,40 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *	  replacing opcode
  *	- sync cores
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	unsigned char int3 = 0xcc;
+	unsigned char int3 = INT3_INSN_OPCODE;
+	struct insn insn;
 
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
-	bp_patching_in_progress = true;
+	bp_int3_addr = addr + INT3_INSN_SIZE;
 
 	lockdep_assert_held(&text_mutex);
 
+	if (!emulate)
+		emulate = opcode;
+
+	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+
+	BUG_ON(!insn_complete(&insn));
+	BUG_ON(insn.length != len);
+
+	switch (insn.opcode.bytes[0]) {
+	case CALL_INSN_OPCODE:
+	case JMP_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		break;
+
+	default:
+		BUG_ON(len != 5);
+		BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], 5));
+	}
+
+	bp_int3_insn = &insn;
+
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
-	 * in_progress and handler are correctly ordered wrt. patching.
+	 * in_progress and opcode are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
@@ -1011,6 +1046,6 @@ void text_poke_bp(void *addr, const void
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
-	bp_patching_in_progress = false;
+	bp_int3_insn = NULL;
 }
 
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -87,8 +87,7 @@ static void __ref __jump_label_transform
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
-		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE, NULL);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
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
