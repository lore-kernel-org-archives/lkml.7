Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9101C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B48E2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GdGm/gg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgAIMcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:32:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43011 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgAIMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:32:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so5062150lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dNz1YuP2AfKv0aZ9saeylvptSi351fPnO7qobVoMRPk=;
        b=GdGm/gg9gF45ctnIoiAyLlkYKo33jPT+zrPTv/pl2hZZ6QaHmJO21KrwGt9KvHGEPL
         //3gnS3w08b6zS0fqIkZcsw+5+z208KqUol6784i8GL/QEg+CwD7bGpWP8TKHNMEw3AT
         kitiLOeLTZOAAh9T6yv1uyFzyKsQdxBfd6i86nW/UbbqsD7b6UUmtBXDvtT5mXGYgnjQ
         ie+iZLuLh5X8YOp+QYnqkj7ZD2iLV7FCRda9ffCMsV5hoZzIuJ9FSyMF7JvM/ufUUT0q
         SqWgIvk6mXNh40JIkwcoh0gH+Lu3Abav4EJh5zXCjUcvALpxwPLOQUKTuFBvi5WPYaMe
         lxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNz1YuP2AfKv0aZ9saeylvptSi351fPnO7qobVoMRPk=;
        b=kMBgiRInHhq2Bxed6Ww080q2VuGdyNsodCUQXeUgOi87WWaXrzqpSNI2xL6NOAJQWm
         3owBLQqM3VP95f+XJsV4UwYsy95Z5YZG3i9trTXefZHMTUPxcX2ebJWnXlI9NI++m1li
         wsfZWSG1hjvz8krI9knR7uzkXhUAe6otCnC4hD/VdEu2kWP9Y4HTGF3ug/8x7L/5P+op
         sOrs8TbfPxi5bH10/JUzVAm8G517w+UJ1FVFqGqnOy5Ol97P6ZEO39mfVWoSs9yc/w33
         xalueg6DIzo+qiQZUQLQDqWD5tzJ8TNyjyuZ4iU2mM7dw7NLAAlNirHAevfuaUXAUVur
         C7gQ==
X-Gm-Message-State: APjAAAVd1jBH4h3WI7C8CmAfOduwdZ8+FnSS8HDxsPxy3G4QkgUukOc2
        TBtPysgEdca2t9oqfrWzLq3deg==
X-Google-Smtp-Source: APXvYqwcL80LZwTLfyb+q6lO6S1d/bO/4ZzrS9E/1X9t7wr0uSPvxZEh1sXI5zuaBEWWE9Xv5oU83Q==
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr6079826lfq.24.1578573154370;
        Thu, 09 Jan 2020 04:32:34 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b19sm3000589ljk.25.2020.01.09.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:32:33 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7095B1007DB; Thu,  9 Jan 2020 15:32:33 +0300 (+03)
Date:   Thu, 9 Jan 2020 15:32:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        richard.weiyang@gmail.com
Subject: Re: [RFC PATCH] mm/rmap.c: finer hwpoison granularity for PTE-mapped
 THP
Message-ID: <20200109123233.ye2h4dxaubu4ad22@box>
References: <20200102030421.30799-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102030421.30799-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:04:21AM +0800, Wei Yang wrote:
> Currently we behave differently between PMD-mapped THP and PTE-mapped
> THP on memory_failure.
> 
> User detected difference:
> 
>     For PTE-mapped THP, the whole 2M range will trigger MCE after
>     memory_failure(), while only 4K range for PMD-mapped THP will.
> 
> Direct reason:
> 
>     All the 512 PTE entry will be marked as hwpoison entry for a PTE-mapped
>     THP while only one PTE will be marked for a PMD-mapped THP.
> 
> Root reason:
> 
>     The root cause is PTE-mapped page doesn't need to split pmd which skip
>     the SPLIT_FREEZE process.

I don't follow how SPLIT_FREEZE is related to pisoning. Cold you
laraborate?

>     This makes try_to_unmap_one() do its job when
>     the THP is not splited. And since page is HWPOISON, all the entries in
>     THP is marked as hwpoison entry.
> 
>     While for the PMD-mapped THP, SPLIT_FREEZE will save migration entry to
>     pte and this skip try_to_unmap_one() before THP splited. And then only
>     the affected 4k page is marked as hwpoison entry.
> 
> This patch tries to provide a finer granularity for PTE-mapped THP by
> only mark the affected subpage as hwpoison entry when THP is not
> split.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> This complicates the picture a little, while I don't find a better way to
> improve. 
> 
> Also I may miss some case or not handle this properly.
> 
> Look forward your comments.
> ---
>  mm/rmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b3e381919835..90229917dd64 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1554,10 +1554,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  				set_huge_swap_pte_at(mm, address,
>  						     pvmw.pte, pteval,
>  						     vma_mmu_pagesize(vma));
> -			} else {
> +			} else if (!PageAnon(page) || page == subpage) {
>  				dec_mm_counter(mm, mm_counter(page));
>  				set_pte_at(mm, address, pvmw.pte, pteval);
> -			}
> +			} else
> +				goto freeze;
>  
>  		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
>  			/*
> @@ -1579,6 +1580,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			swp_entry_t entry;
>  			pte_t swp_pte;
>  
> +freeze:
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
