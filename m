Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4421873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCODSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:18:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:15673 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfCODSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:18:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 20:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,480,1544515200"; 
   d="scan'208";a="127118324"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2019 20:18:47 -0700
Cc:     baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
Date:   Fri, 15 Mar 2019 11:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/14/19 7:56 PM, James Sewart wrote:
> Patches 1 and 2 are the same as v1.
> 
> v1-v2:
>    Refactored ISA direct mappings to be returned by iommu_get_resv_regions.
>    Integrated patch by Lu to defer turning on DMAR until iommu.c has mapped
> reserved regions.
>    Integrated patches by Lu to remove more unused code in cleanup.
> 
> Lu: I didn't integrate your patch to set the default domain type as it
> isn't directly related to the aim of this patchset. Instead patch 4

Without those patches, user experience will be affected and some devices
will not work on Intel platforms anymore.

For a long time, Intel IOMMU driver has its own logic to determine
whether a device requires an identity domain. For example, when user
specifies "iommu=pt" in kernel parameter, all device will be attached
with the identity domain. Further more, some quirky devices require
an identity domain to be used before enabling DMA remapping, otherwise,
it will not work. This was done by adding quirk bits in Intel IOMMU
driver.

So from my point of view, one way is porting all those quirks and kernel
parameters into IOMMU generic layer, or opening a door for vendor IOMMU
driver to determine the default domain type by their own. I prefer the
latter option since it will not impact any behaviors on other
architectures.

> addresses the issue of a device requiring an identity domain by ignoring
> the domain param in attach_device and printing a warning.

This will not work as I commented in that thread.

> 
> I booted some of our devices with this patchset and haven't seen any
> issues. It doesn't look like we have any devices with RMRR's though so
> those codepaths aren't tested.
> 
> James Sewart (7):
>    iommu: Move iommu_group_create_direct_mappings to after device_attach
>    iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>    iommu/vt-d: Expose ISA direct mapping region via
>      iommu_get_resv_regions
>    iommu/vt-d: Ignore domain parameter in attach_device if device
>      requires identity map
>    iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by iommu_ops
>    iommu/vt-d: Remove lazy allocation of domains
> 
> Lu Baolu (1):
>    iommu/vt-d: Enable DMA remapping after rmrr mapped
> 
>   drivers/iommu/intel-iommu.c | 444 +++++++++++-------------------------
>   drivers/iommu/iommu.c       |   4 +-
>   2 files changed, 131 insertions(+), 317 deletions(-)
> 

Best regards,
Lu Baolu
