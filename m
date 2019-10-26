Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6F20679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfJZBD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:03:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:19624 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfJZBD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:03:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 18:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="224087883"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 18:03:25 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 08/11] iommu/vt-d: Misc macro clean up for SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-9-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c07409eb-83e1-58eb-92d9-7e3c8208d5b7@linux.intel.com>
Date:   Sat, 26 Oct 2019 09:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 3:55 AM, Jacob Pan wrote:
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-svm.c | 89 ++++++++++++++++++++++-------------------------
>   1 file changed, 42 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a9a7f85a09bc..a18b02a9709d 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -212,6 +212,10 @@ static const struct mmu_notifier_ops intel_mmuops = {
>   static DEFINE_MUTEX(pasid_mutex);
>   static LIST_HEAD(global_svm_list);
>   
> +#define for_each_svm_dev(svm, dev)			\
> +	list_for_each_entry(sdev, &svm->devs, list)	\
> +	if (dev == sdev->dev)				\
> +
>   int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>   {
>   	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -257,15 +261,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>   				goto out;
>   			}
>   
> -			list_for_each_entry(sdev, &svm->devs, list) {
> -				if (dev == sdev->dev) {
> -					if (sdev->ops != ops) {
> -						ret = -EBUSY;
> -						goto out;
> -					}
> -					sdev->users++;
> -					goto success;
> +			for_each_svm_dev(svm, dev) {
> +				if (sdev->ops != ops) {
> +					ret = -EBUSY;
> +					goto out;
>   				}
> +				sdev->users++;
> +				goto success;
>   			}
>   
>   			break;
> @@ -402,50 +404,43 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>   		goto out;
>   
>   	svm = ioasid_find(NULL, pasid, NULL);
> -	if (IS_ERR(svm)) {
> +	if (IS_ERR_OR_NULL(svm)) {
>   		ret = PTR_ERR(svm);
>   		goto out;
>   	}
>   
> -	if (!svm)
> -		goto out;

If svm == NULL here, this function will return success. This isn't
expected, right?

Others looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> -
> -	list_for_each_entry(sdev, &svm->devs, list) {
> -		if (dev == sdev->dev) {
> -			ret = 0;
> -			sdev->users--;
> -			if (!sdev->users) {
> -				list_del_rcu(&sdev->list);
> -				/* Flush the PASID cache and IOTLB for this device.
> -				 * Note that we do depend on the hardware *not* using
> -				 * the PASID any more. Just as we depend on other
> -				 * devices never using PASIDs that they have no right
> -				 * to use. We have a *shared* PASID table, because it's
> -				 * large and has to be physically contiguous. So it's
> -				 * hard to be as defensive as we might like. */
> -				intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> -				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -				kfree_rcu(sdev, rcu);
> -
> -				if (list_empty(&svm->devs)) {
> -					/* Clear private data so that free pass check */
> -					ioasid_set_data(svm->pasid, NULL);
> -					ioasid_free(svm->pasid);
> -					if (svm->mm)
> -						mmu_notifier_unregister(&svm->notifier, svm->mm);
> -
> -					list_del(&svm->list);
> -
> -					/* We mandate that no page faults may be outstanding
> -					 * for the PASID when intel_svm_unbind_mm() is called.
> -					 * If that is not obeyed, subtle errors will happen.
> -					 * Let's make them less subtle... */
> -					memset(svm, 0x6b, sizeof(*svm));
> -					kfree(svm);
> -				}
> +	for_each_svm_dev(svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			/* Flush the PASID cache and IOTLB for this device.
> +			 * Note that we do depend on the hardware *not* using
> +			 * the PASID any more. Just as we depend on other
> +			 * devices never using PASIDs that they have no right
> +			 * to use. We have a *shared* PASID table, because it's
> +			 * large and has to be physically contiguous. So it's
> +			 * hard to be as defensive as we might like. */
> +			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				/* Clear private data so that free pass check */
> +				ioasid_set_data(svm->pasid, NULL);
> +				ioasid_free(svm->pasid);
> +				if (svm->mm)
> +					mmu_notifier_unregister(&svm->notifier, svm->mm);
> +				list_del(&svm->list);
> +				/* We mandate that no page faults may be outstanding
> +				 * for the PASID when intel_svm_unbind_mm() is called.
> +				 * If that is not obeyed, subtle errors will happen.
> +				 * Let's make them less subtle... */
> +				memset(svm, 0x6b, sizeof(*svm));
> +				kfree(svm);
>   			}
> -			break;
>   		}
> +		break;
>   	}
>    out:
>   	mutex_unlock(&pasid_mutex);
> @@ -581,7 +576,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			 * to unbind the mm while any page faults are outstanding.
>   			 * So we only need RCU to protect the internal idr code. */
>   			rcu_read_unlock();
> -			if (IS_ERR(svm) || !svm) {
> +			if (IS_ERR_OR_NULL(svm)) {
>   				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
>   				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
>   				       ((unsigned long long *)req)[1]);
> 
