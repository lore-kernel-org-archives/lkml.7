Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594A206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLSZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfKLSZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:25:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7899921E6F;
        Tue, 12 Nov 2019 18:25:38 +0000 (UTC)
Date:   Tue, 12 Nov 2019 13:25:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191112132536.28ac1b32@gandalf.local.home>
In-Reply-To: <20191111132457.761255803@infradead.org>
References: <20191111131252.921588318@infradead.org>
        <20191111132457.761255803@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 14:12:57 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -34,6 +34,8 @@
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> +static int ftrace_poke_late = 0;
> +
>  int ftrace_arch_code_modify_prepare(void)
>      __acquires(&text_mutex)
>  {
> @@ -43,16 +45,15 @@ int ftrace_arch_code_modify_prepare(void
>  	 * ftrace has it set to "read/write".
>  	 */
>  	mutex_lock(&text_mutex);
> -	set_kernel_text_rw();
> -	set_all_modules_text_rw();
> +	ftrace_poke_late = 1;
>  	return 0;
>  }
>  
>  int ftrace_arch_code_modify_post_process(void)
>      __releases(&text_mutex)
>  {
> -	set_all_modules_text_ro();
> -	set_kernel_text_ro();
> +	text_poke_finish();

Why is the text_poke_finish() needed here? Can we add a comment about
why?


> +	ftrace_poke_late = 0;
>  	mutex_unlock(&text_mutex);
>  	return 0;
>  }
> @@ -60,67 +61,34 @@ int ftrace_arch_code_modify_post_process
>  union ftrace_code_union {
>  	char code[MCOUNT_INSN_SIZE];
>  	struct {
> -		unsigned char op;
> +		char op;
>  		int offset;
>  	} __attribute__((packed));
>  };
>  
> -static int ftrace_calc_offset(long ip, long addr)
> -{
> -	return (int)(addr - ip);
> -}
> -
> -static unsigned char *
> -ftrace_text_replace(unsigned char op, unsigned long ip, unsigned long addr)
> +static const char *ftrace_text_replace(char op, unsigned long ip, unsigned long addr)
>  {
>  	static union ftrace_code_union calc;
>  
> -	calc.op		= op;
> -	calc.offset	= ftrace_calc_offset(ip + MCOUNT_INSN_SIZE, addr);
> +	calc.op = op;
> +	calc.offset = (int)(addr - (ip + MCOUNT_INSN_SIZE));
>  
>  	return calc.code;
>  }

[..]

>  /* Return the address of the function the trampoline calls */
> @@ -981,19 +555,18 @@ void arch_ftrace_trampoline_free(struct
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  extern void ftrace_graph_call(void);
>  
> -static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
> +static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
>  {
> -	return ftrace_text_replace(0xe9, ip, addr);
> +	return ftrace_text_replace(JMP32_INSN_OPCODE, ip, addr);
>  }
>  
>  static int ftrace_mod_jmp(unsigned long ip, void *func)
>  {
> -	unsigned char *new;
> +	const char *new;
>  
> -	ftrace_update_func_call = 0UL;
>  	new = ftrace_jmp_replace(ip, (unsigned long)func);
> -
> -	return update_ftrace_func(ip, new);
> +	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL); // BATCH

What do you mean by "BATCH" ?

-- Steve

> +	return 0;
>  }
>  
>  int ftrace_enable_ftrace_graph_caller(void)
> @@ -1019,10 +592,9 @@ int ftrace_disable_ftrace_graph_caller(v
>  void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  			   unsigned long frame_pointer)
>  {
> +	unsigned long return_hooker = (unsigned long)&return_to_handler;
>  	unsigned long old;
>  	int faulted;
> -	unsigned long return_hooker = (unsigned long)
> -				&return_to_handler;
>  
>  	/*
>  	 * When resuming from suspend-to-ram, this function can be indirectly
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -563,15 +563,6 @@ NOKPROBE_SYMBOL(do_general_protection);
>  
>  dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
>  {
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -	/*
> -	 * ftrace must be first, everything else may cause a recursive crash.
> -	 * See note by declaration of modifying_ftrace_code in ftrace.c
> -	 */
> -	if (unlikely(atomic_read(&modifying_ftrace_code)) &&
> -	    ftrace_int3_handler(regs))
> -		return;
> -#endif
>  	if (poke_int3_handler(regs))
>  		return;
>  
> 

