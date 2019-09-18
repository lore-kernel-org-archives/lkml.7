Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D15C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B071221907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568821064;
	bh=o8d7dJQnvHL39KRSK6KjVP0f0KtmfzKyIduld2o7JMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=on2DVWhqC3tS/wi50z1NH/trtGFVuaWkd/dQTXYd2t8xbJDo3N6kaJhq9+NALVgoW
	 AcucivIZwunx5da6w8LOCsDAoTy46c3PUP/JPLrzAe62jigmgjAhtN3DF4jI0Lb0Xd
	 TX7Hc1+8xL7qxAV/OKIm8ohXPMmoTlNlModuhfcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfIRPhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfIRPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:37:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E422A21848;
        Wed, 18 Sep 2019 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568821062;
        bh=o8d7dJQnvHL39KRSK6KjVP0f0KtmfzKyIduld2o7JMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6RCkLeoK1SHQW8pEwDSkWFf3OL7vtPollpZp9p6cfdYVaaOTfpSbPfvfQfWkO448
         IGY6tm12B5p36OrH3wTXMnkgWd7r7VJ2184V0HrBsuKhv7eWKSjpmpiZmsslReXLrc
         8L1mSHwAHB0oZ2pSUrJYW7DWdjpkn3bCs1TJP5AI=
Date:   Wed, 18 Sep 2019 16:37:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Message-ID: <20190918153737.dea2z5dddhuus25g@willie-the-truck>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
 <20190829111752.17513-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-2-thierry.reding@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:17:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Implement a generic function for removing reserved regions. This can be
> used by drivers that don't do anything fancy with these regions other
> than allocating memory for them.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0f585b614657..73a2a6b13507 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  		ops->put_resv_regions(dev, list);
>  }
>  
> +/**
> + * iommu_put_resv_regions_simple - Reserved region driver helper
> + * @dev: device for which to free reserved regions
> + * @list: reserved region list for device
> + *
> + * IOMMU drivers can use this to implement their .put_resv_regions() callback
> + * for simple reservations. Memory allocated for each reserved region will be
> + * freed. If an IOMMU driver allocates additional resources per region, it is
> + * going to have to implement a custom callback.
> + */
> +void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, list, list)
> +		kfree(entry);
> +}
> +EXPORT_SYMBOL(iommu_put_resv_regions_simple);

Can you call this directly from iommu_put_resv_regions() if the function
pointer in ops is NULL? That would save having to plumb the default callback
into a bunch of drivers.

Will
