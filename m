Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D3C31E40
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C080420679
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 03:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfHDDRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 23:17:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:36408 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfHDDRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 23:17:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2019 20:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,344,1559545200"; 
   d="scan'208";a="184971362"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2019 20:17:14 -0700
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
To:     Alex Williamson <alex.williamson@redhat.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
 <20190525054136.27810-13-baolu.lu@linux.intel.com>
 <20190717211226.5ffbf524@x1.home>
 <9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
 <20190719092303.751659a0@x1.home> <20190801193013.19444803@x1.home>
 <5258f18f-101e-8a43-edea-3f4bb88ca58b@linux.intel.com>
 <20190802105406.53cd9977@x1.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4b31d73f-5fb5-060b-3238-228ffd039fff@linux.intel.com>
Date:   Sun, 4 Aug 2019 11:16:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802105406.53cd9977@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/19 12:54 AM, Alex Williamson wrote:
> On Fri, 2 Aug 2019 15:17:45 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> Thanks for reporting this. I will try to find a machine with a
>> pcie-to-pci bridge and get this issue fixed. I will update you
>> later.
> 
> Further debug below...

Thanks for the debugging.

> 
>> On 8/2/19 9:30 AM, Alex Williamson wrote:
>>> DMAR: No ATSR found
>>> DMAR: dmar0: Using Queued invalidation
>>> DMAR: dmar1: Using Queued invalidation
>>> pci 0000:00:00.0: DMAR: Software identity mapping
>>> pci 0000:00:01.0: DMAR: Software identity mapping
>>> pci 0000:00:02.0: DMAR: Software identity mapping
>>> pci 0000:00:16.0: DMAR: Software identity mapping
>>> pci 0000:00:1a.0: DMAR: Software identity mapping
>>> pci 0000:00:1b.0: DMAR: Software identity mapping
>>> pci 0000:00:1c.0: DMAR: Software identity mapping
>>> pci 0000:00:1c.5: DMAR: Software identity mapping
>>> pci 0000:00:1c.6: DMAR: Software identity mapping
>>> pci 0000:00:1c.7: DMAR: Software identity mapping
>>> pci 0000:00:1d.0: DMAR: Software identity mapping
>>> pci 0000:00:1f.0: DMAR: Software identity mapping
>>> pci 0000:00:1f.2: DMAR: Software identity mapping
>>> pci 0000:00:1f.3: DMAR: Software identity mapping
>>> pci 0000:01:00.0: DMAR: Software identity mapping
>>> pci 0000:01:00.1: DMAR: Software identity mapping
>>> pci 0000:03:00.0: DMAR: Software identity mapping
>>> pci 0000:04:00.0: DMAR: Software identity mapping
>>> DMAR: Setting RMRR:
>>> pci 0000:00:02.0: DMAR: Setting identity map [0xbf800000 - 0xcf9fffff]
>>> pci 0000:00:1a.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
>>> pci 0000:00:1d.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
>>> DMAR: Prepare 0-16MiB unity mapping for LPC
>>> pci 0000:00:1f.0: DMAR: Setting identity map [0x0 - 0xffffff]
>>> pci 0000:00:00.0: Adding to iommu group 0
>>> pci 0000:00:00.0: Using iommu direct mapping
>>> pci 0000:00:01.0: Adding to iommu group 1
>>> pci 0000:00:01.0: Using iommu direct mapping
>>> pci 0000:00:02.0: Adding to iommu group 2
>>> pci 0000:00:02.0: Using iommu direct mapping
>>> pci 0000:00:16.0: Adding to iommu group 3
>>> pci 0000:00:16.0: Using iommu direct mapping
>>> pci 0000:00:1a.0: Adding to iommu group 4
>>> pci 0000:00:1a.0: Using iommu direct mapping
>>> pci 0000:00:1b.0: Adding to iommu group 5
>>> pci 0000:00:1b.0: Using iommu direct mapping
>>> pci 0000:00:1c.0: Adding to iommu group 6
>>> pci 0000:00:1c.0: Using iommu direct mapping
>>> pci 0000:00:1c.5: Adding to iommu group 7
>>> pci 0000:00:1c.5: Using iommu direct mapping
>>> pci 0000:00:1c.6: Adding to iommu group 8
>>> pci 0000:00:1c.6: Using iommu direct mapping
>>> pci 0000:00:1c.7: Adding to iommu group 9
> 
> Note that group 9 contains device 00:1c.7

Yes.

> 
>>> pci 0000:00:1c.7: Using iommu direct mapping
> 
> I'm booted with iommu=pt, so the domain type is IOMMU_DOMAIN_PT

Yes.

> 
>>> pci 0000:00:1d.0: Adding to iommu group 10
>>> pci 0000:00:1d.0: Using iommu direct mapping
>>> pci 0000:00:1f.0: Adding to iommu group 11
>>> pci 0000:00:1f.0: Using iommu direct mapping
>>> pci 0000:00:1f.2: Adding to iommu group 11
>>> pci 0000:00:1f.3: Adding to iommu group 11
>>> pci 0000:01:00.0: Adding to iommu group 1
>>> pci 0000:01:00.1: Adding to iommu group 1
>>> pci 0000:03:00.0: Adding to iommu group 12
>>> pci 0000:03:00.0: Using iommu direct mapping
>>> pci 0000:04:00.0: Adding to iommu group 13
>>> pci 0000:04:00.0: Using iommu direct mapping
>>> pci 0000:05:00.0: Adding to iommu group 9
> 
> 05:00.0 is downstream of 00:1c.7 and in the same group.  As above, the
> domain is type IOMMU_DOMAIN_IDENTITY, so we take the following branch:
> 
>          } else {
>                  if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
> 
> Default domain type is IOMMU_DOMAIN_DMA because of the code block in
> device_def_domain_type() handling bridges to conventional PCI and
> conventional PCI endpoints.
> 
>                          ret = iommu_request_dma_domain_for_dev(dev);
> 
> This fails in request_default_domain_for_dev() because there's more
> than one device in the group.
> 
>                          if (ret) {
>                                  dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
>                                  if (!get_private_domain_for_dev(dev)) {
> 
> With this commit, this now returns NULL because find_domain() does find
> a domain, the same one we found before this code block.

This seems to be problematic.

Since it failed to request the right default domain type of group, the
driver decided to assign a private domain to it.

However, the device has already been attached by a domain, as "pci
0000:05:00.0: Adding to iommu group 9". So get_private_domain_for_dev()
returned error. It is same for identity private domain case.

We need to detach the domain first before requesting a private domain.
Can you please check whether below change works for you?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bdaed2da8a55..3ee9b0d20c28 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4803,7 +4803,8 @@ static void dmar_remove_one_dev_info(struct device 
*dev)

         spin_lock_irqsave(&device_domain_lock, flags);
         info = dev->archdata.iommu;
-       __dmar_remove_one_dev_info(info);
+       if (info)
+               __dmar_remove_one_dev_info(info);
         spin_unlock_irqrestore(&device_domain_lock, flags);
  }

@@ -5281,6 +5282,7 @@ static int intel_iommu_add_device(struct device *dev)
                 if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
                         ret = iommu_request_dm_for_dev(dev);
                         if (ret) {
+                               dmar_remove_one_dev_info(dev);
                                 dmar_domain->flags |= 
DOMAIN_FLAG_LOSE_CHILDREN;
                                 domain_add_dev_info(si_domain, dev);
                                 dev_info(dev,
@@ -5291,6 +5293,7 @@ static int intel_iommu_add_device(struct device *dev)
                 if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
                         ret = iommu_request_dma_domain_for_dev(dev);
                         if (ret) {
+                               dmar_remove_one_dev_info(dev);
                                 dmar_domain->flags |= 
DOMAIN_FLAG_LOSE_CHILDREN;
                                 if (!get_private_domain_for_dev(dev)) {
                                         dev_warn(dev,

> 
>                                          dev_warn(dev,
>                                                   "Failed to get a private domain.\n");
>                                          return -ENOMEM;
>                                  }
> 
> So the key factors are that I'm booting with iommu=pt and I have a
> PCIe-to-PCI bridge grouped with its parent root port.  The bridge
> wants an IOMMU_DOMAIN_DMA, but the group domain is already of type
> IOMMU_DOMAIN_IDENTITY.  A temporary workaround is to not use
> passthrough mode, but this is a regression versus previous kernels.

Yes, agreed.

> Thanks,
> 
> Alex
> 

Best regards,
Baolu
