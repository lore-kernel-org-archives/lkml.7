Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA3622527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THo64cgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfLLWi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:38:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730707AbfLLWi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crHBje/oHds09T3AVYGKwazOp3zA0oqjnOabhZhsT6c=;
        b=THo64cgBOuTEXP5Y/TyzNDrPDm9Bb0eHwSRfpbg/N54E7KM/n6hDPAfnssR7bgB4tppniR
        pEZZRnXV+IHI7ZCKSq0L/f3rbx2z1leeoLiZqtLCazpq/q4QnwYalcfB8UIjxoTeeTV3+3
        +En13ZAq4KiujaoQHos59JPpgojRawk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-xTIrS3i0Plq_M2x7NwcrKA-1; Thu, 12 Dec 2019 17:38:21 -0500
X-MC-Unique: xTIrS3i0Plq_M2x7NwcrKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2DAD107ACC4;
        Thu, 12 Dec 2019 22:38:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 291E210013A1;
        Thu, 12 Dec 2019 22:38:09 +0000 (UTC)
Date:   Fri, 13 Dec 2019 06:38:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        maz@kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk,
        bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191212223805.GA24463@ming.t460p>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2019 at 05:09:18PM +0000, John Garry wrote:
> On 10/12/2019 01:43, Ming Lei wrote:
> > > > > For when the interrupt is managed, allow the threaded part to run on all
> > > > > cpus in the irq affinity mask.
> > > > I remembered that performance drop is observed by this approach in some
> > > > test.
> > >  From checking the thread about the NVMe interrupt swamp, just switching to
> > > threaded handler alone degrades performance. I didn't see any specific
> > > results for this change from Long Li -https://lkml.org/lkml/2019/8/21/128
> 
> Hi Ming,
> 
> > I am pretty clear the reason for Azure, which is caused by aggressive interrupt
> > coalescing, and this behavior shouldn't be very common, and it can be
> > addressed by the following patch:
> 
> I am running some NVMe perf tests with Marc's patch.

We need to confirm that if Marc's patch works as expected, could you
collect log via the attached script?

> 
> I see this almost always eventually (with or without that patch):
> 
> [   66.018140] rcu: INFO: rcu_preempt self-detected stall on CPU2% done]
> [5058MB/0KB/0KB /s] [1295K/0/0 iops] [eta 01m:39s]
> [   66.023885] rcu: 12-....: (5250 ticks this GP)
> idle=182/1/0x4000000000000004 softirq=517/517 fqs=2529
> [   66.033306] (t=5254 jiffies g=733 q=2241)
> [   66.037394] Task dump for CPU 12:
> [   66.040696] fio             R  running task        0   798    796
> 0x00000002
> [   66.047733] Call trace:
> [   66.050173]  dump_backtrace+0x0/0x1a0
> [   66.053823]  show_stack+0x14/0x20
> [   66.057126]  sched_show_task+0x164/0x1a0
> [   66.061036]  dump_cpu_task+0x40/0x2e8
> [   66.064686]  rcu_dump_cpu_stacks+0xa0/0xe0
> [   66.068769]  rcu_sched_clock_irq+0x6d8/0xaa8
> [   66.073027]  update_process_times+0x2c/0x50
> [   66.077198]  tick_sched_handle.isra.14+0x30/0x50
> [   66.081802]  tick_sched_timer+0x48/0x98
> [   66.085625]  __hrtimer_run_queues+0x120/0x1b8
> [   66.089968]  hrtimer_interrupt+0xd4/0x250
> [   66.093966]  arch_timer_handler_phys+0x28/0x40
> [   66.098398]  handle_percpu_devid_irq+0x80/0x140
> [   66.102915]  generic_handle_irq+0x24/0x38
> [   66.106911]  __handle_domain_irq+0x5c/0xb0
> [   66.110995]  gic_handle_irq+0x5c/0x148
> [   66.114731]  el1_irq+0xb8/0x180
> [   66.117858]  efi_header_end+0x94/0x234
> [   66.121595]  irq_exit+0xd0/0xd8
> [   66.124724]  __handle_domain_irq+0x60/0xb0
> [   66.128806]  gic_handle_irq+0x5c/0x148
> [   66.132542]  el0_irq_naked+0x4c/0x54
> [   97.152870] rcu: INFO: rcu_preempt self-detected stall on CPU8% done]
> [4736MB/0KB/0KB /s] [1212K/0/0 iops] [eta 01m:08s]
> [   97.158616] rcu: 8-....: (1 GPs behind) idle=08e/1/0x4000000000000002
> softirq=462/505 fqs=2621
> [   97.167414] (t=5253 jiffies g=737 q=5507)
> [   97.171498] Task dump for CPU 8:
> [pu_task+0x40/0x2e8
> [   97.198705]  rcu_dump_cpu_stacks+0xa0/0xe0
> [   97.202788]  rcu_sched_clock_irq+0x6d8/0xaa8
> [   97.207046]  update_process_times+0x2c/0x50
> [   97.211217]  tick_sched_handle.isra.14+0x30/0x50
> [   97.215820]  tick_sched_timer+0x48/0x98
> [   97.219644]  __hrtimer_run_queues+0x120/0x1b8
> [   97.223989]  hrtimer_interrupt+0xd4/0x250
> [   97.227987]  arch_timer_handler_phys+0x28/0x40
> [   97.232418]  handle_percpu_devid_irq+0x80/0x140
> [   97.236935]  generic_handle_irq+0x24/0x38
> [   97.240931]  __handle_domain_irq+0x5c/0xb0
> [   97.245015]  gic_handle_irq+0x5c/0x148
> [   97.248751]  el1_irq+0xb8/0x180
> [   97.251880]  find_busiest_group+0x18c/0x9e8
> [   97.256050]  load_balance+0x154/0xb98
> [   97.259700]  rebalance_domains+0x1cc/0x2f8
> [   97.263783]  run_rebalance_domains+0x78/0xe0
> [   97.268040]  efi_header_end+0x114/0x234
> [   97.271864]  run_ksoftirqd+0x38/0x48
> [   97.275427]  smpboot_thread_fn+0x16c/0x270
> [   97.279511]  kthread+0x118/0x120
> [   97.282726]  ret_from_fork+0x10/0x18
> [   97.286289] Task dump for CPU 12:
> [   97.289591] kworker/12:1    R  running task        0   570      2
> 0x0000002a
> [   97.296634] Workqueue:  0x0 (mm_percpu_wq)
> [   97.300718] Call trace:
> [   97.303152]  __switch_to+0xbc/0x218
> [   97.306632]  page_wait_table+0x1500/0x1800
> 
> Would this be the same interrupt "swamp" issue?

It could be, but reason need to investigated.

You never provide the test details(how many drives, how many disks
attached to each drive) as I asked, so I can't comment on the reason,
also no reason shows that the patch is a good fix.

My theory is simple, so far, the CPU is still much quicker than
current storage in case that IO aren't from multiple disks which are
connected to same drive.

Thanks, 
Ming

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dump-io-irq-affinity

#!/bin/sh

get_disk_from_pcid()
{
	PCID=$1

	DISKS=`find /sys/block -name "*"`
	for DISK in $DISKS; do
		DISKP=`realpath $DISK/device`
		echo $DISKP | grep $PCID > /dev/null
		[ $? -eq 0 ] && echo `basename $DISK` && break
	done
}

dump_irq_affinity()
{
	PCID=$1
	PCIP=`find /sys/devices -name *$PCID | grep pci`

	[[ ! -d $PCIP/msi_irqs ]] && return

	IRQS=`ls $PCIP/msi_irqs`

	[ $? -ne 0 ] && return

	DISK=`get_disk_from_pcid $PCID`
	echo "PCI name is $PCID: $DISK"

	for IRQ in $IRQS; do
	    [ -f /proc/irq/$IRQ/smp_affinity_list ] && CPUS=`cat /proc/irq/$IRQ/smp_affinity_list`
	    [ -f /proc/irq/$IRQ/effective_affinity_list ] && ECPUS=`cat /proc/irq/$IRQ/effective_affinity_list`
	    echo -e "\tirq $IRQ, cpu list $CPUS, effective list $ECPUS"
	done
}


if [ $# -ge 1 ]; then
	PCIDS=$1
else
#	PCID=`lspci | grep "Non-Volatile memory" | cut -c1-7`
	PCIDS=`lspci | grep "Non-Volatile memory controller" | awk '{print $1}'`
fi

echo "kernel version: "
uname -a

for PCID in $PCIDS; do
	dump_irq_affinity $PCID
done

--liOOAslEiF7prFVr--

