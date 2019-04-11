Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFF32146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDKRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:22:58 -0400
Received: from foss.arm.com ([217.140.101.70]:46732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:22:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EFC0374;
        Thu, 11 Apr 2019 10:22:57 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479333F59C;
        Thu, 11 Apr 2019 10:22:56 -0700 (PDT)
Date:   Thu, 11 Apr 2019 18:22:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ptrace: Add function argument access API
Message-ID: <20190411172253.GH29081@fuggles.cambridge.arm.com>
References: <155289594227.10570.1879705446198840331.stgit@devnote2>
 <20190403120649.GB29409@fuggles.cambridge.arm.com>
 <20190408093320.35f4050788937c995ca56a6b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408093320.35f4050788937c995ca56a6b@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:33:20AM +0900, Masami Hiramatsu wrote:
> On Wed, 3 Apr 2019 13:06:49 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Mar 18, 2019 at 04:59:02PM +0900, Masami Hiramatsu wrote:
> > > Add regs_get_argument() which returns N th argument of the function
> > > call. On arm64, it supports up to 8th argument.
> > > Note that this chooses most probably assignment, in some case
> > > it can be incorrect (e.g. passing data structure or floating
> > > point etc.)
> > > 
> > > This enables ftrace kprobe events to access kernel function
> > > arguments via $argN syntax.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  arch/arm64/Kconfig              |    1 +
> > >  arch/arm64/include/asm/ptrace.h |   18 ++++++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 117b2541ef3d..6ba0da4be73c 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -148,6 +148,7 @@ config ARM64
> > >  	select HAVE_PERF_REGS
> > >  	select HAVE_PERF_USER_STACK_DUMP
> > >  	select HAVE_REGS_AND_STACK_ACCESS_API
> > > +	select HAVE_FUNCTION_ARG_ACCESS_API
> > >  	select HAVE_RCU_TABLE_FREE
> > >  	select HAVE_RCU_TABLE_INVALIDATE
> > >  	select HAVE_RSEQ
> > > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > > index ec60174c8c18..cfa1bc9b8b70 100644
> > > --- a/arch/arm64/include/asm/ptrace.h
> > > +++ b/arch/arm64/include/asm/ptrace.h
> > > @@ -305,6 +305,24 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
> > >  	return regs->regs[0];
> > >  }
> > >  
> > > +/**
> > > + * regs_get_kernel_argument() - get Nth function argument in kernel
> > > + * @regs:	pt_regs of that context
> > > + * @n:		function argument number (start from 0)
> > > + *
> > > + * regs_get_argument() returns @n th argument of the function call.
> > > + * Note that this chooses most probably assignment, in some case
> > > + * it can be incorrect.
> > 
> > In which cases would it be incorrect? I can imagine varargs causing
> > problems, but are there others?
> 
> As far as I can read "Procedure Call Standard for the ARM 64-bit 
> Architecture(AArch64) 5.4.2 Parameter Passing Rules", it may not return
> correct data if the target function has a parameter which is 16bytes
> or bigger size. Of course that is just a limitation of this interface.
> But anyway, it can return wrong data for the parameter after such big
> parameters. I think, for func(data-struct-128bits p1, u64 p2), p1
> is stored into r0 and r1, and p2 is stored r2, is that correct?

Oh, yes, passing things by value that don't fit in the registers will
obviously go wrong. Thanks. Do we do that in the kernel?

Anyway, please resend with the comment expanded a bit and using
pt_regs_read_reg(), then I can queue this up for 5.2.

Cheers,

Will
