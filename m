Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76787C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfFRIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:40:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:40:24 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ADC1426023F;
        Tue, 18 Jun 2019 09:40:22 +0100 (BST)
Date:   Tue, 18 Jun 2019 10:40:19 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        George Spelvin <lkml@sdf.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/sort.c: implement sort() variant taking context
 argument
Message-ID: <20190618104019.316dce06@collabora.com>
In-Reply-To: <20190617211453.31928-1-linux@rasmusvillemoes.dk>
References: <20190617155125.62da2946@collabora.com>
        <20190617211453.31928-1-linux@rasmusvillemoes.dk>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Mon, 17 Jun 2019 23:14:52 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Our list_sort() utility has always supported a context argument that
> is passed through to the comparison routine. Now there's a use case
> for the similar thing for sort().
> 
> This implements sort_r by simply extending the existing sort function
> in the obvious way. To avoid code duplication, we want to implement
> sort() in terms of sort_r(). The naive way to do that is
> 
> static int cmp_wrapper(const void *a, const void *b, const void *ctx)
> {
>   int (*real_cmp)(const void*, const void*) = ctx;
>   return real_cmp(a, b);
> }
> 
> sort(..., cmp) { sort_r(..., cmp_wrapper, cmp) }
> 
> but this would do two indirect calls for each comparison. Instead, do
> as is done for the default swap functions - that only adds a cost of a
> single easily predicted branch to each comparison call.
> 
> Aside from introducing support for the context argument, this also
> serves as preparation for patches that will eliminate the indirect
> comparison calls in common cases.
> 
> Requested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Hi Boris
> 
> Sorry, completely dropped the ball on this one.

No problem.

> Here's a formal patch
> with change log. I won't have time to do the other changes I mention
> this side of the merge window, so it's perfectly fine if you carry
> this as part of your series.

Not sure my series will make it for the next release, but I'll let you
know either way.

> It's only been tested by booting a kernel
> in qemu with CONFIG_TEST_SORT=y, and nothing exploded.

Thanks for the patch.

Boris

> 
>  include/linux/sort.h |  5 +++++
>  lib/sort.c           | 34 ++++++++++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sort.h b/include/linux/sort.h
> index 2b99a5dd073d..61b96d0ebc44 100644
> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h
> @@ -4,6 +4,11 @@
>  
>  #include <linux/types.h>
>  
> +void sort_r(void *base, size_t num, size_t size,
> +	    int (*cmp)(const void *, const void *, const void *),
> +	    void (*swap)(void *, void *, int),
> +	    const void *priv);
> +
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp)(const void *, const void *),
>  	  void (*swap)(void *, void *, int));
> diff --git a/lib/sort.c b/lib/sort.c
> index cf408aec3733..36fcc2040be5 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -144,6 +144,18 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
>  		swap_func(a, b, (int)size);
>  }
>  
> +typedef int (*cmp_func_t)(const void *, const void *);
> +typedef int (*cmp_r_func_t)(const void *, const void *, const void *);
> +#define _CMP_WRAPPER ((cmp_r_func_t)0L)
> +
> +static int do_cmp(const void *a, const void *b,
> +		  cmp_r_func_t cmp, const void *priv)
> +{
> +	if (cmp == _CMP_WRAPPER)
> +		return ((cmp_func_t)(priv))(a, b);
> +	return cmp(a, b, priv);
> +}
> +
>  /**
>   * parent - given the offset of the child, find the offset of the parent.
>   * @i: the offset of the heap element whose parent is sought.  Non-zero.
> @@ -171,12 +183,13 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
>  }
>  
>  /**
> - * sort - sort an array of elements
> + * sort_r - sort an array of elements
>   * @base: pointer to data to sort
>   * @num: number of elements
>   * @size: size of each element
>   * @cmp_func: pointer to comparison function
>   * @swap_func: pointer to swap function or NULL
> + * @priv: third argument passed to comparison function
>   *
>   * This function does a heapsort on the given array.  You may provide
>   * a swap_func function if you need to do something more than a memory
> @@ -188,9 +201,10 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
>   * O(n*n) worst-case behavior and extra memory requirements that make
>   * it less suitable for kernel use.
>   */
> -void sort(void *base, size_t num, size_t size,
> -	  int (*cmp_func)(const void *, const void *),
> -	  void (*swap_func)(void *, void *, int size))
> +void sort_r(void *base, size_t num, size_t size,
> +	    int (*cmp_func)(const void *, const void *, const void *),
> +	    void (*swap_func)(void *, void *, int size),
> +	    const void *priv)
>  {
>  	/* pre-scale counters for performance */
>  	size_t n = num * size, a = (num/2) * size;
> @@ -238,12 +252,12 @@ void sort(void *base, size_t num, size_t size,
>  		 * average, 3/4 worst-case.)
>  		 */
>  		for (b = a; c = 2*b + size, (d = c + size) < n;)
> -			b = cmp_func(base + c, base + d) >= 0 ? c : d;
> +			b = do_cmp(base + c, base + d, cmp_func, priv) >= 0 ? c : d;
>  		if (d == n)	/* Special case last leaf with no sibling */
>  			b = c;
>  
>  		/* Now backtrack from "b" to the correct location for "a" */
> -		while (b != a && cmp_func(base + a, base + b) >= 0)
> +		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) >= 0)
>  			b = parent(b, lsbit, size);
>  		c = b;			/* Where "a" belongs */
>  		while (b != a) {	/* Shift it into place */
> @@ -252,4 +266,12 @@ void sort(void *base, size_t num, size_t size,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL(sort_r);
> +
> +void sort(void *base, size_t num, size_t size,
> +	    int (*cmp_func)(const void *, const void *),
> +	    void (*swap_func)(void *, void *, int size))
> +{
> +	return sort_r(base, num, size, _CMP_WRAPPER, swap_func, cmp_func);
> +}
>  EXPORT_SYMBOL(sort);

