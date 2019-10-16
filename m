Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB7C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0012221835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391629AbfJPIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389897AbfJPIkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1AEA2CE905;
        Wed, 16 Oct 2019 08:40:15 +0000 (UTC)
Received: from [10.36.117.237] (ovpn-117-237.ams2.redhat.com [10.36.117.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B85235D6A9;
        Wed, 16 Oct 2019 08:40:12 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
From:   David Hildenbrand <david@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
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
        linux-kernel@vger.kernel.org
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a811effb-4ab8-7cb0-aee7-c047d06129bc@redhat.com>
Date:   Wed, 16 Oct 2019 10:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Oct 2019 08:40:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 10:08, David Hildenbrand wrote:
> On 16.10.19 09:34, Anshuman Khandual wrote:
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
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This is based on https://patchwork.kernel.org/patch/11190213/
>>
>> Changes from [V5,1/2] mm/hugetlb: Make alloc_gigantic_page()...
>>
>> - alloc_contig_page() takes nr_pages instead of order per Michal
>> - s/gigantic/contig on all related functions
>>
>>    include/linux/gfp.h |  2 +
>>    mm/hugetlb.c        | 77 +----------------------------------
>>    mm/page_alloc.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>>    3 files changed, 101 insertions(+), 75 deletions(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index fb07b503dc45..1a11d4857027 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -589,6 +589,8 @@ static inline bool pm_suspended_storage(void)
>>    /* The below functions must be run on a range from a single zone. */
>>    extern int alloc_contig_range(unsigned long start, unsigned long end,
>>    			      unsigned migratetype, gfp_t gfp_mask);
>> +extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>> +				       int nid, nodemask_t *nodemask);
>>    #endif
>>    void free_contig_range(unsigned long pfn, unsigned int nr_pages);
>>    
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 985ee15eb04b..a5c2c880af27 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1023,85 +1023,12 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>>    }
>>    
>>    #ifdef CONFIG_CONTIG_ALLOC
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
>>    static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>>    		int nid, nodemask_t *nodemask)
>>    {
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
>>    }
>>    
>>    static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cd1dd0712624..1e084d6acf2f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8499,6 +8499,103 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>    				pfn_max_align_up(end), migratetype);
>>    	return ret;
>>    }
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
> 
> We might still try to allocate a lot of ranges that contain unmovable
> data (we could avoid isolating a lot of page blocks in the first place).
> I'd love to see something like pfn_range_movable() (similar, but
> different to is_mem_section_removable(), which uses has_unmovable_pages()).
> 
> Especially, I want something like that for virtio-mem, which also uses
> alloc_contig_range/free_contig_range, to perform a fast test if a range
> makes sense to try with alloc_contig_range().
> 
> https://lkml.org/lkml/2019/9/19/463
> 
> 
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
> 
> "a" wrapper
> 
>> + * on an applicable zonelist to find a contiguous pfn range which can then be
>> + * tried for allocation with alloc_contig_range(). This routine is intended
>> + * for allocation requests which can not be fulfilled with buddy allocator.
> 
> "the" buddy allocator.
> 
>> + *
>> + * Allocated pages can be freed with free_contig_range() or by manually calling
>> + * __free_page() on each allocated page.
>> + *
>> + * Return: pointer to 'order' pages on success, or NULL if not successful.
> 
> order?
> 
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
> 
> One important part is to never use the MOVABLE zone here (otherwise
> unmovable data would end up on the movable zone). But I guess the caller
> is responsible for that (not pass GFP_MOVABLE) like gigantic pages do.
> 
>> +		spin_lock_irqsave(&zone->lock, flags);
>> +
>> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> 
> This alignment does not make too much sense when allowing passing in
> !power of two orders. Maybe the caller should specify the requested
> alignment instead? Or should we enforce this to be aligned to make our
> life easier for now?
> 
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
> 
> Now, that's interesting. When you relax the alignment restriction,
> skipping over the whole range is no longer such a good idea (imagine
> only the first PFN not being movable).
> 
>> +		}
>> +		spin_unlock_irqrestore(&zone->lock, flags);
>> +	}
>> +	return NULL;
>> +}
>>    #endif /* CONFIG_CONTIG_ALLOC */
>>    
>>    void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>>
> 
> 

FWIW, the patch subject needs a rework, too.

-- 

Thanks,

David / dhildenb
