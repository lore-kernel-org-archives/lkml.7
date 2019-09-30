Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265AC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949432086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVYRTwHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfI3NGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:06:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfI3NGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pDlR6fcxsnEYOQQvqNeC6vIfQZfiRjpLnLs2afm8Kcg=; b=RVYRTwHKqnwbzOMCE8dTEk1Sa
        zvoURh70HF1vAzOo70H/9xE1NCdsIrGp1liocyEP6VnJmo8glv1UgYkkSgrohBhBZqeVNt21Mfhlq
        u3T0l4/n8fK9hnuKeGIJQ5/OZYmEsmKwSr5lODbkvlomV9FKvo8xSGFBOgSO/kWVY2L+JVyKbVAFl
        3q77p6vjgKcC8rCw7vsu64bW2022H16PC1MdrBc1rFI5dT7v/c96QpkOuxFPfCSOoN2Thwhy6AjuK
        +NNbl+5y5RWJaeT602S5giuXS9DdANkQtFr29ME+agp38yBWGhw14qZmLwVmUg8RBA57m2cfiBa9D
        nkp4ZDcGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEvNa-0002KN-Gf; Mon, 30 Sep 2019 13:06:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89DF7301B59;
        Mon, 30 Sep 2019 15:05:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 886C525D6479C; Mon, 30 Sep 2019 15:06:15 +0200 (CEST)
Date:   Mon, 30 Sep 2019 15:06:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V4 07/14] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190930130615.GN4553@hirez.programming.kicks-ass.net>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
 <20190916134128.18120-8-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916134128.18120-8-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
> Reset
> ======
> 
> Both PERF_METRICS and fixed counter 3 are required to start from zero.

explain *why*, also in the comments.

> However, current perf has -max_period as default initial value.
> The patch force initial value as 0 for topdown and slots event counting.
> 
> Additionally, for certain scenarios that involve counting metrics at
> high rates, SW is required to periodically clear both MSRs in order to
> maintain accurate measurements. In this patch, both PERF_METRICS and
> Fixed counter 3 are reset for each read.

That forgoes all the good details again :/ 


> Originally-by: Andi Kleen <ak@linux.intel.com>

This is of dubius value here and in that other patch. In that other
patch I've written more lines than Andi has and here you have pretty
much rewritten everything since v1 or so.

> +static bool is_first_topdown_event_in_group(struct perf_event *event)
> +{
> +	struct perf_event *first = NULL;
> +
> +	if (is_topdown_event(event->group_leader))
> +		first = event->group_leader;
> +	else {
> +		for_each_sibling_event(first, event->group_leader)
> +			if (is_topdown_event(first))
> +				break;
> +	}
> +
> +	if (event == first)
> +		return true;
> +
> +	return false;
> +}

> +static u64 icl_update_topdown_event(struct perf_event *event)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct perf_event *other;
> +	u64 slots, metrics;
> +	int idx;
> +
> +	/*
> +	 * Only need to update all events for the first
> +	 * slots/metrics event in a group
> +	 */
> +	if (event && !is_first_topdown_event_in_group(event))
> +		return 0;

This is pretty crap and approaches O(n^2); let me think if there's
anything saner to do here.

