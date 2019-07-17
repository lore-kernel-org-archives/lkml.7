Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6CCC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851321873
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTU141rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfGQTng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:43:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfGQTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:43:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so11356641pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=B4KkASSByiIr8GwQ9SOJWtTimb9yBfYMRGwI3wSnBvU=;
        b=pTU141rSxqpEpOL4UTml41bJC99Bbi08614VBV9iACXfdQBYQMGLsTxyZ5eWCJAsxp
         PkmS856N30EwaXjbhF/ogszdHLt5Y16oU9gI/Webo0Vzi3aLl7HBczJU2vNPyd+qTCEu
         Q3maXbuUy2yk1XlmTAlUbOmk1w6cqlSqw4Gt8BjP7ChFlly+n1AVNH7KVan6v6f2Elvx
         g4XUKTtvMIwVBZ0eeC13hoMhs+oVB4chrRXX80ycgTxXu0xYpRCAz4p4g4Z2ttJIctMO
         D5r4iEMm9pJU+QauaDTSBBFfvWV9kONhJqPiCSKskg6RibNRsS9fk61AKXSnuBtq18le
         smkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=B4KkASSByiIr8GwQ9SOJWtTimb9yBfYMRGwI3wSnBvU=;
        b=HKtYDpBNZ/koz0F5ZnZ/uzdKcSL7ARGQSfYsayWrCNsjm/gv3xd78xsWxEf2S7DMxK
         Eop4xvbEFF6gIhBE/f5QA2PQYs47dBoemQm5GUqNrOkpo9rVKpINf5KRTT9Dx7B4JSG9
         6tqplhKmO0OudPLLcR5DXFpWXxdshgoYRfkqVxhZ8nKf7WIL/fBUO3YjiNquIYhQl8xU
         rm7zH3BpI6WrSDz8rAHnm2C7z7hyfFWbAF2EQBTyTlFuetIf1dTXdhvI9HQG0LZ6ADoA
         dpXiEXV11upN4OdOHXc0NuB0FhbiT2Jx3/4LPdiGzqw0Ugge4mIU6Ik7Rk0XX1ct+PNv
         F3bw==
X-Gm-Message-State: APjAAAVjpRvWO/JWj+YKViFULUZITbE8O7qcUERpnIYFXOkPVjhHJV4o
        l65C+qwkYDP5p0beJMg7VyvrAg==
X-Google-Smtp-Source: APXvYqzKGlDmY51u8++gkpOHjmKk/bWpr+ftMMYT73CajTWO+QPVJd5fQMfIA9xY+GncnpV3QweYkw==
X-Received: by 2002:a63:d944:: with SMTP id e4mr42815562pgj.261.1563392614248;
        Wed, 17 Jul 2019 12:43:34 -0700 (PDT)
Received: from [100.112.64.100] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id r75sm27194536pfc.18.2019.07.17.12.43.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jul 2019 12:43:33 -0700 (PDT)
Date:   Wed, 17 Jul 2019 12:43:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: thp: make transhuge_vma_suitable available
 for anonymous THP
In-Reply-To: <1560401041-32207-2-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1907171207080.1177@eggly.anvils>
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com> <1560401041-32207-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Yang Shi wrote:

> The transhuge_vma_suitable() was only available for shmem THP, but
> anonymous THP has the same check except pgoff check.  And, it will be
> used for THP eligible check in the later patch, so make it available for
> all kind of THPs.  This also helps reduce code duplication slightly.
> 
> Since anonymous THP doesn't have to check pgoff, so make pgoff check
> shmem vma only.

Yes, I think you are right to avoid the pgoff check on anonymous.
I had originally thought that it would work out okay even with the
pgoff check on anonymous, and usually it would: but could give the
wrong answer on an mremap-moved anonymous area.

> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Almost Acked-by me, but there's one nit I'd much prefer to change:
sorry for being such a late nuisance...

> ---
>  mm/huge_memory.c |  2 +-
>  mm/internal.h    | 25 +++++++++++++++++++++++++
>  mm/memory.c      | 13 -------------
>  3 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9f8bce9..4bc2552 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -691,7 +691,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  	struct page *page;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  
> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> +	if (!transhuge_vma_suitable(vma, haddr))
>  		return VM_FAULT_FALLBACK;
>  	if (unlikely(anon_vma_prepare(vma)))
>  		return VM_FAULT_OOM;
> diff --git a/mm/internal.h b/mm/internal.h
> index 9eeaf2b..7f096ba 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -555,4 +555,29 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  
>  void setup_zone_pageset(struct zone *zone);
>  extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
> +static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> +		unsigned long haddr)
> +{
> +	/* Don't have to check pgoff for anonymous vma */
> +	if (!vma_is_anonymous(vma)) {
> +		if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
> +			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
> +			return false;
> +	}
> +
> +	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> +		return false;
> +	return true;
> +}
> +#else
> +static inline bool transhuge_vma_suitable(struct vma_area_struct *vma,
> +		unsigned long haddr)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif	/* __MM_INTERNAL_H */

... maybe I'm just not much of a fan of mm/internal.h (where at last you
find odd bits and pieces which you had expected to find elsewhere), and
maybe others will disagree: but I'd say transhuge_vma_suitable() surely
belongs in include/linux/huge_mm.h, near __transparent_hugepage_enabled().

But then your correct use of vma_is_anonymous() gets more complicated:
because that declaration is over in include/linux/mm.h; and although
linux/mm.h includes linux/huge_mm.h, vma_is_anonymous() comes lower down.

However... linux/mm.h's definition of vma_set_anonymous() comes higher
up, and it would make perfect sense to move vma_is_anonymous up to just
after vma_set_anonymous(), wouldn't it?  Should vma_is_shmem() and
vma_is_stack_for_current() declarations move with it? Probably yes:
they make more sense near vma_is_anonymous() than where they were.

Hugh

> diff --git a/mm/memory.c b/mm/memory.c
> index 96f1d47..2286424 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3205,19 +3205,6 @@ static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
> -
> -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> -		unsigned long haddr)
> -{
> -	if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
> -			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
> -		return false;
> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> -		return false;
> -	return true;
> -}
> -
>  static void deposit_prealloc_pte(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> -- 
> 1.8.3.1
