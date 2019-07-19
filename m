Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D1121850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGSJPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:15:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:61891 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSJPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 02:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,281,1559545200"; 
   d="scan'208";a="179572435"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2019 02:15:48 -0700
Cc:     baolu.lu@linux.intel.com, Dmitry Safonov <0x7f454c46@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Check if domain->pgd was allocated
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
References: <20190716213806.20456-1-dima@arista.com>
 <20190716213806.20456-2-dima@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0748b24f-7c21-be93-59fa-88f62c3e8389@linux.intel.com>
Date:   Fri, 19 Jul 2019 17:15:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716213806.20456-2-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/19 5:38 AM, Dmitry Safonov wrote:
> There is a couple of places where on domain_init() failure domain_exit()
> is called. While currently domain_init() can fail only if
> alloc_pgtable_page() has failed.
> 
> Make domain_exit() check if domain->pgd present, before calling
> domain_unmap(), as it theoretically should crash on clearing pte entries
> in dma_pte_clear_level().
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>

This looks good to me. Thank you!

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Baolu

> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6d1510284d21..698cc40355ef 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1835,7 +1835,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
>   
>   static void domain_exit(struct dmar_domain *domain)
>   {
> -	struct page *freelist;
>   
>   	/* Remove associated devices and clear attached or cached domains */
>   	domain_remove_dev_info(domain);
> @@ -1843,9 +1842,12 @@ static void domain_exit(struct dmar_domain *domain)
>   	/* destroy iovas */
>   	put_iova_domain(&domain->iovad);
>   
> -	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
> +	if (domain->pgd) {
> +		struct page *freelist;
>   
> -	dma_free_pagelist(freelist);
> +		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
> +		dma_free_pagelist(freelist);
> +	}
>   
>   	free_domain_mem(domain);
>   }
> 
