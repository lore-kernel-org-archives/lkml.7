Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA059218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfGVQIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:08:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbfGVQIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:08:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B78930715761749B0C3;
        Tue, 23 Jul 2019 00:08:34 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 00:08:25 +0800
Subject: Re: About threaded interrupt handler CPU affinity
To:     Thomas Gleixner <tglx@linutronix.de>
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
 <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
 <6fd4d706-b66d-6390-749a-8a06b17cb487@huawei.com>
 <alpine.DEB.2.21.1907221723450.2082@nanos.tec.linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>, <bigeasy@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
Date:   Mon, 22 Jul 2019 17:08:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907221723450.2082@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2019 16:34, Thomas Gleixner wrote:
> John,
>

Hi Thomas,

> On Mon, 22 Jul 2019, John Garry wrote:
>> On 22/07/2019 15:41, Marc Zyngier wrote:
>>> On 22/07/2019 15:14, John Garry wrote:
>>>> I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow
>>>> the effective hard irq affinity"), if you could kindly check:
>>>>
>>>> Here we set the thread affinity to be the same as the hard interrupt
>>>> affinity. For an arm64 system with GIC ITS, this will be a single CPU,
>>>> the lowest in the interrupt affinity mask. So, in this case, effectively
>>>> the thread will be bound to a single CPU. I think APIC is the same for
>>>> this.
>>>>
>>>> The commit message describes the problem that we solve here is that the
>>>> thread may become affine to a different CPU to the hard interrupt - does
>>>> it mean that the thread CPU mask could not cover that of the hard
>>>> interrupt? I couldn't follow the reason.
>>>
>>> Assume a 4 CPU system. If the interrupt affinity is on CPU0-1, you could
>>> end up with the effective interrupt affinity on CPU0 (which would be
>>> typical of the ITS), and the thread running on CPU1. Not great.
>>
>> Sure, not great. But the thread can possibly still run on CPU0.
>
> Sure. It could, but it's up to the scheduler to decide. In general it's the
> right thing to run the threaded handler on the CPU which handles the
> interrupt.

I'd agree.

>With single CPU affinity thats surely a limitation.
>
>>>> We have experimented with fixing the thread mask to be the same as the
>>>> interrupt mask (we're using managed interrupts), like before, and get a
>>>> significant performance boost at high IO datarates on our storage
>>>> controller - like ~11%.
>>>
>>> My understanding is that this patch does exactly that. Does it result in
>>> a regression?
>>
>> Not in the strictest sense for us, I don't know about others. Currently we use
>> tasklets, and we find that the CPUs servicing the interrupts (and hence
>> tasklets) are heavily loaded. We experience the same for when experimenting
>> with threaded interrupt handlers - which would be as expected.
>>
>> But, when we make the change as mentioned, our IOPS goes from ~3M -> 3.4M.
>
> So your interrupt is affined to more than one CPU, but due to the ITS
> limitation the effective affinity is a single CPU, which in turn restricts
> the thread handler affinity to the same single CPU.

Even though this is an ITS limitation, the same thing is effectively 
done for x86 APIC as policy, right? I'm referring to commit fdba46ffb4c2 
("x86/apic: Get rid of multi CPU affinity")

  If you lift that
> restriction and let it be affine to the full affinity set of the interrupt
> then you get better performance, right?

Right

  Probably because the other CPU(s)
> in the affinity set are less loaded than the one which handles the hard
> interrupt.

I will look to get some figures for CPU loading to back this up.

>
> This is heavily use case dependent I assume, so making this a general
> change is perhaps not a good idea, but we could surely make this optional.

That sounds reasonable. So would the idea be to enable this optionally 
at the request threaded irq call?

Thanks,
John

>
> Thanks,
>
> 	tglx
>
> .
>


