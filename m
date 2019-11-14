Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727F206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/g+u3zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:32:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=srjXh+T5lZpTzKxCsN4HOkBm3sqlJaY0GDF28FU/Eyc=; b=i/g+u3zWaLm+6+5EBRwPuEWog
        yVOtSZ+Eqt9cRtkEmZzkc5dMyblsVmAlRmkfGYcGDHQcOe4VibBcq4bfMM9Nt4SXWRrEt5zFUpjl2
        SirrKuK6xVkEyzrqNBs9pBt9lZLufvPnxdjGH+sE/4ryVO4/fBXJUyO/a4BtLXUUw/hMYvbQ4gc+s
        E7d7HDCt+y5TGoMujrnpg3IsVRfqIwrOAKjtZu7CNUrhniqB+M6WXeKOJnheF3D19H4Mo9AQagD6F
        HpC2J25fD1IfepHyA6qI+2xR6cgcXfoViE/xTA7tpj0w1KzSr0kprd+ViqUGxOt1bvc9pFGmSvRru
        hqwFQYGjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVBUR-000661-Lv; Thu, 14 Nov 2019 09:32:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 611D6304637;
        Thu, 14 Nov 2019 10:31:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D481329DF124F; Thu, 14 Nov 2019 10:32:31 +0100 (CET)
Date:   Thu, 14 Nov 2019 10:32:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 02/10] lib: introduce generic min max heap
Message-ID: <20191114093231.GM4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-3-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:30:34PM -0800, Ian Rogers wrote:
> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/min_max_heap.h | 134 ++++++++++++++++++++++++
>  lib/Kconfig.debug            |  10 ++
>  lib/Makefile                 |   1 +
>  lib/test_min_max_heap.c      | 194 +++++++++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 include/linux/min_max_heap.h
>  create mode 100644 lib/test_min_max_heap.c
> 
> diff --git a/include/linux/min_max_heap.h b/include/linux/min_max_heap.h
> new file mode 100644
> index 000000000000..ea7764a8252a
> --- /dev/null
> +++ b/include/linux/min_max_heap.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MIN_MAX_HEAP_H
> +#define _LINUX_MIN_MAX_HEAP_H
> +
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +

Make this a kerneldoc comment and loose the comments in the structure.

> +/*
> + * Data structure used to hold a min or max heap, the number of elements varies
> + * but the maximum size is fixed.
> + */
> +struct min_max_heap {
> +	/* Start of array holding the heap elements. */
> +	void *data;
> +	/* Number of elements currently in min-heap. */
> +	int size;
> +	/* Maximum number of elements that can be held in current storage. */
> +	int cap;

You've got the naming all wrong; size is the size of the allocation, num
is the number of elements in use.

> +};
> +

Maybe do a kerneldoc comment for this structure too, that keeps the
definition less cluttered.

/**
 * struct min_max_heap_callbacks - const data/functions to customise the minmax heap
 * @elem_size:		the size of each element in bytes
 * @cmp:		partial order function for this heap
 *			'less'/'<' for min-heap, 'greater'/'>' for max-heap
 * @swp:		swap function.
 */
> +struct min_max_heap_callbacks {
> +	/* Size of elements in the heap. */
> +	int elem_size;
> +	/*
> +	 * A function which returns *lhs < *rhs or *lhs > *rhs depending on
> +	 * whether this is a min or a max heap. Note, another compare function
> +	 * style in the kernel will return -ve, 0 and +ve and won't handle
> +	 * minimum integer correctly if implemented as a subtract.
> +	 */
> +	bool (*cmp)(const void *lhs, const void *rhs);
> +	/* Swap the element values at lhs with those at rhs. */
> +	void (*swp)(void *lhs, void *rhs);
> +};

Personally I'd just call the whole thing a minheap and call the compare
function less and leave it at that. Sure if you flip the order you'll
get a maxheap but that's fairly obvious.

> +
> +/* Sift the element at pos down the heap. */
> +static inline void heapify(struct min_max_heap *heap, int pos,

Given this lives in the global namespace (this is C), maybe pick a
slightly more specific name, like min_max_heapify().

> +			const struct min_max_heap_callbacks *func) {

This is against coding style. Functions get their opening brace on a new
line. The rest of your patch has this right, why not this one?

> +	void *left_child, *right_child, *parent, *large_or_smallest;

I'm not a fan of excessively long variable names, they make it so much
harder to read code.

	void *left, *right, *parent, *pivot;

> +	char *data = (char *)heap->data;

What's the deal with that char nonsense? GCC does void* arithmetic just
right, also C will silently cast void* to any other pointer type.

> +
> +	for (;;) {
> +		if (pos * 2 + 1 >= heap->size)
> +			break;
> +
> +		left_child = data + ((pos * 2 + 1) * func->elem_size);
> +		parent = data + (pos * func->elem_size);

You can reduce the number of multiplications here. You have 3, and IIRC
you only need 1.

Set parent before the loop, compute right as left + size, and hand
either down as parent for the next iteration.

> +		large_or_smallest = parent;
> +		if (func->cmp(left_child, large_or_smallest))
> +			large_or_smallest = left_child;
> +
> +		if (pos * 2 + 2 < heap->size) {
> +			right_child = data + ((pos * 2 + 2) * func->elem_size);
> +			if (func->cmp(right_child, large_or_smallest))
> +				large_or_smallest = right_child;
> +		}
> +		if (large_or_smallest == parent)
> +			break;
> +		func->swp(large_or_smallest, parent);
> +		if (large_or_smallest == left_child)
> +			pos = (pos * 2) + 1;
> +		else
> +			pos = (pos * 2) + 2;
> +	}

I'm a little confused, normally (2*pos) is left and (2*pos+1) is right,
you seem to have used (2*pos + 1) and (2*pos + 2).

Also, I'm thinking the above can be helped with a little helper:

static inline int min_max_child(int pos, bool right)
{
	return 2 * pos + 1 + right;
}

> +}
> +
> +/* Floyd's approach to heapification that is O(size). */
> +static inline void
> +heapify_all(struct min_max_heap *heap,

min_max_heapify_all()

> +	const struct min_max_heap_callbacks *func)
> +{
> +	int i;
> +
> +	for (i = heap->size / 2; i >= 0; i--)

Where does that >= come from?

> +		heapify(heap, i, func);
> +}
> +
> +/* Remove minimum element from the heap, O(log2(size)). */
> +static inline void
> +heap_pop(struct min_max_heap *heap, const struct min_max_heap_callbacks *func)
> +{
> +	char *data = (char *)heap->data;

more silly char stuff

> +
> +	if (WARN_ONCE(heap->size <= 0, "Popping an empty heap"))
> +		return;
> +
> +	/* Place last element at the root (position 0) and then sift down. */
> +	heap->size--;
> +	memcpy(data, data + (heap->size * func->elem_size), func->elem_size);
> +	heapify(heap, 0, func);
> +}
> +
> +/*
> + * Remove the minimum element and then push the given element. The
> + * implementation performs 1 sift (O(log2(size))) and is therefore more
> + * efficient than a pop followed by a push that does 2.
> + */
> +static void heap_pop_push(struct min_max_heap *heap,
> +			const void *element,
> +			const struct min_max_heap_callbacks *func)
> +{
> +	char *data = (char *)heap->data;

delete it already

> +
> +	memcpy(data, element, func->elem_size);
> +	heapify(heap, 0, func);
> +}
> +
> +/* Push an element on to the heap, O(log2(size)). */
> +static inline void
> +heap_push(struct min_max_heap *heap, const void *element,
> +	const struct min_max_heap_callbacks *func)
> +{
> +	void *child, *parent;
> +	int pos;
> +	char *data = (char *)heap->data;

there are no strings here...

> +
> +	if (WARN_ONCE(heap->size >= heap->cap, "Pushing on a full heap"))
> +		return;
> +
> +	/* Place at the end of data. */
> +	pos = heap->size;
> +	memcpy(data + (pos * func->elem_size), element, func->elem_size);
> +	heap->size++;
> +
> +	/* Sift up. */
> +	for (; pos > 0; pos = (pos - 1) / 2) {

And here you have '>' in direct conflict with heapify_all()

> +		child = data + (pos * func->elem_size);
> +		parent = data + ((pos - 1) / 2) * func->elem_size;
> +		if (func->cmp(parent, child))
> +			break;
> +		func->swp(parent, child);

		child = parent;

and loose one multiplcation.

> +	}
> +}

