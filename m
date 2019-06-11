Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F8C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42E421734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392147AbfFKXrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:47:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:22035 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbfFKXrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:47:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 16:47:21 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 16:47:19 -0700
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iommu/vt-d: Fixes and cleanups for linux-next
To:     Qian Cai <cai@lca.pw>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
 <1560272102.5154.1.camel@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <28f728af-9bc8-d8ce-00b5-59bcfdceacf0@linux.intel.com>
Date:   Wed, 12 Jun 2019 07:40:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560272102.5154.1.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is supposed to be fixed by this patch

https://lkml.org/lkml/2019/6/3/115

which is part of several RMRR related fixes and enhancements.

Best regards,
Baolu

On 6/12/19 12:55 AM, Qian Cai wrote:
> On Sun, 2019-06-09 at 10:37 +0800, Lu Baolu wrote:
>> Hi Joerg,
>>
>> This series includes several fixes and cleanups after delegating
>> DMA domain to generic iommu. Please review and consider them for
>> linux-next.
>>
>> Best regards,
>> Baolu
>>
>> Lu Baolu (5):
>>    iommu/vt-d: Don't return error when device gets right domain
>>    iommu/vt-d: Set domain type for a private domain
>>    iommu/vt-d: Don't enable iommu's which have been ignored
>>    iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
>>    iommu/vt-d: Consolidate domain_init() to avoid duplication
>>
>> Sai Praneeth Prakhya (1):
>>    iommu/vt-d: Cleanup after delegating DMA domain to generic iommu
>>
>>   drivers/iommu/intel-iommu.c | 210 +++++++++---------------------------
>>   1 file changed, 53 insertions(+), 157 deletions(-)
>>
> 
> BTW, the linux-next commit "iommu/vt-d: Expose ISA direct mapping region via
> iommu_get_resv_regions" [1] also introduced a memory leak below, as it forgets
> to ask intel_iommu_put_resv_regions() to call kfree() when
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y.
> 
> [1] https://lore.kernel.org/patchwork/patch/1078963/
> 
> unreferenced object 0xffff88912ef789c8 (size 64):
>    comm "swapper/0", pid 1, jiffies 4294946232 (age 5399.530s)
>    hex dump (first 32 bytes):
>      48 83 f7 2e 91 88 ff ff 30 fa e3 00 82 88 ff ff  H.......0.......
>      00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00  ................
>    backtrace:
>      [<00000000d267f4be>] kmem_cache_alloc_trace+0x266/0x380
>      [<00000000d383d15b>] iommu_alloc_resv_region+0x40/0xb0
>      [<00000000db8be31b>] intel_iommu_get_resv_regions+0x25e/0x2d0
>      [<0000000021fbc6c3>] iommu_group_create_direct_mappings+0x159/0x3d0
>      [<0000000022259268>] iommu_group_add_device+0x17b/0x4f0
>      [<0000000028b91093>] iommu_group_get_for_dev+0x153/0x460
>      [<00000000577c33b4>] intel_iommu_add_device+0xc4/0x210
>      [<00000000587b7492>] iommu_probe_device+0x63/0x80
>      [<000000004aa997d1>] add_iommu_group+0xe/0x20
>      [<00000000c93a9cd6>] bus_for_each_dev+0xf0/0x150
>      [<00000000a2e5f0cb>] bus_set_iommu+0xc6/0x100
>      [<00000000dbad5db0>] intel_iommu_init+0x682/0xb0a
>      [<00000000226f7444>] pci_iommu_init+0x26/0x62
>      [<000000002d8694f5>] do_one_initcall+0xe5/0x3ea
>      [<000000004bc60101>] kernel_init_freeable+0x5ad/0x640
>      [<0000000091b0bad6>] kernel_init+0x11/0x138
> 
> 
