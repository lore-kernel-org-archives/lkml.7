Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28D1206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfC1CJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:09:20 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24484 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfC1CJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:09:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TNol2eC_1553738950;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNol2eC_1553738950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Mar 2019 10:09:17 +0800
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
 <20190327193918.GP11927@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
Date:   Wed, 27 Mar 2019 19:09:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327193918.GP11927@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/19 1:09 PM, Michal Hocko wrote:
> On Wed 27-03-19 11:59:28, Yang Shi wrote:
>>
>> On 3/27/19 10:34 AM, Dan Williams wrote:
>>> On Wed, Mar 27, 2019 at 2:01 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>> On Tue 26-03-19 19:58:56, Yang Shi wrote:
> [...]
>>>>> It is still NUMA, users still can see all the NUMA nodes.
>>>> No, Linux NUMA implementation makes all numa nodes available by default
>>>> and provides an API to opt-in for more fine tuning. What you are
>>>> suggesting goes against that semantic and I am asking why. How is pmem
>>>> NUMA node any different from any any other distant node in principle?
>>> Agree. It's just another NUMA node and shouldn't be special cased.
>>> Userspace policy can choose to avoid it, but typical node distance
>>> preference should otherwise let the kernel fall back to it as
>>> additional memory pressure relief for "near" memory.
>> In ideal case, yes, I agree. However, in real life world the performance is
>> a concern. It is well-known that PMEM (not considering NVDIMM-F or HBM) has
>> higher latency and lower bandwidth. We observed much higher latency on PMEM
>> than DRAM with multi threads.
> One rule of thumb is: Do not design user visible interfaces based on the
> contemporary technology and its up/down sides. This will almost always
> fire back.

Thanks. It does make sense to me.

>
> Btw. if you keep arguing about performance without any numbers. Can you
> present something specific?

Yes, I did have some numbers. We did simple memory sequential rw latency 
test with a designed-in-house test program on PMEM (bind to PMEM) and 
DRAM (bind to DRAM). When running with 20 threads the result is as below:

              Threads          w/lat            r/lat
PMEM      20                537.15         68.06
DRAM      20                14.19           6.47

And, sysbench test with command: sysbench --time=600 memory 
--memory-block-size=8G --memory-total-size=1024T --memory-scope=global 
--memory-oper=read --memory-access-mode=rnd --rand-type=gaussian 
--rand-pareto-h=0.1 --threads=1 run

The result is:
                    lat/ms
PMEM      103766.09
DRAM      31946.30

>
>> In real production environment we don't know what kind of applications would
>> end up on PMEM (DRAM may be full, allocation fall back to PMEM) then have
>> unexpected performance degradation. I understand to have mempolicy to choose
>> to avoid it. But, there might be hundreds or thousands of applications
>> running on the machine, it sounds not that feasible to me to have each
>> single application set mempolicy to avoid it.
> we have cpuset cgroup controller to help here.
>
>> So, I think we still need a default allocation node mask. The default value
>> may include all nodes or just DRAM nodes. But, they should be able to be
>> override by user globally, not only per process basis.
>>
>> Due to the performance disparity, currently our usecases treat PMEM as
>> second tier memory for demoting cold page or binding to not memory access
>> sensitive applications (this is the reason for inventing a new mempolicy)
>> although it is a NUMA node.
> If the performance sucks that badly then do not use the pmem as NUMA,
> really. There are certainly other ways to export the pmem storage. Use
> it as a fast swap storage. Or try to work on a swap caching mechanism
> that still allows much faster access than a slow swap storage. But do
> not try to pretend to abuse the NUMA interface while you are breaking
> some of its long term established semantics.

Yes, we are looking into using it as a fast swap storage too and perhaps 
other usecases.

Anyway, though nobody thought it makes sense to restrict default 
allocation nodes, it sounds over-engineered. I'm going to drop it.

One question, when doing demote and promote we need define a path, for 
example, DRAM <-> PMEM (assume two tier memory). When determining what 
nodes are "DRAM" nodes, does it make sense to assume the nodes with both 
cpu and memory are DRAM nodes since PMEM nodes are typically cpuless nodes?

Thanks,
Yang


