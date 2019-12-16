Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79821C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4E4207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U8y3kVJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLPUhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:37:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfLPUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2Wr+PrRLO4ouxkEO1xZARgw+sE31819/S81jh+OXe4=; b=U8y3kVJBqDbPJtNPAzOyGlFkw
        9/Z9+20PQcR8xTpFTx/g5/+GX4VQNxCF9/c7z9QetQ/HV8qkGCG175fGpXzVZdrWLPzmBexE2EdVl
        nXPGAXaN+4ksrT1/UBummsH64GxmW9iuy6InaLWiQrEWtx6oPaiUfovcNWitziAXdQPi4NY1ddAMN
        JqJcegFmSq7DwC/hYiZJBjeWrXFWeJFri/k6n64aV3T05WepItZ/KI/27eJ6uhueyMsAKqwxOiRiS
        qj+JtylhLdTE3pW6wZftlDz0yZIYMuGorQZ3ImLD4h8RgXC+3JPuNFOIMeVr+clilfHgFAEtKgFkS
        UmI2H36HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igx74-0000Lk-VT; Mon, 16 Dec 2019 20:37:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B051A301747;
        Mon, 16 Dec 2019 21:35:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C8E92B2AF233; Mon, 16 Dec 2019 21:37:05 +0100 (CET)
Date:   Mon, 16 Dec 2019 21:37:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: Allow smp_call_function_single_async() to insert
 locked csd
Message-ID: <20191216203705.GV2844@hirez.programming.kicks-ass.net>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
 <20191211162925.GD48697@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211162925.GD48697@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:29:25AM -0500, Peter Xu wrote:
> This is also true.
> 
> Here's the statistics I mentioned:
> 
> =================================================
> 
> (1) Implemented the same counter mechanism on the caller's:
> 
> *** arch/mips/kernel/smp.c:
> tick_broadcast[713]            smp_call_function_single_async(cpu, csd);
> *** drivers/cpuidle/coupled.c:
> cpuidle_coupled_poke[336]      smp_call_function_single_async(cpu, csd);
> *** kernel/sched/core.c:
> hrtick_start[298]              smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
> 
> (2) Cleared the csd flags before calls:
> 
> *** arch/s390/pci/pci_irq.c:
> zpci_handle_fallback_irq[185]  smp_call_function_single_async(cpu, &cpu_data->csd);
> *** block/blk-mq.c:
> __blk_mq_complete_request[622] smp_call_function_single_async(ctx->cpu, &rq->csd);
> *** block/blk-softirq.c:
> raise_blk_irq[70]              smp_call_function_single_async(cpu, data);
> *** drivers/net/ethernet/cavium/liquidio/lio_core.c:
> liquidio_napi_drv_callback[735] smp_call_function_single_async(droq->cpu_id, csd);
> 
> (3) Others:
> 
> *** arch/mips/kernel/process.c:
> raise_backtrace[713]           smp_call_function_single_async(cpu, csd);

per-cpu csd data, seems perfectly fine usage.

> *** arch/x86/kernel/cpuid.c:
> cpuid_read[85]                 err = smp_call_function_single_async(cpu, &csd);
> *** arch/x86/lib/msr-smp.c:
> rdmsr_safe_on_cpu[182]         err = smp_call_function_single_async(cpu, &csd);

These two have csd on stack and wait with a completion. seems fine.

> *** include/linux/smp.h:
> bool[60]                       int smp_call_function_single_async(int cpu, call_single_data_t *csd);

this is the declaration, your grep went funny

> *** kernel/debug/debug_core.c:
> kgdb_roundup_cpus[272]         ret = smp_call_function_single_async(cpu, csd);
> *** net/core/dev.c:
> net_rps_send_ipi[5818]         smp_call_function_single_async(remsd->cpu, &remsd->csd);

Both percpu again.

> 
> =================================================
> 
> For (1): These probably justify more on that we might want a patch
>          like this to avoid reimplementing it everywhere.

I can't quite parse that, but if you're saying we should fix the
callers, then I agree.

> For (2): If I read it right, smp_call_function_single_async() is the
>          only place where we take a call_single_data_t structure
>          rather than the (smp_call_func_t, void *) tuple.

That's on purpose; by supplying csd we allow explicit concurrency. If
you do as proposed here:

>		I could
>          miss something important, but otherwise I think it would be
>          good to use the tuple for smp_call_function_single_async() as
>          well, then we move call_single_data_t out of global header
>          but move into smp.c to avoid callers from toucing it (which
>          could be error-prone).  In other words, IMHO it would be good
>          to have all these callers fixed.

Then you could only ever have 1 of then in flight at the same time.
Which would break things.

> For (3): I didn't dig, but I think some of them (or future users)
>          could still suffer from the same issue on retriggering the
>          WARN_ON... 

They all seem fine.

So I'm thinking your patch is good, but please also fix all 1).
