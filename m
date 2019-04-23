Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44241218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556038262;
	bh=SLVzH+tZG3kTTx1LdqXQxLV7k8Ac+Dx6ZYQJj3OSYl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KRAjBcFHGmhex0uJkB+UFMiFCk/iXdIA5Sw3P/b19A+dxBzKDPfS0pB6jJKplIejv
	 4AtxtZ+ry5mdia4AyEv4SZJTOEG0kZQ9auPtMdUeYcPO5x3BVpNXDqk4eOrXWzCfEj
	 s1ByG/mDYum7yUo1XExGk4gSFXRsBAWCtYzyBPuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfDWQvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfDWQvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:51:00 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE312148D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556038259;
        bh=SLVzH+tZG3kTTx1LdqXQxLV7k8Ac+Dx6ZYQJj3OSYl4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OtmW/YvIC7Zw+W8YGSvW5YBD3JBG51SSnyyEwoiLiaR1g2d2PFK5wpOeNQDHJlUjs
         IyiIN8hAI9deH6Rhna9033M4GFQKjAd/F4WLV66fHsku7GNiwF9gZF15qt8elltppa
         ZhLkq9+9uw/dEwz8MFX5VeQpvx8AD2prPbvfS02c=
Received: by mail-wm1-f48.google.com with SMTP id z24so911978wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:50:58 -0700 (PDT)
X-Gm-Message-State: APjAAAWbE2bOLVr5+l+t637URjw4837Ehs6OWYH9i0fVFYonN8zcUdbr
        M3iYEKinbpNAWsH4KU9fu0Zgw9/SREijthyNLW+FSg==
X-Google-Smtp-Source: APXvYqxgYlgFWshTh1lDXKFCi/G9WKtEAR8NRpPFqIK6/dnnazm9ExOFmWZq/B5oYMpCWyjOI14J+PnrTIIowv26bFQ=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr2928546wmg.83.1556038257418;
 Tue, 23 Apr 2019 09:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190423065706.15430-1-namit@vmware.com>
In-Reply-To: <20190423065706.15430-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Apr 2019 09:50:46 -0700
X-Gmail-Original-Message-ID: <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
Message-ID: <CALCETrUohp2rMr9EcoAYm2M=Ktu4Bg2sPfUWMy5JqM-GXsDOBQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/tlb: Remove flush_tlb_info from the stack
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:12 AM Nadav Amit <namit@vmware.com> wrote:
>
> Remove flush_tlb_info variables from the stack. This allows to align
> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> line movements. It also allows to have a fixed virtual-to-physical
> translation of the variables, which reduces TLB misses.
>
> Use per-CPU struct for flush_tlb_mm_range() and
> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> no nested TLB flushes that might overwrite the per-CPU data. For
> arch_tlbbatch_flush(), use a const struct.
>
> Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
> operations and touching a page, in which 3 additional threads run a
> busy-wait loop (5 runs):

Can you add a memset(,,,. 0, sizeof(struct flush_tlb_info)) everywhere
you grab it?  Or, even better, perhaps do something like:

static inline struct flush_tlb_info *get_flush_tlb_info(void)
{
  /* check reentrancy, make sure that we use smp_processor_id() or
otherwise assert that we're bound to a single CPU. */
  struct flush_tlb_info *ptr = this_cpu_ptr(...);
  memset(ptr, 0, sizeof(*ptr));
  return ptr;
}

static inline void put_flush_tlb_info(void)
{
 /* finish checking reentrancy. */
}

>
>                         base            off-stack
>                         ----            ---------
> avg (per operation)     1.629           1.580   (-3%)
> stddev                  0.007           0.012
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/mm/tlb.c | 75 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 54 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 487b8474c01c..c4ac66dfb34e 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -634,7 +634,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>         this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
>  }
>
> -static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
> +static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
>  {
>         const struct flush_tlb_info *f = info;
>
> @@ -722,43 +722,62 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>   */
>  unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
> +#endif
> +
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>                                 unsigned long end, unsigned int stride_shift,
>                                 bool freed_tables)
>  {
> +       struct flush_tlb_info *info;
>         int cpu;
>
> -       struct flush_tlb_info info = {
> -               .mm = mm,
> -               .stride_shift = stride_shift,
> -               .freed_tables = freed_tables,
> -       };
> -
>         cpu = get_cpu();
> +       info = this_cpu_ptr(&flush_tlb_info);
> +
> +       /*
> +        * Ensure that the following code is non-reentrant and flush_tlb_info
> +        * is not overwritten. This means no TLB flushing is initiated by
> +        * interrupt handlers and machine-check exception handlers.
> +        */
> +#ifdef CONFIG_DEBUG_VM
> +       BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
> +#endif
>
>         /* This is also a barrier that synchronizes with switch_mm(). */
> -       info.new_tlb_gen = inc_mm_tlb_gen(mm);
> +       info->new_tlb_gen = inc_mm_tlb_gen(mm);
> +       info->mm = mm;
> +       info->stride_shift = stride_shift;
> +       info->freed_tables = freed_tables;
>
>         /* Should we flush just the requested range? */
>         if ((end != TLB_FLUSH_ALL) &&
>             ((end - start) >> stride_shift) <= tlb_single_page_flush_ceiling) {
> -               info.start = start;
> -               info.end = end;
> +               info->start = start;
> +               info->end = end;
>         } else {
> -               info.start = 0UL;
> -               info.end = TLB_FLUSH_ALL;
> +               info->start = 0UL;
> +               info->end = TLB_FLUSH_ALL;
>         }
>
>         if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
> -               VM_WARN_ON(irqs_disabled());
> +               lockdep_assert_irqs_enabled();
>                 local_irq_disable();
> -               flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +               flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
>                 local_irq_enable();
>         }
>
>         if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -               flush_tlb_others(mm_cpumask(mm), &info);
> +               flush_tlb_others(mm_cpumask(mm), info);
>
> +#ifdef CONFIG_DEBUG_VM
> +       barrier();
> +       this_cpu_dec(flush_tlb_info_idx);
> +#endif
>         put_cpu();
>  }
>
> @@ -787,22 +806,36 @@ static void do_kernel_range_flush(void *info)
>
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -
>         /* Balance as user space task's flush, a bit conservative */
>         if (end == TLB_FLUSH_ALL ||
>             (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
>                 on_each_cpu(do_flush_tlb_all, NULL, 1);
>         } else {
> -               struct flush_tlb_info info;
> -               info.start = start;
> -               info.end = end;
> -               on_each_cpu(do_kernel_range_flush, &info, 1);
> +               struct flush_tlb_info *info;
> +
> +               preempt_disable();
> +
> +#ifdef CONFIG_DEBUG_VM
> +               BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
> +#endif
> +
> +               info = this_cpu_ptr(&flush_tlb_info);
> +               info->start = start;
> +               info->end = end;
> +
> +               on_each_cpu(do_kernel_range_flush, info, 1);
> +
> +#ifdef CONFIG_DEBUG_VM
> +               barrier();
> +               this_cpu_dec(flush_tlb_info_idx);
> +#endif
> +               preempt_enable();
>         }
>  }
>
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
> -       struct flush_tlb_info info = {
> +       static const struct flush_tlb_info info = {
>                 .mm = NULL,
>                 .start = 0UL,
>                 .end = TLB_FLUSH_ALL,
> --
> 2.19.1
>
