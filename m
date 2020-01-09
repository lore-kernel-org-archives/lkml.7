Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418B1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15629206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578579371;
	bh=KQ9qbQtsoYGPMZdXi3hjrhuI0cSPD0xhAqRsLeBwpYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p1bVBn0MroRWb6bXKD8yNJRkbD9IoUkV5i6e5QJtPVgUGi5gHHJ4HcQULVq+3WojP
	 p0ZunEBYoMHR4fCEuwgJtGwFKLrmGSuOti49047orwuST7yVSySJGJsddmKza3HeRs
	 bOfVJOO1bNuSGr9+kJ5FRdyGxeTxEh3/lpw8yV8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgAIOQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgAIOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:16:10 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E417F2067D;
        Thu,  9 Jan 2020 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578579369;
        bh=KQ9qbQtsoYGPMZdXi3hjrhuI0cSPD0xhAqRsLeBwpYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb0Oe0gQ9b6CX8A3gAR3Ok2ZegM9K9eb4asZOuoXX5z6sDC15mICSWodGJyVkTgPu
         16iDpMhmNEbRHE/NSRNBBtqnQtawQUxyT7lui3Z4Ipp4w39HhsCMvhxeUaGtjqPKi5
         u05OlGw2rUb6OWLon9rdEygdpEIMl+hTawNs7IfA=
Date:   Thu, 9 Jan 2020 14:16:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20200109141602.GA12236@willie-the-truck>
References: <20191219120352.382-1-will@kernel.org>
 <20191219120352.382-6-will@kernel.org>
 <20191219144437.GA1959534@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219144437.GA1959534@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 19, 2019 at 03:44:37PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 19, 2019 at 12:03:41PM +0000, Will Deacon wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index f2223cbb5fd5..e9f94d3f7a04 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -246,9 +246,10 @@ struct iommu_iotlb_gather {
> >   * @sva_get_pasid: Get PASID associated to a SVA handle
> >   * @page_response: handle page request response
> >   * @cache_invalidate: invalidate translation caches
> > - * @pgsize_bitmap: bitmap of all possible supported page sizes
> >   * @sva_bind_gpasid: bind guest pasid and mm
> >   * @sva_unbind_gpasid: unbind guest pasid and mm
> > + * @pgsize_bitmap: bitmap of all possible supported page sizes
> > + * @owner: Driver module providing these ops
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -318,6 +319,7 @@ struct iommu_ops {
> >  	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> >  
> >  	unsigned long pgsize_bitmap;
> > +	struct module *owner;
> 
> Everyone is always going to forget to set this field.  I don't think you
> even set it for all of the different iommu_ops possible in this series,
> right?

I only initialised the field for those drivers which can actually be built
as a module, but I take your point about this being error-prone.

> The "trick" we did to keep people from having to remember this is to do
> what we did for the bus registering functions.
> 
> Look at pci_register_driver in pci.h:
> #define pci_register_driver(driver)             \
>         __pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> 
> Then we set the .owner field in the "real" __pci_register_driver() call.
> 
> Same thing for USB and lots, if not all, other driver register
> functions.
> 
> You can do the same thing here, and I would recommend it.

Yes, that makes sense, cheers. Diff below. I'll send it to Joerg along
with some other SMMU patches that have come in since the holiday.

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 03dc97842875..e82997a705a8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2733,7 +2733,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
-	.owner			= THIS_MODULE,
 };
 
 /* Probing and initialisation functions */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5ef1f2e100d7..93d332423f6f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1623,7 +1623,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
-	.owner			= THIS_MODULE,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e9f94d3f7a04..90007c92ad2d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -388,12 +388,19 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu);
 int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
 
-static inline void iommu_device_set_ops(struct iommu_device *iommu,
-					const struct iommu_ops *ops)
+static inline void __iommu_device_set_ops(struct iommu_device *iommu,
+					  const struct iommu_ops *ops)
 {
 	iommu->ops = ops;
 }
 
+#define iommu_device_set_ops(iommu, ops)				\
+do {									\
+	struct iommu_ops *__ops = (struct iommu_ops *)(ops);		\
+	__ops->owner = THIS_MODULE;					\
+	__iommu_device_set_ops(iommu, __ops);				\
+} while (0)
+
 static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
 					   struct fwnode_handle *fwnode)
 {
