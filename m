Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E70B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfHORW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbfHORW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43F523082E51;
        Thu, 15 Aug 2019 17:22:56 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D85710018F9;
        Thu, 15 Aug 2019 17:22:55 +0000 (UTC)
Date:   Thu, 15 Aug 2019 13:22:53 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/migrate: remove the duplicated code
 migrate_vma_collect_hole()
Message-ID: <20190815172253.GE30916@redhat.com>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
 <1565078411-27082-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565078411-27082-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 17:22:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 04:00:11PM +0800, Pingfan Liu wrote:
> After the previous patch which sees hole as invalid source,
> migrate_vma_collect_hole() has the same code as migrate_vma_collect_skip().
> Removing the duplicated code.

NAK this one too given previous NAK.

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/migrate.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 832483f..95e038d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2128,22 +2128,6 @@ struct migrate_vma {
>  	unsigned long		end;
>  };
>  
> -static int migrate_vma_collect_hole(unsigned long start,
> -				    unsigned long end,
> -				    struct mm_walk *walk)
> -{
> -	struct migrate_vma *migrate = walk->private;
> -	unsigned long addr;
> -
> -	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
> -		migrate->src[migrate->npages] = 0;
> -		migrate->dst[migrate->npages] = 0;
> -		migrate->npages++;
> -	}
> -
> -	return 0;
> -}
> -
>  static int migrate_vma_collect_skip(unsigned long start,
>  				    unsigned long end,
>  				    struct mm_walk *walk)
> @@ -2173,7 +2157,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  
>  again:
>  	if (pmd_none(*pmdp))
> -		return migrate_vma_collect_hole(start, end, walk);
> +		return migrate_vma_collect_skip(start, end, walk);
>  
>  	if (pmd_trans_huge(*pmdp)) {
>  		struct page *page;
> @@ -2206,7 +2190,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  				return migrate_vma_collect_skip(start, end,
>  								walk);
>  			if (pmd_none(*pmdp))
> -				return migrate_vma_collect_hole(start, end,
> +				return migrate_vma_collect_skip(start, end,
>  								walk);
>  		}
>  	}
> @@ -2337,7 +2321,7 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
>  
>  	mm_walk.pmd_entry = migrate_vma_collect_pmd;
>  	mm_walk.pte_entry = NULL;
> -	mm_walk.pte_hole = migrate_vma_collect_hole;
> +	mm_walk.pte_hole = migrate_vma_collect_skip;
>  	mm_walk.hugetlb_entry = NULL;
>  	mm_walk.test_walk = NULL;
>  	mm_walk.vma = migrate->vma;
> -- 
> 2.7.5
> 
