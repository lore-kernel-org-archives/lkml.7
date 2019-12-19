Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29887C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E322176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSByS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:54:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:57625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSByS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:54:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 17:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="228087471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2019 17:54:15 -0800
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
Date:   Thu, 19 Dec 2019 09:53:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191218134205.1271740-5-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please tweak the title to

"iommu/vt-d: Use generic_iommu_put_resv_regions()"

then,

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

On 12/18/19 9:42 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/intel-iommu.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 42966611a192..a6d5b7cf9183 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   	list_add_tail(&reg->list, head);
>   }
>   
> -static void intel_iommu_put_resv_regions(struct device *dev,
> -					 struct list_head *head)
> -{
> -	struct iommu_resv_region *entry, *next;
> -
> -	list_for_each_entry_safe(entry, next, head, list)
> -		kfree(entry);
> -}
> -
>   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
>   {
>   	struct device_domain_info *info;
> @@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.add_device		= intel_iommu_add_device,
>   	.remove_device		= intel_iommu_remove_device,
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
> -	.put_resv_regions	= intel_iommu_put_resv_regions,
> +	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.apply_resv_region	= intel_iommu_apply_resv_region,
>   	.device_group		= pci_device_group,
>   	.dev_has_feat		= intel_iommu_dev_has_feat,
> 
