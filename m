Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD9C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07CE21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfGITuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:50:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGITuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:50:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkw8C-000583-CT; Tue, 09 Jul 2019 21:50:28 +0200
Date:   Tue, 9 Jul 2019 21:50:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>, Russ Anderson <rja@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
In-Reply-To: <20190702235151.4377-9-namit@vmware.com>
Message-ID: <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
References: <20190702235151.4377-1-namit@vmware.com> <20190702235151.4377-9-namit@vmware.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019, Nadav Amit wrote:

> SGI UV support is outdated and not maintained, and it is not clear how
> it performs relatively to non-UV. Remove the code to simplify the code.

You should at least Cc the SGI/HP folks on that. They are still
around. Done so.

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/mm/tlb.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index b47a71820f35..64afe1215495 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -689,31 +689,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
>  		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
>  				(info->end - info->start) >> PAGE_SHIFT);
>  
> -	if (is_uv_system()) {
> -		/*
> -		 * This whole special case is confused.  UV has a "Broadcast
> -		 * Assist Unit", which seems to be a fancy way to send IPIs.
> -		 * Back when x86 used an explicit TLB flush IPI, UV was
> -		 * optimized to use its own mechanism.  These days, x86 uses
> -		 * smp_call_function_many(), but UV still uses a manual IPI,
> -		 * and that IPI's action is out of date -- it does a manual
> -		 * flush instead of calling flush_tlb_func_remote().  This
> -		 * means that the percpu tlb_gen variables won't be updated
> -		 * and we'll do pointless flushes on future context switches.
> -		 *
> -		 * Rather than hooking native_flush_tlb_multi() here, I think
> -		 * that UV should be updated so that smp_call_function_many(),
> -		 * etc, are optimal on UV.
> -		 */
> -		flush_tlb_func_local(info);
> -
> -		cpumask = uv_flush_tlb_others(cpumask, info);
> -		if (cpumask)
> -			smp_call_function_many(cpumask, flush_tlb_func_remote,
> -					       (void *)info, 1);
> -		return;
> -	}
> -
>  	/*
>  	 * If no page tables were freed, we can skip sending IPIs to
>  	 * CPUs in lazy TLB mode. They will flush the CPU themselves
> -- 
> 2.17.1
> 
> 
