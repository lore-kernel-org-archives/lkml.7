Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE1EC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F7C2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfC2JUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:20:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbfC2JUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:20:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22D916E25BE330483374;
        Fri, 29 Mar 2019 17:20:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 29 Mar 2019
 17:19:52 +0800
Subject: Re: Unexpected interrupt received in Guest OS when booting after
 "system_reset"
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <e8ffbc4e-f7b7-14a1-7614-a3db85c9152f@huawei.com>
 <9a6ece7e-9984-dc9e-8fa2-df9736393dd2@arm.com>
 <9694b5f2-80bd-b85c-8fc5-bd1d917e1b33@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <2e8f8bfb-4ae2-5fc6-4022-222a8f44e1f6@huawei.com>
Date:   Fri, 29 Mar 2019 17:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9694b5f2-80bd-b85c-8fc5-bd1d917e1b33@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

The patch works. I tested for 1.5 hour and 52 VM resets. There were 16 times that a virtual LPI left in the ap_list (seen by an additional printk) during reset and we never saw "Unexpected interrupt received" any more.

Just a minor comment: how about replacing /vcpu->arch.vgic_cpu./ with /vgic_cpu->/ in the lock/unlock code line, to reduce some words?

Thanks,

Heyi

On 2019/3/29 9:19, Heyi Guo wrote:
>
>
> On 2019/3/29 1:18, Marc Zyngier wrote:
>> [Please do not send HTML emails]
> Sorry; will keep in mind next time :)
>>
>> On 28/03/2019 15:44, Heyi Guo wrote:
>>> Hi Marc and Christoffer,
>>>
>>> When we issue "system_reset" from qemu monitor to a running VM, guest
>>> Linux will occasionally get "Unexpected interrupt" after rebooting, with
>>> kernel message at the bottom.
>>>
>>> After some investigation, we found it might be caused by the
>>> preservation of virtual LPI during system reset: it seems the virtual
>>> LPI remains in the ap_list during VM reset, as well as its "enabled" and
>>> "pending_latch" status, and this causes the virtual LPI to be injected
>>> wrongly after VCPU reboots and enables interrupt.
>>>
>>> We propose to clear "enabled" flag of virtual LPI when PROPBASER (or
>>> GICR_CTRL) of virtual GICR is written to 0, and update virtual LPI
>>> properties when GICR_CTRL.enableLPIs is set to 1 again.
>>>
>>> Any advice? Or did we miss something?
>> We're clearly missing a trick here, but I'm not convinced of your
>> approach.
> To be honest, we were not fully convinced by ourselves either. I was worrying about guest switching GICR_CTRL or GICR_PROPBASER at runtime which probably causes issue for our rough approach.
>
>> What should happend is that the redistributors should be reset
>> as well, and that this should recall any LPI that has been made pending.
>> Unfortunately, we don't seem to have such code in place, which is
>> embarrassing.
>>
>> Can you give the following, untested patch a go? It isn't right either,
>> but it should have the right effect. If you confirm that it solves your
>> problem, we can look at adding the right hooks...
> Thanks, I'll test this and get back to you.
> Heyi
>
>> Thanks,
>>
>>     M.
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>> index ab3f47745d9c..bd9a9250f323 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -2403,8 +2403,32 @@ static int vgic_its_commit_v0(struct vgic_its *its)
>>       return 0;
>>   }
>>   +static void vgic_nuke_pending_lpis(struct kvm_vcpu *vcpu)
>> +{
>> +    struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>> +    struct vgic_irq *irq, *tmp;
>> +    unsigned long flags;
>> +
>> + raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
>> +
>> +    list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
>> +        if (irq->intid >= VGIC_MIN_LPI) {
>> +            list_del(&irq->ap_list);
>> +            vgic_put_irq(vcpu->kvm, irq);
>> +        }
>> +    }
>> +
>> + raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
>> +}
>> +
>>   static void vgic_its_reset(struct kvm *kvm, struct vgic_its *its)
>>   {
>> +    struct kvm_vcpu *vcpu;
>> +    int c;
>> +
>> +    kvm_for_each_vcpu(c, vcpu, kvm)
>> +        vgic_nuke_pending_lpis(vcpu);
>> +
>>       /* We need to keep the ABI specific field values */
>>       its->baser_coll_table &= ~GITS_BASER_VALID;
>>       its->baser_device_table &= ~GITS_BASER_VALID;
>>
>
>
>
> .
>


