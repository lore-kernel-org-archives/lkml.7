Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1892E2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578594101;
	bh=+sBgitQL3mchSzP4Zk7erYJ9ZJ5ThhSnczn5fnQvSkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m+rWCSe8p1PQGVd6CV6EyGFTIacrrrxoe2IEM0w5kWWF2mpMzRzm1eYImSNOUVhwC
	 wrBs+NV4MFqlVkBGA84Idtf6myt/a+8gounMOyJx8BC5rv6gtFN8DIbutEP+7K+xZF
	 RKymmSdC5H4An9almf47OPf9gXuSlpbDAFLa/Geg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgAISVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgAISVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:21:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655DE2072A;
        Thu,  9 Jan 2020 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578594097;
        bh=+sBgitQL3mchSzP4Zk7erYJ9ZJ5ThhSnczn5fnQvSkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFHa0o+FuNFrYUBweK+4sytw7pvbDe8ilh4PEgH8e0aoeuk84pqZuF/CKpz2edZfr
         mupIUv4nVDn+sooFYGrIG/xXBlmXBR/gSAwEfF3UM2dntd9XVzj1yYk+Rjei2nobkJ
         gkdIy7JMsz81pP7LvYZ/l5J6mi+KI3F5Jhv9VCpY=
Date:   Thu, 9 Jan 2020 19:17:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org,
        kernel-team@android.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 05/16] drivers/iommu: Take a ref to the IOMMU driver
 prior to ->add_device()
Message-ID: <20200109181758.GD589933@kroah.com>
References: <20191219120352.382-1-will@kernel.org>
 <20191219120352.382-6-will@kernel.org>
 <20191219144437.GA1959534@kroah.com>
 <20200109141602.GA12236@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109141602.GA12236@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:16:03PM +0000, Will Deacon wrote:
> Hi Greg,
> 
> On Thu, Dec 19, 2019 at 03:44:37PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 19, 2019 at 12:03:41PM +0000, Will Deacon wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index f2223cbb5fd5..e9f94d3f7a04 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -246,9 +246,10 @@ struct iommu_iotlb_gather {
> > >   * @sva_get_pasid: Get PASID associated to a SVA handle
> > >   * @page_response: handle page request response
> > >   * @cache_invalidate: invalidate translation caches
> > > - * @pgsize_bitmap: bitmap of all possible supported page sizes
> > >   * @sva_bind_gpasid: bind guest pasid and mm
> > >   * @sva_unbind_gpasid: unbind guest pasid and mm
> > > + * @pgsize_bitmap: bitmap of all possible supported page sizes
> > > + * @owner: Driver module providing these ops
> > >   */
> > >  struct iommu_ops {
> > >  	bool (*capable)(enum iommu_cap);
> > > @@ -318,6 +319,7 @@ struct iommu_ops {
> > >  	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> > >  
> > >  	unsigned long pgsize_bitmap;
> > > +	struct module *owner;
> > 
> > Everyone is always going to forget to set this field.  I don't think you
> > even set it for all of the different iommu_ops possible in this series,
> > right?
> 
> I only initialised the field for those drivers which can actually be built
> as a module, but I take your point about this being error-prone.
> 
> > The "trick" we did to keep people from having to remember this is to do
> > what we did for the bus registering functions.
> > 
> > Look at pci_register_driver in pci.h:
> > #define pci_register_driver(driver)             \
> >         __pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> > 
> > Then we set the .owner field in the "real" __pci_register_driver() call.
> > 
> > Same thing for USB and lots, if not all, other driver register
> > functions.
> > 
> > You can do the same thing here, and I would recommend it.
> 
> Yes, that makes sense, cheers. Diff below. I'll send it to Joerg along
> with some other SMMU patches that have come in since the holiday.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 03dc97842875..e82997a705a8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2733,7 +2733,6 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> -	.owner			= THIS_MODULE,
>  };
>  
>  /* Probing and initialisation functions */
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5ef1f2e100d7..93d332423f6f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1623,7 +1623,6 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> -	.owner			= THIS_MODULE,
>  };
>  
>  static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e9f94d3f7a04..90007c92ad2d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -388,12 +388,19 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu);
>  int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
>  void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
>  
> -static inline void iommu_device_set_ops(struct iommu_device *iommu,
> -					const struct iommu_ops *ops)
> +static inline void __iommu_device_set_ops(struct iommu_device *iommu,
> +					  const struct iommu_ops *ops)
>  {
>  	iommu->ops = ops;
>  }
>  
> +#define iommu_device_set_ops(iommu, ops)				\
> +do {									\
> +	struct iommu_ops *__ops = (struct iommu_ops *)(ops);		\
> +	__ops->owner = THIS_MODULE;					\
> +	__iommu_device_set_ops(iommu, __ops);				\
> +} while (0)
> +
>  static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
>  					   struct fwnode_handle *fwnode)
>  {

Looks good:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
