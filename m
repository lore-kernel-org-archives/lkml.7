Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51742075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCDMUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:20:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCDMUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:20:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986BEA78;
        Mon,  4 Mar 2019 04:20:11 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41BC3F575;
        Mon,  4 Mar 2019 04:20:09 -0800 (PST)
Subject: Re: [RFC PATCH v1 05/15] iommu/arm-smmu: Add auxiliary domain support
 for arm-smmuv2
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        dianders@chromimum.org, hoegsberg@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-6-git-send-email-jcrouse@codeaurora.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d0d0849f-56ab-94c6-f081-210f94353a2d@arm.com>
Date:   Mon, 4 Mar 2019 12:19:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551469117-3404-6-git-send-email-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

On 01/03/2019 19:38, Jordan Crouse wrote:
> Support the new auxiliary domain API for arm-smmuv2 to initialize and
> support multiple pagetables for a SMMU device. Since the smmu-v2 hardware
> doesn't have any built in support for switching the pagetable base it is
> left as an exercise to the caller to actually use the pagetable; aux
> domains in the IOMMU driver are only preoccupied with creating and managing
> the pagetable memory.
> 
> Following is a pseudo code example of how a domain can be created
> 
>  /* Check to see if aux domains are supported */
>  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> 	 iommu = iommu_domain_alloc(...);
> 
> 	 if (iommu_aux_attach_device(domain, dev))
> 		 return FAIL;
> 
> 	/* Save the base address of the pagetable for use by the driver
> 	iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
>  }

> After this 'domain' can be used like any other iommu domain to map and
> unmap iova addresses in the pagetable. The driver/hardware can be used
> to switch the pagetable according to its own specific implementation.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

[...]
> +static bool arm_smmu_dev_has_feat(struct device *dev,
> +		enum iommu_dev_features feat)
> +{
> +	/*
> +	 * FIXME: Should we do some hardware checking here, like to be sure this
> +	 * is a stage 1 and such?
> +	 */
> +
> +	/* Always allow aux domains */
> +	if (feat == IOMMU_DEV_FEAT_AUX)
> +		return true;

If possible, we should only return true when SMMU and GPU are able to
coordinate and switch contexts. Can the feature be identified through ID
reg or compatible string?

If we plug a PCIe card with PASID behind a SMMUv2 'classic', and its
driver attempts to enable AUXD support, then this should return false.

> +
> +	return false;
> +}
> +
> +/* FIXME: Add stubs for dev_enable_feat and dev_disable_feat? */

Ideally yes. Although SMMUv2 support for aux domains will likely only be
used by the MSM driver, using the same model in all IOMMU drivers would
ease moving things to common code later.

> +
> +/* Set up a new aux domain and create a new pagetable with the same
> + * characteristics as the master
> + */
> +static int arm_smmu_aux_attach_dev(struct iommu_domain *domain,
> +		struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	smmu_domain->is_aux = true;

The API allows to attach the same domain to one device using
aux_attach_dev() and another using attach_dev(). For SMMUv3 we'll reject
this, since normal and aux domain are different things (one has PASID
tables, the other doesn't). Is this supported by SMMUv2? Otherwise some
sanity-check here might be necessary

> +
> +	/* No power is needed because aux domain doesn't touch the hardware */
> +	return arm_smmu_init_domain_context(domain, smmu);
> +}
> +
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret;
> @@ -1342,6 +1414,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		return -ENXIO;
>  	}
>  
> +	/* FIXME: Reject unmanged domains since those should be aux? */

No, unmanaged domains are also used by VFIO and a couple other drivers
that want to setup IOMMU mappings themselves.

Thanks,
Jean

> +
>  	/*
>  	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
>  	 * domains between of_xlate() and add_device() - we have no way to cope
> @@ -1388,7 +1462,13 @@ arm_smmu_get_pgtbl_ops(struct iommu_domain *domain, unsigned long iova)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
> +	struct arm_smmu_cb *cb;
> +
> +	/* quick escape for domains that don't have split pagetables enabled */
> +	if (!smmu_domain->pgtbl_ops[1])
> +		return smmu_domain->pgtbl_ops[0];
> +
> +	cb = &smmu_domain->smmu->cbs[cfg->cbndx];
>  
>  	if (iova & cb->split_table_mask)
>  		return smmu_domain->pgtbl_ops[1];
> @@ -1700,6 +1780,11 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  				!!(smmu_domain->attributes &
>  				   (1 << DOMAIN_ATTR_SPLIT_TABLES));
>  			return 0;
> +		case DOMAIN_ATTR_PTBASE:
> +			if (!smmu_domain->is_aux)
> +				return -ENODEV;
> +			*((u64 *)data) = smmu_domain->ttbr0;
> +			return 0;
>  		default:
>  			return -ENODEV;
>  		}
> @@ -1810,7 +1895,9 @@ static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
>  	.domain_free		= arm_smmu_domain_free,
> +	.dev_has_feat		= arm_smmu_dev_has_feat,
>  	.attach_dev		= arm_smmu_attach_dev,
> +	.aux_attach_dev		= arm_smmu_aux_attach_dev,
>  	.map			= arm_smmu_map,
>  	.unmap			= arm_smmu_unmap,
>  	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> 

