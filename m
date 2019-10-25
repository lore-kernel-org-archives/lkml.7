Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8CCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D942070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405204AbfJYGlW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:41:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:29563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405128AbfJYGlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:41:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 23:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="398673106"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2019 23:41:19 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 23:41:18 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 23:41:18 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.96]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 14:41:16 +0800
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
Subject: RE: [PATCH v7 04/11] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Thread-Topic: [PATCH v7 04/11] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Thread-Index: AQHViqRWjgaUKTwITk+Avf8FnVg6vadq6PDA
Date:   Fri, 25 Oct 2019 06:41:16 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC87@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-5-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1571946904-86776-5-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGM2NDVkZDAtN2JiYy00Y2Q0LTk5MzQtM2I4MWU3MmVlYzRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiY1lhR0RRMWIwQ3FYaHRsV1R0MUlcL2FXbWR3QjJ5Q1Z2SU9lenZ0amxnMnlpYUFRWktBRkV6WDVTUHlqK3c5VzYifQ==
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
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

better push this patch separately. It's a generic cleanup.

> ---
>  drivers/iommu/intel-iommu.c | 12 ++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 39 +++++++++++++++++++++++----------------
>  3 files changed, 29 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ced1d89ef977..2ea09b988a23 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5311,7 +5311,7 @@ static void auxiliary_unlink_device(struct
> dmar_domain *domain,
>  	domain->auxd_refcnt--;
> 
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  }
> 
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5329,10 +5329,10 @@ static int aux_domain_add_dev(struct
> dmar_domain *domain,
>  	if (domain->default_pasid <= 0) {
>  		int pasid;
> 
> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> -					     pci_max_pasids(to_pci_dev(dev)),
> -					     GFP_KERNEL);
> -		if (pasid <= 0) {
> +		/* No private data needed for the default pasid */
> +		pasid = ioasid_alloc(NULL, PASID_MIN,
> pci_max_pasids(to_pci_dev(dev)) - 1,
> +				NULL);
> +		if (pasid == INVALID_IOASID) {
>  			pr_err("Can't allocate default pasid\n");
>  			return -ENODEV;
>  		}
> @@ -5368,7 +5368,7 @@ static int aux_domain_add_dev(struct
> dmar_domain *domain,
>  	spin_unlock(&iommu->lock);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
> 
>  	return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index d81e857d2b25..e79d680fe300 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -26,42 +26,6 @@
>   */
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id = PASID_MAX;
> -static DEFINE_IDR(pasid_idr);
> -
> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> -{
> -	int ret, min, max;
> -
> -	min = max_t(int, start, PASID_MIN);
> -	max = min_t(int, end, intel_pasid_max_id);
> -
> -	WARN_ON(in_interrupt());
> -	idr_preload(gfp);
> -	spin_lock(&pasid_lock);
> -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> -	spin_unlock(&pasid_lock);
> -	idr_preload_end();
> -
> -	return ret;
> -}
> -
> -void intel_pasid_free_id(int pasid)
> -{
> -	spin_lock(&pasid_lock);
> -	idr_remove(&pasid_idr, pasid);
> -	spin_unlock(&pasid_lock);
> -}
> -
> -void *intel_pasid_lookup_id(int pasid)
> -{
> -	void *p;
> -
> -	spin_lock(&pasid_lock);
> -	p = idr_find(&pasid_idr, pasid);
> -	spin_unlock(&pasid_lock);
> -
> -	return p;
> -}
> 
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
>  {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9b159132405d..a9a7f85a09bc 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -17,6 +17,7 @@
>  #include <linux/dmar.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm_types.h>
> +#include <linux/ioasid.h>
>  #include <asm/page.h>
> 
>  #include "intel-pasid.h"
> @@ -318,16 +319,15 @@ int intel_svm_bind_mm(struct device *dev, int
> *pasid, int flags, struct svm_dev_
>  		if (pasid_max > intel_pasid_max_id)
>  			pasid_max = intel_pasid_max_id;
> 
> -		/* Do not use PASID 0 in caching mode (virtualised IOMMU)
> */
> -		ret = intel_pasid_alloc_id(svm,
> -					   !!cap_caching_mode(iommu->cap),
> -					   pasid_max - 1, GFP_KERNEL);
> -		if (ret < 0) {
> +		/* Do not use PASID 0, reserved for RID to PASID */
> +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> +					pasid_max - 1, svm);
> +		if (svm->pasid == INVALID_IOASID) {
>  			kfree(svm);
>  			kfree(sdev);
> +			ret = ENOSPC;
>  			goto out;
>  		}
> -		svm->pasid = ret;
>  		svm->notifier.ops = &intel_mmuops;
>  		svm->mm = mm;
>  		svm->flags = flags;
> @@ -337,7 +337,7 @@ int intel_svm_bind_mm(struct device *dev, int
> *pasid, int flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				intel_pasid_free_id(svm->pasid);
> +				ioasid_free(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int
> *pasid, int flags, struct svm_dev_
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier,
> mm);
> -			intel_pasid_free_id(svm->pasid);
> +			ioasid_free(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);
>  			goto out;
> @@ -401,7 +401,12 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  	if (!iommu)
>  		goto out;
> 
> -	svm = intel_pasid_lookup_id(pasid);
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
>  	if (!svm)
>  		goto out;
> 
> @@ -423,7 +428,9 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  				kfree_rcu(sdev, rcu);
> 
>  				if (list_empty(&svm->devs)) {
> -					intel_pasid_free_id(svm->pasid);
> +					/* Clear private data so that free
> pass check */
> +					ioasid_set_data(svm->pasid, NULL);
> +					ioasid_free(svm->pasid);
>  					if (svm->mm)
> 
> 	mmu_notifier_unregister(&svm->notifier, svm->mm);
> 
> @@ -458,10 +465,11 @@ int intel_svm_is_pasid_valid(struct device *dev,
> int pasid)
>  	if (!iommu)
>  		goto out;
> 
> -	svm = intel_pasid_lookup_id(pasid);
> -	if (!svm)
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
>  		goto out;
> -
> +	}
>  	/* init_mm is used in this case */
>  	if (!svm->mm)
>  		ret = 1;
> @@ -568,13 +576,12 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> 
>  		if (!svm || svm->pasid != req->pasid) {
>  			rcu_read_lock();
> -			svm = intel_pasid_lookup_id(req->pasid);
> +			svm = ioasid_find(NULL, req->pasid, NULL);
>  			/* It *can't* go away, because the driver is not
> permitted
>  			 * to unbind the mm while any page faults are
> outstanding.
>  			 * So we only need RCU to protect the internal idr
> code. */
>  			rcu_read_unlock();
> -
> -			if (!svm) {
> +			if (IS_ERR(svm) || !svm) {
>  				pr_err("%s: Page request for invalid
> PASID %d: %08llx %08llx\n",
>  				       iommu->name, req->pasid, ((unsigned
> long long *)req)[0],
>  				       ((unsigned long long *)req)[1]);
> --
> 2.7.4

