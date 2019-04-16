Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF18E206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfDPTTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:19:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42560 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfDPTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:19:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPUbRVj_1555442364;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPUbRVj_1555442364)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Apr 2019 03:19:27 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
Date:   Tue, 16 Apr 2019 12:19:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190416074714.GD11561@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/19 12:47 AM, Michal Hocko wrote:
> On Mon 15-04-19 17:09:07, Yang Shi wrote:
>>
>> On 4/12/19 1:47 AM, Michal Hocko wrote:
>>> On Thu 11-04-19 11:56:50, Yang Shi wrote:
>>> [...]
>>>> Design
>>>> ======
>>>> Basically, the approach is aimed to spread data from DRAM (closest to local
>>>> CPU) down further to PMEM and disk (typically assume the lower tier storage
>>>> is slower, larger and cheaper than the upper tier) by their hotness.  The
>>>> patchset tries to achieve this goal by doing memory promotion/demotion via
>>>> NUMA balancing and memory reclaim as what the below diagram shows:
>>>>
>>>>       DRAM <--> PMEM <--> Disk
>>>>         ^                   ^
>>>>         |-------------------|
>>>>                  swap
>>>>
>>>> When DRAM has memory pressure, demote pages to PMEM via page reclaim path.
>>>> Then NUMA balancing will promote pages to DRAM as long as the page is referenced
>>>> again.  The memory pressure on PMEM node would push the inactive pages of PMEM
>>>> to disk via swap.
>>>>
>>>> The promotion/demotion happens only between "primary" nodes (the nodes have
>>>> both CPU and memory) and PMEM nodes.  No promotion/demotion between PMEM nodes
>>>> and promotion from DRAM to PMEM and demotion from PMEM to DRAM.
>>>>
>>>> The HMAT is effectively going to enforce "cpu-less" nodes for any memory range
>>>> that has differentiated performance from the conventional memory pool, or
>>>> differentiated performance for a specific initiator, per Dan Williams.  So,
>>>> assuming PMEM nodes are cpuless nodes sounds reasonable.
>>>>
>>>> However, cpuless nodes might be not PMEM nodes.  But, actually, memory
>>>> promotion/demotion doesn't care what kind of memory will be the target nodes,
>>>> it could be DRAM, PMEM or something else, as long as they are the second tier
>>>> memory (slower, larger and cheaper than regular DRAM), otherwise it sounds
>>>> pointless to do such demotion.
>>>>
>>>> Defined "N_CPU_MEM" nodemask for the nodes which have both CPU and memory in
>>>> order to distinguish with cpuless nodes (memory only, i.e. PMEM nodes) and
>>>> memoryless nodes (some architectures, i.e. Power, may have memoryless nodes).
>>>> Typically, memory allocation would happen on such nodes by default unless
>>>> cpuless nodes are specified explicitly, cpuless nodes would be just fallback
>>>> nodes, so they are also as known as "primary" nodes in this patchset.  With
>>>> two tier memory system (i.e. DRAM + PMEM), this sounds good enough to
>>>> demonstrate the promotion/demotion approach for now, and this looks more
>>>> architecture-independent.  But it may be better to construct such node mask
>>>> by reading hardware information (i.e. HMAT), particularly for more complex
>>>> memory hierarchy.
>>> I still believe you are overcomplicating this without a strong reason.
>>> Why cannot we start simple and build from there? In other words I do not
>>> think we really need anything like N_CPU_MEM at all.
>> In this patchset N_CPU_MEM is used to tell us what nodes are cpuless nodes.
>> They would be the preferred demotion target.  Of course, we could rely on
>> firmware to just demote to the next best node, but it may be a "preferred"
>> node, if so I don't see too much benefit achieved by demotion. Am I missing
>> anything?
> Why cannot we simply demote in the proximity order? Why do you make
> cpuless nodes so special? If other close nodes are vacant then just use
> them.

We could. But, this raises another question, would we prefer to just 
demote to the next fallback node (just try once), if it is contended, 
then just swap (i.e. DRAM0 -> PMEM0 -> Swap); or would we prefer to try 
all the nodes in the fallback order to find the first less contended one 
(i.e. DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?


|------|     |------| |------|        |------|
|PMEM0|---|DRAM0| --- CPU0 --- CPU1 --- |DRAM1| --- |PMEM1|
|------|     |------| |------|       |------|

The first one sounds simpler, and the current implementation does so and 
this needs find out the closest PMEM node by recognizing cpuless node.

If we prefer go with the second option, it is definitely unnecessary to 
specialize any node.

>   
>>> I would expect that the very first attempt wouldn't do much more than
>>> migrate to-be-reclaimed pages (without an explicit binding) with a
>> Do you mean respect mempolicy or cpuset when doing demotion? I was wondering
>> this, but I didn't do so in the current implementation since it may need
>> walk the rmap to retrieve the mempolicy in the reclaim path. Is there any
>> easier way to do so?
> You definitely have to follow policy. You cannot demote to a node which
> is outside of the cpuset/mempolicy because you are breaking contract
> expected by the userspace. That implies doing a rmap walk.

OK, however, this may prevent from demoting unmapped page cache since 
there is no way to find those pages' policy.

And, we have to think about what we should do when the demotion target 
has conflict with the mempolicy. The easiest way is to just skip those 
conflict pages in demotion. Or we may have to do the demotion one page 
by one page instead of migrating a list of pages.

>
>>> I would also not touch the numa balancing logic at this stage and rather
>>> see how the current implementation behaves.
>> I agree we would prefer start from something simpler and see how it works.
>>
>> The "twice access" optimization is aimed to reduce the PMEM bandwidth burden
>> since the bandwidth of PMEM is scarce resource. I did compare "twice access"
>> to "no twice access", it does save a lot bandwidth for some once-off access
>> pattern. For example, when running stress test with mmtest's
>> usemem-stress-numa-compact. The kernel would promote ~600,000 pages with
>> "twice access" in 4 hours, but it would promote ~80,000,000 pages without
>> "twice access".
> I pressume this is a result of a synthetic workload, right? Or do you
> have any numbers for a real life usecase?

The test just uses usemem.


