Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069EAC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40202080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niyhNmW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405593AbfFKQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:22:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405444AbfFKQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5A3MctuJ5/qP+9tFlCPEP959Ibp9Cmcma5nEMa8xYiM=; b=niyhNmW4fWVk/szQ+NJ+t2jhl
        CT9Y6XDWlI5AcFEPAY4VTZ9E15ooxP7CE0ThQuy9uI/qJS/GGHlGPhFPGkIkdi9yu/5XWISHUgNzw
        OcPBYNgPFMQfSw5O00YlCRohhRTGWM68SyOuD+6jqrCxxykHYjEMhtN0c0IERWD5xI91MNkOOaF+C
        QGumBvtvmQfkpgRct8yGgTBwe40WBvDWu5daZzqlzvXnmvgxPedbjsq/1QYhnNBfRpgB6aJ87Ppo+
        klx6CzLp2HRHfEF99kl+WcK9fA9YIezYqSjEhuV9+B9g0cOQp7af7a3Sg6bbaHHMkOvK+IXwdnplL
        +6GSLWGTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hajWd-0005u6-DJ; Tue, 11 Jun 2019 16:21:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D27820098584; Tue, 11 Jun 2019 18:21:28 +0200 (CEST)
Date:   Tue, 11 Jun 2019 18:21:28 +0200
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
Message-ID: <20190611162128.GK3463@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190611111410.366f4ced@gandalf.local.home>
 <20190611155248.GA3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611155248.GA3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 05:52:48PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 11, 2019 at 11:14:10AM -0400, Steven Rostedt wrote:
> > On Wed, 05 Jun 2019 15:08:01 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > -void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
> > > +void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
> > >  {
> > >  	unsigned char int3 = 0xcc;
> > >  
> > > -	bp_int3_handler = handler;
> > > +	bp_int3_opcode = emulate ?: opcode;
> > >  	bp_int3_addr = (u8 *)addr + sizeof(int3);
> > >  	bp_patching_in_progress = true;
> > >  
> > >  	lockdep_assert_held(&text_mutex);
> > >  
> > >  	/*
> > > +	 * poke_int3_handler() relies on @opcode being a 5 byte instruction;
> > > +	 * notably a JMP, CALL or NOP5_ATOMIC.
> > > +	 */
> > > +	BUG_ON(len != 5);
> > 
> > If we have a bug on here, why bother with passing in len at all? Just
> > force it to be 5.
> 
> Masami said the same.
> 
> > We could make it a WARN_ON() and return without doing anything.
> > 
> > This also prevents us from ever changing two byte jmps.
> 
> It doesn't; that is, we'd need to add emulation for the 3 byte jump, but
> that'd be pretty trivial.

I can't find a 3 byte jump on x86_64, I could only find a 2 byte one.
But something like so should work I suppose, although at this point I'm
thinking we should just used the instruction decode we have instead of
playing iffy games with packed structures.

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e1a4bb42eb92..abb9615dcb1d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -57,6 +57,9 @@ static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 #define JMP_INSN_SIZE		5
 #define JMP_INSN_OPCODE		0xE9
 
+#define JMP8_INSN_SIZE		2
+#define JMP8_INSN_OPCODE	0xEB
+
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5d0123a8183b..5df6c74a0b08 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -924,13 +924,18 @@ static void do_sync_core(void *info)
 static bool bp_patching_in_progress;
 static const void *bp_int3_opcode, *bp_int3_addr;
 
+struct poke_insn {
+	u8 opcode;
+	union {
+		s8 rel8;
+		s32 rel32;
+	};
+} __packed;
+
 int poke_int3_handler(struct pt_regs *regs)
 {
 	long ip = regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE;
-	struct opcode {
-		u8 insn;
-		s32 rel;
-	} __packed opcode;
+	struct poke_insn insn;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
@@ -950,15 +955,19 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
 		return 0;
 
-	opcode = *(struct opcode *)bp_int3_opcode;
+	insn = *(struct poke_insn *)bp_int3_opcode;
 
-	switch (opcode.insn) {
+	switch (insn.opcode) {
 	case CALL_INSN_OPCODE:
-		int3_emulate_call(regs, ip + opcode.rel);
+		int3_emulate_call(regs, ip + insn.rel32);
 		break;
 
 	case JMP_INSN_OPCODE:
-		int3_emulate_jmp(regs, ip + opcode.rel);
+		int3_emulate_jmp(regs, ip + insn.rel32);
+		break;
+
+	case JMP8_INSN_OPCODE:
+		int3_emulate_jmp(regs, ip + insn.rel8);
 		break;
 
 	default: /* assume NOP */
@@ -992,7 +1001,8 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  */
 void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	unsigned char int3 = 0xcc;
+	unsigned char int3 = INT3_INSN_OPCODE;
+	unsigned char opcode;
 
 	bp_int3_opcode = emulate ?: opcode;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
@@ -1001,10 +1011,26 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulat
 	lockdep_assert_held(&text_mutex);
 
 	/*
-	 * poke_int3_handler() relies on @opcode being a 5 byte instruction;
-	 * notably a JMP, CALL or NOP5_ATOMIC.
+	 * Verify we support the actual instruction in poke_int3_handler().
 	 */
-	BUG_ON(len != 5);
+	opcode = *(unsigned char *)bp_int3_opcode;
+	switch (opcode) {
+	case CALL_INSN_OPCODE:
+		BUG_ON(len != CALL_INSN_SIZE);
+		break;
+
+	case JMP_INSN_OPCODE:
+		BUG_ON(len != JMP_INSN_SIZE);
+		break;
+
+	case JMP8_INSN_OPCODE:
+		BUG_ON(len != JMP8_INSN_SIZE);
+		break;
+
+	default: /* assume NOP5_ATOMIC */
+		BUG_ON(len != 5);
+		break;
+	}
 
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
