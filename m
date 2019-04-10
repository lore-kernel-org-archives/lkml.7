Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EE4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3AD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfDJF21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:28:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:20412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfDJF21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 22:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="130076506"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2019 22:28:25 -0700
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
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Date:   Wed, 10 Apr 2019 13:22:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/6/19 2:02 AM, James Sewart wrote:
> Hey Lu,
> 
> My bad, did some debugging on my end. The issue was swapping out
> find_domain for iommu_get_domain_for_dev. It seems in some situations the
> domain is not attached to the group but the device is expected to have the
> domain still stored in its archdata.
> 
> I’ve attached the final patch with find_domain unremoved which seems to
> work in my testing.
> 

Just looked into your v3 patch set and some thoughts from my end posted
here just for your information.

Let me post the problems we want to address.

1. When allocating a new group for a device, how should we determine the
type of the default domain?

2. If we need to put a device into an existing group which uses a
different type of domain from what the device desires to use, we might
break the functionality of the device.

My new thought is letting the iommu generic code to determine the
default domain type (hence my proposed vendor specific default domain
type patches could be dropped).

If the default domain type is dynamical mapping, and later in 
iommu_no_mapping(), we determines that we must use an identity domain,
we then call iommu_request_dm_for_dev(dev).

If the default domain type is identity mapping, and later in
iommu_no_mapping(), we determined that we must use a dynamical domain,
we then call iommu_request_dma_domain_for_dev(dev).

We already have iommu_request_dm_for_dev() in iommu.c. We only need to
implement iommu_request_dma_domain_for_dev().

With this done, your patch titled "Create an IOMMU group for devices
that require an identity map" could also be dropped.

Any thoughts?

> Cheers,
> James.

Best regards,
Lu Baolu
