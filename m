Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C5D21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbfJ1RIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:08:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:28926 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfJ1RIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:08:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="224697287"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 10:08:19 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
In-Reply-To: <20191028162712.GH4097@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com> <20191025140835.53665-2-alexander.shishkin@linux.intel.com> <20191028162712.GH4097@hirez.programming.kicks-ass.net>
Date:   Mon, 28 Oct 2019 19:08:18 +0200
Message-ID: <87tv7sg5ml.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> I have the below delta on top of this patch.
>
> And while I get why we need recursion protection for pmu::snapshot_aux,
> I'm a little puzzled on why it is over the padding, that is, why isn't
> the whole of aux_in_sampling inside (the newly minted)
> perf_pmu_snapshot_aux() ?

No reason. Too long staring at that code by myself.

> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6237,7 +6237,7 @@ perf_output_sample_ustack(struct perf_ou
>  	}
>  }
>  
> -static unsigned long perf_aux_sample_size(struct perf_event *event,
> +static unsigned long perf_prepare_sample_aux(struct perf_event *event,
>  					  struct perf_sample_data *data,
>  					  size_t size)
>  {
> @@ -6275,9 +6275,9 @@ static unsigned long perf_aux_sample_siz
>  	return data->aux_size;
>  }
>  
> -long perf_pmu_aux_sample_output(struct perf_event *event,
> -				struct perf_output_handle *handle,
> -				unsigned long size)
> +long perf_pmu_snapshot_aux(struct perf_event *event,
> +			   struct perf_output_handle *handle,
> +			   unsigned long size)

That makes more sense indeed.

>  {
>  	unsigned long flags;
>  	long ret;
> @@ -6318,11 +6318,12 @@ static void perf_aux_sample_output(struc
>  
>  	/*
>  	 * Guard against NMI hits inside the critical section;
> -	 * see also perf_aux_sample_size().
> +	 * see also perf_prepare_sample_aux().
>  	 */
>  	WRITE_ONCE(rb->aux_in_sampling, 1);
> +	barrier();

Isn't WRITE_ONCE() barrier enough on its own? My thinking was that we
only need a compiler barrier here, hence the WRITE_ONCE.

Thanks,
--
Alex
