Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE49C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A500920868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfDPP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:27:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:29342 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfDPP1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:27:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 08:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="151355990"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2019 08:27:47 -0700
Date:   Tue, 16 Apr 2019 08:30:25 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 10/18] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20190416083025.378f3915@jacob-builder>
In-Reply-To: <20190415143711.13c29308@x1.home>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190415143711.13c29308@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 14:37:11 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon,  8 Apr 2019 16:59:25 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch register a
> > custom IOASID allocator which takes precedence over the default
> > IDR based allocator. The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 50
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  1 + 2 files changed, 51 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 28cb713..a38d774 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -4820,6 +4820,42 @@ static int __init
> > platform_optin_force_iommu(void) return 1;
> >  }
> >  
> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data) +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +	return ioasid;  
> 
> How does this honor min/max?
> 
Sorry I missed this in my previous reply.
VT-d virtual command interface always allocate PASIDs with full 20bit
range. I think a range checking is missing here. Thanks for pointing
this out.

>  [...]  
> 
