Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B9C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8962182B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558969271;
	bh=4OG4/l+3HjzMUGq/hKraSkb6yxA27ZXlX+sW3FxdBCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+kZwQMV7Knf8BijrYD6toNolU+ZwSqrf4wB+7DVoO/LeFNwdyX4Y9CHWVwYq7UFQ
	 rxtp7OuOa7tSVSCo7GqSlGnyODHVeWj4UPQjx/L6nsz6hbnhB49ZzvX0YR6NENC51N
	 wCdLG91LREhg/U0hFKvTZRHCBw28Qu/NpDrtoejI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfE0PBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:01:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:48034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfE0PBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:01:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 065A5AE74;
        Mon, 27 May 2019 15:01:08 +0000 (UTC)
Date:   Mon, 27 May 2019 17:01:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190527150107.GG1658@dhcp22.suse.cz>
References: <20190524173656.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524173656.8339-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-05-19 10:36:56, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Device pages can be more than type MEMORY_DEVICE_PUBLIC.
> 
> Handle all device pages within release_pages()
> 
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.

Please expand more about who is such a user and why does it use
release_pages rather than put_*page API. The above changelog doesn't
really help understanding what is the actual problem. I also do not
understand the fix and a failure mode from release_pages is just scary.
It is basically impossible to handle the error case. So what is going on
here?

> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> 	Add comment clarifying that put_devmap_managed_page() can still
> 	fail.
> 	Add Reviewed-by tags.
> 
>  mm/swap.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 9d0432baddb0..f03b7b4bfb4f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -740,15 +740,18 @@ void release_pages(struct page **pages, int nr)
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
> +			 * zone-device-pages can still fail here and will
> +			 * therefore need put_page_testzero()
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
