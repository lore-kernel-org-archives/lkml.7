Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA662171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfHOErG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:47:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:5118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHOErF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:47:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 21:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="171009770"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2019 21:47:01 -0700
Cc:     baolu.lu@linux.intel.com, corbet@lwn.net, tony.luck@intel.com,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 03/10] iommu/vt-d: Request passthrough mode from IOMMU
 core
To:     Joerg Roedel <joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
 <20190814133841.7095-4-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <77ee40c6-392c-5094-c945-a63dc370188d@linux.intel.com>
Date:   Thu, 15 Aug 2019 12:46:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814133841.7095-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 8/14/19 9:38 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Get rid of the iommu_pass_through variable and request
> passthrough mode via the new iommu core function.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index bdaed2da8a55..234bc2b55c59 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3267,7 +3267,7 @@ static int __init init_dmars(void)
>   		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
>   	}
>   
> -	if (iommu_pass_through)
> +	if (iommu_default_passthrough())
>   		iommu_identity_mapping |= IDENTMAP_ALL;
>   
>   #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
> 
