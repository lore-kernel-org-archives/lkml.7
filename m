Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27AC2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfCAKvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:41386 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfCAKu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:50:59 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gzfkk-00048B-Hz; Fri, 01 Mar 2019 13:50:54 +0300
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
 <44ffadb4-4235-76c9-332f-680dda5da521@nvidia.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <186bf66b-fec5-a614-3ffd-64b8d7660fe5@virtuozzo.com>
Date:   Fri, 1 Mar 2019 13:51:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <44ffadb4-4235-76c9-332f-680dda5da521@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/19 12:44 AM, John Hubbard wrote:
> On 2/28/19 12:33 AM, Andrey Ryabinin wrote:
>> We have common pattern to access lru_lock from a page pointer:
>> 	zone_lru_lock(page_zone(page))
>>
>> Which is silly, because it unfolds to this:
>> 	&NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)]->zone_pgdat->lru_lock
>> while we can simply do
>> 	&NODE_DATA(page_to_nid(page))->lru_lock
>>
> 
> Hi Andrey,
> 
> Nice. I like it so much that I immediately want to tweak it. :)
> 
> 
>> Remove zone_lru_lock() function, since it's only complicate things.
>> Use 'page_pgdat(page)->lru_lock' pattern instead.
> 
> Here, I think the zone_lru_lock() is actually a nice way to add
> a touch of clarity at the call sites. How about, see below:
> 
> [snip]
> 
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 2fd4247262e9..22423763c0bd 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -788,10 +788,6 @@ typedef struct pglist_data {
>>  
>>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
>> -static inline spinlock_t *zone_lru_lock(struct zone *zone)
>> -{
>> -	return &zone->zone_pgdat->lru_lock;
>> -}
>>  
> 
> Instead of removing that function, let's change it, and add another
> (since you have two cases: either a page* or a pgdat* is available),
> and move it to where it can compile, like this:
> 
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80bb6408fe73..cea3437f5d68 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1167,6 +1167,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
>         return NODE_DATA(page_to_nid(page));
>  }
>  
> +static inline spinlock_t *zone_lru_lock(pg_data_t *pgdat)
> +{
> +       return &pgdat->lru_lock;
> +}
> +


I don't think wrapper for a simple plain access to the struct member is reasonable.
Besides, there are plenty of "spin_lock(&pgdat->lru_lock)" even without this patch,
so for consistency reasons &pgdat->lru_lock seems like a better choice to me.

Also "&pgdat->lru_lock" is just shorter than:
      "node_lru_lock(pgdat)"



> +static inline spinlock_t *zone_lru_lock_from_page(struct page *page)
> +{
> +       return zone_lru_lock(page_pgdat(page));
> +}
> +

I don't think such function would find any use. Usually lru_lock is taken
to perform some manipulations with page *and* pgdat, thus it's better to remember
page_pgdat(page) in local variable.
