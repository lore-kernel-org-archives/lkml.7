Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD97C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8552053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecDRc3FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEHJMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:12:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46362 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfEHJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ti/GvQ2fpzLJs51fiijjX5Y8RLoGHui9LgUr7AvseL0=; b=ecDRc3FP8L9eN5fGH7g83Ukb+
        wx/775+ecbnvFj26epsJIiHft6Yy6iZmvwDT0QTaFm4f4ZUCj9z1VK1E95ToIqOxle37TliV3TEZG
        rV35mHPqg4NmYKqti8SNH+WqWroFs7Hh69j8sAQ5sJfQin80qHdxBoa5V+nKp02lbrgvLm8RLdxWM
        AlLGREEhabNknBqnjzOPjC/E4dYhR9Izc3KtDlILG4mSamLpXt97TG9QDQDzlxJwy7uCtyIfF1luB
        SIrM+KibQ0w2QelLBqabBu13ASDSxglmWKcyy46D29DriOz4b1UN2ge1uzwaYkVSLRykV6MrFplNz
        Ft820X0kA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOIcn-0004n2-30; Wed, 08 May 2019 09:12:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9194A2029F886; Wed,  8 May 2019 11:12:27 +0200 (CEST)
Date:   Wed, 8 May 2019 11:12:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com
Subject: Re: [PATCH 2/2] perf/x86/intel: Support PEBS output to PT
Message-ID: <20190508091227.GB2606@hirez.programming.kicks-ass.net>
References: <20190502105022.15534-1-alexander.shishkin@linux.intel.com>
 <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502105022.15534-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:50:22PM +0300, Alexander Shishkin wrote:
> If PEBS declares ability to output its data to Intel PT stream, use the
> aux_source attribute bit to enable PEBS data output to PT. This requires
> a PT event to be present and scheduled in the same context. Unlike the
> DS area, the kernel does not extract PEBS records from the PT stream to
> generate corresponding records in the perf stream, because that would
> require real time in-kernel PT decoding, which is not feasible. The PMI,
> however, can still be used.
> 
> The output setting is per-CPU, so all PEBS events must be either writing
> to PT or to the DS area, so in order to not mess up the event scheduling,
> we fall back to the latter in case both types of events are scheduled in.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c     | 13 +++++++
>  arch/x86/events/intel/ds.c       | 59 +++++++++++++++++++++++++++++++-
>  arch/x86/events/perf_event.h     |  9 +++++
>  arch/x86/include/asm/msr-index.h |  3 ++
>  4 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4b4dac089635..949a589fd9b1 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3291,6 +3291,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		}
>  	}
>  
> +	if (event->attr.aux_source) {
> +		if (!event->attr.precise_ip)
> +			return -EINVAL;
> +
> +		if (!x86_pmu.intel_cap.pebs_output_pt_available)
> +			return -EOPNOTSUPP;
> +
> +		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
> +
> +		/* Signal to the core that we handled it */
> +		event->attr.aux_source = 0;

That's a bit yuck, ideally we'd not modify attrs.

Can't we change that test in perf_event_alloc() to something like:

	if (event->attr.aux_source &&
	    !(pmu->capabilities & PERF_PMU_CAP_AUX_SOURCE))
		// error

?


> +	}
