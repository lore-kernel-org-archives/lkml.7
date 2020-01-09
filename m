Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D192072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgAIQtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:49:04 -0500
Received: from foss.arm.com ([217.140.110.172]:34536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:49:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0BE1FB;
        Thu,  9 Jan 2020 08:49:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742D23F703;
        Thu,  9 Jan 2020 08:49:01 -0800 (PST)
Date:   Thu, 9 Jan 2020 16:48:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, catalin.marinas@arm.com, duwe@lst.de
Subject: Re: [RFC PATCH] arm64/ftrace: support dynamically allocated
 trampolines
Message-ID: <20200109164858.GH3112@lakrids.cambridge.arm.com>
References: <20200109142736.1122-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109142736.1122-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:27:36PM +0000, Cheng Jian wrote:
> When we tracing multiple functions, it has to use a list
> function and cause all the other functions being traced
> to check the hash of the ftrace_ops. But this is very
> inefficient.

Just how bad is this, and when/where does it matter?

How much does this patch improve matters?

> we can call a dynamically allocated trampoline which calls
> the callback directly to solve this problem. This patch
> introduce dynamically alloced trampolines for ARM64.
> 
> If a callback is registered to a function and there's no
> other callback registered to that function, the ftrace_ops
> will get its own trampoline allocated for it that will call
> the function directly.
> 
> We merge two functions (ftrace_caller/ftrace_regs_caller and
> ftrace_common) into one function, so we no longer need a jump
> to ftrace_common and fix it to NOP.
> 
> similar to X86_64, save the local ftrace_ops at the end.
> 
> the ftrace trampoline layout :
> 
>                           low
> ftrace_(regs_)caller  => +---------------+
>                          | ftrace_caller |
> ftrace_common         => +---------------+
>                          | ftrace_common |
> function_trace_op_ptr => | ...           | ldr x2, <ftrace_ops>
>            |             | b ftrace_stub |
>            |             | nop           | fgraph call
>            |             +---------------+
>            +------------>| ftrace_ops    |
>                          +---------------+
>                          | PLT entrys    | (TODO)
>                          +---------------+
>                           high
> 
> Known issues :
> If kaslr is enabled, the address of tramp and ftrace call
> may be far away. Therefore, long jump support is required.
> Here I intend to use the same solution as module relocating,
> Reserve enough space for PLT at the end when allocating, can
> use PLT to complete these long jumps.

This can happen both ways; the callsite can also be too far from the
trampoline to be able to branch to it.

I've had issues with that for other reasons, and I think that we might
be able to use -fpatchable-function-entry=N,M to place a PLT immediately
before each function for that. However, I'm wary of doing so because it
makes it much harder to modify the patch site itself.

> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  arch/arm64/kernel/entry-ftrace.S |   4 +
>  arch/arm64/kernel/ftrace.c       | 310 +++++++++++++++++++++++++++++++
>  2 files changed, 314 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 7d02f9966d34..f5ee797804ac 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -77,17 +77,20 @@
>  
>  ENTRY(ftrace_regs_caller)
>  	ftrace_regs_entry	1
> +GLOBAL(ftrace_regs_caller_end)
>  	b	ftrace_common
>  ENDPROC(ftrace_regs_caller)
>  
>  ENTRY(ftrace_caller)
>  	ftrace_regs_entry	0
> +GLOBAL(ftrace_caller_end)
>  	b	ftrace_common
>  ENDPROC(ftrace_caller)
>  
>  ENTRY(ftrace_common)
>  	sub	x0, x30, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
>  	mov	x1, x9				// parent_ip (callsite's LR)
> +GLOBAL(function_trace_op_ptr)
>  	ldr_l	x2, function_trace_op		// op
>  	mov	x3, sp				// regs
>  
> @@ -121,6 +124,7 @@ ftrace_common_return:
>  	/* Restore the callsite's SP */
>  	add	sp, sp, #S_FRAME_SIZE + 16
>  
> +GLOBAL(ftrace_common_end)
>  	ret	x9

This doesn't look right. Surely you want the RET, too?

>  ENDPROC(ftrace_common)
>  
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 8618faa82e6d..95ea68ef6228 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -10,11 +10,13 @@
>  #include <linux/module.h>
>  #include <linux/swab.h>
>  #include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
> +#include <asm/set_memory.h>
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /*
> @@ -47,6 +49,314 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>  	return 0;
>  }
>  
> +/* ftrace dynamic trampolines */
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef CONFIG_MODULES
> +#include <linux/moduleloader.h>
> +
> +static inline void *alloc_tramp(unsigned long size)
> +{
> +	return module_alloc(size);
> +}
> +
> +static inline void tramp_free(void *tramp)
> +{
> +	module_memfree(tramp);
> +}
> +#else
> +static inline void *alloc_tramp(unsigned long size)
> +{
> +	return NULL;
> +}
> +
> +static inline void tramp_free(void *tramp) {}
> +#endif
> +
> +extern void ftrace_regs_caller_end(void);
> +extern void ftrace_caller_end(void);
> +extern void ftrace_common(void);
> +extern void ftrace_common_end(void);
> +
> +extern void function_trace_op_ptr(void);
> +
> +extern struct ftrace_ops *function_trace_op;
> +
> +/*
> + * ftrace_caller() or ftrace_regs_caller() trampoline
> + *				+-----------------------+
> + * ftrace_(regs_)caller =>	|	......		|
> + * ftrace_(regs_)caller_end =>	| b ftrace_common	| => nop
> + *				+-----------------------+
> + * ftrace_common =>		|	......		|
> + * function_trace_op_ptr =>	| adrp x2, sym		| => nop
> + *				| ldr  x2,[x2,:lo12:sym]| => ldr x2 <ftrace_op>
> + *				|	......		|
> + * ftrace_common_end  =>	|	retq		|

Copy-paste from x86? arm64 doesn't have a retq instruction.

> + *				+-----------------------+
> + * ftrace_opt =>		|	ftrace_opt	|
> + *				+-----------------------+

Typo: s/opt/ops/ ?

> + */
> +static unsigned long create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
> +{
> +	unsigned long start_offset_caller, end_offset_caller, caller_size;
> +	unsigned long start_offset_common, end_offset_common, common_size;
> +	unsigned long op_offset, offset, size, ip, npages;
> +	void *trampoline;
> +	unsigned long *ptr;
> +	/* ldr x2, <label> */
> +	u32 pc_ldr = 0x58000002;
> +	u32 mask = BIT(19) - 1;

Instead of open-coding this, please teach the insn framework how to
encode LDR (immediate).

> +	int shift = 5;
> +	int ret;
> +	u32 nop;
> +
> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> +		start_offset_caller = (unsigned long)ftrace_regs_caller;
> +		end_offset_caller = (unsigned long)ftrace_regs_caller_end;
> +	} else {
> +		start_offset_caller = (unsigned long)ftrace_caller;
> +		end_offset_caller = (unsigned long)ftrace_caller_end;
> +	}
> +	start_offset_common = (unsigned long)ftrace_common;
> +	end_offset_common = (unsigned long)ftrace_common_end;
> +
> +	op_offset = (unsigned long)function_trace_op_ptr;
> +
> +	/*
> +	 * Merge ftrace_caller/ftrace_regs_caller and ftrace_common
> +	 * to one function in ftrace trampoline.
> +	 */
> +	caller_size = end_offset_caller - start_offset_caller + AARCH64_INSN_SIZE;
> +	common_size = end_offset_common - start_offset_common + AARCH64_INSN_SIZE;
> +	size = caller_size + common_size;
> +
> +	trampoline = alloc_tramp(caller_size + common_size + sizeof(void *));
> +	if (!trampoline)
> +		return 0;
> +
> +	*tramp_size = caller_size + common_size + sizeof(void *);
> +	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
> +
> +	/* Copy ftrace_caller/ftrace_regs_caller onto the trampoline memory */
> +	ret = probe_kernel_read(trampoline, (void *)start_offset_caller, caller_size);
> +	if (WARN_ON(ret < 0))
> +		goto free;
> +
> +	/*
> +	 * Copy ftrace_common to the trampoline memory
> +	 * below ftrace_caller/ftrace_regs_caller. so
> +	 * we can merge the two function to one function.
> +	 */
> +	ret = probe_kernel_read(trampoline + caller_size, (void *)start_offset_common, common_size);
> +	if (WARN_ON(ret < 0))
> +		goto free;
> +
> +	/*
> +	 * We merge the two functions to one function, so these is
> +	 * no need to use jump instructions to ftrace_common, modify
> +	 * it to NOP.
> +	 */
> +	ip = (unsigned long)trampoline + caller_size - AARCH64_INSN_SIZE;
> +	nop = aarch64_insn_gen_nop();
> +	memcpy((void *)ip, &nop, AARCH64_INSN_SIZE);
> +
> +	/*
> +	 * Stored ftrace_ops at the end of the trampoline.
> +	 * This will be used to load the third parameter for the callback.
> +	 * Basically, that location at the end of the trampoline takes the
> +	 * place of the global function_trace_op variable.
> +	 */
> +	ptr = (unsigned long *)(trampoline + size);
> +	*ptr = (unsigned long)ops;
> +
> +	/*
> +	 * Update the trampoline ops REF
> +	 *
> +	 * OLD INSNS : ldr_l x2, function_trace_op
> +	 *	adrp	x2, sym
> +	 *	ldr	x2, [x2, :lo12:\sym]
> +	 *
> +	 * NEW INSNS:
> +	 *	nop
> +	 *	ldr x2, <ftrace_ops>
> +	 */
> +	op_offset -= start_offset_common;
> +	ip = (unsigned long)trampoline + caller_size + op_offset;
> +	nop = aarch64_insn_gen_nop();
> +	memcpy((void *)ip, &nop, AARCH64_INSN_SIZE);
> +
> +	op_offset += AARCH64_INSN_SIZE;
> +	ip = (unsigned long)trampoline + caller_size + op_offset;
> +	offset = (unsigned long)ptr - ip;
> +	if (WARN_ON(offset % AARCH64_INSN_SIZE != 0))
> +		goto free;
> +	offset = offset / AARCH64_INSN_SIZE;
> +	pc_ldr |= (offset & mask) << shift;
> +	memcpy((void *)ip, &pc_ldr, AARCH64_INSN_SIZE);

I think it would be much better to have a separate template for the
trampoline which we don't have to patch in this way. It can even be
placed into a non-executable RO section, since the template shouldn't be
executed directly.

> +
> +	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
> +
> +	set_vm_flush_reset_perms(trampoline);
> +
> +	/*
> +	 * Module allocation needs to be completed by making the page
> +	 * executable. The page is still writable, which is a security hazard,
> +	 * but anyhow ftrace breaks W^X completely.
> +	 */
> +	set_memory_x((unsigned long)trampoline, npages);

Why is the page still writeable? Surely you can make it RO first?

Please do not break W^X restrictions; we've tried to ensure that arm64
does the right thing by default here.

Note that arm64's ftrace_modify_code() will use a writeable alias, so it
can be used after the memory has been marked RO.

> +
> +	return (unsigned long)trampoline;
> +
> +free:
> +	tramp_free(trampoline);
> +	return 0;
> +}
> +
> +static unsigned long calc_trampoline_call_offset(struct ftrace_ops *ops)
> +{
> +	unsigned call_offset, end_offset, offset;
> +
> +	call_offset = (unsigned long)&ftrace_call;
> +	end_offset = (unsigned long)ftrace_common_end;
> +	offset = end_offset - call_offset;
> +
> +	return ops->trampoline_size - AARCH64_INSN_SIZE - sizeof(void *) - offset;
> +}
> +
> +static int ftrace_trampoline_modify_call(struct ftrace_ops *ops)
> +{
> +	unsigned long offset;
> +	unsigned long pc;
> +	ftrace_func_t func;
> +	u32 new;
> +
> +	offset = calc_trampoline_call_offset(ops);
> +	pc = ops->trampoline + offset;
> +
> +	func = ftrace_ops_get_func(ops);
> +	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func, AARCH64_INSN_BRANCH_LINK);
> +
> +	return ftrace_modify_code(pc, 0, new, false);
> +}
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +
> +static unsigned long calc_trampoline_graph_call_offset(struct ftrace_ops *ops)
> +{
> +	unsigned end_offset, call_offset, offset;
> +
> +	call_offset = (unsigned long)&ftrace_graph_call;
> +	end_offset = (unsigned long)ftrace_common_end;
> +	offset = end_offset - call_offset;
> +
> +	return ops->trampoline_size - AARCH64_INSN_SIZE - sizeof(void *) - offset;
> +}
> +
> +extern int ftrace_graph_active;
> +static int ftrace_trampoline_modify_graph_call(struct ftrace_ops *ops)
> +{
> +	unsigned long offset;
> +	unsigned long pc;
> +	u32 branch, nop;
> +
> +	offset = calc_trampoline_graph_call_offset(ops);
> +	pc = ops->trampoline + offset;
> +
> +	branch = aarch64_insn_gen_branch_imm(pc,
> +					     (unsigned long)ftrace_graph_caller,
> +					     AARCH64_INSN_BRANCH_NOLINK);
> +	nop = aarch64_insn_gen_nop();
> +
> +	if (ftrace_graph_active)
> +		return ftrace_modify_code(pc, 0, branch, false);
> +	else
> +		return ftrace_modify_code(pc, 0, nop, false);
> +}

It should be posbile to share the bulk of this code with the non-graph
versions.

Thanks,
Mark.
