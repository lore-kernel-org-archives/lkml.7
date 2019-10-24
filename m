Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E79CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E875B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EguVwaXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409319AbfJXOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:06:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404950AbfJXOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oD842OTrwKKm/mGZZWA/0Z9sPwyQYcg0RBZVfQn2YOo=; b=EguVwaXnmWGrDYsZUV7Luw1x0
        JhSqI0L7Te99INzmroomEMOyN+wYwDXZloVW9x+3V5U4MzR8QGyvksy+t6tUVr++Xn8roTq/TY6Bh
        2CufrNPOd16OmE+kMfzB0uFE2kAKLoBmZ+cWGNEwmhRgwCzEGZoypux/hZVcFA32ph9tdFsDElTEa
        nyaqacp1ivKjZ4+JqoZ8t+ih/9PxOT5nKxaQChBxegyPHVVGDibAaCMuhu9ZFRrK57Ah/tsll13h5
        2B0lQGebgCuQ6GkEZM7fs8ui93TeXjdIGS7sPidqLRF/A4ox+EpGT8akIU76O895ll4XG2i31ecYm
        r15o/KBuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdkv-0000DO-N9; Thu, 24 Oct 2019 14:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABC17300489;
        Thu, 24 Oct 2019 16:05:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31B6F2B1D7CA4; Thu, 24 Oct 2019 16:06:24 +0200 (CEST)
Date:   Thu, 24 Oct 2019 16:06:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
Message-ID: <20191024140624.GG4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:
> @@ -964,6 +979,7 @@ struct perf_sample_data {
>  		u32	reserved;
>  	}				cpu_entry;
>  	struct perf_callchain_entry	*callchain;
> +	u64				aux_size;
>  
>  	/*
>  	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
> @@ -996,6 +1012,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->weight = 0;
>  	data->data_src.val = PERF_MEM_NA;
>  	data->txn = 0;
> +	data->aux_size = 0;
>  }
>  

I don't see the need to initialize in perf_sample_data_init(), because
prepare sets it unconditionally:

> +static unsigned long perf_aux_sample_size(struct perf_event *event,
> +					  struct perf_sample_data *data,
> +					  size_t size)
> +{
> +	struct perf_event *sampler = event->aux_event;
> +	struct ring_buffer *rb;
> +
> +	data->aux_size = 0;
> +
> +	if (!sampler)
> +		goto out;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE))
> +		goto out;
> +
> +	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
> +		goto out;
> +
> +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	if (!rb)
> +		goto out;
> +
> +	/*
> +	 * If this is an NMI hit inside sampling code, don't take
> +	 * the sample. See also perf_aux_sample_output().
> +	 */
> +	if (READ_ONCE(rb->aux_in_sampling)) {
> +		data->aux_size = 0;
> +	} else {
> +		size = min_t(size_t, size, perf_aux_size(rb));
> +		data->aux_size = ALIGN(size, sizeof(u64));
> +	}
> +	ring_buffer_put(rb);
> +
> +out:
> +	return data->aux_size;
> +}

When PERF_SAMPLE_AUX

> @@ -6699,6 +6824,35 @@ void perf_prepare_sample(struct perf_event_header *header,
>  
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
> +
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		u64 size;
> +
> +		header->size += sizeof(u64); /* size */
> +
> +		/*
> +		 * Given the 16bit nature of header::size, an AUX sample can
> +		 * easily overflow it, what with all the preceding sample bits.
> +		 * Make sure this doesn't happen by using up to U16_MAX bytes
> +		 * per sample in total (rounded down to 8 byte boundary).
> +		 */
> +		size = min_t(size_t, U16_MAX - header->size,
> +			     event->attr.aux_sample_size);
> +		size = rounddown(size, 8);
> +		size = perf_aux_sample_size(event, data, size);
> +
> +		WARN_ON_ONCE(size + header->size > U16_MAX);
> +		header->size += size;
> +	}
> +	/*
> +	 * If you're adding more sample types here, you likely need to do
> +	 * something about the overflowing header::size, like repurpose the
> +	 * lowest 3 bits of size, which should be always zero at the moment.
> +	 * This raises a more important question, do we really need 512k sized
> +	 * samples and why, so good argumentation is in order for whatever you
> +	 * do here next.
> +	 */
> +	WARN_ON_ONCE(header->size & 7);
>  }

And output only looks at it when PERF_SAMPLE_AUX.

> +static void perf_aux_sample_output(struct perf_event *event,
> +				   struct perf_output_handle *handle,
> +				   struct perf_sample_data *data)
> +{
> +	struct perf_event *sampler = event->aux_event;
> +	unsigned long pad;
> +	struct ring_buffer *rb;
> +	long size;
> +
> +	if (WARN_ON_ONCE(!sampler || !data->aux_size))
> +		return;
> +
> +	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	if (!rb)
> +		return;
> +
> +	/*
> +	 * Guard against NMI hits inside the critical section;
> +	 * see also perf_aux_sample_size().
> +	 */
> +	WRITE_ONCE(rb->aux_in_sampling, 1);
> +
> +	size = perf_pmu_aux_sample_output(sampler, handle, data->aux_size);
> +
> +	/*
> +	 * An error here means that perf_output_copy() failed (returned a
> +	 * non-zero surplus that it didn't copy), which in its current
> +	 * enlightened implementation is not possible. If that changes, we'd
> +	 * like to know.
> +	 */
> +	if (WARN_ON_ONCE(size < 0))
> +		goto out_clear;
> +
> +	/*
> +	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
> +	 * perf_aux_sample_size(), so should not be more than that.
> +	 */
> +	pad = data->aux_size - size;
> +	if (WARN_ON_ONCE(pad >= sizeof(u64)))
> +		pad = 8;
> +
> +	if (pad) {
> +		u64 zero = 0;
> +		perf_output_copy(handle, &zero, pad);
> +	}
> +
> +out_clear:
> +	WRITE_ONCE(rb->aux_in_sampling, 0);
> +
> +	ring_buffer_put(rb);
> +}
> +

> @@ -6511,6 +6629,13 @@ void perf_output_sample(struct perf_output_handle *handle,
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		perf_output_put(handle, data->phys_addr);
>  
> +	if (sample_type & PERF_SAMPLE_AUX) {
> +		perf_output_put(handle, data->aux_size);
> +
> +		if (data->aux_size)
> +			perf_aux_sample_output(event, handle, data);
> +	}
> +
>  	if (!event->attr.watermark) {
>  		int wakeup_events = event->attr.wakeup_events;


So, afaict, you can simply remove the line in perf_sample_data_init().
