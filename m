Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D328920857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554683606;
	bh=4WjgolGb0uGqjgZKtZxFbvcwldWnc+OxMCHji4IyQjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E4IcUm/5GpzujTCpoeRHmbRLKE2gOSPNdhHtBNe56RXEYbdiSOgAwM3A4HlxTtwP2
	 tyA3ch4vq5+OQiQ/kXbUomIwyaIxtEm0HOD9hrXc7OE8h8CM9ZNo9CCAeRuJBrq2w5
	 +wrfa5dLyWbRe1cQTLvyHHcQWtGIgZMo6PPkDIZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDHAdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfDHAdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:33:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF06C20883;
        Mon,  8 Apr 2019 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554683604;
        bh=4WjgolGb0uGqjgZKtZxFbvcwldWnc+OxMCHji4IyQjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j04YICGEIQR+3gYHPAhTjMXqr2YlQ+BpriV9SACWLm1+zU8lEO1uPzretrQU8NXv1
         7xBegn5c3BXlhpZMMOgpv7rg+npHzTktE+rR7c3IZVgAcQUCBJLF+IgL3115X/Q0AV
         BahsrmPbUL2F609hVNzoXOkHjb50ORQYX5YTYUIk=
Date:   Mon, 8 Apr 2019 09:33:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ptrace: Add function argument access API
Message-Id: <20190408093320.35f4050788937c995ca56a6b@kernel.org>
In-Reply-To: <20190403120649.GB29409@fuggles.cambridge.arm.com>
References: <155289594227.10570.1879705446198840331.stgit@devnote2>
        <20190403120649.GB29409@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, 3 Apr 2019 13:06:49 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Mar 18, 2019 at 04:59:02PM +0900, Masami Hiramatsu wrote:
> > Add regs_get_argument() which returns N th argument of the function
> > call. On arm64, it supports up to 8th argument.
> > Note that this chooses most probably assignment, in some case
> > it can be incorrect (e.g. passing data structure or floating
> > point etc.)
> > 
> > This enables ftrace kprobe events to access kernel function
> > arguments via $argN syntax.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm64/Kconfig              |    1 +
> >  arch/arm64/include/asm/ptrace.h |   18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 117b2541ef3d..6ba0da4be73c 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -148,6 +148,7 @@ config ARM64
> >  	select HAVE_PERF_REGS
> >  	select HAVE_PERF_USER_STACK_DUMP
> >  	select HAVE_REGS_AND_STACK_ACCESS_API
> > +	select HAVE_FUNCTION_ARG_ACCESS_API
> >  	select HAVE_RCU_TABLE_FREE
> >  	select HAVE_RCU_TABLE_INVALIDATE
> >  	select HAVE_RSEQ
> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index ec60174c8c18..cfa1bc9b8b70 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -305,6 +305,24 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
> >  	return regs->regs[0];
> >  }
> >  
> > +/**
> > + * regs_get_kernel_argument() - get Nth function argument in kernel
> > + * @regs:	pt_regs of that context
> > + * @n:		function argument number (start from 0)
> > + *
> > + * regs_get_argument() returns @n th argument of the function call.
> > + * Note that this chooses most probably assignment, in some case
> > + * it can be incorrect.
> 
> In which cases would it be incorrect? I can imagine varargs causing
> problems, but are there others?

As far as I can read "Procedure Call Standard for the ARM 64-bit 
Architecture(AArch64) 5.4.2 Parameter Passing Rules", it may not return
correct data if the target function has a parameter which is 16bytes
or bigger size. Of course that is just a limitation of this interface.
But anyway, it can return wrong data for the parameter after such big
parameters. I think, for func(data-struct-128bits p1, u64 p2), p1
is stored into r0 and r1, and p2 is stored r2, is that correct?

(Of course any SIMD/float parameter passed to the function, it also can
not correctly get, but in the kernel we can ignore it.)

> > +static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
> > +						     unsigned int n)
> > +{
> > +#define NR_REG_ARGUMENTS 8
> > +	if (n < NR_REG_ARGUMENTS)
> > +		return regs_get_register(regs, n << 3);
> 
> You can use pt_regs_read_reg() to avoid the shift here.

Ah, right!

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
