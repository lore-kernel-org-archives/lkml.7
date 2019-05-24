Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B32C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82C22133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfEXFiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:38:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44341 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387434AbfEXFiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:38:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSXa0AK_1558676276;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSXa0AK_1558676276)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 May 2019 13:37:56 +0800
Subject: Re: [v4 PATCH 1/2] mm: vmscan: remove double slab pressure by inc'ing
 sc->nr_scanned
To:     Hillf Danton <hdanton@sina.com>
Cc:     ying.huang@intel.com, hannes@cmpxchg.org, mhocko@suse.com,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        josef@toxicpanda.com, hughd@google.com, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190524041545.10820-1-hdanton@sina.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6a3a7a59-fe63-68b9-cec1-400395a2a199@linux.alibaba.com>
Date:   Fri, 24 May 2019 13:37:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190524041545.10820-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/19 12:15 PM, Hillf Danton wrote:
> On Thu, 23 May 2019 10:27:37 +0800 Yang Shi wrote:
>> The commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
>> has broken up the relationship between sc->nr_scanned and slab pressure.
>> The sc->nr_scanned can't double slab pressure anymore.  So, it sounds no
>> sense to still keep sc->nr_scanned inc'ed.  Actually, it would prevent
>> from adding pressure on slab shrink since excessive sc->nr_scanned would
>> prevent from scan->priority raise.
>>
> The deleted code below wants to get more slab pages shrinked, and it can do
> that without raising scan priority first even after commit 9092c71bb724. Or
> we may face the risk that priority goes up too much faster than thought, per
> the following snippet.

The priority is raised if kswapd_shrink_node() returns false for kswapd 
(The direct reclaim would just raise the priority if sc->nr_reclaimed >= 
sc->nr_to_reclaim). The kswapd_shrink_node() returns "return 
sc->nr_scanned >= sc->nr_to_reclaim". So, the old "double pressure" 
doesn't work as it was designed anymore since it would prevent from make 
"sc->nr_scanned < sc->nr_to_reclaim".

And, the patch 2/2 would not make the priority go up too much since one 
THP would be accounted as 512 base page.

>
> 		/*
> 		 * If we're getting trouble reclaiming, start doing
> 		 * writepage even in laptop mode.
> 		 */
> 		if (sc->priority < DEF_PRIORITY - 2)
>
>> The bonnie test doesn't show this would change the behavior of
>> slab shrinkers.
>>
>> 				w/		w/o
>> 			  /sec    %CP      /sec      %CP
>> Sequential delete: 	3960.6    94.6    3997.6     96.2
>> Random delete: 		2518      63.8    2561.6     64.6
>>
>> The slight increase of "/sec" without the patch would be caused by the
>> slight increase of CPU usage.
>>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v4: Added Johannes's ack
>>
>>   mm/vmscan.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7acd0af..b65bc50 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1137,11 +1137,6 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		if (!sc->may_unmap && page_mapped(page))
>>   			goto keep_locked;
>>   
>> -		/* Double the slab pressure for mapped and swapcache pages */
>> -		if ((page_mapped(page) || PageSwapCache(page)) &&
>> -		    !(PageAnon(page) && !PageSwapBacked(page)))
>> -			sc->nr_scanned++;
>> -
>>   		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
>>   			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
>>   
>> -- 
>> 1.8.3.1
>>
> Best Regards
> Hillf

