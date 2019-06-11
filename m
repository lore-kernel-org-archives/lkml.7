Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9152145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404472AbfFKJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:42:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391206AbfFKJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:42:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE189CF4700FAD13C19D;
        Tue, 11 Jun 2019 17:42:27 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 17:42:26 +0800
Date:   Tue, 11 Jun 2019 10:42:14 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <robh+dt@kernel.org>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
Message-ID: <20190611104214.00001f2c@huawei.com>
In-Reply-To: <20190610184714.6786-4-jean-philippe.brucker@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
        <20190610184714.6786-4-jean-philippe.brucker@arm.com>
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

On Mon, 10 Jun 2019 19:47:09 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> For platform devices that support SubstreamID (SSID), firmware provides
> the number of supported SSID bits. Restrict it to what the SMMU supports
> and cache it into master->ssid_bits.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Missing kernel-doc.

Thanks,

Jonathan

> ---
>  drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
>  drivers/iommu/of_iommu.c    |  6 +++++-
>  include/linux/iommu.h       |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d5a694f02c2..3254f473e681 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -604,6 +604,7 @@ struct arm_smmu_master {
>  	struct list_head		domain_head;
>  	u32				*sids;
>  	unsigned int			num_sids;
> +	unsigned int			ssid_bits;
>  	bool				ats_enabled		:1;
>  };
>  
> @@ -2097,6 +2098,16 @@ static int arm_smmu_add_device(struct device *dev)
>  		}
>  	}
>  
> +	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> +
> +	/*
> +	 * If the SMMU doesn't support 2-stage CD, limit the linear
> +	 * tables to a reasonable number of contexts, let's say
> +	 * 64kB / sizeof(ctx_desc) = 1024 = 2^10
> +	 */
> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
> +		master->ssid_bits = min(master->ssid_bits, 10U);
> +
>  	group = iommu_group_get_for_dev(dev);
>  	if (!IS_ERR(group)) {
>  		iommu_group_put(group);
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f04a6df65eb8..04f4f6b95d82 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -206,8 +206,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			if (err)
>  				break;
>  		}
> -	}
>  
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (!err && fwspec)
> +			of_property_read_u32(master_np, "pasid-num-bits",
> +					     &fwspec->num_pasid_bits);
> +	}
>  
>  	/*
>  	 * Two success conditions can be represented by non-negative err here:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 519e40fb23ce..b91df613385f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -536,6 +536,7 @@ struct iommu_fwspec {
>  	struct fwnode_handle	*iommu_fwnode;
>  	void			*iommu_priv;
>  	u32			flags;
> +	u32			num_pasid_bits;

This structure has kernel doc so you need to add something for this.

>  	unsigned int		num_ids;
>  	u32			ids[1];
>  };


