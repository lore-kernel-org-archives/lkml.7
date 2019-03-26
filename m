Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84220856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CRXt6EcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfCZJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:33:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18007 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfCZJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:33:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c99f1f50000>; Tue, 26 Mar 2019 02:33:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 02:33:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 02:33:37 -0700
Received: from [10.24.70.251] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 09:33:30 +0000
Subject: Re: [PATCH v8 9/9] vfio/type1: Handle different mdev isolation type
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "xin.zeng@intel.com" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Neo Jia <cjia@nvidia.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-10-baolu.lu@linux.intel.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <82f373a8-27f0-d217-d87a-aa309acdbc29@nvidia.com>
Date:   Tue, 26 Mar 2019 15:03:26 +0530
MIME-Version: 1.0
In-Reply-To: <20190325013036.18400-10-baolu.lu@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553592821; bh=NNnE8HVHXsscFydPvxBmXWsxtv4b7BDhfp1LtG4AbHk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CRXt6EcRAqppq02bsN1qsfAVZ5Bq1fRehuimWW6qnetGfNUGWyGTNYV65nfHAsSbB
         8Tjk9buN4dgQEAflSB8qX41a+QiqgA6cRL83i/8YTUBgwaECrThGdfHImHr66XCKPN
         49cVQIcWrMzHJB4RBcQJBwBlqd/3W2qyGzuVt1yjcA9+Ohe8px/vkWYlr1pcQinB3M
         lae45FPT8DXd8Rw7Q+ostW/gq/QomtedEeXiIp6t9YEG7HKRImhu7Xy0LB02ozifIS
         uN0977w1qiFbyVSbuFBxpMOe267UvbSTPEqk6iEJiXzQDz5yrf84jXLZYXyapfgGyC
         Uj7lBMC9VHsOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 7:00 AM, Lu Baolu wrote:
> This adds the support to determine the isolation type
> of a mediated device group by checking whether it has
> an iommu device. If an iommu device exists, an iommu
> domain will be allocated and then attached to the iommu
> device. Otherwise, keep the same behavior as it is.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti


> ---
>  drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ccc4165474aa..b91cafcd5181 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -559,7 +559,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  	mutex_lock(&iommu->lock);
>  
>  	/* Fail if notifier list is empty */
> -	if ((!iommu->external_domain) || (!iommu->notifier.head)) {
> +	if (!iommu->notifier.head) {
>  		ret = -EINVAL;
>  		goto pin_done;
>  	}
> @@ -641,11 +641,6 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>  
>  	mutex_lock(&iommu->lock);
>  
> -	if (!iommu->external_domain) {
> -		mutex_unlock(&iommu->lock);
> -		return -EINVAL;
> -	}
> -
>  	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
>  	for (i = 0; i < npage; i++) {
>  		struct vfio_dma *dma;
> @@ -1368,13 +1363,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>  		iommu_detach_group(domain->domain, group->iommu_group);
>  }
>  
> +static bool vfio_bus_is_mdev(struct bus_type *bus)
> +{
> +	struct bus_type *mdev_bus;
> +	bool ret = false;
> +
> +	mdev_bus = symbol_get(mdev_bus_type);
> +	if (mdev_bus) {
> +		ret = (bus == mdev_bus);
> +		symbol_put(mdev_bus_type);
> +	}
> +
> +	return ret;
> +}
> +
> +static int vfio_mdev_iommu_device(struct device *dev, void *data)
> +{
> +	struct device **old = data, *new;
> +
> +	new = vfio_mdev_get_iommu_device(dev);
> +	if (!new || (*old && *old != new))
> +		return -EINVAL;
> +
> +	*old = new;
> +
> +	return 0;
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_group *group;
>  	struct vfio_domain *domain, *d;
> -	struct bus_type *bus = NULL, *mdev_bus;
> +	struct bus_type *bus = NULL;
>  	int ret;
>  	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base;
> @@ -1409,23 +1431,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_free;
>  
> -	mdev_bus = symbol_get(mdev_bus_type);
> +	if (vfio_bus_is_mdev(bus)) {
> +		struct device *iommu_device = NULL;
>  
> -	if (mdev_bus) {
> -		if ((bus == mdev_bus) && !iommu_present(bus)) {
> -			symbol_put(mdev_bus_type);
> +		group->mdev_group = true;
> +
> +		/* Determine the isolation type */
> +		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
> +					       vfio_mdev_iommu_device);
> +		if (ret || !iommu_device) {
>  			if (!iommu->external_domain) {
>  				INIT_LIST_HEAD(&domain->group_list);
>  				iommu->external_domain = domain;
> -			} else
> +			} else {
>  				kfree(domain);
> +			}
>  
>  			list_add(&group->next,
>  				 &iommu->external_domain->group_list);
>  			mutex_unlock(&iommu->lock);
> +
>  			return 0;
>  		}
> -		symbol_put(mdev_bus_type);
> +
> +		bus = iommu_device->bus;
>  	}
>  
>  	domain->domain = iommu_domain_alloc(bus);
> 
