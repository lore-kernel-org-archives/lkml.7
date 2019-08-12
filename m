Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B0CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C020820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHLIrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:47:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbfHLIrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:47:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8D8AE04CE71A9E02373;
        Mon, 12 Aug 2019 16:47:03 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 16:46:53 +0800
Subject: Re: About threaded interrupt handler CPU affinity
To:     Ming Lei <tom.leiming@gmail.com>
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
 <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
 <6fd4d706-b66d-6390-749a-8a06b17cb487@huawei.com>
 <alpine.DEB.2.21.1907221723450.2082@nanos.tec.linutronix.de>
 <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
 <CACVXFVPMZpUrDORA4YDQiwd+VG-OoOhv1G0NeeqSdz7Udfzryg@mail.gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <248a9149-ad8d-ac84-cdc4-67c344179763@huawei.com>
Date:   Mon, 12 Aug 2019 09:46:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPMZpUrDORA4YDQiwd+VG-OoOhv1G0NeeqSdz7Udfzryg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2019 10:47, Ming Lei wrote:
> On Tue, Jul 23, 2019 at 1:40 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 22/07/2019 16:34, Thomas Gleixner wrote:
>>> John,
>>>
>>
>> Hi Thomas,
>>
>>> On Mon, 22 Jul 2019, John Garry wrote:
>>>> On 22/07/2019 15:41, Marc Zyngier wrote:
>>>>> On 22/07/2019 15:14, John Garry wrote:
>>>>>> I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow
>>>>>> the effective hard irq affinity"), if you could kindly check:
>>>>>>
>>>>>> Here we set the thread affinity to be the same as the hard interrupt
>>>>>> affinity. For an arm64 system with GIC ITS, this will be a single CPU,
>>>>>> the lowest in the interrupt affinity mask. So, in this case, effectively
>>>>>> the thread will be bound to a single CPU. I think APIC is the same for
>>>>>> this.
>>>>>>
>>>>>> The commit message describes the problem that we solve here is that the
>>>>>> thread may become affine to a different CPU to the hard interrupt - does
>>>>>> it mean that the thread CPU mask could not cover that of the hard
>>>>>> interrupt? I couldn't follow the reason.
>>>>>
>>>>> Assume a 4 CPU system. If the interrupt affinity is on CPU0-1, you could
>>>>> end up with the effective interrupt affinity on CPU0 (which would be
>>>>> typical of the ITS), and the thread running on CPU1. Not great.
>>>>
>>>> Sure, not great. But the thread can possibly still run on CPU0.
>>>
>>> Sure. It could, but it's up to the scheduler to decide. In general it's the
>>> right thing to run the threaded handler on the CPU which handles the
>>> interrupt.
>>
>> I'd agree.
>>
>>> With single CPU affinity thats surely a limitation.
>>>
>>>>>> We have experimented with fixing the thread mask to be the same as the
>>>>>> interrupt mask (we're using managed interrupts), like before, and get a
>>>>>> significant performance boost at high IO datarates on our storage
>>>>>> controller - like ~11%.
>>>>>
>>>>> My understanding is that this patch does exactly that. Does it result in
>>>>> a regression?
>>>>
>>>> Not in the strictest sense for us, I don't know about others. Currently we use
>>>> tasklets, and we find that the CPUs servicing the interrupts (and hence
>>>> tasklets) are heavily loaded. We experience the same for when experimenting
>>>> with threaded interrupt handlers - which would be as expected.
>>>>
>>>> But, when we make the change as mentioned, our IOPS goes from ~3M -> 3.4M.
>>>
>>> So your interrupt is affined to more than one CPU, but due to the ITS
>>> limitation the effective affinity is a single CPU, which in turn restricts
>>> the thread handler affinity to the same single CPU.
>>
>> Even though this is an ITS limitation, the same thing is effectively
>> done for x86 APIC as policy, right? I'm referring to commit fdba46ffb4c2
>> ("x86/apic: Get rid of multi CPU affinity")
>>
>>   If you lift that
>>> restriction and let it be affine to the full affinity set of the interrupt
>>> then you get better performance, right?
>>
>> Right
>>
>>   Probably because the other CPU(s)
>>> in the affinity set are less loaded than the one which handles the hard
>>> interrupt.
>>
>> I will look to get some figures for CPU loading to back this up.
>>
>>>
>>> This is heavily use case dependent I assume, so making this a general
>>> change is perhaps not a good idea, but we could surely make this optional.
>>
>> That sounds reasonable. So would the idea be to enable this optionally
>> at the request threaded irq call?
>
> I'd suggest to do it for managed IRQ at default, because managed IRQ affinity
> is NUMA locality and setup gracefully. And the idea behind is good since the IRQ
> handler should have been run in the specified CPUs, especially the thread part
> often takes more CPU.

So I was going to send a patch for this change.

However, for the SCSI driver I found it helps performance, managed 
interrupts are disabled by default (due to this yet unresolved issue 
https://lkml.org/lkml/2019/1/29/391 - that's just one thread on this 
issue), so I don't think that it's right to enable it on that basis.

If there's some other driver which uses manages interrupts + threaded 
interrupt handlers and we can prove it helps, then I'd say that should 
be good enough.

Thanks,
John



