Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891D4205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfF1SxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:53:11 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57264 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726909AbfF1SxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:53:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TVRxcr9_1561747966;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVRxcr9_1561747966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jun 2019 02:52:57 +0800
Subject: Re: [PATCH] mm, vmscan: prevent useless kswapd loops
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hillf Danton <hdanton@sina.com>, Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190628015520.13357-1-shakeelb@google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6e28c8ce-96e1-5a1e-bd06-d1df5856094e@linux.alibaba.com>
Date:   Fri, 28 Jun 2019 11:52:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190628015520.13357-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/19 6:55 PM, Shakeel Butt wrote:
> On production we have noticed hard lockups on large machines running
> large jobs due to kswaps hoarding lru lock within isolate_lru_pages when
> sc->reclaim_idx is 0 which is a small zone. The lru was couple hundred
> GiBs and the condition (page_zonenum(page) > sc->reclaim_idx) in
> isolate_lru_pages was basically skipping GiBs of pages while holding the
> LRU spinlock with interrupt disabled.
>
> On further inspection, it seems like there are two issues:
>
> 1) If the kswapd on the return from balance_pgdat() could not sleep
> (maybe all zones are still unbalanced), the classzone_idx is set to 0,
> unintentionally, and the whole reclaim cycle of kswapd will try to reclaim
> only the lowest and smallest zone while traversing the whole memory.
>
> 2) Fundamentally isolate_lru_pages() is really bad when the allocation
> has woken kswapd for a smaller zone on a very large machine running very
> large jobs. It can hoard the LRU spinlock while skipping over 100s of
> GiBs of pages.
>
> This patch only fixes the (1). The (2) needs a more fundamental solution.
>
> Fixes: e716f2eb24de ("mm, vmscan: prevent kswapd sleeping prematurely
> due to mismatched classzone_idx")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9e3292ee5c7c..786dacfdfe29 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3908,7 +3908,7 @@ static int kswapd(void *p)
>   
>   		/* Read the new order and classzone_idx */
>   		alloc_order = reclaim_order = pgdat->kswapd_order;
> -		classzone_idx = kswapd_classzone_idx(pgdat, 0);
> +		classzone_idx = kswapd_classzone_idx(pgdat, classzone_idx);

I'm a little bit confused by the fix. What happen if kswapd is waken for 
a lower zone? It looks kswapd may just reclaim the higher zone instead 
of the lower zone?

For example, after bootup, classzone_idx should be (MAX_NR_ZONES - 1), 
if GFP_DMA is used for allocation and kswapd is waken up for ZONE_DMA, 
kswapd_classzone_idx would still return (MAX_NR_ZONES - 1) since 
kswapd_classzone_idx(pgdat, classzone_idx) returns the max classzone_idx.

>   		pgdat->kswapd_order = 0;
>   		pgdat->kswapd_classzone_idx = MAX_NR_ZONES;
>   

