Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0425C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB30020673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhYC3RAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGCBJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:09:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37699 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:09:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so626431oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdfQkc10ZEHgoDK1SNLlrirAzmY3Oa6pflTI/YkyqLs=;
        b=lhYC3RAwDyVnsu9qutRDpMePchtvZtnds0Au+8BDVd355z2kcvCxxoUeLKjoKsqljz
         0nmLPHcuV4BsV31lBWyb6mlGmxOpTzAUBz3C6sba5YMsicyvHffJNot/FkRrgQ3yleek
         oCMyTMO8UPmvAvc2f4O1rOTb61xIvaciq0FTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdfQkc10ZEHgoDK1SNLlrirAzmY3Oa6pflTI/YkyqLs=;
        b=LKMpLr/Iq0n40ptxXRtTgyWkQFqMoGBfAdnN1+gdqQ0StV8Zx8Q9QM826YP7iRie/j
         zRGwGudqVwhAZSjrW5NAuyj3gydq2boeezB39F4IhAPCQ3fs0pS/LR0s4wTS0ReBeThM
         my220iuiu/r+Amg4wi6cDGp2pDBHLBwEuv1+TrxIfQQR/3SJ+kk/sB3/gsiW12DwQpR4
         5F5/iPgIUUz7hd6L1aOOvI0oBNhQ6W5Gc9MX4mOuh7Omx0JJqAsdQz6uEn0uz6xGAjkp
         3BG1mqlxZ0gUUEIOCsFF1kjgn8A47BP2CZ6sM7jadKAEPsq+iWjSSAk+3ByJhmEPms11
         cuOQ==
X-Gm-Message-State: APjAAAWfreYtvAZGTUJS5IEkUm/g9VGs4nJuGtf6kPJeq7JjUGJ8wfdE
        FZbq4yePXRIkG3yYitd3Ps0seJDifZs=
X-Google-Smtp-Source: APXvYqyxHmfAgHSytPsWrix4p+ZJ6+jIhYHj/U+jxRorMiv/9wt4TCSDHqnkrKqjPvgxgFZ/tzVnIA==
X-Received: by 2002:a65:500d:: with SMTP id f13mr32057264pgo.151.1562101458715;
        Tue, 02 Jul 2019 14:04:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p23sm6217pfn.10.2019.07.02.14.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:04:14 -0700 (PDT)
Date:   Tue, 2 Jul 2019 10:11:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <201907021009.3CF9EBB4@keescook>
References: <201905101341.A17DDD7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905101341.A17DDD7@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 01:43:36PM -0700, Kees Cook wrote:
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

So, after looking at this more, I think I'm going to keep this patch,
and we can add new sanity checks on a per-Page flag check. (See below.)

Andrew, can you apply this to -mm please?

> ---
>  mm/usercopy.c    | 67 ------------------------------------------------
>  security/Kconfig | 11 --------
>  2 files changed, 78 deletions(-)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 14faadcedd06..15dc1bf03303 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -159,70 +159,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>  		usercopy_abort("null address", NULL, to_user, ptr, n);
>  }
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
>  static inline void check_heap_object(const void *ptr, unsigned long n,
>  				     bool to_user)
>  {
> @@ -236,9 +172,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	if (PageSlab(page)) {
>  		/* Check slab allocator for flags and size. */
>  		__check_heap_object(ptr, n, page, to_user);
> -	} else {
> -		/* Verify object does not incorrectly span multiple pages. */
> -		check_page_span(ptr, n, page, to_user);
>  	}

In the future, instead of this catch-all "else", we can add things like:

	} else if (PageCompound(page)) {
		... do some check for compound pages ...
	} else if (PageReserved(page))
		... etc ...
	}

But for 5.3, I think we need to just entirely drop the PAGESPAN thing.

-Kees

>  }
>  
> diff --git a/security/Kconfig b/security/Kconfig
> index 353cfef71d4e..8392647f5a4c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -176,17 +176,6 @@ config HARDENED_USERCOPY_FALLBACK
>  	  Booting with "slab_common.usercopy_fallback=Y/N" can change
>  	  this setting.
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
>  config FORTIFY_SOURCE
>  	bool "Harden common str/mem functions against buffer overflows"
>  	depends on ARCH_HAS_FORTIFY_SOURCE
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
