Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDDC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023902077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L7v0SvPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfKGVTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:19:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42998 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfKGVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:19:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so2770415pgt.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 13:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viAE1CpzSxuRD/BH/MsOEcY+j2yNDU+1S4harELGxYA=;
        b=L7v0SvPM5wqtmIimdjoJlflFSCiarLVuMjw5tUDVJV49TBb/GIt3CUBOIRdHA3BebG
         Ve5aORzfLA3uMKYoSVZ1gtyANrv2YIhfT/YcS6c3Q8pkkKaEMXiPnQ6k95ZHy7YBdqKu
         wHLJLsaK2CXPSDDGzOxGxu8cIP/NX7P3BJYgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viAE1CpzSxuRD/BH/MsOEcY+j2yNDU+1S4harELGxYA=;
        b=uLGIB7ofLw5aBtkaT3vRYP0w/D72o/g63OkodR4uQrlXn80XC0uDO7aVztI8AphqH6
         2PbPb35m8GRpsN9GdVCukxT3qjMbMDnB3a8Y+EoKD8X8DTlnpp/rKzOYg75WKYu3Td+7
         Et2IBCLOz9mh2L2uiUHDYDprInWOX0+J4bXnZfRTaHvRt+6eRmQf95TgjY/N6dPzj1Wu
         LP7UcKwEe0NEFbPpUC6o+unCMxEq6HPCDSitJ6TBtwpmoqVL9soduvN24pjBXBTtUEqO
         BsCFEz4qoJmnzwczNJyDwCnYlADL69yRRmd3LT+2Hgr4VvJ2MStqDy8Zqr5uRSXCS1RU
         4alw==
X-Gm-Message-State: APjAAAWTFavl0CU0sptS/bOjFEfNXjHab1hZrIJ8jm1n6eM8JrUxun4y
        RZlgK3jv8K12pNCXiNaOMBoR1A==
X-Google-Smtp-Source: APXvYqyO2euuNiOHUndxT0zs1UCgY+o45HB5aAKJRIOZnSb6erehLpmH4sarPYmnZvA+5tGzW5rT/w==
X-Received: by 2002:a63:5c21:: with SMTP id q33mr7533017pgb.61.1573161592677;
        Thu, 07 Nov 2019 13:19:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm3040014pgh.37.2019.11.07.13.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:19:51 -0800 (PST)
Date:   Thu, 7 Nov 2019 13:19:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/test_meminit.c: Add bulk alloc/free tests
Message-ID: <201911071318.A2FB7A9@keescook>
References: <20191107191447.23058-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107191447.23058-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:14:47PM -0500, Laura Abbott wrote:
> 
> kmem_cache_alloc_bulk/kmem_cache_free_bulk are used to
> make multiple allocations of the same size to avoid the
> overhead of multiple kmalloc/kfree calls. Extend the kmem_cache
> tests to make some calls to these APIs.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Thanks! Andrew, can you add this to -mm please?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_meminit.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> index 9729f271d150..20f330948b92 100644
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -183,6 +183,9 @@ static bool __init check_buf(void *buf, int size, bool want_ctor,
>  	return fail;
>  }
>  
> +#define BULK_SIZE 100
> +static void *bulk_array[BULK_SIZE];
> +
>  /*
>   * Test kmem_cache with given parameters:
>   *  want_ctor - use a constructor;
> @@ -203,9 +206,24 @@ static int __init do_kmem_cache_size(size_t size, bool want_ctor,
>  			      want_rcu ? SLAB_TYPESAFE_BY_RCU : 0,
>  			      want_ctor ? test_ctor : NULL);
>  	for (iter = 0; iter < 10; iter++) {
> +		/* Do a test of bulk allocations */
> +		if (!want_rcu && !want_ctor) {
> +			int ret;
> +
> +			ret = kmem_cache_alloc_bulk(c, alloc_mask, BULK_SIZE, bulk_array);
> +			if (!ret) {
> +				fail = true;
> +			} else {
> +				int i;
> +				for (i = 0; i < ret; i++)
> +					fail |= check_buf(bulk_array[i], size, want_ctor, want_rcu, want_zero);
> +				kmem_cache_free_bulk(c, ret, bulk_array);
> +			}
> +		}
> +
>  		buf = kmem_cache_alloc(c, alloc_mask);
>  		/* Check that buf is zeroed, if it must be. */
> -		fail = check_buf(buf, size, want_ctor, want_rcu, want_zero);
> +		fail |= check_buf(buf, size, want_ctor, want_rcu, want_zero);
>  		fill_with_garbage_skip(buf, size, want_ctor ? CTOR_BYTES : 0);
>  
>  		if (!want_rcu) {
> -- 
> 2.21.0
> 

-- 
Kees Cook
