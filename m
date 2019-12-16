Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4FB206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLPORo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:17:44 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727974AbfLPORo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:17:44 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DEE196C55462250E0C9C;
        Mon, 16 Dec 2019 14:17:42 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 14:17:42 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 14:17:42 +0000
From:   John Garry <john.garry@huawei.com>
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
Message-ID: <a5f6a542-2dbc-62de-52e2-bd5413b5db51@huawei.com>
Date:   Mon, 16 Dec 2019 14:17:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <50d9ba606e1e3ee1665a0328ffac67ac@www.loen.fr>
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
>> I'm just wondering if non-managed interrupts should be included in
>> the load balancing calculation? Couldn't irqbalance (if active) start
>> moving non-managed interrupts around anyway?
> 
> But they are, aren't they? See what we do in irq_set_affinity:
> 
> +        atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
> +        atomic_dec(per_cpu_ptr(&cpu_lpi_count,
> +                       its_dev->event_map.col_map[id]));
> 
> We don't try to "rebalance" anything based on that though, not that
> I think we should.

Ah sorry, I meant whether they should not be included. In 
its_irq_domain_activate(), we increment the per-cpu lpi count and also 
use its_pick_target_cpu() to find the least loaded cpu. I am asking 
whether we should just stick with the old policy for non-managed 
interrupts here.

After checking D05, I see a very significant performance hit for SAS 
controller performance - ~40% throughout lowering.

With this patch, now we have effective affinity targeted at seemingly 
"random" CPUs, as opposed to all just using CPU0. This affects performance.

The difference is that when we use managed interrupts - like for NVME or 
D06 SAS controller - the irq cpu affinity mask matches the CPUs which 
enqueue the requests to the queue associated with the interrupt. So 
there is an efficiency is enqueuing and deqeueing on same CPU group - 
all related to blk multi-queue. And this is not the case for non-managed 
interrupts.

>>
>>> Please give this new patch a shot on your system (my D05 doesn't have
>>> any managed devices):
>>
>> We could consider supporting platform msi managed interrupts, but I
>> doubt the value.
> 
> It shouldn't be hard to do, and most of the existing code could be
> moved to the generic level. As for the value, I'm not convinced
> either. For example D05 uses the MBIGEN as an intermediate interrupt
> controller, so MSIs are from the PoV of MBIGEN, and not the SAS device
> attached to it. Not the best design...

JFYI, I did raise this following topic before, but that's as far as I got:

https://marc.info/?l=linux-block&m=150722088314310&w=2

> 
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/its-balance-mappings&id=1e987d83b8d880d56c9a2d8a86289631da94e55a 
>>>
>>>
>>
>> I quickly tested that in my NVMe env, and I see a performance boost
>> of 1055K -> 1206K IOPS. Results at bottom.
> 
> OK, that's encouraging.
> 
>> Here's the irq mapping dump:
> 
> [...]
> 
> Looks good.
> 
>> I'm still getting the CPU lockup (even on CPUs which have a single
>> NVMe completion interrupt assigned), which taints these results. That
>> lockup needs to be fixed.
> 
> Is this interrupt screaming to the point where it prevents the completion
> thread from making forward progress? What if you don't use threaded
> interrupts?

Yeah, just switching to threaded interrupts solves it (nvme core has a 
switch for this). So there was a big discussion on this topic a while ago:

https://lkml.org/lkml/2019/8/20/45 (couldn't find this on lore)

The conclusion there was to switch to irq poll, but leiming though that 
it was another issue - see earlier mail:

https://lore.kernel.org/lkml/20191210014335.GA25022@ming.t460p/

> 
>> We'll check on our SAS env also. I did already hack something up
>> similar to your change and again we saw a boost there.
> 
> OK. Please keep me posted. If the result is overall positive, I'll
> push this into -next for some soaking.
> 

ok, thanks

John
