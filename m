Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15470C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8DE222EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKRVmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:42:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:14214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfKRVmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:42:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 13:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="209211756"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2019 13:42:44 -0800
Date:   Mon, 18 Nov 2019 13:47:19 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 02/10] iommu/vt-d: Fix CPU and IOMMU SVM feature
 matching checks
Message-ID: <20191118134719.6835981b@jacob-builder>
In-Reply-To: <26d1e79b-3a16-0a8f-895e-e2c41c8d3b28@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <26d1e79b-3a16-0a8f-895e-e2c41c8d3b28@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 21:33:34 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 11/18/19 8:42 PM, Jacob Pan wrote:
> > The current code checks CPU and IOMMU feature set for SVM support
> > but the result is never stored nor used. Therefore, SVM can still
> > be used even when these checks failed.  
> "SVM can still be used even when these checks failed". What were the
> consequences if it happened? Does it fix this cleanly now.
> > 
The consequence is DMA cannot reach above 48-bit virtual address range
when CPU does 5-level and IOMMU can only do 4-level. With is fix,
svm_bind_mm will fail in the first place to prevent SVM use by DMA.

> > This patch consolidates code for checking PASID, CPU vs. IOMMU
> > paging mode compatibility, as well as provides specific error
> > messages for each failed checks.>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 10 ++--------
> >  drivers/iommu/intel-svm.c   | 40
> > +++++++++++++++++++++++++++-------------
> > include/linux/intel-iommu.h |  4 +++- 3 files changed, 32
> > insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 3f974919d3bd..d598168e410d
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -3289,10 +3289,7 @@ static int __init init_dmars(void)
> >  
> >  		if (!ecap_pass_through(iommu->ecap))
> >  			hw_pass_through = 0;
> > -#ifdef CONFIG_INTEL_IOMMU_SVM
> > -		if (pasid_supported(iommu))
> > -			intel_svm_init(iommu);
> > -#endif
> > +		intel_svm_check(iommu);
> >  	}
> >  
> >  	/*
> > @@ -4471,10 +4468,7 @@ static int intel_iommu_add(struct
> > dmar_drhd_unit *dmaru) if (ret)
> >  		goto out;
> >  
> > -#ifdef CONFIG_INTEL_IOMMU_SVM
> > -	if (pasid_supported(iommu))
> > -		intel_svm_init(iommu);
> > -#endif
> > +	intel_svm_check(iommu);
> >  
> >  	if (dmaru->ignored) {
> >  		/*
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 9b159132405d..716c543488f6 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -23,19 +23,6 @@
> >  
> >  static irqreturn_t prq_event_thread(int irq, void *d);
> >  
> > -int intel_svm_init(struct intel_iommu *iommu)
> > -{
> > -	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> > -			!cap_fl1gp_support(iommu->cap))
> > -		return -EINVAL;
> > -
> > -	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> > -			!cap_5lp_support(iommu->cap))
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> >  #define PRQ_ORDER 0
> >  
> >  int intel_svm_enable_prq(struct intel_iommu *iommu)
> > @@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu
> > *iommu) return 0;
> >  }
> >  
> > +static inline bool intel_svm_capable(struct intel_iommu *iommu)
> > +{
> > +	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
> > +}
> > +
> > +void intel_svm_check(struct intel_iommu *iommu)
> > +{
> > +	if (!pasid_supported(iommu))
> > +		return;
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> > +	    !cap_fl1gp_support(iommu->cap)) {
> > +		pr_err("%s SVM disabled, incompatible 1GB page
> > capability\n",
> > +		       iommu->name);  
> nit: is it really an error or just a warning?
I think it is an error in that there is an illegal configuration. It is
mostly for vIOMMU, we expect native HW should have these features
matched.

> > +		return;
> > +	}
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> > +	    !cap_5lp_support(iommu->cap)) {
> > +		pr_err("%s SVM disabled, incompatible paging
> > mode\n",
> > +		       iommu->name);
> > +		return;
> > +	}
> > +
> > +	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
> > +}
> > +
> >  static void intel_flush_svm_range_dev (struct intel_svm *svm,
> > struct intel_svm_dev *sdev, unsigned long address, unsigned long
> > pages, int ih) {
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 63118991824c..7dcfa1c4a844
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -657,7 +657,7 @@ void iommu_flush_write_buffer(struct
> > intel_iommu *iommu); int intel_iommu_enable_pasid(struct
> > intel_iommu *iommu, struct device *dev); 
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > -int intel_svm_init(struct intel_iommu *iommu);
> > +extern void intel_svm_check(struct intel_iommu *iommu);
> >  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
> >  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> >  
> > @@ -685,6 +685,8 @@ struct intel_svm {
> >  };
> >  
> >  extern struct intel_iommu *intel_svm_device_to_iommu(struct device
> > *dev); +#else
> > +static inline void intel_svm_check(struct intel_iommu *iommu) {}
> >  #endif
> >  
> >  #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
> >   
> Besides,
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
