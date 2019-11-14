Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA707C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B502071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573757807;
	bh=2WPFxrwJdFIdvWOnJ5mraDdOUCys5i095GPhOM9BS4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XdwJYjq6gdQUtZ9CZB3ZrUUeeAWY6Ynbv5JzSgO9OFfKXVo1VbXukB3DVhkYxuYfe
	 46KPgR6+T1l6Wy9DQStrtJndHRpfUZbIB/3jkRThVZJjmc6ivcH5km2PfX1aRAVEEu
	 0fJMoRvzrqmBz+/K+rvmAlCEYLtO9a+5pm8IO5ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKNS4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:56:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:36620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKNS4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:56:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F9CAAE12;
        Thu, 14 Nov 2019 18:56:44 +0000 (UTC)
Date:   Thu, 14 Nov 2019 19:56:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: migrate: handle freed page at the first place
Message-ID: <20191114185643.GM20866@dhcp22.suse.cz>
References: <1573755869-106954-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573755869-106954-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-11-19 02:24:29, Yang Shi wrote:
> When doing migration if the freed page is met, we just return without
> migrating it since it is pointless to migrate a freed page.  But, the
> current code allocates target page unconditionally before handling freed
> page, if the page is freed, the newly allocated will be just freed.  It
> doesn't make too much sense and is just a waste of time although
> migrating freed page is rare.
> 
> So, handle freed page at the before that to avoid unnecessary page
> allocation and free.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

I would be really surprised if this led to any runtime visible effect
but I do agree that one less put_page path looks slightly better. For
that reason
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: * Keep thp migration support check before handling freed page per Michal Hocko
>     * Fixed the build warning reported by 0-day
> 
>  mm/migrate.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fe45d1..a8f87cb 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1168,15 +1168,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  				   enum migrate_reason reason)
>  {
>  	int rc = MIGRATEPAGE_SUCCESS;
> -	struct page *newpage;
> +	struct page *newpage = NULL;
>  
>  	if (!thp_migration_supported() && PageTransHuge(page))
>  		return -ENOMEM;
>  
> -	newpage = get_new_page(page, private);
> -	if (!newpage)
> -		return -ENOMEM;
> -
>  	if (page_count(page) == 1) {
>  		/* page was freed from under us. So we are done. */
>  		ClearPageActive(page);
> @@ -1187,13 +1183,13 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
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
