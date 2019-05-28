Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0420883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0ZmRbMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfE1Mn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:43:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfE1Mn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d1+i8FlqvZy+DZCyf6x+0+OU5pzU76eA12cyixRHZMw=; b=d0ZmRbMZ2FxnVIyiCx1WmtxZb
        ykmUwzb2v1f/D9dWvWix6OWElCYB7UAhbTgbY/f248GD00SyMm1UeaSVCp2BefOoIxbVXcjYOhpPb
        kGzdl2M0lT2Cgs012Ca1LCopXW//8EyG1tfwImOSAdmmw19G6OZH/YFR0rcu6BhehnnesYo/H7BvD
        tCzMzkOIyVaiMNiV7D6F1MwGC1h5uXD9RrddhosnRiWiglrS+X+IjOO5REaBOOk+yb/y92Nqw22rn
        a3SRPTqFAoXuZkvwBaeHJPcoBTmNfmZSKaMRmstp5dZy/usXi0jyzX2/n0+Xl09mbLonNqRGyWYEc
        gzzxJg96w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVbSI-0003Zr-Lp; Tue, 28 May 2019 12:43:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 663E4200A0444; Tue, 28 May 2019 14:43:49 +0200 (CEST)
Date:   Tue, 28 May 2019 14:43:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528124349.GU2606@hirez.programming.kicks-ass.net>
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
> The 8bit metrics ratio values lose precision when the measurement period
> gets longer.
> 
> To avoid this we always reset the metric value when reading, as we
> already accumulate the count in the perf count value.
> 
> For a long period read, low precision is acceptable.
> For a short period read, the register will be reset often enough that it
> is not a problem.

> The PERF_METRICS may report wrong value if its delta was less than 1/255
> of SLOTS (Fixed counter 3).
> 
> To avoid this, the PERF_METRICS and SLOTS registers have to be reset
> simultaneously. The slots value has to be cached as well.

That doesn't sound like it is NMI-safe.



> RDPMC
> =========
> The TopDown can be collected per thread/process. To use TopDown
> through RDPMC in applications on Icelake, the metrics and slots values
> have to be saved/restored during context switching.
> 
> Add specific set_period() to specially handle the slots and metrics
> event. Because,
>  - The initial value must be 0.
>  - Only need to restore the value in context switch. For other cases,
>    the counters have been cleared after read.

So the above claims to explain RDPMC, but doesn't mention that magic
value below at all. In fact, I don't see how the above relates to RDPMC
at all.

> @@ -2141,7 +2157,9 @@ static int x86_pmu_event_idx(struct perf_event *event)
>  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>  		return 0;
>  
> -	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
> +	if (is_metric_idx(idx))
> +		idx = 1 << 29;

I can't find this in the SDM RDPMC description. What does it return?

> +	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
>  		idx -= INTEL_PMC_IDX_FIXED;
>  		idx |= 1 << 30;
>  	}
