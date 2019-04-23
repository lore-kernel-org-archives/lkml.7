Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E348C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3884120811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDWLM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:12:57 -0400
Received: from foss.arm.com ([217.140.101.70]:54548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfDWLM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:12:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FBDB374;
        Tue, 23 Apr 2019 04:12:55 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32343F557;
        Tue, 23 Apr 2019 04:12:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context
 fault
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        will.deacon@arm.com, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <20190422071036.32671-1-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
Date:   Tue, 23 Apr 2019 12:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422071036.32671-1-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 08:10, Vivek Gautam wrote:
> Bits[15:0] in CBFRSYNRA register contain information about
> StreamID of the incoming transaction that generated the
> fault. Dump CBFRSYNRA register to get this info.
> This is specially useful in a distributed SMMU architecture
> where multiple masters are connected to the SMMU.
> SID information helps to quickly identify the faulting
> master device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
>   - Addressed review comments, given by Bjorn, for nits.
> 
>   drivers/iommu/arm-smmu-regs.h | 2 ++
>   drivers/iommu/arm-smmu.c      | 7 +++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..e9132a926761 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
>   #define CBAR_IRPTNDX_SHIFT		24
>   #define CBAR_IRPTNDX_MASK		0xff
>   
> +#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
> +
>   #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>   #define CBA2R_RW64_32BIT		(0 << 0)
>   #define CBA2R_RW64_64BIT		(1 << 0)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..e000473f8205 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>   	void __iomem *cb_base;
> +	u32 cbfrsynra;

Nit: I would simply add to the existing "u32 fsr, fsynr;" declaration, 
but that's the sort of thing that could hopefully be fixed up when 
applying (or otherwise I might bulldoze it anyway in my eventual rework 
of register accesses throughout the driver). Regardless,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>   	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> @@ -585,10 +587,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>   
>   	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>   	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> +	cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
>   
>   	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cfg->cbndx);
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +			    fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
>   
>   	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>   	return IRQ_HANDLED;
> 
