Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BFC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfB1Sal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:30:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:4536 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfB1Sak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:30:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 10:30:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="142457349"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2019 10:30:39 -0800
Date:   Thu, 28 Feb 2019 10:32:52 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190228103252.69715c67@jacob-builder>
In-Reply-To: <d25643d4-efb8-271a-2a58-3914c2124bbb@arm.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
        <20190227134129.51ad42ac@jacob-builder>
        <d25643d4-efb8-271a-2a58-3914c2124bbb@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 12:19:22 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 27/02/2019 21:41, Jacob Pan wrote:
> > On Tue, 26 Feb 2019 12:17:43 +0100
> > Joerg Roedel <joro@8bytes.org> wrote:
> >   
> >> Hi Jean-Philippe,
> >>
> >> Thanks for the patch! I think this is getting close to be applied
> >> after the next merge window.
> >>
> >> On Wed, Feb 20, 2019 at 02:27:59PM +0000, Jean-Philippe Brucker
> >> wrote:  
> >>> +int iommu_sva_bind_device(struct device *dev, struct mm_struct
> >>> *mm, int *pasid,
> >>> +			  iommu_mm_exit_handler_t mm_exit, void
> >>> *drvdata)    
> >>
> >> I think we are better of with introducing a sva-bind handle which
> >> can be used to extend and further configure the binding done with
> >> this function.
> >>
> >> How about a 'struct iommu_sva' with an iommu-private definition
> >> that is returned by this function:
> >>
> >> 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> >> 						struct mm_struct
> >> *mm); 
> > Just trying to understand how to use this API.
> > So if we bind the same mm to two different devices, we should get
> > two different iommu_sva handle, right?  
> 
> Yes, the iommu_sva handle is the bond between one mm and one device,
> so you will get two different handles.
> 
> > I think intel-svm still needs a flag argument for supervisor pasid
> > etc. Other than that, I think both interface should work for vt-d.  
> 
> Is supervisor PASID still needed now that we have auxiliary domains,
> and now that VT-d supports nested IOVA? You could have private kernel
> address spaces through auxiliary domains, or simply use DMA API as
> usual with PASID#0. I've been reluctant to make that feature common
> because it looks risky - gives full access to the kernel address
> space to devices and no notification on mapping change.
> 
It is still in the VT-d spec. Ashok will be able to answer this
better :)
> > Another question is that for nested SVA, we will need to bind guest
> > mm. Do you think we should try to reuse this or have it separate? I
> > am working on a separate API for now.  
> 
> I also think it should be separate. That bind() operation is performed
> on an auxiliary domain, I guess?
> 
yes the 2nd level is retrieved from aux domain for mdev, but for pdev,
2nd level comes from rid2pasid/default domain.
> >> and the corresponding unbind function:
> >>
> >> 	int iommu_sva_unbind_device(struct iommu_sva* *handle);
> >>
> >> (Btw, does this need to return and int? Can unbinding fail?).
> >>
> >> With that in place we can implement and extentable API base on the
> >> handle:
> >>
> >> 	int iommu_sva_get_pasid(struct iommu_sva *handle);  
> > If multiple bind to the same mm gets multiple handles, this API
> > should retrieve the same pasid for different handle?  
> 
> Yes
> 
> > Just curious why making
> > the handle private instead of returning the pasid value in the
> > handle?  
> 
> I don't have a strong objection against that. One reason to have an
> accessor is that the PASID is freed on mm_exit, so until the device
> driver calls unbind(), the PASID contained in the handle is stale (and
> the accessor returns PASID_INVALID). But that's a bit pedantic, the
> device driver should know that the handle is stale since it got
> notified of it. Having an accessor might also help tracking uses of
> the handle in the kernel, and make future API modifications easier.
> 
make sense.
> Thanks,
> Jean
> 
> >> 	void iommu_sva_set_exit_handler(struct iommu_sva *handle,
> >> 					iommu_mm_exit_handler_t
> >> mm_exit);
> >>
> >> I think at least the AMD IOMMU driver needs more call-backs like a
> >> handler that is invoked when a fault can not be resolved. And there
> >> might be others in the future, putting them all in the parameter
> >> list of the bind function doesn't scale well.
> >>  
> >   
> >> Regards,
> >>
> >> 	Joerg  
> > 
> >   
> 

[Jacob Pan]
