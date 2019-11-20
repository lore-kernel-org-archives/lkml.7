Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3EB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKTUZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:25:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:7028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfKTUZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:25:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 12:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381490714"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 12:25:16 -0800
Date:   Wed, 20 Nov 2019 12:25:16 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120202516.GD32572@linux.intel.com>
References: <20191120170208.211997-1-jannh@google.com>
 <20191120170208.211997-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120170208.211997-2-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:02:06PM +0100, Jann Horn wrote:
> @@ -509,11 +511,50 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
>  }
>  
> +/*
> + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> + * address, return that address.

Stale comment now that it's decoding canonical addresses too.

> + */
> +static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
> +					   bool *non_canonical)

Alignment of non_canonical is funky.

> +{
> +#ifdef CONFIG_X86_64
> +	u8 insn_buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +
> +	if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
> +		return false;
> +
> +	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
> +	insn_get_modrm(&insn);
> +	insn_get_sib(&insn);
> +	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
> +
> +	if (*addr == (unsigned long)-1L)

Nit, wouldn't -1UL avoid the need to cast?

> +		return false;
> +
> +	/*
> +	 * Check that:
> +	 *  - the address is not in the kernel half or -1 (which means the
> +	 *    decoder failed to decode it)
> +	 *  - the last byte of the address is not in the user canonical half
> +	 */

This -1 part of the comment should be moved above, or probably dropped
entirely.

> +	*non_canonical = *addr < ~__VIRTUAL_MASK &&
> +			 *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK;
> +
> +	return true;
> +#else
> +	return false;
> +#endif
> +}
> +
> +#define GPFSTR "general protection fault"
> +
>  dotraplinkage void
>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> -	const char *desc = "general protection fault";
>  	struct task_struct *tsk;
> +	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
>  
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>  	cond_local_irq_enable(regs);
> @@ -531,6 +572,10 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  
>  	tsk = current;
>  	if (!user_mode(regs)) {
> +		bool addr_resolved = false;
> +		unsigned long gp_addr;
> +		bool non_canonical;
> +
>  		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
>  			return;
>  
> @@ -547,8 +592,21 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  			return;
>  
>  		if (notify_die(DIE_GPF, desc, regs, error_code,
> -			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> -			die(desc, regs, error_code);
> +			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> +			return;
> +
> +		if (error_code)
> +			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
> +		else
> +			addr_resolved = get_kernel_gp_address(regs, &gp_addr,
> +							      &non_canonical);
> +
> +		if (addr_resolved)
> +			snprintf(desc, sizeof(desc),
> +			    GPFSTR " probably for %saddress 0x%lx",
> +			    non_canonical ? "non-canonical " : "", gp_addr);

I still think not explicitly calling out the straddle case will be
confusing, e.g.

  general protection fault probably for non-canonical address 0x7fffffffffff: 0000 [#1] SMP

versus

  general protection fault, non-canonical access 0x7fffffffffff - 0x800000000006: 0000 [#1] SMP


And for the canonical case, "probably for address" may not be all that
accurate, e.g. #GP(0) due to a instruction specific requirement is arguably
just as likely to apply to the instruction itself as it is to its memory
operand.

Rather than pass around multiple booleans, what about adding an enum and
handling everything in (a renamed) get_kernel_gp_address?  This works
especially well if address decoding is done for 32-bit as well as 64-bit,
which is probably worth doing since we're printing the address in 64-bit
even if it's canonical.  The ifdeffery is really ugly if its 64-bit only...


enum kernel_gp_hint {
	GP_NO_HINT,
	GP_SEGMENT,
	GP_NON_CANONICAL,
	GP_STRADDLE_CANONICAL,
	GP_RESOLVED_ADDR,
};
static int get_kernel_gp_hint(struct pt_regs *regs, unsigned long error_code,
			      unsigned long *addr, unsigned char *size)
{
	u8 insn_buf[MAX_INSN_SIZE];
	struct insn insn;

	if (error_code)
		return GP_SEGMENT;

	if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
		return false;

	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
	insn_get_modrm(&insn);
	insn_get_sib(&insn);
	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
	*size = insn.opnd_bytes;

	if (*addr == -1UL)
		return GP_NO_HINT;

#ifdef CONFIG_X86_64
	if (*addr < ~__VIRTUAL_MASK && *addr > __VIRTUAL_MASK)
		return GP_NON_CANONICAL;

	if (*addr < ~__VIRTUAL_MASK &&
	    (*addr + *size - 1) > __VIRTUAL_MASK)
		return GP_STRADDLE_CANONICAL;
#endif
	return GP_RESOLVED_ADDR;
}

Then the snprintf sequence can handle each case indvidually.

		hint = get_kernel_gp_hint(regs, error_code, &addr, &size);
		if (hint == GP_SEGMENT)
			snprintf(desc, sizeof(desc),
				 GPFSTR ", for segment 0x%lx", error_code);
		else if (hint == GP_NON_CANONICAL)
			snprintf(desc, sizeof(desc),
				 GPFSTR ", non-canonical address 0x%lx", addr);
		else if (hint == GP_STRADDLE_CANONICAL)
			snprintf(desc, sizeof(desc),
				 GPFSTR ", non-canonical access 0x%lx - 0x%lx",
				 addr, addr + size - 1);
		else if (hint == GP_RESOLVED_ADDR)
			snprintf(desc, sizeof(desc),
				 GPFSTR ", possibly for access 0x%lx - 0x%lx",
				 addr, addr + size - 1);

		flags = oops_begin();
		sig = SIGSEGV;
		__die_header(desc, regs, error_code);
		if (hint == GP_NON_CANONICAL || hint == GP_STRADDLE_CANONICAL)
			kasan_non_canonical_hook(addr);
		if (__die_body(desc, regs, error_code))
			sig = 0;
		oops_end(flags, regs, sig);
		die(desc, regs, error_code);


I get that adding a print just for the straddle case is probably overkill,
but it seems silly to add all this and not make it as precise as possible.

  general protection fault, non-canonical address 0xdead000000000000: 0000 [#1] SMP
  general protection fault, non-canonical access 0x7fffffffffff - 0x800000000006: 0000 [#1] SMP
  general protection fault, possibly for address 0xffffc9000021bd90: 0000 [#1] SMP
  general protection fault, possibly for address 0xebcbde5c: 0000 [#1] SMP  // 32-bit kernel


Side topic, opnd_bytes isn't correct for instructions with fixed 64-bit
operands (Mq notation in the opcode map), which is probably an argument
against the fancy straddle logic...


> +		die(desc, regs, error_code);
>  		return;
>  	}
>  
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 
