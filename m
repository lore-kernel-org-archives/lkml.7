Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4BC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F821019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE2CUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:20:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:34857 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfE2CUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 19:20:15 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2019 19:20:12 -0700
Cc:     baolu.lu@linux.intel.com, jean-philippe.brucker@arm.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Handle PCI bridge RMRR device scopes
 in intel_iommu_get_resv_regions
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        robin.murphy@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-6-eric.auger@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bb457306-805a-c618-3f96-4ae53c02e19a@linux.intel.com>
Date:   Wed, 29 May 2019 10:13:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528115025.17194-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/28/19 7:50 PM, Eric Auger wrote:
> In the case the RMRR device scope is a PCI-PCI bridge, let's check
> the device belongs to the PCI sub-hierarchy.


This looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Baolu

> 
> Fixes: 0659b8dc45a6 ("iommu/vt-d: Implement reserved region get/put callbacks")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 35508687f178..9302351818ab 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5496,7 +5496,8 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   			struct iommu_resv_region *resv;
>   			size_t length;
>   
> -			if (i_dev != device)
> +			if (i_dev != device &&
> +			    !is_downstream_to_pci_bridge(device, i_dev))
>   				continue;
>   
>   			length = rmrr->end_address - rmrr->base_address + 1;
> 
