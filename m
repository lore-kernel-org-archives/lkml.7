Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D364CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C7212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559917670;
	bh=gpoMFWooueTQcAcnu+53x5cQNpLlXmAEYoHjD6z/m7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hHxnLbBWyfrwzc3RM8CowALRg8cmYJKpKhrizBcIXo5iMLVnlyofveOaviDwVfRm7
	 1LmXz29NMUZvYox5fK7VubYekqVVWyRGQziOJuB6p3q+qmEE0VShDKuuMpuiw+yrYt
	 p6NwR4OeV/HaBohZioB7DlLxYT8X3hzPghi0sN4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfFGO1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfFGO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:27:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F38B20657;
        Fri,  7 Jun 2019 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559917668;
        bh=gpoMFWooueTQcAcnu+53x5cQNpLlXmAEYoHjD6z/m7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k+p8AstVzyP+536XgnpxVRsJ1+fQ6U6uluFSXbFgndysnWO2qt+6W9yZrploqhoh0
         tMqO8iIrJxr2F23+bCY10J+2Dh4tz/zXKyKE8zwQpGmtPUhNdNANPe5FCtCYqCbIiU
         LoZisGMJ/GbJosPoe3/A8mEUB0bC4TOmJcEW3Ntg=
Date:   Fri, 7 Jun 2019 23:27:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Message-Id: <20190607232742.d331359f0d511c78d06e1703@kernel.org>
In-Reply-To: <20190607082013.GU3419@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
        <20190605131945.005681046@infradead.org>
        <7C13A4B6-6D5B-44C4-B238-58DC5926D7E1@vmware.com>
        <20190607082013.GU3419@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 10:20:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jun 07, 2019 at 05:41:42AM +0000, Nadav Amit wrote:
> 
> > > int poke_int3_handler(struct pt_regs *regs)
> > > {
> > > +	long ip = regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE;
> > > +	struct opcode {
> > > +		u8 insn;
> > > +		s32 rel;
> > > +	} __packed opcode;
> > > +
> > > 	/*
> > > 	 * Having observed our INT3 instruction, we now must observe
> > > 	 * bp_patching_in_progress.
> > > 	 *
> > > -	 * 	in_progress = TRUE		INT3
> > > -	 * 	WMB				RMB
> > > -	 * 	write INT3			if (in_progress)
> > > +	 *	in_progress = TRUE		INT3
> > > +	 *	WMB				RMB
> > > +	 *	write INT3			if (in_progress)
> > 
> > I don’t see what has changed in this chunk… Whitespaces?
> 
> Yep, my editor kept marking that stuff red (space before tab), which
> annoyed me enough to fix it.
> 
> > > 	 *
> > > -	 * Idem for bp_int3_handler.
> > > +	 * Idem for bp_int3_opcode.
> > > 	 */
> > > 	smp_rmb();
> > > 
> > > @@ -943,8 +949,21 @@ int poke_int3_handler(struct pt_regs *re
> > > 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
> > > 		return 0;
> > > 
> > > -	/* set up the specified breakpoint handler */
> > > -	regs->ip = (unsigned long) bp_int3_handler;
> > > +	opcode = *(struct opcode *)bp_int3_opcode;
> > > +
> > > +	switch (opcode.insn) {
> > > +	case 0xE8: /* CALL */
> > > +		int3_emulate_call(regs, ip + opcode.rel);
> > > +		break;
> > > +
> > > +	case 0xE9: /* JMP */
> > > +		int3_emulate_jmp(regs, ip + opcode.rel);
> > > +		break;
> > 
> > Consider using RELATIVECALL_OPCODE and RELATIVEJUMP_OPCODE instead of the
> > constants (0xE8, 0xE9), just as you do later in the patch.
> 
> Those are private to kprobes..
> 
> but I can do something like so:
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -48,8 +48,14 @@ static inline void int3_emulate_jmp(stru
>  	regs->ip = ip;
>  }
>  
> -#define INT3_INSN_SIZE 1
> -#define CALL_INSN_SIZE 5
> +#define INT3_INSN_SIZE		1
> +#define INT3_INSN_OPCODE	0xCC
> +
> +#define CALL_INSN_SIZE		5
> +#define CALL_INSN_OPCODE	0xE8
> +
> +#define JMP_INSN_SIZE		5
> +#define JMP_INSN_OPCODE		0xE9
>  
>  static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
>  {
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -952,11 +952,11 @@ int poke_int3_handler(struct pt_regs *re
>  	opcode = *(struct opcode *)bp_int3_opcode;
>  
>  	switch (opcode.insn) {
> -	case 0xE8: /* CALL */
> +	case CALL_INSN_OPCODE:
>  		int3_emulate_call(regs, ip + opcode.rel);
>  		break;
>  
> -	case 0xE9: /* JMP */
> +	case JMP_INSN_OPCODE:
>  		int3_emulate_jmp(regs, ip + opcode.rel);
>  		break;
>  

This looks good. I don't want to make those opcode as private.
I would like to share it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
