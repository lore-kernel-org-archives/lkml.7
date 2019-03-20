Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E74C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDAC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCTPoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:44:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCTPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:44:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA7F1C13071D;
        Wed, 20 Mar 2019 15:44:24 +0000 (UTC)
Received: from x230.aquini.net (dhcp-17-61.bos.redhat.com [10.18.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2F9E5D73F;
        Wed, 20 Mar 2019 15:44:23 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:44:20 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        osalvador@suse.de, akpm@linux-foundation.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
Message-ID: <20190320154420.GE23194@x230.aquini.net>
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 20 Mar 2019 15:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:35:56AM +0800, Yang Shi wrote:
> When MPOL_MF_STRICT was specified and an existing page was already
> on a node that does not follow the policy, mbind() should return -EIO.
> But commit 6f4576e3687b ("mempolicy: apply page table walker on
> queue_pages_range()") broke the rule.
> 
> And, commit c8633798497c ("mm: mempolicy: mbind and migrate_pages
> support thp migration") didn't return the correct value for THP mbind()
> too.
> 
> If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it reaches
> queue_pages_to_pte_range() or queue_pages_pmd() to check if an existing
> page was already on a node that does not follow the policy.  And,
> non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
> MPOL_MF_MOVE_ALL was specified.
> 
> Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
> 
> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: stable@vger.kernel.org
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/mempolicy.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index abe7a67..401c817 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -447,6 +447,13 @@ static inline bool queue_pages_required(struct page *page,
>  	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>  }
>  
> +/*
> + * The queue_pages_pmd() may have three kind of return value.
> + * 1 - pages are placed on he right node or queued successfully.
> + * 0 - THP get split.
> + * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
> + *        page was already on a node that does not follow the policy.
> + */
>  static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  				unsigned long end, struct mm_walk *walk)
>  {
> @@ -456,7 +463,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  	unsigned long flags;
>  
>  	if (unlikely(is_pmd_migration_entry(*pmd))) {
> -		ret = 1;
> +		ret = -EIO;
>  		goto unlock;
>  	}
>  	page = pmd_page(*pmd);
> @@ -473,8 +480,15 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>  	ret = 1;
>  	flags = qp->flags;
>  	/* go to thp migration */
> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> +	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> +		if (!vma_migratable(walk->vma)) {
> +			ret = -EIO;
> +			goto unlock;
> +		}
> +
>  		migrate_page_add(page, qp->pagelist, flags);
> +	} else
> +		ret = -EIO;
>  unlock:
>  	spin_unlock(ptl);
>  out:
> @@ -499,8 +513,10 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	ptl = pmd_trans_huge_lock(pmd, vma);
>  	if (ptl) {
>  		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -		if (ret)
> +		if (ret > 0)
>  			return 0;
> +		else if (ret < 0)
> +			return ret;
>  	}
>  
>  	if (pmd_trans_unstable(pmd))
> @@ -521,11 +537,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  			continue;
>  		if (!queue_pages_required(page, qp))
>  			continue;
> -		migrate_page_add(page, qp->pagelist, flags);
> +		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> +			if (!vma_migratable(vma))
> +				break;
> +			migrate_page_add(page, qp->pagelist, flags);
> +		} else
> +			break;
>  	}
>  	pte_unmap_unlock(pte - 1, ptl);
>  	cond_resched();
> -	return 0;
> +	return addr != end ? -EIO : 0;
>  }
>  
>  static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
> @@ -595,7 +616,12 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  	unsigned long endvma = vma->vm_end;
>  	unsigned long flags = qp->flags;
>  
> -	if (!vma_migratable(vma))
> +	/*
> +	 * Need check MPOL_MF_STRICT to return -EIO if possible
> +	 * regardless of vma_migratable
> +	 */ 
> +	if (!vma_migratable(vma) &&
> +	    !(flags & MPOL_MF_STRICT))
>  		return 1;
>  
>  	if (endvma > end)
> @@ -622,7 +648,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  	}
>  
>  	/* queue pages from current vma */
> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> +	if (flags & MPOL_MF_VALID)
>  		return 0;
>  	return 1;
>  }
> -- 
> 1.8.3.1
> 
Acked-by: Rafael Aquini <aquini@redhat.com>
