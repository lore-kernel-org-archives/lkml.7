Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F2C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5052133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pAzALn6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfFXNTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:19:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfFXNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:19:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so21718004edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rl49ZjQOWKHc6PSmuS0py6dY6eFBF2erKrnaVhI/v1M=;
        b=pAzALn6CQwLJtoYs5SQYVCa9v/b1tWSbSzL07o0W4Tc8FYNtib0147hiNS+18LrYH2
         nmExBiqLml5FZngdyJgAC0sd+q4qbUZABFxRl5dLBjq/kb/zSLnK7Pdp+Wu8ZqCEgkIV
         3JmoycRRxo845zITP2NlIcRCLq6RKDDz/uy5LB/5icV3e+/NCE+N3Qxf98/blAH62/6C
         N4BMClgLCH0BkSltmgoS3ewLXEJ5oRiPALlR9mkT+0dlb+FYKWNCKYqXV1jVG4Y24SIC
         QWTP0jrmgtg660GAjAYSe3/G5b5Nt97K4HTgv4D59v/P+WnIUjS8R8y8SyzWnDR5Yv5M
         UoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rl49ZjQOWKHc6PSmuS0py6dY6eFBF2erKrnaVhI/v1M=;
        b=QLPx5Ltvon/ANY7FNJ/gUdF3k5rMSjUaEGmLvrStVG1yj14ycU+eDAMnAp7/11kQ4I
         9RZ39117kqPF+P9GsCP0lTOt54WxWAs+t8hBEe1i2+QxA6uHgPRgtTVoVkr4kYSED8sB
         P9PU/AkshChKr3mKdFtxMkuMEy6Au7IW+0/DCracMvJVvWFPUBcCoqx/kxI9TS1gNkcc
         R0uFbBnHghlgBM1Haqw7fZcTLbHPJ38WnyooI9KiRocR2p+kDuJNZ0bAgMCKjrtTxmp2
         kEDnNmYTlTgQQevnNPX1/LW+a1a3iiYfUbBR6eJcM1wkgQtIOTmhcq3c72fn5ZGGH0ao
         nObA==
X-Gm-Message-State: APjAAAVoLJgE9TmuDllwHYcoTL/N+FbRkPHNJIm1KXlBoy9LcTOhmTbo
        vKnJHsbfIdpkNRkfKeHobgLGzA==
X-Google-Smtp-Source: APXvYqyZNea8ZmAmw4kwbTJhQNzzT9FXr6ZmOFVXnlPgc6amqpUX/uB8MqbkXlYNn4zJzAr37l2Jtg==
X-Received: by 2002:aa7:c692:: with SMTP id n18mr110966818edq.220.1561382370462;
        Mon, 24 Jun 2019 06:19:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g16sm3795300edc.76.2019.06.24.06.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:19:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E99EC10439E; Mon, 24 Jun 2019 16:19:34 +0300 (+03)
Date:   Mon, 24 Jun 2019 16:19:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        kernel-team@fb.com, william.kucharski@oracle.com
Subject: Re: [PATCH v6 5/6] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190624131934.m6gbktixyykw65ws@box>
References: <20190623054829.4018117-1-songliubraving@fb.com>
 <20190623054829.4018117-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623054829.4018117-6-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 10:48:28PM -0700, Song Liu wrote:
> khugepaged needs exclusive mmap_sem to access page table. When it fails
> to lock mmap_sem, the page will fault in as pte-mapped THP. As the page
> is already a THP, khugepaged will not handle this pmd again.
> 
> This patch enables the khugepaged to retry retract_page_tables().
> 
> A new flag AS_COLLAPSE_PMD is introduced to show the address_space may
> contain pte-mapped THPs. When khugepaged fails to trylock the mmap_sem,
> it sets AS_COLLAPSE_PMD. Then, at a later time, khugepaged will retry
> compound pages in this address_space.
> 
> Since collapse may happen at an later time, some pages may already fault
> in. To handle these pages properly, it is necessary to prepare the pmd
> before collapsing. prepare_pmd_for_collapse() is introduced to prepare
> the pmd by removing rmap, adjusting refcount and mm_counter.
> 
> prepare_pmd_for_collapse() also double checks whether all ptes in this
> pmd are mapping to the same THP. This is necessary because some subpage
> of the THP may be replaced, for example by uprobe. In such cases, it
> is not possible to collapse the pmd, so we fall back.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/pagemap.h |  1 +
>  mm/khugepaged.c         | 69 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 9ec3544baee2..eac881de2a46 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -29,6 +29,7 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> +	AS_COLLAPSE_PMD = 6,	/* try collapse pmd for THP */
>  };
>  
>  /**
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a4f90a1b06f5..9b980327fd9b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1254,7 +1254,47 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
>  }
>  
>  #if defined(CONFIG_SHMEM) && defined(CONFIG_TRANSPARENT_HUGE_PAGECACHE)
> -static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> +
> +/* return whether the pmd is ready for collapse */
> +bool prepare_pmd_for_collapse(struct vm_area_struct *vma, pgoff_t pgoff,
> +			      struct page *hpage, pmd_t *pmd)
> +{
> +	unsigned long haddr = page_address_in_vma(hpage, vma);
> +	unsigned long addr;
> +	int i, count = 0;
> +
> +	/* step 1: check all mapped PTEs are to this huge page */
> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +
> +		if (pte_none(*pte))
> +			continue;
> +
> +		if (hpage + i != vm_normal_page(vma, addr, *pte))
> +			return false;
> +		count++;
> +	}
> +
> +	/* step 2: adjust rmap */
> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +		struct page *page;
> +
> +		if (pte_none(*pte))
> +			continue;
> +		page = vm_normal_page(vma, addr, *pte);
> +		page_remove_rmap(page, false);
> +	}
> +
> +	/* step 3: set proper refcount and mm_counters. */
> +	page_ref_sub(hpage, count);
> +	add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
> +	return true;
> +}
> +
> +extern pid_t sysctl_dump_pt_pid;
> +static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> +				struct page *hpage)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long addr;
> @@ -1273,21 +1313,21 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		pmd = mm_find_pmd(vma->vm_mm, addr);
>  		if (!pmd)
>  			continue;
> -		/*
> -		 * We need exclusive mmap_sem to retract page table.
> -		 * If trylock fails we would end up with pte-mapped THP after
> -		 * re-fault. Not ideal, but it's more important to not disturb
> -		 * the system too much.
> -		 */
>  		if (down_write_trylock(&vma->vm_mm->mmap_sem)) {
>  			spinlock_t *ptl = pmd_lock(vma->vm_mm, pmd);
> -			/* assume page table is clear */
> +
> +			if (!prepare_pmd_for_collapse(vma, pgoff, hpage, pmd)) {
> +				spin_unlock(ptl);
> +				up_write(&vma->vm_mm->mmap_sem);
> +				continue;
> +			}
>  			_pmd = pmdp_collapse_flush(vma, addr, pmd);
>  			spin_unlock(ptl);
>  			up_write(&vma->vm_mm->mmap_sem);
>  			mm_dec_nr_ptes(vma->vm_mm);
>  			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
> -		}
> +		} else
> +			set_bit(AS_COLLAPSE_PMD, &mapping->flags);
>  	}
>  	i_mmap_unlock_write(mapping);
>  }
> @@ -1561,7 +1601,7 @@ static void collapse_file(struct mm_struct *mm,
>  		/*
>  		 * Remove pte page tables, so we can re-fault the page as huge.
>  		 */
> -		retract_page_tables(mapping, start);
> +		retract_page_tables(mapping, start, new_page);
>  		*hpage = NULL;
>  
>  		khugepaged_pages_collapsed++;
> @@ -1622,6 +1662,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
>  	int present, swap;
>  	int node = NUMA_NO_NODE;
>  	int result = SCAN_SUCCEED;
> +	bool collapse_pmd = false;
>  
>  	present = 0;
>  	swap = 0;
> @@ -1640,6 +1681,14 @@ static void khugepaged_scan_file(struct mm_struct *mm,
>  		}
>  
>  		if (PageTransCompound(page)) {
> +			if (collapse_pmd ||
> +			    test_and_clear_bit(AS_COLLAPSE_PMD,
> +					       &mapping->flags)) {

Who said it's the only PMD range that's subject to collapse? The bit has
to be per-PMD, not per-mapping.

I beleive we can store the bit in struct page of PTE page table, clearing
it if we've mapped anyting that doesn't belong to there from fault path.

And in general this calls for more substantial re-design for khugepaged:
we might want to split if into two different kernel threads. One works on
collapsing small pages into compound and the other changes virtual address
space to map the page as PMD.

Even if only the first step is successful, it's still useful: the new
mapping of the file will get huge page, even if the old is sill
PTE-mapped.

-- 
 Kirill A. Shutemov
