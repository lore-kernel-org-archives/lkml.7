Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6CDC04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 02:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708282063F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 02:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEEC0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 22:26:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfEEC0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 22:26:30 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 610C686769A485A10BEA;
        Sun,  5 May 2019 10:26:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 5 May 2019
 10:26:19 +0800
To:     <linux-kernel@vger.kernel.org>
From:   Heyi Guo <guoheyi@huawei.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
Subject: ARM/gic-v4: deadlock occurred
Message-ID: <9efe0260-4a84-7489-ecdd-2e9561599320@huawei.com>
Date:   Sun, 5 May 2019 10:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We observed deadlocks after enabling GICv4 and PCI passthrough on ARM64 virtual
machines, when not pinning VCPU to physical CPU.

We observed below warnings after enabling lockdep debug in kernel:

[  362.847021] =====================================================
[  362.855643] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[  362.864840] 4.19.34+ #7 Tainted: G        W
[  362.872314] -----------------------------------------------------
[  362.881034] CPU 0/KVM/51468 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  362.890504] 00000000659c1dc9 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.22+0x0/0x48
[  362.901413]
[  362.901413] and this task is already holding:
[  362.912976] 000000007318873f (&dev->event_map.vlpi_lock){....}, at: its_irq_set_vcpu_affinity+0x134/0x638
[  362.928626] which would create a new lock dependency:
[  362.936837]  (&dev->event_map.vlpi_lock){....} -> (fs_reclaim){+.+.}
[  362.946449]
[  362.946449] but this new dependency connects a HARDIRQ-irq-safe lock:
[  362.960877]  (&irq_desc_lock_class){-.-.}
[  362.960880]
[  362.960880] ... which became HARDIRQ-irq-safe at:
[  362.981234]   lock_acquire+0xf0/0x258
[  362.988337]   _raw_spin_lock+0x54/0x90
[  362.995543]   handle_fasteoi_irq+0x2c/0x198
[  363.003205]   generic_handle_irq+0x34/0x50
[  363.010787]   __handle_domain_irq+0x68/0xc0
[  363.018500]   gic_handle_irq+0xf4/0x1e0
[  363.025913]   el1_irq+0xc8/0x180
[  363.032683]   _raw_spin_unlock_irq+0x40/0x60
[  363.040512]   finish_task_switch+0x98/0x258
[  363.048254]   __schedule+0x350/0xca8
[  363.055359]   schedule+0x40/0xa8
[  363.062098]   worker_thread+0xd8/0x410
[  363.069340]   kthread+0x134/0x138
[  363.076070]   ret_from_fork+0x10/0x18
[  363.083111]
[  363.083111] to a HARDIRQ-irq-unsafe lock:
[  363.095213]  (fs_reclaim){+.+.}
[  363.095216]
[  363.095216] ... which became HARDIRQ-irq-unsafe at:
[  363.114527] ...
[  363.114530]   lock_acquire+0xf0/0x258
[  363.126269]   fs_reclaim_acquire.part.22+0x3c/0x48
[  363.134206]   fs_reclaim_acquire+0x2c/0x38
[  363.141363]   kmem_cache_alloc_trace+0x44/0x368
[  363.148892]   acpi_os_map_iomem+0x9c/0x208
[  363.155934]   acpi_os_map_memory+0x28/0x38
[  363.162831]   acpi_tb_acquire_table+0x58/0x8c
[  363.170021]   acpi_tb_validate_table+0x34/0x58
[  363.177162]   acpi_tb_get_table+0x4c/0x90
[  363.183741]   acpi_get_table+0x94/0xc4
[  363.190020]   find_acpi_cpu_topology_tag+0x54/0x240
[  363.197404]   find_acpi_cpu_topology_package+0x28/0x38
[  363.204985]   init_cpu_topology+0xdc/0x1e4
[  363.211498]   smp_prepare_cpus+0x2c/0x108
[  363.217882]   kernel_init_freeable+0x130/0x508
[  363.224699]   kernel_init+0x18/0x118
[  363.230624]   ret_from_fork+0x10/0x18
[  363.236611]
[  363.236611] other info that might help us debug this:
[  363.236611]
[  363.251604] Chain exists of:
[  363.251604]   &irq_desc_lock_class --> &dev->event_map.vlpi_lock --> fs_reclaim
[  363.251604]
[  363.270508]  Possible interrupt unsafe locking scenario:
[  363.270508]
[  363.282238]        CPU0                    CPU1
[  363.289228]        ----                    ----
[  363.296189]   lock(fs_reclaim);
[  363.301726]                                local_irq_disable();
[  363.310122] lock(&irq_desc_lock_class);
[  363.319143] lock(&dev->event_map.vlpi_lock);
[  363.328617]   <Interrupt>
[  363.333713]     lock(&irq_desc_lock_class);
[  363.340414]
[  363.340414]  *** DEADLOCK ***
[  363.340414]
[  363.353682] 5 locks held by CPU 0/KVM/51468:
[  363.360412]  #0: 00000000eeb852a5 (&vdev->igate){+.+.}, at: vfio_pci_ioctl+0x2f8/0xed0
[  363.370915]  #1: 000000002ab491f7 (lock#9){+.+.}, at: irq_bypass_register_producer+0x6c/0x1d0
[  363.382139]  #2: 000000000d9fd5c6 (&its->its_lock){+.+.}, at: kvm_vgic_v4_set_forwarding+0xd0/0x188
[  363.396625]  #3: 00000000232bdc47 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x60/0xa0
[  363.408486]  #4: 000000007318873f (&dev->event_map.vlpi_lock){....}, at: its_irq_set_vcpu_affinity+0x134/0x638


Then we found that irq_set_vcpu_affinity() in kernel/irq/manage.c aquires an
antomic context by irq_get_desc_lock() at the beginning, but in
its_irq_set_vcpu_affinity() (drivers/irqchip/irq-gic-v3-its.c) we are still
using mutext_lock, kcalloc, kfree, etc, which we think should be forbidden in
atomic context.

Though the issue is observed in 4.19.34, we don't find any related fixes in the mainline yet.

Please advise.

Thanks,

Heyi



