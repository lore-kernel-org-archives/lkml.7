Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF259C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A42217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561589814;
	bh=yo71BW543URwix7cTvmxvou/Zqigt30jEMLC6h5wM3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pcmLRchN2J42GoWNYj+5fuvpa9JxaDVjDk64kO9+FQaexnkxmLSY8jw0cG1An2rlx
	 y1KQC5AfWP/qKqUajSZyqG0OZffhuhRYoMUTnbNg0t7xRxeuGic0qAFgA0PImQ46Cc
	 miCrTppKH5j6onp6x43RiQPvg4nEiv9myEcEgJjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFZW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFZW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:56:53 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E37B20665;
        Wed, 26 Jun 2019 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561589812;
        bh=yo71BW543URwix7cTvmxvou/Zqigt30jEMLC6h5wM3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U8i1ubLZG8J4ORUFtJT9VaSwjplP7PFznXjZlFjbkT8vcj1CPbzEhVYA4UciiVHS4
         8eLWZCq2wrGjdOfMWluyOt5aWiUrLV4FKs5hVM50KqPKa3oWocNyuTRvNa4RWgyEgV
         FxQPxsvU/bUCjxH2iFU2OCmzE3l+6hzGOhndb46c=
Date:   Wed, 26 Jun 2019 15:56:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 4/5] mm/slab: Refactor common ksize KASAN logic into
 slab_common.c
Message-Id: <20190626155650.c525aa7fad387e32be290b50@linux-foundation.org>
In-Reply-To: <20190626142014.141844-5-elver@google.com>
References: <20190626142014.141844-1-elver@google.com>
        <20190626142014.141844-5-elver@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 16:20:13 +0200 Marco Elver <elver@google.com> wrote:

> This refactors common code of ksize() between the various allocators
> into slab_common.c: __ksize() is the allocator-specific implementation
> without instrumentation, whereas ksize() includes the required KASAN
> logic.
> 
> ...
>
>  /**
> - * ksize - get the actual amount of memory allocated for a given object
> - * @objp: Pointer to the object
> + * __ksize -- Uninstrumented ksize.
>   *
> - * kmalloc may internally round up allocations and return more memory
> - * than requested. ksize() can be used to determine the actual amount of
> - * memory allocated. The caller may use this additional memory, even though
> - * a smaller amount of memory was initially specified with the kmalloc call.
> - * The caller must guarantee that objp points to a valid object previously
> - * allocated with either kmalloc() or kmem_cache_alloc(). The object
> - * must not be freed during the duration of the call.
> - *
> - * Return: size of the actual memory used by @objp in bytes
> + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> + * safety checks as ksize() with KASAN instrumentation enabled.
>   */
> -size_t ksize(const void *objp)
> +size_t __ksize(const void *objp)
>  {
> -	size_t size;
> -
>  	BUG_ON(!objp);
>  	if (unlikely(objp == ZERO_SIZE_PTR))
>  		return 0;
>  
> -	size = virt_to_cache(objp)->object_size;
> -	/* We assume that ksize callers could use the whole allocated area,
> -	 * so we need to unpoison this area.
> -	 */
> -	kasan_unpoison_shadow(objp, size);
> -
> -	return size;
> +	return virt_to_cache(objp)->object_size;
>  }

This conflicts with Kees's "mm/slab: sanity-check page type when
looking up cache". 
https://ozlabs.org/~akpm/mmots/broken-out/mm-slab-sanity-check-page-type-when-looking-up-cache.patch

Here's what I ended up with:

/**
 * __ksize -- Uninstrumented ksize.
 *
 * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
 * safety checks as ksize() with KASAN instrumentation enabled.
 */
size_t __ksize(const void *objp)
{
	size_t size;
	struct kmem_cache *c;

	BUG_ON(!objp);
	if (unlikely(objp == ZERO_SIZE_PTR))
		return 0;

	c = virt_to_cache(objp);
	size = c ? c->object_size : 0;

	return size;
}
EXPORT_SYMBOL(__ksize);

> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1597,6 +1597,32 @@ void kzfree(const void *p)
>  }
>  EXPORT_SYMBOL(kzfree);
>  
> +/**
> + * ksize - get the actual amount of memory allocated for a given object
> + * @objp: Pointer to the object
> + *
> + * kmalloc may internally round up allocations and return more memory
> + * than requested. ksize() can be used to determine the actual amount of
> + * memory allocated. The caller may use this additional memory, even though
> + * a smaller amount of memory was initially specified with the kmalloc call.
> + * The caller must guarantee that objp points to a valid object previously
> + * allocated with either kmalloc() or kmem_cache_alloc(). The object
> + * must not be freed during the duration of the call.
> + *
> + * Return: size of the actual memory used by @objp in bytes
> + */
> +size_t ksize(const void *objp)
> +{
> +	size_t size = __ksize(objp);
> +	/*
> +	 * We assume that ksize callers could use whole allocated area,
> +	 * so we need to unpoison this area.
> +	 */
> +	kasan_unpoison_shadow(objp, size);
> +	return size;
> +}
> +EXPORT_SYMBOL(ksize);

That looks OK still.
