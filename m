Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84630C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623C621848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfJBRQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:16:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:52280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfJBRQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:16:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 10:16:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="343390102"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2019 10:16:35 -0700
Date:   Wed, 2 Oct 2019 10:20:44 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20191002102044.6ed3ad56@jacob-builder>
In-Reply-To: <20191002161825.GA626133@lophozonia>
References: <1569110870-12603-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1569110870-12603-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191002161825.GA626133@lophozonia>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 18:18:25 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> I have four tiny comments below but the patch looks great otherwise,
> no major concern from me.
> 
> On Sat, Sep 21, 2019 at 05:07:49PM -0700, Jacob Pan wrote:
> > +/*
> > + * struct ioasid_allocator_data - Internal data structure to hold
> > information
> > + * about an allocator. There are two types of allocators:
> > + *
> > + * - Default allocator always has its own XArray to track the
> > IOASIDs allocated.
> > + * - Custom allocators may share allocation helpers with different
> > private data.
> > + *   Custom allocators that share the same helper functions also
> > share the same
> > + *   XArray.
> > + * Rules:
> > + * 1. Default allocator is always available, not dynamically
> > registered. This is
> > + *    to prevent race conditions with early boot code that want to
> > register
> > + *    custom allocators or allocate IOASIDs.
> > + * 2. Custom allocators take precedence over the default allocator.
> > + * 3. When all custom allocators sharing the same helper functions
> > are
> > + *    unregistered (e.g. due to hotplug), all outstanding IOASIDs
> > must be
> > + *    freed. Otherwise, outstand IOASIDs will be lost and
> > orphaned.  
> 
>                            outstanding
> 
> [...]
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private)
> >  {
> > -	ioasid_t id;
> >  	struct ioasid_data *data;
> > +	void *adata;
> > +	ioasid_t id;  
> 
> nit: changing the location of id could be in patch 2/4.
> 
will do.

> > -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	data = kzalloc(sizeof(*data), GFP_ATOMIC);  
> 
> I don't think that one needs to be GFP_ATOMIC. Otherwise it should
> probably be done from the start, by patch 2/4.
> 
I was thinking since we are making this API usable in atomic context,
we need to use GFP_ATOMIC and spinlock throughout the code. I agree it
should be moved to 2/4.
> >  	if (!data)
> >  		return INVALID_IOASID;
> >  
> >  	data->set = set;
> >  	data->private = private;
> >  
> > -	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max),
> > GFP_KERNEL)) {
> > -		pr_err("Failed to alloc ioasid from %d to %d\n",
> > min, max);
> > +	/*
> > +	 * Custom allocator needs allocator data to perform
> > platform specific
> > +	 * operations.
> > +	 */
> > +	spin_lock(&ioasid_allocator_lock);
> > +	adata = active_allocator->flags &
> > IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
> > +	id = active_allocator->ops->alloc(min, max, adata);
> > +	if (id == INVALID_IOASID) {
> > +		pr_err("Failed ASID allocation %lu\n",
> > active_allocator->flags);
> > +		goto exit_free;
> > +	}
> > +
> > +	if ((active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) &&
> > +		xa_alloc(&active_allocator->xa, &id, data,
> > XA_LIMIT(id, id), GFP_ATOMIC)) {  
> 
> nit: aligning at the "if (" would make this block more readable.
> 
sounds good. I need to change my editor :)
> > +		/* Custom allocator needs framework to store and
> > track allocation results */
> > +		pr_err("Failed to alloc ioasid from %d\n", id);
> > +		active_allocator->ops->free(id,
> > active_allocator->ops->pdata); goto exit_free;
> >  	}  
> 
> Thanks,
> Jean

[Jacob Pan]
