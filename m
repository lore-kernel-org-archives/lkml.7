Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200E206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfKNRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:46:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:48423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKNRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:46:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="207868279"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 09:46:30 -0800
Date:   Thu, 14 Nov 2019 09:46:30 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191114174630.GF24045@linux.intel.com>
References: <20191112211002.128278-1-jannh@google.com>
 <20191112211002.128278-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112211002.128278-2-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:10:01PM +0100, Jann Horn wrote:
> A frequent cause of #GP exceptions are memory accesses to non-canonical
> addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> the kernel doesn't currently print the fault address for #GP.
> Luckily, we already have the necessary infrastructure for decoding X86
> instructions and computing the memory address that is being accessed;
> hook it up to the #GP handler so that we can figure out whether the #GP
> looks like it was caused by a non-canonical address, and if so, print
> that address.
> 
> While it is already possible to compute the faulting address manually by
> disassembling the opcode dump and evaluating the instruction against the
> register dump, this should make it slightly easier to identify crashes
> at a glance.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/kernel/traps.c | 45 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c90312146da0..479cfc6e9507 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -56,6 +56,8 @@
>  #include <asm/mpx.h>
>  #include <asm/vm86.h>
>  #include <asm/umip.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -509,6 +511,42 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
>  }
>  
> +/*
> + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> + * address, print that address.
> + */
> +static void print_kernel_gp_address(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_X86_64
> +	u8 insn_bytes[MAX_INSN_SIZE];
> +	struct insn insn;
> +	unsigned long addr_ref;
> +
> +	if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> +		return;
> +
> +	kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> +	insn_get_modrm(&insn);
> +	insn_get_sib(&insn);
> +	addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
> +
> +	/*
> +	 * If insn_get_addr_ref() failed or we got a canonical address in the
> +	 * kernel half, bail out.
> +	 */
> +	if ((addr_ref | __VIRTUAL_MASK) == ~0UL)
> +		return;
> +	/*
> +	 * For the user half, check against TASK_SIZE_MAX; this way, if the
> +	 * access crosses the canonical address boundary, we don't miss it.
> +	 */
> +	if (addr_ref <= TASK_SIZE_MAX)

Any objection to open coding the upper bound instead of using
TASK_SIZE_MASK to make the threshold more obvious?

> +		return;
> +
> +	pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);

Printing the raw address will confuse users in the case where the access
straddles the lower canonical boundary.  Maybe combine this with open
coding the straddle case?  With a rough heuristic to hedge a bit for
instructions whose operand size isn't accurately reflected in opnd_bytes.

	if (addr_ref > __VIRTUAL_MASK)
		pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
	else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
		pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
			 addr_ref, addr_ref + insn->opnd_bytes - 1);
	else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
		pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
			 addr_ref, addr_ref + PAGE_SIZE - 1);

> +#endif
> +}
> +
>  dotraplinkage void
>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> @@ -547,8 +585,11 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  			return;
>  
>  		if (notify_die(DIE_GPF, desc, regs, error_code,
> -			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> -			die(desc, regs, error_code);
> +			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> +			return;
> +
> +		print_kernel_gp_address(regs);

This can be conditional on '!error_code', non-canonical faults on the
direct access always have zero for the error code.  Doubt it will matter
in practice, but far calls and other silly segment instructions can
generate non-zero error codes on #GP in 64-bit mode.

> +		die(desc, regs, error_code);
>  		return;
>  	}
>  
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 
