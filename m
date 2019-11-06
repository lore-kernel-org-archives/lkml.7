Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBFC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667812178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573053504;
	bh=2c7cvPxuU8LfTxmHL5i0LbtUwb1edjG4zpmpPTgcb7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M3+kM5xBQx3VxpbSl/7QRQHsolX3KeCT+USw9qDLcdD+OVNDsWTFFCqq2r0h2tFST
	 WDX34TVlDsfH+yPkKICffn11BqYhKgkxxFl6Y0qHVFRYVsLSbU7XP2H2YGOIaukta7
	 PBZndcQ/nYnIJESfiPEgFQZcvQxB7NZtZb+Z8zzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfKFPSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:18:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbfKFPSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:18:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58B34AB9D;
        Wed,  6 Nov 2019 15:18:21 +0000 (UTC)
Date:   Wed, 6 Nov 2019 16:18:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: use proper gfp flags for shmem_writepage()
Message-ID: <20191106151820.GB8138@dhcp22.suse.cz>
References: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 06:02:31, Yang Shi wrote:
> The shmem_writepage() uses GFP_ATOMIC to allocate swap cache.
> GFP_ATOMIC used to mean __GFP_HIGH, but now it means __GFP_HIGH |
> __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM.  However, shmem_writepage() should
> write out to swap only in response to memory pressure, so
> __GFP_KSWAPD_RECLAIM looks useless since the caller may be kswapd itself
> or in direct reclaim already.

What kind of problem are you trying to fix here?

> In addition, XArray node allocations from PF_MEMALLOC contexts could
> completely exhaust the page allocator, __GFP_NOMEMALLOC stops emergency
> reserves from being allocated.

I am not really familiar with XArray much, could you be more specific
please?

> Here just copy the gfp flags used by add_to_swap().
> 
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/shmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 220be9f..9691dec 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1369,7 +1369,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  	if (list_empty(&info->swaplist))
>  		list_add(&info->swaplist, &shmem_swaplist);
>  
> -	if (add_to_swap_cache(page, swap, GFP_ATOMIC) == 0) {
> +	if (add_to_swap_cache(page, swap,
> +			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
>  		spin_lock_irq(&info->lock);
>  		shmem_recalc_inode(inode);
>  		info->swapped++;
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
