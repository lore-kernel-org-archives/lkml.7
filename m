Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E6920835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SB7gFcf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCGIo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:44:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3703 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:44:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c80da070000>; Thu, 07 Mar 2019 00:44:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 00:44:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Mar 2019 00:44:55 -0800
Received: from nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 08:44:55 +0000
Date:   Thu, 7 Mar 2019 00:44:54 -0800
From:   Neo Jia <cjia@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, <ashok.raj@intel.com>,
        <sanjay.k.kumar@intel.com>, <jacob.jun.pan@intel.com>,
        <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <peterx@redhat.com>,
        <tiwei.bie@intel.com>, <xin.zeng@intel.com>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
Message-ID: <20190307084453.GA9288@nvidia.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-10-baolu.lu@linux.intel.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.6.2 (2016-07-01)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551948295; bh=BDA6Ko/d05MsugX1KCmdhakB/UEuWEqecuuA/CKUBo8=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=SB7gFcf48r457Z/cn9qMSWRqc7D6n6z2ytMSePgUKvdBE8XbN91M4b5TSKT4FzzHn
         Yo7mBalPWNkd4oio7PZYgyurudkQvi7dYMV/jDFkI05v4TrqhnjSIcnFeu9vXA5tkW
         OynRvEsxqNG1X6w5HRJ99Sams9o1Ly4ZtdbPUjTZi9VrOdrDCj7bzttEiWmHt4h/Vq
         Fr0/g2PNvX05THEFs9YK4UR0DS8stIuDcgY710nzDOuQsM3BeyIO7J64aNO2f9Tt2U
         +mjCNoqn6ow5I45K4mU4gvk6rzFzNH9aUsYhrnVfdaxeVmKcTpinA10ZC8mxpHeYXo
         zDgZVZanBHvIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:19:27AM +0800, Lu Baolu wrote:
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
> ---
>  drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ccc4165474aa..f1392c582a3c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>  		iommu_detach_group(domain->domain, group->iommu_group);
>  }
>  

Hi Baolu,

To allow IOMMU-awared mdev, I think you need to modify the
vfio_iommu_type1_pin_pages and vfio_iommu_type1_unpin_pages to remove the
iommu->external_domain check.

Could you please include that in your patch? If not, I can send out a separate
patch to address that issue.

Thanks,
Neo

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
> @@ -1409,23 +1436,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
> -- 
> 2.17.1
> 
