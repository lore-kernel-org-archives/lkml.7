Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03EDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C731221848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391598AbfEXRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:41:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:24458 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfEXRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:41:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 10:41:13 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2019 10:41:13 -0700
Date:   Fri, 24 May 2019 10:44:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, yi.l.liu@linux.intel.com,
        ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu: Introduce device fault data
Message-ID: <20190524104411.15ed5c4b@jacob-builder>
In-Reply-To: <3f512c57-de7c-dc3b-049c-2c4745757636@arm.com>
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
        <20190523180613.55049-3-jean-philippe.brucker@arm.com>
        <791fe9b1-5d85-fd2d-7cfb-c2fb3428deb6@arm.com>
        <20190524064924.0cc92ae3@jacob-builder>
        <3f512c57-de7c-dc3b-049c-2c4745757636@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 17:14:30 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 24/05/2019 14:49, Jacob Pan wrote:
> > On Thu, 23 May 2019 19:43:46 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:  
> >>> +/**
> >>> + * struct iommu_fault_event - Generic fault event
> >>> + *
> >>> + * Can represent recoverable faults such as a page requests or
> >>> + * unrecoverable faults such as DMA or IRQ remapping faults.
> >>> + *
> >>> + * @fault: fault descriptor
> >>> + * @iommu_private: used by the IOMMU driver for storing
> >>> fault-specific
> >>> + *                 data. Users should not modify this field
> >>> before
> >>> + *                 sending the fault response.    
> >>
> >> Sorry if I'm a bit late to the party, but given that description,
> >> if users aren't allowed to touch this then why expose it to them
> >> at all? I.e. why not have iommu_report_device_fault() pass just
> >> the fault itself to the fault handler:
> >>
> >> 	ret = fparam->handler(&evt->fault, fparam->data);
> >>
> >> and let the IOMMU core/drivers decapsulate it again later if need
> >> be. AFAICS drivers could also just embed the entire generic event
> >> in their own private structure anyway, just as we do for domains.
> >>  
> > I can't remember all the discussion history but I think
> > iommu_private is used similarly to the page request private data
> > (device private).  
> 
> Hm yes, we already have iommu_fault_page_request::private_data for
> that. I think I used to stash flags in iommu_private (is_stall and
> needs_pasid), so that the SMMUv3 driver doesn't need to go fetch them
> from the device structure, but I removed them. If VT-d doesn't need
> iommu_private either, maybe we can remove it entirely?
> 
yes, vt-d does not use or plan to use it.
> In any case I agree that device drivers should only need to know about
> evt->fault.
> 
> > We
> > need to inject the data to the guest and the guest will send the
> > unmodified data back along with response.  
> 
> By the way, does private_data need to go back through the
> iommu_page_response() path? The current series doesn't do that.
> 
yes, private needs to go back in the page_response path. perhaps just
send the response with the match prm?
-ret = domain->ops->page_response(dev, msg, evt->iommu_private);
+ret = domain->ops->page_response(dev, msg, prm);


> > The private data can be used
> > to tag internal device/iommu context.  
> 
> > I think we can do the way you said by keeping them within iommu core
> > and recover it based on the response but that would require tracking
> > each fault report, right?  
> 
> That's already the case: we decided in thread [1] to track recoverable
> faults in the IOMMU core, in order to check that the response is sane
> and to set a quota and/or timeout. (I didn't include your timeout
> patches here because I think they need a little more work. They are on
> my sva/api branch.)
> 
> I already dropped iommu_private from the iommu_page_response
> structure. In patch 4 iommu_page_response() retrieves the fault event
> and pass the corresponding iommu_private back to the IOMMU driver.
> 
> [1]
> https://lore.kernel.org/lkml/20171206112521.1edf8e9b@jacob-builder/
>
great, as planned :) I lost track where the discussion ended and
haven't read the latest code. Thanks

> Thanks,
> Jean
> 
> > 
> > If we pass on the private data, we only need to check if the
> > response belong to the device but not exact match of a specific
> > fault since the damage is contained in the assigned device. In case
> > of injection fault into the guest, the response will come
> > asynchronously after the handler completes.  

[Jacob Pan]
