Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852DC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B58E21721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE2Ce3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:34:29 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37206 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfE2Ce3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:34:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TSvOYQ4_1559097264;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSvOYQ4_1559097264)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 May 2019 10:34:25 +0800
Subject: Re: [RFC PATCH 0/3] Make deferred split shrinker memcg aware
To:     David Rientjes <rientjes@google.com>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1905281817090.86034@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2e23bd8c-6120-5a86-9e9e-ab43b02ce150@linux.alibaba.com>
Date:   Wed, 29 May 2019 10:34:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905281817090.86034@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/19 9:22 AM, David Rientjes wrote:
> On Tue, 28 May 2019, Yang Shi wrote:
>
>> I got some reports from our internal application team about memcg OOM.
>> Even though the application has been killed by oom killer, there are
>> still a lot THPs reside, page reclaim doesn't reclaim them at all.
>>
>> Some investigation shows they are on deferred split queue, memcg direct
>> reclaim can't shrink them since THP deferred split shrinker is not memcg
>> aware, this may cause premature OOM in memcg.  The issue can be
>> reproduced easily by the below test:
>>
> Right, we've also encountered this.  I talked to Kirill about it a week or
> so ago where the suggestion was to split all compound pages on the
> deferred split queues under the presence of even memory pressure.
>
> That breaks cgroup isolation and perhaps unfairly penalizes workloads that
> are running attached to other memcg hierarchies that are not under
> pressure because their compound pages are now split as a side effect.
> There is a benefit to keeping these compound pages around while not under
> memory pressure if all pages are subsequently mapped again.

Yes, I do agree. I tried other approaches too, it sounds making deferred 
split queue per memcg is the optimal one.

>
>> $ cgcreate -g memory:thp
>> $ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
>> $ cgexec -g memory:thp ./transhuge-stress 4000
>>
>> transhuge-stress comes from kernel selftest.
>>
>> It is easy to hit OOM, but there are still a lot THP on the deferred split
>> queue, memcg direct reclaim can't touch them since the deferred split
>> shrinker is not memcg aware.
>>
> Yes, we have seen this on at least 4.15 as well.
>
>> Convert deferred split shrinker memcg aware by introducing per memcg deferred
>> split queue.  The THP should be on either per node or per memcg deferred
>> split queue if it belongs to a memcg.  When the page is immigrated to the
>> other memcg, it will be immigrated to the target memcg's deferred split queue
>> too.
>>
>> And, move deleting THP from deferred split queue in page free before memcg
>> uncharge so that the page's memcg information is available.
>>
>> Reuse the second tail page's deferred_list for per memcg list since the same
>> THP can't be on multiple deferred split queues at the same time.
>>
>> Remove THP specific destructor since it is not used anymore with memcg aware
>> THP shrinker (Please see the commit log of patch 2/3 for the details).
>>
>> Make deferred split shrinker not depend on memcg kmem since it is not slab.
>> It doesn't make sense to not shrink THP even though memcg kmem is disabled.
>>
>> With the above change the test demonstrated above doesn't trigger OOM anymore
>> even though with cgroup.memory=nokmem.
>>
> I'm curious if your internal applications team is also asking for
> statistics on how much memory can be freed if the deferred split queues
> can be shrunk?  We have applications that monitor their own memory usage

No, but this reminds me. The THPs on deferred split queue should be 
accounted into available memory too.

> through memcg stats or usage and proactively try to reduce that usage when
> it is growing too large.  The deferred split queues have significantly
> increased both memcg usage and rss when they've upgraded kernels.
>
> How are your applications monitoring how much memory from deferred split
> queues can be freed on memory pressure?  Any thoughts on providing it as a
> memcg stat?

I don't think they have such monitor. I saw rss_huge is abormal in memcg 
stat even after the application is killed by oom, so I realized the 
deferred split queue may play a role here.

The memcg stat doesn't have counters for available memory as global 
vmstat. It may be better to have such statistics, or extending 
reclaimable "slab" to shrinkable/reclaimable "memory".

>
> Thanks!

