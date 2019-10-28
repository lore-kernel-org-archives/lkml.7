Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1397ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0657218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfJ1WhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:37:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:30465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfJ1WhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:37:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 15:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="203399122"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2019 15:37:16 -0700
Date:   Mon, 28 Oct 2019 15:41:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 06/11] iommu/vt-d: Avoid duplicated code for PASID
 setup
Message-ID: <20191028154140.313a1fe9@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDCA0@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDCA0@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 06:42:54 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > Sent: Friday, October 25, 2019 3:55 AM
> > 
> > After each setup for PASID entry, related translation caches must be
> > flushed.
> > We can combine duplicated code into one function which is less error
> > prone.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> similarly, it doesn't need to be in this series.
Technically true, it is in this series so that we can use the combined
function. 
> 
> > ---
> >  drivers/iommu/intel-pasid.c | 48
> > +++++++++++++++++--------------------------- -
> >  1 file changed, 18 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index e79d680fe300..ffbd416ed3b8
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -485,6 +485,21 @@ void intel_pasid_tear_down_entry(struct
> > intel_iommu *iommu,
> >  		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> >  }
> > 
> > +static void pasid_flush_caches(struct intel_iommu *iommu,
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
> > +	} else {
> > +		iommu_flush_write_buffer(iommu);
> > +	}
> > +}
> > +
> >  /*
> >   * Set up the scalable mode pasid table entry for first only
> >   * translation type.
> > @@ -530,16 +545,7 @@ int intel_pasid_setup_first_level(struct
> > intel_iommu *iommu,
> >  	/* Setup Present and PASID Granular Transfer Type: */
> >  	pasid_set_translation_type(pte, 1);
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
> > @@ -603,16 +609,7 @@ int intel_pasid_setup_second_level(struct
> > intel_iommu *iommu,
> >  	 */
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
> > @@ -646,16 +643,7 @@ int intel_pasid_setup_pass_through(struct
> > intel_iommu *iommu,
> >  	 */
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
> > --
> > 2.7.4  
> 

[Jacob Pan]
