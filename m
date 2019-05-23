Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FDBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B97521019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfEWMwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:52:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:53817 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWMwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:52:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 05:52:50 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 05:52:48 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <kirill.shutemov@linux.intel.com>,
        <josef@toxicpanda.com>, <hughd@google.com>, <shakeelb@google.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v4 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP swapout
References: <1558578458-83807-1-git-send-email-yang.shi@linux.alibaba.com>
        <1558578458-83807-2-git-send-email-yang.shi@linux.alibaba.com>
Date:   Thu, 23 May 2019 20:52:48 +0800
In-Reply-To: <1558578458-83807-2-git-send-email-yang.shi@linux.alibaba.com>
        (Yang Shi's message of "Thu, 23 May 2019 10:27:38 +0800")
Message-ID: <87lfyx9vtr.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
> and some other vm counters still get inc'ed by one even though a whole
> THP (512 pages) gets swapped out.
>
> This doesn't make too much sense to memory reclaim.  For example, direct
> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
> could fulfill it.  But, if nr_reclaimed is not increased correctly,
> direct reclaim may just waste time to reclaim more pages,
> SWAP_CLUSTER_MAX * 512 pages in worst case.
>
> And, it may cause pgsteal_{kswapd|direct} is greater than
> pgscan_{kswapd|direct}, like the below:
>
> pgsteal_kswapd 122933
> pgsteal_direct 26600225
> pgscan_kswapd 174153
> pgscan_direct 14678312
>
> nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
> break some page reclaim logic, e.g.
>
> vmpressure: this looks at the scanned/reclaimed ratio so it won't
> change semantics as long as scanned & reclaimed are fixed in parallel.
>
> compaction/reclaim: compaction wants a certain number of physical pages
> freed up before going back to compacting.
>
> kswapd priority raising: kswapd raises priority if we scan fewer pages
> than the reclaim target (which itself is obviously expressed in order-0
> pages). As a result, kswapd can falsely raise its aggressiveness even
> when it's making great progress.
>
> Other than nr_scanned and nr_reclaimed, some other counters, e.g.
> pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed
> too since they are user visible via cgroup, /proc/vmstat or trace
> points, otherwise they would be underreported.
>
> When isolating pages from LRUs, nr_taken has been accounted in base
> page, but nr_scanned and nr_skipped are still accounted in THP.  It
> doesn't make too much sense too since this may cause trace point
> underreport the numbers as well.
>
> So accounting those counters in base page instead of accounting THP as
> one page.
>
> nr_dirty, nr_unqueued_dirty, nr_congested and nr_writeback are used by
> file cache, so they are not impacted by THP swap.
>
> This change may result in lower steal/scan ratio in some cases since
> THP may get split during page reclaim, then a part of tail pages get
> reclaimed instead of the whole 512 pages, but nr_scanned is accounted
> by 512, particularly for direct reclaim.  But, this should be not a
> significant issue.
>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v4: Fixed the comments from Johannes and Huang Ying
> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>     Switched back to use compound_order per Matthew
>     Fixed more counters per Johannes
> v2: Added Shakeel's Reviewed-by
>     Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>
>  mm/vmscan.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b65bc50..1b35a7a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1118,6 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		int may_enter_fs;
>  		enum page_references references = PAGEREF_RECLAIM_CLEAN;
>  		bool dirty, writeback;
> +		unsigned int nr_pages;
>  
>  		cond_resched();
>  
> @@ -1129,7 +1130,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  
>  		VM_BUG_ON_PAGE(PageActive(page), page);
>  
> -		sc->nr_scanned++;
> +		/* Account the number of base pages evne though THP */

s/evne/even/

> +		nr_pages = 1 << compound_order(page);
> +		sc->nr_scanned += nr_pages;
>  
>  		if (unlikely(!page_evictable(page)))
>  			goto activate_locked;
> @@ -1250,7 +1253,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		case PAGEREF_ACTIVATE:
>  			goto activate_locked;
>  		case PAGEREF_KEEP:
> -			stat->nr_ref_keep++;
> +			stat->nr_ref_keep += nr_pages;
>  			goto keep_locked;
>  		case PAGEREF_RECLAIM:
>  		case PAGEREF_RECLAIM_CLEAN:

If the THP is split, you need

        sc->nr_scanned -= nr_pages - 1;

Otherwise the tail pages will be counted twice.

> @@ -1315,7 +1318,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  			if (unlikely(PageTransHuge(page)))
>  				flags |= TTU_SPLIT_HUGE_PMD;
>  			if (!try_to_unmap(page, flags)) {
> -				stat->nr_unmap_fail++;
> +				stat->nr_unmap_fail += nr_pages;
>  				goto activate_locked;
>  			}
>  		}
> @@ -1442,7 +1445,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  
>  		unlock_page(page);
>  free_it:
> -		nr_reclaimed++;
> +		/*
> +		 * THP may get swapped out in a whole, need account
> +		 * all base pages.
> +		 */
> +		nr_reclaimed += (1 << compound_order(page));

Best Regards,
Huang, Ying
