Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A26C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0120866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfCZRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfCZRmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C962E307F5FE;
        Tue, 26 Mar 2019 17:42:38 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD16617992;
        Tue, 26 Mar 2019 17:42:37 +0000 (UTC)
Date:   Tue, 26 Mar 2019 11:42:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v8 9/9] vfio/type1: Handle different mdev isolation type
Message-ID: <20190326114237.6be15e47@x1.home>
In-Reply-To: <20190325013036.18400-10-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
        <20190325013036.18400-10-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 26 Mar 2019 17:42:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 09:30:36 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

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
>  drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 13 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


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

