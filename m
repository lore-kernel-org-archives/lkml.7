Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D627C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A572182B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfEKAlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 20:41:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38864 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 20:41:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id a64so4809036qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 17:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jbkUKFn8++TsU9Za8XuJSDEs43zcgIMnpYRuVZebT4=;
        b=C3tEAWV4u/Y8Hor9Tt8QxfqxUbXtYjNTpJiLGxAB4jVpuvQc9UHEX81KPI/0gY5afs
         bENsUqtxSii6Ahb1FFwkARLIb38RJw9A4JzCM9K6HwuL9b84DsCI0ZPe3ag6S8vZza1Y
         T94vvTTT9z8PJnjK9/vkknXjr60uxv0qis7oerOebMh/yddMaoA7ku7rTM6bIiHOi8os
         66loveKnIy0q96D5eaQcSTb3ggzOlD/M4iGop4OmbqOoxjVjCZFGuu2p4dWVAD9Q+8Ym
         06f0lMT4t6UbcgjY1Mk3D7jBRadvVTpuAGVMpRN9J2ukEoq6eWzVUMuX1bxPxN0aFizV
         ba1w==
X-Gm-Message-State: APjAAAVsVMKAZ5T93I79D1GC8hHoCw6zTMiQ+Snetrk7vmH76oI/Rga3
        r8dzxs/kEdzneGNVL7ungLcheTfdoLg=
X-Google-Smtp-Source: APXvYqyG/TvQToTghUYqqWG9TYIUBvmqVR2SgTZob9JNYGLspxTeABm3+Hb9lMYXHBQ+9rmEFd9yqg==
X-Received: by 2002:a05:620a:1184:: with SMTP id b4mr11862355qkk.15.1557535306153;
        Fri, 10 May 2019 17:41:46 -0700 (PDT)
Received: from [172.20.2.92] ([65.202.30.10])
        by smtp.gmail.com with ESMTPSA id x7sm3468390qkc.22.2019.05.10.17.41.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 17:41:45 -0700 (PDT)
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
References: <201905101341.A17DDD7@keescook>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
Date:   Fri, 10 May 2019 20:41:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905101341.A17DDD7@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/19 3:43 PM, Kees Cook wrote:
> This feature continues to cause more problems than it solves[1]. Its
> intention was to check the bounds of page-allocator allocations by using
> __GFP_COMP, for which we would need to find all missing __GFP_COMP
> markings. This work has been on hold and there is an argument[2]
> that such markings are not even the correct signal for checking for
> same-allocation pages. Instead of depending on BROKEN, this just removes
> it entirely. It can be trivially reverted if/when a better solution for
> tracking page allocator sizes is found.
> 
> [1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
> [2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   mm/usercopy.c    | 67 ------------------------------------------------
>   security/Kconfig | 11 --------
>   2 files changed, 78 deletions(-)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 14faadcedd06..15dc1bf03303 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -159,70 +159,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>   		usercopy_abort("null address", NULL, to_user, ptr, n);
>   }
>   
> -/* Checks for allocs that are marked in some way as spanning multiple pages. */
> -static inline void check_page_span(const void *ptr, unsigned long n,
> -				   struct page *page, bool to_user)
> -{
> -#ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
> -	const void *end = ptr + n - 1;
> -	struct page *endpage;
> -	bool is_reserved, is_cma;
> -
> -	/*
> -	 * Sometimes the kernel data regions are not marked Reserved (see
> -	 * check below). And sometimes [_sdata,_edata) does not cover
> -	 * rodata and/or bss, so check each range explicitly.
> -	 */
> -
> -	/* Allow reads of kernel rodata region (if not marked as Reserved). */
> -	if (ptr >= (const void *)__start_rodata &&
> -	    end <= (const void *)__end_rodata) {
> -		if (!to_user)
> -			usercopy_abort("rodata", NULL, to_user, 0, n);
> -		return;
> -	}
> -
> -	/* Allow kernel data region (if not marked as Reserved). */
> -	if (ptr >= (const void *)_sdata && end <= (const void *)_edata)
> -		return;
> -
> -	/* Allow kernel bss region (if not marked as Reserved). */
> -	if (ptr >= (const void *)__bss_start &&
> -	    end <= (const void *)__bss_stop)
> -		return;
> -


I agree the page spanning is broken but is it worth keeping the
checks against __rodata __bss etc.?

> -	/* Is the object wholly within one base page? */
> -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> -		return;
> -
> -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> -	endpage = virt_to_head_page(end);
> -	if (likely(endpage == page))
> -		return;
> -
> -	/*
> -	 * Reject if range is entirely either Reserved (i.e. special or
> -	 * device memory), or CMA. Otherwise, reject since the object spans
> -	 * several independently allocated pages.
> -	 */
> -	is_reserved = PageReserved(page);
> -	is_cma = is_migrate_cma_page(page);
> -	if (!is_reserved && !is_cma)
> -		usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
> -
> -	for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
> -		page = virt_to_head_page(ptr);
> -		if (is_reserved && !PageReserved(page))
> -			usercopy_abort("spans Reserved and non-Reserved pages",
> -				       NULL, to_user, 0, n);
> -		if (is_cma && !is_migrate_cma_page(page))
> -			usercopy_abort("spans CMA and non-CMA pages", NULL,
> -				       to_user, 0, n);
> -	}
> -#endif
> -}
> -
>   static inline void check_heap_object(const void *ptr, unsigned long n,
>   				     bool to_user)
>   {
> @@ -236,9 +172,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>   	if (PageSlab(page)) {
>   		/* Check slab allocator for flags and size. */
>   		__check_heap_object(ptr, n, page, to_user);
> -	} else {
> -		/* Verify object does not incorrectly span multiple pages. */
> -		check_page_span(ptr, n, page, to_user);
>   	}
>   }
>   
> diff --git a/security/Kconfig b/security/Kconfig
> index 353cfef71d4e..8392647f5a4c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -176,17 +176,6 @@ config HARDENED_USERCOPY_FALLBACK
>   	  Booting with "slab_common.usercopy_fallback=Y/N" can change
>   	  this setting.
>   
> -config HARDENED_USERCOPY_PAGESPAN
> -	bool "Refuse to copy allocations that span multiple pages"
> -	depends on HARDENED_USERCOPY
> -	depends on EXPERT
> -	help
> -	  When a multi-page allocation is done without __GFP_COMP,
> -	  hardened usercopy will reject attempts to copy it. There are,
> -	  however, several cases of this in the kernel that have not all
> -	  been removed. This config is intended to be used only while
> -	  trying to find such users.
> -
>   config FORTIFY_SOURCE
>   	bool "Harden common str/mem functions against buffer overflows"
>   	depends on ARCH_HAS_FORTIFY_SOURCE
> 

