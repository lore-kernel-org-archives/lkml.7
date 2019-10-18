Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE6CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3FF21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EDCNuvHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504951AbfJRHwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:52:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504745AbfJRHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3LfbnDcdc8lo8OHURkGWYg56v17qiJWB5/jbfbyNytM=; b=EDCNuvHJdlmtBGSmWLQ5MD1aUa
        6hW5idPhf97DK86u0/hrHxNdDJHLAi9Z2Eb0EQlQH/D5Kw9JGw1X84GPicbe6ExGGgAXcAWxWNavL
        6PNTiPy1XNQLyyhOWlAj976Q3vZHoC4bOrxT/gXlzscGe1QVVisjPuYjkpFgYhteRlIO8jLqxapJz
        wSo+xCKcAA5FwyEFhmm+P/zUP4N3MNF6+NPeziXgaye2H4BpO1funTkcS92cHRjjF1vPxdNHnJ1gj
        lB5ZMsYyfi0eERz2jySOnOQVAecgckPew1LJ5OGgba4ORUMQ/mfQwkZFJAod2qjgpQPmxhN/Mg56R
        zgL8TfWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2e-0001QE-81; Fri, 18 Oct 2019 07:51:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ADEE306BBB;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 592CC2B178117; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.571994469@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 11/16] x86/kprobes: Convert to text-patching.h
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kprobes to the new text-poke naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/kprobes.h       |   14 +++--------
 arch/x86/include/asm/text-patching.h |    2 +
 arch/x86/kernel/kprobes/core.c       |   18 +++++++-------
 arch/x86/kernel/kprobes/opt.c        |   44 ++++++++++++++++-------------------
 4 files changed, 37 insertions(+), 41 deletions(-)

--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -11,12 +11,11 @@
 
 #include <asm-generic/kprobes.h>
 
-#define BREAKPOINT_INSTRUCTION	0xcc
-
 #ifdef CONFIG_KPROBES
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
+#include <asm/text-patching.h>
 #include <asm/insn.h>
 
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
@@ -25,10 +24,7 @@ struct pt_regs;
 struct kprobe;
 
 typedef u8 kprobe_opcode_t;
-#define RELATIVEJUMP_OPCODE 0xe9
-#define RELATIVEJUMP_SIZE 5
-#define RELATIVECALL_OPCODE 0xe8
-#define RELATIVE_ADDR_SIZE 4
+
 #define MAX_STACK_SIZE 64
 #define CUR_STACK_SIZE(ADDR) \
 	(current_top_of_stack() - (unsigned long)(ADDR))
@@ -43,11 +39,11 @@ extern __visible kprobe_opcode_t optprob
 extern __visible kprobe_opcode_t optprobe_template_val[];
 extern __visible kprobe_opcode_t optprobe_template_call[];
 extern __visible kprobe_opcode_t optprobe_template_end[];
-#define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + RELATIVE_ADDR_SIZE)
+#define MAX_OPTIMIZED_LENGTH (MAX_INSN_SIZE + DISP32_SIZE)
 #define MAX_OPTINSN_SIZE 				\
 	(((unsigned long)optprobe_template_end -	\
 	  (unsigned long)optprobe_template_entry) +	\
-	 MAX_OPTIMIZED_LENGTH + RELATIVEJUMP_SIZE)
+	 MAX_OPTIMIZED_LENGTH + JMP32_INSN_SIZE)
 
 extern const int kretprobe_blacklist_size;
 
@@ -73,7 +69,7 @@ struct arch_specific_insn {
 
 struct arch_optimized_insn {
 	/* copy of the original instructions */
-	kprobe_opcode_t copied_insn[RELATIVE_ADDR_SIZE];
+	kprobe_opcode_t copied_insn[DISP32_SIZE];
 	/* detour code buffer */
 	kprobe_opcode_t *insn;
 	/* the size of instructions copied to detour code buffer */
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -61,6 +61,8 @@ extern void text_poke_finish(void);
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+#define DISP32_SIZE		4
+
 static inline int text_opcode_size(u8 opcode)
 {
 	int size = 0;
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -119,14 +119,14 @@ __synthesize_relative_insn(void *dest, v
 /* Insert a jump instruction at address 'from', which jumps to address 'to'.*/
 void synthesize_reljump(void *dest, void *from, void *to)
 {
-	__synthesize_relative_insn(dest, from, to, RELATIVEJUMP_OPCODE);
+	__synthesize_relative_insn(dest, from, to, JMP32_INSN_OPCODE);
 }
 NOKPROBE_SYMBOL(synthesize_reljump);
 
 /* Insert a call instruction at address 'from', which calls address 'to'.*/
 void synthesize_relcall(void *dest, void *from, void *to)
 {
-	__synthesize_relative_insn(dest, from, to, RELATIVECALL_OPCODE);
+	__synthesize_relative_insn(dest, from, to, CALL_INSN_OPCODE);
 }
 NOKPROBE_SYMBOL(synthesize_relcall);
 
@@ -301,7 +301,7 @@ static int can_probe(unsigned long paddr
 		 * Another debugging subsystem might insert this breakpoint.
 		 * In that case, we can't recover it.
 		 */
-		if (insn.opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
 			return 0;
 		addr += insn.length;
 	}
@@ -352,7 +352,7 @@ int __copy_instruction(u8 *dest, u8 *src
 	insn_get_length(insn);
 
 	/* Another subsystem puts a breakpoint, failed to recover */
-	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+	if (insn->opcode.bytes[0] == INT3_INSN_OPCODE)
 		return 0;
 
 	/* We should not singlestep on the exception masking instructions */
@@ -396,14 +396,14 @@ static int prepare_boost(kprobe_opcode_t
 	int len = insn->length;
 
 	if (can_boost(insn, p->addr) &&
-	    MAX_INSN_SIZE - len >= RELATIVEJUMP_SIZE) {
+	    MAX_INSN_SIZE - len >= JMP32_INSN_SIZE) {
 		/*
 		 * These instructions can be executed directly if it
 		 * jumps back to correct address.
 		 */
 		synthesize_reljump(buf + len, p->ainsn.insn + len,
 				   p->addr + insn->length);
-		len += RELATIVEJUMP_SIZE;
+		len += JMP32_INSN_SIZE;
 		p->ainsn.boostable = true;
 	} else {
 		p->ainsn.boostable = false;
@@ -497,7 +497,7 @@ int arch_prepare_kprobe(struct kprobe *p
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	text_poke(p->addr, ((unsigned char []){BREAKPOINT_INSTRUCTION}), 1);
+	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
 }
 
 void arch_disarm_kprobe(struct kprobe *p)
@@ -605,7 +605,7 @@ static void setup_singlestep(struct kpro
 	regs->flags |= X86_EFLAGS_TF;
 	regs->flags &= ~X86_EFLAGS_IF;
 	/* single step inline if the instruction is an int3 */
-	if (p->opcode == BREAKPOINT_INSTRUCTION)
+	if (p->opcode == INT3_INSN_OPCODE)
 		regs->ip = (unsigned long)p->addr;
 	else
 		regs->ip = (unsigned long)p->ainsn.insn;
@@ -691,7 +691,7 @@ int kprobe_int3_handler(struct pt_regs *
 				reset_current_kprobe();
 			return 1;
 		}
-	} else if (*addr != BREAKPOINT_INSTRUCTION) {
+	} else if (*addr != INT3_INSN_OPCODE) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -38,7 +38,7 @@ unsigned long __recover_optprobed_insn(k
 	long offs;
 	int i;
 
-	for (i = 0; i < RELATIVEJUMP_SIZE; i++) {
+	for (i = 0; i < JMP32_INSN_SIZE; i++) {
 		kp = get_kprobe((void *)addr - i);
 		/* This function only handles jump-optimized kprobe */
 		if (kp && kprobe_optimized(kp)) {
@@ -62,10 +62,10 @@ unsigned long __recover_optprobed_insn(k
 
 	if (addr == (unsigned long)kp->addr) {
 		buf[0] = kp->opcode;
-		memcpy(buf + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+		memcpy(buf + 1, op->optinsn.copied_insn, DISP32_SIZE);
 	} else {
 		offs = addr - (unsigned long)kp->addr - 1;
-		memcpy(buf, op->optinsn.copied_insn + offs, RELATIVE_ADDR_SIZE - offs);
+		memcpy(buf, op->optinsn.copied_insn + offs, DISP32_SIZE - offs);
 	}
 
 	return (unsigned long)buf;
@@ -141,8 +141,6 @@ STACK_FRAME_NON_STANDARD(optprobe_templa
 #define TMPL_END_IDX \
 	((long)optprobe_template_end - (long)optprobe_template_entry)
 
-#define INT3_SIZE sizeof(kprobe_opcode_t)
-
 /* Optimized kprobe call back function: called from optinsn */
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
@@ -162,7 +160,7 @@ optimized_callback(struct optimized_kpro
 		regs->cs |= get_kernel_rpl();
 		regs->gs = 0;
 #endif
-		regs->ip = (unsigned long)op->kp.addr + INT3_SIZE;
+		regs->ip = (unsigned long)op->kp.addr + INT3_INSN_SIZE;
 		regs->orig_ax = ~0UL;
 
 		__this_cpu_write(current_kprobe, &op->kp);
@@ -179,7 +177,7 @@ static int copy_optimized_instructions(u
 	struct insn insn;
 	int len = 0, ret;
 
-	while (len < RELATIVEJUMP_SIZE) {
+	while (len < JMP32_INSN_SIZE) {
 		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
@@ -271,7 +269,7 @@ static int can_optimize(unsigned long pa
 		return 0;
 
 	/* Check there is enough space for a relative jump. */
-	if (size - offset < RELATIVEJUMP_SIZE)
+	if (size - offset < JMP32_INSN_SIZE)
 		return 0;
 
 	/* Decode instructions */
@@ -290,15 +288,15 @@ static int can_optimize(unsigned long pa
 		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
 		insn_get_length(&insn);
 		/* Another subsystem puts a breakpoint */
-		if (insn.opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
+		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
 			return 0;
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
 		/* Check any instructions don't jump into target */
 		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_SIZE,
-					 RELATIVE_ADDR_SIZE))
+		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+					 DISP32_SIZE))
 			return 0;
 		addr += insn.length;
 	}
@@ -374,7 +372,7 @@ int arch_prepare_optimized_kprobe(struct
 	 * Verify if the address gap is in 2GB range, because this uses
 	 * a relative jump.
 	 */
-	rel = (long)slot - (long)op->kp.addr + RELATIVEJUMP_SIZE;
+	rel = (long)slot - (long)op->kp.addr + JMP32_INSN_SIZE;
 	if (abs(rel) > 0x7fffffff) {
 		ret = -ERANGE;
 		goto err;
@@ -401,7 +399,7 @@ int arch_prepare_optimized_kprobe(struct
 	/* Set returning jmp instruction at the tail of out-of-line buffer */
 	synthesize_reljump(buf + len, slot + len,
 			   (u8 *)op->kp.addr + op->optinsn.size);
-	len += RELATIVEJUMP_SIZE;
+	len += JMP32_INSN_SIZE;
 
 	/* We have to use text_poke() for instruction buffer because it is RO */
 	text_poke(slot, buf, len);
@@ -422,22 +420,22 @@ int arch_prepare_optimized_kprobe(struct
 void arch_optimize_kprobes(struct list_head *oplist)
 {
 	struct optimized_kprobe *op, *tmp;
-	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 insn_buff[JMP32_INSN_SIZE];
 
 	list_for_each_entry_safe(op, tmp, oplist, list) {
 		s32 rel = (s32)((long)op->optinsn.insn -
-			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+			((long)op->kp.addr + JMP32_INSN_SIZE));
 
 		WARN_ON(kprobe_disabled(&op->kp));
 
 		/* Backup instructions which will be replaced by jump address */
-		memcpy(op->optinsn.copied_insn, op->kp.addr + INT3_SIZE,
-		       RELATIVE_ADDR_SIZE);
+		memcpy(op->optinsn.copied_insn, op->kp.addr + INT3_INSN_SIZE,
+		       DISP32_SIZE);
 
-		insn_buff[0] = RELATIVEJUMP_OPCODE;
+		insn_buff[0] = JMP32_INSN_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE, NULL);
+		text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
 
 		list_del_init(&op->list);
 	}
@@ -446,13 +444,13 @@ void arch_optimize_kprobes(struct list_h
 /* Replace a relative jump with a breakpoint (int3).  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 insn_buff[JMP32_INSN_SIZE];
 
 	/* Set int3 to first byte for kprobes */
-	insn_buff[0] = BREAKPOINT_INSTRUCTION;
-	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+	insn_buff[0] = INT3_INSN_OPCODE;
+	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
 
-	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
+	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
 		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
 }
 


