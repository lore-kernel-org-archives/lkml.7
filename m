Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E207206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWPQMn+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfCYVQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:16:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35373 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbfCYVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:16:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so7045799pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4BzU9k+CtqDZ1j76qBcTb5kQ8SsjjODmCUIQVnBeD+Q=;
        b=UWPQMn+mPKdiUi8P3tjKi5y0jsM8j+OEbfoG1mff84YHF7QShqTifmZ84EL+/ESntS
         q+AM6ryD+AsrWhxKBAOFaEjpLjvwwbUu8Zs0yj5W3RTwS7aK8BUNFnptPqJAcj2wscZS
         ZMICsd+BhZkyf2GpOpw7TKg9b8vft1O6s0rzXcKdC7Bqs8SEpVSS+5Czrf5ARU2XgsZl
         99olkcfUoZhIPrZ9V/YmUlFKSs/9R9xHb8XZNjNcPoXphpALl8QE+gy2LjAtnajWbeyH
         UQQ6A4iYybOgC0kQMsUpjwm2g1NzUustlxWhcy8DS2ZaxGhR30wvpAAWi6ZKKYlcadv/
         0tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4BzU9k+CtqDZ1j76qBcTb5kQ8SsjjODmCUIQVnBeD+Q=;
        b=YO1umRO7VuBk1CsCSY8qg6aDZ90Aclos+lpC9jO6v6Je5DNVBxWF+mKdlcuh1Ksq7h
         mu4TUN+eocZumMQKnD7fYw15D/Q8bZ5yIuz0AnOzZGSBoXUxZWS4SdmFOyQNWC1Bienn
         fyMyqA235dFbplrw9oI3iAV3m1a1uq2kgN+J8a7W4xiIdhkq+fZAq8kH64W6X9mu3E5T
         5ZofIuoCwSJzyZD02Bsar8uuSUU3o/RQIvMwiIpGcsYyOejWHbn/Wkn/55Gjw1bnyczr
         5/YQJwWnaBzPkfX1AU3R1ialBotGtCoq/wCs3R2TiL26ZQBRiE+xzj7VNc5I23gIpZzi
         PEFQ==
X-Gm-Message-State: APjAAAWW6Zmj780LLb3Q3AziHDxS8CgkuxZxvqN9ta5cY9Wj2Ayl5EiG
        wOyNmTN2TNJYWmWUBxGNS5BVLA==
X-Google-Smtp-Source: APXvYqwPYMq0cvOc5K7EsKwL9LEMAMhj0LVdn3ZJ/krQoBed1zbyvbvcHj4SpHIMzert6m6l6IoAvw==
X-Received: by 2002:a65:6497:: with SMTP id e23mr24706297pgv.21.1553548602684;
        Mon, 25 Mar 2019 14:16:42 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p34sm27347416pgb.18.2019.03.25.14.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:16:41 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:16:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Add support to handle Qcom's TLBI
 serialization errata
Message-ID: <20190325211639.GD2899@builder>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910062551.28175-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Sep 23:25 PDT 2018, Vivek Gautam wrote:

> Qcom's implementation of arm,mmu-500 require to serialize all
> TLB invalidations for context banks.
> In case the TLB invalidation requests don't go through the first
> time, there's a way to disable/enable the wait for safe logic.
> Disabling this logic expadites the TLBIs.
> 

Reading this I get a feeling that this will give a slight performance
boost, but after finally narrowing the last weeks performance hunt down
I've concluded that without this patch we loose 1000x throughput on UFS
and USB (even I2C is completely useless) when the display is on.

So this is definitely needed for SDM845 devices, such as the Dragonboard
845c and MTP, to be functional.

> Different bootloaders with their access control policies allow this
> register access differntly. With one, we should be able to directly
> make qcom-scm call to do io read/write, while with other we should
> use the specific SCM command to send request to do the complete
> register configuration.
> A separate device tree flag for arm-smmu will allow to identify
> which firmware configuration of the two mentioned above we use.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm-smmu-regs.h |   2 +
>  drivers/iommu/arm-smmu.c      | 133 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..71662cae9806 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -177,6 +177,8 @@ enum arm_smmu_s2cr_privcfg {
>  #define ARM_SMMU_CB_ATS1PR		0x800
>  #define ARM_SMMU_CB_ATSR		0x8f0
>  
> +#define ARM_SMMU_GID_QCOM_CUSTOM_CFG	0x300
> +
>  #define SCTLR_S1_ASIDPNE		(1 << 12)
>  #define SCTLR_CFCFG			(1 << 7)
>  #define SCTLR_CFIE			(1 << 6)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 411e5ac57c64..de9c4a5bf686 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -49,6 +49,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/qcom_scm.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> @@ -181,7 +182,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_EXIDS		(1 << 12)
>  	u32				features;
>  
> -#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> +#define ARM_SMMU_OPT_SECURE_CFG_ACCESS	 (1 << 0)
> +#define ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA (1 << 1)
>  	u32				options;
>  	enum arm_smmu_arch_version	version;
>  	enum arm_smmu_implementation	model;
> @@ -266,6 +268,7 @@ static bool using_legacy_binding, using_generic_binding;
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
> +	{ ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA, "qcom,smmu-500-fw-impl-errata" },
>  	{ 0, NULL},
>  };
>  
> @@ -531,12 +534,134 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
>  	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
>  }
>  
> +#define CUSTOM_CFG_MDP_SAFE_ENABLE		BIT(15)
> +#define CUSTOM_CFG_IFE1_SAFE_ENABLE		BIT(14)
> +#define CUSTOM_CFG_IFE0_SAFE_ENABLE		BIT(13)
> +
> +static int __qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu, int en)
> +{
> +	int ret;
> +	u32 val, gid_phys_base;
> +	phys_addr_t reg;
> +	struct vm_struct *vm;
> +
> +	/* We want physical address of SMMU, so the vm_area */
> +	vm = find_vm_area(smmu->base);
> +
> +	/*
> +	 * GID (implementation defined address space) is located at
> +	 * SMMU_BASE + (2 × PAGESIZE).
> +	 */
> +	gid_phys_base = vm->phys_addr + (2 << (smmu)->pgshift);
> +	reg = gid_phys_base + ARM_SMMU_GID_QCOM_CUSTOM_CFG;
> +
> +	ret = qcom_scm_io_readl_atomic(reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (en)
> +		val |= CUSTOM_CFG_MDP_SAFE_ENABLE |
> +		       CUSTOM_CFG_IFE0_SAFE_ENABLE |
> +		       CUSTOM_CFG_IFE1_SAFE_ENABLE;
> +	else
> +		val &= ~(CUSTOM_CFG_MDP_SAFE_ENABLE |
> +			 CUSTOM_CFG_IFE0_SAFE_ENABLE |
> +			 CUSTOM_CFG_IFE1_SAFE_ENABLE);
> +
> +	ret = qcom_scm_io_writel_atomic(reg, val);
> +
> +	return ret;
> +}
> +
> +static int qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu,
> +				     int en, bool is_fw_impl)
> +{
> +	if (is_fw_impl)
> +		return qcom_scm_qsmmu500_wait_safe_toggle(en);
> +	else
> +		return __qsmmu500_wait_safe_toggle(smmu, en);
> +}
> +
> +static void qcom_errata_tlb_sync(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
> +	bool is_fw_impl;
> +	u32 val;
> +
> +	writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
> +
> +	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> +				       !(val & sTLBGSTATUS_GSACTIVE), 0, 100))
> +		return;
> +
> +	is_fw_impl = smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA ?
> +			true : false;
> +
> +	/* SCM call here to disable the wait-for-safe logic. */
> +	if (WARN(qsmmu500_wait_safe_toggle(smmu, false, is_fw_impl),
> +		 "Failed to disable wait-safe logic, bad hw state\n"))
> +		return;
> +
> +	if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> +				       !(val & sTLBGSTATUS_GSACTIVE), 0, 10000))
> +		return;
> +
> +	/* SCM call here to re-enable the wait-for-safe logic. */
> +	WARN(qsmmu500_wait_safe_toggle(smmu, true, is_fw_impl),
> +	     "Failed to re-enable wait-safe logic, bad hw state\n");
> +
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU in bad state\n");
> +}
> +
> +static void qcom_errata_tlb_sync_context(void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	qcom_errata_tlb_sync(smmu_domain);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +}
> +
> +static void qcom_errata_tlb_inv_context_s1(void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
> +	qcom_errata_tlb_sync(cookie);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +}
> +
> +static void qcom_errata_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					     size_t granule, bool leaf,
> +					     void *cookie)
> +{
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> +	arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
> +	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> +}
> +
>  static const struct iommu_gather_ops arm_smmu_s1_tlb_ops = {
>  	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
>  	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
>  	.tlb_sync	= arm_smmu_tlb_sync_context,
>  };
>  
> +static const struct iommu_gather_ops qcom_errata_s1_tlb_ops = {
> +	.tlb_flush_all	= qcom_errata_tlb_inv_context_s1,
> +	.tlb_add_flush	= qcom_errata_tlb_inv_range_nosync,
> +	.tlb_sync	= qcom_errata_tlb_sync_context,
> +};
> +
>  static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 = {
>  	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
>  	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
> @@ -824,7 +949,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  			ias = min(ias, 32UL);
>  			oas = min(oas, 32UL);
>  		}
> -		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
> +		if (of_device_is_compatible(smmu->dev->of_node,
> +					    "qcom,sdm845-smmu-500"))
> +			smmu_domain->tlb_ops = &qcom_errata_s1_tlb_ops;
> +		else
> +			smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
>  		break;
>  	case ARM_SMMU_DOMAIN_NESTED:
>  		/*
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
