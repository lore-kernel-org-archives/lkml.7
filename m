Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BAE22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfHTI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:59:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbfHTI7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:59:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65641364036BC0FFDAF4;
        Tue, 20 Aug 2019 16:59:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 16:59:39 +0800
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
To:     Ming Lei <tom.leiming@gmail.com>, <longli@linuxonhyperv.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
Date:   Tue, 20 Aug 2019 09:59:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 09:25, Ming Lei wrote:
> On Tue, Aug 20, 2019 at 2:14 PM <longli@linuxonhyperv.com> wrote:
>>
>> From: Long Li <longli@microsoft.com>
>>
>> This patch set tries to fix interrupt swamp in NVMe devices.
>>
>> On large systems with many CPUs, a number of CPUs may share one NVMe hardware
>> queue. It may have this situation where several CPUs are issuing I/Os, and
>> all the I/Os are returned on the CPU where the hardware queue is bound to.
>> This may result in that CPU swamped by interrupts and stay in interrupt mode
>> for extended time while other CPUs continue to issue I/O. This can trigger
>> Watchdog and RCU timeout, and make the system unresponsive.
>>
>> This patch set addresses this by enforcing scheduling and throttling I/O when
>> CPU is starved in this situation.
>>
>> Long Li (3):
>>   sched: define a function to report the number of context switches on a
>>     CPU
>>   sched: export idle_cpu()
>>   nvme: complete request in work queue on CPU with flooded interrupts
>>
>>  drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++-
>>  drivers/nvme/host/nvme.h |  1 +
>>  include/linux/sched.h    |  2 ++
>>  kernel/sched/core.c      |  7 +++++
>>  4 files changed, 66 insertions(+), 1 deletion(-)
>
> Another simpler solution may be to complete request in threaded interrupt
> handler for this case. Meantime allow scheduler to run the interrupt thread
> handler on CPUs specified by the irq affinity mask, which was discussed by
> the following link:
>
> https://lore.kernel.org/lkml/e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com/
>
> Could you try the above solution and see if the lockup can be avoided?
> John Garry
> should have workable patch.

Yeah, so we experimented with changing the interrupt handling in the 
SCSI driver I maintain to use a threaded handler IRQ handler plus patch 
below, and saw a significant throughput boost:

--->8

Subject: [PATCH] genirq: Add support to allow thread to use hard irq 
affinity

Currently the cpu allowed mask for the threaded part of a threaded irq
handler will be set to the effective affinity of the hard irq.

Typically the effective affinity of the hard irq will be for a single
cpu. As such, the threaded handler would always run on the same cpu as
the hard irq.

We have seen scenarios in high data-rate throughput testing that the
cpu handling the interrupt can be totally saturated handling both the
hard interrupt and threaded handler parts, limiting throughput.

Add IRQF_IRQ_AFFINITY flag to allow the driver requesting the threaded
interrupt to decide on the policy of which cpu the threaded handler
may run.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a99b2a..48e8b955989a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -61,6 +61,9 @@
   *                interrupt handler after suspending interrupts. For 
system
   *                wakeup devices users need to implement wakeup 
detection in
   *                their interrupt handlers.
+ * IRQF_IRQ_AFFINITY - Use the hard interrupt affinity for setting the cpu
+ *                allowed mask for the threaded handler of a threaded 
interrupt
+ *                handler, rather than the effective hard irq affinity.
   */
  #define IRQF_SHARED		0x00000080
  #define IRQF_PROBE_SHARED	0x00000100
@@ -74,6 +77,7 @@
  #define IRQF_NO_THREAD		0x00010000
  #define IRQF_EARLY_RESUME	0x00020000
  #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_IRQ_AFFINITY	0x00080000

  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f179bf77..cb483a055512 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -966,9 +966,13 @@ irq_thread_check_affinity(struct irq_desc *desc, 
struct irqaction *action)
  	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
  	 */
  	if (cpumask_available(desc->irq_common_data.affinity)) {
+		struct irq_data *irq_data = &desc->irq_data;
  		const struct cpumask *m;

-		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		if (action->flags & IRQF_IRQ_AFFINITY)
+			m = desc->irq_common_data.affinity;
+		else
+			m = irq_data_get_effective_affinity_mask(irq_data);
  		cpumask_copy(mask, m);
  	} else {
  		valid = false;
-- 
2.17.1

As Ming mentioned in that same thread, we could even make this policy 
for managed interrupts.

Cheers,
John

>
> Thanks,
> Ming Lei
>
> .
>


