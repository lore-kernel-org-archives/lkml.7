Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D0C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D9820645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfGHH6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:58:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C0042F8BF7;
        Mon,  8 Jul 2019 07:58:23 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FFC417D40;
        Mon,  8 Jul 2019 07:58:20 +0000 (UTC)
Subject: Re: [PATCH 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-9-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b0e3d9a9-6085-b393-1982-3dd95bf5d100@redhat.com>
Date:   Mon, 8 Jul 2019 09:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190610184714.6786-9-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 08 Jul 2019 07:58:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 6/10/19 8:47 PM, Jean-Philippe Brucker wrote:
> Enable PASID for PCI devices that support it. Since the SSID tables are
> allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> arm_smmu_dev_feature_enable() would be too late, since by that time the
> main DMA domain has already been attached. Do it in add_device() instead.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
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
I don't really get why this setting is conditional to the success of
pci_enabled_pasid and not num_pasids > 0.

If it fails the ssid_bits is set to min(smmu->ssid_bits,
fwspec->num_pasid_bits) anyway.

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
in case of a platform device you leave the ssid_bits to a value != 0. Is
that what you want?
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
In case the call fails, don't you want to handle the error and reset the
ssid_bits?
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
> 
Thanks

Eric
