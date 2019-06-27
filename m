Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A093DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A7D20659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZM5jrqkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfF0QHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:07:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33625 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfF0QHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:07:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so1560626plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YubArmml1h3da19oo14hDKUh4iUk2iId9IFXcb+lgfE=;
        b=ZM5jrqkf1YPQbShg55KDMRK1AN3BPBhV1rfjC02j8tBiDqKSXL/oWs7V6cvjIBQTns
         uLwb7Xo2dWd0Jxc2Y8eQwBFXKoFJM7ycdsQnAwlvl1hiwA5fYeI5fJKCqY80nLPYmovI
         JpC6AI+aU7O+uTMLz8MZXgL42KaRt7ZabJkNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YubArmml1h3da19oo14hDKUh4iUk2iId9IFXcb+lgfE=;
        b=ESPC2z9WapYLhObszjqduXm+AKPzLijizsG26DCeMIb88njRKY2oZzqTbxvN9sCh9r
         Gsm3smjL4uCQvRG0LV5j6sTXl05jLqvwn4HUOVF/StOUtVfKrvfLZ6hm+7k87WtUZ2gU
         1TAA/++54pDn9xsaw3Zcz3Sdr3iwjM7m+y6Sy/k12ybHOV0lojgkZe2mz5OpCzIUy0Ok
         YZ7lOzQT+d9HCvHmTm/YfTj9zxUXKbyFctGChX/8rbT3RIpVfojSTJ2E+IWP+2dMAz2E
         gzPHZY9FGbkjC0M7NypgQPUiLCP+xtgvs2Wd1sz+M+IN0F17RM1dGOu+ZEH9WgDjhKiW
         wRfw==
X-Gm-Message-State: APjAAAVANwNseR8WfhtGhO8QLCKTQDjLtlOpd+NJ/f790d5TIDleFLRJ
        DMVtoStAc2r+09a4GmPiEDyRGw==
X-Google-Smtp-Source: APXvYqxIq0TpaZ0zSQZtZhkI/74V37DVi1HouI3w6I5BzO0yXzYiL7aJZqJNRqs/ejob+/YzW1mf5g==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr5760668pld.41.1561651629814;
        Thu, 27 Jun 2019 09:07:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10sm3514357pfd.151.2019.06.27.09.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 09:07:08 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:07:08 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v4 5/5] mm/kasan: Add object validation in ksize()
Message-ID: <201906270906.9EE619600@keescook>
References: <20190627094445.216365-1-elver@google.com>
 <20190627094445.216365-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627094445.216365-6-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:44:45AM +0200, Marco Elver wrote:
> ksize() has been unconditionally unpoisoning the whole shadow memory region
> associated with an allocation. This can lead to various undetected bugs,
> for example, double-kzfree().
> 
> Specifically, kzfree() uses ksize() to determine the actual allocation
> size, and subsequently zeroes the memory. Since ksize() used to just
> unpoison the whole shadow memory region, no invalid free was detected.
> 
> This patch addresses this as follows:
> 
> 1. Add a check in ksize(), and only then unpoison the memory region.
> 
> 2. Preserve kasan_unpoison_slab() semantics by explicitly unpoisoning
>    the shadow memory region using the size obtained from __ksize().
> 
> Tested:
> 1. With SLAB allocator: a) normal boot without warnings; b) verified the
>    added double-kzfree() is detected.
> 2. With SLUB allocator: a) normal boot without warnings; b) verified the
>    added double-kzfree() is detected.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199359
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
> v4:
> * Prefer WARN_ON_ONCE() instead of BUG_ON().
> ---
>  include/linux/kasan.h |  7 +++++--
>  mm/slab_common.c      | 22 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b40ea104dd36..cc8a03cc9674 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -76,8 +76,11 @@ void kasan_free_shadow(const struct vm_struct *vm);
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>  
> -size_t ksize(const void *);
> -static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
> +size_t __ksize(const void *);
> +static inline void kasan_unpoison_slab(const void *ptr)
> +{
> +	kasan_unpoison_shadow(ptr, __ksize(ptr));
> +}
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>  
>  bool kasan_save_enable_multi_shot(void);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b7c6a40e436a..a09bb10aa026 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1613,7 +1613,27 @@ EXPORT_SYMBOL(kzfree);
>   */
>  size_t ksize(const void *objp)
>  {
> -	size_t size = __ksize(objp);
> +	size_t size;
> +
> +	if (WARN_ON_ONCE(!objp))
> +		return 0;
> +	/*
> +	 * We need to check that the pointed to object is valid, and only then
> +	 * unpoison the shadow memory below. We use __kasan_check_read(), to
> +	 * generate a more useful report at the time ksize() is called (rather
> +	 * than later where behaviour is undefined due to potential
> +	 * use-after-free or double-free).
> +	 *
> +	 * If the pointed to memory is invalid we return 0, to avoid users of
> +	 * ksize() writing to and potentially corrupting the memory region.
> +	 *
> +	 * We want to perform the check before __ksize(), to avoid potentially
> +	 * crashing in __ksize() due to accessing invalid metadata.
> +	 */
> +	if (unlikely(objp == ZERO_SIZE_PTR) || !__kasan_check_read(objp, 1))
> +		return 0;
> +
> +	size = __ksize(objp);
>  	/*
>  	 * We assume that ksize callers could use whole allocated area,
>  	 * so we need to unpoison this area.
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
