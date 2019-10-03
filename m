Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E56C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DD62133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8Naiej5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJCNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:05:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbfJCNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yj3GzRvDkjYyXd5+HITj3dFBQboLCILF2cbMOcJINQ0=; b=D8Naiej5VlnbcqM+0mf3Be6P8
        UimvXZWsgLCLIWA/Eoj7V0/L/85hmHqvvoVY9VAtD3sFE1ewLNjgbgodJjkiHIG1qTZR+RmO7R57e
        r0ElLmU2K68dDWYZYu6JgKNzutWe3f/2w0FsBsrm8/96yqe59X5fVkGYEh/1MT3+iY8d0RkeGYdmm
        +FrE57n9LSympH+JhMxb8L6dfB3XuEOoimjCk6jeUKVq/rOpBpaFuJHVnxSTPC5Xm9Z7kQfKVh4oq
        QfLtaBXFho7n2AbF1UykoTuMa5DQfa0HAZYB2h6Zq+NzB+bUdVjNjEIu/oi7tHO0KfkSoLEmvaTKi
        +bc+IteKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG0n9-0007GB-Lt; Thu, 03 Oct 2019 13:05:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95F27301B59;
        Thu,  3 Oct 2019 15:04:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C376E2653E3EB; Thu,  3 Oct 2019 15:05:09 +0200 (CEST)
Date:   Thu, 3 Oct 2019 15:05:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191003130509.GL4581@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:27:51AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2019 at 02:00:50PM +0900, Masami Hiramatsu wrote:
> 
> > > This fits almost all text_poke_bp() users, except
> > > arch_unoptimize_kprobe() which restores random text, and for that site
> > > we have to build an explicit emulate instruction.
> > 
> > OK, and in this case, I would like to change RELATIVEJUMP_OPCODE
> > to JMP32_INSN_OPCODE for readability. (or at least
> > making RELATIVEJUMP_OPCODE as an alias of JMP32_INSN_OPCODE)
> 
> > > @@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
> > >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> > >  {
> > >  	u8 insn_buff[RELATIVEJUMP_SIZE];
> > > +	u8 emulate_buff[RELATIVEJUMP_SIZE];
> > >  
> > >  	/* Set int3 to first byte for kprobes */
> > >  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
> > >  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
> > > +
> > > +	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> > > +	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> > > +			((long)op->kp.addr + RELATIVEJUMP_SIZE));
> 
> I'm halfway through a patch introducing:
> 
>   union text_poke_insn {
> 	u8 code[POKE_MAX_OPCODE_SUZE];
> 	struct {
> 		u8 opcode;
> 		s32 disp;
> 	} __attribute__((packed));
>   };
> 
> to text-patching.h to unify all such custom unions we have all over the
> place. I'll mob up the above in that.

How's something like so?

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -49,6 +49,8 @@ extern void text_poke_bp(void *addr, con
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
+extern void *text_gen_insn(u8 opcode, unsigned long addr, unsigned long dest);
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
+void *text_gen_insn(u8 opcode, unsigned long addr, unsigned long dest)
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
+		insn.disp = dest - (addr + size);
+		if (size == 2)
+			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+	}
+
+	return &insn.text;
+}
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,14 +16,6 @@
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
 static void bug_at(unsigned char *ip, int line)
 {
 	/*
@@ -38,33 +30,29 @@ static void bug_at(unsigned char *ip, in
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
-	static union jump_code_union code; /* relies on text_mutex */
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect;
+	const void *expect, *code;
 	int line;
 
-	lockdep_assert_held(&text_mutex);
-
-	code.jump = JMP32_INSN_OPCODE;
-	code.offset = jump_entry_target(entry) -
-		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	code = text_gen_insn(JMP32_INSN_OPCODE, jump_entry_code(entry),
+						jump_entry_target(entry));
 
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
 		expect = ideal_nop; line = __LINE__;
 	} else {
-		expect = code.code; line = __LINE__;
+		expect = code; line = __LINE__;
 	}
 
 	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
 		bug_at((void *)jump_entry_code(entry), line);
 
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
+		     text_gen_insn(JMP32_INSN_OPCODE, (long)op->kp.addr, (long)op->optinsn.insn));
 }
 
 /*
