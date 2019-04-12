Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B6420850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555076963;
	bh=/6YSBsCEYlkSXwaJHg4fmlnapDa79xojOFgqTwN7IDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GVQO2OPMU3dsoiAWIyVWpYNbTvzRvHsuH6+Gc1eV6f7pY3SgYrfAduBcHFOOTKPH1
	 etRwwwoYSsxXR2+O+vzrnr+6CJApa8X1SviILOiYvwAanPFFGDW5wFY+fuRlz4Orxq
	 XzkmQcWPg/toor4NW1i3y0oG31ZUDfwTdWrL7huA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDLNtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfDLNtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:49:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3E92084D;
        Fri, 12 Apr 2019 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555076961;
        bh=/6YSBsCEYlkSXwaJHg4fmlnapDa79xojOFgqTwN7IDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dPC6hmU5VVHipggOy2xRcgC3X8cQ2Wsq1r6AcGlI4j4LITlc0pxkj0Gig6KTgYU1B
         kqNdmju8A3gEPuzNUavfSMHGlSMOcE2nntS1ZGFdyTvssr081bN1cEgT2EEZ+S2GT2
         Jrxd6Ugkfv+xFrePTn68GonfQWdLhaCTm4zVF0pY=
Date:   Fri, 12 Apr 2019 22:49:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ptrace: Add function argument access API
Message-Id: <20190412224916.fea6405337457c1242d8960a@kernel.org>
In-Reply-To: <20190411172253.GH29081@fuggles.cambridge.arm.com>
References: <155289594227.10570.1879705446198840331.stgit@devnote2>
        <20190403120649.GB29409@fuggles.cambridge.arm.com>
        <20190408093320.35f4050788937c995ca56a6b@kernel.org>
        <20190411172253.GH29081@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 18:22:53 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Apr 08, 2019 at 09:33:20AM +0900, Masami Hiramatsu wrote:
> > On Wed, 3 Apr 2019 13:06:49 +0100
> > Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Mar 18, 2019 at 04:59:02PM +0900, Masami Hiramatsu wrote:
> > > > Add regs_get_argument() which returns N th argument of the function
> > > > call. On arm64, it supports up to 8th argument.
> > > > Note that this chooses most probably assignment, in some case
> > > > it can be incorrect (e.g. passing data structure or floating
> > > > point etc.)
> > > > 
> > > > This enables ftrace kprobe events to access kernel function
> > > > arguments via $argN syntax.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > ---
> > > >  arch/arm64/Kconfig              |    1 +
> > > >  arch/arm64/include/asm/ptrace.h |   18 ++++++++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 117b2541ef3d..6ba0da4be73c 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -148,6 +148,7 @@ config ARM64
> > > >  	select HAVE_PERF_REGS
> > > >  	select HAVE_PERF_USER_STACK_DUMP
> > > >  	select HAVE_REGS_AND_STACK_ACCESS_API
> > > > +	select HAVE_FUNCTION_ARG_ACCESS_API
> > > >  	select HAVE_RCU_TABLE_FREE
> > > >  	select HAVE_RCU_TABLE_INVALIDATE
> > > >  	select HAVE_RSEQ
> > > > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > > > index ec60174c8c18..cfa1bc9b8b70 100644
> > > > --- a/arch/arm64/include/asm/ptrace.h
> > > > +++ b/arch/arm64/include/asm/ptrace.h
> > > > @@ -305,6 +305,24 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
> > > >  	return regs->regs[0];
> > > >  }
> > > >  
> > > > +/**
> > > > + * regs_get_kernel_argument() - get Nth function argument in kernel
> > > > + * @regs:	pt_regs of that context
> > > > + * @n:		function argument number (start from 0)
> > > > + *
> > > > + * regs_get_argument() returns @n th argument of the function call.
> > > > + * Note that this chooses most probably assignment, in some case
> > > > + * it can be incorrect.
> > > 
> > > In which cases would it be incorrect? I can imagine varargs causing
> > > problems, but are there others?
> > 
> > As far as I can read "Procedure Call Standard for the ARM 64-bit 
> > Architecture(AArch64) 5.4.2 Parameter Passing Rules", it may not return
> > correct data if the target function has a parameter which is 16bytes
> > or bigger size. Of course that is just a limitation of this interface.
> > But anyway, it can return wrong data for the parameter after such big
> > parameters. I think, for func(data-struct-128bits p1, u64 p2), p1
> > is stored into r0 and r1, and p2 is stored r2, is that correct?
> 
> Oh, yes, passing things by value that don't fit in the registers will
> obviously go wrong. Thanks. Do we do that in the kernel?

No, as far as I know. But I can't say it never happens in the kernel.

> 
> Anyway, please resend with the comment expanded a bit and using
> pt_regs_read_reg(), then I can queue this up for 5.2.

OK, I'll do.

Thank you!

> 
> Cheers,
> 
> Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>
