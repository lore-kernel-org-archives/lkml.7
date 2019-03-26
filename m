Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB405C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959A320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UCb3rOd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfCZJc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:32:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4215 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:32:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c99f1c30000>; Tue, 26 Mar 2019 02:32:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 02:32:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 02:32:55 -0700
Received: from [10.24.70.251] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 09:32:48 +0000
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
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
 <20190325013036.18400-8-baolu.lu@linux.intel.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <b45dabe5-04ef-0e05-db25-c8edf111e355@nvidia.com>
Date:   Tue, 26 Mar 2019 15:02:44 +0530
MIME-Version: 1.0
In-Reply-To: <20190325013036.18400-8-baolu.lu@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553592771; bh=RjeaBpxhOXcLYBecoLMz46llJK4/0fRPQejaUMEb4qA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UCb3rOd0kRUcX6d5ePHglVck6Xwd3sp5zgDcN/XYpj/7O8MdPiz6FrbrHgg/ibCMg
         MEh7ktxdFbVcgvRhftLRfBZpWHCZssdhdHuQjU781ZnMFRZzZ/o1gzqw1UEdJnuh2R
         iU+3ScHUCbMqG/LcFnA9jFL4GehhqOSEG4miCNL7offSVXdoqkk2JeoBaRLaiK33+P
         ZZX2TOIbjeiL86br48q3A89tebvNcdE1ShiJn9bRl6Xr+/J4XXePNyoMJmKmBn86bf
         peYLfaiYBMKyIZkLzXtSZhngU0MSdotHvQh/PoAt/s8OrjLqWZ4ufVWafUdM75v670
         Gacj/iNTCqrYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 7:00 AM, Lu Baolu wrote:
> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in VT-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds a new member in the struct mdev_device to
> indicate that the mediated device represented by mdev could
> be isolated and protected by attaching a domain to a device
> represented by mdev->iommu_device. It also adds a helper to
> add or set the iommu device.
> 
> * mdev_device->iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation, hence bypass IOMMU.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  1 +
>  include/linux/mdev.h             | 14 ++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b96fedc77ee5..1b6435529166 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	return mdev->iommu_device;
> +}
> +EXPORT_SYMBOL(mdev_get_iommu_device);
> +
>  static int __init mdev_init(void)
>  {
>  	return mdev_bus_register();
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index 379758c52b1b..bfb7b22a7cb6 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -34,6 +34,7 @@ struct mdev_device {
>  	struct list_head next;
>  	struct kobject *type_kobj;
>  	bool active;
> +	struct device *iommu_device;
>  };
>  
>  #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index d7aee90e5da5..df2ea39f47ee 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -15,6 +15,20 @@
>  
>  struct mdev_device;
>  
> +/*
> + * Called by the parent device driver to set the device which represents
> + * this mdev in iommu protection scope. By default, the iommu device is
> + * NULL, that indicates using vendor defined isolation.
> + *
> + * @dev: the mediated device that iommu will isolate.
> + * @iommu_device: a pci device which represents the iommu for @dev.
> + *
> + * Return 0 for success, otherwise negative error value.
> + */
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
> +
> +struct device *mdev_get_iommu_device(struct device *dev);
> +
>  /**
>   * struct mdev_parent_ops - Structure to be registered for each parent device to
>   * register the device to mdev module.
> 

Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti
