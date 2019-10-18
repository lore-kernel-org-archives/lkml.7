Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DCDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B400E21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442125AbfJRFzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:55:49 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55352 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfJRFzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:55:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD25328;
        Thu, 17 Oct 2019 20:28:03 -0700 (PDT)
Received: from [10.162.40.145] (p8cg001049571a15.blr.arm.com [10.162.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10FA83F6C4;
        Thu, 17 Oct 2019 20:27:57 -0700 (PDT)
Subject: Re: [PATCH V3] mm/page_alloc: Add alloc_contig_pages()
To:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1571300646-32240-1-git-send-email-anshuman.khandual@arm.com>
 <d0b4a92b-825f-7b2f-4624-c76f218f064e@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1b173827-b08c-b294-bf86-22228bdfd542@arm.com>
Date:   Fri, 18 Oct 2019 08:58:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d0b4a92b-825f-7b2f-4624-c76f218f064e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2019 02:44 AM, John Hubbard wrote:
> On 10/17/19 1:24 AM, Anshuman Khandual wrote:
>> HugeTLB helper alloc_gigantic_page() implements fairly generic allocation
>> method where it scans over various zones looking for a large contiguous pfn
>> range before trying to allocate it with alloc_contig_range(). Other than
>> deriving the requested order from 'struct hstate', there is nothing HugeTLB
>> specific in there. This can be made available for general use to allocate
>> contiguous memory which could not have been allocated through the buddy
>> allocator.
>>
>> alloc_gigantic_page() has been split carving out actual allocation method
>> which is then made available via new alloc_contig_pages() helper wrapped
>> under CONFIG_CONTIG_ALLOC. All references to 'gigantic' have been replaced
>> with more generic term 'contig'. Allocated pages here should be freed with
>> free_contig_range() or by calling __free_page() on each allocated page.
>>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This is based on https://patchwork.kernel.org/patch/11190213/
> 
> Hi Anshuman,
> 
> I'm having trouble finding a tree that this applies cleanly too,
> which one did you use? (latest linux-next, or linux.git would be
> nice).

Hello John,

Yeah, it is bit non-trivial because v5 of the pgtable tests are still
on the latest linux-next (20191015 or 20191017). You will need to
revert the following patches.

1. mm/hugetlb: make alloc_gigantic_page() available for general use
2. mm/debug: add tests validating architecture page table helpers
3. mm-debug-add-tests-validating-architecture-page-table-helpers-fix

and apply the following patch (https://patchwork.kernel.org/patch/11190213/)

1. hugetlbfs: don't access uninitialized memmaps in pfn_range_valid_gigantic()

After which this particular patch here will apply cleanly. Hope this helps.

- Anshuman
> 
> 
> thanks,
> 
> John Hubbard
> NVIDIA
> 
> 
>>
>> Changes in V3:
>>
>> - Added an in-code comment per Michal and David
>>
>> Changes in V2:
>>
>> - Rephrased patch subject per David
>> - Fixed all typos per David
>> - s/order/contiguous
>>
>> Changes from [V5,1/2] mm/hugetlb: Make alloc_gigantic_page()...
>>
>> - alloc_contig_page() takes nr_pages instead of order per Michal
>> - s/gigantic/contig on all related functions
>>
>>  include/linux/gfp.h |   2 +
>>  mm/hugetlb.c        |  77 +--------------------------------
>>  mm/page_alloc.c     | 101 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 105 insertions(+), 75 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index fb07b503dc45..1a11d4857027 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -589,6 +589,8 @@ static inline bool pm_suspended_storage(void)
>>  /* The below functions must be run on a range from a single zone. */
>>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>>  			      unsigned migratetype, gfp_t gfp_mask);
>> +extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>> +				       int nid, nodemask_t *nodemask);
>>  #endif
>>  void free_contig_range(unsigned long pfn, unsigned int nr_pages);
>>  
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 985ee15eb04b..a5c2c880af27 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1023,85 +1023,12 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>>  }
>>  
>>  #ifdef CONFIG_CONTIG_ALLOC
>> -static int __alloc_gigantic_page(unsigned long start_pfn,
>> -				unsigned long nr_pages, gfp_t gfp_mask)
>> -{
>> -	unsigned long end_pfn = start_pfn + nr_pages;
>> -	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
>> -				  gfp_mask);
>> -}
>> -
>> -static bool pfn_range_valid_gigantic(struct zone *z,
>> -			unsigned long start_pfn, unsigned long nr_pages)
>> -{
>> -	unsigned long i, end_pfn = start_pfn + nr_pages;
>> -	struct page *page;
>> -
>> -	for (i = start_pfn; i < end_pfn; i++) {
>> -		page = pfn_to_online_page(i);
>> -		if (!page)
>> -			return false;
>> -
>> -		if (page_zone(page) != z)
>> -			return false;
>> -
>> -		if (PageReserved(page))
>> -			return false;
>> -
>> -		if (page_count(page) > 0)
>> -			return false;
>> -
>> -		if (PageHuge(page))
>> -			return false;
>> -	}
>> -
>> -	return true;
>> -}
>> -
>> -static bool zone_spans_last_pfn(const struct zone *zone,
>> -			unsigned long start_pfn, unsigned long nr_pages)
>> -{
>> -	unsigned long last_pfn = start_pfn + nr_pages - 1;
>> -	return zone_spans_pfn(zone, last_pfn);
>> -}
>> -
>>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>  		int nid, nodemask_t *nodemask)
>>  {
>> -	unsigned int order = huge_page_order(h);
>> -	unsigned long nr_pages = 1 << order;
>> -	unsigned long ret, pfn, flags;
>> -	struct zonelist *zonelist;
>> -	struct zone *zone;
>> -	struct zoneref *z;
>> -
>> -	zonelist = node_zonelist(nid, gfp_mask);
>> -	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nodemask) {
>> -		spin_lock_irqsave(&zone->lock, flags);
>> +	unsigned long nr_pages = 1UL << huge_page_order(h);
>>  
>> -		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>> -		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
>> -			if (pfn_range_valid_gigantic(zone, pfn, nr_pages)) {
>> -				/*
>> -				 * We release the zone lock here because
>> -				 * alloc_contig_range() will also lock the zone
>> -				 * at some point. If there's an allocation
>> -				 * spinning on this lock, it may win the race
>> -				 * and cause alloc_contig_range() to fail...
>> -				 */
>> -				spin_unlock_irqrestore(&zone->lock, flags);
>> -				ret = __alloc_gigantic_page(pfn, nr_pages, gfp_mask);
>> -				if (!ret)
>> -					return pfn_to_page(pfn);
>> -				spin_lock_irqsave(&zone->lock, flags);
>> -			}
>> -			pfn += nr_pages;
>> -		}
>> -
>> -		spin_unlock_irqrestore(&zone->lock, flags);
>> -	}
>> -
>> -	return NULL;
>> +	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
>>  }
>>  
>>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cd1dd0712624..fe76be55c9d5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8499,6 +8499,107 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  				pfn_max_align_up(end), migratetype);
>>  	return ret;
>>  }
>> +
>> +static int __alloc_contig_pages(unsigned long start_pfn,
>> +				unsigned long nr_pages, gfp_t gfp_mask)
>> +{
>> +	unsigned long end_pfn = start_pfn + nr_pages;
>> +
>> +	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
>> +				  gfp_mask);
>> +}
>> +
>> +static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>> +				   unsigned long nr_pages)
>> +{
>> +	unsigned long i, end_pfn = start_pfn + nr_pages;
>> +	struct page *page;
>> +
>> +	for (i = start_pfn; i < end_pfn; i++) {
>> +		page = pfn_to_online_page(i);
>> +		if (!page)
>> +			return false;
>> +
>> +		if (page_zone(page) != z)
>> +			return false;
>> +
>> +		if (PageReserved(page))
>> +			return false;
>> +
>> +		if (page_count(page) > 0)
>> +			return false;
>> +
>> +		if (PageHuge(page))
>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static bool zone_spans_last_pfn(const struct zone *zone,
>> +				unsigned long start_pfn, unsigned long nr_pages)
>> +{
>> +	unsigned long last_pfn = start_pfn + nr_pages - 1;
>> +
>> +	return zone_spans_pfn(zone, last_pfn);
>> +}
>> +
>> +/**
>> + * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
>> + * @nr_pages:	Number of contiguous pages to allocate
>> + * @gfp_mask:	GFP mask to limit search and used during compaction
>> + * @nid:	Target node
>> + * @nodemask:	Mask for other possible nodes
>> + *
>> + * This routine is a wrapper around alloc_contig_range(). It scans over zones
>> + * on an applicable zonelist to find a contiguous pfn range which can then be
>> + * tried for allocation with alloc_contig_range(). This routine is intended
>> + * for allocation requests which can not be fulfilled with the buddy allocator.
>> + *
>> + * The allocated memory is always aligned to a page boundary. If nr_pages is a
>> + * power of two then the alignment is guaranteed to be to the given nr_pages
>> + * (e.g. 1GB request would be aligned to 1GB).
>> + *
>> + * Allocated pages can be freed with free_contig_range() or by manually calling
>> + * __free_page() on each allocated page.
>> + *
>> + * Return: pointer to contiguous pages on success, or NULL if not successful.
>> + */
>> +struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>> +				int nid, nodemask_t *nodemask)
>> +{
>> +	unsigned long ret, pfn, flags;
>> +	struct zonelist *zonelist;
>> +	struct zone *zone;
>> +	struct zoneref *z;
>> +
>> +	zonelist = node_zonelist(nid, gfp_mask);
>> +	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>> +					gfp_zone(gfp_mask), nodemask) {
>> +		spin_lock_irqsave(&zone->lock, flags);
>> +
>> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>> +		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
>> +			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
>> +				/*
>> +				 * We release the zone lock here because
>> +				 * alloc_contig_range() will also lock the zone
>> +				 * at some point. If there's an allocation
>> +				 * spinning on this lock, it may win the race
>> +				 * and cause alloc_contig_range() to fail...
>> +				 */
>> +				spin_unlock_irqrestore(&zone->lock, flags);
>> +				ret = __alloc_contig_pages(pfn, nr_pages,
>> +							gfp_mask);
>> +				if (!ret)
>> +					return pfn_to_page(pfn);
>> +				spin_lock_irqsave(&zone->lock, flags);
>> +			}
>> +			pfn += nr_pages;
>> +		}
>> +		spin_unlock_irqrestore(&zone->lock, flags);
>> +	}
>> +	return NULL;
>> +}
>>  #endif /* CONFIG_CONTIG_ALLOC */
>>  
>>  void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>>
> 
