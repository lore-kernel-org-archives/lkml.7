Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3488EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059E72064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0tvZRA8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfJOJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:16:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfJOJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oIjZ3ZGDT1Dl1PI+PmIwiAz6EXPC9LLSMZjb9xG3QJY=; b=0tvZRA8H2b8vxdLFiyget6nIR
        qFYTIRGIwD2c1gGkp8OPm0/zir5ZcOVOrsfxSDs+g55d4taRwX0tcxVMUBb8QTuL28O+tchAHm+zv
        byZWfBvvTSwYvJXlYHTnbVpUVmUcWZJF4Dpq1Lrt+2wfaX+YVvDI/Ntj0RUpbR3pcYWhLOl1rQzUq
        31GwVUUIB6Mpaw1MXQOwohHZy2GYHctc2Z3lzMDCjgFTjgjkuv/munV468tDUGmDMAWGKJWwFX5Ua
        HmcR/A3WQ3Y+ozViXTkJSzpz/ECS9BXJ6wTPc0zuQmq1Jx0SnZGrJTto4oY4jGyO8QNeUPq6rKNS/
        lpT8lIgQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKIwF-00010O-SZ; Tue, 15 Oct 2019 09:16:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A5CD3032F8;
        Tue, 15 Oct 2019 11:15:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC90728B550B6; Tue, 15 Oct 2019 11:16:17 +0200 (CEST)
Date:   Tue, 15 Oct 2019 11:16:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf/core: fix restoring of Intel LBR call stack on a
 context switch
Message-ID: <20191015091617.GF2311@hirez.programming.kicks-ass.net>
References: <cf5b18f6-3de5-0826-15ac-8fc87b153127@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5b18f6-3de5-0826-15ac-8fc87b153127@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 09:08:34AM +0300, Alexey Budankov wrote:
> 
> Restore Intel LBR call stack from cloned inactive task perf context on
> a context switch. This change inherently addresses inconsistency in LBR 
> call stack data provided on a sample in record profiling mode for 
> example like this:
> 
>   $ perf record -N -B -T -R --call-graph lbr \
>          -e cpu/period=0xcdfe60,event=0x3c,name=\'CPU_CLK_UNHALTED.THREAD\'/Duk \
>          --clockid=monotonic_raw -- ./miniFE.x nx 25 ny 25 nz 25
> 
> Let's assume threads A, B, C belonging to the same process. 
> B and C are siblings of A and their perf contexts are treated as equivalent.
> At some point B blocks on a futex (non preempt context switch).
> B's LBRs are preserved at B's perf context task_ctx_data and B's events 
> are removed from PMU and disabled. B's perf context becomes inactive.
> 
> Later C gets on a cpu, runs, gets profiled and eventually switches to 
> the awaken but not yet running B. The optimized context switch path is 
> executed coping B's task_ctx_data to C's one and updating B's perf context 
> pointer to refer to C's task_ctx_data that contains preserved B's LBRs 
> after coping.
> 
> However, as far B's perf context is inactive there is no enabled events
> in there and B's task_ctx_data->lbr_callstack_users is equal to 0.
> When B gets on the cpu B's events reviving is skipped following
> the optimized context switch path and B's task_ctx_data->lbr_callstack_users
> remains 0. Thus B's LBR's are not restored by pmu sched_task() code called 
> in the end of perf context switch sched_in callback for B.
> 
> In the report that manifests as having short fragments of B's
> call stack, still tracked by LBR's HW between adjacent samples,
> but the whole thread call tree doesn't aggregate.
> 

> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2aad959e6def..74c2ff38e079 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3181,7 +3181,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
>  
>  	rcu_read_lock();
>  	next_ctx = next->perf_event_ctxp[ctxn];
> -	if (!next_ctx)
> +	if (!next_ctx || !next_ctx->is_active)
>  		goto unlock;

AFAICT this completely kills off the optimization. next_ctx->is_active
cannot be set at this point.


