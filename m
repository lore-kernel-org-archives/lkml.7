Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5809C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8252075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbKjdPWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFUBBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:01:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:01:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so2453541pgr.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jOk3PreZ3YiInlE3LTXkzPl68+QbundNai30bAJKnEU=;
        b=PbKjdPWcdAzMqG/JzK1HR0UcqG/UX8eh2967eEegjSLi4avW+I1MWzePzFoaR/RhDz
         v936+ryvXqtDcxrnJqsy5S/83EDuAVf5GwkEF/Kd7NU5M9kBznE739f8ulkLOKnCN5TP
         BgbRDjDHZ8uwDaNrUzaVY5sjhf5UK5VV4W7MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOk3PreZ3YiInlE3LTXkzPl68+QbundNai30bAJKnEU=;
        b=iGJ6hErWfJ0BFzM+UWt+b2ImcQoZ+uxz67xGpM22d4iy4HDqQyBlBtTWWXScm6RN1J
         W8zhl3U0uY6noVMid11G0rlISgvkhY5izwmDYR1MwK3/bJRPX9JmhkfNEdhthASO+1zr
         CBDwKpNFLf5/247bz8gEI54N5Dx3Mmf1tRt2y4WSQYv9VJ0kyR+F+AcZn6Wl4VjjA/NA
         0FqCVDzip+766UCQcUa2jJjYYRHiZe4AKp3UYHQYvDJP6IMN21UUIharuuicM8uGxzOD
         dlId2ONyuYxIfaMR/oZIP1DGe/6RLSalZWDD9S+RGbHHj9uAVHdMJXBHvoEk9Zq3A9fl
         qMuA==
X-Gm-Message-State: APjAAAULtw2l6evoh53hS8ClJJICbPxJVZLoNTPYNChw2zbfovH1I+e/
        Jvy/BHt4Yi3/fdFsAcnuiOp5bA==
X-Google-Smtp-Source: APXvYqwVLiWe21jhFrAmpCuL2rGWSXFn0Xn+zlSdAo/GWr7qvi7R3zAyZAmL5tMFTjfT5QVEED6QXQ==
X-Received: by 2002:a65:50c3:: with SMTP id s3mr15343980pgp.177.1561078902926;
        Thu, 20 Jun 2019 18:01:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v13sm650415pfe.105.2019.06.20.18.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 18:01:42 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:01:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, glider@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/page_alloc: fix a false memory corruption
Message-ID: <201906201801.9CFC9225@keescook>
References: <1561063566-16335-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561063566-16335-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:46:06PM -0400, Qian Cai wrote:
> The linux-next commit "mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options" [1] introduced a false positive when
> init_on_free=1 and page_poison=on, due to the page_poison expects the
> pattern 0xaa when allocating pages which were overwritten by
> init_on_free=1 with 0.
> 
> Fix it by switching the order between kernel_init_free_pages() and
> kernel_poison_pages() in free_pages_prepare().

Cool; this seems like the right approach. Alexander, what do you think?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> [1] https://patchwork.kernel.org/patch/10999465/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: After further debugging, the issue after switching order is likely a
>     separate issue as clear_page() should not cause issues with future
>     accesses.
> 
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 54dacf35d200..32bbd30c5f85 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1172,9 +1172,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  					   PAGE_SIZE << order);
>  	}
>  	arch_free_page(page, order);
> -	kernel_poison_pages(page, 1 << order, 0);
>  	if (want_init_on_free())
>  		kernel_init_free_pages(page, 1 << order);
> +
> +	kernel_poison_pages(page, 1 << order, 0);
>  	if (debug_pagealloc_enabled())
>  		kernel_map_pages(page, 1 << order, 0);
>  
> -- 
> 1.8.3.1
> 

-- 
Kees Cook
