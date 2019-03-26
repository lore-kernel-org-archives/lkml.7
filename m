Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38CD20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfCZBaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:30:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:47516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfCZBaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:30:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 18:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="130144816"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 18:29:58 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
Date:   Tue, 26 Mar 2019 09:24:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/25/19 8:57 PM, James Sewart wrote:
>>> Theres an issue that if we choose to alloc a new resv_region with type
>>> IOMMU_RESV_DIRECT, we will need to refactor intel_iommu_put_resv_regions
>>> to free this entry type which means refactoring the rmrr regions in
>>> get_resv_regions. Should this work be in this patchset?
>> Do you mean the rmrr regions are not allocated in get_resv_regions, but
>> are freed in put_resv_regions? I think we should fix this in this patch
>> set since this might impact the device passthrough if we don't do it.
> They’re not allocated and not freed currently, only type IOMMU_RESV_MSI is
> freed in put_resv_regions. If we allocate a new resv_region with type
> IOMMU_RESV_DIRECT for the isa region, then it won’t be freed. If we modify
> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to free
> the static RMRR regions.
> 
> Either the ISA region is static and not freed as with my implementation,
> or the RMRR regions are converted to be allocated on each call to
> get_resv_regions and freed in put_resv_regions.
> 

By the way, there's another way in my mind. Let's add a new region type
for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the same way
as those MSI regions. Just FYI.

Best regards,
Lu Baolu
