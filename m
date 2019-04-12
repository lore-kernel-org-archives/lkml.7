Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F1C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899C92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e52fnXng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDLSNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:13:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S8fsam0gvo8Tk0PvjCdBizNMLccGiCFqupFxHNeyggY=; b=e52fnXngZgk79XhYUE8dDfdzn
        Slw7OwzO/O4XkENeSYZDXecM8VHAJxxfcBN+mGhH+la0064AnhCq3hG6QuIY2D1Iu278eg8E9za/w
        fRltrEEDR5AvQpuU4UFtsWCTvVqe5NzledWRo9k0LgQj8XZ5V6LYEUtW4CYXE37Ur/SwGHHkl50K2
        hX9AZ+hmc42XbuwkDVUZtQpe3RI3hD6vKAd0isxpCjFIHOp04aKA040pi0cZJ8i2HcQ9fJVxUkuUB
        ihcS3Ywg9p93voal+qcsjgXWFcHWcN8XKesD75iVfPTy6v9SzsAdzgef5TbMFFppCK/NpDMPlGHjl
        ACnYnQphQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF0gE-0003OW-4j; Fri, 12 Apr 2019 18:13:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB78829B23300; Fri, 12 Apr 2019 20:13:35 +0200 (CEST)
Date:   Fri, 12 Apr 2019 20:13:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Message-ID: <20190412181335.GB12232@hirez.programming.kicks-ass.net>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
 <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E33FDED8-8B95-431D-9AC7-71D45AB49011@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 05:05:53PM +0000, Nadav Amit wrote:
> Peter, what do you say about this one? I assume there are no nested TLB
> flushes, but the code can easily be adapted (assuming there is a limit on
> the nesting level).

Possible. Althoug at this point I think we should just remove the
alignment, and them maybe do this on top later.

> -- >8 --
> 
> Subject: [PATCH] x86: Move flush_tlb_info off the stack
> ---
>  arch/x86/mm/tlb.c | 49 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index bc4bc7b2f075..15fe90d4e3e1 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -14,6 +14,7 @@
>  #include <asm/cache.h>
>  #include <asm/apic.h>
>  #include <asm/uv/uv.h>
> +#include <asm/local.h>
>  
>  #include "mm_internal.h"
>  
> @@ -722,43 +723,63 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>   */
>  unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>  
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(local_t, flush_tlb_info_idx);
> +#endif
> +
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, unsigned int stride_shift,
>  				bool freed_tables)
>  {
> +	struct flush_tlb_info *info;
>  	int cpu;
>  
> -	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
> -		.mm = mm,
> -		.stride_shift = stride_shift,
> -		.freed_tables = freed_tables,
> -	};
> -
>  	cpu = get_cpu();
>  
> +	info = this_cpu_ptr(&flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Ensure that the following code is non-reentrant and flush_tlb_info
> +	 * is not overwritten. This means no TLB flushing is initiated by
> +	 * interrupt handlers and machine-check exception handlers. If needed,
> +	 * we can add additional flush_tlb_info entries.
> +	 */
> +	BUG_ON(local_inc_return(this_cpu_ptr(&flush_tlb_info_idx)) != 1);

That's what we have this_cpu_inc_return() for.

> +#endif
> +
> +	info->mm = mm;
> +	info->stride_shift = stride_shift;
> +	info->freed_tables = freed_tables;
> +
>  	/* This is also a barrier that synchronizes with switch_mm(). */
> -	info.new_tlb_gen = inc_mm_tlb_gen(mm);
> +	info->new_tlb_gen = inc_mm_tlb_gen(mm);
>  
>  	/* Should we flush just the requested range? */
>  	if ((end != TLB_FLUSH_ALL) &&
>  	    ((end - start) >> stride_shift) <= tlb_single_page_flush_ceiling) {
> -		info.start = start;
> -		info.end = end;
> +		info->start = start;
> +		info->end = end;
>  	} else {
> -		info.start = 0UL;
> -		info.end = TLB_FLUSH_ALL;
> +		info->start = 0UL;
> +		info->end = TLB_FLUSH_ALL;
>  	}
>  
>  	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
> -		VM_WARN_ON(irqs_disabled());
> +		lockdep_assert_irqs_enabled();
>  		local_irq_disable();
> -		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
>  		local_irq_enable();
>  	}
>  
>  	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -		flush_tlb_others(mm_cpumask(mm), &info);
> +		flush_tlb_others(mm_cpumask(mm), info);
>  
> +#ifdef CONFIG_DEBUG_VM
> +	barrier();
> +	local_dec(this_cpu_ptr(&flush_tlb_info_idx));

this_cpu_dec();

> +#endif
>  	put_cpu();
>  }
>  
> -- 
> 2.17.1
> 
> 
