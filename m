Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D8C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9B2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDZQTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfDZQTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:19:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32B6CC058CC0;
        Fri, 26 Apr 2019 16:19:29 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E77AE2E02C;
        Fri, 26 Apr 2019 16:19:21 +0000 (UTC)
Subject: Re: [PATCH v2 16/19] iommu/vtd: Clean up for SVM device list
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-17-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d7db0f68-3b56-7fac-e290-8c57ad9dcb2c@redhat.com>
Date:   Fri, 26 Apr 2019 18:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-17-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 26 Apr 2019 16:19:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/24/19 1:31 AM, Jacob Pan wrote:
> Use combined macro for_each_svm_dev() to simplify SVM device iteration.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/intel-svm.c | 76 ++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 0a973c2..39dfb2e 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -447,15 +447,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  				goto out;
>  			}
>  
> -			list_for_each_entry(sdev, &svm->devs, list) {
> -				if (dev == sdev->dev) {
> -					if (sdev->ops != ops) {
> -						ret = -EBUSY;
> -						goto out;
> -					}
> -					sdev->users++;
> -					goto success;
> +			for_each_svm_dev() {
> +				if (sdev->ops != ops) {
> +					ret = -EBUSY;
> +					goto out;
>  				}
> +				sdev->users++;
> +				goto success;
>  			}
>  
>  			break;
> @@ -585,40 +583,38 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  	if (!svm)
>  		goto out;
>  
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
> -				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> -				kfree_rcu(sdev, rcu);
> -
> -				if (list_empty(&svm->devs)) {
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
> +	for_each_svm_dev() {
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
> +			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				ioasid_free(svm->pasid);
> +				if (svm->mm)
> +					mmu_notifier_unregister(&svm->notifier, svm->mm);
> +
> +				list_del(&svm->list);
> +
> +				/* We mandate that no page faults may be outstanding
> +				 * for the PASID when intel_svm_unbind_mm() is called.
> +				 * If that is not obeyed, subtle errors will happen.
> +				 * Let's make them less subtle... */
> +				memset(svm, 0x6b, sizeof(*svm));
> +				kfree(svm);
>  			}
> -			break;
>  		}
> +		break;
>  	}
>   out:
>  	mutex_unlock(&pasid_mutex);
> 
