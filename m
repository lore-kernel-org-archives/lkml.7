Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758BEC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C5520663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfFXVdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:33:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52016 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfFXVdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:33:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 14:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="244842879"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2019 14:33:11 -0700
Date:   Mon, 24 Jun 2019 14:36:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 15/22] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Message-ID: <20190624143626.0dd8d46d@jacob-builder>
In-Reply-To: <20190618165709.00005dbf@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-16-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190618165709.00005dbf@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 16:57:09 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:15 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> Hi Jacob,
> 
> One question inline.
> 
Hi Jonathan,

Sorry, I got distracted and missed your review. My answer
below.

Thanks!

Jacob

> Jonathan
> 
> > ---
> >  drivers/iommu/intel-iommu.c | 11 +++++------
> >  drivers/iommu/intel-pasid.c | 36
> > ------------------------------------ drivers/iommu/intel-svm.c   |
> > 37 +++++++++++++++++++++---------------- 3 files changed, 26
> > insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 5b84994..39b63fe 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5167,7 +5167,7 @@ static void auxiliary_unlink_device(struct
> > dmar_domain *domain, domain->auxd_refcnt--;
> >  
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >  }
> >  
> >  static int aux_domain_add_dev(struct dmar_domain *domain,
> > @@ -5185,10 +5185,9 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, if (domain->default_pasid <= 0) {
> >  		int pasid;
> >  
> > -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> > -
> > pci_max_pasids(to_pci_dev(dev)),
> > -					     GFP_KERNEL);
> > -		if (pasid <= 0) {
> > +		pasid = ioasid_alloc(NULL, PASID_MIN,
> > pci_max_pasids(to_pci_dev(dev)) - 1,
> > +				domain);  
> 
> Is there any point in passing the domain in as the private pointer
> here? I can't immediately see anywhere it is read back?
> 
Good point, I agree. There is no need for passing the domain. aux domain
and its defaul_pasid has 1:1 mapping.

> It is also rather confusing as the same driver stashes two different
> types of data in the same xarray.

On VT-d, there should be only one type of data for all PASID users that
needs private data. Whether it is native SVA or guest SVA. Only an
internal flag will tell them apart.
