Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE029C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C22341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfH3PCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:02:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfH3PCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:02:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E95344;
        Fri, 30 Aug 2019 08:02:45 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE87E3F703;
        Fri, 30 Aug 2019 08:02:42 -0700 (PDT)
Subject: Re: [PATCH 1/7] iommu/arm-smmu: add Nvidia SMMUv2 implementation
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
        mperttunen@nvidia.com, praithatha@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, avanbrunt@nvidia.com,
        linux-arm-kernel@lists.infradead.org
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-2-git-send-email-vdumpa@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2ae9e0c4-6916-b005-f4bd-29e06d2056c6@arm.com>
Date:   Fri, 30 Aug 2019 16:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-2-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 23:47, Krishna Reddy wrote:
> Add Nvidia SMMUv2 implementation and model info.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   MAINTAINERS                     |  2 +
>   drivers/iommu/Makefile          |  2 +-
>   drivers/iommu/arm-smmu-impl.c   |  2 +
>   drivers/iommu/arm-smmu-nvidia.c | 97 +++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c        |  2 +
>   drivers/iommu/arm-smmu.h        |  2 +
>   6 files changed, 106 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/iommu/arm-smmu-nvidia.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 289fb06..b9d59e51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15785,9 +15785,11 @@ F:	drivers/i2c/busses/i2c-tegra.c
>   
>   TEGRA IOMMU DRIVERS
>   M:	Thierry Reding <thierry.reding@gmail.com>
> +R:	Krishna Reddy <vdumpa@nvidia.com>
>   L:	linux-tegra@vger.kernel.org
>   S:	Supported
>   F:	drivers/iommu/tegra*
> +F:	drivers/iommu/arm-smmu-nvidia.c
>   
>   TEGRA KBC DRIVER
>   M:	Laxman Dewangan <ldewangan@nvidia.com>
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a2729aa..7f5489e 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>   obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
> -obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o
> +obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>   obj-$(CONFIG_DMAR_TABLE) += dmar.o
>   obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 5c87a38..e5e595f 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -162,6 +162,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>   		break;
>   	case CAVIUM_SMMUV2:
>   		return cavium_smmu_impl_init(smmu);
> +	case NVIDIA_SMMUV2:
> +		return nvidia_smmu_impl_init(smmu);
>   	default:
>   		break;
>   	}
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> new file mode 100644
> index 0000000..d93ceda
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Nvidia ARM SMMU v2 implementation quirks
> +// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.
> +
> +#define pr_fmt(fmt) "nvidia-smmu: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "arm-smmu.h"
> +
> +#define NUM_SMMU_INSTANCES 3
> +
> +struct nvidia_smmu {
> +	struct arm_smmu_device	smmu;
> +	int			num_inst;
> +	void __iomem		*bases[NUM_SMMU_INSTANCES];
> +};
> +
> +#define to_nsmmu(s)	container_of(s, struct nvidia_smmu, smmu)
> +
> +#define nsmmu_page(smmu, inst, page) \
> +	(((inst) ? to_nsmmu(smmu)->bases[(inst)] : smmu->base) + \
> +	((page) << smmu->pgshift))
> +
> +static u32 nsmmu_read_reg(struct arm_smmu_device *smmu,
> +			      int page, int offset)
> +{
> +	return readl_relaxed(nsmmu_page(smmu, 0, page) + offset);
> +}
> +
> +static void nsmmu_write_reg(struct arm_smmu_device *smmu,
> +				int page, int offset, u32 val)
> +{
> +	int i;
> +
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++)
> +		writel_relaxed(val, nsmmu_page(smmu, i, page) + offset);
> +}
> +
> +static u64 nsmmu_read_reg64(struct arm_smmu_device *smmu,
> +				int page, int offset)
> +{
> +	return readq_relaxed(nsmmu_page(smmu, 0, page) + offset);
> +}
> +
> +static void nsmmu_write_reg64(struct arm_smmu_device *smmu,
> +				  int page, int offset, u64 val)
> +{
> +	int i;
> +
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++)
> +		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
> +}
> +
> +static const struct arm_smmu_impl nsmmu_impl = {
> +	.read_reg = nsmmu_read_reg,
> +	.write_reg = nsmmu_write_reg,
> +	.read_reg64 = nsmmu_read_reg64,
> +	.write_reg64 = nsmmu_write_reg64,
> +};
> +
> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +	int i;
> +	struct nvidia_smmu *nsmmu;
> +	struct resource *res;
> +	struct device *dev = smmu->dev;
> +	struct platform_device *pdev = to_platform_device(smmu->dev);
> +
> +	nsmmu = devm_kzalloc(smmu->dev, sizeof(*nsmmu), GFP_KERNEL);
> +	if (!nsmmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nsmmu->smmu = *smmu;
> +	/* Instance 0 is ioremapped by arm-smmu.c */
> +	nsmmu->num_inst = 1;
> +
> +	for (i = 1; i < NUM_SMMU_INSTANCES; i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			break;
> +		nsmmu->bases[i] = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(nsmmu->bases[i]))
> +			return (struct arm_smmu_device *)nsmmu->bases[i];
> +		nsmmu->num_inst++;
> +	}
> +
> +	nsmmu->smmu.impl = &nsmmu_impl;
> +	devm_kfree(smmu->dev, smmu);
> +	pr_info("Nvidia SMMUv2, Instances=%d\n", nsmmu->num_inst);
> +
> +	return &nsmmu->smmu;
> +}
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5b93c79..46e1641 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1871,6 +1871,7 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
>   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
>   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
>   ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
> +ARM_SMMU_MATCH_DATA(nvidia_smmuv2, ARM_SMMU_V2, NVIDIA_SMMUV2);

 From the previous discussions, I got the impression that other than the 
'novel' way they're integrated, the actual SMMU implementations were 
unmodified Arm MMU-500s. Is that the case, or have I misread something?

Robin.

>   
>   static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
> @@ -1880,6 +1881,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>   	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
> +	{ .compatible = "nvidia,smmu-v2", .data = &nvidia_smmuv2 },
>   	{ },
>   };
>   
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index b19b6ca..9645bf1 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -220,6 +220,7 @@ enum arm_smmu_implementation {
>   	ARM_MMU500,
>   	CAVIUM_SMMUV2,
>   	QCOM_SMMUV2,
> +	NVIDIA_SMMUV2,
>   };
>   
>   struct arm_smmu_device {
> @@ -398,5 +399,6 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>   	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
>   
>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
>   
>   #endif /* _ARM_SMMU_H */
> 
