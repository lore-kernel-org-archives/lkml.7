Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BD82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfLKRJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:09:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729512AbfLKRJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:09:22 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0AD9CE01575F78853AA3;
        Wed, 11 Dec 2019 17:09:20 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Dec 2019 17:09:19 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 17:09:19 +0000
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Ming Lei <ming.lei@redhat.com>
CC:     <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
Date:   Wed, 11 Dec 2019 17:09:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191210014335.GA25022@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 01:43, Ming Lei wrote:
>>>> For when the interrupt is managed, allow the threaded part to run on all
>>>> cpus in the irq affinity mask.
>>> I remembered that performance drop is observed by this approach in some
>>> test.
>>  From checking the thread about the NVMe interrupt swamp, just switching to
>> threaded handler alone degrades performance. I didn't see any specific
>> results for this change from Long Li -https://lkml.org/lkml/2019/8/21/128

Hi Ming,

> I am pretty clear the reason for Azure, which is caused by aggressive interrupt
> coalescing, and this behavior shouldn't be very common, and it can be
> addressed by the following patch:

I am running some NVMe perf tests with Marc's patch.

I see this almost always eventually (with or without that patch):

[   66.018140] rcu: INFO: rcu_preempt self-detected stall on CPU2% done] 
[5058MB/0KB/0KB /s] [1295K/0/0 iops] [eta 01m:39s]
[   66.023885] rcu: 12-....: (5250 ticks this GP) 
idle=182/1/0x4000000000000004 softirq=517/517 fqs=2529
[   66.033306] (t=5254 jiffies g=733 q=2241)
[   66.037394] Task dump for CPU 12:
[   66.040696] fio             R  running task        0   798    796 
0x00000002
[   66.047733] Call trace:
[   66.050173]  dump_backtrace+0x0/0x1a0
[   66.053823]  show_stack+0x14/0x20
[   66.057126]  sched_show_task+0x164/0x1a0
[   66.061036]  dump_cpu_task+0x40/0x2e8
[   66.064686]  rcu_dump_cpu_stacks+0xa0/0xe0
[   66.068769]  rcu_sched_clock_irq+0x6d8/0xaa8
[   66.073027]  update_process_times+0x2c/0x50
[   66.077198]  tick_sched_handle.isra.14+0x30/0x50
[   66.081802]  tick_sched_timer+0x48/0x98
[   66.085625]  __hrtimer_run_queues+0x120/0x1b8
[   66.089968]  hrtimer_interrupt+0xd4/0x250
[   66.093966]  arch_timer_handler_phys+0x28/0x40
[   66.098398]  handle_percpu_devid_irq+0x80/0x140
[   66.102915]  generic_handle_irq+0x24/0x38
[   66.106911]  __handle_domain_irq+0x5c/0xb0
[   66.110995]  gic_handle_irq+0x5c/0x148
[   66.114731]  el1_irq+0xb8/0x180
[   66.117858]  efi_header_end+0x94/0x234
[   66.121595]  irq_exit+0xd0/0xd8
[   66.124724]  __handle_domain_irq+0x60/0xb0
[   66.128806]  gic_handle_irq+0x5c/0x148
[   66.132542]  el0_irq_naked+0x4c/0x54
[   97.152870] rcu: INFO: rcu_preempt self-detected stall on CPU8% done] 
[4736MB/0KB/0KB /s] [1212K/0/0 iops] [eta 01m:08s]
[   97.158616] rcu: 8-....: (1 GPs behind) idle=08e/1/0x4000000000000002 
softirq=462/505 fqs=2621
[   97.167414] (t=5253 jiffies g=737 q=5507)
[   97.171498] Task dump for CPU 8:
[pu_task+0x40/0x2e8
[   97.198705]  rcu_dump_cpu_stacks+0xa0/0xe0
[   97.202788]  rcu_sched_clock_irq+0x6d8/0xaa8
[   97.207046]  update_process_times+0x2c/0x50
[   97.211217]  tick_sched_handle.isra.14+0x30/0x50
[   97.215820]  tick_sched_timer+0x48/0x98
[   97.219644]  __hrtimer_run_queues+0x120/0x1b8
[   97.223989]  hrtimer_interrupt+0xd4/0x250
[   97.227987]  arch_timer_handler_phys+0x28/0x40
[   97.232418]  handle_percpu_devid_irq+0x80/0x140
[   97.236935]  generic_handle_irq+0x24/0x38
[   97.240931]  __handle_domain_irq+0x5c/0xb0
[   97.245015]  gic_handle_irq+0x5c/0x148
[   97.248751]  el1_irq+0xb8/0x180
[   97.251880]  find_busiest_group+0x18c/0x9e8
[   97.256050]  load_balance+0x154/0xb98
[   97.259700]  rebalance_domains+0x1cc/0x2f8
[   97.263783]  run_rebalance_domains+0x78/0xe0
[   97.268040]  efi_header_end+0x114/0x234
[   97.271864]  run_ksoftirqd+0x38/0x48
[   97.275427]  smpboot_thread_fn+0x16c/0x270
[   97.279511]  kthread+0x118/0x120
[   97.282726]  ret_from_fork+0x10/0x18
[   97.286289] Task dump for CPU 12:
[   97.289591] kworker/12:1    R  running task        0   570      2 
0x0000002a
[   97.296634] Workqueue:  0x0 (mm_percpu_wq)
[   97.300718] Call trace:
[   97.303152]  __switch_to+0xbc/0x218
[   97.306632]  page_wait_table+0x1500/0x1800

Would this be the same interrupt "swamp" issue?

> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-November/028008.html
> 

What is the status of these patches? I did not see them in mainline.

> Then please share your lockup story, such as, which HBA/drivers, test steps,
> if you complete IOs from multiple disks(LUNs) on single CPU, if you have
> multiple queues, how many active LUNs involved in the test, ...
> 
> 

Thanks,
John

