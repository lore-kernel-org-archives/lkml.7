Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07215C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D932084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfIFIWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:22:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfIFIWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:22:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA31868B9DD1DF7BB3BC;
        Fri,  6 Sep 2019 16:22:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 16:22:40 +0800
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
 <5a188e2b-6c07-a9db-fbaa-561e9362d3ba@huawei.com>
 <20190906065211.GA18823@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <26d7a539-96fc-8a92-d60d-7e76e418ab63@huawei.com>
Date:   Fri, 6 Sep 2019 16:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190906065211.GA18823@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/6 14:52, Greg KH wrote:
> On Fri, Sep 06, 2019 at 02:41:36PM +0800, Yunsheng Lin wrote:
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
>>>
>>> Anyway, if you make this change, how many machines start reporting this
>>> error? 
>>
>> Any machines with more than one numa node will start reporting this error.
>>
>> 1) many virtual deivces maybe do not set the node id before calling
>>    device_register(), such as vfio, tun, etc.
>>
>> 2) struct cpu has a dev, but does not set the dev' node according to
>>    cpu_to_node().
>>
>> 3) Many platform Device also do not have a node id provided by FW.
> 
> Then this patch is not ok, as you are flooding the kernel log saying the
> system is "broken" when this is just what it always has been like.  How
> is anyone going to "fix" things?

cpu->node_id does not seem to be used, maybe we can fix the cpu device:

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index cc37511d..ad0a841 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -41,7 +41,7 @@ static void change_cpu_under_node(struct cpu *cpu,
        int cpuid = cpu->dev.id;
        unregister_cpu_under_node(cpuid, from_nid);
        register_cpu_under_node(cpuid, to_nid);
-       cpu->node_id = to_nid;
+       set_dev_node(&cpu->dev, to_nid);
 }

 static int cpu_subsys_online(struct device *dev)
@@ -367,7 +367,7 @@ int register_cpu(struct cpu *cpu, int num)
 {
        int error;

-       cpu->node_id = cpu_to_node(num);
+       set_dev_node(&cpu->dev, cpu_to_node(num));
        memset(&cpu->dev, 0x00, sizeof(struct device));
        cpu->dev.id = num;
        cpu->dev.bus = &cpu_subsys;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fcb1386..9a6fc51 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -24,7 +24,6 @@ struct device_node;
 struct attribute_group;

 struct cpu {
-       int node_id;            /* The node which contains the CPU */
        int hotpluggable;       /* creates sysfs control file if hotpluggable */
        struct device dev;
 };


> 
> You can adjust the default node to 0 as isn't that what always has
> happened, but you can not claim it is a "error" that this is happening
> because it is not an error, it's just the default operation.

You are right, will remove the error log.

