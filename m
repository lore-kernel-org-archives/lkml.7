Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63DAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB620811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfDVULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbfDVULd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F1AFC13070F;
        Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7F05D9D4;
        Mon, 22 Apr 2019 20:11:28 +0000 (UTC)
Date:   Mon, 22 Apr 2019 16:11:26 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 15/31] mm: introduce
 __lru_cache_add_active_or_unevictable
Message-ID: <20190422201126.GF14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-16-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-16-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 22 Apr 2019 20:11:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:06PM +0200, Laurent Dufour wrote:
> The speculative page fault handler which is run without holding the
> mmap_sem is calling lru_cache_add_active_or_unevictable() but the vm_flags
> is not guaranteed to remain constant.
> Introducing __lru_cache_add_active_or_unevictable() which has the vma flags
> value parameter instead of the vma pointer.
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/swap.h | 10 ++++++++--
>  mm/memory.c          |  8 ++++----
>  mm/swap.c            |  6 +++---
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4bfb5c4ac108..d33b94eb3c69 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -343,8 +343,14 @@ extern void deactivate_file_page(struct page *page);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
>  
> -extern void lru_cache_add_active_or_unevictable(struct page *page,
> -						struct vm_area_struct *vma);
> +extern void __lru_cache_add_active_or_unevictable(struct page *page,
> +						unsigned long vma_flags);
> +
> +static inline void lru_cache_add_active_or_unevictable(struct page *page,
> +						struct vm_area_struct *vma)
> +{
> +	return __lru_cache_add_active_or_unevictable(page, vma->vm_flags);
> +}
>  
>  /* linux/mm/vmscan.c */
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
> diff --git a/mm/memory.c b/mm/memory.c
> index 56802850e72c..85ec5ce5c0a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2347,7 +2347,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
>  		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(new_page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(new_page, vma);
> +		__lru_cache_add_active_or_unevictable(new_page, vmf->vma_flags);
>  		/*
>  		 * We call the notify macro here because, when using secondary
>  		 * mmu page tables (such as kvm shadow page tables), we want the
> @@ -2896,7 +2896,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (unlikely(page != swapcache && swapcache)) {
>  		page_add_new_anon_rmap(page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(page, vma);
> +		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  	} else {
>  		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
>  		mem_cgroup_commit_charge(page, memcg, true, false);
> @@ -3048,7 +3048,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	page_add_new_anon_rmap(page, vma, vmf->address, false);
>  	mem_cgroup_commit_charge(page, memcg, false, false);
> -	lru_cache_add_active_or_unevictable(page, vma);
> +	__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  setpte:
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>  
> @@ -3327,7 +3327,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
>  		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  		page_add_new_anon_rmap(page, vma, vmf->address, false);
>  		mem_cgroup_commit_charge(page, memcg, false, false);
> -		lru_cache_add_active_or_unevictable(page, vma);
> +		__lru_cache_add_active_or_unevictable(page, vmf->vma_flags);
>  	} else {
>  		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>  		page_add_file_rmap(page, false);
> diff --git a/mm/swap.c b/mm/swap.c
> index 3a75722e68a9..a55f0505b563 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -450,12 +450,12 @@ void lru_cache_add(struct page *page)
>   * directly back onto it's zone's unevictable list, it does NOT use a
>   * per cpu pagevec.
>   */
> -void lru_cache_add_active_or_unevictable(struct page *page,
> -					 struct vm_area_struct *vma)
> +void __lru_cache_add_active_or_unevictable(struct page *page,
> +					   unsigned long vma_flags)
>  {
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
> +	if (likely((vma_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
>  		SetPageActive(page);
>  	else if (!TestSetPageMlocked(page)) {
>  		/*
> -- 
> 2.21.0
> 
