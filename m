Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D220867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392833AbfJYF3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:29:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:24278 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392384AbfJYF3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:29:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 22:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="223807397"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2019 22:29:11 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 05/11] iommu/vt-d: Move domain helper to header
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <415090ca-183c-024a-320d-873625d37ba9@linux.intel.com>
Date:   Fri, 25 Oct 2019 13:26:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 10/25/19 3:54 AM, Jacob Pan wrote:
> Move domain helper to header to be used by SVA code.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

This patch looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 6 ------
>   include/linux/intel-iommu.h | 6 ++++++
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 2ea09b988a23..acd1ac787d8b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -428,12 +428,6 @@ static void init_translation_status(struct intel_iommu *iommu)
>   		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>   }
>   
> -/* Convert generic 'struct iommu_domain to private struct dmar_domain */
> -static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> -{
> -	return container_of(dom, struct dmar_domain, domain);
> -}
> -
>   static int __init intel_iommu_setup(char *str)
>   {
>   	if (!str)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index c624733cb2e6..3dba6ad3e9ad 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -594,6 +594,12 @@ static inline void __iommu_flush_cache(
>   		clflush_cache_range(addr, size);
>   }
>   
> +/* Convert generic struct iommu_domain to private struct dmar_domain */
> +static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct dmar_domain, domain);
> +}
> +
>   /*
>    * 0: readable
>    * 1: writable
> 
