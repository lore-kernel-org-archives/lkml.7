Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbfIJMtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:49:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729140AbfIJMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:49:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 13F489C46136409020B5;
        Tue, 10 Sep 2019 20:48:58 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 20:48:48 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@kernel.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <linuxarm@huawei.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz> <20190910111252.GA8970@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
Date:   Tue, 10 Sep 2019 20:47:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190910111252.GA8970@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 19:12, Greg KH wrote:
> On Tue, Sep 10, 2019 at 01:04:51PM +0200, Michal Hocko wrote:
>> On Tue 10-09-19 18:58:05, Yunsheng Lin wrote:
>>> On 2019/9/10 17:31, Greg KH wrote:
>>>> On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
>>>>> On 2019/9/9 17:53, Greg KH wrote:
>>>>>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
>>>>>>> Currently a device does not belong to any of the numa nodes
>>>>>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
>>>>>>> specified by fw nor by virtual device layer and the device has
>>>>>>> no parent device.
>>>>>>
>>>>>> Is this really a problem?
>>>>>
>>>>> Not really.
>>>>> Someone need to guess the node id when it is not specified, right?
>>>>
>>>> No, why?  Guessing guarantees you will get it wrong on some systems.
>>>>
>>>> Are you seeing real problems because the id is not being set?  What
>>>> problem is this fixing that you can actually observe?
>>>
>>> When passing the return value of dev_to_node() to cpumask_of_node()
>>> without checking the node id if the node id is not valid, there is
>>> global-out-of-bounds detected by KASAN as below:
>>
>> OK, I seem to remember this being brought up already. And now when I
>> think about it, we really want to make cpumask_of_node NUMA_NO_NODE
>> aware. That means using the same trick the allocator does for this
>> special case.
> 
> That seems reasonable to me, and much more "obvious" as to what is going
> on.
> 

Ok, thanks for the suggestion.

For arm64 and x86, there are two versions of cpumask_of_node().

when CONFIG_DEBUG_PER_CPU_MAPS is defined, the cpumask_of_node()
   in arch/x86/mm/numa.c is used, which does partial node id checking:

const struct cpumask *cpumask_of_node(int node)
{
        if (node >= nr_node_ids) {
                printk(KERN_WARNING
                        "cpumask_of_node(%d): node > nr_node_ids(%u)\n",
                        node, nr_node_ids);
                dump_stack();
                return cpu_none_mask;
        }
        if (node_to_cpumask_map[node] == NULL) {
                printk(KERN_WARNING
                        "cpumask_of_node(%d): no node_to_cpumask_map!\n",
                        node);
                dump_stack();
                return cpu_online_mask;
        }
        return node_to_cpumask_map[node];
}

when CONFIG_DEBUG_PER_CPU_MAPS is undefined, the cpumask_of_node()
   in arch/x86/include/asm/topology.h is used:

static inline const struct cpumask *cpumask_of_node(int node)
{
        return node_to_cpumask_map[node];
}

As discussion in [1], adding the checking in cpumask_of_node() with
CONFIG_DEBUG_PER_CPU_MAPS not defined increases overhead for everyone,
and it is already true that cpumask_of_node() requires a valid node_id.

So maybe the overhead is worth it?

Hi, Peter
	Does the argument in this thread about making cpumask_of_node()
NUMA_NO_NODE aware make sense to you?

[1] https://lore.kernel.org/patchwork/patch/1122516/


