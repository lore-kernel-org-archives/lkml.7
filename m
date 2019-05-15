Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB42C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BtNC5WcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEOKs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eT98c9ZJEKzSBV1OwAhd/D5fyFJk9KO5ces9PubNUPQ=; b=BtNC5WcFTIWlxnIopvRtU44XL
        UBiXr92kU2jaHbFs/6BoO4H5WendDQQ0uCEAZYamVzI+yLaVnUtaekqULM9LsigCBnIjvUi6UnHUa
        A3KZPajbJWY0ZGAogherjThCh1qWHjTobQFNx5hOmGFGzlq6GEDPhncFkVvKdOLjTbY9+BW4fSib0
        r4gv/Xa6pGQwmqrrGQmmFuzZu8nEoXRB3RGiegOL0CQ/nQW164JPz7W/n5Hn3NDuppOQoPtK1LHxr
        3nT5lDlhoKPIVvgnxJfuWc1pMpoTocueIYPAAXoF0XhyRBMqa+wIJ+MzD+iXjIgOHLXwOObd1E3lS
        0sc7kTEfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQrSV-0003zJ-2E; Wed, 15 May 2019 10:48:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDC9E20297D4B; Wed, 15 May 2019 12:48:24 +0200 (CEST)
Date:   Wed, 15 May 2019 12:48:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yabin Cui <yabinc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased
 data_head.
Message-ID: <20190515104824.GD2623@hirez.programming.kicks-ass.net>
References: <20190515003059.23920-1-yabinc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515003059.23920-1-yabinc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 05:30:59PM -0700, Yabin Cui wrote:
> In perf_output_put_handle(), an IRQ/NMI can happen in below location and
> write records to the same ring buffer:
> 	...
> 	local_dec_and_test(&rb->nest)
> 	...                          <-- an IRQ/NMI can happen here
> 	rb->user_page->data_head = head;
> 	...
> 
> In this case, a value A is written to data_head in the IRQ, then a value
> B is written to data_head after the IRQ. And A > B. As a result,
> data_head is temporarily decreased from A to B. And a reader may see
> data_head < data_tail if it read the buffer frequently enough, which
> creates unexpected behaviors.

Indeed, good catch! Have you observed this, or is this patch due to code
inspection?

> This can be fixed by moving dec(&rb->nest) to after updating data_head,
> which prevents the IRQ/NMI above from updating data_head.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  kernel/events/ring_buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 674b35383491..0b9aefe13b04 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>  	 * IRQ/NMI can happen here, which means we can miss a head update.
>  	 */
>  
> -	if (!local_dec_and_test(&rb->nest))
> +	if (local_read(&rb->nest) > 1) {
> +		local_dec(&rb->nest);
>  		goto out;
> +	}
>  
>  	/*
>  	 * Since the mmap() consumer (userspace) can run on a different CPU:
> @@ -86,6 +88,13 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>  	smp_wmb(); /* B, matches C */
>  	rb->user_page->data_head = head;

At the very least this needs:

	barrier();

> +	/*
> +	 * Clear rb->nest after updating data_head. This prevents IRQ/NMI from
> +	 * updating data_head before us. If that happens, we will expose a
> +	 * temporarily decreased data_head.
> +	 */
> +	local_set(&rb->nest, 0);

Since you rely on the 'decrement' (1->0) to happen after we've written
head.

And similarly, you need:

	barrier();

Because we must re-check the head after we've 'decremented'.

>  	/*
>  	 * Now check if we missed an update -- rely on previous implied
>  	 * compiler barriers to force a re-read.


A more paranoid person might've written:

	WARN_ON_ONCE(local_cmpxchg(&rb->nest, 1, 0) != 1);

which would've also implied both barrier()s.

