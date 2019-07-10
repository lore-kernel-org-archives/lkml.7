Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBAFC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4882087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfGJULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfGJULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:11:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E30E20844;
        Wed, 10 Jul 2019 20:11:39 +0000 (UTC)
Date:   Wed, 10 Jul 2019 16:11:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 2/7] x86/entry/32: Simplify common_exception
Message-ID: <20190710161137.026cdd47@gandalf.local.home>
In-Reply-To: <20190704200050.363747790@infradead.org>
References: <20190704195555.580363209@infradead.org>
        <20190704200050.363747790@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2019 21:55:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -294,9 +294,11 @@
>  .Lfinished_frame_\@:
>  .endm
>  
> -.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
> +.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
>  	cld
> +.if \skip_gs == 0
>  	PUSH_GS
> +.endif
>  	FIXUP_FRAME
>  	pushl	%fs
>  	pushl	%es
> @@ -313,13 +315,13 @@
>  	movl	%edx, %es
>  	movl	$(__KERNEL_PERCPU), %edx
>  	movl	%edx, %fs
> +.if \skip_gs == 0
>  	SET_KERNEL_GS %edx
> -
> +.endif
>  	/* Switch to kernel stack if necessary */
>  .if \switch_stacks > 0
>  	SWITCH_TO_KERNEL_STACK
>  .endif
> -
>  .endm
>  
>  .macro SAVE_ALL_NMI cr3_reg:req
> @@ -1448,32 +1450,20 @@ END(page_fault)
>  
>  common_exception:
>  	/* the function address is in %gs's slot on the stack */
> -	FIXUP_FRAME
> -	pushl	%fs
> -	pushl	%es
> -	pushl	%ds
> -	pushl	%eax
> -	movl	$(__USER_DS), %eax
> -	movl	%eax, %ds
> -	movl	%eax, %es
> -	movl	$(__KERNEL_PERCPU), %eax
> -	movl	%eax, %fs
> -	pushl	%ebp
> -	pushl	%edi
> -	pushl	%esi
> -	pushl	%edx
> -	pushl	%ecx
> -	pushl	%ebx
> -	SWITCH_TO_KERNEL_STACK
> +	SAVE_ALL switch_stacks=1 skip_gs=1
>  	ENCODE_FRAME_POINTER
> -	cld

The only code change of this is that cld moved from the end to the
beginning. As this appears to match other SAVE_ALL users with respect
to ENCODE_FRAME_POINTER, this shouldn't be an issue.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve



>  	UNWIND_ESPFIX_STACK
> +
