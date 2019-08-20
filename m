Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2256C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1C922CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfHTP1r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:27:47 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40299 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:27:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ta-wyV7_1566314832;
Received: from 127.0.0.1(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0Ta-wyV7_1566314832)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 23:27:15 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 3/3] vfio_pci: make use of update_irq_devid and
 optimize irq ops
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <7a3606ad-8fa6-45d5-b5a4-ee3f07893a25@linux.alibaba.com>
Date:   Tue, 20 Aug 2019 23:27:11 +0800
Cc:     Thomas Gleixner <tglx@linutronix.de>, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Content-Transfer-Encoding: 8BIT
Message-Id: <FA3946E3-BAC5-4C3B-9409-83C5C64FB96F@linux.alibaba.com>
References: <cover.1565857737.git.luoben@linux.alibaba.com>
 <f8838cf037055351d677e628f169cb21c6a76f02.1565857737.git.luoben@linux.alibaba.com>
 <alpine.DEB.2.21.1908151833010.1908@nanos.tec.linutronix.de>
 <7a3606ad-8fa6-45d5-b5a4-ee3f07893a25@linux.alibaba.com>
To:     luoben <luoben@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2019, at 11:24 PM, luoben <luoben@linux.alibaba.com> wrote:
> 
> 
> 
> 在 2019/8/16 上午12:45, Thomas Gleixner 写道:
>> On Thu, 15 Aug 2019, Ben Luo wrote:
>> 
>>>  	if (vdev->ctx[vector].trigger) {
>>> -		free_irq(irq, vdev->ctx[vector].trigger);
>>> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>> -		kfree(vdev->ctx[vector].name);
>>> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
>>> -		vdev->ctx[vector].trigger = NULL;
>>> +		if (vdev->ctx[vector].trigger == trigger) {
>>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>> 
>> What's the point of unregistering the producer, just to register it again below?
> Whether producer token changed or not, irq_bypass_register_producer() is a way (seems the
> 
> only way) to update IRTE by VFIO for posted interrupt.
> 
> When posted interrupt is in use, the target IRTE will be used by IOMMU directly to find the
> 
> target CPU for an interrupt posted to VM, since hypervisor is bypassed.
> 
> irq_bypass_register_producer() will modify IRTE based on the information retrieved from KVM,
> 
> 
> 0xffffffff8150a920 : modify_irte+0x0/0x180 [kernel]
> 0xffffffff8150ab94 : intel_ir_set_vcpu_affinity+0xf4/0x150 [kernel]
> 0xffffffff81125f3c : irq_set_vcpu_affinity+0x5c/0xa0 [kernel]
> 0xffffffffa0550818 : vmx_update_pi_irte+0x178/0x290 [kvm_intel]    // get pi_desc etc. from KVM
> 0xffffffffa052b789 : kvm_arch_irq_bypass_add_producer+0x39/0x50 [kvm_intel] (inexact)
> 0xffffffffa024a50b : __connect+0x7b/0xa0 [kvm] (inexact)
> 0xffffffffa024a6a8 : irq_bypass_register_producer+0x108/0x140 [kvm] (inexact)
> 0xffffffffa0338386 : vfio_msi_set_vector_signal+0x1b6/0x2c0 [vfio_pci] (inexact)
>> 
>>> +		} else if (trigger) {
>>> +			ret = update_irq_devid(irq,
>>> +					vdev->ctx[vector].trigger, trigger);
>>> +			if (unlikely(ret)) {
>>> +				dev_info(&pdev->dev,
>>> +					 "update_irq_devid %d (token %p) fails: %d\n",
>>> 
>> s/fails/failed/
>> 
>> 
>>> +					 irq, vdev->ctx[vector].trigger, ret);
>>> +				eventfd_ctx_put(trigger);
>>> +				return ret;
>>> +			}
>>> 
>> This lacks any form of comment why this is correct. dev_id is updated and
>> the producer with the old token is still registered.
>> 
> ok, I will add comment like below:
> 
> For KVM-VFIO case, once producer and consumer connected successfully, interrupt from passthrough
> 
> device will be directly delivered to VM instead of triggering interrupt process in HOST. If producer and
> 
> consumer are disconnected, this interrupt process will fall back to remap mode, the handler vfio_msihandler()
> 
> registered in corresponding irqaction will use the dev_id to find the right way to deliver the interrupt to VM.
> 
> So, it is safe to update dev_id before unregistration of irq-bypass producer, i.e. switch back from posted
> 
> mode to remap mode, since only in remap mode the 'dev_id' will be used by interrupt handler. To producer
> 
> and consumer, dev_id is only a token for pairing them togather.
>> 
>>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>>> 
>> Now it's unregistered.
>> 
>> 
>>> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
>>> +			vdev->ctx[vector].producer.token = trigger;
>>> 
>> The token is updated and then it's newly registered below.
>> 
>> 
>>> +			vdev->ctx[vector].trigger = trigger;
>>> -	vdev->ctx[vector].producer.token = trigger;
>>> -	vdev->ctx[vector].producer.irq = irq;
>>> +	/* always update irte for posted mode */
>>>  	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>>>  	if (unlikely(ret))
>>>  		dev_info(&pdev->dev,
>>>  		"irq bypass producer (token %p) registration fails: %d\n",
>>>  		vdev->ctx[vector].producer.token, ret);
>>> 
>> I know this code already existed, but again this looks inconsistent. If the
>> registration fails then a subsequent update will try to unregister a not
>> registered producer. Does not make any sense to me.
>> 
> irq_bypass_register_producer() also fails on duplicated registration, so maybe an unconditional try to
> 
> unregistration is a easy way to keep consistent. 
> 
> Maybe it's better to change these function names to irq_bypass_try_register_producer() and
> 
> irq_bypass_try_unregister_producer()  :)
> 
> 
Hi Ben,
	The point is that we shouldn’t blindly try to register again  if we fails to unregister a posted interrupt producer. By this way, the fast path (posted interrupt) may get disabled, but it’s safer than blindly ignoring the failure of ungistration.
Thanks,
Gerry 
> 
> Thanks,
> 
>     Ben

