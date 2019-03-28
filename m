Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D322C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE220700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfC2A7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:59:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:47520 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfC2A7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:59:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 17:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="144783633"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2019 17:54:50 -0700
Date:   Thu, 28 Mar 2019 09:53:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 08/11] mm/hmm: mirror hugetlbfs (snapshoting, faulting
 and DMA mapping) v2
Message-ID: <20190328165343.GG31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-9-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325144011.10560-9-jglisse@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:40:08AM -0400, Jerome Glisse wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> HMM mirror is a device driver helpers to mirror range of virtual address.
> It means that the process jobs running on the device can access the same
> virtual address as the CPU threads of that process. This patch adds support
> for hugetlbfs mapping (ie range of virtual address that are mmap of a
> hugetlbfs).
> 
> Changes since v1:
>     - improved commit message
>     - squashed: Arnd Bergmann: fix unused variable warnings
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/hmm.h |  29 ++++++++--
>  mm/hmm.c            | 126 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 138 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 13bc2c72f791..f3b919b04eda 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -181,10 +181,31 @@ struct hmm_range {
>  	const uint64_t		*values;
>  	uint64_t		default_flags;
>  	uint64_t		pfn_flags_mask;
> +	uint8_t			page_shift;
>  	uint8_t			pfn_shift;
>  	bool			valid;
>  };
>  
> +/*
> + * hmm_range_page_shift() - return the page shift for the range
> + * @range: range being queried
> + * Returns: page shift (page size = 1 << page shift) for the range
> + */
> +static inline unsigned hmm_range_page_shift(const struct hmm_range *range)
> +{
> +	return range->page_shift;
> +}
> +
> +/*
> + * hmm_range_page_size() - return the page size for the range
> + * @range: range being queried
> + * Returns: page size for the range in bytes
> + */
> +static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
> +{
> +	return 1UL << hmm_range_page_shift(range);
> +}
> +
>  /*
>   * hmm_range_wait_until_valid() - wait for range to be valid
>   * @range: range affected by invalidation to wait on
> @@ -438,7 +459,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
>   *          struct hmm_range range;
>   *          ...
>   *
> - *          ret = hmm_range_register(&range, mm, start, end);
> + *          ret = hmm_range_register(&range, mm, start, end, page_shift);
>   *          if (ret)
>   *              return ret;
>   *
> @@ -498,7 +519,8 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
>  int hmm_range_register(struct hmm_range *range,
>  		       struct mm_struct *mm,
>  		       unsigned long start,
> -		       unsigned long end);
> +		       unsigned long end,
> +		       unsigned page_shift);
>  void hmm_range_unregister(struct hmm_range *range);
>  long hmm_range_snapshot(struct hmm_range *range);
>  long hmm_range_fault(struct hmm_range *range, bool block);
> @@ -529,7 +551,8 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>  	range->pfn_flags_mask = -1UL;
>  
>  	ret = hmm_range_register(range, range->vma->vm_mm,
> -				 range->start, range->end);
> +				 range->start, range->end,
> +				 PAGE_SHIFT);
>  	if (ret)
>  		return (int)ret;
>  
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 4fe88a196d17..64a33770813b 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -387,11 +387,13 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsigned long end,
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	uint64_t *pfns = range->pfns;
> -	unsigned long i;
> +	unsigned long i, page_size;
>  
>  	hmm_vma_walk->last = addr;
> -	i = (addr - range->start) >> PAGE_SHIFT;
> -	for (; addr < end; addr += PAGE_SIZE, i++) {
> +	page_size = 1UL << range->page_shift;

NIT: page_size = hmm_range_page_size(range);

??

Otherwise:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +	i = (addr - range->start) >> range->page_shift;
> +
> +	for (; addr < end; addr += page_size, i++) {
>  		pfns[i] = range->values[HMM_PFN_NONE];
>  		if (fault || write_fault) {
>  			int ret;
> @@ -703,6 +705,69 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	return 0;
>  }
>  
> +static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
> +				      unsigned long start, unsigned long end,
> +				      struct mm_walk *walk)
> +{
> +#ifdef CONFIG_HUGETLB_PAGE
> +	unsigned long addr = start, i, pfn, mask, size, pfn_inc;
> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> +	struct hmm_range *range = hmm_vma_walk->range;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct hstate *h = hstate_vma(vma);
> +	uint64_t orig_pfn, cpu_flags;
> +	bool fault, write_fault;
> +	spinlock_t *ptl;
> +	pte_t entry;
> +	int ret = 0;
> +
> +	size = 1UL << huge_page_shift(h);
> +	mask = size - 1;
> +	if (range->page_shift != PAGE_SHIFT) {
> +		/* Make sure we are looking at full page. */
> +		if (start & mask)
> +			return -EINVAL;
> +		if (end < (start + size))
> +			return -EINVAL;
> +		pfn_inc = size >> PAGE_SHIFT;
> +	} else {
> +		pfn_inc = 1;
> +		size = PAGE_SIZE;
> +	}
> +
> +
> +	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
> +	entry = huge_ptep_get(pte);
> +
> +	i = (start - range->start) >> range->page_shift;
> +	orig_pfn = range->pfns[i];
> +	range->pfns[i] = range->values[HMM_PFN_NONE];
> +	cpu_flags = pte_to_hmm_pfn_flags(range, entry);
> +	fault = write_fault = false;
> +	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
> +			   &fault, &write_fault);
> +	if (fault || write_fault) {
> +		ret = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	pfn = pte_pfn(entry) + (start & mask);
> +	for (; addr < end; addr += size, i++, pfn += pfn_inc)
> +		range->pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
> +	hmm_vma_walk->last = end;
> +
> +unlock:
> +	spin_unlock(ptl);
> +
> +	if (ret == -ENOENT)
> +		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> +
> +	return ret;
> +#else /* CONFIG_HUGETLB_PAGE */
> +	return -EINVAL;
> +#endif
> +}
> +
>  static void hmm_pfns_clear(struct hmm_range *range,
>  			   uint64_t *pfns,
>  			   unsigned long addr,
> @@ -726,6 +791,7 @@ static void hmm_pfns_special(struct hmm_range *range)
>   * @mm: the mm struct for the range of virtual address
>   * @start: start virtual address (inclusive)
>   * @end: end virtual address (exclusive)
> + * @page_shift: expect page shift for the range
>   * Returns 0 on success, -EFAULT if the address space is no longer valid
>   *
>   * Track updates to the CPU page table see include/linux/hmm.h
> @@ -733,16 +799,23 @@ static void hmm_pfns_special(struct hmm_range *range)
>  int hmm_range_register(struct hmm_range *range,
>  		       struct mm_struct *mm,
>  		       unsigned long start,
> -		       unsigned long end)
> +		       unsigned long end,
> +		       unsigned page_shift)
>  {
> -	range->start = start & PAGE_MASK;
> -	range->end = end & PAGE_MASK;
> +	unsigned long mask = ((1UL << page_shift) - 1UL);
> +
>  	range->valid = false;
>  	range->hmm = NULL;
>  
> -	if (range->start >= range->end)
> +	if ((start & mask) || (end & mask))
> +		return -EINVAL;
> +	if (start >= end)
>  		return -EINVAL;
>  
> +	range->page_shift = page_shift;
> +	range->start = start;
> +	range->end = end;
> +
>  	range->hmm = hmm_register(mm);
>  	if (!range->hmm)
>  		return -EFAULT;
> @@ -809,6 +882,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
>   */
>  long hmm_range_snapshot(struct hmm_range *range)
>  {
> +	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>  	unsigned long start = range->start, end;
>  	struct hmm_vma_walk hmm_vma_walk;
>  	struct hmm *hmm = range->hmm;
> @@ -825,15 +899,26 @@ long hmm_range_snapshot(struct hmm_range *range)
>  			return -EAGAIN;
>  
>  		vma = find_vma(hmm->mm, start);
> -		if (vma == NULL || (vma->vm_flags & VM_SPECIAL))
> +		if (vma == NULL || (vma->vm_flags & device_vma))
>  			return -EFAULT;
>  
> -		/* FIXME support hugetlb fs/dax */
> -		if (is_vm_hugetlb_page(vma) || vma_is_dax(vma)) {
> +		/* FIXME support dax */
> +		if (vma_is_dax(vma)) {
>  			hmm_pfns_special(range);
>  			return -EINVAL;
>  		}
>  
> +		if (is_vm_hugetlb_page(vma)) {
> +			struct hstate *h = hstate_vma(vma);
> +
> +			if (huge_page_shift(h) != range->page_shift &&
> +			    range->page_shift != PAGE_SHIFT)
> +				return -EINVAL;
> +		} else {
> +			if (range->page_shift != PAGE_SHIFT)
> +				return -EINVAL;
> +		}
> +
>  		if (!(vma->vm_flags & VM_READ)) {
>  			/*
>  			 * If vma do not allow read access, then assume that it
> @@ -859,6 +944,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>  		mm_walk.hugetlb_entry = NULL;
>  		mm_walk.pmd_entry = hmm_vma_walk_pmd;
>  		mm_walk.pte_hole = hmm_vma_walk_hole;
> +		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
>  
>  		walk_page_range(start, end, &mm_walk);
>  		start = end;
> @@ -877,7 +963,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
>   *          then one of the following values may be returned:
>   *
>   *           -EINVAL  invalid arguments or mm or virtual address are in an
> - *                    invalid vma (ie either hugetlbfs or device file vma).
> + *                    invalid vma (for instance device file vma).
>   *           -ENOMEM: Out of memory.
>   *           -EPERM:  Invalid permission (for instance asking for write and
>   *                    range is read only).
> @@ -898,6 +984,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
>   */
>  long hmm_range_fault(struct hmm_range *range, bool block)
>  {
> +	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
>  	unsigned long start = range->start, end;
>  	struct hmm_vma_walk hmm_vma_walk;
>  	struct hmm *hmm = range->hmm;
> @@ -917,15 +1004,25 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>  		}
>  
>  		vma = find_vma(hmm->mm, start);
> -		if (vma == NULL || (vma->vm_flags & VM_SPECIAL))
> +		if (vma == NULL || (vma->vm_flags & device_vma))
>  			return -EFAULT;
>  
> -		/* FIXME support hugetlb fs/dax */
> -		if (is_vm_hugetlb_page(vma) || vma_is_dax(vma)) {
> +		/* FIXME support dax */
> +		if (vma_is_dax(vma)) {
>  			hmm_pfns_special(range);
>  			return -EINVAL;
>  		}
>  
> +		if (is_vm_hugetlb_page(vma)) {
> +			if (huge_page_shift(hstate_vma(vma)) !=
> +			    range->page_shift &&
> +			    range->page_shift != PAGE_SHIFT)
> +				return -EINVAL;
> +		} else {
> +			if (range->page_shift != PAGE_SHIFT)
> +				return -EINVAL;
> +		}
> +
>  		if (!(vma->vm_flags & VM_READ)) {
>  			/*
>  			 * If vma do not allow read access, then assume that it
> @@ -952,6 +1049,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>  		mm_walk.hugetlb_entry = NULL;
>  		mm_walk.pmd_entry = hmm_vma_walk_pmd;
>  		mm_walk.pte_hole = hmm_vma_walk_hole;
> +		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
>  
>  		do {
>  			ret = walk_page_range(start, end, &mm_walk);
> -- 
> 2.17.2
> 
