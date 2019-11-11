Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBAC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405C2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573514285;
	bh=rdJa61maE1ekeAOY2Gb+SEWYgZusibLnrBqmCvuYI+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G7jDLTOVsB0EurEZKRrMXTvqN2GrQLn2OzrML+IVRvaVGpaYZxrrr7vv9/aRlOLqX
	 8CRiyin1W2EsiNapVqIPTWuwC3XOy9N7vcAIERPXW1Lsse+Yc3EbXiTKNIqEje+WQL
	 IvC1RD8CkCpav6mikmrYnuYrswVZey2wIMgrYgXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKKXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKXSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:18:04 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11632184C;
        Mon, 11 Nov 2019 23:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573514281;
        bh=rdJa61maE1ekeAOY2Gb+SEWYgZusibLnrBqmCvuYI+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nvbJM84E2sEkK32e2Rv/AuBrrVuPQF/okvjjX0bzui9PswJjAGhUgUq8r4wALvWli
         UkeeqACkIOgTMr5zQXzoOxNAr/6PZY2GKZ1rXbPPfrXXajfiYfu3bbi4YckxU5WbPJ
         R4RHMpkbdVVMXzdwABPfTfauSPX5t3kcbdTIE5iI=
Date:   Mon, 11 Nov 2019 15:18:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: handle freed page at the first place
Message-Id: <20191111151801.fb206aa84cc8ab3059994f7e@linux-foundation.org>
In-Reply-To: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 06:09:25 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

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
> 
>
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

Is it possible to have (!thp_migration_supported() &&
PageTransHuge(page) && page_count(page) == 1)?  If so, isn't this new
behviour?

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

