Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6274CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36671218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfB1V4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:56:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfB1V4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:56:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04C3AADD6;
        Thu, 28 Feb 2019 21:56:47 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
 <44ffadb4-4235-76c9-332f-680dda5da521@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <67a79bb9-12b5-e668-abb1-ef91a9cbfea8@suse.cz>
Date:   Thu, 28 Feb 2019 22:56:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <44ffadb4-4235-76c9-332f-680dda5da521@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2019 10:44 PM, John Hubbard wrote:
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

In that case it should now be named node_lru_lock(). zone_lru_lock() was a
wrapper introduced to make the conversion of per-zone to per-node lru_lock smoother.

> +{
> +       return &pgdat->lru_lock;
> +}
> +
> +static inline spinlock_t *zone_lru_lock_from_page(struct page *page)

Ditto. Or maybe even page_node_lru_lock()?

> +{
> +       return zone_lru_lock(page_pgdat(page));
> +}
> +
>  #ifdef SECTION_IN_PAGE_FLAGS
>  static inline void set_page_section(struct page *page, unsigned long section)
>  {
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 842f9189537b..e03042fe1d88 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -728,11 +728,6 @@ typedef struct pglist_data {
>  
>  #define node_start_pfn(nid)    (NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
> -static inline spinlock_t *zone_lru_lock(struct zone *zone)
> -{
> -       return &zone->zone_pgdat->lru_lock;
> -}
> -
>  static inline struct lruvec *node_lruvec(struct pglist_data *pgdat)
>  {
>         return &pgdat->lruvec;
> 
> 
> 
> Like it?
> 
> thanks,
> 

