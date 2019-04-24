Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A67C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D98A2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbfDXR2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfDXR1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4509870D7D;
        Wed, 24 Apr 2019 17:27:51 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51E6F5D9CD;
        Wed, 24 Apr 2019 17:27:46 +0000 (UTC)
Subject: Re: [PATCH v2 12/19] iommu/vt-d: Move domain helper to header
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
 <1556062279-64135-13-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <69413823-2749-80d0-c200-0f82d14467b7@redhat.com>
Date:   Wed, 24 Apr 2019 19:27:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-13-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 24 Apr 2019 17:27:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob

On 4/24/19 1:31 AM, Jacob Pan wrote:
> Move domainer helper to header to be used by SVA code.
s/domainer/domain
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel-iommu.c | 6 ------
>  include/linux/intel-iommu.h | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 785330a..77bbe1b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -427,12 +427,6 @@ static void init_translation_status(struct intel_iommu *iommu)
>  		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
>  }
>  
> -/* Convert generic 'struct iommu_domain to private struct dmar_domain */
> -static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> -{
> -	return container_of(dom, struct dmar_domain, domain);
> -}
> -
>  static int __init intel_iommu_setup(char *str)
>  {
>  	if (!str)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index c24c8aa..48fa164 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -597,6 +597,12 @@ static inline void __iommu_flush_cache(
>  		clflush_cache_range(addr, size);
>  }
>  
> +/* Convert generic 'struct iommu_domain to private struct dmar_domain */
> +static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct dmar_domain, domain);
> +}
> +
>  /*
>   * 0: readable
>   * 1: writable
> 
