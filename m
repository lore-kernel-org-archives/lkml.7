Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866DC17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D107215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfKIBAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKIBAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:00:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581A6214DA;
        Sat,  9 Nov 2019 01:00:39 +0000 (UTC)
Date:   Fri, 8 Nov 2019 20:00:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191108200037.5ee30af8@gandalf.local.home>
In-Reply-To: <20191108225100.ea3bhsbdf6oerj6g@treble>
References: <20191108212834.594904349@goodmis.org>
        <20191108225100.ea3bhsbdf6oerj6g@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 16:51:00 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Here's the fix for the objtool warning:

Thanks, I applied it (will push it soon).

-- Steve

> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] ftrace/x86: Tell objtool to ignore nondeterministic ftrace stack layout
> 
> Objtool complains about the new ftrace direct trampoline code:
> 
>   arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x190: stack state mismatch: cfa1=7+16 cfa2=7+24
> 
> Typically, code has a deterministic stack layout, such that at a given
> instruction address, the stack frame size is always the same.
> 
> That's not the case for the new ftrace_regs_caller() code after it
> adjusts the stack for the direct case.  Just plead ignorance and assume
> it's always the non-direct path.  Note this creates a tiny window for
> ORC to get confused.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/unwind_hints.h |  8 ++++++++
>  arch/x86/kernel/ftrace_64.S         | 12 +++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
> index 0bcdb1279361..f5e2eb12cb71 100644
> --- a/arch/x86/include/asm/unwind_hints.h
> +++ b/arch/x86/include/asm/unwind_hints.h
> @@ -86,6 +86,14 @@
>  	UNWIND_HINT sp_offset=\sp_offset
>  .endm
>  
> +.macro UNWIND_HINT_SAVE
> +	UNWIND_HINT type=UNWIND_HINT_TYPE_SAVE
> +.endm
> +
> +.macro UNWIND_HINT_RESTORE
> +	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
> +.endm
> +
>  #else /* !__ASSEMBLY__ */
>  
>  #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 5d946ab40b52..1c79624a36b2 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -175,6 +175,8 @@ ENTRY(ftrace_regs_caller)
>  	/* Save the current flags before any operations that can change them */
>  	pushfq
>  
> +	UNWIND_HINT_SAVE
> +
>  	/* added 8 bytes to save flags */
>  	save_mcount_regs 8
>  	/* save_mcount_regs fills in first two parameters */
> @@ -249,8 +251,16 @@ GLOBAL(ftrace_regs_call)
>  1:	restore_mcount_regs
>  
>  
> +2:
> +	/*
> +	 * The stack layout is nondetermistic here, depending on which path was
> +	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
> +	 * pretend the stack always looks like the non-direct case.
> +	 */
> +	UNWIND_HINT_RESTORE
> +
>  	/* Restore flags */
> -2:	popfq
> +	popfq
>  
>  	/*
>  	 * As this jmp to ftrace_epilogue can be a short jump

