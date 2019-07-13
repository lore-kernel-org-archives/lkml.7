Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ACC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2661B2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGMLhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:37:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfGMLhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:37:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A961A28;
        Sat, 13 Jul 2019 04:37:09 -0700 (PDT)
Received: from why (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAADD3F59C;
        Sat, 13 Jul 2019 04:37:08 -0700 (PDT)
Date:   Sat, 13 Jul 2019 12:37:04 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Guoheyi <guoheyi@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Subject: Re: ARM/gic-v4: deadlock occurred
Message-ID: <20190713123704.2d8a308c@why>
In-Reply-To: <dbbf516d-3326-a948-8617-db6b6ec0ceed@huawei.com>
References: <9efe0260-4a84-7489-ecdd-2e9561599320@huawei.com>
        <86lfzl9ofe.wl-marc.zyngier@arm.com>
        <0b413592-7d98-ebe8-35c5-da330f800326@huawei.com>
        <86a7fx9lg8.wl-marc.zyngier@arm.com>
        <4d60d130-b7ce-96cb-5f8a-11e83329601a@huawei.com>
        <868svg9igl.wl-marc.zyngier@arm.com>
        <dbbf516d-3326-a948-8617-db6b6ec0ceed@huawei.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 19:08:57 +0800
Guoheyi <guoheyi@huawei.com> wrote:

Hi Heyi,

> Hi Marc,
> 
> Really sorry for the delay of testing the rework patches. I picked up
> the work these days and applied the patches to our 4.19.36 stable
> branch. However, I got below panic during the boot process of host
> (not yet to boot guests).
> 
> I supposed the result was not related with my testing kernel version,
> for we don't have many differences in ITS driver; I can test against
> mainline if you think it is necessary.

In general, please report bugs against mainline. There isn't much I can
do about your private tree...

That being said, a couple of comments below.

> Thanks,
> 
> Heyi
> 
> 
> [   16.990413] iommu: Adding device 0000:00:00.0 to group 6
> [   17.000691] pcieport 0000:00:00.0: Signaling PME with IRQ 133
> [   17.006456] pcieport 0000:00:00.0: AER enabled with IRQ 134
> [   17.012151] iommu: Adding device 0000:00:08.0 to group 7
> [   17.018575] Unable to handle kernel paging request at virtual address 00686361635f746f
> [   17.026467] Mem abort info:
> [   17.029251]   ESR = 0x96000004
> [   17.032313]   Exception class = DABT (current EL), IL = 32 bits
> [   17.038207]   SET = 0, FnV = 0
> [   17.041258]   EA = 0, S1PTW = 0
> [   17.044391] Data abort info:
> [   17.047260]   ISV = 0, ISS = 0x00000004
> [   17.051081]   CM = 0, WnR = 0
> [   17.054035] [00686361635f746f] address between user and kernel address ranges
> [   17.061140] Internal error: Oops: 96000004 [#1] SMP
> [   17.065997] Process kworker/0:4 (pid: 889, stack limit = 0x(____ptrval____))
> [   17.073013] CPU: 0 PID: 889 Comm: kworker/0:4 Not tainted 4.19.36+ #8
> [   17.079422] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 0.52 06/20/2019
> [   17.086788] Workqueue: events work_for_cpu_fn
> [   17.091126] pstate: 20c00009 (nzCv daif +PAN +UAO)
> [   17.095895] pc : __kmalloc_track_caller+0xb0/0x2a0
> [   17.100662] lr : __kmalloc_track_caller+0x64/0x2a0
> [   17.105429] sp : ffff00002920ba00
> [   17.108728] x29: ffff00002920ba00 x28: ffff802cb6792780
> [   17.114015] x27: 00000000006080c0 x26: 00000000006000c0
> [   17.119302] x25: ffff0000084c8a00 x24: ffff802cbfc0fc00
> [   17.124588] x23: ffff802cbfc0fc00 x22: ffff0000084c8a00
> [   17.129875] x21: 0000000000000004 x20: 00000000006000c0
> [   17.135161] x19: 65686361635f746f x18: ffffffffffffffff
> [   17.140448] x17: 000000000000000e x16: 0000000000000007
> [   17.145734] x15: ffff000009119708 x14: 0000000000000000
> [   17.151021] x13: 0000000000000003 x12: 0000000000000000
> [   17.156307] x11: 0000000005f5e0ff x10: ffff00002920bb80
> [   17.161594] x9 : 00000000ffffffd0 x8 : 0000000000000098
> [   17.166880] x7 : ffff00002920bb80 x6 : ffff000008a8cb98
> [   17.172167] x5 : 000000000000a705 x4 : ffff803f802d22e0
> [   17.177453] x3 : ffff00002920b990 x2 : ffff7e00b2dafd00
> [   17.182740] x1 : 0000803f77476000 x0 : 0000000000000000
> [   17.188027] Call trace:
> [   17.190461]  __kmalloc_track_caller+0xb0/0x2a0
> [   17.194886]  kvasprintf+0x7c/0x108
> [   17.198271]  kasprintf+0x60/0x80
> [   17.201488]  populate_msi_sysfs+0xe4/0x250
> [   17.205564]  __pci_enable_msi_range+0x278/0x450
> [   17.210073]  pci_alloc_irq_vectors_affinity+0xd4/0x110
> [   17.215188]  pcie_port_device_register+0x134/0x558
> [   17.219955]  pcie_portdrv_probe+0x3c/0xf0
> [   17.223947]  local_pci_probe+0x44/0xa8
> [   17.227679]  work_for_cpu_fn+0x20/0x30
> [   17.231411]  process_one_work+0x1b4/0x3f8
> [   17.235401]  worker_thread+0x210/0x470
> [   17.239134]  kthread+0x134/0x138
> [   17.242348]  ret_from_fork+0x10/0x18
> [   17.245907] Code: f100005f fa401a64 54000bc0 b9402300 (f8606a66)
> [   17.251970] kernel fault(0x1) notification starting on CPU 0
> [   17.257602] kernel fault(0x1) notification finished on CPU 0
> [   17.263234] Modules linked in:
> [   17.266277] ---[ end trace 023e6b19cb68b94f ]---

What in this trace makes you think that this has anything to do with an
ITS change? The system crashes in a completely unrelated piece of code.
Also, if you look at the VA that indicates the crash, it should be
obvious that this isn't a kernel address. Worse, this is a piece of
ASCII text:

$ echo 00686361635f746f | xxd -r -p
hcac_to

This tends to indicate some memory form of corruption ("hcac_to" looks
like the begining of a symbol), and I'm not sure how the ITS would be
involved in this... Furthermore, this happens on the host at boot time,
while the patch you suspect only affects VMs...

I think you need to spend more time analysing this issue.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
