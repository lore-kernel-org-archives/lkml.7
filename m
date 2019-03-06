Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD45C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38CC20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfCFGcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:32:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:45862 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCFGcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:32:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 22:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,446,1544515200"; 
   d="scan'208";a="121377965"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 22:32:51 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
 <855ED37F-2E4A-4BDD-9B09-64C41179C319@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <42739a9d-478c-68dd-fb62-2894add36c75@linux.intel.com>
Date:   Wed, 6 Mar 2019 14:27:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <855ED37F-2E4A-4BDD-9B09-64C41179C319@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/19 7:14 PM, James Sewart wrote:
> Hey Lu,
> 
> The motivation for this is buggy domain <-> IOMMU group relationship when
> using find_or_alloc_domain. From what I have read it should be the case
> that an IOMMU domain is shared by all devices in the same group, thus the
> same mappings. This is because the IOMMU group is determined by things
> like ACS settings on pci switches which determines whether devices can
> talk to each other.
Yes, exactly. This is a known issue.

> 
> In find_or_alloc_domain we only determine domain sharing based on devices
> returned by pci_for_each_dma_alias, whereas there are many more checks in
> pci_device_group(e.g. ACS settings of intermediary pci switches), which is
> used for determining which IOMMU group a device is in. This discontinuity
> means it can be the case that each device within an IOMMU group will have
> different domains.

Yes. Agree again.

> 
> We see issues as it is supposed to be safe to assume that devices within a
> group should be considered to be in the same address space, but if each
> device has its own domain then any mapping created won’t be valid for the
> other devices, and even could be mapped differently for each device. This
> also could cause issues with a device whose RMRR's are not applied to the
> domains of other devices within its group, these regions could be remapped
> for the other devices resulting in unexpected behaviour during
> peer-to-peer transfers.

Yes, fair enough.

I asked this question because I am interested to know whether multiple
domains per group due to lack of ACS consideration will cause any issues
that we need to fix in the stable kernels.

Best regards,
Lu Baolu

> 
> Cheers,
> James
> 
> 
>> On 5 Mar 2019, at 06:05, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> Very glad to see this. Thank you!
>>
>> On 3/4/19 11:41 PM, James Sewart wrote:
>>> Hey,
>>> This patchset moves IOMMU_DOMAIN_DMA iommu domain management to iommu.c.
>>> This avoids the use of find_or_alloc_domain whose domain assignment is
>>> inconsistent with the iommu grouping as determined by pci_device_group.
>>
>> Is this a bug fix or an improvement? What's the real issue will it cause
>> if we go without this patch set?
>>
>> Best regards,
>> Lu Baolu
>>
>>> Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the
>>> iommu_ops api, allowing the default_domain of an iommu group to be set in
>>> iommu.c. This domain will be attached to every device that is brought up
>>> with an iommu group, and the devices reserved regions will be mapped using
>>> regions returned by get_resv_regions.
>>> In intel_iommu_domain_alloc we don’t know the IOMMU this domain will be
>>> associated with so we defer full initialisation until
>>> intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device will
>>> try to map a devices reserved regions before attaching the domain which
>>> would cause issue if the domain is not fully initialised. This is
>>> addressed in patch 1 by moving the mapping to after attaching.
>>> Patch 2 implements function apply_resv_region, used in
>>> iommu_group_create_direct_mappings to mark the reserved regions as non
>>> mappable for the dma_map_ops api.
>>> Patch 4 removes the domain lazy allocation logic. Before this patch the
>>> lazy allocation logic would not be used as any domain allocated using
>>> these paths would be replaced when attaching the group default domain.
>>> Default domain allocation has been tested with and without this patch on
>>> 4.19.
>>> Cheers,
>>> James.
>>> James Sewart (4):
>>>    iommu: Move iommu_group_create_direct_mappings to after device_attach
>>>    iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>>>    iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be allocated
>>>    iommu/vt-d: Remove lazy allocation of domains
>>>   drivers/iommu/intel-iommu.c | 329 ++++++++++++------------------------
>>>   drivers/iommu/iommu.c       |   4 +-
>>>   2 files changed, 108 insertions(+), 225 deletions(-)
> 
> 
