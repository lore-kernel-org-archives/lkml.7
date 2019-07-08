Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD14C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1CA21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ASziEEwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfGHQgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:36:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5qbxX7uLGGM0j7ktC1ZeTbiIh4ZweqU0oC2EGZqjScg=; b=ASziEEwAmPt1Gy7ZpM0nciVC4
        I+LUZ/OlLYQVIlfxtVeuLb1wEY6XhgOME6OuFx1x9YXJ2a24xpOvCSqE8WLy2l2gq8xzgHDz7dv+Q
        faoOB5VNEtLd267bzpGsLd6VGAuQdqFYVRzEUYNgVJVp+XhXEFT6nPjd1TjgS5M713B3sjHiTCf2v
        9ozy0ijuf4Ru/bakMDNwOLF7d2F8wM3e6Y7yIGGHCOrCGzt17a2IwO4Glfgq2METXceISM+RALqNJ
        K1tMJGfPh/a9c+yxLSLQUUy+9xtC3lr9rFQP8IdmmAm72hRLxy6KgnnSPDKH/+ZeBdJHqDjDFyTMK
        R5U67q6cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWcz-0001E7-TW; Mon, 08 Jul 2019 16:36:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54C4A20976EFC; Mon,  8 Jul 2019 18:36:32 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:36:32 +0200
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
Message-ID: <20190708163632.GH3419@hirez.programming.kicks-ass.net>
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

> +/* Sift the perf_event at pos down the heap. */
> +static void min_heapify(struct perf_event_heap *heap, int pos)
> +{
> +	int left_child, right_child;
> +
> +	while (pos > heap->num_elements / 2) {

Did that want to be 'pos < head->num_elements / 2' ?

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

Otherwise I don't actually see it do anything at all. Also, when pos >
nr/2, then pos * 2 is silly.


