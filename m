Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C992C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E537E23403
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fl2793y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1IoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:44:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1IoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TbiAm34UHSQnJDbGh+tQRL2bzfQS9wG8Ak+/2D09nxw=; b=fl2793y/MBOXnRDDd+6MgQ4Cc
        0W1gIATu84hfQ2hYcDQZ96n70fMihRgVM0yLjxbWwR1fNLiYroAeRoeQEgub2p6JgcPJ43FJHx12Q
        NTn4K0SRSOdLNhdUzZfya2pfqGy2EAMnuW/JtLlaBIZqFntBFV2cU0A5FJ+gdYDmP4Pi4tiweXXHx
        uebQSY2ndzt4azmZMuKvRAAYcC5at4ZqjaDavj1wD8UCk8k+kLJ+og/m433tIduNxhZLV+TRV1ae4
        ekIzWcZKOjCqE96/+PnFJBVqK3im8cB6i3+H5FUuW1/1m+rgvPnewrhW2ki0OcGVFXsYw4adReDOB
        gjrABJxxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2tYx-0006QZ-V8; Wed, 28 Aug 2019 08:44:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 100113074C6;
        Wed, 28 Aug 2019 10:43:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E387B20230B0C; Wed, 28 Aug 2019 10:44:16 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:44:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828084416.GC2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:34AM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 1b2c37ed49db..f4d6335a18e2 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2131,7 +2131,7 @@ static inline void intel_pmu_ack_status(u64 ack)
>  
>  static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
>  {
> -	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
> +	int idx = get_reg_idx(hwc->idx) - INTEL_PMC_IDX_FIXED;
>  	u64 ctrl_val, mask;
>  
>  	mask = 0xfULL << (idx * 4);
> @@ -2150,6 +2150,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int reg_idx = get_reg_idx(hwc->idx);
>  
>  	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
>  		intel_pmu_disable_bts();

It is unfortunate we need that in both cases; and note how the
inconsitent naming.

> @@ -2157,9 +2158,16 @@ static void intel_pmu_disable_event(struct perf_event *event)
>  		return;
>  	}
>  
> -	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
> -	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
> +	/*
> +	 * When any other topdown events are still enabled,
> +	 * cancel the disabling.
> +	 */
> +	if (has_other_topdown_event(cpuc->active_mask, hwc->idx))
> +		return;

And this includes a 3rd instance of that check :/ Also, this really
wants to be in disable_fixed.

> +
> +	cpuc->intel_ctrl_guest_mask &= ~(1ull << reg_idx);
> +	cpuc->intel_ctrl_host_mask &= ~(1ull << reg_idx);
> +	cpuc->intel_cp_status &= ~(1ull << reg_idx);
>  
>  	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
>  		intel_pmu_disable_fixed(hwc);

Same for the enable thing.

Let me clean up this mess for you.
