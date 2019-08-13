Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3EA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="agR9AvYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfHMMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:35:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43140 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfHMMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:35:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so6331754qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S54lLa6bgYl50xMneQkBqoB3M0F5v0sM817U2bzthXY=;
        b=agR9AvYOrhFisIq3zyRg4IM/ZRdhZf5/0lqKd2pNTQa5RoGvsDs5PPhxDI9RK9Ol3C
         qf5Mt7bSLQVchVswI/LpN3Hdt+DjL7mwdWm1lQsCA1Hvf5dhov2H0jnYUWm8AOBJwhaD
         aQy2Y5h7zApILOwcTVb/pK5XYc+Y03KG7nbm7a6wJjzBgu5tk4jTHz8a5qyha8hJ8yhJ
         k38Z2rz1wQNMBxKbrr1vwAZyySgH7XW6ZSSj3keFjJ2+8Cw/Nc5nKW9dF0YTcWM8Y8GI
         uCH4ArZP7E+cApAfFDOTSvvER6PZp4dC8dQQhKcwStWa123KCF/qCHrhqTDnceK27Sm7
         YhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S54lLa6bgYl50xMneQkBqoB3M0F5v0sM817U2bzthXY=;
        b=rvsOqQ1M6FZE4mrXdBkkwMkT7Qcf+UGc1wdFufndXItdNmh84zJKJlbg8rI++xnv9L
         jpWTY90Gua2vLqAHu4AzgPhrz6MHd1SB07VuC4yx+FZEIXCJQeYGXaNGhHijyuJ4uEQ7
         behXfuX/d25YVUkryESDwvl6nTkLRHjmHzgX/Gt0pD5+EYk24iVYtxZFFlLTybSpj/gw
         qkCh1BkA70uSsRxHyi4O9cNGfLJ1r9saVlWZeci6wPFswqmExzyUd+uXvtTvCA3GmKC1
         5gs4rfp/G0K+maszWgELoHE5dPVqZ6kICY4Bv/xr9NiUdH5b0GFZhhyk3skd7TANIvte
         1Q+Q==
X-Gm-Message-State: APjAAAWIS4Pd1lJ03mQvDIm/pFPiVg4Thnn3mPKXtv/U+SRB0196Xv2P
        fxPZIaCRofbofhSiOvb6oVsf/g==
X-Google-Smtp-Source: APXvYqxtXmnf0GGchCLA6EVm/YadIfQw8wWVCxKFsbu+A1RacfwS39mJeDS31/OUgGDLvtQ1S4X/rQ==
X-Received: by 2002:a0c:fa02:: with SMTP id q2mr5488260qvn.28.1565699757517;
        Tue, 13 Aug 2019 05:35:57 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y25sm10208095qkj.35.2019.08.13.05.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 05:35:56 -0700 (PDT)
Message-ID: <1565699754.8572.8.camel@lca.pw>
Subject: Re: [PATCH v3 3/3] mm: kmemleak: Use the memory pool for early
 allocations
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 13 Aug 2019 08:35:54 -0400
In-Reply-To: <20190812160642.52134-4-catalin.marinas@arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
         <20190812160642.52134-4-catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 17:06 +0100, Catalin Marinas wrote:
> Currently kmemleak uses a static early_log buffer to trace all memory
> allocation/freeing before the slab allocator is initialised. Such early
> log is replayed during kmemleak_init() to properly initialise the
> kmemleak metadata for objects allocated up that point. With a memory
> pool that does not rely on the slab allocator, it is possible to skip
> this early log entirely.
> 
> In order to remove the early logging, consider kmemleak_enabled == 1 by
> default while the kmem_cache availability is checked directly on the
> object_cache and scan_area_cache variables. The RCU callback is only
> invoked after object_cache has been initialised as we wouldn't have any
> concurrent list traversal before this.
> 
> In order to reduce the number of callbacks before kmemleak is fully
> initialised, move the kmemleak_init() call to mm_init().
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  init/main.c       |   2 +-
>  lib/Kconfig.debug |  11 +-
>  mm/kmemleak.c     | 267 +++++-----------------------------------------
>  3 files changed, 35 insertions(+), 245 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 96f8d5af52d6..ca05e3cd7ef7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -556,6 +556,7 @@ static void __init mm_init(void)
>  	report_meminit();
>  	mem_init();
>  	kmem_cache_init();
> +	kmemleak_init();
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> @@ -740,7 +741,6 @@ asmlinkage __visible void __init start_kernel(void)
>  		initrd_start = 0;
>  	}
>  #endif
> -	kmemleak_init();
>  	setup_per_cpu_pageset();
>  	numa_policy_init();
>  	acpi_early_init();
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4d39540011e2..39df06ffd9f4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -592,17 +592,18 @@ config DEBUG_KMEMLEAK
>  	  In order to access the kmemleak file, debugfs needs to be
>  	  mounted (usually at /sys/kernel/debug).
>  
> -config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> -	int "Maximum kmemleak early log entries"
> +config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> +	int "Kmemleak memory pool size"
>  	depends on DEBUG_KMEMLEAK
>  	range 200 40000
>  	default 16000

Hmm, this seems way too small. My previous round of testing with
kmemleak.mempool=524288 works quite well on all architectures.
