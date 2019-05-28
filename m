Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6285C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9BB2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3G6MP5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfE1Mxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:53:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1Mxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AXx+SzZ6K/ciPLwW8Q9L3pq12ZrCV5cYZu0brp2oNvM=; b=d3G6MP5s/bqNkzZZKI6qQor18
        8IbUPbqkG/57v/Vr6MI4frRhYqJLSkvJkdTvdAMH9LDuFmDgttQdLHEAGyoduw62U5gkDC0s+YPi7
        NUZjQeduZyMN3+GSuIMOBskK9zjfY3w6GyJRusLzlCNZg5T1w7IPTDCeC2XR44+o/LQSahzZuZE5E
        Pe7RdzHoi9gLswkF7UEiEyGCD1DXtOFK3cW9TDz0AQEIEu4KTMreuI8Xvm2ClkTPV0AfdUFAvZRGb
        v1I5mO/ccaHY/WkQOB1R28CEMrNTcwwqjorvFMoqRZOY2U3mnkEIt8vbu6suuPhg1zivAKIoEDt0R
        zpB1xwXRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVbbg-00046h-Jl; Tue, 28 May 2019 12:53:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9B022072908B; Tue, 28 May 2019 14:53:30 +0200 (CEST)
Date:   Tue, 28 May 2019 14:53:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190528125330.GV2606@hirez.programming.kicks-ass.net>
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
> +		x86_pmu.has_metric = x86_pmu.intel_cap.perf_metrics;

It makes sense to duplicate that state because?

> @@ -717,6 +729,8 @@ struct x86_pmu {
>  	struct extra_reg *extra_regs;
>  	unsigned int flags;
>  
> +	bool has_metric;
> +
>  	/*
>  	 * Intel host/guest support (KVM)
>  	 */

You forgot how I feel about _Bool in composite types _again_ ?

