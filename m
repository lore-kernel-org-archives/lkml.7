Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B0FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150F20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392440AbfJPK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:28:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:28:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58FAE28;
        Wed, 16 Oct 2019 03:28:12 -0700 (PDT)
Received: from [10.163.1.216] (unknown [10.163.1.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7414F3F6C4;
        Wed, 16 Oct 2019 03:28:06 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <20191016085839.GP317@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
Date:   Wed, 16 Oct 2019 15:58:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191016085839.GP317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 02:28 PM, Michal Hocko wrote:
> On Wed 16-10-19 13:04:53, Anshuman Khandual wrote:
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
> 
> Do we want to export this to modules? Apart from mostly styling issues
> pointed by David this looks fine.
> 
> I do agree that a general allocator api belongs to page_alloc.c rather
> than force people to invent their own and broken instances.
>  
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
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> After other issues mentioned by David get resolved you can add

Just to confirm. Only the styling issues, right ? pfn_range_valid_contig(),
pfn alignment and zone scanning all remain the same like before ?

> Acked-by: Michal Hocko <mhocko@suse.com>
> 
>> ---
>> This is based on https://patchwork.kernel.org/patch/11190213/
>>
>> Changes from [V5,1/2] mm/hugetlb: Make alloc_gigantic_page()...
>>
>> - alloc_contig_page() takes nr_pages instead of order per Michal
>> - s/gigantic/contig on all related functions
>>
>>  include/linux/gfp.h |  2 +
>>  mm/hugetlb.c        | 77 +----------------------------------
>>  mm/page_alloc.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 101 insertions(+), 75 deletions(-)
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
>> index cd1dd0712624..1e084d6acf2f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8499,6 +8499,103 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
>> + * This routine is an wrapper around alloc_contig_range(). It scans over zones
>> + * on an applicable zonelist to find a contiguous pfn range which can then be
>> + * tried for allocation with alloc_contig_range(). This routine is intended
>> + * for allocation requests which can not be fulfilled with buddy allocator.
>> + *
>> + * Allocated pages can be freed with free_contig_range() or by manually calling
>> + * __free_page() on each allocated page.
>> + *
>> + * Return: pointer to 'order' pages on success, or NULL if not successful.
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
>> -- 
>> 2.20.1
> 
