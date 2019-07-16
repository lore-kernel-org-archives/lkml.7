Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD26C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153F920651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfGPRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:04:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:32736 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfGPRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:04:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 10:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="319053613"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by orsmga004.jf.intel.com with ESMTP; 16 Jul 2019 10:04:54 -0700
Date:   Tue, 16 Jul 2019 10:04:53 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
Message-ID: <20190716170453.GA54873@otc-nc-03>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
 <2c5a7686-aef7-f98f-cb1c-8e0eb31b2bfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5a7686-aef7-f98f-cb1c-8e0eb31b2bfa@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric

Jacob is on sabbatical, so i'll give it my best shot :-)

Yi/Kevin can jump in...

On Tue, Jul 16, 2019 at 06:45:51PM +0200, Auger Eric wrote:
> Hi Jacob,
> 
> On 6/9/19 3:44 PM, Jacob Pan wrote:
> > When supporting guest SVA with emulated IOMMU, the guest PASID
> > table is shadowed in VMM. Updates to guest vIOMMU PASID table
> > will result in PASID cache flush which will be passed down to
> > the host as bind guest PASID calls.
> > 
> > For the SL page tables, it will be harvested from device's
> > default domain (request w/o PASID), or aux domain in case of
> > mediated device.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process CR3, FL only|
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                CR3 in GPA
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|--------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.------------------------------.
> >     |             |   |SL for GPA-HPA, default domain|
> >     |             |   '------------------------------'
> >     '-------------'
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   4 +
> >  drivers/iommu/intel-svm.c   | 187 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/intel-iommu.h |  13 ++-
> >  include/linux/intel-svm.h   |  17 ++++
> >  4 files changed, 219 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 7cfa0eb..3b4d712 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5782,6 +5782,10 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.dev_enable_feat	= intel_iommu_dev_enable_feat,
> >  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> >  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> > +#endif
> >  };
> >  
> >  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 66d98e1..f06a82f 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -229,6 +229,193 @@ static LIST_HEAD(global_svm_list);
> >  	list_for_each_entry(sdev, &svm->devs, list)	\
> >  	if (dev == sdev->dev)				\
> >  
> > +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> > +			struct device *dev,
> > +			struct gpasid_bind_data *data)
> > +{
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm = NULL;
> not requested
> > +	struct dmar_domain *ddomain;
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!iommu) || !data)
> > +		return -EINVAL;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > +		data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	if (dev_is_pci(dev)) {
> > +		/* VT-d supports devices with full 20 bit PASIDs only */
> > +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> > +			return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * We only check host PASID range, we have no knowledge to check
> > +	 * guest PASID range nor do we use the guest PASID.
> guest pasid is set below in svm->gpasid.
> So I am confused, do you handle gpasid or not? If you don't use gpasid
> at the moment, then you may return -EINVAL if data->flags &
> IOMMU_SVA_GPASID_VAL.
> 
> I confess I don't really understand gpasid as I thought you use
> enlightened PASID allocation to use a system wide PASID allocator on
> host so in which case guest and host PASID do differ?

Correct, from within the guest, we only use the enlightned allocator.

Guest PASID can be managed via Qemu, and it will also associate
guest pasid's with appropriate host pasids. Sort of how guest bdf
and host bdf are managed for page-request etc.

