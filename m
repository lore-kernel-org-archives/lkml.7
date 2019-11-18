Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA94C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3F1206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRBee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:34:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:57822 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKRBee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:34:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 17:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,318,1569308400"; 
   d="scan'208";a="203924117"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2019 17:34:32 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 04/10] iommu/vt-d: Match CPU and IOMMU paging mode
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1573859377-75924-5-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <96bb7bcf-97b7-f6ca-3f4b-0610bb51a166@linux.intel.com>
Date:   Mon, 18 Nov 2019 09:31:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573859377-75924-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/19 7:09 AM, Jacob Pan wrote:
> When setting up first level page tables for sharing with CPU, we need
> to ensure IOMMU can support no less than the levels supported by the
> CPU.
> It is not adequate, as in the current code, to set up 5-level paging
> in PASID entry First Level Paging Mode(FLPM) solely based on CPU.
> 
> Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
> interface")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>


Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-pasid.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 040a445be300..e7cb0b8a7332 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -499,8 +499,16 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>   	}
>   
>   #ifdef CONFIG_X86
> -	if (cpu_feature_enabled(X86_FEATURE_LA57))
> -		pasid_set_flpm(pte, 1);
> +	/* Both CPU and IOMMU paging mode need to match */
> +	if (cpu_feature_enabled(X86_FEATURE_LA57)) {
> +		if (cap_5lp_support(iommu->cap)) {
> +			pasid_set_flpm(pte, 1);
> +		} else {
> +			pr_err("VT-d has no 5-level paging support for CPU\n");
> +			pasid_clear_entry(pte);
> +			return -EINVAL;
> +		}
> +	}
>   #endif /* CONFIG_X86 */
>   
>   	pasid_set_domain_id(pte, did);
> 
