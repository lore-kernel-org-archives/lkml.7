Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289ADCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18E9205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfJ1OHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:07:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:41247 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfJ1OHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:07:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 07:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="224640543"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 07:07:34 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/intel: Use fallback generic_device_group() for ACPI
 devices
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        iommu@lists.linux-foundation.org
References: <20191004205554.21055-1-chris@chris-wilson.co.uk>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b73f0c36-42a7-95be-3166-df7fe372c905@linux.intel.com>
Date:   Mon, 28 Oct 2019 22:04:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004205554.21055-1-chris@chris-wilson.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Just a quick scan of the dmesg attached in the bugzilla.

There are 6 devices reported in ANDD.

[    0.458662] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.458683] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    0.458704] DMAR: ANDD device: 3 name: \_SB.PCI0.SPI0
[    0.458724] DMAR: ANDD device: 4 name: \_SB.PCI0.SPI1
[    0.458745] DMAR: ANDD device: 6 name: \_SB.PCI0.UA01
[    0.458766] DMAR: ANDD device: 7 name: \_SB.PCI0.SDHC

On 10/5/19 4:55 AM, Chris Wilson wrote:
> [    2.073922] DMAR: ACPI device "INT33C2:00" under DMAR at fed91000 as 00:15.1
> [    2.073983] DMAR: ACPI device "INT33C3:00" under DMAR at fed91000 as 00:15.2
> [    2.074027] DMAR: ACPI device "INT33C0:00" under DMAR at fed91000 as 00:15.3
> [    2.074072] DMAR: ACPI device "INT33C1:00" under DMAR at fed91000 as 00:15.4

Four of them have been mapped to pci devices with device# 15:

> [    2.074114] DMAR: Failed to find handle for ACPI object \_SB.PCI0.UA01
> [    2.074156] DMAR: Failed to find handle for ACPI object \_SB.PCI0.SDHC

And 2 failed to be probed due to lack of ACPI objects.

> [    2.074208] DMAR: No ATSR found
> [    2.074572] DMAR: dmar0: Using Queued invalidation
> [    2.074629] DMAR: dmar1: Using Queued invalidation
> [    2.110029] pci 0000:00:00.0: Adding to iommu group 0
> [    2.115703] pci 0000:00:02.0: Adding to iommu group 1
> [    2.116221] pci 0000:00:03.0: Adding to iommu group 2
> [    2.116759] pci 0000:00:14.0: Adding to iommu group 3
> [    2.117276] pci 0000:00:16.0: Adding to iommu group 4
> [    2.117762] pci 0000:00:1b.0: Adding to iommu group 5
> [    2.118264] pci 0000:00:1c.0: Adding to iommu group 6
> [    2.118733] pci 0000:00:1c.2: Adding to iommu group 7
> [    2.119289] pci 0000:00:1d.0: Adding to iommu group 8
> [    2.119846] pci 0000:00:1f.0: Adding to iommu group 9
> [    2.119960] pci 0000:00:1f.2: Adding to iommu group 9
> [    2.120073] pci 0000:00:1f.3: Adding to iommu group 9
> [    2.120549] pci 0000:06:00.0: Adding to iommu group 10

IOMMU pci bus scan didn't see pci devices with device# 15.

Are these hidden devices? Do you mind posting the output of lspci
command? With this fix, do these devices work well?

Best regards,
baolu

> [    2.120631] ------------[ cut here ]------------
> [    2.120681] WARNING: CPU: 2 PID: 1 at drivers/iommu/iommu.c:1275 pci_device_group+0x109/0x120
> [    2.120723] Modules linked in:
> [    2.120744] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc1-CI-CI_DRM_7000+ #1
> [    2.120782] Hardware name: Dell Inc. XPS 12-9Q33/XPS 12-9Q33, BIOS A04 12/03/2013
> [    2.120821] RIP: 0010:pci_device_group+0x109/0x120
> [    2.120848] Code: e9 ff ff 48 85 c0 48 89 c5 75 bd 48 8d 74 24 10 4c 89 e7 e8 49 ea ff ff 48 85 c0 48 89 c5 75 a8 e8 fc ee ff ff 48 89 c5 eb 9e <0f> 0b 48 c7 c5 ea ff ff ff eb 93 e8 37 5f a7 ff 0f 1f 80 00 00 00
> [    2.120933] RSP: 0000:ffffc90000037cd0 EFLAGS: 00010202
> [    2.120961] RAX: ffffffff81639810 RBX: ffffffffffffffea RCX: 0000000000000000
> [    2.120996] RDX: 0000000000000000 RSI: 00000000403efd19 RDI: ffff888119999c08
> [    2.121031] RBP: ffff888119999c08 R08: ffff88811a5188f8 R09: 00000000fffffffe
> [    2.121066] R10: 00000000ca7d066a R11: 000000002161dc90 R12: ffff888118320a58
> [    2.121100] R13: ffff888119fc1e50 R14: 0000000000000001 R15: ffff888119fc2300
> [    2.121136] FS:  0000000000000000(0000) GS:ffff88811b900000(0000) knlGS:0000000000000000
> [    2.121176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.121205] CR2: 0000000000000000 CR3: 0000000005210001 CR4: 00000000001606e0
> [    2.121240] Call Trace:
> [    2.121264]  iommu_group_get_for_dev+0x77/0x210
> [    2.121295]  intel_iommu_add_device+0x54/0x1c0
> [    2.121323]  iommu_probe_device+0x43/0xc0
> [    2.121350]  intel_iommu_init+0x11fb/0x12c9
> [    2.121383]  ? set_debug_rodata+0xc/0xc
> [    2.121410]  ? set_debug_rodata+0xc/0xc
> [    2.121434]  ? e820__memblock_setup+0x5b/0x5b
> [    2.121458]  ? pci_iommu_init+0x11/0x3a
> [    2.121471]  ? rcu_read_lock_sched_held+0x4d/0x80
> [    2.121471]  pci_iommu_init+0x11/0x3a
> [    2.121471]  do_one_initcall+0x58/0x2ff
> [    2.121471]  ? set_debug_rodata+0xc/0xc
> [    2.121471]  ? rcu_read_lock_sched_held+0x4d/0x80
> [    2.121471]  kernel_init_freeable+0x137/0x1c7
> [    2.121471]  ? rest_init+0x250/0x250
> [    2.121471]  kernel_init+0x5/0x100
> [    2.121471]  ret_from_fork+0x3a/0x50
> [    2.121471] irq event stamp: 1252438
> [    2.121471] hardirqs last  enabled at (1252437): [<ffffffff8123f4ed>] __slab_alloc.isra.84.constprop.89+0x4d/0x70
> [    2.121471] hardirqs last disabled at (1252438): [<ffffffff81001bba>] trace_hardirqs_off_thunk+0x1a/0x20
> [    2.121471] softirqs last  enabled at (1252382): [<ffffffff81c00385>] __do_softirq+0x385/0x47f
> [    2.121471] softirqs last disabled at (1252375): [<ffffffff810b7f4a>] irq_exit+0xba/0xc0
> [    2.121471] ---[ end trace 610717c918cf08f3 ]---
> [    2.121974] DMAR: ACPI name space devices didn't probe correctly
> [    2.122069] DMAR: Intel(R) Virtualization Technology for Directed I/O
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=111906
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
> Take the patch with a pinch of salt; it seems to be the pattern used by
> other iommu backends, but I don't know if it is even suitable for iommu
> and what appear to be ACPI devices rather than the expected PCI.
> ---
>   drivers/iommu/intel-iommu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ed321b808176..e231be0d0534 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5939,6 +5939,14 @@ static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
>   }
>   
> +static struct iommu_group *intel_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
> +}
> +
>   const struct iommu_ops intel_iommu_ops = {
>   	.capable		= intel_iommu_capable,
>   	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -5956,7 +5964,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
>   	.put_resv_regions	= intel_iommu_put_resv_regions,
>   	.apply_resv_region	= intel_iommu_apply_resv_region,
> -	.device_group		= pci_device_group,
> +	.device_group		= intel_iommu_device_group,
>   	.dev_has_feat		= intel_iommu_dev_has_feat,
>   	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
>   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
> 
