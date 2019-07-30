Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54103C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1513B206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KOUGq7zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfG3O7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:59:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40772 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfG3O7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:59:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so62832050eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1OEUHJAeJuir02frAc/X7UiYIxvDviag+lOCO2z8Si0=;
        b=KOUGq7zysuAvE4at0kpunn/9Swua/F5SVdKPFwxdiiIeL56jNWqXb8ZQZa5qGsNr7V
         QD6bP3Q4zszfH0VhIAWqObOmxipyHePvV2ZvOnqcZ34niW2D8zWnzi2MbvG3xOQZboOG
         whNAdEE/VZyH/hMrfbhkrodxr/LkN2whTZ/7v3zZFNhrz2A21IZ1alPUJ9/b8jL/Y5zg
         mYeAL+F+cQ307+fnBuUumeKCHrK3SXcSGNV+o9pKJFIUjwi1MvTTCn7O7v9czAE+Eutd
         yxHTvOmBCZATZeLJroEYg8k7OG0wV5k8LAjEcHhIDDaaD8DR3BSOmnGG973PWbZeoe6r
         RKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1OEUHJAeJuir02frAc/X7UiYIxvDviag+lOCO2z8Si0=;
        b=T3ixUJM8SK3//CE/7LnL6dsFyNZcXLYwoacvVukDbpkYh7H/Vp5n8dtRzPLozEwnnP
         PHLOaNOSu5cw4seFunMK6MQIr0SawqzOxcvSrD3gcviWE8h7PnnMotfZQcBoJKJzN+xt
         R0mea56eUDeMM+Bu5L/DpeHChrX3xamqGOYgPPuda5E7Y45MKfqqmaamtu/NtF2CQGZ9
         wDx+CjxxeCsQl5PAjrBjs1mQW/16gvKE6D4YVyCHQu+2KY59eqr9X+inZ2D4ezAQ6tko
         JG1TtIBW/r3KZYDX0gioIxojwKwLs6+bcUrK1eKhZMQrlb4F/Gxq6n4BiaF72xBse4sT
         NT7Q==
X-Gm-Message-State: APjAAAVIbHGLPUqy/6pUIsnAgcFp75IoUIU427inFZXmAVQtg2l16Blo
        TmWQz2euqQGXbQ8/yAO+AdZf77TA
X-Google-Smtp-Source: APXvYqwmER3ENBQ3PycVe77F3GLiXz2oNqpGaj5ZDb+WG1FV3RPBYSSBfpBKNQnJUvmYAtTe097f1g==
X-Received: by 2002:a50:91ef:: with SMTP id h44mr102245801eda.276.1564498761916;
        Tue, 30 Jul 2019 07:59:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id oa21sm10568353ejb.60.2019.07.30.07.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 07:59:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 52DCC100AD0; Tue, 30 Jul 2019 17:59:22 +0300 (+03)
Date:   Tue, 30 Jul 2019 17:59:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, oleg@redhat.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        srikar@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190730145922.m5omqqf7rmilp6yy@box>
References: <20190729054335.3241150-1-songliubraving@fb.com>
 <20190729054335.3241150-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729054335.3241150-2-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:43:34PM -0700, Song Liu wrote:
> khugepaged needs exclusive mmap_sem to access page table. When it fails
> to lock mmap_sem, the page will fault in as pte-mapped THP. As the page
> is already a THP, khugepaged will not handle this pmd again.
> 
> This patch enables the khugepaged to retry collapse the page table.
> 
> struct mm_slot (in khugepaged.c) is extended with an array, containing
> addresses of pte-mapped THPs. We use array here for simplicity. We can
> easily replace it with more advanced data structures when needed. This
> array is protected by khugepaged_mm_lock.
> 
> In khugepaged_scan_mm_slot(), if the mm contains pte-mapped THP, we try
> to collapse the page table.
> 
> Since collapse may happen at an later time, some pages may already fault
> in. collapse_pte_mapped_thp() is added to properly handle these pages.
> collapse_pte_mapped_thp() also double checks whether all ptes in this pmd
> are mapping to the same THP. This is necessary because some subpage of
> the THP may be replaced, for example by uprobe. In such cases, it is not
> possible to collapse the pmd.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/khugepaged.h |  15 ++++
>  mm/khugepaged.c            | 136 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 082d1d2a5216..2d700830fe0e 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -15,6 +15,16 @@ extern int __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  				      unsigned long vm_flags);
> +#ifdef CONFIG_SHMEM
> +extern int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +					 unsigned long addr);
> +#else
> +static inline int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +						unsigned long addr)
> +{
> +	return 0;
> +}
> +#endif
>  
>  #define khugepaged_enabled()					       \
>  	(transparent_hugepage_flags &				       \
> @@ -73,6 +83,11 @@ static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  {
>  	return 0;
>  }
> +static inline int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +						unsigned long addr)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #endif /* _LINUX_KHUGEPAGED_H */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index eaaa21b23215..247c25aeb096 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -76,6 +76,7 @@ static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>  
>  static struct kmem_cache *mm_slot_cache __read_mostly;
>  
> +#define MAX_PTE_MAPPED_THP 8

Is MAX_PTE_MAPPED_THP value random or do you have any justification for
it?

Please add empty line after it.

>  /**
>   * struct mm_slot - hash lookup from mm to mm_slot
>   * @hash: hash collision list
> @@ -86,6 +87,10 @@ struct mm_slot {
>  	struct hlist_node hash;
>  	struct list_head mm_node;
>  	struct mm_struct *mm;
> +
> +	/* pte-mapped THP in this mm */
> +	int nr_pte_mapped_thp;
> +	unsigned long pte_mapped_thp[MAX_PTE_MAPPED_THP];
>  };
>  
>  /**
> @@ -1281,11 +1286,141 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  			up_write(&vma->vm_mm->mmap_sem);
>  			mm_dec_nr_ptes(vma->vm_mm);
>  			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
> +		} else if (down_read_trylock(&vma->vm_mm->mmap_sem)) {
> +			/* need down_read for khugepaged_test_exit() */
> +			khugepaged_add_pte_mapped_thp(vma->vm_mm, addr);
> +			up_read(&vma->vm_mm->mmap_sem);
>  		}
>  	}
>  	i_mmap_unlock_write(mapping);
>  }
>  
> +/*
> + * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
> + * khugepaged should try to collapse the page table.
> + */
> +int khugepaged_add_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)

What is contract about addr alignment? Do we expect it PAGE_SIZE aligned
or PMD_SIZE aligned? Do we want to enforce it?

> +{
> +	struct mm_slot *mm_slot;
> +	int ret = 0;
> +
> +	/* hold mmap_sem for khugepaged_test_exit() */
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +
> +	if (unlikely(khugepaged_test_exit(mm)))
> +		return 0;
> +
> +	if (!test_bit(MMF_VM_HUGEPAGE, &mm->flags) &&
> +	    !test_bit(MMF_DISABLE_THP, &mm->flags)) {
> +		ret = __khugepaged_enter(mm);
> +		if (ret)
> +			return ret;
> +	}

Any reason not to call khugepaged_enter() here?

> +
> +	spin_lock(&khugepaged_mm_lock);
> +	mm_slot = get_mm_slot(mm);
> +	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
> +		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;

It's probably good enough for start, but I'm not sure how useful it will
be for real application, considering the limitation.

> +

Useless empty line?

> +	spin_unlock(&khugepaged_mm_lock);
> +	return 0;
> +}
> +
> +/**
> + * Try to collapse a pte-mapped THP for mm at address haddr.
> + *
> + * This function checks whether all the PTEs in the PMD are pointing to the
> + * right THP. If so, retract the page table so the THP can refault in with
> + * as pmd-mapped.
> + */
> +static void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long haddr)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, haddr);
> +	pmd_t *pmd = mm_find_pmd(mm, haddr);
> +	struct page *hpage = NULL;
> +	unsigned long addr;
> +	spinlock_t *ptl;
> +	int count = 0;
> +	pmd_t _pmd;
> +	int i;
> +
> +	if (!vma || !pmd || pmd_trans_huge(*pmd))
> +		return;
> +
> +	/* step 1: check all mapped PTEs are to the right huge page */
> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +		struct page *page;
> +
> +		if (pte_none(*pte))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, *pte);
> +
> +		if (!PageCompound(page))
> +			return;

I think khugepaged_scan_shmem() and collapse_shmem() should changed to not
stop on PageTransCompound() to make this useful for more cases.

Ideally, it collapse_shmem() and this routine should be the same thing.
Or do you thing it's not doable for some reason?

> +
> +		if (!hpage) {
> +			hpage = compound_head(page);
> +			if (hpage->mapping != vma->vm_file->f_mapping)
> +				return;
> +		}
> +
> +		if (hpage + i != page)
> +			return;
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
> +	if (hpage) {
> +		page_ref_sub(hpage, count);
> +		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
> +	}
> +
> +	/* step 4: collapse pmd */
> +	ptl = pmd_lock(vma->vm_mm, pmd);
> +	_pmd = pmdp_collapse_flush(vma, addr, pmd);
> +	spin_unlock(ptl);
> +	mm_dec_nr_ptes(mm);
> +	pte_free(mm, pmd_pgtable(_pmd));
> +}
> +
> +static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
> +{
> +	struct mm_struct *mm = mm_slot->mm;
> +	int i;
> +
> +	lockdep_assert_held(&khugepaged_mm_lock);
> +
> +	if (likely(mm_slot->nr_pte_mapped_thp == 0))
> +		return 0;
> +
> +	if (!down_write_trylock(&mm->mmap_sem))
> +		return -EBUSY;
> +
> +	if (unlikely(khugepaged_test_exit(mm)))
> +		goto out;
> +
> +	for (i = 0; i < mm_slot->nr_pte_mapped_thp; i++)
> +		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i]);
> +
> +out:
> +	mm_slot->nr_pte_mapped_thp = 0;
> +	up_write(&mm->mmap_sem);
> +	return 0;
> +}
> +
>  /**
>   * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
>   *
> @@ -1667,6 +1802,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  		khugepaged_scan.address = 0;
>  		khugepaged_scan.mm_slot = mm_slot;
>  	}
> +	khugepaged_collapse_pte_mapped_thps(mm_slot);
>  	spin_unlock(&khugepaged_mm_lock);
>  
>  	mm = mm_slot->mm;
> -- 
> 2.17.1
> 

-- 
 Kirill A. Shutemov
