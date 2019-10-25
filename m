Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4842CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF421D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406836AbfJYHTb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:19:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:26868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfJYHTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:19:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="202535612"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2019 00:19:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 00:19:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Oct 2019 00:19:28 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Oct 2019 00:19:27 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX153.ccr.corp.intel.com ([10.239.6.53]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 15:19:26 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHViqRYHs7rkU/ej0S5OBwc0DBZHqdq78Jw
Date:   Fri, 25 Oct 2019 07:19:26 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDDA6@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGU4ZjI2Y2MtZDNiYy00MTJiLTk5NGYtZGE2MzU3OTBkMzk4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOVY2dWNvSWhMSTJUVHRyZjkxQlhIZzQxTkN6MkxjVjBkZGtcLzdFYVZzdmFsWXZZMklMU2tEblhhODBCYk5MMmMifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Friday, October 25, 2019 3:55 AM
> 
> When supporting guest SVA with emulated IOMMU, the guest PASID
> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> will result in PASID cache flush which will be passed down to
> the host as bind guest PASID calls.

will be translated into binding/unbinding guest PASID calls to update
the host shadow PASID table.

> 
> For the SL page tables, it will be harvested from device's
> default domain (request w/o PASID), or aux domain in case of
> mediated device.

harvested -> copied or linked to?

> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |   4 +
>  drivers/iommu/intel-svm.c   | 184
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |   8 +-
>  include/linux/intel-svm.h   |  17 ++++
>  4 files changed, 212 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index acd1ac787d8b..5fab32fbc4b4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6026,6 +6026,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +#endif

again, pure PASID management logic should be separated from SVM.

>  };
> 
>  static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a18b02a9709d..ae13a310cf96 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -216,6 +216,190 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry(sdev, &svm->devs, list)	\
>  	if (dev == sdev->dev)				\
> 
> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +			struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct dmar_domain *ddomain;
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = 0;
> +
> +	if (WARN_ON(!iommu) || !data)
> +		return -EINVAL;
> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> +		data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	}

what about non-pci devices? It just moves forward w/o any check here?

> +
> +	/*
> +	 * We only check host PASID range, we have no knowledge to check
> +	 * guest PASID range nor do we use the guest PASID.
> +	 */
> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> +		return -EINVAL;
> +
> +	ddomain = to_dmar_domain(domain);
> +	/* REVISIT:
> +	 * Sanity check adddress width and paging mode support
> +	 * width matching in two dimensions:
> +	 * 1. paging mode CPU <= IOMMU
> +	 * 2. address width Guest <= Host.
> +	 */

Is lacking of above logic harmful? If not, we should add

> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, data->hpasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +	if (svm) {
> +		/*
> +		 * If we found svm for the PASID, there must be at
> +		 * least one device bond, otherwise svm should be freed.
> +		 */
> +		BUG_ON(list_empty(&svm->devs));
> +
> +		for_each_svm_dev(svm, dev) {
> +			/* In case of multiple sub-devices of the same pdev
> assigned, we should
> +			 * allow multiple bind calls with the same PASID and
> pdev.
> +			 */
> +			sdev->users++;
> +			goto out;

sorry if I overlooked, but I didn't see any check on the PASID 
actually belonging to this process. At least should check the
match between svm->mm and get_task_mm? also check
whether a previous binding between this hpasid and gpasid
already exists.

> +		}
> +	} else {
> +		/* We come here when PASID has never been bond to a
> device. */
> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> +		if (!svm) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		/* REVISIT: upper layer/VFIO can track host process that
> bind the PASID.
> +		 * ioasid_set = mm might be sufficient for vfio to check
> pasid VMM
> +		 * ownership.
> +		 */

Is it correct to leave the check to the caller?

> +		svm->mm = get_task_mm(current);
> +		svm->pasid = data->hpasid;
> +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> +			svm->gpasid = data->gpasid;
> +			svm->flags |= SVM_FLAG_GUEST_PASID;
> +		}
> +		ioasid_set_data(data->hpasid, svm);
> +		INIT_LIST_HEAD_RCU(&svm->devs);
> +		INIT_LIST_HEAD(&svm->list);
> +
> +		mmput(svm->mm);
> +	}
> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev) {
> +		if (list_empty(&svm->devs))
> +			kfree(svm);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	sdev->dev = dev;
> +	sdev->users = 1;
> +
> +	/* Set up device context entry for PASID if not enabled already */
> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable PASID capability\n");
> +		kfree(sdev);
> +		goto out;
> +	}
> +
> +	/*
> +	 * For guest bind, we need to set up PASID table entry as follows:
> +	 * - FLPM matches guest paging mode
> +	 * - turn on nested mode
> +	 * - SL guest address width matching
> +	 */
> +	ret = intel_pasid_setup_nested(iommu,
> +				dev,
> +				(pgd_t *)data->gpgd,
> +				data->hpasid,
> +				&data->vtd,
> +				ddomain,
> +				data->addr_width);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up PASID %llu in nested mode,
> Err %d\n",
> +			data->hpasid, ret);
> +		kfree(sdev);

disable pasid? revert ioasid_set_data?

> +		goto out;
> +	}
> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> +
> +	init_rcu_head(&sdev->rcu);
> +	list_add_rcu(&sdev->list, &svm->devs);
> + out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> +
> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +{
> +	struct intel_svm_dev *sdev;
> +	struct intel_iommu *iommu;
> +	struct intel_svm *svm;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&pasid_mutex);
> +	iommu = intel_svm_device_to_iommu(dev);
> +	if (!iommu)
> +		goto out;
> +
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR_OR_NULL(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	for_each_svm_dev(svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			/* TODO: Drain in flight PRQ for the PASID since it
> +			 * may get reused soon, we don't want to
> +			 * confuse with its previous life.
> +			 * intel_svm_drain_prq(dev, pasid);
> +			 */
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				list_del(&svm->list);
> +				kfree(svm);
> +				/*
> +				 * We do not free PASID here until explicit
> call
> +				 * from VFIO to free. The PASID life cycle
> +				 * management is largely tied to VFIO
> management
> +				 * of assigned device life cycles. In case of
> +				 * guest exit without a explicit free PASID call,
> +				 * the responsibility lies in VFIO layer to free
> +				 * the PASIDs allocated for the guest.
> +				 * For security reasons, VFIO has to track the
> +				 * PASID ownership per guest anyway to
> ensure
> +				 * that PASID allocated by one guest cannot
> be
> +				 * used by another.
> +				 */
> +				ioasid_set_data(pasid, NULL);
> +			}
> +		}
> +		break;
> +	}
> + out:
> +	mutex_unlock(&pasid_mutex);
> +
> +	return ret;
> +}
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct
> svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3dba6ad3e9ad..6c74c71b1ebf 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -673,7 +673,9 @@ int intel_iommu_enable_pasid(struct intel_iommu
> *iommu, struct device *dev);
>  int intel_svm_init(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -
> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_gpasid_bind_data *data);
> +extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>  struct svm_dev_ops;
> 
>  struct intel_svm_dev {
> @@ -690,9 +692,13 @@ struct intel_svm_dev {
>  struct intel_svm {
>  	struct mmu_notifier notifier;
>  	struct mm_struct *mm;
> +
>  	struct intel_iommu *iommu;
>  	int flags;
>  	int pasid;
> +	int gpasid; /* Guest PASID in case of vSVA bind with non-identity
> host
> +		     * to guest PASID mapping.
> +		     */
>  	struct list_head devs;
>  	struct list_head list;
>  };
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index 94f047a8a845..a2c189ad0b01 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -44,6 +44,23 @@ struct svm_dev_ops {
>   * do such IOTLB flushes automatically.
>   */
>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> +/*
> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to
> a device.
> + * In this case the mm_struct is in the guest kernel or userspace, its life
> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API
> provides
> + * means to bind/unbind guest CR3 with PASIDs allocated for a device.
> + */
> +#define SVM_FLAG_GUEST_MODE	(1<<2)
> +/*
> + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own
> PASID space,
> + * which requires guest and host PASID translation at both directions. We
> keep
> + * track of guest PASID in order to provide lookup service to device drivers.
> + * One such example is a physical function (PF) driver that supports
> mediated
> + * device (mdev) assignment. Guest programming of mdev configuration
> space can
> + * only be done with guest PASID, therefore PF driver needs to find the
> matching
> + * host PASID to program the real hardware.
> + */
> +#define SVM_FLAG_GUEST_PASID	(1<<3)
> 
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> 
> --
> 2.7.4

