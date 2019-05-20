Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A21C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B3E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfETPa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:30:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:62180 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731262AbfETPa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:30:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 08:30:27 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 20 May 2019 08:30:27 -0700
Date:   Mon, 20 May 2019 08:33:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix bind svm with multiple devices
Message-ID: <20190520083323.1decb496@jacob-builder>
In-Reply-To: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg & David,

Any feedback on this one? Thanks.

On Wed,  8 May 2019 12:22:46 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> If multiple devices try to bind to the same mm/PASID, we need to
> set up first level PASID entries for all the devices. The current
> code does not consider this case which results in failed DMA for
> devices after the first bind.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reported-by: Mike Campin <mike.campin@intel.com>
> ---
>  drivers/iommu/intel-svm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 3a4b09a..f3d59d1 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -357,6 +357,21 @@ int intel_svm_bind_mm(struct device *dev, int
> *pasid, int flags, struct svm_dev_ }
>  
>  		list_add_tail(&svm->list, &global_svm_list);
> +	} else {
> +		/*
> +		 * Binding a new device with existing PASID, need to
> setup
> +		 * the PASID entry.
> +		 */
> +		spin_lock(&iommu->lock);
> +		ret = intel_pasid_setup_first_level(iommu, dev,
> +						mm ? mm->pgd :
> init_mm.pgd,
> +						svm->pasid,
> FLPT_DEFAULT_DID,
> +						mm ? 0 :
> PASID_FLAG_SUPERVISOR_MODE);
> +		spin_unlock(&iommu->lock);
> +		if (ret) {
> +			kfree(sdev);
> +			goto out;
> +		}
>  	}
>  	list_add_rcu(&sdev->list, &svm->devs);
>  

[Jacob Pan]
