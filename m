Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFF32070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405322AbfJYGm6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:42:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:24390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405128AbfJYGm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:42:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 23:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="202526904"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2019 23:42:57 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 23:42:57 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 23:42:57 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.176]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 14:42:55 +0800
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
Subject: RE: [PATCH v7 06/11] iommu/vt-d: Avoid duplicated code for PASID
 setup
Thread-Topic: [PATCH v7 06/11] iommu/vt-d: Avoid duplicated code for PASID
 setup
Thread-Index: AQHViqRWsNCM4P1XlkW1vczMQuE5vadq6W7w
Date:   Fri, 25 Oct 2019 06:42:54 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDCA0@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDZhYzZiMzMtMTE4Yy00MzQ3LWE5MGUtMTg0MzBlMDBmMjgxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXhDZW9VM3V4U1NjaWp2bllhcThFXC9EZHEzSjF1aVRIUFwvUDJ0SUs1ekFXcnIzYkplZWtKYUp4bVRpdUQxU3dhIn0=
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
> After each setup for PASID entry, related translation caches must be
> flushed.
> We can combine duplicated code into one function which is less error
> prone.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

similarly, it doesn't need to be in this series.

> ---
>  drivers/iommu/intel-pasid.c | 48 +++++++++++++++++---------------------------
> -
>  1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index e79d680fe300..ffbd416ed3b8 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -485,6 +485,21 @@ void intel_pasid_tear_down_entry(struct
> intel_iommu *iommu,
>  		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>  }
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
>  /*
>   * Set up the scalable mode pasid table entry for first only
>   * translation type.
> @@ -530,16 +545,7 @@ int intel_pasid_setup_first_level(struct
> intel_iommu *iommu,
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
> @@ -603,16 +609,7 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
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
> @@ -646,16 +643,7 @@ int intel_pasid_setup_pass_through(struct
> intel_iommu *iommu,
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
> --
> 2.7.4

