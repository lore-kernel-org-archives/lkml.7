Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB85C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9A821E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfHGKEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:04:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbfHGKEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:04:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D95DAD20;
        Wed,  7 Aug 2019 10:04:44 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: remove unnecessary zone parameter in
 isolate_migratepages()
To:     Pengfei Li <lpf.vector@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, cai@lca.pw, aryabinin@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190806151616.21107-1-lpf.vector@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5d07663b-3915-b6a4-4886-fc78dc3ef209@suse.cz>
Date:   Wed, 7 Aug 2019 12:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806151616.21107-1-lpf.vector@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 5:16 PM, Pengfei Li wrote:
> Like commit 40cacbcb3240 ("mm, compaction: remove unnecessary zone
> parameter in some instances"), remove unnecessary zone parameter.
> 
> No functional change.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 952dc2fb24e5..685c3e3d0a0f 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1737,8 +1737,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>   * starting at the block pointed to by the migrate scanner pfn within
>   * compact_control.
>   */
> -static isolate_migrate_t isolate_migratepages(struct zone *zone,
> -					struct compact_control *cc)
> +static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>  {
>  	unsigned long block_start_pfn;
>  	unsigned long block_end_pfn;
> @@ -1756,8 +1755,8 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  	 */
>  	low_pfn = fast_find_migrateblock(cc);
>  	block_start_pfn = pageblock_start_pfn(low_pfn);
> -	if (block_start_pfn < zone->zone_start_pfn)
> -		block_start_pfn = zone->zone_start_pfn;
> +	if (block_start_pfn < cc->zone->zone_start_pfn)
> +		block_start_pfn = cc->zone->zone_start_pfn;
>  
>  	/*
>  	 * fast_find_migrateblock marks a pageblock skipped so to avoid
> @@ -1787,8 +1786,8 @@ static isolate_migrate_t isolate_migratepages(struct zone *zone,
>  		if (!(low_pfn % (SWAP_CLUSTER_MAX * pageblock_nr_pages)))
>  			cond_resched();
>  
> -		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
> -									zone);
> +		page = pageblock_pfn_to_page(block_start_pfn,
> +						block_end_pfn, cc->zone);
>  		if (!page)
>  			continue;
>  
> @@ -2158,7 +2157,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			cc->rescan = true;
>  		}
>  
> -		switch (isolate_migratepages(cc->zone, cc)) {
> +		switch (isolate_migratepages(cc)) {
>  		case ISOLATE_ABORT:
>  			ret = COMPACT_CONTENDED;
>  			putback_movable_pages(&cc->migratepages);
> 

