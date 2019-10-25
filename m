Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1248C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A584021929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392981AbfJYFfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:35:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:61831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732032AbfJYFfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:35:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 22:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="223808618"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2019 22:35:32 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 06/11] iommu/vt-d: Avoid duplicated code for PASID
 setup
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <077e00d1-9ec8-9aeb-200b-016326634a32@linux.intel.com>
Date:   Fri, 25 Oct 2019 13:32:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 3:54 AM, Jacob Pan wrote:
> After each setup for PASID entry, related translation caches must be flushed.
> We can combine duplicated code into one function which is less error prone.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

This patch looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-pasid.c | 48 +++++++++++++++++----------------------------
>   1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index e79d680fe300..ffbd416ed3b8 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -485,6 +485,21 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>   		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>   }
>   
> +static void pasid_flush_caches(struct intel_iommu *iommu,
> +				struct pasid_entry *pte,
> +				int pasid, u16 did)
> +{
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
> +	if (cap_caching_mode(iommu->cap)) {
> +		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +		iotlb_invalidation_with_pasid(iommu, did, pasid);
> +	} else {
> +		iommu_flush_write_buffer(iommu);
> +	}
> +}
> +
>   /*
>    * Set up the scalable mode pasid table entry for first only
>    * translation type.
> @@ -530,16 +545,7 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>   	/* Setup Present and PASID Granular Transfer Type: */
>   	pasid_set_translation_type(pte, 1);
>   	pasid_set_present(pte);
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
>   	return 0;
>   }
> @@ -603,16 +609,7 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   	 */
>   	pasid_set_sre(pte);
>   	pasid_set_present(pte);
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
>   	return 0;
>   }
> @@ -646,16 +643,7 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>   	 */
>   	pasid_set_sre(pte);
>   	pasid_set_present(pte);
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
>   	return 0;
>   }
> 
