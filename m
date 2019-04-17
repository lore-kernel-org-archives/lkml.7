Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF23C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96597206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfDQOHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:07:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729395AbfDQOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:07:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B2E1B17E;
        Wed, 17 Apr 2019 14:07:02 +0000 (UTC)
Message-ID: <1555510005.3139.36.camel@suse.de>
Subject: Re: [PATCH v4] mm/hotplug: treat CMA pages as unmovable
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Date:   Wed, 17 Apr 2019 16:06:45 +0200
In-Reply-To: <20190416170510.20048-1-cai@lca.pw>
References: <20190416170510.20048-1-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> 
> v4: Use is_migrate_cma_page() and update the commit log per
> Vlastimil.
> v3: Use a string pointer instead of an array per Michal.
> v2: Borrow some commit log texts.
>     Call dump_page() in the error path.
> 
>  mm/page_alloc.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d96ca5bc555b..c6ce20aaf80b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8005,7 +8005,10 @@ void *__init alloc_large_system_hash(const
> char *tablename,
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int
> count,
>  			 int migratetype, int flags)
>  {
> -	unsigned long pfn, iter, found;
> +	unsigned long found;
> +	unsigned long iter = 0;
> +	unsigned long pfn = page_to_pfn(page);
> +	const char *reason = "unmovable page";
>  
>  	/*
>  	 * TODO we could make this much more efficient by not
> checking every
> @@ -8015,17 +8018,20 @@ bool has_unmovable_pages(struct zone *zone,
> struct page *page, int count,
>  	 * can still lead to having bootmem allocations in
> zone_movable.
>  	 */
>  
> -	/*
> -	 * CMA allocations (alloc_contig_range) really need to mark
> isolate
> -	 * CMA pageblocks even when they are not movable in fact so
> consider
> -	 * them movable here.
> -	 */
> -	if (is_migrate_cma(migratetype) &&
> -			is_migrate_cma(get_pageblock_migratetype(pag
> e)))
> -		return false;
> +	if (is_migrate_cma_page(page)) {
> +		/*
> +		 * CMA allocations (alloc_contig_range) really need
> to mark
> +		 * isolate CMA pageblocks even when they are not
> movable in fact
> +		 * so consider them movable here.
> +		 */
> +		if (is_migrate_cma(migratetype))
> +			return false;
> +
> +		reason = "CMA page";
> +		goto unmovable;
> +	}
>  
> -	pfn = page_to_pfn(page);
> -	for (found = 0, iter = 0; iter < pageblock_nr_pages; iter++)
> {
> +	for (found = 0; iter < pageblock_nr_pages; iter++) {
>  		unsigned long check = pfn + iter;
>  
>  		if (!pfn_valid_within(check))
> @@ -8105,7 +8111,7 @@ bool has_unmovable_pages(struct zone *zone,
> struct page *page, int count,
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
>  	if (flags & REPORT_FAILURE)
> -		dump_page(pfn_to_page(pfn+iter), "unmovable page");
> +		dump_page(pfn_to_page(pfn + iter), reason);
>  	return true;
>  }
>  
-- 
Oscar Salvador
SUSE L3
