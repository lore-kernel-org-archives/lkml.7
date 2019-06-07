Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D6C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCAA2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kme53K79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFGIUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:20:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JazDGPTciCVZpSGhyhHqtjBiLtA80UeGIT+jhVKWr9o=; b=Kme53K79YiAo8gwQa7fNoeLwvt
        lmUBsep1uyKFrtc32Scf/rZ4G5ZcIIBXbkjqlRYMGGDpeUdOoGHsQewbtazrvas1G4F0xalu4ytKh
        TPgKn9eJoxMD3lsvqwMs0YGSrnGgUt6c5coJw0AwuDzic3q9zsRJWd9bJ2HhJgKad6Tm8iqt/y347
        E2xKm1R2/lC3BgaTlHJuB+DxU2GsiJdedpVRsHdYYnbGzf0wtYVj+BIKHIFoVBSwmgm+CKIJQ1JnG
        zpYQ0XlNm4jOuCxIEU2WLpe9syVirNmX/vFTfgaLkk4tr6Hqcfl3LlTskhUgG6r3PHUspNSXTCAbI
        4zVLXuoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZA6h-0006P7-8H; Fri, 07 Jun 2019 08:20:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 682C520227133; Fri,  7 Jun 2019 10:20:13 +0200 (CEST)
Date:   Fri, 7 Jun 2019 10:20:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190607082013.GU3419@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <7C13A4B6-6D5B-44C4-B238-58DC5926D7E1@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C13A4B6-6D5B-44C4-B238-58DC5926D7E1@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 05:41:42AM +0000, Nadav Amit wrote:

> > int poke_int3_handler(struct pt_regs *regs)
> > {
> > +	long ip = regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE;
> > +	struct opcode {
> > +		u8 insn;
> > +		s32 rel;
> > +	} __packed opcode;
> > +
> > 	/*
> > 	 * Having observed our INT3 instruction, we now must observe
> > 	 * bp_patching_in_progress.
> > 	 *
> > -	 * 	in_progress = TRUE		INT3
> > -	 * 	WMB				RMB
> > -	 * 	write INT3			if (in_progress)
> > +	 *	in_progress = TRUE		INT3
> > +	 *	WMB				RMB
> > +	 *	write INT3			if (in_progress)
> 
> I don’t see what has changed in this chunk… Whitespaces?

Yep, my editor kept marking that stuff red (space before tab), which
annoyed me enough to fix it.

> > 	 *
> > -	 * Idem for bp_int3_handler.
> > +	 * Idem for bp_int3_opcode.
> > 	 */
> > 	smp_rmb();
> > 
> > @@ -943,8 +949,21 @@ int poke_int3_handler(struct pt_regs *re
> > 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
> > 		return 0;
> > 
> > -	/* set up the specified breakpoint handler */
> > -	regs->ip = (unsigned long) bp_int3_handler;
> > +	opcode = *(struct opcode *)bp_int3_opcode;
> > +
> > +	switch (opcode.insn) {
> > +	case 0xE8: /* CALL */
> > +		int3_emulate_call(regs, ip + opcode.rel);
> > +		break;
> > +
> > +	case 0xE9: /* JMP */
> > +		int3_emulate_jmp(regs, ip + opcode.rel);
> > +		break;
> 
> Consider using RELATIVECALL_OPCODE and RELATIVEJUMP_OPCODE instead of the
> constants (0xE8, 0xE9), just as you do later in the patch.

Those are private to kprobes..

but I can do something like so:

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -48,8 +48,14 @@ static inline void int3_emulate_jmp(stru
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
 
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -952,11 +952,11 @@ int poke_int3_handler(struct pt_regs *re
 	opcode = *(struct opcode *)bp_int3_opcode;
 
 	switch (opcode.insn) {
-	case 0xE8: /* CALL */
+	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, ip + opcode.rel);
 		break;
 
-	case 0xE9: /* JMP */
+	case JMP_INSN_OPCODE:
 		int3_emulate_jmp(regs, ip + opcode.rel);
 		break;
 
