Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E705F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfJWRvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:51:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:29594 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbfJWRvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:51:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 10:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="201210147"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 10:51:03 -0700
Date:   Wed, 23 Oct 2019 10:55:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 01/10] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20191023105523.75895d76@jacob-builder>
In-Reply-To: <f17d8df6-d77a-32b9-104c-1ae246c7a117@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023004503.GB100970@otc-nc-03>
        <f17d8df6-d77a-32b9-104c-1ae246c7a117@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 09:53:04 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Ashok,
> 
> Thanks for reviewing the patch.
> 
> On 10/23/19 8:45 AM, Raj, Ashok wrote:
> > On Tue, Oct 22, 2019 at 04:53:14PM -0700, Jacob Pan wrote:  
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >>
> >> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> >> IOMMU driver should rely on the emulation software to allocate
> >> and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> >> register set to support this. This includes a capability register,
> >> a virtual command register and a virtual response register. Refer
> >> to section 10.4.42, 10.4.43, 10.4.44 for more information.  
> > 
> > The above paragraph seems a bit confusing, there is no reference
> > to caching mode for for VCMD... some suggestion below.
> > 
> > Enabling IOMMU in a guest requires communication with the host
> > driver for certain aspects. Use of PASID ID to enable Shared Virtual
> > Addressing (SVA) requires managing PASID's in the host. VT-d 3.0
> > spec provides a Virtual Command Register (VCMD) to facilitate this.
> > Writes to this register in the guest are trapped by Qemu and
> > proxies the call to the host driver....  
> 
> Yours is better. Will use it.
> 
I will roll that in to v7
> > 
> >   
> >>
> >> This patch adds the enlightened PASID allocation/free interfaces
> >> via the virtual command register.
> >>
> >> Cc: Ashok Raj <ashok.raj@intel.com>
> >> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Cc: Kevin Tian <kevin.tian@intel.com>
> >> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>   drivers/iommu/intel-pasid.c | 83
> >> +++++++++++++++++++++++++++++++++++++++++++++
> >> drivers/iommu/intel-pasid.h | 13 ++++++-
> >> include/linux/intel-iommu.h |  2 ++ 3 files changed, 97
> >> insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/intel-pasid.c
> >> b/drivers/iommu/intel-pasid.c index 040a445be300..76bcbb21e112
> >> 100644 --- a/drivers/iommu/intel-pasid.c
> >> +++ b/drivers/iommu/intel-pasid.c
> >> @@ -63,6 +63,89 @@ void *intel_pasid_lookup_id(int pasid)
> >>   	return p;
> >>   }
> >>   
> >> +static int check_vcmd_pasid(struct intel_iommu *iommu)
> >> +{
> >> +	u64 cap;
> >> +
> >> +	if (!ecap_vcs(iommu->ecap)) {
> >> +		pr_warn("IOMMU: %s: Hardware doesn't support
> >> virtual command\n",
> >> +			iommu->name);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> >> +	if (!(cap & DMA_VCS_PAS)) {
> >> +		pr_warn("IOMMU: %s: Emulation software doesn't
> >> support PASID allocation\n",
> >> +			iommu->name);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> >> *pasid) +{
> >> +	u64 res;
> >> +	u8 status_code;
> >> +	unsigned long flags;
> >> +	int ret = 0;
> >> +
> >> +	ret = check_vcmd_pasid(iommu);  
> > 
> > Do you have to check this everytime? every dmar_readq is going to
> > trap to the other side ...  
> 
> Yes. We don't need to check it every time. Check once and save the
> result during boot is enough.
> 
> How about below incremental change?
> 
Below is good but I was thinking to include vccap in struct
intel_iommu{} where cap and ecaps reside. i.e.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 14b87ae2916a..e2cf25c9c956 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -528,6 +528,7 @@ struct intel_iommu {
        u64             reg_size; /* size of hw register set */
        u64             cap;
        u64             ecap;
+       u64             vccap;

Also, we can use a static branch here.

> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index ff7e877b7a4d..c15d9d7e1e73 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -29,22 +29,29 @@ u32 intel_pasid_max_id = PASID_MAX;
> 
>   static int check_vcmd_pasid(struct intel_iommu *iommu)
>   {
> +       static int vcmd_supported = -EINVAL;
>          u64 cap;
> 
> +       if (vcmd_supported != -EINVAL)
> +               return vcmd_supported;
> +
>          if (!ecap_vcs(iommu->ecap)) {
>                  pr_warn("IOMMU: %s: Hardware doesn't support virtual 
> command\n",
>                          iommu->name);
> -               return -ENODEV;
> +               vcmd_supported = -ENODEV;
> +               return vcmd_supported;
>          }
> 
>          cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>          if (!(cap & DMA_VCS_PAS)) {
>                  pr_warn("IOMMU: %s: Emulation software doesn't
> support PASID allocation\n",
>                          iommu->name);
> -               return -ENODEV;
> +               vcmd_supported = -ENODEV;
> +               return vcmd_supported;
>          }
> 
> -       return 0;
> +       vcmd_supported = 0;
> +       return vcmd_supported;
>   }
> 
>   int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> 
> Best regards,
> baolu
> 
> >   
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> >> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
> >> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> >> +		      !(res & VCMD_VRSP_IP), res);
> >> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> >> +
> >> +	status_code = VCMD_VRSP_SC(res);
> >> +	switch (status_code) {
> >> +	case VCMD_VRSP_SC_SUCCESS:
> >> +		*pasid = VCMD_VRSP_RESULT(res);
> >> +		break;
> >> +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> >> +		pr_info("IOMMU: %s: No PASID available\n",
> >> iommu->name);
> >> +		ret = -ENOMEM;
> >> +		break;
> >> +	default:
> >> +		ret = -ENODEV;
> >> +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> >> +			iommu->name, status_code);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int
> >> pasid) +{
> >> +	u64 res;
> >> +	u8 status_code;
> >> +	unsigned long flags;
> >> +
> >> +	if (check_vcmd_pasid(iommu))
> >> +		return;
> >> +
> >> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> >> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) |
> >> VCMD_CMD_FREE);
> >> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> >> +		      !(res & VCMD_VRSP_IP), res);
> >> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> >> +
> >> +	status_code = VCMD_VRSP_SC(res);
> >> +	switch (status_code) {
> >> +	case VCMD_VRSP_SC_SUCCESS:
> >> +		break;
> >> +	case VCMD_VRSP_SC_INVALID_PASID:
> >> +		pr_info("IOMMU: %s: Invalid PASID\n",
> >> iommu->name);
> >> +		break;
> >> +	default:
> >> +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> >> +			iommu->name, status_code);
> >> +	}
> >> +}
> >> +
> >>   /*
> >>    * Per device pasid table management:
> >>    */
> >> diff --git a/drivers/iommu/intel-pasid.h
> >> b/drivers/iommu/intel-pasid.h index fc8cd8f17de1..e413e884e685
> >> 100644 --- a/drivers/iommu/intel-pasid.h
> >> +++ b/drivers/iommu/intel-pasid.h
> >> @@ -23,6 +23,16 @@
> >>   #define is_pasid_enabled(entry)		(((entry)->lo >>
> >> 3) & 0x1) #define get_pasid_dir_size(entry)	(1 <<
> >> ((((entry)->lo >> 9) & 0x7) + 7)) 
> >> +/* Virtual command interface for enlightened pasid management. */
> >> +#define VCMD_CMD_ALLOC			0x1
> >> +#define VCMD_CMD_FREE			0x2
> >> +#define VCMD_VRSP_IP			0x1
> >> +#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
> >> +#define VCMD_VRSP_SC_SUCCESS		0
> >> +#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> >> +#define VCMD_VRSP_SC_INVALID_PASID	1
> >> +#define VCMD_VRSP_RESULT(e)		(((e) >> 8) & 0xfffff)
> >> +
> >>   /*
> >>    * Domain ID reserved for pasid entries programmed for
> >> first-level
> >>    * only and pass-through transfer modes.
> >> @@ -95,5 +105,6 @@ int intel_pasid_setup_pass_through(struct
> >> intel_iommu *iommu, struct device *dev, int pasid);
> >>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >>   				 struct device *dev, int pasid);
> >> -
> >> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> >> *pasid); +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned
> >> int pasid); #endif /* __INTEL_PASID_H */
> >> diff --git a/include/linux/intel-iommu.h
> >> b/include/linux/intel-iommu.h index ed11ef594378..eea7468694a7
> >> 100644 --- a/include/linux/intel-iommu.h
> >> +++ b/include/linux/intel-iommu.h
> >> @@ -161,6 +161,7 @@
> >>   #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
> >>   #define ecap_flts(e)		(((e) >> 47) & 0x1)
> >>   #define ecap_slts(e)		(((e) >> 46) & 0x1)
> >> +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
> >>   #define ecap_smts(e)		(((e) >> 43) & 0x1)
> >>   #define ecap_dit(e)		((e >> 41) & 0x1)
> >>   #define ecap_pasid(e)		((e >> 40) & 0x1)
> >> @@ -279,6 +280,7 @@
> >>   
> >>   /* PRS_REG */
> >>   #define DMA_PRS_PPR	((u32)1)
> >> +#define DMA_VCS_PAS	((u64)1)
> >>   
> >>   #define IOMMU_WAIT_OP(iommu, offset, op, cond,
> >> sts)			\ do
> >> {
> >> \ -- 2.7.4
> >>  
> >   

[Jacob Pan]
