Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619DC2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCEGKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:10:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:57644 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfCEGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:10:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 22:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,442,1544515200"; 
   d="scan'208";a="119670991"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 22:10:40 -0800
Cc:     baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
Date:   Tue, 5 Mar 2019 14:05:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Very glad to see this. Thank you!

On 3/4/19 11:41 PM, James Sewart wrote:
> Hey,
> 
> This patchset moves IOMMU_DOMAIN_DMA iommu domain management to iommu.c.
> This avoids the use of find_or_alloc_domain whose domain assignment is
> inconsistent with the iommu grouping as determined by pci_device_group.

Is this a bug fix or an improvement? What's the real issue will it cause
if we go without this patch set?

Best regards,
Lu Baolu

> 
> Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the
> iommu_ops api, allowing the default_domain of an iommu group to be set in
> iommu.c. This domain will be attached to every device that is brought up
> with an iommu group, and the devices reserved regions will be mapped using
> regions returned by get_resv_regions.
> 
> In intel_iommu_domain_alloc we don’t know the IOMMU this domain will be
> associated with so we defer full initialisation until
> intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device will
> try to map a devices reserved regions before attaching the domain which
> would cause issue if the domain is not fully initialised. This is
> addressed in patch 1 by moving the mapping to after attaching.
> 
> Patch 2 implements function apply_resv_region, used in
> iommu_group_create_direct_mappings to mark the reserved regions as non
> mappable for the dma_map_ops api.
> 
> Patch 4 removes the domain lazy allocation logic. Before this patch the
> lazy allocation logic would not be used as any domain allocated using
> these paths would be replaced when attaching the group default domain.
> Default domain allocation has been tested with and without this patch on
> 4.19.
> 
> Cheers,
> James.
> 
> James Sewart (4):
>    iommu: Move iommu_group_create_direct_mappings to after device_attach
>    iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>    iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be allocated
>    iommu/vt-d: Remove lazy allocation of domains
> 
>   drivers/iommu/intel-iommu.c | 329 ++++++++++++------------------------
>   drivers/iommu/iommu.c       |   4 +-
>   2 files changed, 108 insertions(+), 225 deletions(-)
> 
