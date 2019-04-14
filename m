Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B388AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CF020850
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555286472;
	bh=b+z9tLwoAjLetdAKKEPLgTCmxa1G/MBrrJFLMasb/yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rweY8wSDqSwmQgjHB1HndMvCL/mkEeuX43OwZAGvy1++Yc8JSuRX+ZdM6LWzxigjt
	 VNvQeJEcf39EXhwte8GpD0dsFyG0jrxsGIvACPFvGlO8tgDtITwYDkbY7vzngPIHFP
	 U1+e2YvMjhxgAu7DRbD7sZVL10aQdaJr7lP0qw/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfDNXyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfDNXyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:54:52 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DC12084E;
        Sun, 14 Apr 2019 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555286091;
        bh=b+z9tLwoAjLetdAKKEPLgTCmxa1G/MBrrJFLMasb/yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCWgOO/8IbdmH+E/JEWGJJiO0iXkXMALXZkdelMaAQBQQ+AiagAfLNZm1oifPe6N6
         fjZ+rie7ZFRYEpMlmbwayffw+PTEv1dMNWZRDf2bnhoxUnAEyigJZuTTSdM7/gikjg
         dkyZs6mjWStul/6aZhgw0XtEQxwOITEsPRj2LwGU=
Date:   Mon, 15 Apr 2019 08:54:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kconfig dependency issue on function-graph tracer and frame
 pointer on arm
Message-Id: <20190415085446.52f6b515f6eb2e85c0df7dc8@kernel.org>
In-Reply-To: <20190414153704.7xlyluams3rl2mvo@shell.armlinux.org.uk>
References: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
        <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
        <20190414235238.e860b1ce234752eff2b8c61c@kernel.org>
        <20190414153704.7xlyluams3rl2mvo@shell.armlinux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 16:37:04 +0100
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Sun, Apr 14, 2019 at 11:52:38PM +0900, Masami Hiramatsu wrote:
> > On Sun, 14 Apr 2019 14:34:58 +0100
> > Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > 
> > > On Sun, Apr 14, 2019 at 07:47:05PM +0900, Masami Hiramatsu wrote:
> > > > Hello,
> > > > 
> > > > Recently, Naresh reported that the function-graph tracer on the latest
> > > > kernel crashes on arm. I could reproduce it and bisected. I finally found
> > > > the commit f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
> > > > was the first bad commit.
> > > 
> > > I don't think that littering the rest of the kernel Kconfig with ARM
> > > specific stuff is really a viable solution to this.
> > > 
> > > If we examine the current situation, we have:
> > > 
> > > - THUMB2_KERNEL selecting ARM_UNWIND when enabled.
> > > - UNWINDER_FRAME_POINTER disabled if THUMB2_KERNEL is enabled, provided
> > >   we're not using Clang.  This leaves UNWINDER_ARM as the only choice,
> > >   which also selects ARM_UNWIND.
> > > - The default choice is dependent on the settings of AEABI and
> > >   FUNCTION_GRAPH_TRACER.
> > > - HAVE_FUNCTION_GRAPH_TRACER is disabled if THUMB2_KERNEL is enabled.
> > > 
> > > which seems to be _way_ too messy.
> > > 
> > > Looking back before this commit, the function graph tracer never had a
> > > strong dependence on frame pointers being enabled in the kernel, but it
> > > seems the code relies upon them (see ftrace_return_to_handler() in
> > > kernel/trace/ and return_to_handler in arch/arm/kernel/entry-frace.S).
> > > There is also the __ftrace_graph_caller macro which seems to rely on it.
> > 
> > Yes, so I think similar bug is hiding in other LTS kernels. It should
> > have a dependency to FRAME_POINTER on arm.
> > 
> > > Since Clang does not support frame pointers, we shouldn't even offer
> > > the function graph tracer for Clang compilers, so let's do that with
> > > the first hunk of the patch below.
> > > 
> > > The subsequent hunks remove the defaulting of the choice according to
> > > the function graph tracer - this is not a "hint" where the user can
> > > still choose either option irrespective of the state of the function
> > > graph tracer.  They should only be able to select the frame pointer
> > > option in that case.
> > 
> > Agreed. Using default for making dependency is wrong.
> > 
> > > 
> > > Another way forward would be for someone to put the work in to making
> > > the function graph tracer work without frame pointers.
> > 
> > Yes, we eventually need that. But for fixing current released kernel
> > (this bug is in v5.0 series), I think Kconfig fix is needed.
> > 
> > > 
> > > So, how about this:
> > > 
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 850b4805e2d1..9aed25a6019b 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -73,7 +73,7 @@ config ARM
> > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> > >  	select HAVE_EXIT_THREAD
> > >  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > -	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
> > > +	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> > >  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > >  	select HAVE_GCC_PLUGINS
> > >  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> > > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > > index 6d6e0330930b..e388af4594a6 100644
> > > --- a/arch/arm/Kconfig.debug
> > > +++ b/arch/arm/Kconfig.debug
> > > @@ -47,8 +47,8 @@ config DEBUG_WX
> > >  
> > >  choice
> > >  	prompt "Choose kernel unwinder"
> > > -	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
> > > -	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
> > > +	default UNWINDER_ARM if AEABI
> > > +	default UNWINDER_FRAME_POINTER if !AEABI
> > 
> > If UNWINDER_ARM depends on ARM EABI, would we really need this "if !AEABI"?
> > (I doubt we need these default...)
> > 
> > >  	help
> > >  	  This determines which method will be used for unwinding kernel stack
> > >  	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
> > > @@ -65,7 +65,7 @@ config UNWINDER_FRAME_POINTER
> > >  
> > >  config UNWINDER_ARM
> > >  	bool "ARM EABI stack unwinder"
> > > -	depends on AEABI
> > > +	depends on AEABI && !FUNCTION_GRAPH_TRACER
> > 
> > Hmm, AFAIK, FUNCTION_GRAPH_TRACER only depends on FRAME_POINTER, but not
> > UNWINDER_FRAME_POINTER. So can user still choose UNWINDER_ARM even if
> > FUNCTION_GRAPH_TRACER=y ? (Of course that may not be a meaningful option)
> 
> The UNWINDER_* options do not control anything except whether
> FRAME_POINTER is enabled or not.  FRAME_POINTER controls not only
> whether we build with frame pointers, but also how we unwind.
> If both ARM_UNWIND and FRAME_POINTER are set, the kernel will
> fail to link due to a multiple definition of unwind_frame().

Thank you for the explanation :) got it.

> 
> The UNWINDER_* symbols were added in the commit you referenced
> merely to select which of ARM_UNWIND or FRAME_POINTER are
> enabled.

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
