Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B28C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EEF2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfIURiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:38:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:43482 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfIURiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:38:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2019 10:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,532,1559545200"; 
   d="scan'208";a="200032667"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 21 Sep 2019 10:38:00 -0700
Date:   Sat, 21 Sep 2019 10:42:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20190921104204.238f5908@jacob-builder>
In-Reply-To: <20190920163558.GC1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1568849194-47874-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190920163558.GC1533866@lophozonia>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 18:35:58 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Sep 18, 2019 at 04:26:33PM -0700, Jacob Pan wrote:
> > +/*
> > + * struct ioasid_allocator_data - Internal data structure to hold
> > information
> > + * about an allocator. There are two types of allocators:
> > + *
> > + * - Default allocator always has its own XArray to track the
> > IOASIDs allocated.
> > + * - Custom allocators may share allocation helpers with different
> > private data.
> > + *   Custom allocators share the same helper functions also share
> > the same
> > + *   XArray.  
> 
> "that share the same helper"
> 
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
> > + *    freed.
> > + * 4. When switching between custom allocators sharing the same
> > helper
> > + *    functions, outstanding IOASIDs are preserved.
> > + * 5. When switching between custom allocator and default
> > allocator, all IOASIDs
> > + *    must be freed to ensure unadulterated space for the new
> > allocator.
> > + *
> > + * @ops:	allocator helper functions and its data
> > + * @list:	registered custom allocators
> > + * @slist:	allocators share the same ops but different data
> > + * @flags:	attributes of the allocator
> > + * @xa		xarray holds the IOASID space
> > + * @users	number of allocators sharing the same ops and
> > XArray
> > + */
> > +struct ioasid_allocator_data {
> > +	struct ioasid_allocator_ops *ops;
> > +	struct list_head list;
> > +	struct list_head slist;
> > +#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track
> > results */
> > +	unsigned long flags;
> > +	struct xarray xa;
> > +	refcount_t users;
> > +};
> > +
> > +static DEFINE_SPINLOCK(ioasid_allocator_lock);  
> 
> Thanks for making this a spinlock! I hit that sleep-in-atomic problem
> while updating iommu-sva to the new MMU notifier API, which doesn't
> allow sleeping in the free() callback.
> 
> I don't like having to use GFP_ATOMIC everywhere as a result, but
> can't see a better way. Maybe we can improve that later.
> 
> [...]
> > +/**
> > + * ioasid_unregister_allocator - Remove a custom IOASID allocator
> > ops
> > + * @ops: the custom allocator to be removed
> > + *
> > + * Remove an allocator from the list, activate the next allocator
> > in
> > + * the order it was registered. Or revert to default allocator if
> > all
> > + * custom allocators are unregistered without outstanding IOASIDs.
> > + */
> > +void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
> > +{
> > +	struct ioasid_allocator_data *pallocator;
> > +	struct ioasid_allocator_ops *sops;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	if (list_empty(&allocators_list)) {
> > +		pr_warn("No custom IOASID allocators active!\n");
> > +		goto exit_unlock;
> > +	}
> > +
> > +	list_for_each_entry(pallocator, &allocators_list, list) {
> > +		if (!use_same_ops(pallocator->ops, ops))
> > +			continue;
> > +
> > +		if (refcount_read(&pallocator->users) == 1) {
> > +			/* No shared helper functions */
> > +			list_del(&pallocator->list);
> > +			/*
> > +			 * All IOASIDs should have been freed
> > before
> > +			 * the last allocator that shares the same
> > ops
> > +			 * is unregistered.
> > +			 */
> > +			WARN_ON(!xa_empty(&pallocator->xa));  
> 
> The function doc seems to say that we revert to the default allocator
> only if there wasn't any outstanding IOASID, which isn't what this
> does. To follow the doc, we'd need to return here instead of
> continuing. The best solution would be to return with an error, but
> since we don't propagate errors I think leaking stuff is preferable
> to leaving the allocator registered, since the caller might free the
> ops when this function return. So I would keep the code like that but
> change the function's comment. What do you think is best?
> 
I agree, unregister allocator should not fail. I will change the
comments stating that if allocator is unregistered prior to freeing all
outstanding IOASIDs, these IOASIDs will be orphaned and lost.

> > +			kfree(pallocator);
> > +			if (list_empty(&allocators_list)) {
> > +				pr_info("No custom IOASID
> > allocators, switch to default.\n");
> > +				active_allocator =
> > &default_allocator;  
> 
> I'm concerned about the active_allocator variable, because
> ioasid_find() accesses it without holding ioasid_allocator_lock. It
> is holding the RCU read lock, so I think we need to free pallocator
> after a RCU grace period (using kfree_rcu)? I think we also need to
> update active_allocator with rcu_assign_pointer() and dereference it
> with rcu_dereference()
> 
right, will do. ioasid_find is on the fast path, so we try not to use
spinlock.
> > +			} else if (pallocator == active_allocator)
> > {
> > +				active_allocator =
> > list_first_entry(&allocators_list, struct ioasid_allocator_data,
> > list);
> > +				pr_info("IOASID allocator
> > changed");
> > +			}
> > +			break;
> > +		}
> > +		/*
> > +		 * Find the matching shared ops to delete,
> > +		 * but keep outstanding IOASIDs
> > +		 */
> > +		list_for_each_entry(sops, &pallocator->slist,
> > list) {
> > +			if (sops == ops) {
> > +				list_del(&ops->list);
> > +				if
> > (refcount_dec_and_test(&pallocator->users))
> > +					pr_err("no shared
> > ops\n");  
> 
> That's not possible, right, since dec_and_test only returns true if
> pallocator->users was 1, which we already checked against? I find
> pallocator->users a bit redundant since you can use list_is_empty() or
> list_is_singular() on pallocator->slist
> 
you are right, no need for the refcount, just check the status of the
shared op list.
> [...]
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private)
> >  {
> > -	ioasid_t id;
> >  	struct ioasid_data *data;
> > +	void *adata;
> > +	ioasid_t id;
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > @@ -76,14 +324,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, data->set = set;
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
> > active_allocator->flags); goto exit_free;
> >  	}
> > +
> > +	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> > +		/* Custom allocator needs framework to store and
> > track allocation results */
> > +		min = max = id;
> > +
> > +		if (xa_alloc(&active_allocator->xa, &id, data,
> > XA_LIMIT(min, max), GFP_KERNEL)) {  
> 
> Or just XA_LIMIT(id, id), and merge the two ifs?
> 
much better, thanks for the suggestions.
> You do need GFP_ATOMIC here.
> 
right, will change.

> > +			pr_err("Failed to alloc ioasid from %d to
> > %d\n", min, max);  
> 
> Maybe just "Failed to alloc ioasid %d\n" then
> 
agreed. just failed on a specific id, not range.
> > +			active_allocator->ops->free(id, NULL);  
> 
> Why doesn't this call need to pass active_allocator->ops->pdata like
> the one in ioasid_free()?
> 
Good catch, this call also need pdata.
> Thanks,
> Jean

