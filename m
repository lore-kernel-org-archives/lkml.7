Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28769C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F335C206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRD0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:26:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:37596 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRD0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:26:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 19:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,328,1571727600"; 
   d="scan'208";a="227721983"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 19:26:20 -0800
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 06/10] iommu/vt-d: Cache virtual command capability
 register
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f704b87-aad7-c864-91ac-423a05287f21@linux.intel.com>
Date:   Wed, 18 Dec 2019 11:25:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576524252-79116-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/17/19 3:24 AM, Jacob Pan wrote:
> Virtual command registers are used in the guest only, to prevent
> vmexit cost, we cache the capability and store it during initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/dmar.c        | 1 +
>   include/linux/intel-iommu.h | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index f2f5d75da94a..3f98dd9ad004 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -953,6 +953,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
>   		warn_invalid_dmar(phys_addr, " returns all ones");
>   		goto unmap;
>   	}
> +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>   
>   	/* the registers might be more than one page */
>   	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ee26989df008..4d25141ec3df 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -189,6 +189,9 @@
>   #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>   #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
>   
> +/* Virtual command interface capabilities */
> +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */

Has DMA_VCS_PAS ever been defined?

Best regards,
baolu

> +
>   /* IOTLB_REG */
>   #define DMA_TLB_FLUSH_GRANU_OFFSET  60
>   #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> @@ -531,6 +534,7 @@ struct intel_iommu {
>   	u64		reg_size; /* size of hw register set */
>   	u64		cap;
>   	u64		ecap;
> +	u64		vccap;
>   	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
>   	raw_spinlock_t	register_lock; /* protect register handling */
>   	int		seq_id;	/* sequence id of the iommu */
> 
