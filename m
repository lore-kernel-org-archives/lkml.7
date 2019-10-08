Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED062070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfJHOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfJHOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:40:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4375720659;
        Tue,  8 Oct 2019 14:40:12 +0000 (UTC)
Date:   Tue, 8 Oct 2019 10:40:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to
 emulate instructions
Message-ID: <20191008104010.181c4927@gandalf.local.home>
In-Reply-To: <20191008142924.GE14765@zn.tnic>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081944.88332264.2@infradead.org>
        <20191008142924.GE14765@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 16:29:24 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Oct 07, 2019 at 10:17:17AM +0200, Peter Zijlstra wrote:
> > In preparation for static_call and variable size jump_label support,
> > teach text_poke_bp() to emulate instructions, namely:
> > 
> >   JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5, INT3
> > 
> > The current text_poke_bp() takes a @handler argument which is used as
> > a jump target when the temporary INT3 is hit by a different CPU.
> > 
> > When patching CALL instructions, this doesn't work because we'd miss
> > the PUSH of the return address. Instead, teach poke_int3_handler() to
> > emulate an instruction, typically the instruction we're patching in.
> > 
> > This fits almost all text_poke_bp() users, except
> > arch_unoptimize_kprobe() which restores random text, and for that site
> > we have to build an explicit emulate instruction.  
> 
> ...
> 
> > @@ -63,8 +66,17 @@ static inline void int3_emulate_jmp(stru
> >  	regs->ip = ip;
> >  }
> >  
> > -#define INT3_INSN_SIZE 1
> > -#define CALL_INSN_SIZE 5
> > +#define INT3_INSN_SIZE		1
> > +#define INT3_INSN_OPCODE	0xCC
> > +
> > +#define CALL_INSN_SIZE		5
> > +#define CALL_INSN_OPCODE	0xE8
> > +
> > +#define JMP32_INSN_SIZE		5
> > +#define JMP32_INSN_OPCODE	0xE9
> > +
> > +#define JMP8_INSN_SIZE		2
> > +#define JMP8_INSN_OPCODE	0xEB  
> 
> You probably should switch those to have the name prefix come first and
> make them even shorter:
> 
> OPCODE_CALL
> INSN_SIZE_CALL
> OPCODE_JMP32
> INSN_SIZE_JMP32
> OPCODE_JMP8
> ...
> 
> This way you have the opcodes prefixed with OPCODE_ and the insn sizes
> with INSN_SIZE_. I.e., what they actually are.

Honestly, I like the original way better.

Seeing OPCODE_JMP32 and INSN_SIZE_JMP32 doesn't look like they are
related to me.

-- Steve
