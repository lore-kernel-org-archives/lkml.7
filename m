Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD0EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A71820673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfD2QOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:14:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:7499 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2QOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:14:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 09:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="319998209"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2019 09:14:38 -0700
Date:   Mon, 29 Apr 2019 09:17:23 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
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
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 17/19] iommu: Add max num of cache and granu types
Message-ID: <20190429091723.5970e967@jacob-builder>
In-Reply-To: <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
        <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 18:22:46 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > To convert to/from cache types and granularities between generic and
> > VT-d specific counterparts, a 2D arrary is used. Introduce the
> > limits  
> array
> > to help define the converstion array size.  
> conversion
> > 
will fix, thanks
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 5c95905..2d8fac8 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
> >  	__u64	granule_size;
> >  	__u64	nb_granules;
> >  };
> > +#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
> >  
> >  /**
> >   * First level/stage invalidation information
> > @@ -235,6 +236,7 @@ struct iommu_cache_invalidate_info {
> >  		struct iommu_inv_addr_info addr_info;
> >  	};
> >  };
> > +#define NR_IOMMU_CACHE_TYPE		(3)
> >  /**
> >   * struct gpasid_bind_data - Information about device and guest
> > PASID binding
> >   * @gcr3:	Guest CR3 value from guest mm
> >   
> Is it really something that needs to be exposed in the uapi?
> 
I put it in uapi since the related definitions for granularity and
cache type are in the same file.
Maybe putting them close together like this? I was thinking you can just
fold it into your next series as one patch for introducing cache
invalidation.
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 2d8fac8..4ff6929 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -164,6 +164,7 @@ enum iommu_inv_granularity {
        IOMMU_INV_GRANU_DOMAIN, /* domain-selective invalidation */
        IOMMU_INV_GRANU_PASID,  /* pasid-selective invalidation */
        IOMMU_INV_GRANU_ADDR,   /* page-selective invalidation */
+       NR_IOMMU_INVAL_GRANU,   /* number of invalidation granularities
*/ };
 
 /**
@@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
 #define IOMMU_CACHE_INV_TYPE_IOTLB     (1 << 0) /* IOMMU IOTLB */
 #define IOMMU_CACHE_INV_TYPE_DEV_IOTLB (1 << 1) /* Device IOTLB */
 #define IOMMU_CACHE_INV_TYPE_PASID     (1 << 2) /* PASID cache */
+#define NR_IOMMU_CACHE_TYPE            (3)
        __u8    cache;
        __u8    granularity;

> Thanks
> 
> Eric

[Jacob Pan]
