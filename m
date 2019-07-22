Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D514C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B94821921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGVPSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:18:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfGVPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:18:02 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 339ABD1490A4FCDA92F9;
        Mon, 22 Jul 2019 23:17:58 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Jul 2019
 23:17:51 +0800
Subject: Re: About threaded interrupt handler CPU affinity
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
 <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
CC:     <bigeasy@linutronix.de>, chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6fd4d706-b66d-6390-749a-8a06b17cb487@huawei.com>
Date:   Mon, 22 Jul 2019 16:17:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2019 15:41, Marc Zyngier wrote:
> Hi John,

Hi Marc,

>
> On 22/07/2019 15:14, John Garry wrote:
>> Hi Thomas,
>>
>> I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow
>> the effective hard irq affinity"), if you could kindly check:
>>
>> Here we set the thread affinity to be the same as the hard interrupt
>> affinity. For an arm64 system with GIC ITS, this will be a single CPU,
>> the lowest in the interrupt affinity mask. So, in this case, effectively
>> the thread will be bound to a single CPU. I think APIC is the same for this.
>>
>> The commit message describes the problem that we solve here is that the
>> thread may become affine to a different CPU to the hard interrupt - does
>> it mean that the thread CPU mask could not cover that of the hard
>> interrupt? I couldn't follow the reason.
>
> Assume a 4 CPU system. If the interrupt affinity is on CPU0-1, you could
> end up with the effective interrupt affinity on CPU0 (which would be
> typical of the ITS), and the thread running on CPU1. Not great.

Sure, not great. But the thread can possibly still run on CPU0.

>
> The change you mentions ensures that the thread affinity is strictly
> equal to the *effective affinity* of the interrupt (or at least that's
> the way I read it).
>
>> We have experimented with fixing the thread mask to be the same as the
>> interrupt mask (we're using managed interrupts), like before, and get a
>> significant performance boost at high IO datarates on our storage
>> controller - like ~11%.
>
> My understanding is that this patch does exactly that. Does it result in
> a regression?

Not in the strictest sense for us, I don't know about others. Currently 
we use tasklets, and we find that the CPUs servicing the interrupts (and 
hence tasklets) are heavily loaded. We experience the same for when 
experimenting with threaded interrupt handlers - which would be as expected.

But, when we make the change as mentioned, our IOPS goes from ~3M -> 3.4M.

I would say that a. CPU0 not always having to deal with the interrupt 
handler+threaded part b. less context switching from a. would be factors 
in this.

Thanks,
John


>
> Thanks,
> 	
> 	M.
>


