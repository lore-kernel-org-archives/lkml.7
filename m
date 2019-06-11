Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBBC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CFD20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfFKKp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:45:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18547 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfFKKp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:45:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A2DE477F75B8C656581;
        Tue, 11 Jun 2019 18:45:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 18:45:52 +0800
Date:   Tue, 11 Jun 2019 11:45:42 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <robh+dt@kernel.org>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20190611114542.000021f1@huawei.com>
In-Reply-To: <20190610184714.6786-9-jean-philippe.brucker@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
        <20190610184714.6786-9-jean-philippe.brucker@arm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 19:47:14 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Enable PASID for PCI devices that support it. Since the SSID tables are
> allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> arm_smmu_dev_feature_enable() would be too late, since by that time the
> main DMA domain has already been attached. Do it in add_device() instead.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Nitpick in line.

Thanks,

Jonathan
> ---
>  drivers/iommu/arm-smmu-v3.c | 51 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 972bfb80f964..a8a516d9ff10 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2197,6 +2197,49 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>  	master->ats_enabled = false;
>  }
>  
> +static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
> +{
> +	int ret;
> +	int features;
> +	int num_pasids;
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return -ENOSYS;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	features = pci_pasid_features(pdev);
> +	if (features < 0)
> +		return -ENOSYS;
> +
> +	num_pasids = pci_max_pasids(pdev);
> +	if (num_pasids <= 0)
> +		return -ENOSYS;
> +
> +	ret = pci_enable_pasid(pdev, features);
> +	if (!ret)
> +		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> +					  master->smmu->ssid_bits);
> +	return ret;
> +}
> +
> +static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pdev->pasid_enabled)
> +		return;
> +
> +	pci_disable_pasid(pdev);
> +	master->ssid_bits = 0;

If we are being really fussy about ordering, why have this set of
ssid_bits after pci_disable_pasid rather than before (to reverse order
of .._enable_pasid)?

> +}
> +
>  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  {
>  	unsigned long flags;
> @@ -2413,6 +2456,9 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
>  
> +	/* Note that PASID must be enabled before, and disabled after ATS */
> +	arm_smmu_enable_pasid(master);
> +
>  	/*
>  	 * If the SMMU doesn't support 2-stage CD, limit the linear
>  	 * tables to a reasonable number of contexts, let's say
> @@ -2423,7 +2469,7 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	ret = iommu_device_link(&smmu->iommu, dev);
>  	if (ret)
> -		goto err_free_master;
> +		goto err_disable_pasid;
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
> @@ -2436,6 +2482,8 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  err_unlink:
>  	iommu_device_unlink(&smmu->iommu, dev);
> +err_disable_pasid:
> +	arm_smmu_disable_pasid(master);
>  err_free_master:
>  	kfree(master);
>  	fwspec->iommu_priv = NULL;
> @@ -2456,6 +2504,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	arm_smmu_detach_dev(master);
>  	iommu_group_remove_device(dev);
>  	iommu_device_unlink(&smmu->iommu, dev);
> +	arm_smmu_disable_pasid(master);
>  	kfree(master);
>  	iommu_fwspec_free(dev);
>  }


