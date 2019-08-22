Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8866C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F3233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfHVNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:41:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48885 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbfHVNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:41:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ta8JkQz_1566481288;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Ta8JkQz_1566481288)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Aug 2019 21:41:29 +0800
Subject: Re: [PATCH v3 3/3] vfio_pci: make use of update_irq_devid and
 optimize irq ops
To:     "Liu, Jiang" <gerry@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
References: <cover.1565857737.git.luoben@linux.alibaba.com>
 <f8838cf037055351d677e628f169cb21c6a76f02.1565857737.git.luoben@linux.alibaba.com>
 <alpine.DEB.2.21.1908151833010.1908@nanos.tec.linutronix.de>
 <7a3606ad-8fa6-45d5-b5a4-ee3f07893a25@linux.alibaba.com>
 <FA3946E3-BAC5-4C3B-9409-83C5C64FB96F@linux.alibaba.com>
From:   luoben <luoben@linux.alibaba.com>
Message-ID: <fc7ce2e7-dd5d-d78d-9064-93225d14139f@linux.alibaba.com>
Date:   Thu, 22 Aug 2019 21:41:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <FA3946E3-BAC5-4C3B-9409-83C5C64FB96F@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/20 下午11:27, Liu, Jiang 写道:
>
>> On Aug 20, 2019, at 11:24 PM, luoben <luoben@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2019/8/16 上午12:45, Thomas Gleixner 写道:
>>> On Thu, 15 Aug 2019, Ben Luo wrote:
>>>
>>>>   	if (vdev->ctx[vector].trigger) {
>>>> -		free_irq(irq, vdev->ctx[vector].trigger);
>>>> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>>> -		kfree(vdev->ctx[vector].name);
>>>> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
>>>> -		vdev->ctx[vector].trigger = NULL;
>>>> +		if (vdev->ctx[vector].trigger == trigger) {
>>>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>>>
>>> What's the point of unregistering the producer, just to register it again below?
>> Whether producer token changed or not, irq_bypass_register_producer() is a way (seems the
>>
>> only way) to update IRTE by VFIO for posted interrupt.
>>
>> When posted interrupt is in use, the target IRTE will be used by IOMMU directly to find the
>>
>> target CPU for an interrupt posted to VM, since hypervisor is bypassed.
>>
>> irq_bypass_register_producer() will modify IRTE based on the information retrieved from KVM,
>>
>>
>> 0xffffffff8150a920 : modify_irte+0x0/0x180 [kernel]
>> 0xffffffff8150ab94 : intel_ir_set_vcpu_affinity+0xf4/0x150 [kernel]
>> 0xffffffff81125f3c : irq_set_vcpu_affinity+0x5c/0xa0 [kernel]
>> 0xffffffffa0550818 : vmx_update_pi_irte+0x178/0x290 [kvm_intel]    // get pi_desc etc. from KVM
>> 0xffffffffa052b789 : kvm_arch_irq_bypass_add_producer+0x39/0x50 [kvm_intel] (inexact)
>> 0xffffffffa024a50b : __connect+0x7b/0xa0 [kvm] (inexact)
>> 0xffffffffa024a6a8 : irq_bypass_register_producer+0x108/0x140 [kvm] (inexact)
>> 0xffffffffa0338386 : vfio_msi_set_vector_signal+0x1b6/0x2c0 [vfio_pci] (inexact)
>>>> +		} else if (trigger) {
>>>> +			ret = update_irq_devid(irq,
>>>> +					vdev->ctx[vector].trigger, trigger);
>>>> +			if (unlikely(ret)) {
>>>> +				dev_info(&pdev->dev,
>>>> +					 "update_irq_devid %d (token %p) fails: %d\n",
>>>>
>>> s/fails/failed/
>>>
>>>
>>>> +					 irq, vdev->ctx[vector].trigger, ret);
>>>> +				eventfd_ctx_put(trigger);
>>>> +				return ret;
>>>> +			}
>>>>
>>> This lacks any form of comment why this is correct. dev_id is updated and
>>> the producer with the old token is still registered.
>>>
>> ok, I will add comment like below:
>>
>> For KVM-VFIO case, once producer and consumer connected successfully, interrupt from passthrough
>>
>> device will be directly delivered to VM instead of triggering interrupt process in HOST. If producer and
>>
>> consumer are disconnected, this interrupt process will fall back to remap mode, the handler vfio_msihandler()
>>
>> registered in corresponding irqaction will use the dev_id to find the right way to deliver the interrupt to VM.
>>
>> So, it is safe to update dev_id before unregistration of irq-bypass producer, i.e. switch back from posted
>>
>> mode to remap mode, since only in remap mode the 'dev_id' will be used by interrupt handler. To producer
>>
>> and consumer, dev_id is only a token for pairing them togather.
>>>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>>>
>>> Now it's unregistered.
>>>
>>>
>>>> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
>>>> +			vdev->ctx[vector].producer.token = trigger;
>>>>
>>> The token is updated and then it's newly registered below.
>>>
>>>
>>>> +			vdev->ctx[vector].trigger = trigger;
>>>> -	vdev->ctx[vector].producer.token = trigger;
>>>> -	vdev->ctx[vector].producer.irq = irq;
>>>> +	/* always update irte for posted mode */
>>>>   	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>>>>   	if (unlikely(ret))
>>>>   		dev_info(&pdev->dev,
>>>>   		"irq bypass producer (token %p) registration fails: %d\n",
>>>>   		vdev->ctx[vector].producer.token, ret);
>>>>
>>> I know this code already existed, but again this looks inconsistent. If the
>>> registration fails then a subsequent update will try to unregister a not
>>> registered producer. Does not make any sense to me.
>>>
>> irq_bypass_register_producer() also fails on duplicated registration, so maybe an unconditional try to
>>
>> unregistration is a easy way to keep consistent.
>>
>> Maybe it's better to change these function names to irq_bypass_try_register_producer() and
>>
>> irq_bypass_try_unregister_producer()  :)
>>
>>
> Hi Ben,
> 	The point is that we shouldn’t blindly try to register again  if we fails to unregister a posted interrupt producer. By this way, the fast path (posted interrupt) may get disabled, but it’s safer than blindly ignoring the failure of ungistration.
> Thanks,
> Gerry

This may need another patchset to enhance the irq_bypass 
register/unregister functions first, at least to return some error code 
when irq_bypass_try_unregister_producer() fails. I would like to have a 
try later.

Thanks,

     Ben

