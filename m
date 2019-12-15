Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054AC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C322B48
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfLOFkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:40:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:47426 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfLOFkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 00:40:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2019 21:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,316,1571727600"; 
   d="scan'208";a="226735470"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2019 21:40:20 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Allocate reserved region for ISA with correct
 permission
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20191213053642.5696-1-jsnitsel@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3a9bcdc5-9e78-945d-f6e4-5af6829bf4f0@linux.intel.com>
Date:   Sun, 15 Dec 2019 13:39:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213053642.5696-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/19 1:36 PM, Jerry Snitselaar wrote:
> Currently the reserved region for ISA is allocated with no
> permissions. If a dma domain is being used, mapping this region will
> fail. Set the permissions to DMA_PTE_READ|DMA_PTE_WRITE.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: stable@vger.kernel.org # v5.3+
> Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

This fix looks reasonable to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..998529cebcf2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5736,7 +5736,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   		struct pci_dev *pdev = to_pci_dev(device);
>   
>   		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
> -			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
> +			reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
>   						      IOMMU_RESV_DIRECT);
>   			if (reg)
>   				list_add_tail(&reg->list, head);
> 
