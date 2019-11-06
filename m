Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A406C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16617217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="b9gId18g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfKFJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:53:00 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKFJxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:53:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 477MKM0M9xz9sP6;
        Wed,  6 Nov 2019 20:52:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573033977;
        bh=izSF2AL2NQDyQCu8234O8zrZSbgYgjyqHCG8/iEWwGs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=b9gId18gagaVywR+++g4RbfioORzpLVEpkQFDfoe6YJ+Id1Hyjjq/06ICOZfwGQ7s
         uEw327gffeKFiSAHkylzMZ/SlvyUFoOtryquxAkEd7UwW0ywC33JL/TU521FoKipgm
         nmhtWZg0/lLCyrcslap1+XDAoBZSrMxItWvQ1SmJ9RNfGuYMWc2c3X59G7Im5DKs8u
         dmxP/7vER/jwGiOjnVMTWRO07UPpgf8NEYrfqsa0inOKOjfQLe+sscQL5S6RbDv/aq
         ZbSIdMDPaAr0Z/SRZSv1GMd4yPv/NNcs1Bjn+vaWsmgj+XcmuizMxkiy294kyreFAY
         5s6eorQGvCfXg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 26/50] powerpc: Add show_stack_loglvl()
In-Reply-To: <20191106030542.868541-27-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com> <20191106030542.868541-27-dima@arista.com>
Date:   Wed, 06 Nov 2019 20:52:52 +1100
Message-ID: <8736f172mj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).

Yes, I've had bug reports where the stacktrace is missing, which is
annoying. Thanks for trying to fix the problem.

> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
>
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
>
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/powerpc/kernel/process.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

This looks good to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers


> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 639ceae7da9d..34b46680a196 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2028,7 +2028,8 @@ unsigned long get_wchan(struct task_struct *p)
>  
>  static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
>  
> -void show_stack(struct task_struct *tsk, unsigned long *stack)
> +void show_stack_loglvl(struct task_struct *tsk, unsigned long *stack,
> +		       const char *loglvl)
>  {
>  	unsigned long sp, ip, lr, newsp;
>  	int count = 0;
> @@ -2053,7 +2054,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  	}
>  
>  	lr = 0;
> -	printk("Call Trace:\n");
> +	printk("%sCall Trace:\n", loglvl);
>  	do {
>  		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
>  			break;
> @@ -2062,7 +2063,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  		newsp = stack[0];
>  		ip = stack[STACK_FRAME_LR_SAVE];
>  		if (!firstframe || ip != lr) {
> -			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
> +			printk("%s["REG"] ["REG"] %pS",
> +				loglvl, sp, ip, (void *)ip);
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  			ret_addr = ftrace_graph_ret_addr(current,
>  						&ftrace_idx, ip, stack);
> @@ -2084,8 +2086,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  			struct pt_regs *regs = (struct pt_regs *)
>  				(sp + STACK_FRAME_OVERHEAD);
>  			lr = regs->link;
> -			printk("--- interrupt: %lx at %pS\n    LR = %pS\n",
> -			       regs->trap, (void *)regs->nip, (void *)lr);
> +			printk("%s--- interrupt: %lx at %pS\n    LR = %pS\n",
> +			       loglvl, regs->trap,
> +			       (void *)regs->nip, (void *)lr);
>  			firstframe = 1;
>  		}
>  
> @@ -2095,6 +2098,11 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  	put_task_stack(tsk);
>  }
>  
> +void show_stack(struct task_struct *tsk, unsigned long *stack)
> +{
> +	show_stack_loglvl(tsk, stack, KERN_DEFAULT);
> +}
> +
>  #ifdef CONFIG_PPC64
>  /* Called with hard IRQs off */
>  void notrace __ppc64_runlatch_on(void)
> -- 
> 2.23.0
