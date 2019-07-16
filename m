Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8287C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B09217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfGPJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGPJ3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3309944BEF;
        Tue, 16 Jul 2019 09:29:39 +0000 (UTC)
Received: from [10.36.116.32] (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D345E7A5;
        Tue, 16 Jul 2019 09:29:32 +0000 (UTC)
Subject: Re: [PATCH v4 13/22] iommu/vt-d: Enlightened PASID allocation
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
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-14-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6d53fe3e-8d91-22f6-4bec-aad6745bee81@redhat.com>
Date:   Tue, 16 Jul 2019 11:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1560087862-57608-14-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 16 Jul 2019 09:29:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 6/9/19 3:44 PM, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> IOMMU driver should rely on the emulation software to allocate
> and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> register set to support this. This includes a capability register,
> a virtual command register and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
> 
> This patch adds the enlightened PASID allocation/free interfaces
> via the virtual command register.>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h | 13 +++++++-
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 2fefeaf..69fddd3 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -63,6 +63,82 @@ void *intel_pasid_lookup_id(int pasid)
>  	return p;
>  }
>  
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +{
> +	u64 res;
> +	u64 cap;
> +	u8 status_code;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!ecap_vcs(iommu->ecap)) {
> +		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
> +			iommu->name);
> +		return -ENODEV;
> +	}
> +
> +	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> +	if (!(cap & DMA_VCS_PAS)) {
> +		pr_warn("IOMMU: %s: Emulation software doesn't support PASID allocation\n",
> +			iommu->name);
> +		return -ENODEV;
> +	}
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	status_code = VCMD_VRSP_SC(res);
> +	switch (status_code) {
> +	case VCMD_VRSP_SC_SUCCESS:
> +		*pasid = VCMD_VRSP_RESULT(res);
> +		break;
> +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> +		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
> +		ret = -ENOMEM;
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
unknown
s/unknown/unexpected
> +			iommu->name, status_code);
> +	}
> +
> +	return ret;
> +}
> +
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +{
> +	u64 res;
> +	u8 status_code;
> +	unsigned long flags;
> +
> +	if (!ecap_vcs(iommu->ecap)) {
> +		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
> +			iommu->name);
> +		return;
> +	}
Logically shouldn't you also check DMAR_VCCAP_REG as well?
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	status_code = VCMD_VRSP_SC(res);
> +	switch (status_code) {
> +	case VCMD_VRSP_SC_SUCCESS:
> +		break;
> +	case VCMD_VRSP_SC_INVALID_PASID:
> +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> +		break;
> +	default:
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
> +			iommu->name, status_code);
s/Unkonwn/Unexpected
> +	}
> +}
> +
>  /*
>   * Per device pasid table management:
>   */
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 23537b3..4b26ab5 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -19,6 +19,16 @@
>  #define PASID_PDE_SHIFT			6
>  #define MAX_NR_PASID_BITS		20
>  
> +/* Virtual command interface for enlightened pasid management. */
> +#define VCMD_CMD_ALLOC			0x1
> +#define VCMD_CMD_FREE			0x2
> +#define VCMD_VRSP_IP			0x1
> +#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
> +#define VCMD_VRSP_SC_SUCCESS		0
> +#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> +#define VCMD_VRSP_SC_INVALID_PASID	1
> +#define VCMD_VRSP_RESULT(e)		(((e) >> 8) & 0xfffff)
> +
>  /*
>   * Domain ID reserved for pasid entries programmed for first-level
>   * only and pass-through transfer modes.
> @@ -69,5 +79,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct device *dev, int pasid);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, int pasid);
> -
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6925a18..bff907b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -173,6 +173,7 @@
>  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
>  #define ecap_flts(e)		(((e) >> 47) & 0x1)
>  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
>  #define ecap_smts(e)		(((e) >> 43) & 0x1)
>  #define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
> @@ -289,6 +290,7 @@
>  
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_VCS_PAS	((u64)1)
>  
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
>  do {									\
> 
Otherwise

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

