Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2BC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335420850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfKQS2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 13:28:37 -0500
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:40034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726047AbfKQS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:28:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3552418225AE5;
        Sun, 17 Nov 2019 18:28:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sky31_2d41e53a0222a
X-Filterd-Recvd-Size: 4615
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 17 Nov 2019 18:28:30 +0000 (UTC)
Message-ID: <7d369058842123c3038d10a631f5fa4c3e7472ff.camel@perches.com>
Subject: Re: [PATCH v3 02/10] lib: introduce generic min max heap
From:   Joe Perches <joe@perches.com>
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Date:   Sun, 17 Nov 2019 10:28:09 -0800
In-Reply-To: <20191114003042.85252-3-irogers@google.com>
References: <20191114003042.85252-1-irogers@google.com>
         <20191114003042.85252-3-irogers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 16:30 -0800, Ian Rogers wrote:
> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Perhaps some functions are a bit large for inline
and perhaps the function names are too generic?

> diff --git a/include/linux/min_max_heap.h b/include/linux/min_max_heap.h
[]
> +/* Sift the element at pos down the heap. */
> +static inline void heapify(struct min_max_heap *heap, int pos,
> +			const struct min_max_heap_callbacks *func) {
> +	void *left_child, *right_child, *parent, *large_or_smallest;
> +	char *data = (char *)heap->data;

The kernel already depends on void * arithmetic so it
seems char *data could just as well be void *data and
it might be more readable without the temporary at all.

> +
> +	for (;;) {
> +		if (pos * 2 + 1 >= heap->size)
> +			break;
> +
> +		left_child = data + ((pos * 2 + 1) * func->elem_size);
> +		parent = data + (pos * func->elem_size);
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
> +}

[]

> +static void heap_pop_push(struct min_max_heap *heap,
> +			const void *element,
> +			const struct min_max_heap_callbacks *func)
> +{
> +	char *data = (char *)heap->data;
> +
> +	memcpy(data, element, func->elem_size);
> +	heapify(heap, 0, func);
> +}

missing inline.

> +
> +/* Push an element on to the heap, O(log2(size)). */
> +static inline void
> +heap_push(struct min_max_heap *heap, const void *element,
> +	const struct min_max_heap_callbacks *func)
> +{
> +	void *child, *parent;
> +	int pos;
> +	char *data = (char *)heap->data;

Same comment about char * vs void * and unnecessary temporary.

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
> +		child = data + (pos * func->elem_size);
> +		parent = data + ((pos - 1) / 2) * func->elem_size;
> +		if (func->cmp(parent, child))
> +			break;
> +		func->swp(parent, child);
> +	}
> +}
> +
> +#endif /* _LINUX_MIN_MAX_HEAP_H */


