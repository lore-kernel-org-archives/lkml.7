Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A24C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E338720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfFGHvL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfFGHvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:51:10 -0400
Received: from oasis.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDA9208C3;
        Fri,  7 Jun 2019 07:51:04 +0000 (UTC)
Date:   Fri, 7 Jun 2019 03:51:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 12/15] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20190607035100.3cd49d4c@oasis.local.home>
In-Reply-To: <37C2FB32-3437-48CB-954D-05F683B7D80B@vmware.com>
References: <20190605130753.327195108@infradead.org>
        <20190605131945.254721704@infradead.org>
        <37C2FB32-3437-48CB-954D-05F683B7D80B@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 06:13:58 +0000
Nadav Amit <namit@vmware.com> wrote:

> > On Jun 5, 2019, at 6:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Add the x86 out-of-line static call implementation.  For each key, a
> > permanent trampoline is created which is the destination for all static
> > calls for the given key.  The trampoline has a direct jump which gets
> > patched by static_call_update() when the destination function changes.
> > 
> > Cc: x86@kernel.org
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Julia Cartwright <julia@ni.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Jason Baron <jbaron@akamai.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: David Laight <David.Laight@ACULAB.COM>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F00b08f2194e80241decbf206624b6580b9b8855b.1543200841.git.jpoimboe%40redhat.com&amp;data=02%7C01%7Cnamit%40vmware.com%7C13bc03381930464a018e08d6e9b8f90e%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636953378007810030&amp;sdata=UnHEUYEYV3FBSZj667lZYzGKRov%2B1PdAjAnM%2BqOz3Ns%3D&amp;reserved=0
> > ---
> > arch/x86/Kconfig                   |    1 
> > arch/x86/include/asm/static_call.h |   28 +++++++++++++++++++++++++++
> > arch/x86/kernel/Makefile           |    1 
> > arch/x86/kernel/static_call.c      |   38 +++++++++++++++++++++++++++++++++++++
> > 4 files changed, 68 insertions(+)
> > create mode 100644 arch/x86/include/asm/static_call.h
> > create mode 100644 arch/x86/kernel/static_call.c
> > 
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -198,6 +198,7 @@ config X86
> > 	select HAVE_FUNCTION_ARG_ACCESS_API
> > 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
> > 	select HAVE_STACK_VALIDATION		if X86_64
> > +	select HAVE_STATIC_CALL
> > 	select HAVE_RSEQ
> > 	select HAVE_SYSCALL_TRACEPOINTS
> > 	select HAVE_UNSTABLE_SCHED_CLOCK
> > --- /dev/null
> > +++ b/arch/x86/include/asm/static_call.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_STATIC_CALL_H
> > +#define _ASM_STATIC_CALL_H
> > +
> > +/*
> > + * Manually construct a 5-byte direct JMP to prevent the assembler from
> > + * optimizing it into a 2-byte JMP.
> > + */
> > +#define __ARCH_STATIC_CALL_JMP_LABEL(key) ".L" __stringify(key ## _after_jmp)
> > +#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
> > +	".byte 0xe9						\n"	\
> > +	".long " #func " - " __ARCH_STATIC_CALL_JMP_LABEL(key) "\n"	\
> > +	__ARCH_STATIC_CALL_JMP_LABEL(key) ":"
> > +
> > +/*
> > + * This is a permanent trampoline which does a direct jump to the function.
> > + * The direct jump get patched by static_call_update().
> > + */
> > +#define ARCH_DEFINE_STATIC_CALL_TRAMP(key, func)			\
> > +	asm(".pushsection .text, \"ax\"				\n"	\
> > +	    ".align 4						\n"	\
> > +	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
> > +	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
> > +	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
> > +	    __ARCH_STATIC_CALL_TRAMP_JMP(key, func) "           \n"	\
> > +	    ".popsection					\n")
> > +
> > +#endif /* _ASM_STATIC_CALL_H */
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -63,6 +63,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rt
> > obj-y			+= pci-iommu_table.o
> > obj-y			+= resource.o
> > obj-y			+= irqflags.o
> > +obj-y			+= static_call.o
> > 
> > obj-y				+= process.o
> > obj-y				+= fpu/
> > --- /dev/null
> > +++ b/arch/x86/kernel/static_call.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/static_call.h>
> > +#include <linux/memory.h>
> > +#include <linux/bug.h>
> > +#include <asm/text-patching.h>
> > +#include <asm/nospec-branch.h>
> > +
> > +#define CALL_INSN_SIZE 5
> > +
> > +void arch_static_call_transform(void *site, void *tramp, void *func)
> > +{
> > +	unsigned char opcodes[CALL_INSN_SIZE];
> > +	unsigned char insn_opcode;
> > +	unsigned long insn;
> > +	s32 dest_relative;
> > +
> > +	mutex_lock(&text_mutex);
> > +
> > +	insn = (unsigned long)tramp;
> > +
> > +	insn_opcode = *(unsigned char *)insn;
> > +	if (insn_opcode != 0xE9) {
> > +		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
> > +			  insn_opcode, (void *)insn);
> > +		goto unlock;  
> 
> This might happen if a kprobe is installed on the call, no?
> 
> I don’t know if you want to be more gentle handling of this case (or perhaps
> modify can_probe() to prevent such a case).
> 

Perhaps it is better to block kprobes from attaching to a static call.
Or have it use the static call directly as it does with ftrace. But
that would probably be much more work.

-- Steve
