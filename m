Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D873C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4572332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfHUKDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:03:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbfHUKDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:03:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 286FFA91F63E2A9D8B5C;
        Wed, 21 Aug 2019 18:03:22 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 18:03:15 +0800
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
To:     Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
 <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
 <CY4PR21MB0741D1CD295AD572548E61D1CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190821094406.GA28391@ming.t460p>
CC:     Ming Lei <tom.leiming@gmail.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        chenxiang <chenxiang66@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1a647622-d9cf-9c70-f990-e5606e60842b@huawei.com>
Date:   Wed, 21 Aug 2019 11:03:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190821094406.GA28391@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 10:44, Ming Lei wrote:
> On Wed, Aug 21, 2019 at 07:47:44AM +0000, Long Li wrote:
>>>>> Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
>>>>>
>>>>> On 20/08/2019 09:25, Ming Lei wrote:
>>>>>> On Tue, Aug 20, 2019 at 2:14 PM <longli@linuxonhyperv.com> wrote:
>>>>>>>
>>>>>>> From: Long Li <longli@microsoft.com>
>>>>>>>
>>>>>>> This patch set tries to fix interrupt swamp in NVMe devices.
>>>>>>>
>>>>>>> On large systems with many CPUs, a number of CPUs may share one
>>>>> NVMe
>>>>>>> hardware queue. It may have this situation where several CPUs are
>>>>>>> issuing I/Os, and all the I/Os are returned on the CPU where the
>>>>> hardware queue is bound to.
>>>>>>> This may result in that CPU swamped by interrupts and stay in
>>>>>>> interrupt mode for extended time while other CPUs continue to issue
>>>>>>> I/O. This can trigger Watchdog and RCU timeout, and make the system
>>>>> unresponsive.
>>>>>>>
>>>>>>> This patch set addresses this by enforcing scheduling and throttling
>>>>>>> I/O when CPU is starved in this situation.
>>>>>>>
>>>>>>> Long Li (3):
>>>>>>>   sched: define a function to report the number of context switches on a
>>>>>>>     CPU
>>>>>>>   sched: export idle_cpu()
>>>>>>>   nvme: complete request in work queue on CPU with flooded interrupts
>>>>>>>
>>>>>>>  drivers/nvme/host/core.c | 57
>>>>>>> +++++++++++++++++++++++++++++++++++++++-
>>>>>>>  drivers/nvme/host/nvme.h |  1 +
>>>>>>>  include/linux/sched.h    |  2 ++
>>>>>>>  kernel/sched/core.c      |  7 +++++
>>>>>>>  4 files changed, 66 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> Another simpler solution may be to complete request in threaded
>>>>>> interrupt handler for this case. Meantime allow scheduler to run the
>>>>>> interrupt thread handler on CPUs specified by the irq affinity mask,
>>>>>> which was discussed by the following link:
>>>>>>
>>>>>>
>>>>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
>>>>> e
>>>>>> .kernel.org%2Flkml%2Fe0e9478e-62a5-ca24-3b12-
>>>>> 58f7d056383e%40huawei.com
>>>>>> %2F&amp;data=02%7C01%7Clongli%40microsoft.com%7Cc7f46d3e273f45
>>>>> 176d1c08
>>>>>>
>>>>> d7254cc69e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6370188
>>>>> 8401588
>>>>>>
>>>>> 9866&amp;sdata=h5k6HoGoyDxuhmDfuKLZUwgmw17PU%2BT%2FCbawfxV
>>>>> Er3U%3D&amp;
>>>>>> reserved=0
>>>>>>
>>>>>> Could you try the above solution and see if the lockup can be avoided?
>>>>>> John Garry
>>>>>> should have workable patch.
>>>>>
>>>>> Yeah, so we experimented with changing the interrupt handling in the SCSI
>>>>> driver I maintain to use a threaded handler IRQ handler plus patch below,
>>>>> and saw a significant throughput boost:
>>>>>
>>>>> --->8
>>>>>
>>>>> Subject: [PATCH] genirq: Add support to allow thread to use hard irq affinity
>>>>>
>>>>> Currently the cpu allowed mask for the threaded part of a threaded irq
>>>>> handler will be set to the effective affinity of the hard irq.
>>>>>
>>>>> Typically the effective affinity of the hard irq will be for a single cpu. As such,
>>>>> the threaded handler would always run on the same cpu as the hard irq.
>>>>>
>>>>> We have seen scenarios in high data-rate throughput testing that the cpu
>>>>> handling the interrupt can be totally saturated handling both the hard
>>>>> interrupt and threaded handler parts, limiting throughput.
>>>>>
>>>>> Add IRQF_IRQ_AFFINITY flag to allow the driver requesting the threaded
>>>>> interrupt to decide on the policy of which cpu the threaded handler may run.
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Thanks for pointing me to this patch. This fixed the interrupt swamp and make the system stable.
>>
>> However I'm seeing reduced performance when using threaded interrupts.
>>
>> Here are the test results on a system with 80 CPUs and 10 NVMe disks (32 hardware queues for each disk)
>> Benchmark tool is FIO, I/O pattern: 4k random reads on all NVMe disks, with queue depth = 64, num of jobs = 80, direct=1
>>
>> With threaded interrupts: 1320k IOPS
>> With just interrupts: 3720k IOPS
>> With just interrupts and my patch: 3700k IOPS
>
> This gap looks too big wrt. threaded interrupts vs. interrupts.
>
>>
>> At the peak IOPS, the overall CPU usage is at around 98-99%. I think the cost of doing wake up and context switch for NVMe threaded IRQ handler takes some CPU away.
>>
>
> In theory, it shouldn't be so because most of times the thread should be running
> on CPUs of this hctx, and the wakeup cost shouldn't be so big. Maybe there is
> performance problem somewhere wrt. threaded interrupt.
>
> Could you share us your test script and environment? I will see if I can
> reproduce it in my environment.
>
>> In this test, I made the following change to make use of IRQF_IRQ_AFFINITY for NVMe:
>>
>> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
>> index a1de501a2729..3fb30d16464e 100644
>> --- a/drivers/pci/irq.c
>> +++ b/drivers/pci/irq.c
>> @@ -86,7 +86,7 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>>         va_list ap;
>>         int ret;
>>         char *devname;
>> -       unsigned long irqflags = IRQF_SHARED;
>> +       unsigned long irqflags = IRQF_SHARED | IRQF_IRQ_AFFINITY;
>>
>>         if (!handler)
>>                 irqflags |= IRQF_ONESHOT;
>>
>
> I don't see why IRQF_IRQ_AFFINITY is needed.
>
> John, could you explain it a bit why you need changes on IRQF_IRQ_AFFINITY?

Hi Ming,

The patch I shared was my original solution, based on the driver setting 
flag IRQF_IRQ_AFFINITY to request the threaded handler uses the irq 
affinity mask for the handler cpu allowed mask.

If we want to make this decision based only on whether the irq is 
managed or not, then we can drop the flag and just make the change as 
you suggest, below.

Thanks,
John

>
> The following patch should be enough:
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e8f7f179bf77..1e7cffc1c20c 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -968,7 +968,11 @@ irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
>  	if (cpumask_available(desc->irq_common_data.affinity)) {
>  		const struct cpumask *m;
>
> -		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +		if (irqd_affinity_is_managed(&desc->irq_data))
> +			m = desc->irq_common_data.affinity;
> +		else
> +			m = irq_data_get_effective_affinity_mask(
> +					&desc->irq_data);
>  		cpumask_copy(mask, m);
>  	} else {
>  		valid = false;
>
>
> Thanks,
> Ming
>
> .
>


