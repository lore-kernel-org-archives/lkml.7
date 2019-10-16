Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D672FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476CE20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392630AbfJPLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfJPLKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 017B810DCC8A;
        Wed, 16 Oct 2019 11:10:45 +0000 (UTC)
Received: from [10.36.118.23] (unknown [10.36.118.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26D916046B;
        Wed, 16 Oct 2019 11:10:41 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        linux-kernel@vger.kernel.org
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <c7ac9f99-a34f-c553-b216-b847d093cae9@redhat.com>
 <20191016085123.GO317@dhcp22.suse.cz>
 <679b5c66-8f1b-ec4d-64dd-13fbc440917d@redhat.com>
 <20191016110831.GV317@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eb2406d5-1327-1365-be0e-ee319ab92088@redhat.com>
Date:   Wed, 16 Oct 2019 13:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016110831.GV317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Wed, 16 Oct 2019 11:10:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 13:08, Michal Hocko wrote:
> On Wed 16-10-19 10:56:16, David Hildenbrand wrote:
>> On 16.10.19 10:51, Michal Hocko wrote:
>>> On Wed 16-10-19 10:08:21, David Hildenbrand wrote:
>>>> On 16.10.19 09:34, Anshuman Khandual wrote:
>>> [...]
>>>>> +static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>>>>> +				   unsigned long nr_pages)
>>>>> +{
>>>>> +	unsigned long i, end_pfn = start_pfn + nr_pages;
>>>>> +	struct page *page;
>>>>> +
>>>>> +	for (i = start_pfn; i < end_pfn; i++) {
>>>>> +		page = pfn_to_online_page(i);
>>>>> +		if (!page)
>>>>> +			return false;
>>>>> +
>>>>> +		if (page_zone(page) != z)
>>>>> +			return false;
>>>>> +
>>>>> +		if (PageReserved(page))
>>>>> +			return false;
>>>>> +
>>>>> +		if (page_count(page) > 0)
>>>>> +			return false;
>>>>> +
>>>>> +		if (PageHuge(page))
>>>>> +			return false;
>>>>> +	}
>>>>
>>>> We might still try to allocate a lot of ranges that contain unmovable data
>>>> (we could avoid isolating a lot of page blocks in the first place). I'd love
>>>> to see something like pfn_range_movable() (similar, but different to
>>>> is_mem_section_removable(), which uses has_unmovable_pages()).
>>>
>>> Just to make sure I understand. Do you want has_unmovable_pages to be
>>> called inside pfn_range_valid_contig?
>>
>> I think this requires more thought, as has_unmovable_pages() works on
>> pageblocks only AFAIK. If you try to allocate < MAX_ORDER - 1, you could get
>> a lot of false positives.
>>
>> E.g., if a free "MAX_ORDER - 1" page spans two pageblocks and you only test
>> the second pageblock, you might detect "unmovable" if not taking proper care
>> of the "bigger" free page. (alloc_contig_range() properly works around that
>> issue)
> 
> OK, I see your point. You are right that false positives are possible. I
> would deal with those in a separate patch though.
> 
>>> [...]
>>>>> +struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>>>>> +				int nid, nodemask_t *nodemask)
>>>>> +{
>>>>> +	unsigned long ret, pfn, flags;
>>>>> +	struct zonelist *zonelist;
>>>>> +	struct zone *zone;
>>>>> +	struct zoneref *z;
>>>>> +
>>>>> +	zonelist = node_zonelist(nid, gfp_mask);
>>>>> +	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>>>>> +					gfp_zone(gfp_mask), nodemask) {
>>>>
>>>> One important part is to never use the MOVABLE zone here (otherwise
>>>> unmovable data would end up on the movable zone). But I guess the caller is
>>>> responsible for that (not pass GFP_MOVABLE) like gigantic pages do.
>>>
>>> Well, if the caller uses GFP_MOVABLE then the movability should be
>>> implemented in some form. If that is not the case then it is a bug on
>>> the caller behalf.
>>>
>>>>> +		spin_lock_irqsave(&zone->lock, flags);
>>>>> +
>>>>> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
>>>>
>>>> This alignment does not make too much sense when allowing passing in !power
>>>> of two orders. Maybe the caller should specify the requested alignment
>>>> instead? Or should we enforce this to be aligned to make our life easier for
>>>> now?
>>>
>>> Are there any usecases that would require than the page alignment?
>>
>> Gigantic pages have to be aligned AFAIK.
> 
> Aligned to what? I do not see any guarantee like that in the existing
> code.
> 

pfn = ALIGN(zone->zone_start_pfn, nr_pages);

-- 

Thanks,

David / dhildenb
