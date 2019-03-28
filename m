Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0669218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfC2ANb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:44538 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbfC2ANa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 17:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="311314120"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2019 17:13:28 -0700
Date:   Thu, 28 Mar 2019 09:12:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 06/11] mm/hmm: improve driver API to work and wait
 over a range v2
Message-ID: <20190328161221.GE31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-7-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325144011.10560-7-jglisse@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:40:06AM -0400, Jerome Glisse wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> A common use case for HMM mirror is user trying to mirror a range
> and before they could program the hardware it get invalidated by
> some core mm event. Instead of having user re-try right away to
> mirror the range provide a completion mechanism for them to wait
> for any active invalidation affecting the range.
> 
> This also changes how hmm_range_snapshot() and hmm_range_fault()
> works by not relying on vma so that we can drop the mmap_sem
> when waiting and lookup the vma again on retry.
> 
> Changes since v1:
>     - squashed: Dan Carpenter: potential deadlock in nonblocking code
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/hmm.h | 208 ++++++++++++++---
>  mm/hmm.c            | 528 +++++++++++++++++++++-----------------------
>  2 files changed, 428 insertions(+), 308 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index e9afd23c2eac..79671036cb5f 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -77,8 +77,34 @@
>  #include <linux/migrate.h>
>  #include <linux/memremap.h>
>  #include <linux/completion.h>
> +#include <linux/mmu_notifier.h>
>  
> -struct hmm;
> +
> +/*
> + * struct hmm - HMM per mm struct
> + *
> + * @mm: mm struct this HMM struct is bound to
> + * @lock: lock protecting ranges list
> + * @ranges: list of range being snapshotted
> + * @mirrors: list of mirrors for this mm
> + * @mmu_notifier: mmu notifier to track updates to CPU page table
> + * @mirrors_sem: read/write semaphore protecting the mirrors list
> + * @wq: wait queue for user waiting on a range invalidation
> + * @notifiers: count of active mmu notifiers
> + * @dead: is the mm dead ?
> + */
> +struct hmm {
> +	struct mm_struct	*mm;
> +	struct kref		kref;
> +	struct mutex		lock;
> +	struct list_head	ranges;
> +	struct list_head	mirrors;
> +	struct mmu_notifier	mmu_notifier;
> +	struct rw_semaphore	mirrors_sem;
> +	wait_queue_head_t	wq;
> +	long			notifiers;
> +	bool			dead;
> +};
>  
>  /*
>   * hmm_pfn_flag_e - HMM flag enums
> @@ -155,6 +181,38 @@ struct hmm_range {
>  	bool			valid;
>  };
>  
> +/*
> + * hmm_range_wait_until_valid() - wait for range to be valid
> + * @range: range affected by invalidation to wait on
> + * @timeout: time out for wait in ms (ie abort wait after that period of time)
> + * Returns: true if the range is valid, false otherwise.
> + */
> +static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
> +					      unsigned long timeout)
> +{
> +	/* Check if mm is dead ? */
> +	if (range->hmm == NULL || range->hmm->dead || range->hmm->mm == NULL) {
> +		range->valid = false;
> +		return false;
> +	}
> +	if (range->valid)
> +		return true;
> +	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
> +			   msecs_to_jiffies(timeout));
> +	/* Return current valid status just in case we get lucky */
> +	return range->valid;
> +}
> +
> +/*
> + * hmm_range_valid() - test if a range is valid or not
> + * @range: range
> + * Returns: true if the range is valid, false otherwise.
> + */
> +static inline bool hmm_range_valid(struct hmm_range *range)
> +{
> +	return range->valid;
> +}
> +
>  /*
>   * hmm_pfn_to_page() - return struct page pointed to by a valid HMM pfn
>   * @range: range use to decode HMM pfn value
> @@ -357,51 +415,133 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
>  
>  
>  /*
> - * To snapshot the CPU page table, call hmm_vma_get_pfns(), then take a device
> - * driver lock that serializes device page table updates, then call
> - * hmm_vma_range_done(), to check if the snapshot is still valid. The same
> - * device driver page table update lock must also be used in the
> - * hmm_mirror_ops.sync_cpu_device_pagetables() callback, so that CPU page
> - * table invalidation serializes on it.
> + * To snapshot the CPU page table you first have to call hmm_range_register()
> + * to register the range. If hmm_range_register() return an error then some-
> + * thing is horribly wrong and you should fail loudly. If it returned true then
> + * you can wait for the range to be stable with hmm_range_wait_until_valid()
> + * function, a range is valid when there are no concurrent changes to the CPU
> + * page table for the range.
> + *
> + * Once the range is valid you can call hmm_range_snapshot() if that returns
> + * without error then you can take your device page table lock (the same lock
> + * you use in the HMM mirror sync_cpu_device_pagetables() callback). After
> + * taking that lock you have to check the range validity, if it is still valid
> + * (ie hmm_range_valid() returns true) then you can program the device page
> + * table, otherwise you have to start again. Pseudo code:
> + *
> + *      mydevice_prefault(mydevice, mm, start, end)
> + *      {
> + *          struct hmm_range range;
> + *          ...
>   *
> - * YOU MUST CALL hmm_vma_range_done() ONCE AND ONLY ONCE EACH TIME YOU CALL
> - * hmm_range_snapshot() WITHOUT ERROR !
> + *          ret = hmm_range_register(&range, mm, start, end);
> + *          if (ret)
> + *              return ret;
>   *
> - * IF YOU DO NOT FOLLOW THE ABOVE RULE THE SNAPSHOT CONTENT MIGHT BE INVALID !
> - */
> -long hmm_range_snapshot(struct hmm_range *range);
> -bool hmm_vma_range_done(struct hmm_range *range);
> -
> -
> -/*
> - * Fault memory on behalf of device driver. Unlike handle_mm_fault(), this will
> - * not migrate any device memory back to system memory. The HMM pfn array will
> - * be updated with the fault result and current snapshot of the CPU page table
> - * for the range.
> + *          down_read(mm->mmap_sem);
> + *      again:
> + *
> + *          if (!hmm_range_wait_until_valid(&range, TIMEOUT)) {
> + *              up_read(&mm->mmap_sem);
> + *              hmm_range_unregister(range);
> + *              // Handle time out, either sleep or retry or something else
> + *              ...
> + *              return -ESOMETHING; || goto again;
> + *          }
> + *
> + *          ret = hmm_range_snapshot(&range); or hmm_range_fault(&range);
> + *          if (ret == -EAGAIN) {
> + *              down_read(mm->mmap_sem);
> + *              goto again;
> + *          } else if (ret == -EBUSY) {
> + *              goto again;
> + *          }
> + *
> + *          up_read(&mm->mmap_sem);
> + *          if (ret) {
> + *              hmm_range_unregister(range);
> + *              return ret;
> + *          }
> + *
> + *          // It might not have snap-shoted the whole range but only the first
> + *          // npages, the return values is the number of valid pages from the
> + *          // start of the range.
> + *          npages = ret;
>   *
> - * The mmap_sem must be taken in read mode before entering and it might be
> - * dropped by the function if the block argument is false. In that case, the
> - * function returns -EAGAIN.
> + *          ...
>   *
> - * Return value does not reflect if the fault was successful for every single
> - * address or not. Therefore, the caller must to inspect the HMM pfn array to
> - * determine fault status for each address.
> + *          mydevice_page_table_lock(mydevice);
> + *          if (!hmm_range_valid(range)) {
> + *              mydevice_page_table_unlock(mydevice);
> + *              goto again;
> + *          }
>   *
> - * Trying to fault inside an invalid vma will result in -EINVAL.
> + *          mydevice_populate_page_table(mydevice, range, npages);
> + *          ...
> + *          mydevice_take_page_table_unlock(mydevice);
> + *          hmm_range_unregister(range);
>   *
> - * See the function description in mm/hmm.c for further documentation.
> + *          return 0;
> + *      }
> + *
> + * The same scheme apply to hmm_range_fault() (ie replace hmm_range_snapshot()
> + * with hmm_range_fault() in above pseudo code).
> + *
> + * YOU MUST CALL hmm_range_unregister() ONCE AND ONLY ONCE EACH TIME YOU CALL
> + * hmm_range_register() AND hmm_range_register() RETURNED TRUE ! IF YOU DO NOT
> + * FOLLOW THIS RULE MEMORY CORRUPTION WILL ENSUE !
>   */
> +int hmm_range_register(struct hmm_range *range,
> +		       struct mm_struct *mm,
> +		       unsigned long start,
> +		       unsigned long end);
> +void hmm_range_unregister(struct hmm_range *range);

The above comment is great!  But I think you also need to update
Documentation/vm/hmm.rst:hmm_range_snapshot() to show the use of
hmm_range_[un]register()

> +long hmm_range_snapshot(struct hmm_range *range);
>  long hmm_range_fault(struct hmm_range *range, bool block);
>  
> +/*
> + * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
> + *
> + * When waiting for mmu notifiers we need some kind of time out otherwise we
> + * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
> + * wait already.
> + */
> +#define HMM_RANGE_DEFAULT_TIMEOUT 1000
> +
>  /* This is a temporary helper to avoid merge conflict between trees. */
> +static inline bool hmm_vma_range_done(struct hmm_range *range)
> +{
> +	bool ret = hmm_range_valid(range);
> +
> +	hmm_range_unregister(range);
> +	return ret;
> +}
> +
>  static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>  {
> -	long ret = hmm_range_fault(range, block);
> -	if (ret == -EBUSY)
> -		ret = -EAGAIN;
> -	else if (ret == -EAGAIN)
> -		ret = -EBUSY;
> -	return ret < 0 ? ret : 0;
> +	long ret;
> +
> +	ret = hmm_range_register(range, range->vma->vm_mm,
> +				 range->start, range->end);
> +	if (ret)
> +		return (int)ret;
> +
> +	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> +		up_read(&range->vma->vm_mm->mmap_sem);
> +		return -EAGAIN;
> +	}
> +
> +	ret = hmm_range_fault(range, block);
> +	if (ret <= 0) {
> +		if (ret == -EBUSY || !ret) {
> +			up_read(&range->vma->vm_mm->mmap_sem);
> +			ret = -EBUSY;
> +		} else if (ret == -EAGAIN)
> +			ret = -EBUSY;
> +		hmm_range_unregister(range);
> +		return ret;
> +	}
> +	return 0;

Is hmm_vma_fault() also temporary to keep the nouveau driver working?  It looks
like it to me.

This and hmm_vma_range_done() above are part of the old interface which is in
the Documentation correct?  As stated above we should probably change that
documentation with this patch to ensure no new users of these 2 functions
appear.

Ira

