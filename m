Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A322AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573545845;
	bh=6SnOfqdXhqaOls6U29IR2NKAD/SMfAUwGfpxBSUmbL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tK7eFWfxBdpDByl5EaYqb6ciQgyvzaweUAcJzLTGQUxiIQLTMX5x+2phXpvrQ9Mal
	 h68LU5PglOfIrHA3+Z8I9tHIJ9BaLi3n8oGhD31+kzREOC5XpB/t1qa2jrg6kkiRAm
	 I73qbVkUy/C/MSf46s73CYYDsl7WhdNH6Mz3wqRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLIEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:04:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:34054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbfKLIEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:04:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33614B156;
        Tue, 12 Nov 2019 08:04:02 +0000 (UTC)
Date:   Tue, 12 Nov 2019 09:04:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: handle freed page at the first place
Message-ID: <20191112080401.GA2763@dhcp22.suse.cz>
References: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-11-19 06:09:25, Yang Shi wrote:
> When doing migration if the freed page is met, we just return without
> migrating it since it is pointless to migrate a freed page.  But, the
> current code did two things before handling freed page:
> 
> 1. Return -ENOMEM if the page is THP and THP migration is not supported.
> 2. Allocate target page unconditionally.
> 
> Both makes not too much sense.  If we handle freed page at the first place
> we don't have to worry about allocating/freeing target page and split
> THP at all.
> 
> For example (worst case) if we are trying to migrate a freed THP without
> THP migration supported, the migrate_pages() would just split the THP then
> retry to migrate base pages one by one by pointless allocating and freeing
> pages, this is just waste of time.
> 
> I didn't run into any actual problem with the current code (or I may
> just not notice it yet), it was found by visual inspection.

It would be preferable to accompany a change like this with some actual
numbers. A race with page freeing should be a very rare situation. Maybe
it is not under some workloads but that would better be checked and
documented. I also do not like to do page state changes for THP
migration without a support. I cannot really say this is 100% correct
from top of my head and I do not see a sufficient justification to go
and chase all those tiny details because that is time consuming.

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/migrate.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fe45d1..ef96997 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1170,13 +1170,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  	int rc = MIGRATEPAGE_SUCCESS;
>  	struct page *newpage;
>  
> -	if (!thp_migration_supported() && PageTransHuge(page))
> -		return -ENOMEM;
> -
> -	newpage = get_new_page(page, private);
> -	if (!newpage)
> -		return -ENOMEM;
> -
>  	if (page_count(page) == 1) {
>  		/* page was freed from under us. So we are done. */
>  		ClearPageActive(page);
> @@ -1187,13 +1180,16 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  				__ClearPageIsolated(page);
>  			unlock_page(page);
>  		}
> -		if (put_new_page)
> -			put_new_page(newpage, private);
> -		else
> -			put_page(newpage);
>  		goto out;
>  	}
>  
> +	if (!thp_migration_supported() && PageTransHuge(page))
> +		return -ENOMEM;
> +
> +	newpage = get_new_page(page, private);
> +	if (!newpage)
> +		return -ENOMEM;
> +
>  	rc = __unmap_and_move(page, newpage, force, mode);
>  	if (rc == MIGRATEPAGE_SUCCESS)
>  		set_page_owner_migrate_reason(newpage, reason);
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
