Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18865C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E384F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfFRQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:03:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19039 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbfFRQDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:03:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4C1B12414D8A08DBFF9;
        Wed, 19 Jun 2019 00:03:48 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 00:03:46 +0800
Date:   Tue, 18 Jun 2019 17:03:35 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 17/22] iommu/vt-d: Avoid duplicated code for PASID
 setup
Message-ID: <20190618170335.000078db@huawei.com>
In-Reply-To: <1560087862-57608-18-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-18-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019 06:44:17 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> After each setup for PASID entry, related translation caches must be flushed.
> We can combine duplicated code into one function which is less error prone.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Formatting nitpick below ;)

Otherwise it's cut and paste
> ---
>  drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 1e25539..1ff2ecc 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -522,6 +522,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>  }
>  
> +static inline void pasid_flush_caches(struct intel_iommu *iommu,
> +				struct pasid_entry *pte,
> +				int pasid, u16 did)
> +{
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
> +	if (cap_caching_mode(iommu->cap)) {
> +		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +		iotlb_invalidation_with_pasid(iommu, did, pasid);
> +	} else
> +		iommu_flush_write_buffer(iommu);

I have some vague recollection kernel style says use brackets around
single lines if other blocks in an if / else stack have multiple lines..

I checked, this case is specifically called out

https://www.kernel.org/doc/html/v5.1/process/coding-style.html
> +
This blank line doesn't add anything either ;)
> +}
> +
>  /*
>   * Set up the scalable mode pasid table entry for first only
>   * translation type.
> @@ -567,16 +582,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  	/* Setup Present and PASID Granular Transfer Type: */
>  	pasid_set_translation_type(pte, 1);
>  	pasid_set_present(pte);
> -
> -	if (!ecap_coherent(iommu->ecap))
> -		clflush_cache_range(pte, sizeof(*pte));
> -
> -	if (cap_caching_mode(iommu->cap)) {
> -		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> -	} else {
> -		iommu_flush_write_buffer(iommu);
> -	}
> +	pasid_flush_caches(iommu, pte, pasid, did);
>  
>  	return 0;
>  }
> @@ -640,16 +646,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  	 */
>  	pasid_set_sre(pte);
>  	pasid_set_present(pte);
> -
> -	if (!ecap_coherent(iommu->ecap))
> -		clflush_cache_range(pte, sizeof(*pte));
> -
> -	if (cap_caching_mode(iommu->cap)) {
> -		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> -	} else {
> -		iommu_flush_write_buffer(iommu);
> -	}
> +	pasid_flush_caches(iommu, pte, pasid, did);
>  
>  	return 0;
>  }
> @@ -683,16 +680,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  	 */
>  	pasid_set_sre(pte);
>  	pasid_set_present(pte);
> -
> -	if (!ecap_coherent(iommu->ecap))
> -		clflush_cache_range(pte, sizeof(*pte));
> -
> -	if (cap_caching_mode(iommu->cap)) {
> -		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> -	} else {
> -		iommu_flush_write_buffer(iommu);
> -	}
> +	pasid_flush_caches(iommu, pte, pasid, did);
>  
>  	return 0;
>  }


