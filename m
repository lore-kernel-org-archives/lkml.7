Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B462084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDCNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:05:30 -0400
Received: from verein.lst.de ([213.95.11.211]:60097 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCNFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:05:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id CD3EB68AFE; Wed,  3 Apr 2019 15:05:18 +0200 (CEST)
Date:   Wed, 3 Apr 2019 15:05:18 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190403130518.GA20688@lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de> <20190118163908.E338E68D93@newverein.lst.de> <20190403024842.drobymuwvx6hmwv7@blommer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403024842.drobymuwvx6hmwv7@blommer>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:48:43AM +0100, Mark Rutland wrote:
> Hi Torsten,
> 
> Sorry for the long delay prior to this reply.

I was hoping you would come up with some code to speed things up :(

(For the record, v8 was the latest I sent, but nothing in the locations
mentioned here has changed)

> On Fri, Jan 18, 2019 at 05:39:08PM +0100, Torsten Duwe wrote:
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -14,9 +14,24 @@
> >  #include <asm/insn.h>
> >  
> >  #define HAVE_FUNCTION_GRAPH_FP_TEST
> > -#define MCOUNT_ADDR		((unsigned long)_mcount)
> >  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> >  
> > +/*
> > + * DYNAMIC_FTRACE_WITH_REGS is implemented by adding 2 NOPs at the beginning
> > + * of each function, with the second NOP actually calling ftrace. In contrary
> > + * to a classic _mcount call, the call instruction to be modified is thus
> > + * the second one, and not the only one.
> > + */
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> > +/* All we need is some magic value. Simply use "_mCount:" */
> > +#define MCOUNT_ADDR		(0x5f6d436f756e743a)
> 
> I'm really not keen on having a magic constant, and I'd really like to
> see MCOUNT_ADDR disappear entirely when the compiler doesn't generate an
> mcount call. I'm concerned that this is confusing and fragile.

Confusing: agreed. Fragile? don't think so.

> I think that it would be better to make the core ftrace API agnostic of
> mcount, and to teach it that there's a one-time initialization step for
> callsites (which is not necessarily patching a call with a NOP).
> 
> We currently have:
> 
> ftrace_make_nop(mod, rec, addr)
> ftrace_make_call(rec, addr)
> ftrace_modify_call(rec, old_addr, new_addr)
> 
> ... whereas we could have:
> 
> ftrace_call_init(mod, rec)
> ftrace_call_enable(rec, addr)
> ftrace_call_disable(rec, addr)
> ftrace_call_modify(rec, old_addr, new_addr)
> 
> ... so we wouldn't need to special-case anything for initialization (and
> don't need MCOUNT_ADDR at all), and it would be clearer as to what was
> happening at each stage.

I'm fully on your side here, BUT...

This is the dynamic ftrace with regs implementation for aarch64 with the
_current_ dynamic ftrace API. Changing the latter is IMO a different issue.
This implementation has been tested, up to the point of some preliminary live
patching. I propose to commit this and only then change the API for aarch64
and s390 simultaneously, avoiding breakage on ppc64le and x86, of course.
(others to be investigated)

> > +
> > +	/* The program counter just after the ftrace call site */
> > +	str	lr, [sp, #S_PC]
> 
> For consistency with the existing ftrace assembly, please use 'x30'
> rather than 'lr'.

You could have raised that concern already along with the "fp" issue for v6.
I don't have a strong preference here; personally I find fp and lr more
readable, but with x29 and x30 one knows where they go.
This is only just a waste of time.

> > -			module_disable_ro(mod);
> > -			*mod->arch.ftrace_trampoline = trampoline;
> > -			module_enable_ro(mod, true);
> > +		/* Check against our well-known list of ftrace entry points */
> > +		if (addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR) {
> 
> These checks exist within install_ftrace_trampoline(), so we don't need
> to duplicate them here.

True. Code evolution at work.

Any other opinions on the dynamic ftrace API change, anyone?

	Torsten

