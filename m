Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0AACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2EA21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404061AbfJ1RKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:10:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:55198 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbfJ1RKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:10:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="400870656"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2019 10:10:22 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
In-Reply-To: <20191028162840.GD5671@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com> <20191025140835.53665-2-alexander.shishkin@linux.intel.com> <20191028162712.GH4097@hirez.programming.kicks-ass.net> <20191028162840.GD5671@hirez.programming.kicks-ass.net>
Date:   Mon, 28 Oct 2019 19:10:21 +0200
Message-ID: <87r22wg5j6.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Oct 28, 2019 at 05:27:12PM +0100, Peter Zijlstra wrote:
>> And while I get why we need recursion protection for pmu::snapshot_aux,
>> I'm a little puzzled on why it is over the padding, that is, why isn't
>> the whole of aux_in_sampling inside (the newly minted)
>> perf_pmu_snapshot_aux() ?
>
> That is, given the previous delta, the below.
>
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6292,9 +6292,17 @@ long perf_pmu_snapshot_aux(struct perf_e
>  	 * IRQs need to be disabled to prevent IPIs from racing with us.
>  	 */
>  	local_irq_save(flags);
> +	/*
> +	 * Guard against NMI hits inside the critical section;
> +	 * see also perf_prepare_sample_aux().
> +	 */
> +	WRITE_ONCE(rb->aux_in_sampling, 1);
> +	barrier();
>  
>  	ret = event->pmu->snapshot_aux(event, handle, size);
>  
> +	barrier();
> +	WRITE_ONCE(rb->aux_in_sampling, 0);
>  	local_irq_restore(flags);
>  
>  	return ret;
> @@ -6316,13 +6324,6 @@ static void perf_aux_sample_output(struc
>  	if (!rb)
>  		return;
>  
> -	/*
> -	 * Guard against NMI hits inside the critical section;
> -	 * see also perf_prepare_sample_aux().
> -	 */
> -	WRITE_ONCE(rb->aux_in_sampling, 1);
> -	barrier();
> -
>  	size = perf_pmu_snapshot_aux(sampler, handle, data->aux_size);
>  
>  	/*
> @@ -6348,9 +6349,6 @@ static void perf_aux_sample_output(struc
>  	}
>  
>  out_clear:
> -	barrier();
> -	WRITE_ONCE(rb->aux_in_sampling, 0);
> -
>  	ring_buffer_put(rb);

I can't tell without applying these, if the labels still make sense. But
this one probably becomes "out_put" at this point.

Thanks,
--
Alex
