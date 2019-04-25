Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB03C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672B206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221726;
	bh=de1daFi5i6dpqL1aUK1wa5Lb46ywcBRyjOcNKpuPhCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8mAF9ugFPXPUNC6+GYHyTXcd6tjy8t8E3AbCiPEiWsN1DwaThaZixitq/QA8Leil
	 y/NqgoDpcNkE0vnR12A1w9OlKYUSo6pdevVwDOu4Ak3Pmp2A1LXriu88iWTYw32EnJ
	 ral+CNO4JgzgjzihiOtRdWlUW0eZ2Tugv751BUQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfDYTsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:48:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45927 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDYTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:48:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so969453wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zpbM72a9jAXoeFXtBUNjGKK0Y7i3TL6zbnrT40gmTQ8=;
        b=CzuzaxaENx8Uwt3sQHZ4dKJKTuOwsqKNGUyXwatzrt0+5yKjDyOMQO8X23zHjUsBtF
         Jt7DG2EZpzmXzGRQErXr6A7RRbq/RXEC1e7ff3jjGxXNlQFcuxGwkI75LOvwU1SlPkaS
         x73p2k9UVXo6Wtf7otDvV/IvL5lIo2eKtN1zleGE6aTNGEJaeenP/Eu1HKgjhfJZOjjk
         gZU14c3VtBng8utwPsUk7wdDQAB12K2RMtqRFEn0k1GAboVBsuD1X+oW/SUlU7nw+ZZh
         nk47kWxws2O4Ltl5+hKq0sKjPJhnKau3n6JTYrXpsK+XMmnpvXB+i8CDXP4862ax/g4L
         MxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zpbM72a9jAXoeFXtBUNjGKK0Y7i3TL6zbnrT40gmTQ8=;
        b=McDTdgRl2SpXil4H7teh2k8ALICJxyrtCiQZM0/Iljkjb+HadpwtHnuFUK3IZNukk0
         bOgUN3wNDBtRBs2FbLPI0I/oZ7CtnQzPwlB3xrR0GYa95Mizv6TQgQHSCx7EPOy1N4SC
         BRZ4EvNKf6Y3HDeVID3k4MmzzX91nOJAWeMUEh6CF/mX8DxwVpiJi11tKfc3GIbnDM8r
         GyfmtbRCpE8iXJKwj6LiJnzdGTatEVu71DFURrOWVVX3TlBZ8jBHvalkhZK1EWsQxp9R
         EbzXlxxVJxy/i6f7ViRGeo6wmxnmIBUPH2d25NaOOaPBD2WZHlBGMCt9IAfVyP9xod+z
         Q6vg==
X-Gm-Message-State: APjAAAXvTDKTbKMi0LhEEFUiDiuuSd6bN0PxaumkXVYD80YNU0CSQwFv
        HF+6sjrcRqaGuYkovZpFNc4=
X-Google-Smtp-Source: APXvYqz80KABTmrXmcu4rSkMZJQlnI7epR4/+fcjEc46wazqFU7LS9WzoKoDF69QgES42X1O9wpsjg==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr9298047wrs.243.1556221720494;
        Thu, 25 Apr 2019 12:48:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i18sm21275500wrm.7.2019.04.25.12.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:48:39 -0700 (PDT)
Date:   Thu, 25 Apr 2019 21:48:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Message-ID: <20190425194837.GB58719@gmail.com>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
 <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > On Apr 25, 2019, at 12:29 PM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > 
> > * Nadav Amit <namit@vmware.com> wrote:
> > 
> >> Move flush_tlb_info variables off the stack. This allows to align
> >> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> >> line movements. It also allows to have a fixed virtual-to-physical
> >> translation of the variables, which reduces TLB misses.
> >> 
> >> Use per-CPU struct for flush_tlb_mm_range() and
> >> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> >> no nested TLB flushes that might overwrite the per-CPU data. For
> >> arch_tlbbatch_flush() use a const struct.
> >> 
> >> Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
> >> operations and touching a page, in which 3 additional threads run a
> >> busy-wait loop (5 runs, PTI and retpolines are turned off):
> >> 
> >> 			base		off-stack
> >> 			----		---------
> >> avg (usec/op)		1.629		1.570	(-3%)
> >> stddev			0.014		0.009
> >> 
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Dave Hansen <dave.hansen@intel.com>
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> 
> >> ---
> >> 
> >> v1->v2:
> >> - Initialize all flush_tlb_info fields [Andy]
> >> ---
> >> arch/x86/mm/tlb.c | 100 ++++++++++++++++++++++++++++++++++------------
> >> 1 file changed, 74 insertions(+), 26 deletions(-)
> >> 
> >> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> >> index 487b8474c01c..aac191eb2b90 100644
> >> --- a/arch/x86/mm/tlb.c
> >> +++ b/arch/x86/mm/tlb.c
> >> @@ -634,7 +634,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
> >> 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
> >> }
> >> 
> >> -static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
> >> +static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
> >> {
> >> 	const struct flush_tlb_info *f = info;
> >> 
> >> @@ -722,43 +722,81 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
> >>  */
> >> unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
> >> 
> >> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
> >> +
> >> +#ifdef CONFIG_DEBUG_VM
> >> +static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
> >> +#endif
> >> +
> >> +static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
> >> +			unsigned long start, unsigned long end,
> >> +			unsigned int stride_shift, bool freed_tables,
> >> +			u64 new_tlb_gen)
> >> +{
> >> +	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
> >> +
> >> +#ifdef CONFIG_DEBUG_VM
> >> +	/*
> >> +	 * Ensure that the following code is non-reentrant and flush_tlb_info
> >> +	 * is not overwritten. This means no TLB flushing is initiated by
> >> +	 * interrupt handlers and machine-check exception handlers.
> >> +	 */
> >> +	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
> >> +#endif
> > 
> > isn't this effectively VM_BUG_ON()?
> 
> Not exactly. When CONFIG_DEBUG_VM is off we get
> 
> 	#define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
> 
> This will cause the build to fail since flush_tlb_info_idx is not defined in
> when CONFIG_DEBUG_VM is off.

Ugh, so VM_BUG_ON() should really be named VM_BUILD_BUG_ON()?

Anyway, agreed.

> >> +static inline void put_flush_tlb_info(void)
> >> +{
> >> +#ifdef CONFIG_DEBUG_VM
> >> +	/* Complete reentrency prevention checks */
> >> +	barrier();
> >> +	this_cpu_dec(flush_tlb_info_idx);
> >> +#endif
> > 
> > In principle this_cpu_dec() should imply a compiler barrier?
> 
> this_cpu_dec() is eventually expanded to the macro of percpu_add_op(). And
> the inline assembly does not have a “memory” clobber, so I don’t think so.

I think that's a bug and PeterZ is fixing those.

Thanks,

	Ingo
