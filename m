Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2B6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C971C2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfEXR5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:57:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:64010 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfEXR5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:57:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 10:57:07 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2019 10:57:07 -0700
Date:   Fri, 24 May 2019 11:00:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        joro@8bytes.org, alex.williamson@redhat.com,
        yi.l.liu@linux.intel.com, iommu@lists.linux-foundation.org,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu: Introduce device fault report API
Message-ID: <20190524110005.55c3eade@jacob-builder>
In-Reply-To: <e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
        <20190523180613.55049-4-jean-philippe.brucker@arm.com>
        <e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 19:56:54 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 23/05/2019 19:06, Jean-Philippe Brucker wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > Traditionally, device specific faults are detected and handled
> > within their own device drivers. When IOMMU is enabled, faults such
> > as DMA related transactions are detected by IOMMU. There is no
> > generic reporting mechanism to report faults back to the in-kernel
> > device driver or the guest OS in case of assigned devices.
> > 
> > This patch introduces a registration API for device specific fault
> > handlers. This differs from the existing iommu_set_fault_handler/
> > report_iommu_fault infrastructures in several ways:
> > - it allows to report more sophisticated fault events (both
> >    unrecoverable faults and page request faults) due to the nature
> >    of the iommu_fault struct
> > - it is device specific and not domain specific.
> > 
> > The current iommu_report_device_fault() implementation only handles
> > the "shoot and forget" unrecoverable fault case. Handling of page
> > request faults or stalled faults will come later.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >   drivers/iommu/iommu.c | 127
> > ++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h |
> > 29 ++++++++++ 2 files changed, 156 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 67ee6623f9b2..d546f7baa0d4 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) goto err_free_name;
> >   	}
> >   
> > +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param),
> > GFP_KERNEL);
> > +	if (!dev->iommu_param) {
> > +		ret = -ENOMEM;
> > +		goto err_free_name;
> > +	}
> > +	mutex_init(&dev->iommu_param->lock);
> > +  
> 
> Note that this gets a bit tricky when we come to move to move the 
> fwspec/ops/etc. into iommu_param, since that data can have a longer 
> lifespan than the group association. I'd suggest moving this
> management out to the iommu_{probe,release}_device() level from the
> start, but maybe we're happy to come back and change things later as
> necessary.
> 
Agreed, I can't think of any downside of moving it earlier.
> Robin.
> 
>  [...]  
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
