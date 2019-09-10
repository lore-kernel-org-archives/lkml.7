Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE25521019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406563AbfIJHJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:09:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729707AbfIJHJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:09:37 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1DAC3C5B758C0C66B5EB;
        Tue, 10 Sep 2019 15:09:36 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 15:09:26 +0800
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
To:     Michal Hocko <mhocko@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <linuxarm@huawei.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909185035.GC2063@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <07576292-e129-5949-6a2e-45fff067ca5a@huawei.com>
Date:   Tue, 10 Sep 2019 15:08:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190909185035.GC2063@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 2:50, Michal Hocko wrote:
> On Mon 09-09-19 14:04:23, Yunsheng Lin wrote:
>> Currently a device does not belong to any of the numa nodes
>> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
>> specified by fw nor by virtual device layer and the device has
>> no parent device.
>>
>> According to discussion in [1]:
> 
> Please do not reference important parts of the justification via a link.
> Just quote the relevant part to the changelog. It is just too easy that
> external links die - not to mention lkml.org.

Ok

> 
>> Even if a device's numa node is not specified, the device really
>> does belong to a node.
> 
> What does this mean?

It means some one need to guess the node id if the node is not
specified.

> 
>> This patch sets the device node to node 0 in device_add() if the
>> device's node id is not specified and it either has no parent
>> device, or the parent device also does not have a valid node id.
> 
> Why is node 0 special? I have seen platforms with node 0 missing or
> being memory less. The changelog also lacks an actual problem

by node 0 missing, how do we know if node 0 is missing?
by node_online(0)?

> descripton. Why do we even care about NUMA_NO_NODE? E.g. the page
> allocator interprets NUMA_NO_NODE as the closest node with a memory.
> And by closest it really means to the CPU which is performing the
> allocation.

Yes, I should have mentioned that in the commit log.

I mentioned the below in the RFC, but somehow deleted when sending
V1:
"There may be explicit handling out there relying on NUMA_NO_NODE,
like in nvme_probe()."

>  
>> [1] https://lkml.org/lkml/2019/9/2/466
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>> Changelog RFC -> v1:
>> 1. Drop log error message and use a "if" instead of "? :".
>> 2. Drop the RFC tag.
>> ---
>>  drivers/base/core.c  | 10 +++++++---
>>  include/linux/numa.h |  2 ++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 1669d41..f79ad20 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2107,9 +2107,13 @@ int device_add(struct device *dev)
>>  	if (kobj)
>>  		dev->kobj.parent = kobj;
>>  
>> -	/* use parent numa_node */
>> -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
>> -		set_dev_node(dev, dev_to_node(parent));
>> +	/* use parent numa_node or default node 0 */
>> +	if (!numa_node_valid(dev_to_node(dev))) {
>> +		if (parent && numa_node_valid(dev_to_node(parent)))
>> +			set_dev_node(dev, dev_to_node(parent));
>> +		else
>> +			set_dev_node(dev, 0);
>> +	}
>>  
>>  	/* first, register with generic layer. */
>>  	/* we require the name to be set before, and pass NULL */
>> diff --git a/include/linux/numa.h b/include/linux/numa.h
>> index 110b0e5..eccc757 100644
>> --- a/include/linux/numa.h
>> +++ b/include/linux/numa.h
>> @@ -13,4 +13,6 @@
>>  
>>  #define	NUMA_NO_NODE	(-1)
>>  
>> +#define numa_node_valid(node)	((unsigned int)(node) < nr_node_ids)
>> +
>>  #endif /* _LINUX_NUMA_H */
>> -- 
>> 2.8.1
> 

