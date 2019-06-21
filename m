Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B1208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561104712;
	bh=OFfo/3eq3QQ66aWr0ZMwYUCzIJNojKOCPFo0nmQoqmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zxqeqwcEJT2J4bMiM2hvA2w/mE7gAt/6zkkoWdmKqZIQXjz/vMnjY+sLNgnQ8GkVv
	 wH2XaCiFMksvz9+upBpXIklUsUgV9+DUds50p6emACZOqFL2d44H3atGKWPYXzpXis
	 ZI8wia67OvDgcN08ME5lLPj8ai4CgfwhXZiiyJGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFUILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfFUILu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5292CAF50;
        Fri, 21 Jun 2019 08:11:49 +0000 (UTC)
Date:   Fri, 21 Jun 2019 10:11:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190621081147.GC3429@dhcp22.suse.cz>
References: <20190605214922.17684-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605214922.17684-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for a late reply.

On Wed 05-06-19 14:49:22, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> release_pages() is an optimized version of a loop around put_page().
> Unfortunately for devmap pages the logic is not entirely correct in
> release_pages().  This is because device pages can be more than type
> MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS
> DAX, and PCI P2PDMA.  Some of these have specific needs to "put" the
> page while others do not.
> 
> This logic to handle any special needs is contained in
> put_devmap_managed_page().  Therefore all devmap pages should be
> processed by this function where we can contain the correct logic for a
> page put.
> 
> Handle all device type pages within release_pages() by calling
> put_devmap_managed_page() on all devmap pages.  If
> put_devmap_managed_page() returns true the page has been put and we
> continue with the next page.  A false return of
> put_devmap_managed_page() means the page did not require special
> processing and should fall to "normal" processing.
> 
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.[1]

This is much more clear than the previous version I've looked at. Thanks
a lot!
> 
> [1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc.intel.com/
> 
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
> Changes from V3:
> 	Update comment to the one provided by John
> 
> Changes from V2:
> 	Update changelog for more clarity as requested by Michal
> 	Update comment WRT "failing" of put_devmap_managed_page()
> 
> Changes from V1:
> 	Add comment clarifying that put_devmap_managed_page() can still
> 	fail.
> 	Add Reviewed-by tags.
> 
>  mm/swap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 7ede3eddc12a..607c48229a1d 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
>  		if (is_huge_zero_page(page))
>  			continue;
>  
> -		/* Device public page can not be huge page */
> -		if (is_device_public_page(page)) {
> +		if (is_zone_device_page(page)) {
>  			if (locked_pgdat) {
>  				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
>  						       flags);
>  				locked_pgdat = NULL;
>  			}
> -			put_devmap_managed_page(page);
> -			continue;
> +			/*
> +			 * ZONE_DEVICE pages that return 'false' from
> +			 * put_devmap_managed_page() do not require special
> +			 * processing, and instead, expect a call to
> +			 * put_page_testzero().
> +			 */
> +			if (put_devmap_managed_page(page))
> +				continue;
>  		}
>  
>  		page = compound_head(page);
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
