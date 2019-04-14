Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEEA20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xeuhtCSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfDNPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:37:21 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60092 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfDNPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aHU8pYkD4d9ZDBsmRbagbI5VZOamvJFLd3K+l+zwu8c=; b=xeuhtCSfZyvyYmIZVWVAFMY3Y
        VqP8QfN5DINn+b4xfYBQ3HxGfwpe69iT0DHnlxNlqHj1iAOxXkic4l19gvgBh8Nw82krs5MYXx48l
        0h74GzoXG4B/4SdiiyUd1tFTwrZIEVgvRUPdX9Z+vTjOZgtxAiwOEUtYjaV13uGGLOHd1mxeMEkzP
        wOn3MbKeVr/nvwmILfJy0dZCZogakJM8UwIdwLuG4wN08Te3JPMLhMujfPvjZZjn3xfKgQo8h9RL+
        +wc+Ba4WyI8Hryv5Eb48qrgtN3j+b0lE1Jify5eBqlcx9o5DRSkkj/F2etDpwC3UmPmbIW0wMhncw
        evZv29hKQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37762)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hFhBs-0007pn-0J; Sun, 14 Apr 2019 16:37:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hFhBo-0006jZ-S7; Sun, 14 Apr 2019 16:37:04 +0100
Date:   Sun, 14 Apr 2019 16:37:04 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kconfig dependency issue on function-graph tracer and frame
 pointer on arm
Message-ID: <20190414153704.7xlyluams3rl2mvo@shell.armlinux.org.uk>
References: <20190414194705.2e10802aca2df36c8f27f349@kernel.org>
 <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
 <20190414235238.e860b1ce234752eff2b8c61c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414235238.e860b1ce234752eff2b8c61c@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:52:38PM +0900, Masami Hiramatsu wrote:
> On Sun, 14 Apr 2019 14:34:58 +0100
> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Apr 14, 2019 at 07:47:05PM +0900, Masami Hiramatsu wrote:
> > > Hello,
> > > 
> > > Recently, Naresh reported that the function-graph tracer on the latest
> > > kernel crashes on arm. I could reproduce it and bisected. I finally found
> > > the commit f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
> > > was the first bad commit.
> > 
> > I don't think that littering the rest of the kernel Kconfig with ARM
> > specific stuff is really a viable solution to this.
> > 
> > If we examine the current situation, we have:
> > 
> > - THUMB2_KERNEL selecting ARM_UNWIND when enabled.
> > - UNWINDER_FRAME_POINTER disabled if THUMB2_KERNEL is enabled, provided
> >   we're not using Clang.  This leaves UNWINDER_ARM as the only choice,
> >   which also selects ARM_UNWIND.
> > - The default choice is dependent on the settings of AEABI and
> >   FUNCTION_GRAPH_TRACER.
> > - HAVE_FUNCTION_GRAPH_TRACER is disabled if THUMB2_KERNEL is enabled.
> > 
> > which seems to be _way_ too messy.
> > 
> > Looking back before this commit, the function graph tracer never had a
> > strong dependence on frame pointers being enabled in the kernel, but it
> > seems the code relies upon them (see ftrace_return_to_handler() in
> > kernel/trace/ and return_to_handler in arch/arm/kernel/entry-frace.S).
> > There is also the __ftrace_graph_caller macro which seems to rely on it.
> 
> Yes, so I think similar bug is hiding in other LTS kernels. It should
> have a dependency to FRAME_POINTER on arm.
> 
> > Since Clang does not support frame pointers, we shouldn't even offer
> > the function graph tracer for Clang compilers, so let's do that with
> > the first hunk of the patch below.
> > 
> > The subsequent hunks remove the defaulting of the choice according to
> > the function graph tracer - this is not a "hint" where the user can
> > still choose either option irrespective of the state of the function
> > graph tracer.  They should only be able to select the frame pointer
> > option in that case.
> 
> Agreed. Using default for making dependency is wrong.
> 
> > 
> > Another way forward would be for someone to put the work in to making
> > the function graph tracer work without frame pointers.
> 
> Yes, we eventually need that. But for fixing current released kernel
> (this bug is in v5.0 series), I think Kconfig fix is needed.
> 
> > 
> > So, how about this:
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 850b4805e2d1..9aed25a6019b 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -73,7 +73,7 @@ config ARM
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> >  	select HAVE_EXIT_THREAD
> >  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > -	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
> > +	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> >  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> >  	select HAVE_GCC_PLUGINS
> >  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 6d6e0330930b..e388af4594a6 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -47,8 +47,8 @@ config DEBUG_WX
> >  
> >  choice
> >  	prompt "Choose kernel unwinder"
> > -	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
> > -	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
> > +	default UNWINDER_ARM if AEABI
> > +	default UNWINDER_FRAME_POINTER if !AEABI
> 
> If UNWINDER_ARM depends on ARM EABI, would we really need this "if !AEABI"?
> (I doubt we need these default...)
> 
> >  	help
> >  	  This determines which method will be used for unwinding kernel stack
> >  	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
> > @@ -65,7 +65,7 @@ config UNWINDER_FRAME_POINTER
> >  
> >  config UNWINDER_ARM
> >  	bool "ARM EABI stack unwinder"
> > -	depends on AEABI
> > +	depends on AEABI && !FUNCTION_GRAPH_TRACER
> 
> Hmm, AFAIK, FUNCTION_GRAPH_TRACER only depends on FRAME_POINTER, but not
> UNWINDER_FRAME_POINTER. So can user still choose UNWINDER_ARM even if
> FUNCTION_GRAPH_TRACER=y ? (Of course that may not be a meaningful option)

The UNWINDER_* options do not control anything except whether
FRAME_POINTER is enabled or not.  FRAME_POINTER controls not only
whether we build with frame pointers, but also how we unwind.
If both ARM_UNWIND and FRAME_POINTER are set, the kernel will
fail to link due to a multiple definition of unwind_frame().

The UNWINDER_* symbols were added in the commit you referenced
merely to select which of ARM_UNWIND or FRAME_POINTER are
enabled.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
