Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C962077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220576;
	bh=EOewyryj1zrcIWKvZ4isQHfpoxgDJ66BTUBp7HGRWQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IfSJK59F+srZ3AzNwOkT0rw0kcPyN6ofN0poukKUvHJXioP1VHefsg+c0ksG0D8gt
	 P4RJZWf1F9Xavir9YKzy4sYOPGL+Ygd6Pg2TeYdHEk8kN5DPHdIWOypd1nhdOtrvyg
	 1VpMs9SqGzLtmIZ84b1zeXwtG1SxJVY0umZaWo8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfDYT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:29:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDYT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:29:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so696370wmk.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9swn068NMwgMlcOgr1i2VTceDu71rXceG291N2Z51Og=;
        b=MYaLlhamNoCazWYKPFFvjKcWJrNRTygEXp58F1gC5+ULbxZFHqvfFb7n0dj2Frs3e7
         dlee88891C62n8XEwfTNtqXWALHaGq8WvHItn+/jkzjrSFaXsyn35YKzknS5U7sNxu7G
         lwvqkw9v28vIcys/C7iBcO71z46cNna19omt2vP6eShICakXeRS22Lj1L1J9qaTYMJo8
         +j2PNWol6BYFOAt7Zy+GpXDMvLqHOrk13ftLGp3ci+mygR7woMK/rS5L0nWTpRW2URN3
         nrL8ha7MMRHxlAO2C9IyyBYu99aEyFlEecv5ehQ4Di2ZqJ782VCGixfb1LddQ2PXGHse
         qVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9swn068NMwgMlcOgr1i2VTceDu71rXceG291N2Z51Og=;
        b=Gzj6uL+ezextq8i6AvvBUwM4DMwWlcCY3AoheqcaGe5pTPVH0xtmkVLkjRG2HUD+AG
         u+WrNd3mCkSGkUBvrzZS8DcruHWu05qrKFTSRUhfj6+0rh+/G/HsA53ILbQ0U+V5qAqG
         IhQno8wlJIv2OEwHycsFfyqJJNhX+yaNC9FlgrjR3Thwg4/nkDWD3xC44oD6fbKBmPeU
         y+Ev3vR/NJ1muYurYuieljH0MkPfET7L/ueeHr85XoCVVHQclSk15Bj/5E4S2DSP9wBs
         5xusMefcdmt2G9jQL9dC08wBu2/7uUFgKmRHe9synmi3luF0I7HmhZ3epw9kXHi9g+C9
         Xdbw==
X-Gm-Message-State: APjAAAXR02M9xaUiqxyg/ygYv+vfRvapA291x9H2/hNhBNkGqWWpRSB3
        X6dQaWXpR7hhJjMDCe5U988=
X-Google-Smtp-Source: APXvYqz6Q5bw/iwHElDCkJqv0QWfQxLQFDRELN6/adq/3BevSGuZZSxkYm9LiQzAyNAVMJ6p7D5HTg==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr4614332wmc.49.1556220572880;
        Thu, 25 Apr 2019 12:29:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a13sm7034710wmj.39.2019.04.25.12.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:29:32 -0700 (PDT)
Date:   Thu, 25 Apr 2019 21:29:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Message-ID: <20190425192930.GA91578@gmail.com>
References: <20190425180828.24959-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425180828.24959-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Move flush_tlb_info variables off the stack. This allows to align
> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> line movements. It also allows to have a fixed virtual-to-physical
> translation of the variables, which reduces TLB misses.
> 
> Use per-CPU struct for flush_tlb_mm_range() and
> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> no nested TLB flushes that might overwrite the per-CPU data. For
> arch_tlbbatch_flush() use a const struct.
> 
> Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
> operations and touching a page, in which 3 additional threads run a
> busy-wait loop (5 runs, PTI and retpolines are turned off):
> 
> 			base		off-stack
> 			----		---------
> avg (usec/op)		1.629		1.570	(-3%)
> stddev			0.014		0.009
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> 
> ---
> 
> v1->v2:
> - Initialize all flush_tlb_info fields [Andy]
> ---
>  arch/x86/mm/tlb.c | 100 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 487b8474c01c..aac191eb2b90 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -634,7 +634,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>  	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
>  }
>  
> -static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
> +static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
>  {
>  	const struct flush_tlb_info *f = info;
>  
> @@ -722,43 +722,81 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>   */
>  unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>  
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
> +#endif
> +
> +static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
> +			unsigned long start, unsigned long end,
> +			unsigned int stride_shift, bool freed_tables,
> +			u64 new_tlb_gen)
> +{
> +	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Ensure that the following code is non-reentrant and flush_tlb_info
> +	 * is not overwritten. This means no TLB flushing is initiated by
> +	 * interrupt handlers and machine-check exception handlers.
> +	 */
> +	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
> +#endif

isn't this effectively VM_BUG_ON()?

> +
> +	info->start = start;
> +	info->end = end;
> +	info->mm = mm;
> +	info->stride_shift = stride_shift;
> +	info->freed_tables = freed_tables;
> +	info->new_tlb_gen = new_tlb_gen;

This pattern is really asking for a bit more tabulation:

	info->start		= start;
	info->end		= end;
	info->mm		= mm;
	info->stride_shift	= stride_shift;
	info->freed_tables	= freed_tables;
	info->new_tlb_gen	= new_tlb_gen;

> +static inline void put_flush_tlb_info(void)
> +{
> +#ifdef CONFIG_DEBUG_VM
> +	/* Complete reentrency prevention checks */
> +	barrier();
> +	this_cpu_dec(flush_tlb_info_idx);
> +#endif

In principle this_cpu_dec() should imply a compiler barrier?

> +	if ((end == TLB_FLUSH_ALL) ||
> +	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
> +		start = 0UL;

Any reason why we cannot use the '0' numeric literal here?

> +		struct flush_tlb_info *info;
> +
> +		preempt_disable();
> +
> +		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
> +
> +		info = this_cpu_ptr(&flush_tlb_info);
> +		info->start = start;
> +		info->end = end;
> +
> +		on_each_cpu(do_kernel_range_flush, info, 1);
> +
> +		put_flush_tlb_info();
> +
> +		preempt_enable();

>  	}
>  }
>  
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
> -	struct flush_tlb_info info = {
> +	static const struct flush_tlb_info info = {
>  		.mm = NULL,
>  		.start = 0UL,
>  		.end = TLB_FLUSH_ALL,

Could you please move this now .data global variable just before the 
function, to make it more apparent what's going on?

Thanks,

	Ingo
