Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA1821739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLPSvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:51:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbfLPSu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:50:59 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1591BE8D58F2BEE38D72;
        Mon, 16 Dec 2019 18:50:57 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 18:50:56 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 18:50:56 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
CC:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
 <20191212223805.GA24463@ming.t460p>
 <d4b89ecf-7ced-d5d6-fc02-6d4257580465@huawei.com>
 <20191213131822.GA19876@ming.t460p>
 <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
 <20191214135641.5a817512@why>
 <7db89b97-1b9e-8dd1-684a-3eef1b1af244@huawei.com>
 <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
 <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
 <68058fd28c939b8e065524715494de95@www.loen.fr>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ac5b5a25-df2e-18e9-6b0f-60af8c7cec3b@huawei.com>
Date:   Mon, 16 Dec 2019 18:50:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <68058fd28c939b8e065524715494de95@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>>
>>>>
>>>> I'm just wondering if non-managed interrupts should be included in
>>>> the load balancing calculation? Couldn't irqbalance (if active) start
>>>> moving non-managed interrupts around anyway?
>>> But they are, aren't they? See what we do in irq_set_affinity:
>>> +        atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
>>> +        atomic_dec(per_cpu_ptr(&cpu_lpi_count,
>>> +                       its_dev->event_map.col_map[id]));
>>> We don't try to "rebalance" anything based on that though, not that
>>> I think we should.
>>
>> Ah sorry, I meant whether they should not be included. In
>> its_irq_domain_activate(), we increment the per-cpu lpi count and also
>> use its_pick_target_cpu() to find the least loaded cpu. I am asking
>> whether we should just stick with the old policy for non-managed
>> interrupts here.
>>
>> After checking D05, I see a very significant performance hit for SAS
>> controller performance - ~40% throughout lowering.
> 
> -ETOOMANYMOVINGPARTS.

Understood.

> 
>> With this patch, now we have effective affinity targeted at seemingly
>> "random" CPUs, as opposed to all just using CPU0. This affects
>> performance.
> 
> And piling all interrupts on the same CPU does help?

Apparently... I need to check this more.

> 
>> The difference is that when we use managed interrupts - like for NVME
>> or D06 SAS controller - the irq cpu affinity mask matches the CPUs
>> which enqueue the requests to the queue associated with the interrupt.
>> So there is an efficiency is enqueuing and deqeueing on same CPU group
>> - all related to blk multi-queue. And this is not the case for
>> non-managed interrupts.
> 
> So you enqueue requests from CPU0 only? It seems a bit odd...

No, but maybe I wasn't clear enough. I'll give an overview:

For D06 SAS controller - which is a multi-queue PCI device - we use 
managed interrupts. The HW has 16 submission/completion queues, so for 
96 cores, we have an even spread of 6 CPUs assigned per queue; and this 
per-queue CPU mask is the interrupt affinity mask. So CPU0-5 would 
submit any IO on queue0, CPU6-11 on queue2, and so on. PCI NVMe is 
essentially the same.

These are the environments which we're trying to promote performance.

Then for D05 SAS controller - which is multi-queue platform device 
(mbigen) - we don't use managed interrupts. We still submit IO from any 
CPU, but we choose the queue to submit IO on a round-robin basis to 
promote some isolation, i.e. reduce inter-queue lock contention, so the 
queue chosen has nothing to do with the CPU.

And with your change we may submit on cpu4 but service the interrupt on 
cpu30, as an example. While previously we would always service on cpu0. 
The old way still isn't ideal, I'll admit.

For this env, we would just like to maintain the same performance. And 
it's here that we see the performance drop.

> 
>>>>> Please give this new patch a shot on your system (my D05 doesn't have
>>>>> any managed devices):
>>>>
>>>> We could consider supporting platform msi managed interrupts, but I
>>>> doubt the value.
>>> It shouldn't be hard to do, and most of the existing code could be
>>> moved to the generic level. As for the value, I'm not convinced
>>> either. For example D05 uses the MBIGEN as an intermediate interrupt
>>> controller, so MSIs are from the PoV of MBIGEN, and not the SAS device
>>> attached to it. Not the best design...
>>
>> JFYI, I did raise this following topic before, but that's as far as I 
>> got:
>>
>> https://marc.info/?l=linux-block&m=150722088314310&w=2
> 
> Yes. And that's probably not very hard, but the problem in your case is
> that the D05 HW is not using MSIs...

Right

  You'd have to provide an abstraction
> for wired interrupts (please don't).
> 
> You'd be better off directly setting the affinity of the interrupts from
> the driver, but I somehow can't believe that you're only submitting 
> requests
> from the same CPU,

Maybe...

  always. There must be something I'm missing.
> 

Thanks,
John
