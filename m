Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3604C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BE42067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfHMQxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:53:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:12530 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfHMQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:53:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 09:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="351588121"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2019 09:53:41 -0700
Date:   Tue, 13 Aug 2019 09:57:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 13/22] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20190813095723.467b0344@jacob-builder>
In-Reply-To: <6d53fe3e-8d91-22f6-4bec-aad6745bee81@redhat.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <6d53fe3e-8d91-22f6-4bec-aad6745bee81@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Apologize for the delayed response below,

On Tue, 16 Jul 2019 11:29:30 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 6/9/19 3:44 PM, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> > IOMMU driver should rely on the emulation software to allocate
> > and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> > register set to support this. This includes a capability register,
> > a virtual command register and a virtual response register. Refer
> > to section 10.4.42, 10.4.43, 10.4.44 for more information.
> > 
> > This patch adds the enlightened PASID allocation/free interfaces
> > via the virtual command register.>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-pasid.c | 76
> > +++++++++++++++++++++++++++++++++++++++++++++
> > drivers/iommu/intel-pasid.h | 13 +++++++-
> > include/linux/intel-iommu.h |  2 ++ 3 files changed, 90
> > insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 2fefeaf..69fddd3 100644
> > --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -63,6 +63,82 @@ void *intel_pasid_lookup_id(int pasid)
> >  	return p;
> >  }
> >  
> > +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid) +{
> > +	u64 res;
> > +	u64 cap;
> > +	u8 status_code;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (!ecap_vcs(iommu->ecap)) {
> > +		pr_warn("IOMMU: %s: Hardware doesn't support
> > virtual command\n",
> > +			iommu->name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> > +	if (!(cap & DMA_VCS_PAS)) {
> > +		pr_warn("IOMMU: %s: Emulation software doesn't
> > support PASID allocation\n",
> > +			iommu->name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> > +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
> > +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> > +		      !(res & VCMD_VRSP_IP), res);
> > +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> > +
> > +	status_code = VCMD_VRSP_SC(res);
> > +	switch (status_code) {
> > +	case VCMD_VRSP_SC_SUCCESS:
> > +		*pasid = VCMD_VRSP_RESULT(res);
> > +		break;
> > +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> > +		pr_info("IOMMU: %s: No PASID available\n",
> > iommu->name);
> > +		ret = -ENOMEM;
> > +		break;
> > +	default:
> > +		ret = -ENODEV;
> > +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",  
> unknown
> s/unknown/unexpected
sounds good.
> > +			iommu->name, status_code);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> > +{
> > +	u64 res;
> > +	u8 status_code;
> > +	unsigned long flags;
> > +
> > +	if (!ecap_vcs(iommu->ecap)) {
> > +		pr_warn("IOMMU: %s: Hardware doesn't support
> > virtual command\n",
> > +			iommu->name);
> > +		return;
> > +	}  
> Logically shouldn't you also check DMAR_VCCAP_REG as well?
Good point, we may have more than just PASID allocation virtual
commands.
> > +
> > +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> > +	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) |
> > VCMD_CMD_FREE);
> > +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> > +		      !(res & VCMD_VRSP_IP), res);
> > +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> > +
> > +	status_code = VCMD_VRSP_SC(res);
> > +	switch (status_code) {
> > +	case VCMD_VRSP_SC_SUCCESS:
> > +		break;
> > +	case VCMD_VRSP_SC_INVALID_PASID:
> > +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> > +		break;
> > +	default:
> > +		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
> > +			iommu->name, status_code);  
> s/Unkonwn/Unexpected
will fix. 
> > +	}
> > +}
> > +
> >  /*
> >   * Per device pasid table management:
> >   */
> > diff --git a/drivers/iommu/intel-pasid.h
> > b/drivers/iommu/intel-pasid.h index 23537b3..4b26ab5 100644
> > --- a/drivers/iommu/intel-pasid.h
> > +++ b/drivers/iommu/intel-pasid.h
> > @@ -19,6 +19,16 @@
> >  #define PASID_PDE_SHIFT			6
> >  #define MAX_NR_PASID_BITS		20
> >  
> > +/* Virtual command interface for enlightened pasid management. */
> > +#define VCMD_CMD_ALLOC			0x1
> > +#define VCMD_CMD_FREE			0x2
> > +#define VCMD_VRSP_IP			0x1
> > +#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
> > +#define VCMD_VRSP_SC_SUCCESS		0
> > +#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> > +#define VCMD_VRSP_SC_INVALID_PASID	1
> > +#define VCMD_VRSP_RESULT(e)		(((e) >> 8) & 0xfffff)
> > +
> >  /*
> >   * Domain ID reserved for pasid entries programmed for first-level
> >   * only and pass-through transfer modes.
> > @@ -69,5 +79,6 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu, struct device *dev, int pasid);
> >  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >  				 struct device *dev, int pasid);
> > -
> > +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid); +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned
> > int pasid); #endif /* __INTEL_PASID_H */
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 6925a18..bff907b 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -173,6 +173,7 @@
> >  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
> >  #define ecap_flts(e)		(((e) >> 47) & 0x1)
> >  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> > +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
> >  #define ecap_smts(e)		(((e) >> 43) & 0x1)
> >  #define ecap_dit(e)		((e >> 41) & 0x1)
> >  #define ecap_pasid(e)		((e >> 40) & 0x1)
> > @@ -289,6 +290,7 @@
> >  
> >  /* PRS_REG */
> >  #define DMA_PRS_PPR	((u32)1)
> > +#define DMA_VCS_PAS	((u64)1)
> >  
> >  #define IOMMU_WAIT_OP(iommu, offset, op, cond,
> > sts)			\ do
> > {
> > \ 
> Otherwise
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
