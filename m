Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE9AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B1321951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LK7rq+Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfGYR3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:29:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfGYR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HoO6xqK/GBaL96N6V+tqdVamLqQPoZ/x5PiTNdy5VKk=; b=LK7rq+JskfBnWPbtFsLbM1Ode
        xuwXaNnVOxr1AuEM1QDPeMLzrnv5UZo6wFVO+lEh4URPbSyxmXAZrzATaANTAsQqV/U+Y/cfwYrb9
        P769RldFP04MrJeDndqJAXvmn0n8gO5nrBGRKEJEk0YnCX0NRrCWc4X5hjnT4ztZdRG80h2wJXbXa
        A3xv3qQVb93kpjn76pACx2ZgMpPG9cQF59jJlBxMxSGBHu8QbQA7KP3YsX4UN/WSeyyHyu57ERnKy
        VpwM3UbIt94+H7E5ksJPedt93fNgFnCrP2G73rWoL4wBI9xWmK1EzXQp9Sj2TBInlsztNTqXHdU/o
        oyqLlWDWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqhY1-0006np-Or; Thu, 25 Jul 2019 17:28:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 494852076726E; Thu, 25 Jul 2019 19:28:54 +0200 (CEST)
Date:   Thu, 25 Jul 2019 19:28:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/hw_breakpoint: Prevent data breakpoints on
 cpu_entry_area
Message-ID: <20190725172854.GL31381@hirez.programming.kicks-ass.net>
References: <cf0ca526e3bc946766ab70bada2686c82e7da1ce.1564072590.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0ca526e3bc946766ab70bada2686c82e7da1ce.1564072590.git.luto@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:37:15AM -0700, Andy Lutomirski wrote:
> A data breakpoint near the top of an IST stack will cause unresoverable
> recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> Prevent either of these from happening.
> 
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

One small nit beflow.

> ---
> 
>  arch/x86/include/asm/cpu_entry_area.h | 10 ++++++++++
>  arch/x86/kernel/hw_breakpoint.c       | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
> index e23e2d9a92d7..3f50d4738487 100644
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -126,6 +126,16 @@ static inline struct entry_stack *cpu_entry_stack(int cpu)
>  	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
>  }
>  
> +/*
> + * Checks whether the range from addr to end, inclusive, overlaps the CPU
> + * entry area range.
> + */
> +static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
> +{
> +	return end >= CPU_ENTRY_AREA_PER_CPU &&
> +		addr < (CPU_ENTRY_AREA_PER_CPU + CPU_ENTRY_AREA_TOT_SIZE);
> +}
> +
>  #define __this_cpu_ist_top_va(name)					\
>  	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
>  
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 218c8917118e..dc4581fe4b4e 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -231,6 +231,23 @@ static int arch_build_bp_info(struct perf_event *bp,
>  			      const struct perf_event_attr *attr,
>  			      struct arch_hw_breakpoint *hw)
>  {
> +	unsigned long bp_end;
> +
> +	/* Ensure that bp_end does not oveflow. */
> +	if (attr->bp_len >= ULONG_MAX - attr->bp_addr)
> +		return -EINVAL;
> +
> +	bp_end = attr->bp_addr + attr->bp_len - 1;

The alternative (and possibly more conventional) overflow test would be:

	if (bp_end < attr->bp_addr)
		return -EINVAL;

> +
> +	/*
> +	 * Prevent any breakpoint of any type that overlaps the
> +	 * cpu_entry_area.  This protects the IST stacks and also
> +	 * reduces the chance that we ever find out what happens if
> +	 * there's a data breakpoint on the GDT, IDT, or TSS.
> +	 */
> +	if (within_cpu_entry_area(attr->bp_addr, bp_end))
> +		return -EINVAL;
> +
>  	hw->address = attr->bp_addr;
>  	hw->mask = 0;
>  
