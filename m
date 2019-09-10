Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD32820872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfIJKlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:41:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfIJKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:41:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F8E7C44C905677AE275;
        Tue, 10 Sep 2019 18:41:27 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 18:41:19 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Michal Hocko <mhocko@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <linuxarm@huawei.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909185035.GC2063@dhcp22.suse.cz>
 <07576292-e129-5949-6a2e-45fff067ca5a@huawei.com>
 <20190910072425.GI2063@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <434aff9a-2acb-73d7-83fa-43d5494471c0@huawei.com>
Date:   Tue, 10 Sep 2019 18:40:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190910072425.GI2063@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 15:24, Michal Hocko wrote:
> Our emails crossed, sorry about that.
> 
> On Tue 10-09-19 15:08:20, Yunsheng Lin wrote:
>> On 2019/9/10 2:50, Michal Hocko wrote:
>>> On Mon 09-09-19 14:04:23, Yunsheng Lin wrote:
> [...]
>>>> Even if a device's numa node is not specified, the device really
>>>> does belong to a node.
>>>
>>> What does this mean?
>>
>> It means some one need to guess the node id if the node is not
>> specified.
> 
> I have asked about this in other email so let's not cross the
> communication even more.

I may just answer your question here.

Besides the page allocator, cpu allocator or scheduler may need to
know about the node id to figure out which cpu to run is more
optimized, like in workqueue_select_cpu_near().


>  
>>>> This patch sets the device node to node 0 in device_add() if the
>>>> device's node id is not specified and it either has no parent
>>>> device, or the parent device also does not have a valid node id.
>>>
>>> Why is node 0 special? I have seen platforms with node 0 missing or
>>> being memory less. The changelog also lacks an actual problem
>>
>> by node 0 missing, how do we know if node 0 is missing?
>> by node_online(0)?
> 
> No, this is a dynamic situation. Node might get offline via hotremove.
> In most cases it wouldn't because there will likely be some kernel
> memory on node0 but you cannot really make any assumptions here. Besides
> that nothing should really care.

From the node checking:
'(unsigned)node_id >= nr_node_ids'

If the nr_node_ids > 0, then node 0 is a valid node according to
the above checking, is there a function to check if a node is
missing?

Also, I am not sure if I understand "nothing should really care".
Does it means a device still can be a numa that is missing, just
have some performance degradation?

> 
>>> descripton. Why do we even care about NUMA_NO_NODE? E.g. the page
>>> allocator interprets NUMA_NO_NODE as the closest node with a memory.
>>> And by closest it really means to the CPU which is performing the
>>> allocation.
>>
>> Yes, I should have mentioned that in the commit log.
>>
>> I mentioned the below in the RFC, but somehow deleted when sending
>> V1:
>> "There may be explicit handling out there relying on NUMA_NO_NODE,
>> like in nvme_probe()."
> 
> This code, and other doing similar things, is very likely bogus. Just
> look at what the code does. It takes the node affinity from the dev and
> uses it for an allocation. So far so good. But it tries to be clever
> and special cases NUMA_NO_NODE to be first_node. So now the allocator
> has used a proper fallback to the nearest node with memory for the
> current CPU that is executing the code while dev will point to a
> first_node which might be a completely different one. See the
> discrepancy?

Do you mean let kzalloc_node handle the NUMA_NO_NODE case, if node
id is NUMA_NO_NODE, kzalloc_node handles it as numa_mem_id().

If yes, above makes more sense.

> 

