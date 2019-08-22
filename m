Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B2C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E772339E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfHVBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfHVBeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A623B106BB24;
        Thu, 22 Aug 2019 01:34:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29EFB5C205;
        Thu, 22 Aug 2019 01:34:01 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:33:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Long Li <longli@microsoft.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        chenxiang <chenxiang66@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
Message-ID: <20190822013356.GC28635@ming.t460p>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com>
 <fd7d6101-37f4-2d34-f2f7-cfeade610278@huawei.com>
 <CY4PR21MB0741D1CD295AD572548E61D1CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190821094406.GA28391@ming.t460p>
 <CY4PR21MB07410E84C8C7C1D64BD7BF41CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB07410E84C8C7C1D64BD7BF41CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 01:34:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:27:00PM +0000, Long Li wrote:
> >>>Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
> >>>
> >>>On Wed, Aug 21, 2019 at 07:47:44AM +0000, Long Li wrote:
> >>>> >>>Subject: Re: [PATCH 0/3] fix interrupt swamp in NVMe
> >>>> >>>
> >>>> >>>On 20/08/2019 09:25, Ming Lei wrote:
> >>>> >>>> On Tue, Aug 20, 2019 at 2:14 PM <longli@linuxonhyperv.com> wrote:
> >>>> >>>>>
> >>>> >>>>> From: Long Li <longli@microsoft.com>
> >>>> >>>>>
> >>>> >>>>> This patch set tries to fix interrupt swamp in NVMe devices.
> >>>> >>>>>
> >>>> >>>>> On large systems with many CPUs, a number of CPUs may share
> >>>one
> >>>> >>>NVMe
> >>>> >>>>> hardware queue. It may have this situation where several CPUs
> >>>> >>>>> are issuing I/Os, and all the I/Os are returned on the CPU where
> >>>> >>>>> the
> >>>> >>>hardware queue is bound to.
> >>>> >>>>> This may result in that CPU swamped by interrupts and stay in
> >>>> >>>>> interrupt mode for extended time while other CPUs continue to
> >>>> >>>>> issue I/O. This can trigger Watchdog and RCU timeout, and make
> >>>> >>>>> the system
> >>>> >>>unresponsive.
> >>>> >>>>>
> >>>> >>>>> This patch set addresses this by enforcing scheduling and
> >>>> >>>>> throttling I/O when CPU is starved in this situation.
> >>>> >>>>>
> >>>> >>>>> Long Li (3):
> >>>> >>>>>   sched: define a function to report the number of context switches
> >>>on a
> >>>> >>>>>     CPU
> >>>> >>>>>   sched: export idle_cpu()
> >>>> >>>>>   nvme: complete request in work queue on CPU with flooded
> >>>> >>>>> interrupts
> >>>> >>>>>
> >>>> >>>>>  drivers/nvme/host/core.c | 57
> >>>> >>>>> +++++++++++++++++++++++++++++++++++++++-
> >>>> >>>>>  drivers/nvme/host/nvme.h |  1 +
> >>>> >>>>>  include/linux/sched.h    |  2 ++
> >>>> >>>>>  kernel/sched/core.c      |  7 +++++
> >>>> >>>>>  4 files changed, 66 insertions(+), 1 deletion(-)
> >>>> >>>>
> >>>> >>>> Another simpler solution may be to complete request in threaded
> >>>> >>>> interrupt handler for this case. Meantime allow scheduler to run
> >>>> >>>> the interrupt thread handler on CPUs specified by the irq
> >>>> >>>> affinity mask, which was discussed by the following link:
> >>>> >>>>
> >>>> >>>>
> >>>> >>>https://lor
> >>>> >>>e
> >>>> >>>> .kernel.org%2Flkml%2Fe0e9478e-62a5-ca24-3b12-
> >>>> >>>58f7d056383e%40huawei.com
> >>>> >>>> %2F&amp;data=02%7C01%7Clongli%40microsoft.com%7Cc7f46d3e2
> >>>73f45
> >>>> >>>176d1c08
> >>>> >>>>
> >>>> >>>d7254cc69e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63
> >>>70188
> >>>> >>>8401588
> >>>> >>>>
> >>>> >>>9866&amp;sdata=h5k6HoGoyDxuhmDfuKLZUwgmw17PU%2BT%2FCb
> >>>awfxV
> >>>> >>>Er3U%3D&amp;
> >>>> >>>> reserved=0
> >>>> >>>>
> >>>> >>>> Could you try the above solution and see if the lockup can be
> >>>avoided?
> >>>> >>>> John Garry
> >>>> >>>> should have workable patch.
> >>>> >>>
> >>>> >>>Yeah, so we experimented with changing the interrupt handling in
> >>>> >>>the SCSI driver I maintain to use a threaded handler IRQ handler
> >>>> >>>plus patch below, and saw a significant throughput boost:
> >>>> >>>
> >>>> >>>--->8
> >>>> >>>
> >>>> >>>Subject: [PATCH] genirq: Add support to allow thread to use hard
> >>>> >>>irq affinity
> >>>> >>>
> >>>> >>>Currently the cpu allowed mask for the threaded part of a threaded
> >>>> >>>irq handler will be set to the effective affinity of the hard irq.
> >>>> >>>
> >>>> >>>Typically the effective affinity of the hard irq will be for a
> >>>> >>>single cpu. As such, the threaded handler would always run on the
> >>>same cpu as the hard irq.
> >>>> >>>
> >>>> >>>We have seen scenarios in high data-rate throughput testing that
> >>>> >>>the cpu handling the interrupt can be totally saturated handling
> >>>> >>>both the hard interrupt and threaded handler parts, limiting
> >>>throughput.
> >>>> >>>
> >>>> >>>Add IRQF_IRQ_AFFINITY flag to allow the driver requesting the
> >>>> >>>threaded interrupt to decide on the policy of which cpu the threaded
> >>>handler may run.
> >>>> >>>
> >>>> >>>Signed-off-by: John Garry <john.garry@huawei.com>
> >>>>
> >>>> Thanks for pointing me to this patch. This fixed the interrupt swamp and
> >>>make the system stable.
> >>>>
> >>>> However I'm seeing reduced performance when using threaded
> >>>interrupts.
> >>>>
> >>>> Here are the test results on a system with 80 CPUs and 10 NVMe disks
> >>>> (32 hardware queues for each disk) Benchmark tool is FIO, I/O pattern:
> >>>> 4k random reads on all NVMe disks, with queue depth = 64, num of jobs
> >>>> = 80, direct=1
> >>>>
> >>>> With threaded interrupts: 1320k IOPS
> >>>> With just interrupts: 3720k IOPS
> >>>> With just interrupts and my patch: 3700k IOPS
> >>>
> >>>This gap looks too big wrt. threaded interrupts vs. interrupts.
> >>>
> >>>>
> >>>> At the peak IOPS, the overall CPU usage is at around 98-99%. I think the
> >>>cost of doing wake up and context switch for NVMe threaded IRQ handler
> >>>takes some CPU away.
> >>>>
> >>>
> >>>In theory, it shouldn't be so because most of times the thread should be
> >>>running on CPUs of this hctx, and the wakeup cost shouldn't be so big.
> >>>Maybe there is performance problem somewhere wrt. threaded interrupt.
> >>>
> >>>Could you share us your test script and environment? I will see if I can
> >>>reproduce it in my environment.
> 
> Ming, do you have access to L80s_v2 in Azure? This test needs to run on that VM size.
> 
> Here is the command to benchmark it:
> 
> fio --bs=4k --ioengine=libaio --iodepth=128 --filename=/dev/nvme0n1:/dev/nvme1n1:/dev/nvme2n1:/dev/nvme3n1:/dev/nvme4n1:/dev/nvme5n1:/dev/nvme6n1:/dev/nvme7n1:/dev/nvme8n1:/dev/nvme9n1 --direct=1 --runtime=120 --numjobs=80 --rw=randread --name=test --group_reporting --gtod_reduce=1
> 

I can reproduce the issue on one machine(96 cores) with 4 NVMes(32 queues), so
each queue is served on 3 CPUs.

IOPS drops > 20% when 'use_threaded_interrupts' is enabled. From fio log, CPU
context switch is increased a lot.


Thanks,
Ming
