Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E98BC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B152184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGSJFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:05:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:17509 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfGSJE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:04:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 02:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,281,1559545200"; 
   d="scan'208";a="179569783"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2019 02:04:53 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
To:     Alex Williamson <alex.williamson@redhat.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
 <20190525054136.27810-13-baolu.lu@linux.intel.com>
 <20190717211226.5ffbf524@x1.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
Date:   Fri, 19 Jul 2019 17:04:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717211226.5ffbf524@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 7/18/19 11:12 AM, Alex Williamson wrote:
> On Sat, 25 May 2019 13:41:33 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Previously, get_valid_domain_for_dev() is used to retrieve the
>> DMA domain which has been attached to the device or allocate one
>> if no domain has been attached yet. As we have delegated the DMA
>> domain management to upper layer, this function is used purely to
>> allocate a private DMA domain if the default domain doesn't work
>> for ths device. Cleanup the code for readability.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 18 ++++++++----------
>>   include/linux/intel-iommu.h |  1 -
>>   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> System fails to boot bisected to this commit:

Is this the same issue as this https://lkml.org/lkml/2019/7/18/840?

Best regards,
Baolu

> 
> ommit 4ec066c7b1476e0ca66a7acdb575627a5d1a1ee6 (HEAD, refs/bisect/bad)
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Sat May 25 13:41:33 2019 +0800
> 
>      iommu/vt-d: Cleanup get_valid_domain_for_dev()
> 
> [    6.857697] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    6.870723] ehci-pci: EHCI PCI platform driver
> [    6.879666] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    6.890122] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> [    6.904893] ehci-pci 0000:00:1a.0: debug port 2
> [    6.913961] ehci-pci 0000:00:1a.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
> [    6.929953] ehci-pci 0000:00:1a.0: DMAR: 32bit DMA uses non-identity mapping
> [    6.944033] WARNING: CPU: 0 PID: 1 at drivers/iommu/intel-iommu.c:600 domain_get_iommu+0x55/0x60
> [    6.945017] Modules linked in:
> [    6.945017] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc2+ #37
> [    6.945017] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 3904 04/27/2013
> [    6.945017] RIP: 0010:domain_get_iommu+0x55/0x60
> [    6.945017] Code: c2 01 eb 0b 48 83 c0 01 8b 34 87 85 f6 75 0b 48 63 c8 48 39 c2 75 ed 31 c0 c3 48 c1 e1 03 48 8b 05 e0 f5 44 01 48 8b 04 08 c3 <0f> 0b 31 c0 c3 31 c9 eb eb 66 90 0f 1f 44 00 00 41 55 40 0f b6 f6
> [    6.945017] RSP: 0018:ffffbd02418bba98 EFLAGS: 00010293
> [    6.945017] RAX: ffffffffffffffff RBX: 0000000000000000 RCX: 0000000000000000
> [    6.945017] RDX: 0000000000001000 RSI: 00000000313ea000 RDI: ffff9ce9f3026e00
> [    6.945017] RBP: ffff9cea144f80b0 R08: 00000000ffffffff R09: ffff9ce9f13ea000
> [    6.945017] R10: 0000000000100000 R11: 0000000000000100 R12: 00000000313ea000
> [    6.945017] R13: ffff9ce9f3026e00 R14: 0000000000001000 R15: 00000000313ea000
> [    6.945017] FS:  0000000000000000(0000) GS:ffff9ceddf400000(0000) knlGS:0000000000000000
> [    6.945017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.945017] CR2: 00007fa72ed421f8 CR3: 000000011b20a001 CR4: 00000000001606f0
> [    6.945017] Call Trace:
> [    6.945017]  __intel_map_single+0x4e/0x120
> [    6.945017]  intel_alloc_coherent+0xa7/0x110
> [    6.945017]  dma_pool_alloc+0xd9/0x1e0
> [    6.945017]  ehci_qh_alloc+0x55/0x130
> [    6.945017]  ehci_setup+0x284/0x7b0
> [    6.945017]  ehci_pci_setup+0x8b/0x41d
> [    6.945017]  usb_add_hcd.cold.40+0x1c5/0x7b7
> [    6.945017]  usb_hcd_pci_probe+0x2a4/0x420
> [    6.945017]  local_pci_probe+0x42/0x80
> [    6.945017]  pci_device_probe+0x115/0x190
> [    6.945017]  really_probe+0xef/0x390
> [    6.945017]  driver_probe_device+0xb4/0x100
> [    6.945017]  device_driver_attach+0x4f/0x60
> [    6.945017]  __driver_attach+0x86/0x140
> [    6.945017]  ? device_driver_attach+0x60/0x60
> [    6.945017]  bus_for_each_dev+0x77/0xc0
> [    6.945017]  ? klist_add_tail+0x3b/0x60
> [    6.945017]  bus_add_driver+0x14a/0x1e0
> [    6.945017]  ? ehci_hcd_init+0xaa/0xaa
> [    6.945017]  ? do_early_param+0x8e/0x8e
> [    6.945017]  driver_register+0x6b/0xb0
> [    6.945017]  ? ehci_hcd_init+0xaa/0xaa
> [    6.945017]  do_one_initcall+0x46/0x1f4
> [    6.945017]  ? do_early_param+0x8e/0x8e
> [    6.945017]  kernel_init_freeable+0x1ac/0x255
> [    6.945017]  ? rest_init+0x9f/0x9f
> [    6.945017]  kernel_init+0xa/0x101
> [    6.945017]  ret_from_fork+0x35/0x40
> [    6.945017] ---[ end trace 1aa3219cfb92242b ]---
> 
> Kernel command line includes intel_iommu=on iommu=pt
> 
> On the merge commit of Joerg's pull request for 5.3 (6b04014f3f15),
> including:
> 
> commit c57b260a7d7d60dfbcf794dd9836c1d9fdbf5434
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Wed Jun 12 08:28:46 2019 +0800
> 
>      iommu/vt-d: Set domain type for a private domain
>      
>      Otherwise, domain_get_iommu() will be broken.
>      
>      Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
> 
> 
> The fail to boot error shows as:
> 
> [    7.042371] general protection fault: 0000 [#1] SMP PTI
> [    7.042968] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0+ #39
> [    7.042968] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 3904 04/27/2013
> [    7.042968] RIP: 0010:domain_context_mapping_one+0x212/0x4c0
> [    7.042968] Code: 39 c2 0f 8d fc 01 00 00 48 8b 15 49 4d b5 00 eb 0c 83 e8 01 41 39 c2 0f 84 ea 01 00 00 4d 8b 00 49 81 e0 00 f0 ff ff 49 01 d0 <41> f6 00 03 75 e1 b8 f4 ff ff ff e9 be fe ff ff 44 89 e1 45 89 e0
> [    7.042968] RSP: 0018:ffffb021818bb928 EFLAGS: 00010087
> [    7.042968] RAX: 0000000000000002 RBX: ffff9d665f057f00 RCX: 0000000000000001
> [    7.042968] RDX: ffff9d6240000000 RSI: 0000000000000030 RDI: ffff9d665f057f00
> [    7.042968] RBP: 0000000000000003 R08: f0008c563000e000 R09: ffff9d627155a000
> [    7.042968] R10: 0000000000000001 R11: 0000000000000804 R12: 0000000000000000
> [    7.042968] R13: 0000000000000002 R14: 0000000000000000 R15: ffff9d6285934200
> [    7.042968] FS:  0000000000000000(0000) GS:ffff9d665f400000(0000) knlGS:0000000000000000
> [    7.042968] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.042968] CR2: 00007f99e08a81f8 CR3: 000000040c20a001 CR4: 00000000001606f0
> [    7.042968] Call Trace:
> [    7.042968]  ? domain_context_mapping_one+0x4c0/0x4c0
> [    7.042968]  pci_for_each_dma_alias+0x30/0x140
> [    7.042968]  dmar_insert_one_dev_info+0x33f/0x4b0
> [    7.042968]  get_private_domain_for_dev.part.75+0x136/0x2f0
> [    7.042968]  ? __dmar_remove_one_dev_info+0x106/0x250
> [    7.042968]  iommu_need_mapping+0xac/0xc0
> [    7.042968]  intel_alloc_coherent+0x20/0x110
> [    7.042968]  xhci_mem_init+0x1ba/0xee1
> [    7.042968]  ? xhci_dbg_trace+0x6b/0xb0
> [    7.042968]  ? recalibrate_cpu_khz+0x10/0x10
> [    7.042968]  ? ktime_get+0x36/0xa0
> [    7.042968]  ? xhci_pci_suspend+0xd0/0xd0
> [    7.042968]  xhci_init+0x81/0x170
> [    7.042968]  xhci_gen_setup+0x1fe/0x360
> [    7.042968]  xhci_pci_setup+0x4d/0x120
> [    7.042968]  usb_add_hcd.cold.40+0x1c5/0x7b7
> [    7.042968]  usb_hcd_pci_probe+0x214/0x420
> [    7.042968]  xhci_pci_probe+0x29/0x1f0
> [    7.042968]  local_pci_probe+0x42/0x80
> [    7.042968]  pci_device_probe+0x115/0x190
> [    7.042968]  really_probe+0xef/0x390
> [    7.042968]  driver_probe_device+0xb4/0x100
> [    7.042968]  device_driver_attach+0x4f/0x60
> [    7.042968]  __driver_attach+0x86/0x140
> [    7.042968]  ? device_driver_attach+0x60/0x60
> [    7.042968]  bus_for_each_dev+0x77/0xc0
> [    7.042968]  ? klist_add_tail+0x3b/0x60
> [    7.042968]  bus_add_driver+0x14a/0x1e0
> [    7.042968]  ? xhci_debugfs_create_root+0x20/0x20
> [    7.042968]  ? do_early_param+0x8e/0x8e
> [    7.042968]  driver_register+0x6b/0xb0
> [    7.042968]  ? xhci_debugfs_create_root+0x20/0x20
> [    7.042968]  do_one_initcall+0x46/0x1f4
> [    7.042968]  ? do_early_param+0x8e/0x8e
> [    7.042968]  kernel_init_freeable+0x1ac/0x255
> [    7.042968]  ? rest_init+0x9f/0x9f
> [    7.042968]  kernel_init+0xa/0x101
> [    7.042968]  ret_from_fork+0x35/0x40
> [    7.042968] Modules linked in:
> [    7.042968] ---[ end trace 6d6cf443442a773d ]---
> 
> Thanks,
> Alex
> 
