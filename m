Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F6C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gLVeUTEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCMW3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:29:45 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46681 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:29:44 -0400
Received: by mail-ed1-f44.google.com with SMTP id n17so2918822edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GooeRtkEcBASn20ecj7vkhUgshUAUPCUJgQbIy2WuQE=;
        b=gLVeUTEpKLqULgDkY9DZ4mObm3hO83MraIn3nEv9gZMCV0a104E4nm3vcQ8B4kOJxo
         nS5Np76pUCl1hUSAbZnBTc2vuxHwnmOfVHXn/X/Y+Qij5zovbYJjIK0KiL2tBl1LTlgo
         qPGE4CLM39PisQTZ22BjlR6jg7fNuSTx2STCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GooeRtkEcBASn20ecj7vkhUgshUAUPCUJgQbIy2WuQE=;
        b=tXMCOYu3hAbwhhZNwZRaBOyS/7a9+blFsk1Y0l7si1jysXf+99p2Y4p90PjkVs7N9/
         Mc2zUl1wao66Wciob7E6hmJq4xROXmetJGlD/y8gTMMK7k1ga+0eWuSox2mLC/DACOS8
         H6rGq9PEGUVfrifooV+aQoR3bW4DEIKyB/1o6lNaS23OsTWDd8UXNCxFObA0Kw0728FT
         hcHt2Chk1zMgarokpv9x75F6II3tWp65J4lk4jFoj/LJ2ggmDr4VieVH+e6T2ZDh32pm
         it7J/MIvFG/DbftS24ZYQXXVuDGG5oQUY/2HX5bBryR90p8Pr2h/qEp3enG4OqdXzxC1
         e2pg==
X-Gm-Message-State: APjAAAViHCQnRHnl6LJX/HuEFJKldgpZM5HCHkQ5n11b0BPyk5JOeXlS
        gljItN3RkdizpGWMsKebDDK77Q==
X-Google-Smtp-Source: APXvYqwiYO9eGVyaSMDf7KW9mF7T6mPGa0QET+A5dHqk8QJCp+062F4A/U65hiFoX+mM4BIwKi9OFA==
X-Received: by 2002:a17:906:c7ce:: with SMTP id dc14mr1226238ejb.165.1552516182308;
        Wed, 13 Mar 2019 15:29:42 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id f41sm658985eda.77.2019.03.13.15.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 15:29:41 -0700 (PDT)
Subject: Re: [PATCH 2/5] lib/sort: Use more efficient bottom-up heapsort
 variant
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dbac34c6052fc973fb55df4966981bae24c7cce9.1552097842.git.lkml@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <472510ad-77f9-49e8-4122-52f447cb1c15@rasmusvillemoes.dk>
Date:   Wed, 13 Mar 2019 23:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dbac34c6052fc973fb55df4966981bae24c7cce9.1552097842.git.lkml@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 09.21, George Spelvin wrote:
>  
> +/**
> + * parent - given the offset of the child, find the offset of the parent.
> + * @i: the offset of the heap element whose parent is sought.  Non-zero.
> + * @lsbit: a precomputed 1-bit mask, equal to "size & -size"
> + * @size: size of each element
> + *
> + * In terms of array indexes, the parent of element j = i/size is simply
> + * (j-1)/2.  But when working in byte offsets, we can't use implicit
> + * truncation of integer divides.
> + *
> + * Fortunately, we only need one bit of the quotient, not the full divide.
> + * size has a least significant bit.  That bit will be clear if i is
> + * an even multiple of size, and set if it's an odd multiple.
> + *
> + * Logically, we're doing "if (i & lsbit) i -= size;", but since the
> + * branch is unpredictable, it's done with a bit of clever branch-free
> + * code instead.
> + */
> +__attribute_const__ __always_inline
> +static size_t parent(size_t i, unsigned int lsbit, size_t size)
> +{
> +	i -= size;
> +	i -= size & -(i & lsbit);
> +	return i / 2;
> +}
> +

Really nice :) I had to work through this by hand, but it's solid.

>  /**
>   * sort - sort an array of elements
>   * @base: pointer to data to sort
> @@ -125,21 +151,26 @@ static void generic_swap(void *a, void *b, int size)
>   * @cmp_func: pointer to comparison function
>   * @swap_func: pointer to swap function or NULL
>   *
> - * This function does a heapsort on the given array. You may provide a
> - * swap_func function optimized to your element type.
> + * This function does a heapsort on the given array.  You may provide a
> + * swap_func function if you need to do something more than a memory copy
> + * (e.g. fix up pointers or auxiliary data), but the built-in swap isn't
> + * usually a bottleneck.
>   *
>   * Sorting time is O(n log n) both on average and worst-case. While
>   * qsort is about 20% faster on average, it suffers from exploitable
>   * O(n*n) worst-case behavior and extra memory requirements that make
>   * it less suitable for kernel use.
>   */
> -
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp_func)(const void *, const void *),
>  	  void (*swap_func)(void *, void *, int size))
>  {
>  	/* pre-scale counters for performance */
> -	int i = (num/2 - 1) * size, n = num * size, c, r;
> +	size_t n = num * size, a = (num/2) * size;
> +	unsigned const lsbit = size & -size;	/* Used to find parent */
> +

Nit: qualifier before type, "const unsigned". And this sets ZF, so a
paranoid check for zero size (cf. the other mail) by doing "if (!lsbit)
return;" is practically free. Though it's probably a bit obscure doing
it that way...

> +	if (!n)
> +		return;

I'd make that n <= 1. Shouldn't be much more costly.

> -		}
> -	}
> +	/*
> +	 * Loop invariants:
> +	 * 1. elements [a,n) satisfy the heap property (compare greater than
> +	 *    all of their children),
> +	 * 2. elements [n,num*size) are sorted, and
> +	 * 3. a <= b <= c <= d <= n (whenever they are valid).
> +	 */
> +	for (;;) {
> +		size_t b, c, d;
>  

> +		if (a)			/* Building heap: sift down --a */
> +			a -= size;
> +		else if (n -= size)	/* Sorting: Extract root to --n */
> +			swap_func(base, base + n, size);
> +		else			/* Sort complete */
> +			break;
> +
> +		/*
> +		 * Sift element at "a" down into heap.  This is the
> +		 * "bottom-up" variant, which significantly reduces
> +		 * calls to cmp_func(): we find the sift-down path all
> +		 * the way to the leaves (one compare per level), then
> +		 * backtrack to find where to insert the target element.
> +		 *
> +		 * Because elements tend to sift down close to the leaves,
> +		 * this uses fewer compares than doing two per level
> +		 * on the way down.  (A bit more than half as many on
> +		 * average, 3/4 worst-case.)
> +		 */
> +		for (b = a; c = 2*b + size, (d = c + size) < n;)
> +			b = cmp_func(base + c, base + d) >= 0 ? c : d;
> +		if (d == n)	/* Special case last leaf with no sibling */
> +			b = c;
> +
> +		/* Now backtrack from "b" to the correct location for "a" */
> +		while (b != a && cmp_func(base + a, base + b) >= 0)
> +			b = parent(b, lsbit, size);
> +		c = b;			/* Where "a" belongs */
> +		while (b != a) {	/* Shift it into place */
> +			b = parent(b, lsbit, size);
> +			swap_func(base + b, base + c, size);
>  		}
>  	}
>  }
> 

Nice!

Rasmus
