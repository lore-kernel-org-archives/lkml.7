Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E3DC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CFD2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfE0HGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:06:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:18791 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0HGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 00:06:30 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2019 00:06:28 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <mgorman@techsingularity.net>, <kirill.shutemov@linux.intel.com>,
        <josef@toxicpanda.com>, <hughd@google.com>, <shakeelb@google.com>,
        <hdanton@sina.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v6 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP swapout
References: <1558929166-3363-1-git-send-email-yang.shi@linux.alibaba.com>
        <1558929166-3363-2-git-send-email-yang.shi@linux.alibaba.com>
Date:   Mon, 27 May 2019 15:06:27 +0800
In-Reply-To: <1558929166-3363-2-git-send-email-yang.shi@linux.alibaba.com>
        (Yang Shi's message of "Mon, 27 May 2019 11:52:46 +0800")
Message-ID: <87ef4k8jgs.fsf@yhuang-dev.intel.com>
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
> Cc: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v6: Fixed the other double account issue introduced by v5 per Huang Ying
> v5: Fixed sc->nr_scanned double accounting per Huang Ying
>     Added some comments to address the concern about premature OOM per Hillf Danton 
> v4: Fixed the comments from Johannes and Huang Ying
> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>     Switched back to use compound_order per Matthew
>     Fixed more counters per Johannes
> v2: Added Shakeel's Reviewed-by
>     Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>
>  mm/vmscan.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b65bc50..378edff 100644
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
> @@ -1129,7 +1130,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  
>  		VM_BUG_ON_PAGE(PageActive(page), page);
>  
> -		sc->nr_scanned++;
> +		nr_pages = 1 << compound_order(page);
> +
> +		/* Account the number of base pages even though THP */
> +		sc->nr_scanned += nr_pages;
>  
>  		if (unlikely(!page_evictable(page)))
>  			goto activate_locked;
> @@ -1250,7 +1254,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		case PAGEREF_ACTIVATE:
>  			goto activate_locked;
>  		case PAGEREF_KEEP:
> -			stat->nr_ref_keep++;
> +			stat->nr_ref_keep += nr_pages;
>  			goto keep_locked;
>  		case PAGEREF_RECLAIM:
>  		case PAGEREF_RECLAIM_CLEAN:
> @@ -1306,6 +1310,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		}
>  
>  		/*
> +		 * THP may get split above, need minus tail pages and update
> +		 * nr_pages to avoid accounting tail pages twice.
> +		 */
> +		if ((nr_pages > 1) && !PageTransHuge(page)) {
> +			sc->nr_scanned -= (nr_pages - 1);
> +			nr_pages = 1;
> +		}

After checking the code again, it appears there's another hole in the
code.  In the following code snippet.

				if (!add_to_swap(page)) {
					if (!PageTransHuge(page))
						goto activate_locked;
					/* Fallback to swap normal pages */
					if (split_huge_page_to_list(page,
								    page_list))
						goto activate_locked;
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
					count_vm_event(THP_SWPOUT_FALLBACK);
#endif
					if (!add_to_swap(page))
						goto activate_locked;
				}


If the THP is split, but the first or the second add_to_swap() fails, we
still need to deal with sc->nr_scanned and nr_pages.

How about add a new label before "activate_locked" to deal with that?

Best Regards,
Huang, Ying
