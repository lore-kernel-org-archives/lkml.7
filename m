Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA0CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5643206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfKRC0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:26:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:19719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfKRC0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:26:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 18:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,318,1569308400"; 
   d="scan'208";a="203932511"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2019 18:26:36 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 10/10] iommu/vt-d: Misc macro clean up for SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1573859377-75924-11-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ac725526-0396-e9c6-196e-b0d1cf5431fe@linux.intel.com>
Date:   Mon, 18 Nov 2019 10:23:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573859377-75924-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/19 7:09 AM, Jacob Pan wrote:
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-svm.c | 85 ++++++++++++++++++++++-------------------------
>   1 file changed, 40 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 189865501411..a7f67a9da3fc 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -226,6 +226,10 @@ static const struct mmu_notifier_ops intel_mmuops = {
>   static DEFINE_MUTEX(pasid_mutex);
>   static LIST_HEAD(global_svm_list);
>   
> +#define for_each_svm_dev(sdev, svm, dev)		\
> +	list_for_each_entry(sdev, &svm->devs, list)	\
> +		if (dev != sdev->dev) {} else

"dev" has been reused in "sdev->dev", how about below?

#define for_each_svm_dev(sdev, svm, d)                  \
         list_for_each_entry((sdev), &(svm)->devs, list) \
                 if ((d) != (sdev)->dev) {} else

Best regards,
baolu


> +
>   int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>   {
>   	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -274,15 +278,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
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
> +			for_each_svm_dev(sdev, svm, dev) {
> +				if (sdev->ops != ops) {
> +					ret = -EBUSY;
> +					goto out;
>   				}
> +				sdev->users++;
> +				goto success;
>   			}
>   
>   			break;
> @@ -427,45 +429,38 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>   		goto out;
>   	}
>   
> -	if (!svm)
> -		goto out;
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
> +	for_each_svm_dev(sdev, svm, dev) {
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
> 
