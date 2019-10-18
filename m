Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4125A222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571399551;
	bh=D9LghzEEyf8QuTbE4bhDEX15GceImZzEwifvj5okrJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xlPJmM6ZYDcezYLYERHfb0rEHZVUG92qVbEE5NcZ5QBEmCcMse/6AJ574YYcoRcqu
	 9VvHsVYSBolg0tHcvR4EfTW4aAR7Rn2Pn13BpEg2DiNoV7cBl0df9p+yEMxTUiSATk
	 aV3yJaPhWkQ6X6/on8KpOFE/EG4+U5IRsSLnFWjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633644AbfJRLwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:52:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:60108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729946AbfJRLw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:52:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13320ACA5;
        Fri, 18 Oct 2019 11:52:28 +0000 (UTC)
Date:   Fri, 18 Oct 2019 13:52:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/16] mm,madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Message-ID: <20191018115227.GL5017@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017142123.24245-3-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 16:21:09, Oscar Salvador wrote:
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> The call to get_user_pages_fast is only to get the pointer to a struct
> page of a given address, pinning it is memory-poisoning handler's job,
> so drop the refcount grabbed by get_user_pages_fast
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/madvise.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2be9f3fdb05e..89ed9a22ff4f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -878,16 +878,24 @@ static int madvise_inject_error(int behavior,
>  		 */
>  		order = compound_order(compound_head(page));
>  
> -		if (PageHWPoison(page)) {
> -			put_page(page);
> +		/*
> +		 * The get_user_pages_fast() is just to get the pfn of the
> +		 * given address, and the refcount has nothing to do with
> +		 * what we try to test, so it should be released immediately.
> +		 * This is racy but it's intended because the real hardware
> +		 * errors could happen at any moment and memory error handlers
> +		 * must properly handle the race.
> +		 */
> +		put_page(page);
> +
> +		if (PageHWPoison(page))
>  			continue;
> -		}
>  
>  		if (behavior == MADV_SOFT_OFFLINE) {
>  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>  					pfn, start);
>  
> -			ret = soft_offline_page(page, MF_COUNT_INCREASED);
> +			ret = soft_offline_page(page, 0);

What does prevent this struct page to go away completely?

>  			if (ret)
>  				return ret;
>  			continue;
> @@ -895,14 +903,6 @@ static int madvise_inject_error(int behavior,
>  
>  		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>  				pfn, start);
> -
> -		/*
> -		 * Drop the page reference taken by get_user_pages_fast(). In
> -		 * the absence of MF_COUNT_INCREASED the memory_failure()
> -		 * routine is responsible for pinning the page to prevent it
> -		 * from being released back to the page allocator.
> -		 */
> -		put_page(page);
>  		ret = memory_failure(pfn, 0);
>  		if (ret)
>  			return ret;
> -- 
> 2.12.3
> 

-- 
Michal Hocko
SUSE Labs
