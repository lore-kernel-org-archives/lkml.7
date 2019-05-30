Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB7EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9334124B8D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfE3DjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:39:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49725 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732844AbfE3DWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:22:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TT-SMAB_1559186545;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TT-SMAB_1559186545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 May 2019 11:22:26 +0800
Subject: Re: [RFC PATCH 0/3] Make deferred split shrinker memcg aware
To:     David Rientjes <rientjes@google.com>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1905281817090.86034@chino.kir.corp.google.com>
 <2e23bd8c-6120-5a86-9e9e-ab43b02ce150@linux.alibaba.com>
 <alpine.DEB.2.21.1905291402360.242480@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9af25d50-576a-3cc3-20a3-c0c61cf3e494@linux.alibaba.com>
Date:   Thu, 30 May 2019 11:22:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905291402360.242480@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/19 5:07 AM, David Rientjes wrote:
> On Wed, 29 May 2019, Yang Shi wrote:
>
>>> Right, we've also encountered this.  I talked to Kirill about it a week or
>>> so ago where the suggestion was to split all compound pages on the
>>> deferred split queues under the presence of even memory pressure.
>>>
>>> That breaks cgroup isolation and perhaps unfairly penalizes workloads that
>>> are running attached to other memcg hierarchies that are not under
>>> pressure because their compound pages are now split as a side effect.
>>> There is a benefit to keeping these compound pages around while not under
>>> memory pressure if all pages are subsequently mapped again.
>> Yes, I do agree. I tried other approaches too, it sounds making deferred split
>> queue per memcg is the optimal one.
>>
> The approach we went with were to track the actual counts of compound
> pages on the deferred split queue for each pgdat for each memcg and then
> invoke the shrinker for memcg reclaim and iterate those not charged to the
> hierarchy under reclaim.  That's suboptimal and was a stop gap measure
> under time pressure: it's refreshing to see the optimal method being
> pursued, thanks!

We did the exactly same thing for a temporary hotfix.

>
>>> I'm curious if your internal applications team is also asking for
>>> statistics on how much memory can be freed if the deferred split queues
>>> can be shrunk?  We have applications that monitor their own memory usage
>> No, but this reminds me. The THPs on deferred split queue should be accounted
>> into available memory too.
>>
> Right, and we have also seen this for users of MADV_FREE that have both an
> increased rss and memcg usage that don't realize that the memory is freed
> under pressure.  I'm thinking that we need some kind of MemAvailable for
> memcg hierarchies to be the authoritative source of what can be reclaimed
> under pressure.

It sounds useful. We also need know the available memory in memcg scope 
in our containers.

>
>>> through memcg stats or usage and proactively try to reduce that usage when
>>> it is growing too large.  The deferred split queues have significantly
>>> increased both memcg usage and rss when they've upgraded kernels.
>>>
>>> How are your applications monitoring how much memory from deferred split
>>> queues can be freed on memory pressure?  Any thoughts on providing it as a
>>> memcg stat?
>> I don't think they have such monitor. I saw rss_huge is abormal in memcg stat
>> even after the application is killed by oom, so I realized the deferred split
>> queue may play a role here.
>>
> Exactly the same in my case :)  We were likely looking at the exact same
> issue at the same time.

Yes, it seems so. :-)

>> The memcg stat doesn't have counters for available memory as global vmstat. It
>> may be better to have such statistics, or extending reclaimable "slab" to
>> shrinkable/reclaimable "memory".
>>
> Have you considered following how NR_ANON_MAPPED is tracked for each pgdat
> and using that as an indicator of when the modify a memcg stat to track
> the amount of memory on a compound page?  I think this would be necessary
> for userspace to know what their true memory usage is.

No, I haven't. Do you mean minus MADV_FREE and deferred split THP from 
NR_ANON_MAPPED? It looks they have been decreased from NR_ANON_MAPPED 
when removing rmap.


