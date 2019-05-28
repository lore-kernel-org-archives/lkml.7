Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36A20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQPfddBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfE1Nac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:30:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1Nab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m8QDuIo40K2ON6yKsiYwzYOeap3jWGAqFsvplXDMLl8=; b=PQPfddBfbyEXuXddfKHI/aoGX
        c0pJ30nGCQ7FnvYJ2hqkbrGNKMPKRtaiec/+silMCly1SxmenARrs+9KyIPeeTfc8W00EW5Gfb2s1
        JV34qq5RHSAD3xSikRAT5KdjWHRlXbS/lvjhXOhP4xyc4rCk4adNuK6zLwcE4Szknhcm5y0Ny2ZIR
        iGnlSGOUpQ8N+qArI+ZbXxGYToPuBLZ5a+8FxtKMf4/gGIWEaq3RE+q+I3VZWVl0OmpJSvprWIRHn
        5isW24F/FP8fUM2t26R1DHpCG+Tfw5QWeRJ3VMd9PU1w8fkfvoPGQi2FhqSNSks9kkjalWx5qLF6R
        BnSxBvNcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVcBN-0004DY-3p; Tue, 28 May 2019 13:30:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 999502072908B; Tue, 28 May 2019 15:30:22 +0200 (CEST)
Date:   Tue, 28 May 2019 15:30:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528133022.GX2606@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521214055.31060-5-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
> +static u64 icl_metric_update_event(struct perf_event *event, u64 val)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 newval, metric, slots_val = 0, new, last;
> +	bool nmi = in_nmi();
> +	int txn_flags = nmi ? 0 : cpuc->txn_flags;
> +
> +	/*
> +	 * Use cached value for transaction.
> +	 */
> +	newval = 0;
> +	if (txn_flags) {
> +		newval = cpuc->txn_metric;
> +		slots_val = cpuc->txn_slots;
> +	} else if (nmi) {
> +		newval = cpuc->nmi_metric;
> +		slots_val = cpuc->nmi_slots;
> +	}
> +
> +	if (!newval) {
> +		slots_val = val;
> +
> +		rdpmcl((1<<29), newval);
> +		if (txn_flags) {
> +			cpuc->txn_metric = newval;
> +			cpuc->txn_slots = slots_val;
> +		} else if (nmi) {
> +			cpuc->nmi_metric = newval;
> +			cpuc->nmi_slots = slots_val;
> +		}
> +
> +		if (!(txn_flags & PERF_PMU_TXN_REMOVE)) {
> +			/* Reset the metric value when reading
> +			 * The SLOTS register must be reset when PERF_METRICS reset,
> +			 * otherwise PERF_METRICS may has wrong output.
> +			 */

broken comment style.. (and grammer)

> +			wrmsrl(MSR_PERF_METRICS, 0);
> +			wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);

I don't get this, overflow happens on when we flip sign, so why is
programming 0 a sane thing to do?

> +			hwc->saved_metric = 0;
> +			hwc->saved_slots = 0;
> +		} else {
> +			/* saved metric and slots for context switch */
> +			hwc->saved_metric = newval;
> +			hwc->saved_slots = val;
> +
> +		}
> +		/* cache the last metric and slots */
> +		cpuc->last_metric = hwc->last_metric;
> +		cpuc->last_slots = hwc->last_slots;
> +		hwc->last_metric = 0;
> +		hwc->last_slots = 0;
> +	}
> +
> +	/* The METRICS and SLOTS have been reset when reading */
> +	if (!(txn_flags & PERF_PMU_TXN_REMOVE))
> +		local64_set(&hwc->prev_count, 0);
> +
> +	if (is_slots_event(event))
> +		return (slots_val - cpuc->last_slots);
> +
> +	/*
> +	 * The metric is reported as an 8bit integer percentage
> +	 * suming up to 0xff. As the counter is less than 64bits
> +	 * we can use the not used bits to get the needed precision.
> +	 * Use 16bit fixed point arithmetic for
> +	 * slots-in-metric = (MetricPct / 0xff) * val
> +	 * This works fine for upto 48bit counters, but will
> +	 * lose precision above that.
> +	 */
> +
> +	metric = (cpuc->last_metric >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
> +	last = (((metric * 0xffff) >> 8) * cpuc->last_slots) >> 16;

How is that cpuc->last_* crap not broken for NMIs ?

> +
> +	metric = (newval >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
> +	new = (((metric * 0xffff) >> 8) * slots_val) >> 16;
> +
> +	return (new - last);
> +}


This is diguisting.. and unreadable.

mul_u64_u32_shr() is actually really fast, use it.
