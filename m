Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71CCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69062072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgAHOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgAHOQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:16:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9534F206F0;
        Wed,  8 Jan 2020 14:16:29 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:16:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bristot@redhat.com,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, namit@vmware.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH -v5mkII 13/17] arm/ftrace: Use __patch_text()
Message-ID: <20200108091628.7e548401@gandalf.local.home>
In-Reply-To: <CAK8P3a0MJGpg6AkmwRL6o7TCPOQXSMDShutigvBjeOMDn0BHaA@mail.gmail.com>
References: <20191111131252.921588318@infradead.org>
        <20191111132458.220458362@infradead.org>
        <20191111164703.GA11521@willie-the-truck>
        <20191111171955.GO4114@hirez.programming.kicks-ass.net>
        <20191111172541.GT5671@hirez.programming.kicks-ass.net>
        <20191112112950.GB17835@willie-the-truck>
        <20191113092636.GG4131@hirez.programming.kicks-ass.net>
        <CAK8P3a0MJGpg6AkmwRL6o7TCPOQXSMDShutigvBjeOMDn0BHaA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 13:22:52 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Nov 13, 2019 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > @@ -49,8 +49,8 @@ obj-$(CONFIG_HAVE_ARM_SCU)    += smp_scu.o
> >  obj-$(CONFIG_HAVE_ARM_TWD)     += smp_twd.o
> >  obj-$(CONFIG_ARM_ARCH_TIMER)   += arch_timer.o
> >  obj-$(CONFIG_FUNCTION_TRACER)  += entry-ftrace.o
> > -obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o
> > -obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o
> > +obj-$(CONFIG_DYNAMIC_FTRACE)   += ftrace.o insn.o patch.o
> > +obj-$(CONFIG_FUNCTION_GRAPH_TRACER)    += ftrace.o insn.o patch.o
> >  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o insn.o patch.o
> >  obj-$(CONFIG_KEXEC)            += machine_kexec.o relocate_kernel.o  
> 
> This broke randconfig builds with big-endian ARMv5:
> 
> ../arch/arm/kernel/patch.c: In function '__patch_text_real':
> ../arch/arm/kernel/patch.c:94:11: error: implicit declaration of
> function '__opcode_to_mem_thumb32'
> [-Werror=implicit-function-declaration]
>     insn = __opcode_to_mem_thumb32(insn);
>            ^~~~~~~~~~~~~~~~~~~~~~~
> 
> The problem is that we don't have a BE32 definition of
> __opcode_to_mem_thumb32, mostly because no hardware
> supports that.
> 
> One possible workaround is a big ugly:
> 
> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> index d0a05a3bdb96..1067fd122897 100644
> --- a/arch/arm/kernel/patch.c
> +++ b/arch/arm/kernel/patch.c
> @@ -90,9 +90,11 @@ void __kprobes __patch_text_real(void *addr,
> unsigned int insn, bool remap)
> 
>                 size = sizeof(u32);
>         } else {
> +#ifdef CONFIG_THUMB2_KERNEL
>                 if (thumb2)

If we change the above to:

		if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && thumb2)

Would the compiler optmize out __opcode_to_mem_thumb32(). We would need
to add a declaration for it, but wont need to define it. At least we
wont have nasty #ifdef logic in the code.

-- Steve

>                         insn = __opcode_to_mem_thumb32(insn);
>                 else
> +#endif
>                         insn = __opcode_to_mem_arm(insn);
> 
>                 *(u32 *)waddr = insn;
> 
> 
> Any other suggestions?
> 
>        Arnd

