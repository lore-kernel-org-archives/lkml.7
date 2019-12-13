Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E137C79DCF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D46246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9vdf8oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLMRMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:12:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728384AbfLMRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576257165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EuwWqmoCwmKvBUFDbZjYP8hq4gfxWivjFxYy8JJ24fs=;
        b=R9vdf8oAoettXD4PgGkGNfASykzq49WVIodNm4rEJJ0WWzWNgkM666c5+OBtGWBSLtGDrE
        5/CXk2V7AQNUNv2PqsCOdMzgf2VJjtkXc80ugunjWPvvNdHAIXcNfr+pAK3jApxwx7f5L8
        fBrrYuRoTHu7+LCB2KMoxkwP3fLjtNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-i4D-RFWKNvGFbcdc-vXO5g-1; Fri, 13 Dec 2019 12:12:38 -0500
X-MC-Unique: i4D-RFWKNvGFbcdc-vXO5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64938911A3;
        Fri, 13 Dec 2019 17:12:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B36801CB;
        Fri, 13 Dec 2019 17:12:27 +0000 (UTC)
Date:   Sat, 14 Dec 2019 01:12:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>, "hare@suse.com" <hare@suse.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191213171222.GA17267@ming.t460p>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f3bcea-84ec-f9f6-a3aa-007ae712415f@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 03:43:07PM +0000, John Garry wrote:
> On 13/12/2019 13:18, Ming Lei wrote:
> 
> Hi Ming,
> 
> > 
> > On Fri, Dec 13, 2019 at 11:12:49AM +0000, John Garry wrote:
> > > Hi Ming,
> > > 
> > > > > I am running some NVMe perf tests with Marc's patch.
> > > > 
> > > > We need to confirm that if Marc's patch works as expected, could you
> > > > collect log via the attached script?
> > > 
> > > As immediately below, I see this on vanilla mainline, so let's see what the
> > > issue is without that patch.
> > 
> > IMO, the interrupt load needs to be distributed as what X86 IRQ matrix
> > does. If the ARM64 server doesn't do that, the 1st step should align to
> > that.
> 
> That would make sense. But still, I would like to think that a CPU could
> sink the interrupts from 2x queues.
> 
> > 
> > Also do you pass 'use_threaded_interrupts=1' in your test?
> 
> When I set this, then, as I anticipated, no lockup. But IOPS drops from ~ 1M
> IOPS->800K.
> 
> > 
> > > 
> > > >   >
> > > > You never provide the test details(how many drives, how many disks
> > > > attached to each drive) as I asked, so I can't comment on the reason,
> > > > also no reason shows that the patch is a good fix.
> > > 
> > > So I have only 2x ES3000 V3s. This looks like the same one:
> > > https://actfornet.com/HUAWEI_SERVER_DOCS/PCIeSSD/Huawei%20ES3000%20V3%20NVMe%20PCIe%20SSD%20Data%20Sheet.pdf
> > > 
> > > > 
> > > > My theory is simple, so far, the CPU is still much quicker than
> > > > current storage in case that IO aren't from multiple disks which are
> > > > connected to same drive.
> > > 
> 
> [...]
> 
> > > irq 98, cpu list 88-91, effective list 88
> > > irq 99, cpu list 92-95, effective list 92
> > The above log shows there are two nvme drives, each drive has 24 hw
> > queues.
> > 
> > Also the system has 96 cores, and 96 > 24 * 2, so if everything is fine,
> > each hw queue can be assigned one unique effective CPU for handling
> > the queue's interrupt.
> > 
> > Because arm64's gic driver doesn't distribute irq's effective cpu affinity,
> > each hw queue is assigned same CPU to handle its interrupt.
> > 
> > As you saw, the detected RCU stall is on CPU0, which is for handling
> > both irq 77 and irq 100.
> > 
> > Please apply Marc's patch and observe if unique effective CPU is
> > assigned to each hw queue's irq.
> > 
> 
> Same issue:
> 
> 979826] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse
> [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input1
> [   38.772536] IRQ25 CPU14 -> CPU3
> [   38.777138] IRQ58 CPU8 -> CPU17
> [  119.499459] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  119.505202] rcu: 16-....: (1 GPs behind) idle=a8a/1/0x4000000000000002
> softirq=952/1211 fqs=2625
> [  119.514188] (t=5253 jiffies g=2613 q=4573)
> [  119.514193] Task dump for CPU 16:
> [  119.514197] ksoftirqd/16    R  running task        0    91      2
> 0x0000002a
> [  119.514206] Call trace:
> [  119.514224]  dump_backtrace+0x0/0x1a0
> [  119.514228]  show_stack+0x14/0x20
> [  119.514236]  sched_show_task+0x164/0x1a0
> [  119.514240]  dump_cpu_task+0x40/0x2e8
> [  119.514245]  rcu_dump_cpu_stacks+0xa0/0xe0
> [  119.514247]  rcu_sched_clock_irq+0x6d8/0xaa8
> [  119.514251]  update_process_times+0x2c/0x50
> [  119.514258]  tick_sched_handle.isra.14+0x30/0x50
> [  119.514261]  tick_sched_timer+0x48/0x98
> [  119.514264]  __hrtimer_run_queues+0x120/0x1b8
> [  119.514266]  hrtimer_interrupt+0xd4/0x250
> [  119.514277]  arch_timer_handler_phys+0x28/0x40
> [  119.514280]  handle_percpu_devid_irq+0x80/0x140
> [  119.514283]  generic_handle_irq+0x24/0x38
> [  119.514285]  __handle_domain_irq+0x5c/0xb0
> [  119.514299]  gic_handle_irq+0x5c/0x148
> [  119.514301]  el1_irq+0xb8/0x180
> [  119.514305]  load_balance+0x478/0xb98
> [  119.514308]  rebalance_domains+0x1cc/0x2f8
> [  119.514311]  run_rebalance_domains+0x78/0xe0
> [  119.514313]  efi_header_end+0x114/0x234
> [  119.514317]  run_ksoftirqd+0x38/0x48
> [  119.514322]  smpboot_thread_fn+0x16c/0x270
> [  119.514324]  kthread+0x118/0x120
> [  119.514326]  ret_from_fork+0x10/0x18
> john@ubuntu:~$ ./dump-io-irq-affinity
> kernel version:
> Linux ubuntu 5.5.0-rc1-00003-g7adc5d7ec1ca-dirty #1440 SMP PREEMPT Fri Dec
> 13 14:53:19 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
> PCI name is 04:00.0: nvme0n1
> irq 56, cpu list 75, effective list 5
> irq 60, cpu list 24-28, effective list 10

The effect list supposes to be subset of irq's affinity(24-28).

> irq 61, cpu list 29-33, effective list 7
> irq 62, cpu list 34-38, effective list 5
> irq 63, cpu list 39-43, effective list 6
> irq 64, cpu list 44-47, effective list 8
> irq 65, cpu list 48-51, effective list 9
> irq 66, cpu list 52-55, effective list 10
> irq 67, cpu list 56-59, effective list 11
> irq 68, cpu list 60-63, effective list 12
> irq 69, cpu list 64-67, effective list 13
> irq 70, cpu list 68-71, effective list 14
> irq 71, cpu list 72-75, effective list 15
> irq 72, cpu list 76-79, effective list 16
> irq 73, cpu list 80-83, effective list 17
> irq 74, cpu list 84-87, effective list 18
> irq 75, cpu list 88-91, effective list 19
> irq 76, cpu list 92-95, effective list 20

Same with above, so looks Marc's patch is wrong.

> irq 77, cpu list 0-3, effective list 3
> irq 78, cpu list 4-7, effective list 4
> irq 79, cpu list 8-11, effective list 8
> irq 80, cpu list 12-15, effective list 12
> irq 81, cpu list 16-19, effective list 16
> irq 82, cpu list 20-23, effective list 23
> PCI name is 81:00.0: nvme1n1
> irq 100, cpu list 0-3, effective list 0
> irq 101, cpu list 4-7, effective list 5
> irq 102, cpu list 8-11, effective list 9
> irq 103, cpu list 12-15, effective list 13
> irq 104, cpu list 16-19, effective list 17
> irq 105, cpu list 20-23, effective list 21
> irq 57, cpu list 63, effective list 7
> irq 83, cpu list 24-28, effective list 5
> irq 84, cpu list 29-33, effective list 6
> irq 85, cpu list 34-38, effective list 8
> irq 86, cpu list 39-43, effective list 9
> irq 87, cpu list 44-47, effective list 10
> irq 88, cpu list 48-51, effective list 11
> irq 89, cpu list 52-55, effective list 12
> irq 90, cpu list 56-59, effective list 13
> irq 91, cpu list 60-63, effective list 14
> irq 92, cpu list 64-67, effective list 15
> irq 93, cpu list 68-71, effective list 16
> irq 94, cpu list 72-75, effective list 17
> irq 95, cpu list 76-79, effective list 18
> irq 96, cpu list 80-83, effective list 19
> irq 97, cpu list 84-87, effective list 20
> irq 98, cpu list 88-91, effective list 21
> irq 99, cpu list 92-95, effective list 22

More are wrong.

> john@ubuntu:~$
> 
> but you can see that CPU16 is handling irq72, 81, and 93.

As I mentioned, the effective affinity has to be subset of the irq's
affinity.

> 
> > If unique effective CPU is assigned to each hw queue's irq, and the RCU
> > stall can still be triggered, let's investigate further, given one single
> > ARM64 CPU core should be quick enough to handle IO completion from single
> > NVNe drive.
> 
> If I remove the code for bring the affinity within the ITS numa node mask -
> as Marc hinted - then I still get a lockup, but we still we have CPUs
> serving multiple interrupts:
> 
>   116.166881] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  116.181432] Task dump for CPU 4:
> [  116.181502] Task dump for CPU 8:
> john@ubuntu:~$ ./dump-io-irq-affinity
> kernel version:
> Linux ubuntu 5.5.0-rc1-00003-g7adc5d7ec1ca-dirty #1443 SMP PREEMPT Fri Dec
> 13 15:29:55 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
> PCI name is 04:00.0: nvme0n1
> irq 56, cpu list 75, effective list 75
> irq 60, cpu list 24-28, effective list 25
> irq 61, cpu list 29-33, effective list 29
> irq 62, cpu list 34-38, effective list 34
> irq 63, cpu list 39-43, effective list 39
> irq 64, cpu list 44-47, effective list 44
> irq 65, cpu list 48-51, effective list 49
> irq 66, cpu list 52-55, effective list 55
> irq 67, cpu list 56-59, effective list 56
> irq 68, cpu list 60-63, effective list 61
> irq 69, cpu list 64-67, effective list 64
> irq 70, cpu list 68-71, effective list 68
> irq 71, cpu list 72-75, effective list 73
> irq 72, cpu list 76-79, effective list 76
> irq 73, cpu list 80-83, effective list 80
> irq 74, cpu list 84-87, effective list 85
> irq 75, cpu list 88-91, effective list 88
> irq 76, cpu list 92-95, effective list 92
> irq 77, cpu list 0-3, effective list 1
> irq 78, cpu list 4-7, effective list 4
> irq 79, cpu list 8-11, effective list 8
> irq 80, cpu list 12-15, effective list 14
> irq 81, cpu list 16-19, effective list 16
> irq 82, cpu list 20-23, effective list 20
> PCI name is 81:00.0: nvme1n1
> irq 100, cpu list 0-3, effective list 0
> irq 101, cpu list 4-7, effective list 4
> irq 102, cpu list 8-11, effective list 8
> irq 103, cpu list 12-15, effective list 13
> irq 104, cpu list 16-19, effective list 16
> irq 105, cpu list 20-23, effective list 20
> irq 57, cpu list 63, effective list 63
> irq 83, cpu list 24-28, effective list 26
> irq 84, cpu list 29-33, effective list 31
> irq 85, cpu list 34-38, effective list 35
> irq 86, cpu list 39-43, effective list 40
> irq 87, cpu list 44-47, effective list 45
> irq 88, cpu list 48-51, effective list 50
> irq 89, cpu list 52-55, effective list 52
> irq 90, cpu list 56-59, effective list 57
> irq 91, cpu list 60-63, effective list 62
> irq 92, cpu list 64-67, effective list 65
> irq 93, cpu list 68-71, effective list 69
> irq 94, cpu list 72-75, effective list 74
> irq 95, cpu list 76-79, effective list 77
> irq 96, cpu list 80-83, effective list 81
> irq 97, cpu list 84-87, effective list 86
> irq 98, cpu list 88-91, effective list 89
> irq 99, cpu list 92-95, effective list 93
> john@ubuntu:~$
> 
> I'm now thinking that we should just attempt this intelligent CPU affinity
> assignment for managed interrupts.

Right, the rule is simple: distribute effective list among CPUs evenly,
meantime select the effective CPU from the irq's affinity mask.


Thanks,
Ming

