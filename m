Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95755C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766C321848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfIEJId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:08:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732160AbfIEJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:08:33 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA81243F6A79C6D72018;
        Thu,  5 Sep 2019 17:08:31 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 17:08:22 +0800
Subject: Re: [PATCH RFC] driver core: ensure a device has valid node id in
 device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <mhocko@kernel.org>,
        <linuxarm@huawei.com>
References: <1567647230-166903-1-git-send-email-linyunsheng@huawei.com>
 <20190905055727.GB23826@kroah.com>
 <e5905af2-5a8d-7b00-d2a6-a961f3eee120@huawei.com>
 <20190905073334.GA29933@kroah.com>
 <d282774f-29fb-cffb-d606-ab678f792565@huawei.com>
 <20190905090249.GA28356@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ccf18baf-096d-b78d-4d5b-bfb8bcd35ba9@huawei.com>
Date:   Thu, 5 Sep 2019 17:07:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190905090249.GA28356@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/5 17:02, Greg KH wrote:
> On Thu, Sep 05, 2019 at 04:57:00PM +0800, Yunsheng Lin wrote:
>> On 2019/9/5 15:33, Greg KH wrote:
>>> On Thu, Sep 05, 2019 at 02:48:24PM +0800, Yunsheng Lin wrote:
>>>> On 2019/9/5 13:57, Greg KH wrote:
>>>>> On Thu, Sep 05, 2019 at 09:33:50AM +0800, Yunsheng Lin wrote:
>>>>>> Currently a device does not belong to any of the numa nodes
>>>>>> (dev->numa_node is NUMA_NO_NODE) when the FW does not provide
>>>>>> the node id and the device has not no parent device.
>>>>>>
>>>>>> According to discussion in [1]:
>>>>>> Even if a device's numa node is not set by fw, the device
>>>>>> really does belong to a node.
>>>>>>
>>>>>> This patch sets the device node to node 0 in device_add() if
>>>>>> the fw has not specified the node id and it either has no
>>>>>> parent device, or the parent device also does not have a valid
>>>>>> node id.
>>>>>>
>>>>>> There may be explicit handling out there relying on NUMA_NO_NODE,
>>>>>> like in nvme_probe().
>>>>>>
>>>>>> [1] https://lkml.org/lkml/2019/9/2/466
>>>>>>
>>>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>>>> ---
>>>>>>  drivers/base/core.c  | 17 ++++++++++++++---
>>>>>>  include/linux/numa.h |  2 ++
>>>>>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>>> index 1669d41..466b8ff 100644
>>>>>> --- a/drivers/base/core.c
>>>>>> +++ b/drivers/base/core.c
>>>>>> @@ -2107,9 +2107,20 @@ int device_add(struct device *dev)
>>>>>>  	if (kobj)
>>>>>>  		dev->kobj.parent = kobj;
>>>>>>  
>>>>>> -	/* use parent numa_node */
>>>>>> -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
>>>>>> -		set_dev_node(dev, dev_to_node(parent));
>>>>>> +	/* use parent numa_node or default node 0 */
>>>>>> +	if (!numa_node_valid(dev_to_node(dev))) {
>>>>>> +		int nid = parent ? dev_to_node(parent) : NUMA_NO_NODE;
>>>>>
>>>>> Can you expand this to be a "real" if statement please?
>>>>
>>>> Sure. May I ask why "? :" is not appropriate here?
>>>
>>> Because it is a pain to read, just spell it out and make it obvious what
>>> is happening.  You write code for developers first, and the compiler
>>> second, and in this case, either way is identical to the compiler.
>>>
>>>>>> +
>>>>>> +		if (numa_node_valid(nid)) {
>>>>>> +			set_dev_node(dev, nid);
>>>>>> +		} else {
>>>>>> +			if (nr_node_ids > 1U)
>>>>>> +				pr_err("device: '%s': has invalid NUMA node(%d)\n",
>>>>>> +				       dev_name(dev), dev_to_node(dev));
>>>>>
>>>>> dev_err() will show you the exact device properly, instead of having to
>>>>> rely on dev_name().
>>>>>
>>>>> And what is a user to do if this message happens?  How do they fix this?
>>>>> If they can not, what good is this error message?
>>>>
>>>> If user know about their system's topology well enough and node 0
>>>> is not the nearest node to the device, maybe user can readjust that by
>>>> writing the nearest node to /sys/class/pci_bus/XXXX/device/numa_node,
>>>> if not, then maybe user need to contact the vendor for info or updates.
>>>>
>>>> Maybe print error message as below:
>>>>
>>>> dev_err(dev, FW_BUG "has invalid NUMA node(%d). Readjust it by writing to sysfs numa_node or contact your vendor for updates.\n",
>>>> 	dev_to_node(dev));
>>>
>>> FW_BUG?
>>
>> The sysfs numa_node writing interface does print FW_BUG error.
>> Maybe it is a way of telling the user to contact the vendors, which
>> pushing the vendors to update the FW.
> 
> But is this always going to be caused by a firmware bug?  If so, ok, if
> not, and it's a driver/bus kernel issue, we should not say this.

Ok, Make sense. Will not add the FW_BUG printing.

> 
> thanks,
> 
> greg k-h
> 
> .
> 

