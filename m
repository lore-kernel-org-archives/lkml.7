Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A56C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B5222EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKRWLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:11:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:39280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfKRWLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:11:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 14:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="200125139"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2019 14:11:48 -0800
Date:   Mon, 18 Nov 2019 14:16:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 07/10] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Message-ID: <20191118141623.2cdf403b@jacob-builder>
In-Reply-To: <14e130e8-abcb-534f-655f-25488ad3500b@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-8-git-send-email-jacob.jun.pan@linux.intel.com>
        <14e130e8-abcb-534f-655f-25488ad3500b@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 22:11:52 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 11/18/19 8:42 PM, Jacob Pan wrote:
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > IOASID allocator is inclusive for both start and end of the
> > allocation range. The current code is based on IDR, which is
> > exclusive for the end of the allocation range. This patch fixes the
> > off-by-one error in intel_svm_bind_mm, where pasid_max - 1 is used
> > for the end of allocation range.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/Kconfig       |  1 +
> >  drivers/iommu/intel-iommu.c | 13 +++++++------
> >  drivers/iommu/intel-pasid.c | 36
> > ------------------------------------ drivers/iommu/intel-svm.c   |
> > 41 +++++++++++++++++++++++++++-------------- 4 files changed, 35
> > insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index fd50ddffffbf..43ce450a40d3 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -212,6 +212,7 @@ config INTEL_IOMMU_SVM
> >  	depends on INTEL_IOMMU && X86
> >  	select PCI_PASID
> >  	select MMU_NOTIFIER
> > +	select IOASID
> >  	help
> >  	  Shared Virtual Memory (SVM) provides a facility for
> > devices to access DMA resources through process address space by
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index d598168e410d..a84f0caa33a0
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5238,7 +5238,7 @@ static void auxiliary_unlink_device(struct
> > dmar_domain *domain, domain->auxd_refcnt--;
> >  
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >  }
> >  
> >  static int aux_domain_add_dev(struct dmar_domain *domain,
> > @@ -5256,10 +5256,11 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, if (domain->default_pasid <= 0) {
> >  		int pasid;
> >  
> > -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> > -
> > pci_max_pasids(to_pci_dev(dev)),
> > -					     GFP_KERNEL);
> > -		if (pasid <= 0) {
> > +		/* No private data needed for the default pasid */
> > +		pasid = ioasid_alloc(NULL, PASID_MIN,
> > +
> > pci_max_pasids(to_pci_dev(dev)) - 1,
> > +				     NULL);
> > +		if (pasid == INVALID_IOASID) {
> >  			pr_err("Can't allocate default pasid\n");
> >  			return -ENODEV;
> >  		}
> > @@ -5295,7 +5296,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, spin_unlock(&iommu->lock);
> >  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 732bfee228df..3cb569e76642
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -26,42 +26,6 @@
> >   */
> >  static DEFINE_SPINLOCK(pasid_lock);
> >  u32 intel_pasid_max_id = PASID_MAX;
> > -static DEFINE_IDR(pasid_idr);
> > -
> > -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> > -{
> > -	int ret, min, max;
> > -
> > -	min = max_t(int, start, PASID_MIN);
> > -	max = min_t(int, end, intel_pasid_max_id);
> > -
> > -	WARN_ON(in_interrupt());
> > -	idr_preload(gfp);
> > -	spin_lock(&pasid_lock);
> > -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> > -	spin_unlock(&pasid_lock);
> > -	idr_preload_end();
> > -
> > -	return ret;
> > -}
> > -
> > -void intel_pasid_free_id(int pasid)
> > -{
> > -	spin_lock(&pasid_lock);
> > -	idr_remove(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -}
> > -
> > -void *intel_pasid_lookup_id(int pasid)
> > -{
> > -	void *p;
> > -
> > -	spin_lock(&pasid_lock);
> > -	p = idr_find(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -
> > -	return p;
> > -}
> >  
> >  /*
> >   * Per device pasid table management:
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index e90d0b914afe..26a2f57763ec 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/dmar.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/ioasid.h>
> >  #include <asm/page.h>
> >  
> >  #include "intel-pasid.h"
> > @@ -335,16 +336,15 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (pasid_max >
> > intel_pasid_max_id) pasid_max = intel_pasid_max_id;
> >  
> > -		/* Do not use PASID 0 in caching mode (virtualised
> > IOMMU) */
> > -		ret = intel_pasid_alloc_id(svm,
> > -					   !!cap_caching_mode(iommu->cap),
> > -					   pasid_max, GFP_KERNEL);
> > -		if (ret < 0) {
> > +		/* Do not use PASID 0, reserved for RID to PASID */
> > +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > +					  pasid_max - 1, svm);
> > +		if (svm->pasid == INVALID_IOASID) {
> >  			kfree(svm);
> >  			kfree(sdev);
> > +			ret = -ENOSPC;
> >  			goto out;
> >  		}
> > -		svm->pasid = ret;
> >  		svm->notifier.ops = &intel_mmuops;
> >  		svm->mm = mm;
> >  		svm->flags = flags;
> > @@ -354,7 +354,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (mm) {
> >  			ret =
> > mmu_notifier_register(&svm->notifier, mm); if (ret) {
> > -				intel_pasid_free_id(svm->pasid);
> > +				ioasid_free(svm->pasid);
> >  				kfree(svm);
> >  				kfree(sdev);
> >  				goto out;
> > @@ -370,7 +370,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (ret) {
> >  			if (mm)
> >  				mmu_notifier_unregister(&svm->notifier,
> > mm);
> > -			intel_pasid_free_id(svm->pasid);
> > +			ioasid_free(svm->pasid);
> >  			kfree(svm);
> >  			kfree(sdev);
> >  			goto out;
> > @@ -418,7 +418,15 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) if (!iommu)
> >  		goto out;
> >  
> > -	svm = intel_pasid_lookup_id(pasid);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (!svm)
> > +		goto out;
> > +
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> >  	if (!svm)
> >  		goto out;
> >  
> > @@ -440,7 +448,9 @@ int intel_svm_unbind_mm(struct device *dev, int
> > pasid) kfree_rcu(sdev, rcu);
> >  
> >  				if (list_empty(&svm->devs)) {
> > -
> > intel_pasid_free_id(svm->pasid);
> > +					/* Clear private data so
> > that free pass check */
> > +
> > ioasid_set_data(svm->pasid, NULL);  
> This still looks weird to me. clearing the private data before freeing
> is a requirement from the custom allocation, if I am not wrong, ie.
> not a requirement from the generic allocator. If confirmed, this
> should not be part of this patch but added later on?
> 
You are right, we don't need to clear private data for native bind_mm. I
got confused with the guest PASID bind.
The presence of the private data is used to indicate whether there is
an active guest bind.

One fundamental difference between native and guest bind is that native
bind includes IOASID allocation but guest bind has IOASID preallocated.
So guest bind/unbind is a two step process which I thought would be
done in order. But as Alex pointed out, we should not hold IOASID and
fail the free() call if caller didn't do an unbind.
https://lore.kernel.org/linux-iommu/20191113082940.1b415d00@x1.home/

I will remove this line.
> 
> > +					ioasid_free(svm->pasid);
> >  					if (svm->mm)
> >  						mmu_notifier_unregister(&svm->notifier,
> > svm->mm); 
> > @@ -475,10 +485,14 @@ int intel_svm_is_pasid_valid(struct device
> > *dev, int pasid) if (!iommu)
> >  		goto out;
> >  
> > -	svm = intel_pasid_lookup_id(pasid);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> >  	if (!svm)
> >  		goto out;
> >  
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> >  	/* init_mm is used in this case */
> >  	if (!svm->mm)
> >  		ret = 1;  
> not related to this patch but in prq_event_thread
> resp.qw0 and qw1 are not initialized in case (req->lpig ||
> req->priv_data_present) is not true
> 
resp is not used either in this case.

> > @@ -585,13 +599,12 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d) 
> >  		if (!svm || svm->pasid != req->pasid) {
> >  			rcu_read_lock();
> > -			svm = intel_pasid_lookup_id(req->pasid);
> > +			svm = ioasid_find(NULL, req->pasid, NULL);
> >  			/* It *can't* go away, because the driver
> > is not permitted
> >  			 * to unbind the mm while any page faults
> > are outstanding.
> >  			 * So we only need RCU to protect the
> > internal idr code. */ rcu_read_unlock();
> > -
> > -			if (!svm) {
> > +			if (IS_ERR_OR_NULL(svm)) {
> >  				pr_err("%s: Page request for
> > invalid PASID %d: %08llx %08llx\n", iommu->name, req->pasid,
> > ((unsigned long long *)req)[0], ((unsigned long long *)req)[1]);
> >   
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
