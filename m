Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A19F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfC2Kyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:54:52 -0400
Received: from foss.arm.com ([217.140.101.70]:57926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbfC2Kyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:54:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2BB580D;
        Fri, 29 Mar 2019 03:54:51 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4C03F575;
        Fri, 29 Mar 2019 03:54:50 -0700 (PDT)
Subject: Re: Unexpected interrupt received in Guest OS when booting after
 "system_reset"
To:     Heyi Guo <guoheyi@huawei.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
References: <e8ffbc4e-f7b7-14a1-7614-a3db85c9152f@huawei.com>
 <9a6ece7e-9984-dc9e-8fa2-df9736393dd2@arm.com>
 <9694b5f2-80bd-b85c-8fc5-bd1d917e1b33@huawei.com>
 <2e8f8bfb-4ae2-5fc6-4022-222a8f44e1f6@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtCNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPokCOwQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8m5Ag0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAGJAh8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <ad743120-8d9b-57e1-ef19-657047d6ccf8@arm.com>
Date:   Fri, 29 Mar 2019 10:54:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2e8f8bfb-4ae2-5fc6-4022-222a8f44e1f6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2019 09:19, Heyi Guo wrote:
> Hi Marc,
> 
> The patch works. I tested for 1.5 hour and 52 VM resets. There were
> 16 times that a virtual LPI left in the ap_list (seen by an
> additional printk) during reset and we never saw "Unexpected
> interrupt received" any more.


Thanks for testing, much appreciated.

> Just a minor comment: how about replacing /vcpu->arch.vgic_cpu./ with
> /vgic_cpu->/ in the lock/unlock code line, to reduce some words?

Well, as I said, the patch is wrong in other ways, so I wouldn't bother
with that. It only serves as a test for my theory.

I think I'm slowly warming up to you initial proposal to hook things
into the PROPBASER/PENDBASER registers, as the LPIs do have a life
outside of the ITS itself.

I'll try to respin something next week.

Thanks,

	M.

> 
> Thanks,
> 
> Heyi
> 
> On 2019/3/29 9:19, Heyi Guo wrote:
>>
>>
>> On 2019/3/29 1:18, Marc Zyngier wrote:
>>> [Please do not send HTML emails]
>> Sorry; will keep in mind next time :)
>>>
>>> On 28/03/2019 15:44, Heyi Guo wrote:
>>>> Hi Marc and Christoffer,
>>>>
>>>> When we issue "system_reset" from qemu monitor to a running VM, guest
>>>> Linux will occasionally get "Unexpected interrupt" after rebooting, with
>>>> kernel message at the bottom.
>>>>
>>>> After some investigation, we found it might be caused by the
>>>> preservation of virtual LPI during system reset: it seems the virtual
>>>> LPI remains in the ap_list during VM reset, as well as its "enabled" and
>>>> "pending_latch" status, and this causes the virtual LPI to be injected
>>>> wrongly after VCPU reboots and enables interrupt.
>>>>
>>>> We propose to clear "enabled" flag of virtual LPI when PROPBASER (or
>>>> GICR_CTRL) of virtual GICR is written to 0, and update virtual LPI
>>>> properties when GICR_CTRL.enableLPIs is set to 1 again.
>>>>
>>>> Any advice? Or did we miss something?
>>> We're clearly missing a trick here, but I'm not convinced of your
>>> approach.
>> To be honest, we were not fully convinced by ourselves either. I was worrying about guest switching GICR_CTRL or GICR_PROPBASER at runtime which probably causes issue for our rough approach.
>>
>>> What should happend is that the redistributors should be reset
>>> as well, and that this should recall any LPI that has been made pending.
>>> Unfortunately, we don't seem to have such code in place, which is
>>> embarrassing.
>>>
>>> Can you give the following, untested patch a go? It isn't right either,
>>> but it should have the right effect. If you confirm that it solves your
>>> problem, we can look at adding the right hooks...
>> Thanks, I'll test this and get back to you.
>> Heyi
>>
>>> Thanks,
>>>
>>>     M.
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>>> index ab3f47745d9c..bd9a9250f323 100644
>>> --- a/virt/kvm/arm/vgic/vgic-its.c
>>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>>> @@ -2403,8 +2403,32 @@ static int vgic_its_commit_v0(struct vgic_its *its)
>>>       return 0;
>>>   }
>>>   +static void vgic_nuke_pending_lpis(struct kvm_vcpu *vcpu)
>>> +{
>>> +    struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>> +    struct vgic_irq *irq, *tmp;
>>> +    unsigned long flags;
>>> +
>>> + raw_spin_lock_irqsave(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
>>> +
>>> +    list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
>>> +        if (irq->intid >= VGIC_MIN_LPI) {
>>> +            list_del(&irq->ap_list);
>>> +            vgic_put_irq(vcpu->kvm, irq);
>>> +        }
>>> +    }
>>> +
>>> + raw_spin_unlock_irqrestore(&vcpu->arch.vgic_cpu.ap_list_lock, flags);
>>> +}
>>> +
>>>   static void vgic_its_reset(struct kvm *kvm, struct vgic_its *its)
>>>   {
>>> +    struct kvm_vcpu *vcpu;
>>> +    int c;
>>> +
>>> +    kvm_for_each_vcpu(c, vcpu, kvm)
>>> +        vgic_nuke_pending_lpis(vcpu);
>>> +
>>>       /* We need to keep the ABI specific field values */
>>>       its->baser_coll_table &= ~GITS_BASER_VALID;
>>>       its->baser_device_table &= ~GITS_BASER_VALID;
>>>
>>
>>
>>
>> .
>>
> 
> 


-- 
Jazz is not dead. It just smells funny...
