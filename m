Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FEC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE020868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERwvyf3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfFGRfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:35:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfFGRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7hQvF6Fl7wpi3fnwIv4elLx91/akNUjrVJD1LDKmF/8=; b=ERwvyf3Udn6E8Z2GOp2+PnKoy
        Vnzh1w7c5nQZq/9/VzaOjNlvKl9gbANHf2+NC+ksT1sBpcNdV2BbJeJzyidxnzDeLxmyuMTQlS5lX
        4yshsXB60NrOtsphQoXheivkvdwM5Tx96KKxgArkAAA1wxaSRSzdF5BnI1/3eCxvuF1jSiAJf38YC
        J8zbxMwX/+ZB0tefxEpGUQFEtSH9MAdEg3Ycs0mxPFVfGUFLUyG4Qg/hpdorURjdxjskGz98F00Dq
        cdUP+eyaQyRyjb+gMvkGSKm7vr/K995wSvX/b00W8esPuz2RIbprWsxuq0ko47bu+mj24Ik0JkzOM
        muzKZC5FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZIl3-0002bu-JV; Fri, 07 Jun 2019 17:34:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5357120227117; Fri,  7 Jun 2019 19:34:27 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:34:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20190607173427.GK3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608004708.7646b287151cf613838ce05f@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 12:47:08AM +0900, Masami Hiramatsu wrote:

> > This fits almost all text_poke_bp() users, except
> > arch_unoptimize_kprobe() which restores random text, and for that site
> > we have to build an explicit emulate instruction.
> 
> Hm, actually it doesn't restores randome text, since the first byte
> must always be int3. As the function name means, it just unoptimizes
> (jump based optprobe -> int3 based kprobe).
> Anyway, that is not an issue. With this patch, optprobe must still work.

I thought it basically restored 5 bytes of original text (with no
guarantee it is a single instruction, or even a complete instruction),
with the first byte replaced with INT3.

> > @@ -943,8 +949,21 @@ int poke_int3_handler(struct pt_regs *re
> >  	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
> >  		return 0;
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
> > +
> > +	default: /* assume NOP */
> 
> Shouldn't we check whether it is actually NOP here?

I was/am lazy and didn't want to deal with:

arch/x86/include/asm/nops.h:#define GENERIC_NOP5_ATOMIC NOP_DS_PREFIX,GENERIC_NOP4
arch/x86/include/asm/nops.h:#define K8_NOP5_ATOMIC 0x66,K8_NOP4
arch/x86/include/asm/nops.h:#define K7_NOP5_ATOMIC NOP_DS_PREFIX,K7_NOP4
arch/x86/include/asm/nops.h:#define P6_NOP5_ATOMIC P6_NOP5

But maybe we should check for all the various NOP5 variants and BUG() on
anything unexpected.

> > +		int3_emulate_jmp(regs, ip);
> > +		break;
> > +	}
> 
> BTW, if we fix the length of patching always 5 bytes and allow user
> to apply it only from/to jump/call/nop, we may be better to remove
> "len" and rename it, something like "text_poke_branch" etc.

I considered it; but was thinking we could still allow patching other
instructions, we'd just have to extend the emulation in
poke_int3_handler().

Then again, if/when we want to do that, we can also restore the @len
argument again.
