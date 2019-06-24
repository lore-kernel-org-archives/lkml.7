Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003B4C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfFXXlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:41:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:29338 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfFXXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 16:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="244876675"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2019 16:41:35 -0700
Date:   Mon, 24 Jun 2019 16:44:50 -0700
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
Subject: Re: [PATCH v4 17/22] iommu/vt-d: Avoid duplicated code for PASID
 setup
Message-ID: <20190624164450.732e5539@jacob-builder>
In-Reply-To: <20190618170335.000078db@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-18-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190618170335.000078db@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 17:03:35 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:17 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > After each setup for PASID entry, related translation caches must
> > be flushed. We can combine duplicated code into one function which
> > is less error prone.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> Formatting nitpick below ;)
> 
> Otherwise it's cut and paste
> > ---
> >  drivers/iommu/intel-pasid.c | 48
> > +++++++++++++++++---------------------------- 1 file changed, 18
> > insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 1e25539..1ff2ecc 100644
> > --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -522,6 +522,21 @@ void intel_pasid_tear_down_entry(struct
> > intel_iommu *iommu, devtlb_invalidation_with_pasid(iommu, dev,
> > pasid); }
> >  
> > +static inline void pasid_flush_caches(struct intel_iommu *iommu,
> > +				struct pasid_entry *pte,
> > +				int pasid, u16 did)
> > +{
> > +	if (!ecap_coherent(iommu->ecap))
> > +		clflush_cache_range(pte, sizeof(*pte));
> > +
> > +	if (cap_caching_mode(iommu->cap)) {
> > +		pasid_cache_invalidation_with_pasid(iommu, did,
> > pasid);
> > +		iotlb_invalidation_with_pasid(iommu, did, pasid);
> > +	} else
> > +		iommu_flush_write_buffer(iommu);  
> 
> I have some vague recollection kernel style says use brackets around
> single lines if other blocks in an if / else stack have multiple
> lines..
> 
> I checked, this case is specifically called out
> 
> https://www.kernel.org/doc/html/v5.1/process/coding-style.html
> > +  
> This blank line doesn't add anything either ;)
indeed. i will add the braces and remove the blank line.

Thanks for looking it up.
> > +}
> > +
> >  /*
> >   * Set up the scalable mode pasid table entry for first only
> >   * translation type.
> > @@ -567,16 +582,7 @@ int intel_pasid_setup_first_level(struct
> > intel_iommu *iommu, /* Setup Present and PASID Granular Transfer
> > Type: */ pasid_set_translation_type(pte, 1);
> >  	pasid_set_present(pte);
> > -
> > -	if (!ecap_coherent(iommu->ecap))
> > -		clflush_cache_range(pte, sizeof(*pte));
> > -
> > -	if (cap_caching_mode(iommu->cap)) {
> > -		pasid_cache_invalidation_with_pasid(iommu, did,
> > pasid);
> > -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> > -	} else {
> > -		iommu_flush_write_buffer(iommu);
> > -	}
> > +	pasid_flush_caches(iommu, pte, pasid, did);
> >  
> >  	return 0;
> >  }
> > @@ -640,16 +646,7 @@ int intel_pasid_setup_second_level(struct
> > intel_iommu *iommu, */
> >  	pasid_set_sre(pte);
> >  	pasid_set_present(pte);
> > -
> > -	if (!ecap_coherent(iommu->ecap))
> > -		clflush_cache_range(pte, sizeof(*pte));
> > -
> > -	if (cap_caching_mode(iommu->cap)) {
> > -		pasid_cache_invalidation_with_pasid(iommu, did,
> > pasid);
> > -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> > -	} else {
> > -		iommu_flush_write_buffer(iommu);
> > -	}
> > +	pasid_flush_caches(iommu, pte, pasid, did);
> >  
> >  	return 0;
> >  }
> > @@ -683,16 +680,7 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu, */
> >  	pasid_set_sre(pte);
> >  	pasid_set_present(pte);
> > -
> > -	if (!ecap_coherent(iommu->ecap))
> > -		clflush_cache_range(pte, sizeof(*pte));
> > -
> > -	if (cap_caching_mode(iommu->cap)) {
> > -		pasid_cache_invalidation_with_pasid(iommu, did,
> > pasid);
> > -		iotlb_invalidation_with_pasid(iommu, did, pasid);
> > -	} else {
> > -		iommu_flush_write_buffer(iommu);
> > -	}
> > +	pasid_flush_caches(iommu, pte, pasid, did);
> >  
> >  	return 0;
> >  }  
> 
> 

[Jacob Pan]
