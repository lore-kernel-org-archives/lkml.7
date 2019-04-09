Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1068C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A712084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDIQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:40:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:1707 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:40:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 09:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="141301427"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 09 Apr 2019 09:40:53 -0700
Date:   Tue, 9 Apr 2019 09:43:28 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@smile.fi.intel.com,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Message-ID: <20190409094328.03731c3c@jacob-builder>
In-Reply-To: <20190409100718.GE9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190409100718.GE9224@smile.fi.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 13:07:18 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:
> > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > 
> > In any virtualization use case, when the first translation stage
> > is "owned" by the guest OS, the host IOMMU driver has no knowledge
> > of caching structure updates unless the guest invalidation
> > activities are trapped by the virtualizer and passed down to the
> > host.
> > 
> > Since the invalidation data are obtained from user space and will be
> > written into physical IOMMU, we must allow security check at various
> > layers. Therefore, generic invalidation data format are proposed
> > here, model specific IOMMU drivers need to convert them into their
> > own format.  
> 
> > +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > +			   struct iommu_cache_invalidate_info
> > *inv_info) +{
> > +	int ret = 0;  
> 
> Redundant assignment.
> 
I am not a security expert but initialization of local variable can be
more secure.
I was looking at this talk.
https://outflux.net/slides/2018/lss/danger.pdf
https://cwe.mitre.org/data/definitions/457.html

> > +
> > +	if (unlikely(!domain->ops->cache_invalidate))
> > +		return -ENODEV;
> > +
> > +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> > +
> > +	return ret;
> > +}  
> 

[Jacob Pan]
