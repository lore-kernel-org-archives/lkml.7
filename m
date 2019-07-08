Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C9C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA1F21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCUqTPl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfGHQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:30:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfGHQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=04VsQin5fQQD6HrGTvlUwJ6xlZUOLvn+UaWNLc/zkB0=; b=vCUqTPl2ipzmd49ySsSXpS65M
        eXeYC3nfJ/AjlLrdFTNrvfm6qaY6inXl3PWVbhn9hO92uioXOG3N8I6wMhs0Zi89HITX8AdcZ255l
        RuMAYwE5LSqd9zGZLXua2w3KlVMxL62qsbvHtyWHJKQe7G/T7vbwOFzUovis0sVtMYL1y80d5p6Qq
        QlnkSt5rwGGu9em8SB3D0qfIAfz+HkTJaEjeDULOAFkGsxbJqhkoY73kK36/TEjF7vTOdx1EDgG1w
        3YNgyJQg1elhAxBsv8HtJdRiZrz8CWvd7HiYsEPUT3EFrXtMkceI6mTndjmTswwc8A06ozJRK+bmw
        090eYDW4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWX1-0007rA-5M; Mon, 08 Jul 2019 16:30:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8559420976EFB; Mon,  8 Jul 2019 18:30:21 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:30:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/7] perf: order iterators for visit_groups_merge into a
 min-heap
Message-ID: <20190708163021.GG3419@hirez.programming.kicks-ass.net>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-4-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:51PM -0700, Ian Rogers wrote:
> The groups rbtree holding perf events, either for a CPU or a task, needs
> to have multiple iterators that visit events in group_index (insertion)
> order. Rather than linearly searching the iterators, use a min-heap to go
> from a O(#iterators) search to a O(log2(#iterators)) insert cost per event
> visited.

Is this actually faster for the common (very small n) case?

ISTR 'stupid' sorting algorithms are actually faster when the data fits
into L1

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/events/core.c | 123 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 95 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9a2ad34184b8..396b5ac6dcd4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3318,6 +3318,77 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
>  	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
>  }
>  
> +/* Data structure used to hold a min-heap, ordered by group_index, of a fixed
> + * maximum size.
> + */

Broken comment style.

> +struct perf_event_heap {
> +	struct perf_event **storage;
> +	int num_elements;
> +	int max_elements;
> +};
> +
> +static void min_heap_swap(struct perf_event_heap *heap,
> +			  int pos1, int pos2)
> +{
> +	struct perf_event *tmp = heap->storage[pos1];
> +
> +	heap->storage[pos1] = heap->storage[pos2];
> +	heap->storage[pos2] = tmp;
> +}
> +
> +/* Sift the perf_event at pos down the heap. */
> +static void min_heapify(struct perf_event_heap *heap, int pos)
> +{
> +	int left_child, right_child;
> +
> +	while (pos > heap->num_elements / 2) {
> +		left_child = pos * 2;
> +		right_child = pos * 2 + 1;
> +		if (heap->storage[pos]->group_index >
> +		    heap->storage[left_child]->group_index) {
> +			min_heap_swap(heap, pos, left_child);
> +			pos = left_child;
> +		} else if (heap->storage[pos]->group_index >
> +			   heap->storage[right_child]->group_index) {
> +			min_heap_swap(heap, pos, right_child);
> +			pos = right_child;
> +		} else {
> +			break;
> +		}
> +	}
> +}
> +
> +/* Floyd's approach to heapification that is O(n). */
> +static void min_heapify_all(struct perf_event_heap *heap)
> +{
> +	int i;
> +
> +	for (i = heap->num_elements / 2; i > 0; i--)
> +		min_heapify(heap, i);
> +}
> +
> +/* Remove minimum element from the heap. */
> +static void min_heap_pop(struct perf_event_heap *heap)
> +{
> +	WARN_ONCE(heap->num_elements <= 0, "Popping an empty heap");
> +	heap->num_elements--;
> +	heap->storage[0] = heap->storage[heap->num_elements];
> +	min_heapify(heap, 0);
> +}

Is this really the first heap implementation in the kernel?

> @@ -3378,12 +3453,14 @@ static int visit_groups_merge(struct perf_event_context *ctx,
>  			struct cgroup_subsys_state *css;
>  
>  			for (css = &cpuctx->cgrp->css; css; css = css->parent) {
> -				itrs[num_itrs] = perf_event_groups_first(groups,
> +				heap.storage[heap.num_elements] =
> +						perf_event_groups_first(groups,
>  								   cpu,
>  								   css->cgroup);
> -				if (itrs[num_itrs]) {
> -					num_itrs++;
> -					if (num_itrs == max_itrs) {
> +				if (heap.storage[heap.num_elements]) {
> +					heap.num_elements++;
> +					if (heap.num_elements ==
> +					    heap.max_elements) {
>  						WARN_ONCE(
>  				     max_cgroups_with_events_depth,
>  				     "Insufficient iterators for cgroup depth");

That's turning into unreadable garbage due to indentation; surely
there's a solution for that.
