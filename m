Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3F214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="akOX48pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390962AbfJ1Q10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:27:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbfJ1Q10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hl7EeV1e87EvWLPBta0t1ffcGVSzWnGjvGSEpK+Qbwc=; b=akOX48pcg2u9uFGaUBrMmqiiH
        qxJcwCaBvyqnFfUn22T0j6NhK3bbuKwZe400E2uTtr+52mBobX7FX0gFRyP8WLZExBc/SNvIjYE2S
        0KOfr3wnRBPhHHSVfi3TlHfnhD1AdMpZzomyv9drq/n2ftVtcShekupF+/JWaeMoW9L/p4lapcrAx
        19DajV/HhiMrGyjSN40gpxaP+faiJRu7WExuCEYd2qvgm5uBy6zLJVZIt8HXWeEDizGF36cZCrEz7
        FGID6hL7nO/UJgWpBnVv3Dv3dThZYN7Ibhv4BZPqBCAUO2/2IQzGPL7Ty283N5tOGQsMU2ISZ6H16
        hxXGoa6jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7rQ-0004dn-0W; Mon, 28 Oct 2019 16:27:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4978D3002B0;
        Mon, 28 Oct 2019 17:26:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C97A2B400AB4; Mon, 28 Oct 2019 17:27:12 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:27:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v3 1/3] perf: Allow using AUX data in perf samples
Message-ID: <20191028162712.GH4097@hirez.programming.kicks-ass.net>
References: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
 <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025140835.53665-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 05:08:33PM +0300, Alexander Shishkin wrote:
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

I have the below delta on top of this patch.

And while I get why we need recursion protection for pmu::snapshot_aux,
I'm a little puzzled on why it is over the padding, that is, why isn't
the whole of aux_in_sampling inside (the newly minted)
perf_pmu_snapshot_aux() ?

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6237,7 +6237,7 @@ perf_output_sample_ustack(struct perf_ou
 	}
 }
 
-static unsigned long perf_aux_sample_size(struct perf_event *event,
+static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 					  struct perf_sample_data *data,
 					  size_t size)
 {
@@ -6275,9 +6275,9 @@ static unsigned long perf_aux_sample_siz
 	return data->aux_size;
 }
 
-long perf_pmu_aux_sample_output(struct perf_event *event,
-				struct perf_output_handle *handle,
-				unsigned long size)
+long perf_pmu_snapshot_aux(struct perf_event *event,
+			   struct perf_output_handle *handle,
+			   unsigned long size)
 {
 	unsigned long flags;
 	long ret;
@@ -6318,11 +6318,12 @@ static void perf_aux_sample_output(struc
 
 	/*
 	 * Guard against NMI hits inside the critical section;
-	 * see also perf_aux_sample_size().
+	 * see also perf_prepare_sample_aux().
 	 */
 	WRITE_ONCE(rb->aux_in_sampling, 1);
+	barrier();
 
-	size = perf_pmu_aux_sample_output(sampler, handle, data->aux_size);
+	size = perf_pmu_snapshot_aux(sampler, handle, data->aux_size);
 
 	/*
 	 * An error here means that perf_output_copy() failed (returned a
@@ -6335,7 +6336,7 @@ static void perf_aux_sample_output(struc
 
 	/*
 	 * The pad comes from ALIGN()ing data->aux_size up to u64 in
-	 * perf_aux_sample_size(), so should not be more than that.
+	 * perf_prepare_sample_aux(), so should not be more than that.
 	 */
 	pad = data->aux_size - size;
 	if (WARN_ON_ONCE(pad >= sizeof(u64)))
@@ -6347,6 +6348,7 @@ static void perf_aux_sample_output(struc
 	}
 
 out_clear:
+	barrier();
 	WRITE_ONCE(rb->aux_in_sampling, 0);
 
 	ring_buffer_put(rb);
@@ -6881,7 +6883,7 @@ void perf_prepare_sample(struct perf_eve
 		size = min_t(size_t, U16_MAX - header->size,
 			     event->attr.aux_sample_size);
 		size = rounddown(size, 8);
-		size = perf_aux_sample_size(event, data, size);
+		size = perf_prepare_sample_aux(event, data, size);
 
 		WARN_ON_ONCE(size + header->size > U16_MAX);
 		header->size += size;
