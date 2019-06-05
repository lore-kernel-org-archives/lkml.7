Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCBC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E53020872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKS2Okpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfFENXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfFENXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8x3gGSrMTszEyeuuObzdSDHeiglefgxadgIzng9uQ5U=; b=mKS2OkpjTJ2MGrRQnPp42D80Tt
        aPls5KhUcTdbI/yXGyJUBClBXvcE7vp3FUu88CyHR8nY9yE0Q5evgaYSQkqVYZ+3hH6HgwALgu4Ss
        EtPuPLOigetdt/nfej0joUEoLdPe3yLS01lUsmZcm5fD9C/NNRLwjxc3d0xcu2eC2Eqfv9RnKapLU
        LHIK8Fiukuf7y5brqJhp848oXY0qzHsvrWqDc+N0SRJY12LGdcFHIXMPAe9CZOWwwxCGr7YLzAnul
        uoBSHAv+LIPzrJcf4KLWBmft5+ZTtaH7XTx3JHh+M9j3eCn1/RTcujpq45L0AWz3cf4EKfbp3/hFD
        SJAmlWhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0006rS-2e; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8CE692075075B; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.005681046@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate instructions
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Nadav Amit <namit@vmware.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    2 -
 arch/x86/kernel/alternative.c        |   47 ++++++++++++++++++++++++++---------
 arch/x86/kernel/jump_label.c         |    3 --
 arch/x86/kernel/kprobes/opt.c        |   11 +++++---
 4 files changed, 46 insertions(+), 17 deletions(-)

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
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -921,19 +921,25 @@ static void do_sync_core(void *info)
 }
 
 static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static const void *bp_int3_opcode, *bp_int3_addr;
 
 int poke_int3_handler(struct pt_regs *regs)
 {
+	long ip = regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE;
+	struct opcode {
+		u8 insn;
+		s32 rel;
+	} __packed opcode;
+
 	/*
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching_in_progress.
 	 *
-	 * 	in_progress = TRUE		INT3
-	 * 	WMB				RMB
-	 * 	write INT3			if (in_progress)
+	 *	in_progress = TRUE		INT3
+	 *	WMB				RMB
+	 *	write INT3			if (in_progress)
 	 *
-	 * Idem for bp_int3_handler.
+	 * Idem for bp_int3_opcode.
 	 */
 	smp_rmb();
 
@@ -943,8 +949,21 @@ int poke_int3_handler(struct pt_regs *re
 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	opcode = *(struct opcode *)bp_int3_opcode;
+
+	switch (opcode.insn) {
+	case 0xE8: /* CALL */
+		int3_emulate_call(regs, ip + opcode.rel);
+		break;
+
+	case 0xE9: /* JMP */
+		int3_emulate_jmp(regs, ip + opcode.rel);
+		break;
+
+	default: /* assume NOP */
+		int3_emulate_jmp(regs, ip);
+		break;
+	}
 
 	return 1;
 }
@@ -955,7 +974,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * @emulate:	opcode to emulate, when NULL use @opcode
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
@@ -970,19 +989,25 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  *	  replacing opcode
  *	- sync cores
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	unsigned char int3 = 0xcc;
 
-	bp_int3_handler = handler;
+	bp_int3_opcode = emulate ?: opcode;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	bp_patching_in_progress = true;
 
 	lockdep_assert_held(&text_mutex);
 
 	/*
+	 * poke_int3_handler() relies on @opcode being a 5 byte instruction;
+	 * notably a JMP, CALL or NOP5_ATOMIC.
+	 */
+	BUG_ON(len != 5);
+
+	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
-	 * in_progress and handler are correctly ordered wrt. patching.
+	 * in_progress and opcode are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
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


