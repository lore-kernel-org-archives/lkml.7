Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6999C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D92199C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGXHnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:55396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfGXHnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96ADBB02A;
        Wed, 24 Jul 2019 07:43:14 +0000 (UTC)
To:     Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Subject: 5.3-rc1 BUGS in dma_addressing_limited
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cda1952f-0265-e055-a3ce-237c59069a3f@suse.com>
Date:   Wed, 24 Jul 2019 10:43:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph, 

5.3-rc1 crashes for me when run in qemu with scsi disks. 
Quick investigation shows that the following triggers a BUG_ON: 

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e11b115dd0e4..4465e352b8dd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -689,6 +689,7 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
+       BUG_ON(!(dev->dma_mask));
        return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
                dma_get_required_mask(dev);


Otherwise here is what the real backtrace looks like: 

[    5.387839] scsi host0: Virtio SCSI HBA
[    5.389860] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    5.390217] #PF: supervisor read access in kernel mode
[    5.390520] #PF: error_code(0x0000) - not-present page
[    5.390813] PGD 0 P4D 0 
[    5.391007] Oops: 0000 [#1] SMP
[    5.391007] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc1-default #578
[    5.391007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    5.391007] RIP: 0010:dma_direct_max_mapping_size+0x21/0x80
[    5.391007] Code: 0f b6 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 55 53 48 89 fb e8 f1 0e 00 00 84 c0 74 42 48 8b 83 e8 01 00 00 48 8b ab f8 01 00 00 <48> 8b 00 48 85 c0 74 0c 48 85 ed 74 31 48 39 c5 48 0f 47 e8 48 89
[    5.391007] RSP: 0000:ffffb0edc0013ac0 EFLAGS: 00010202
[    5.391007] RAX: 0000000000000000 RBX: ffff9216f9d8b838 RCX: 0000000000000000
[    5.391007] RDX: 0000000000000000 RSI: 000000000000007e RDI: ffff9216f9d8b838
[    5.391007] RBP: 0000000000000000 R08: 0000000249ffd97b R09: 0000000000000001
[    5.391007] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9216f9d8b838
[    5.391007] R13: 000000000000ffff R14: ffff9216f7348580 R15: 0000000000000000
[    5.391007] FS:  0000000000000000(0000) GS:ffff9216fba00000(0000) knlGS:0000000000000000
[    5.391007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.391007] CR2: 0000000000000000 CR3: 000000007a211000 CR4: 00000000000006e0
[    5.391007] Call Trace:
[    5.391007]  __scsi_init_queue+0x75/0x130
[    5.391007]  scsi_mq_alloc_queue+0x34/0x50
[    5.391007]  scsi_alloc_sdev+0x232/0x300
[    5.391007]  scsi_probe_and_add_lun+0x482/0xda0
[    5.391007]  ? scsi_alloc_target+0x282/0x340
[    5.391007]  __scsi_scan_target+0xe6/0x610
[    5.391007]  ? sched_clock_local+0x12/0x80
[    5.391007]  ? sched_clock_cpu+0x94/0xc0
[    5.391007]  scsi_scan_channel.part.15+0x55/0x70
[    5.391007]  scsi_scan_host_selected+0xd7/0x180
[    5.391007]  virtscsi_probe+0x6f6/0x710
[    5.391007]  ? msi_get_domain_info+0x10/0x10
[    5.391007]  virtio_dev_probe+0x147/0x1d0
[    5.391007]  really_probe+0xd6/0x3b0
[    5.391007]  ? set_debug_rodata+0x11/0x11
[    5.391007]  device_driver_attach+0x4f/0x60
[    5.391007]  __driver_attach+0x99/0x130
[    5.391007]  ? device_driver_attach+0x60/0x60
[    5.391007]  bus_for_each_dev+0x76/0xc0
[    5.391007]  bus_add_driver+0x144/0x220
[    5.391007]  ? sym2_init+0xf6/0xf6
[    5.391007]  driver_register+0x5b/0xe0
[    5.391007]  ? sym2_init+0xf6/0xf6
[    5.391007]  init+0x86/0xcc
[    5.391007]  do_one_initcall+0x5a/0x2d4
[    5.391007]  ? set_debug_rodata+0x11/0x11
[    5.391007]  ? rcu_read_lock_sched_held+0x74/0x80
[    5.391007]  kernel_init_freeable+0x139/0x1c9
[    5.391007]  ? rest_init+0x260/0x260
[    5.391007]  kernel_init+0xa/0x100
[    5.391007]  ret_from_fork+0x24/0x30
[    5.391007] Modules linked in:
[    5.391007] CR2: 0000000000000000
[    5.391007] ---[ end trace 03e50b8909d2f2e5 ]---
[    5.391007] RIP: 0010:dma_direct_max_mapping_size+0x21/0x80
[    5.391007] Code: 0f b6 c0 c3 0f 1f 44 00 00 0f 1f 44 00 00 55 53 48 89 fb e8 f1 0e 00 00 84 c0 74 42 48 8b 83 e8 01 00 00 48 8b ab f8 01 00 00 <48> 8b 00 48 85 c0 74 0c 48 85 ed 74 31 48 39 c5 48 0f 47 e8 48 89
[    5.391007] RSP: 0000:ffffb0edc0013ac0 EFLAGS: 00010202
[    5.391007] RAX: 0000000000000000 RBX: ffff9216f9d8b838 RCX: 0000000000000000
[    5.391007] RDX: 0000000000000000 RSI: 000000000000007e RDI: ffff9216f9d8b838
[    5.391007] RBP: 0000000000000000 R08: 0000000249ffd97b R09: 0000000000000001
[    5.391007] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9216f9d8b838
[    5.391007] R13: 000000000000ffff R14: ffff9216f7348580 R15: 0000000000000000
[    5.391007] FS:  0000000000000000(0000) GS:ffff9216fba00000(0000) knlGS:0000000000000000
[    5.391007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.391007] CR2: 0000000000000000 CR3: 000000007a211000 CR4: 00000000000006e0
[    5.391007] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:38
[    5.391007] in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: swapper/0
[    5.391007] INFO: lockdep is turned off.
[    5.391007] irq event stamp: 13427044
[    5.391007] hardirqs last  enabled at (13427043): [<ffffffff92215b9b>] __slab_alloc+0x4b/0x80
[    5.391007] hardirqs last disabled at (13427044): [<ffffffff92001a4a>] trace_hardirqs_off_thunk+0x1a/0x20
[    5.391007] softirqs last  enabled at (13425414): [<ffffffff92c0032c>] __do_softirq+0x32c/0x430
[    5.391007] softirqs last disabled at (13425375): [<ffffffff9206fc03>] irq_exit+0xb3/0xc0
[    5.391007] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G      D           5.3.0-rc1-default #578
[    5.391007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    5.391007] Call Trace:
[    5.391007]  dump_stack+0x67/0x9b
[    5.391007]  ___might_sleep+0x152/0x240
[    5.391007]  exit_signals+0x30/0x320
[    5.391007]  do_exit+0xb8/0xca0
[    5.391007]  rewind_stack_do_exit+0x17/0x20
[    5.419466] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    5.420114] Kernel Offset: 0x11000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    5.420667] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
