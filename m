Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3867B2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKGUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:19:43 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37203 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfKGUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:19:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ThRudlZ_1573157976;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThRudlZ_1573157976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Nov 2019 04:19:38 +0800
Subject: Re: [PATCH] mm: shmem: use proper gfp flags for shmem_writepage()
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191106151820.GB8138@dhcp22.suse.cz>
 <733100ea-97aa-db27-4b43-cf42317afaf8@linux.alibaba.com>
 <alpine.LSU.2.11.1911061039540.1357@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a90d6ec8-1f02-36f3-6531-a44be7d1aed9@linux.alibaba.com>
Date:   Thu, 7 Nov 2019 12:19:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1911061039540.1357@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 10:59 AM, Hugh Dickins wrote:
> On Wed, 6 Nov 2019, Yang Shi wrote:
>> On 11/6/19 7:18 AM, Michal Hocko wrote:
>>> On Wed 06-11-19 06:02:31, Yang Shi wrote:
>>>> The shmem_writepage() uses GFP_ATOMIC to allocate swap cache.
>>>> GFP_ATOMIC used to mean __GFP_HIGH, but now it means __GFP_HIGH |
>>>> __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM.  However, shmem_writepage() should
>>>> write out to swap only in response to memory pressure, so
>>>> __GFP_KSWAPD_RECLAIM looks useless since the caller may be kswapd itself
>>>> or in direct reclaim already.
>>> What kind of problem are you trying to fix here?
>> I didn't run into any visible problem. I just happened to find this
>> inconsistency when I was looking into the other problem.
> Yes, I don't think it fixes any actual problem: just a cleanup to
> make the two calls look the same when they don't need to be different
> (whereas the call from __read_swap_cache_async() rightly uses a
> lower priority gfp).

I'm supposed it is because __read_swap_cache_async()is typically called 
from page fault context which is less crucial than reclaim.

Shall I consider this as an ack but with commit log rephrased to reflect 
the cleanup?

>
> If it does fix a problem, then you need to worry also about the
> 	 * TODO: this could cause a theoretical memory reclaim
> 	 * deadlock in the swap out path.
> comment still against the call in add_to_swap(): but I think that
> is equally theoretical, demanding no attention since 2.6.12.
>
>> The add_to_swap() does:
>>
>> int add_to_swap(struct page *page)
>> {
>> ...
>> err = add_to_swap_cache(page, entry,
>>                          __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
>> ...
>> }
>>
>> Actually, shmem_writepage() does almost the same thing and both of them are
>> called in reclaim context, so I didn't see why they should use different gfp
>> flag. And, GFP_ATOMIC is also different from the old definition as I
>> mentioned in the commit log.
>>
>>>> In addition, XArray node allocations from PF_MEMALLOC contexts could
>>>> completely exhaust the page allocator, __GFP_NOMEMALLOC stops emergency
>>>> reserves from being allocated.
>>> I am not really familiar with XArray much, could you be more specific
>>> please?
>> It comes from the comments of add_to_swap(), says:
>>
>> /*
>>           * XArray node allocations from PF_MEMALLOC contexts could
>>           * completely exhaust the page allocator. __GFP_NOMEMALLOC
>>           * stops emergency reserves from being allocated.
>>
>> And, it looks the original comment came from pre-git time, TBH I'm not quite
>> sure about the specific problem which incurred this. I suspect it may be
>> because PF_MEMALLOC context allows ALLOC_NO_WATERMARK.
>>
>>>> Here just copy the gfp flags used by add_to_swap().
>>>>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> ---
>>>>    mm/shmem.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 220be9f..9691dec 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -1369,7 +1369,8 @@ static int shmem_writepage(struct page *page,
>>>> struct writeback_control *wbc)
>>>>    	if (list_empty(&info->swaplist))
>>>>    		list_add(&info->swaplist, &shmem_swaplist);
>>>>    -	if (add_to_swap_cache(page, swap, GFP_ATOMIC) == 0) {
>>>> +	if (add_to_swap_cache(page, swap,
>>>> +			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
>>>>    		spin_lock_irq(&info->lock);
>>>>    		shmem_recalc_inode(inode);
>>>>    		info->swapped++;
>>>> -- 
>>>> 1.8.3.1

