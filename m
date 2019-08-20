Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251FC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3040822D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfHTKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:53:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:40122 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfHTKxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:53:47 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1i01lo-0004mL-Ik; Tue, 20 Aug 2019 13:53:44 +0300
Subject: Re: [v5 PATCH 2/4] mm: move mem_cgroup_uncharge out of
 __page_cache_release()
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        mhocko@suse.com, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, cai@lca.pw, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1565144277-36240-1-git-send-email-yang.shi@linux.alibaba.com>
 <1565144277-36240-3-git-send-email-yang.shi@linux.alibaba.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8444f6e3-e628-3d64-fd20-4ae26f1c761b@virtuozzo.com>
Date:   Tue, 20 Aug 2019 13:53:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565144277-36240-3-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.2019 05:17, Yang Shi wrote:
> The later patch would make THP deferred split shrinker memcg aware, but
> it needs page->mem_cgroup information in THP destructor, which is called
> after mem_cgroup_uncharge() now.
> 
> So, move mem_cgroup_uncharge() from __page_cache_release() to compound
> page destructor, which is called by both THP and other compound pages
> except HugeTLB.  And call it in __put_single_page() for single order
> page.
> 
> Suggested-by: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Qian Cai <cai@lca.pw>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/page_alloc.c | 1 +
>  mm/swap.c       | 2 +-
>  mm/vmscan.c     | 6 ++----
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index df02a88..1d1c5d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -670,6 +670,7 @@ static void bad_page(struct page *page, const char *reason,
>  
>  void free_compound_page(struct page *page)
>  {
> +	mem_cgroup_uncharge(page);
>  	__free_pages_ok(page, compound_order(page));
>  }
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index ae30039..d4242c8 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -71,12 +71,12 @@ static void __page_cache_release(struct page *page)
>  		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>  	}
>  	__ClearPageWaiters(page);
> -	mem_cgroup_uncharge(page);
>  }
>  
>  static void __put_single_page(struct page *page)
>  {
>  	__page_cache_release(page);
> +	mem_cgroup_uncharge(page);
>  	free_unref_page(page);
>  }
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dbdc46a..b1b5e5f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1490,10 +1490,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		 * Is there need to periodically free_page_list? It would
>  		 * appear not as the counts should be low
>  		 */
> -		if (unlikely(PageTransHuge(page))) {
> -			mem_cgroup_uncharge(page);
> +		if (unlikely(PageTransHuge(page)))
>  			(*get_compound_page_dtor(page))(page);
> -		} else
> +		else
>  			list_add(&page->lru, &free_pages);
>  		continue;
>  
> @@ -1914,7 +1913,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&pgdat->lru_lock);
> -				mem_cgroup_uncharge(page);
>  				(*get_compound_page_dtor(page))(page);
>  				spin_lock_irq(&pgdat->lru_lock);
>  			} else
> 

