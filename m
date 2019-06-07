Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23D02133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559912540;
	bh=F/U8VomZijZSt3nzg8WGWDTNABAy4BLoOonOoQPuGK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eNhY+1bvKvU5RqyfTJBMUmsu/BSad0MISZcKqjTTuWoX3M7B093riZA2yb+JlG18R
	 DgI91eG5VpZGjf5Jn+JYhC/JQAbzf8//OFnGFz8fj9AOeR5gcKyfXWmooil54B98J2
	 ia0kEFpZf+I1a4aMXtNVTTS009fQgKKKb28bE7Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfFGNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfFGNCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:02:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7265D206BB;
        Fri,  7 Jun 2019 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559912538;
        bh=F/U8VomZijZSt3nzg8WGWDTNABAy4BLoOonOoQPuGK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PRdOi1j0fZfTtrvXwPLmQhxSRggAT6MjxRT5zbn6UVFIGwA5yRGO4Ld7yiDs2HCvG
         D7SPJAw+cIJtRLN4BnjKRnWAChhLFhflfrXBGABnGl1/11I2PppB0P8ewzIIOsTYus
         mM8NelmzA413AEVTfXCAzZzf6zcdEvHqG1x8QPDw=
Date:   Fri, 7 Jun 2019 22:02:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
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
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/15] x86/kprobes: Fix frame pointer annotations
Message-Id: <20190607220210.328ed88f2f7598e757c3564f@kernel.org>
In-Reply-To: <20190605131944.711054227@infradead.org>
References: <20190605130753.327195108@infradead.org>
        <20190605131944.711054227@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019 15:07:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The kprobe trampolines have a FRAME_POINTER annotation that makes no
> sense. It marks the frame in the middle of pt_regs, at the place of
> saving BP.

commit ee213fc72fd67 introduced this code, and this is for unwinder which
uses frame pointer. I think current code stores the address of previous
(original context's) frame pointer into %rbp. So with that, if unwinder
tries to decode frame pointer, it can get the original %rbp value,
instead of &pt_regs from current %rbp.

> 
> Change it to mark the pt_regs frame as per the ENCODE_FRAME_POINTER
> from the respective entry_*.S.
> 

With this change, I think stack unwinder can not get the original %rbp
value. Peter, could you check the above commit?

Thank you,

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/common.h |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> --- a/arch/x86/kernel/kprobes/common.h
> +++ b/arch/x86/kernel/kprobes/common.h
> @@ -5,15 +5,10 @@
>  /* Kprobes and Optprobes common header */
>  
>  #include <asm/asm.h>
> -
> -#ifdef CONFIG_FRAME_POINTER
> -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n" \
> -			 "	mov  %" _ASM_SP ", %" _ASM_BP "\n"
> -#else
> -# define SAVE_RBP_STRING "	push %" _ASM_BP "\n"
> -#endif
> +#include <asm/frame.h>
>  
>  #ifdef CONFIG_X86_64
> +
>  #define SAVE_REGS_STRING			\
>  	/* Skip cs, ip, orig_ax. */		\
>  	"	subq $24, %rsp\n"		\
> @@ -27,11 +22,13 @@
>  	"	pushq %r10\n"			\
>  	"	pushq %r11\n"			\
>  	"	pushq %rbx\n"			\
> -	SAVE_RBP_STRING				\
> +	"	pushq %rbp\n"			\
>  	"	pushq %r12\n"			\
>  	"	pushq %r13\n"			\
>  	"	pushq %r14\n"			\
> -	"	pushq %r15\n"
> +	"	pushq %r15\n"			\
> +	ENCODE_FRAME_POINTER
> +
>  #define RESTORE_REGS_STRING			\
>  	"	popq %r15\n"			\
>  	"	popq %r14\n"			\
> @@ -51,19 +48,22 @@
>  	/* Skip orig_ax, ip, cs */		\
>  	"	addq $24, %rsp\n"
>  #else
> +
>  #define SAVE_REGS_STRING			\
>  	/* Skip cs, ip, orig_ax and gs. */	\
> -	"	subl $16, %esp\n"		\
> +	"	subl $4*4, %esp\n"		\
>  	"	pushl %fs\n"			\
>  	"	pushl %es\n"			\
>  	"	pushl %ds\n"			\
>  	"	pushl %eax\n"			\
> -	SAVE_RBP_STRING				\
> +	"	pushl %ebp\n"			\
>  	"	pushl %edi\n"			\
>  	"	pushl %esi\n"			\
>  	"	pushl %edx\n"			\
>  	"	pushl %ecx\n"			\
> -	"	pushl %ebx\n"
> +	"	pushl %ebx\n"			\
> +	ENCODE_FRAME_POINTER
> +
>  #define RESTORE_REGS_STRING			\
>  	"	popl %ebx\n"			\
>  	"	popl %ecx\n"			\
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
