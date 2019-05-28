Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F52C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D772133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tge7xkUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfE1Nwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:52:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfE1Nwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g2N2vKFHMkXhwJDKF/A36/f9dR++zHITnEPQPxg5154=; b=tge7xkUQK4dr/w/7LWQvA3HrT
        6nCQbND5p+3lWLkMeTo2GVv/ETkz0ZI3zhzwIKGMt8LLexAXM9nKowrD5+cf2J2MTbusaWGexneo8
        uKjqDC/ININ4Da3J75H4WDmsYHBh1cviqD08fCOgu2SmIugbBUXz5ju/+woEfsfoNWElZEt2yZwbh
        4NbavKkeessBd2lXbPxGQ+OQ4mtYoTNHErgG6r2eN80Lz3ytCnALqWBQDpWchUSOWJ47YyamUN/Gf
        hBqiimi/X5XKMZ6n7qOrfUAKO+gRkrOGYLX3XNJF4Sj5VZ7pey3ACp4rTjGS7Agh1h7ogFBaQOV59
        vRqCjd7hA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcWg-0004M9-81; Tue, 28 May 2019 13:52:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C29920756A00; Tue, 28 May 2019 15:52:25 +0200 (CEST)
Date:   Tue, 28 May 2019 15:52:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 7/9] perf/x86/intel: Disable sampling read slots and
 topdown
Message-ID: <20190528135224.GS2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-8-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:53PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> To get correct PERF_METRICS value, the fixed counter 3 must start from
> 0. It would bring problems when sampling read slots and topdown events.
> For example,
>         perf record -e '{slots, topdown-retiring}:S'
> The slots would not overflow if it starts from 0.
> 
> Add specific validate_group() support to reject the case and error out
> for Icelake.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/core.c       |  2 ++
>  arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
>  arch/x86/events/perf_event.h |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 07ecfe75f0e6..a7eb842f8651 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2065,6 +2065,8 @@ static int validate_group(struct perf_event *event)
>  	fake_cpuc->n_events = 0;
>  	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
>  
> +	if (x86_pmu.validate_group)
> +		ret = x86_pmu.validate_group(fake_cpuc, n);
>  out:
>  	free_fake_cpuc(fake_cpuc);
>  	return ret;
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 79e9d05e047d..2bb90d652a35 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4410,6 +4410,25 @@ static int icl_set_period(struct perf_event *event)
>  	return 1;
>  }
>  
> +static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
> +{
> +	bool has_sampling_slots = false, has_metrics = false;
> +	struct perf_event *e;
> +	int i;
> +
> +	for (i = 0; i < n; i++) {
> +		e = cpuc->event_list[i];
> +		if (is_slots_event(e) && is_sampling_event(e))
> +			has_sampling_slots = true;
> +
> +		if (is_perf_metrics_event(e))
> +			has_metrics = true;
> +	}
> +	if (unlikely(has_sampling_slots && has_metrics))
> +		return -EINVAL;
> +	return 0;
> +}

Why this special hack, why not disallow sampling on SLOTS on creation?
