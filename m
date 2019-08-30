Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F360421897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfH3Pnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:43:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3Pnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:43:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71040344;
        Fri, 30 Aug 2019 08:43:40 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9729F3F703;
        Fri, 30 Aug 2019 08:43:38 -0700 (PDT)
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Add global/context fault
 implementation hooks
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
        mperttunen@nvidia.com, praithatha@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, avanbrunt@nvidia.com,
        linux-arm-kernel@lists.infradead.org
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-5-git-send-email-vdumpa@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5ab7c402-344d-0967-2ecf-21e24ecd0a0f@arm.com>
Date:   Fri, 30 Aug 2019 16:43:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-5-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 23:47, Krishna Reddy wrote:
> Add global/context fault hooks to allow Nvidia SMMU implementation
> handle faults across multiple SMMUs.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   drivers/iommu/arm-smmu-nvidia.c | 127 ++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c        |   6 ++
>   drivers/iommu/arm-smmu.h        |   4 ++
>   3 files changed, 137 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
> index a429b2c..b2a3c49 100644
> --- a/drivers/iommu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -14,6 +14,10 @@
>   
>   #define NUM_SMMU_INSTANCES 3
>   
> +static irqreturn_t nsmmu_context_fault_inst(int irq,
> +					    struct arm_smmu_device *smmu,
> +					    int idx, int inst);
> +
>   struct nvidia_smmu {
>   	struct arm_smmu_device	smmu;
>   	int			num_inst;
> @@ -87,12 +91,135 @@ static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
>   		nsmmu_tlb_sync_wait(smmu, page, sync, status, i);
>   }
>   
> +static irqreturn_t nsmmu_global_fault_inst(int irq,
> +					       struct arm_smmu_device *smmu,
> +					       int inst)
> +{
> +	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
> +
> +	gfsr = readl_relaxed(nsmmu_page(smmu, inst, 0) + ARM_SMMU_GR0_sGFSR);
> +	gfsynr0 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
> +				ARM_SMMU_GR0_sGFSYNR0);
> +	gfsynr1 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
> +				ARM_SMMU_GR0_sGFSYNR1);
> +	gfsynr2 = readl_relaxed(nsmmu_page(smmu, inst, 0) +
> +				ARM_SMMU_GR0_sGFSYNR2);
> +
> +	if (!gfsr)
> +		return IRQ_NONE;
> +
> +	dev_err_ratelimited(smmu->dev,
> +		"Unexpected global fault, this could be serious\n");
> +	dev_err_ratelimited(smmu->dev,
> +		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
> +		gfsr, gfsynr0, gfsynr1, gfsynr2);
> +
> +	writel_relaxed(gfsr, nsmmu_page(smmu, inst, 0) + ARM_SMMU_GR0_sGFSR);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nsmmu_global_fault(int irq, struct arm_smmu_device *smmu)
> +{
> +	int i;
> +	irqreturn_t irq_ret = IRQ_NONE;
> +
> +	/* Interrupt line is shared between global and context faults.
> +	 * Check for both type of interrupts on either fault handlers.
> +	 */
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++) {
> +		irq_ret = nsmmu_context_fault_inst(irq, smmu, 0, i);
> +		if (irq_ret == IRQ_HANDLED)
> +			return irq_ret;
> +	}
> +
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++) {
> +		irq_ret = nsmmu_global_fault_inst(irq, smmu, i);
> +		if (irq_ret == IRQ_HANDLED)
> +			return irq_ret;
> +	}
> +
> +	return irq_ret;
> +}
> +
> +static irqreturn_t nsmmu_context_fault_bank(int irq,
> +					    struct arm_smmu_device *smmu,
> +					    int idx, int inst)
> +{
> +	u32 fsr, fsynr, cbfrsynra;
> +	unsigned long iova;
> +
> +	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> +	if (!(fsr & FSR_FAULT))
> +		return IRQ_NONE;
> +
> +	fsynr = readl_relaxed(nsmmu_page(smmu, inst, smmu->numpage + idx) +
> +			      ARM_SMMU_CB_FSYNR0);
> +	iova = readq_relaxed(nsmmu_page(smmu, inst, smmu->numpage + idx) +
> +			     ARM_SMMU_CB_FAR);
> +	cbfrsynra = readl_relaxed(nsmmu_page(smmu, inst, 1) +
> +				  ARM_SMMU_GR1_CBFRSYNRA(idx));
> +
> +	dev_err_ratelimited(smmu->dev,
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +			    fsr, iova, fsynr, cbfrsynra, idx);
> +
> +	writel_relaxed(fsr, nsmmu_page(smmu, inst, smmu->numpage + idx) +
> +			    ARM_SMMU_CB_FSR);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nsmmu_context_fault_inst(int irq,
> +					    struct arm_smmu_device *smmu,
> +					    int idx, int inst)
> +{
> +	irqreturn_t irq_ret = IRQ_NONE;
> +
> +	/* Interrupt line shared between global and all context faults.
> +	 * Check for faults across all contexts.
> +	 */
> +	for (idx = 0; idx < smmu->num_context_banks; idx++) {
> +		irq_ret = nsmmu_context_fault_bank(irq, smmu, idx, inst);
> +
> +		if (irq_ret == IRQ_HANDLED)
> +			break;
> +	}
> +
> +	return irq_ret;
> +}
> +
> +static irqreturn_t nsmmu_context_fault(int irq,
> +				       struct arm_smmu_device *smmu,
> +				       int cbndx)
> +{
> +	int i;
> +	irqreturn_t irq_ret = IRQ_NONE;
> +
> +	/* Interrupt line is shared between global and context faults.
> +	 * Check for both type of interrupts on either fault handlers.
> +	 */
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++) {
> +		irq_ret = nsmmu_global_fault_inst(irq, smmu, i);
> +		if (irq_ret == IRQ_HANDLED)
> +			return irq_ret;
> +	}
> +
> +	for (i = 0; i < to_nsmmu(smmu)->num_inst; i++) {
> +		irq_ret = nsmmu_context_fault_inst(irq, smmu, cbndx, i);
> +		if (irq_ret == IRQ_HANDLED)
> +			return irq_ret;
> +	}
> +
> +	return irq_ret;
> +}
> +
>   static const struct arm_smmu_impl nsmmu_impl = {
>   	.read_reg = nsmmu_read_reg,
>   	.write_reg = nsmmu_write_reg,
>   	.read_reg64 = nsmmu_read_reg64,
>   	.write_reg64 = nsmmu_write_reg64,
>   	.tlb_sync = nsmmu_tlb_sync,
> +	.global_fault = nsmmu_global_fault,
> +	.context_fault = nsmmu_context_fault,
>   };
>   
>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f5454e71..9cc532d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -454,6 +454,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	int idx = smmu_domain->cfg.cbndx;
>   
> +	if (smmu->impl->context_fault)
> +		return smmu->impl->context_fault(irq, smmu, idx);
> +
>   	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>   	if (!(fsr & FSR_FAULT))
>   		return IRQ_NONE;
> @@ -475,6 +478,9 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>   	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
>   	struct arm_smmu_device *smmu = dev;
>   
> +	if (smmu->impl->global_fault)
> +		return smmu->impl->global_fault(irq, smmu);

Can't we just register impl->global_fault (if set) instead of 
arm_smmu_global_fault as the handler when we first set up the IRQs in 
arm_smmu_device_probe()?

Ideally we'd do the same for the context banks as well, although we 
might need an additional hook from which to request the secondary IRQs 
that the main flow can't accommodate.

Robin.

> +
>   	gfsr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSR);
>   	gfsynr0 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR0);
>   	gfsynr1 = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sGFSYNR1);
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index d3217f1..dec5e1a 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -17,6 +17,7 @@
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/io-pgtable.h>
>   #include <linux/iommu.h>
> +#include <linux/irqreturn.h>
>   #include <linux/mutex.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> @@ -340,6 +341,9 @@ struct arm_smmu_impl {
>   	int (*init_context)(struct arm_smmu_domain *smmu_domain);
>   	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>   			 int status);
> +	irqreturn_t (*global_fault)(int irq, struct arm_smmu_device *smmu);
> +	irqreturn_t (*context_fault)(int irq, struct arm_smmu_device *smmu,
> +				     int cbndx);
>   };
>   
>   static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
> 
