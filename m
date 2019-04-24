Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B94C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497721902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbfDXRw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390570AbfDXR17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3102309D04C;
        Wed, 24 Apr 2019 17:27:58 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C9161B99;
        Wed, 24 Apr 2019 17:27:53 +0000 (UTC)
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
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
 <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
Date:   Wed, 24 Apr 2019 19:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Apr 2019 17:27:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> IOMMU driver should rely on the emulation software to allocate
> and free PASID IDs.
Do we make the decision depending on the CM or depending on the VCCAP_REG?

VCCAP_REG description says:

If Set, software must use Virtual Command Register interface to
allocate and free PASIDs.

 The Intel vt-d spec revision 3.0 defines a
> register set to support this. This includes a capability register,
> a virtual command register and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
> 
> This patch adds the enlightened PASID allocation/free interfaces
For mu curiosity why is it called "enlightened"?
> via the virtual command register.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h | 13 ++++++++-
>  include/linux/intel-iommu.h |  2 ++
>  3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 03b12d2..5b1d3be 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -63,6 +63,76 @@ void *intel_pasid_lookup_id(int pasid)
>  	return p;
>  }
>  
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +{
> +	u64 res;
> +	u64 cap;
> +	u8 err_code;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!ecap_vcs(iommu->ecap)) {
> +		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
> +			iommu->name);
nit: other pr_* messages don't have the "IOMMU: %s:" prefix.
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
> +	err_code = VCMD_VRSP_EC(res);
> +	switch (err_code) {
> +	case VCMD_VRSP_EC_SUCCESS:
> +		*pasid = VCMD_VRSP_RESULE(res);
> +		break;
> +	case VCMD_VRSP_EC_UNAVAIL:
> +		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
> +		ret = -ENOMEM;
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
unknown
> +			iommu->name, err_code);
> +	}
> +
> +	return ret;
> +}
> +
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +{
> +	u64 res;
> +	u8 err_code;
> +	unsigned long flags;
Shall we check as well the cap is set?
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	err_code = VCMD_VRSP_EC(res);
> +	switch (err_code) {
> +	case VCMD_VRSP_EC_SUCCESS:
> +		break;
> +	case VCMD_VRSP_EC_INVAL:
> +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> +		break;
> +	default:
> +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
unknown
> +			iommu->name, err_code);
> +	}
> +}
> +
>  /*
>   * Per device pasid table management:
>   */
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 23537b3..0999dfe 100644
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
> +#define VCMD_VRSP_EC(e)			(((e) >> 1) & 0x3)
s/EC/SC? for Status Code and below
> +#define VCMD_VRSP_EC_SUCCESS		0
> +#define VCMD_VRSP_EC_UNAVAIL		1
nit: _NO_VALID_PASID
> +#define VCMD_VRSP_EC_INVAL		1
nit: _INVALID_PASID
> +#define VCMD_VRSP_RESULE(e)		(((e) >> 8) & 0xfffff)
nit: s/RESULE/RSLT?
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

Thanks

Eric

