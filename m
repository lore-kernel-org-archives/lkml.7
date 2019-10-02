Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82052C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610F421848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJBR0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:26:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53161 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbfJBR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:26:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TdzVieg_1570037201;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TdzVieg_1570037201)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Oct 2019 01:26:44 +0800
Subject: Re: [PATCH] mm thp: shrink deferred split THPs harder
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, hughd@google.com, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1569974210-55366-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191002084014.GH15624@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9cfcafe7-dd57-a4d7-236f-eda472c7bb7d@linux.alibaba.com>
Date:   Wed, 2 Oct 2019 10:26:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191002084014.GH15624@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/19 1:40 AM, Michal Hocko wrote:
> On Wed 02-10-19 07:56:50, Yang Shi wrote:
>> The deferred split THPs may get accumulated with some workloads, they
>> would get shrunk when memory pressure is hit.  Now we use DEFAULT_SEEKS
>> to determine how many objects would get scanned then split if possible,
>> but actually they are not like other system cache objects, i.e. inode
>> cache which would incur extra I/O if over reclaimed, the unmapped pages
>> will not be accessed anymore, so we could shrink them more aggressively.
>>
>> We could shrink THPs more pro-actively even though memory pressure is not
>> hit, however, IMHO waiting for memory pressure is still a good
>> compromise and trade-off.  And, we do have simpler ways to shrink these
>> objects harder until we have to take other means do pro-actively drain.
>>
>> Change shrinker->seeks to 0 to shrink deferred split THPs harder.
> Do you have any numbers on the effect of this patch.

Yes, this patch would make THPs get split earlier.

For example, I have a test case which generates around 4G deferred split 
THPs (2K huge pages). With the default seeks, THPs would start to get 
split when priority reaches 6 since nr_to_scan depends on priority and 
shrinker->seeks. With this patch it would start to get split at the very 
beginning (priority 12).

IMHO, somehow this would achieve the similar effect with pro-actively 
draining.

>
> Btw. the whole thing is getting more and more complex and I still
> believe the approach is just wrong. We are tunning for something that
> doesn't really belong to the memory reclaim in the first place IMHO.

Maybe, but it is not clear to me that other approaches would be 
universally better than the current one unless we could split the page 
right away.

>   
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/huge_memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3b78910..1d6b1f1 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2955,7 +2955,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   static struct shrinker deferred_split_shrinker = {
>>   	.count_objects = deferred_split_count,
>>   	.scan_objects = deferred_split_scan,
>> -	.seeks = DEFAULT_SEEKS,
>> +	.seeks = 0,
>>   	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
>>   		 SHRINKER_NONSLAB,
>>   };
>> -- 
>> 1.8.3.1

