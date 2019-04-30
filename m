Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF61C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfD3RrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:47:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:21818 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:47:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 10:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="138781891"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2019 10:47:00 -0700
Date:   Tue, 30 Apr 2019 10:49:46 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 15/19] iommu/vt-d: Add bind guest PASID support
Message-ID: <20190430104946.02da45c0@jacob-builder>
In-Reply-To: <0af838f6-3830-9538-2cb9-a0dc26b24768@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <66758de4-2b76-7380-3636-7da1c0a6dc65@redhat.com>
        <20190429082550.76f3f736@jacob-builder>
        <0af838f6-3830-9538-2cb9-a0dc26b24768@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 09:05:01 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> On 4/29/19 5:25 PM, Jacob Pan wrote:
> > On Fri, 26 Apr 2019 18:15:27 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 4/24/19 1:31 AM, Jacob Pan wrote:  
> >>> When supporting guest SVA with emulated IOMMU, the guest PASID
> >>> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> >>> will result in PASID cache flush which will be passed down to
> >>> the host as bind guest PASID calls.
> >>>
> >>> For the SL page tables, it will be harvested from device's
> >>> default domain (request w/o PASID), or aux domain in case of
> >>> mediated device.
> >>>
> >>>     .-------------.  .---------------------------.
> >>>     |   vIOMMU    |  | Guest process CR3, FL only|
> >>>     |             |  '---------------------------'
> >>>     .----------------/
> >>>     | PASID Entry |--- PASID cache flush -
> >>>     '-------------'                       |
> >>>     |             |                       V
> >>>     |             |                CR3 in GPA
> >>>     '-------------'
> >>> Guest
> >>> ------| Shadow |--------------------------|--------
> >>>       v        v                          v
> >>> Host
> >>>     .-------------.  .----------------------.
> >>>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >>>     |             |  '----------------------'
> >>>     .----------------/  |
> >>>     | PASID Entry |     V (Nested xlate)
> >>>     '----------------\.------------------------------.
> >>>     |             |   |SL for GPA-HPA, default domain|
> >>>     |             |   '------------------------------'
> >>>     '-------------'
> >>> Where:
> >>>  - FL = First level/stage one page tables
> >>>  - SL = Second level/stage two page tables
> >>>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/intel-iommu.c |   4 +
> >>>  drivers/iommu/intel-svm.c   | 174
> >>> ++++++++++++++++++++++++++++++++++++++++++++
> >>> include/linux/intel-iommu.h |  10 ++- include/linux/intel-svm.h
> >>> |   7 ++ 4 files changed, 193 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/intel-iommu.c
> >>> b/drivers/iommu/intel-iommu.c index 77bbe1b..89989b5 100644
> >>> --- a/drivers/iommu/intel-iommu.c
> >>> +++ b/drivers/iommu/intel-iommu.c
> >>> @@ -5768,6 +5768,10 @@ const struct iommu_ops intel_iommu_ops = {
> >>>  	.dev_enable_feat	= intel_iommu_dev_enable_feat,
> >>>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> >>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> >>> +#ifdef CONFIG_INTEL_IOMMU_SVM
> >>> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> >>> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> >>> +#endif
> >>>  };
> >>>  
> >>>  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
> >>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> >>> index 8fff212..0a973c2 100644
> >>> --- a/drivers/iommu/intel-svm.c
> >>> +++ b/drivers/iommu/intel-svm.c
> >>> @@ -227,6 +227,180 @@ static const struct mmu_notifier_ops
> >>> intel_mmuops = { 
> >>>  static DEFINE_MUTEX(pasid_mutex);
> >>>  static LIST_HEAD(global_svm_list);
> >>> +#define for_each_svm_dev() \
> >>> +	list_for_each_entry(sdev, &svm->devs, list)	\
> >>> +	if (dev == sdev->dev)				\
> >>> +
> >>> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> >>> +			struct device *dev,
> >>> +			struct gpasid_bind_data *data)
> >>> +{
> >>> +	struct intel_iommu *iommu =
> >>> intel_svm_device_to_iommu(dev);
> >>> +	struct intel_svm_dev *sdev;
> >>> +	struct intel_svm *svm = NULL;
> >>> +	struct dmar_domain *ddomain;
> >>> +	int pasid_max;
> >>> +	int ret = 0;
> >>> +
> >>> +	if (WARN_ON(!iommu) || !data)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (dev_is_pci(dev)) {
> >>> +		pasid_max = pci_max_pasids(to_pci_dev(dev));
> >>> +		if (pasid_max < 0)
> >>> +			return -EINVAL;
> >>> +	} else
> >>> +		pasid_max = 1 << 20;
> >>> +
> >>> +	if (data->pasid <= 0 || data->pasid >= pasid_max)
> >>> +		return -EINVAL;
> >>> +
> >>> +	ddomain = to_dmar_domain(domain);
> >>> +	/* REVISIT:
> >>> +	 * Sanity check adddress width and paging mode support
> >>> +	 * width matching in two dimensions:
> >>> +	 * 1. paging mode CPU <= IOMMU
> >>> +	 * 2. address width Guest <= Host.
> >>> +	 */
> >>> +	mutex_lock(&pasid_mutex);
> >>> +	svm = ioasid_find(NULL, data->pasid, NULL);
> >>> +	if (IS_ERR(svm)) {
> >>> +		ret = PTR_ERR(svm);
> >>> +		goto out;
> >>> +	}
> >>> +	if (svm) {
> >>> +		if (list_empty(&svm->devs)) {
> >>> +			dev_err(dev, "GPASID %d has no devices
> >>> bond but SVA is allocated\n",
> >>> +				data->pasid);
> >>> +			ret = -ENODEV; /*
> >>> +					* If we found svm for the
> >>> PASID, there must be at
> >>> +					* least one device bond,
> >>> otherwise svm should be freed.
> >>> +					*/    
> >> comment should be put after list_empty I think. In which
> >> circumstances can it happen, I mean, isn't it a BUG_ON case?  
> > Well, I think failing to bind guest PASID is not severe enough to
> > the host to use BUG_ON. It has to be something more catastrophic to
> > use BUG_ON right? I will relocate the comments.  
> When the error is due to a programming error at kernel error (not
> induced by any userspace call) I guess it is acceptable to put a
> BUG_ON. However the usage of BUG_ON() is generally frown upon so my
> question rather was to understand if this can really happen and why?
Indeed this should never happen unless some future programming error. I
guess I can add a BUG_ON() or ignore the check.
> >>> +			goto out;
> >>> +		}
> >>> +		for_each_svm_dev() {
> >>> +			/* In case of multiple sub-devices of the
> >>> same pdev assigned, we should
> >>> +			 * allow multiple bind calls with the
> >>> same PASID and pdev.
> >>> +			 */
> >>> +			sdev->users++;
> >>> +			goto out;
> >>> +		}
> >>> +	} else {
> >>> +		/* We come here when PASID has never been bond to
> >>> a device. */
> >>> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> >>> +		if (!svm) {
> >>> +			ret = -ENOMEM;
> >>> +			goto out;
> >>> +		}
> >>> +		/* REVISIT: upper layer/VFIO can track host
> >>> process that bind the PASID.
> >>> +		 * ioasid_set = mm might be sufficient for vfio
> >>> to check pasid VMM
> >>> +		 * ownership.
> >>> +		 */
> >>> +		svm->mm = get_task_mm(current);
> >>> +		svm->pasid = data->pasid;
> >>> +		refcount_set(&svm->refs, 0);
> >>> +		ioasid_set_data(data->pasid, svm);
> >>> +		INIT_LIST_HEAD_RCU(&svm->devs);
> >>> +		INIT_LIST_HEAD(&svm->list);
> >>> +
> >>> +		mmput(svm->mm);
> >>> +	}
> >>> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> >>> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> >>> +	if (!sdev) {
> >>> +		ret = -ENOMEM;    
> >> in case of failure what is the state of svm (you added the
> >> SVM_FLAG_GUEST_MODE bit typically, is it safe to leave it?)  
> > The SVM_FLAG_GUEST_MODE flag is used for fault reporting where
> > faults such as PRQ need to be injected into the guest. If this
> > kzalloc() fails, the nested translation would not be setup for this
> > PASID. So there shouldn't be any user of the flag. But I think it
> > is better to move svm->flags |= SVM_FLAG_GUEST_MODE; to the end
> > when everything is setup for nesting.  
> ok
> >   
> >>> +		goto out;
> >>> +	}
> >>> +	sdev->dev = dev;
> >>> +	sdev->users = 1;
> >>> +
> >>> +	/* Set up device context entry for PASID if not enabled
> >>> already */
> >>> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "Failed to enable PASID
> >>> capability\n");
> >>> +		kfree(sdev);    
> >> same here  
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * For guest bind, we need to set up PASID table entry as
> >>> follows:
> >>> +	 * - FLPM matches guest paging mode
> >>> +	 * - turn on nested mode
> >>> +	 * - SL guest address width matching
> >>> +	 */
> >>> +	ret = intel_pasid_setup_nested(iommu,
> >>> +				dev,
> >>> +				(pgd_t *)data->gcr3,
> >>> +				data->pasid,
> >>> +				data->flags,
> >>> +				ddomain,
> >>> +				data->addr_width);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "Failed to set up PASID %d in nested
> >>> mode, Err %d\n",
> >>> +			data->pasid, ret);
> >>> +		kfree(sdev);
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	init_rcu_head(&sdev->rcu);
> >>> +	refcount_inc(&svm->refs);
> >>> +	list_add_rcu(&sdev->list, &svm->devs);
> >>> + out:
> >>> +	mutex_unlock(&pasid_mutex);
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> >>> +{
> >>> +	struct intel_svm_dev *sdev;
> >>> +	struct intel_iommu *iommu;
> >>> +	struct intel_svm *svm;
> >>> +	int ret = -EINVAL;
> >>> +
> >>> +	mutex_lock(&pasid_mutex);
> >>> +	iommu = intel_svm_device_to_iommu(dev);
> >>> +	if (!iommu)
> >>> +		goto out;
> >>> +
> >>> +	svm = ioasid_find(NULL, pasid, NULL);
> >>> +	if (IS_ERR(svm)) {
> >>> +		ret = PTR_ERR(svm);
> >>> +		goto out;
> >>> +	}
> >>> +
> >>> +	if (!svm)
> >>> +		goto out;
> >>> +
> >>> +	for_each_svm_dev() {
> >>> +		ret = 0;
> >>> +		sdev->users--;
> >>> +		if (!sdev->users) {
> >>> +			list_del_rcu(&sdev->list);
> >>> +			intel_pasid_tear_down_entry(iommu, dev,
> >>> svm->pasid);
> >>> +			/* TODO: Drain in flight PRQ for the
> >>> PASID since it
> >>> +			 * may get reused soon, we don't want to
> >>> +			 * confuse with its previous live.
> >>> +			 * intel_svm_drain_prq(dev, pasid);
> >>> +			 */
> >>> +			kfree_rcu(sdev, rcu);
> >>> +
> >>> +			if (list_empty(&svm->devs)) {
> >>> +				list_del(&svm->list);
> >>> +				kfree(svm);
> >>> +				/*
> >>> +				 * We do not free PASID here
> >>> until explicit call
> >>> +				 * from the guest to free.    
> >> can you be confident in the guest?  
> > No. But I have confident in the kernel VFIO code to manage guest
> > life cycle :)
> > I assume when a guest doesn't do unbind when it dies or unload a
> > assigned device, I expect VFIO to free all the PASIDs. VFIO needs to
> > police the PASID ownership anyway in order to make sure a PASID
> > assigned to guest A cannot be used to bind from guest B.
> > This is the flow I worked out with Yi, who is doing the VFIO part.
> > Any particular concerns?  
> No I just wanted to make sure someone is going to take care of the
> final tear down even if the userspace fails to do things as expected.
> Maybe adding a comment to explain who has the ownership of the final
> tear down would help here.
> 
I will add comments as follows:
/*
 * We do not free PASID here until explicit call
 * from VFIO to free. The PASID life cycle
 * management is largely tied to VFIO management
 * of assigned device life cycles. In case of
 * guest exit without a explicit free PASID call,
 * the responsibility lies in VFIO layer to free
 * the PASIDs allocated for the guest.
 * For security reasons, VFIO has to track the
 * PASID ownership per guest anyway to ensure
 * that PASID allocated by one guest cannot be
 * used by another.
 */

> Thanks
> 
> Eric
> >   
> >>> +				 */
> >>> +				ioasid_set_data(pasid, NULL);
> >>> +			}
> >>> +		}
> >>> +		break;
> >>> +	}
> >>> + out:
> >>> +	mutex_unlock(&pasid_mutex);
> >>> +
> >>> +	return ret;
> >>> +}
> >>>  
> >>>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> >>> struct svm_dev_ops *ops) {
> >>> diff --git a/include/linux/intel-iommu.h
> >>> b/include/linux/intel-iommu.h index 48fa164..5d67d0d4 100644
> >>> --- a/include/linux/intel-iommu.h
> >>> +++ b/include/linux/intel-iommu.h
> >>> @@ -677,7 +677,9 @@ int intel_iommu_enable_pasid(struct
> >>> intel_iommu *iommu, struct device *dev); int
> >>> intel_svm_init(struct intel_iommu *iommu); extern int
> >>> intel_svm_enable_prq(struct intel_iommu *iommu); extern int
> >>> intel_svm_finish_prq(struct intel_iommu *iommu); -
> >>> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> >>> +		struct device *dev, struct gpasid_bind_data
> >>> *data); +extern int intel_svm_unbind_gpasid(struct device *dev,
> >>> int pasid); struct svm_dev_ops;
> >>>  
> >>>  struct intel_svm_dev {
> >>> @@ -693,12 +695,16 @@ struct intel_svm_dev {
> >>>  
> >>>  struct intel_svm {
> >>>  	struct mmu_notifier notifier;
> >>> -	struct mm_struct *mm;
> >>> +	union {
> >>> +		struct mm_struct *mm;
> >>> +		u64 gcr3;
> >>> +	};
> >>>  	struct intel_iommu *iommu;
> >>>  	int flags;
> >>>  	int pasid;
> >>>  	struct list_head devs;
> >>>  	struct list_head list;
> >>> +	refcount_t refs; /* # of devs bond to the PASID */    
> >> number of devices sharing the same PASID?  
> > more clear wording, thanks.  
> >>>  };
> >>>  
> >>>  extern struct intel_iommu *intel_svm_device_to_iommu(struct
> >>> device *dev); diff --git a/include/linux/intel-svm.h
> >>> b/include/linux/intel-svm.h index e3f7631..34b0a3b 100644
> >>> --- a/include/linux/intel-svm.h
> >>> +++ b/include/linux/intel-svm.h
> >>> @@ -52,6 +52,13 @@ struct svm_dev_ops {
> >>>   * do such IOTLB flushes automatically.
> >>>   */
> >>>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> >>> +/*
> >>> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind
> >>> to a device.    
> >> binds  
> > will fix
> >   
> >>> + * In this case the mm_struct is in the guest kernel or
> >>> userspace, its life
> >>> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this
> >>> API provides
> >>> + * means to bind/unbind guest CR3 with PASIDs allocated for a
> >>> device.
> >>> + */
> >>> +#define SVM_FLAG_GUEST_MODE	(1<<2)
> >>>  
> >>>  #ifdef CONFIG_INTEL_IOMMU_SVM
> >>>  
> >>>     
> >>
> >> Thanks
> >>
> >> Eric  
> > 
> > [Jacob Pan]
> >   

[Jacob Pan]
