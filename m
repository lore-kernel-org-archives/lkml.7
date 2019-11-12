Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD00C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E76E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKLJtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:49:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbfKLJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:49:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D48DB039;
        Tue, 12 Nov 2019 09:49:18 +0000 (UTC)
Date:   Tue, 12 Nov 2019 10:49:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] xtensa: improve stack dumping
Message-ID: <20191112094917.fl57dhtennwo2tlz@pathway.suse.cz>
References: <20191108004448.5386-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108004448.5386-1-jcmvbkbc@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-07 16:44:48, Max Filippov wrote:
> Calculate printable stack size and use print_hex_dump instead of
> opencoding it.
> Make size of stack dump configurable.
> Drop extra newline output in show_trace as its output format does not
> depend on CONFIG_KALLSYMS.

> diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
> index 39de98e20018..83cc8d12fa0e 100644
> --- a/arch/xtensa/Kconfig.debug
> +++ b/arch/xtensa/Kconfig.debug
> @@ -31,3 +31,10 @@ config S32C1I_SELFTEST
>  	  It is easy to make wrong hardware configuration, this test should catch it early.
>  
>  	  Say 'N' on stable hardware.
> +
> +config PRINT_STACK_DEPTH
> +	int "Stack depth to print" if DEBUG_KERNEL
> +	default 64
> +	help
> +	  This option allows you to set the stack depth that the kernel
> +	  prints in stack traces.

I would split this into separate patch.

> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index 4a6c495ce9b6..fe090ab1cab8 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> @@ -491,32 +491,24 @@ void show_trace(struct task_struct *task, unsigned long *sp)
>  
>  	pr_info("Call Trace:\n");
>  	walk_stackframe(sp, show_trace_cb, NULL);
> -#ifndef CONFIG_KALLSYMS
> -	pr_cont("\n");
> -#endif
>  }
>  
> -static int kstack_depth_to_print = 24;
> +static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
>  
>  void show_stack(struct task_struct *task, unsigned long *sp)
>  {
> -	int i = 0;
> -	unsigned long *stack;
> +	size_t len;
>  
>  	if (!sp)
>  		sp = stack_pointer(task);
> -	stack = sp;
>  
> -	pr_info("Stack:\n");
> +	len = min((-(unsigned long)sp) & (THREAD_SIZE - 4),
> +		  kstack_depth_to_print * 4ul);

I would replace the hardcoded 4 with sizeof(void *).

>  
> -	for (i = 0; i < kstack_depth_to_print; i++) {
> -		if (kstack_end(sp))
> -			break;
> -		pr_cont(" %08lx", *sp++);
> -		if (i % 8 == 7)
> -			pr_cont("\n");
> -	}
> -	show_trace(task, stack);
> +	pr_info("Stack:\n");
> +	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE, 32, 4,
> +		       sp, len, false);
> +	show_trace(task, sp);
>  }

The conversion looks fine to me. It is up to you (as a maintainer)
what you do with the above proposal for two cosmetic changes ;-)
Either way, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
