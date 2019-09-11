Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D41ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F121928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIKHXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:23:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfIKHXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:23:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76821790CCCDCFF3A76D;
        Wed, 11 Sep 2019 15:23:49 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 15:23:41 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Michal Hocko <mhocko@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <linuxarm@huawei.com>
References: <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
 <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz> <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz> <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
Date:   Wed, 11 Sep 2019 15:22:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190911064926.GJ4023@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/11 14:49, Michal Hocko wrote:
> On Wed 11-09-19 14:15:51, Yunsheng Lin wrote:
>> On 2019/9/11 13:33, Michal Hocko wrote:
>>> On Tue 10-09-19 14:53:39, Michal Hocko wrote:
>>>> On Tue 10-09-19 20:47:40, Yunsheng Lin wrote:
>>>>> On 2019/9/10 19:12, Greg KH wrote:
>>>>>> On Tue, Sep 10, 2019 at 01:04:51PM +0200, Michal Hocko wrote:
>>>>>>> On Tue 10-09-19 18:58:05, Yunsheng Lin wrote:
>>>>>>>> On 2019/9/10 17:31, Greg KH wrote:
>>>>>>>>> On Tue, Sep 10, 2019 at 02:43:32PM +0800, Yunsheng Lin wrote:
>>>>>>>>>> On 2019/9/9 17:53, Greg KH wrote:
>>>>>>>>>>> On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
>>>>>>>>>>>> Currently a device does not belong to any of the numa nodes
>>>>>>>>>>>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
>>>>>>>>>>>> specified by fw nor by virtual device layer and the device has
>>>>>>>>>>>> no parent device.
>>>>>>>>>>>
>>>>>>>>>>> Is this really a problem?
>>>>>>>>>>
>>>>>>>>>> Not really.
>>>>>>>>>> Someone need to guess the node id when it is not specified, right?
>>>>>>>>>
>>>>>>>>> No, why?  Guessing guarantees you will get it wrong on some systems.
>>>>>>>>>
>>>>>>>>> Are you seeing real problems because the id is not being set?  What
>>>>>>>>> problem is this fixing that you can actually observe?
>>>>>>>>
>>>>>>>> When passing the return value of dev_to_node() to cpumask_of_node()
>>>>>>>> without checking the node id if the node id is not valid, there is
>>>>>>>> global-out-of-bounds detected by KASAN as below:
>>>>>>>
>>>>>>> OK, I seem to remember this being brought up already. And now when I
>>>>>>> think about it, we really want to make cpumask_of_node NUMA_NO_NODE
>>>>>>> aware. That means using the same trick the allocator does for this
>>>>>>> special case.
>>>>>>
>>>>>> That seems reasonable to me, and much more "obvious" as to what is going
>>>>>> on.
>>>>>>
>>>>>
>>>>> Ok, thanks for the suggestion.
>>>>>
>>>>> For arm64 and x86, there are two versions of cpumask_of_node().
>>>>>
>>>>> when CONFIG_DEBUG_PER_CPU_MAPS is defined, the cpumask_of_node()
>>>>>    in arch/x86/mm/numa.c is used, which does partial node id checking:
>>>>>
>>>>> const struct cpumask *cpumask_of_node(int node)
>>>>> {
>>>>>         if (node >= nr_node_ids) {
>>>>>                 printk(KERN_WARNING
>>>>>                         "cpumask_of_node(%d): node > nr_node_ids(%u)\n",
>>>>>                         node, nr_node_ids);
>>>>>                 dump_stack();
>>>>>                 return cpu_none_mask;
>>>>>         }
>>>>>         if (node_to_cpumask_map[node] == NULL) {
>>>>>                 printk(KERN_WARNING
>>>>>                         "cpumask_of_node(%d): no node_to_cpumask_map!\n",
>>>>>                         node);
>>>>>                 dump_stack();
>>>>>                 return cpu_online_mask;
>>>>>         }
>>>>>         return node_to_cpumask_map[node];
>>>>> }
>>>>>
>>>>> when CONFIG_DEBUG_PER_CPU_MAPS is undefined, the cpumask_of_node()
>>>>>    in arch/x86/include/asm/topology.h is used:
>>>>>
>>>>> static inline const struct cpumask *cpumask_of_node(int node)
>>>>> {
>>>>>         return node_to_cpumask_map[node];
>>>>> }
>>>>
>>>> I would simply go with. There shouldn't be any need for heavy weight
>>>> checks that CONFIG_DEBUG_PER_CPU_MAPS has.
>>>>
>>>> static inline const struct cpumask *cpumask_of_node(int node)
>>>> {
>>>> 	/* A nice comment goes here */
>>>> 	if (node == NUMA_NO_NODE)
>>
>> How about "(unsigned int)node >= nr_node_ids", this is suggested
>> by Peter, it checks the case where the node id set by fw is bigger
>> or equal than nr_node_ids, and still handle the < 0 case, which
>> includes NUMA_NO_NODE.
> 
> Isn't that a plain bug? Is something like that really happening?

I have not seen one happened before except the NUMA_NO_NODE case.
Even with NUMA_NO_NODE case, we did not see it until we turn on
the KASAN detection.

It seems that there is no protection that prevent setting the node
of device to an invalid node.
And the kernel does have a few different check now:
1) some does " < 0" check;
2) some does "== NUMA_NO_NODE" check;
3) some does ">= MAX_NUMNODES" check;
4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.

We need to be consistent about the checking, right?

