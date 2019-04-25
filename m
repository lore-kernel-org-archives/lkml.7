Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A053C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F84E20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfDYV1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:27:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:10736 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfDYV1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:27:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 14:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="134421018"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 14:27:01 -0700
Date:   Thu, 25 Apr 2019 14:29:44 -0700
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
Subject: Re: [PATCH v2 08/19] ioasid: Add custom IOASID allocator
Message-ID: <20190425142944.40661941@jacob-builder>
In-Reply-To: <4ef22c62-0947-8de5-3288-2835ce5fa7a9@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <4ef22c62-0947-8de5-3288-2835ce5fa7a9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thanks for the review.

On Thu, 25 Apr 2019 12:03:42 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > Sometimes, IOASID allocation must be handled by platform specific
> > code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs need
> > to be allocated by the host via enlightened or paravirt interfaces.
> > 
> > This patch adds an extension to the IOASID allocator APIs such that
> > platform drivers can register a custom allocator, possibly at boot
> > time, to take over the allocation. Xarray is still used for tracking
> > and searching purposes internal to the IOASID code. Private data of
> > an IOASID can also be set after the allocation.
> > 
> > There can be multiple custom allocators registered but only one is
> > used at a time. In case of hot removal of devices that provides the
> > allocator, all IOASIDs must be freed prior to unregistering the
> > allocator. Default XArray based allocator cannot be mixed with
> > custom allocators, i.e. custom allocators will not be used if there
> > are outstanding IOASIDs allocated by the default XA allocator.  
> 
> What's the exact use case behind allowing several custom IOASID
> allocators to be registered?
It is mainly for supporting multiple PCI segments thus multiple
vIOMMUs. Even though, all allocators will end up calling the host to
allocate PASIDs. QEMU does not support multiple PCI segments/domains
afaik but others might.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/base/ioasid.c  | 182
> > ++++++++++++++++++++++++++++++++++++++++++++++---
> > include/linux/ioasid.h |  15 +++- 2 files changed, 187
> > insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
> > index c4012aa..5cb36a4 100644
> > --- a/drivers/base/ioasid.c
> > +++ b/drivers/base/ioasid.c
> > @@ -17,6 +17,120 @@ struct ioasid_data {
> >  };
> >  
> >  static DEFINE_XARRAY_ALLOC(ioasid_xa);
> > +static DEFINE_MUTEX(ioasid_allocator_lock);
> > +static struct ioasid_allocator *ioasid_allocator;  
> A more explicit name may be chosen. If I understand correctly that's
> the active_custom_allocator
Yes, more clear this way.

> > +
> > +static LIST_HEAD(custom_allocators);
> > +/*
> > + * A flag to track if ioasid default allocator already been used,
> > this will  
> is already in use?
> > + * prevent custom allocator from being used. The reason is that
> > custom allocator  
> s/The reason is that custom allocator/The reason is that custom
> allocators
> > + * must have unadulterated space to track private data with
> > xarray, there cannot
> > + * be a mix been default and custom allocated IOASIDs.
> > + */
> > +static int default_allocator_used;
> > +
> > +/**
> > + * ioasid_register_allocator - register a custom allocator
> > + * @allocator: the custom allocator to be registered
> > + *
> > + * Custom allocator take precedence over the default xarray based
> > allocator.
> > + * Private data associated with the ASID are managed by ASID
> > common code
> > + * similar to data stored in xa.
> > + *
> > + * There can be multiple allocators registered but only one is
> > active. In case
> > + * of runtime removal of an custom allocator, the next one is
> > activated based
> > + * on the registration ordering.  
> This last sentence may be moved to the unregister() kerneldoc
> > + */
> > +int ioasid_register_allocator(struct ioasid_allocator *allocator)
> > +{
> > +	struct ioasid_allocator *pallocator;
> > +	int ret = 0;
> > +
> > +	if (!allocator)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	if (list_empty(&custom_allocators))
> > +		ioasid_allocator = allocator;  
> The fact the first registered custom allocator gets automatically
> active was not obvious to me and may deserve a comment.
Will do. I will add:
"No particular preference since all custom allocators end up calling
the host to allocate IOASIDs. We activate the first allocator and keep
the later ones in a list in case the first one gets removed due to
hotplug."

> > +	else {
> > +		/* Check if the allocator is already registered */
> > +		list_for_each_entry(pallocator,
> > &custom_allocators, list) {
> > +			if (pallocator == allocator) {
> > +				pr_err("IOASID allocator already
> > exist\n");  
> s/exist/registered?
make sense.
> > +				ret = -EEXIST;
> > +				goto out_unlock;
> > +			}
> > +		}
> > +	}
> > +	list_add_tail(&allocator->list, &custom_allocators);
> > +
> > +out_unlock:
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_register_allocator);
> > +
> > +/**
> > + * ioasid_unregister_allocator - Remove a custom IOASID allocator
> > + * @allocator: the custom allocator to be removed
> > + *
> > + * Remove an allocator from the list, activate the next allocator
> > in
> > + * the order it was  registration.
> > + */
> > +void ioasid_unregister_allocator(struct ioasid_allocator
> > *allocator) +{
> > +	if (!allocator)
> > +		return;
> > +
> > +	if (list_empty(&custom_allocators)) {
> > +		pr_warn("No custom IOASID allocators active!\n");  
> s/active/registered?
> > +		return;
> > +	}
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	list_del(&allocator->list);
> > +	if (list_empty(&custom_allocators)) {
> > +		pr_info("No custom IOASID allocators\n");
> > +		/*
> > +		 * All IOASIDs should have been freed before the
> > last allocator
> > +		 * is unregistered.
> > +		 */
> > +		BUG_ON(!xa_empty(&ioasid_xa));  
> At this stage it is difficult to assess whether using a BUG_ON() is
> safe here. Who is responsible for freeing the IOASIDs?
Who ever allocates IOASIDs are responsible for freeing. This could be
the IOMMU driver running in the guest. In the very unlikely scenario
below:
1. vIOMMU1 register a custom allocator1
2. vIOMMU2 register a custom allocator2
3. sva_bind() called to bind dev under vIOMMU1, use allocator1 to
allocate ioasid1.
4. vIOMMU 1 hot removed
5. vIOMMU 2 hot removed
BUG_ON() hits because sva_unbind was not called on ioasid1. So even if
we free ioasid1 after BUG_ON, it does not undo the damage.

> > +		ioasid_allocator = NULL;
> > +	} else if (allocator == ioasid_allocator) {
> > +		ioasid_allocator = list_entry(&custom_allocators,
> > struct ioasid_allocator, list);
> > +		pr_info("IOASID allocator changed");
> > +	}
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
> > +
> > +/**
> > + * ioasid_set_data - Set private data for an allocated ioasid
> > + * @ioasid: the ID to set data
> > + * @data:   the private data
> > + *
> > + * For IOASID that is already allocated, private data can be set
> > + * via this API. Future lookup can be done via ioasid_find.
> > + */
> > +int ioasid_set_data(ioasid_t ioasid, void *data)
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	int ret = 0;
> > +
> > +	ioasid_data = xa_load(&ioasid_xa, ioasid);
> > +	if (ioasid_data)
> > +		ioasid_data->private = data;
> > +	else
> > +		ret = -ENOENT;
> > +
> > +	/* getter may use the private data */
> > +	synchronize_rcu();
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_data);
> > +
> >  /**
> >   * ioasid_alloc - Allocate an IOASID
> >   * @set: the IOASID set
> > @@ -31,7 +145,7 @@ static DEFINE_XARRAY_ALLOC(ioasid_xa);
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private)
> >  {
> > -	int id = -1;
> > +	int id = INVALID_IOASID;
> >  	struct ioasid_data *data;
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > @@ -40,14 +154,37 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, 
> >  	data->set = set;
> >  	data->private = private;
> > +
> > +	/*
> > +	 * Use custom allocator if available, otherwise use
> > default.
> > +	 * However, if there are active IOASIDs already been
> > allocated by default
> > +	 * allocator, custom allocator cannot be used.
> > +	 */
> > +	if (!default_allocator_used && ioasid_allocator) {
> > +		mutex_lock(&ioasid_allocator_lock);
> > +		id = ioasid_allocator->alloc(min, max,
> > ioasid_allocator->pdata);
> > +		mutex_unlock(&ioasid_allocator_lock);
> > +		if (id == INVALID_IOASID) {
> > +			pr_err("Failed ASID allocation by custom
> > allocator\n");
> > +			goto exit_free;
> > +		}
> > +		/*
> > +		 * Use XA to manage private data also sanitiy
> > check custom> +		 * allocator for duplicates.  
> s/data also sanitiy check/data, also sanity check
> > +		 */
> > +		min = id;
> > +		max = id + 1;
> > +	} else
> > +		default_allocator_used = 1;  
> shouldn't default_allocator_used be protected as well?
> > +
> >  	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max),
> > GFP_KERNEL)) { pr_err("Failed to alloc ioasid from %d to %d\n",
> > min, max); goto exit_free;
> >  	}
> > -
> >  	data->id = id;  
> wouldn't it be possible to integrate the default io asid allocator as
> any custom allocator, ie. implement an alloc callback using xa_alloc.
> Then the active io allocator could be either a custom or a default
> one.
That is an interesting idea. I think it is possible.
But since default xa allocator is internal to ioasid infrastructure,
why implement it as a callback?

> > +
> >  exit_free:
> > -	if (id < 0) {
> > +	if (id < 0 || id == INVALID_IOASID) {
> >  		kfree(data);
> >  		return INVALID_IOASID;
> >  	}
> > @@ -59,12 +196,29 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
> >   * ioasid_free - Free an IOASID
> >   * @ioasid: the ID to remove
> >   */
> > -void ioasid_free(ioasid_t ioasid)
> > +int ioasid_free(ioasid_t ioasid)
> >  {
> >  	struct ioasid_data *ioasid_data;
> > +	int ret = 0;
> > +
> > +	if (ioasid_allocator) {
> > +		mutex_lock(&ioasid_allocator_lock);
> > +		ret = ioasid_allocator->free(ioasid,
> > ioasid_allocator->pdata);
> > +		mutex_unlock(&ioasid_allocator_lock);
> > +	}
> > +	if (ret) {
> > +		pr_err("ioasid %d custom allocator free failed\n",
> > ioasid);
> > +		return ret;
> > +	}
> >  
> >  	ioasid_data = xa_erase(&ioasid_xa, ioasid);
> > +
> >  	kfree_rcu(ioasid_data, rcu);
> > +
> > +	if (xa_empty(&ioasid_xa))
> > +		default_allocator_used = 0;
> > +
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> > @@ -79,7 +233,8 @@ EXPORT_SYMBOL_GPL(ioasid_free);
> >   * if @getter returns false, then the object is invalid and NULL
> > is returned. *
> >   * If the IOASID has been allocated for this set, return the
> > private pointer
> > - * passed to ioasid_alloc. Otherwise return NULL.
> > + * passed to ioasid_alloc. Private data can be NULL if not set.
> > Return an error
> > + * if the IOASID is not found or not belong to the set.  
> s/not belong/does not belong
> >   */
> >  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> >  		  bool (*getter)(void *))
> > @@ -89,11 +244,20 @@ void *ioasid_find(struct ioasid_set *set,
> > ioasid_t ioasid, 
> >  	rcu_read_lock();
> >  	ioasid_data = xa_load(&ioasid_xa, ioasid);
> > -	if (ioasid_data && ioasid_data->set == set) {
> > -		priv = ioasid_data->private;
> > -		if (getter && !getter(priv))
> > -			priv = NULL;
> > +	if (!ioasid_data) {
> > +		priv = ERR_PTR(-ENOENT);
> > +		goto unlock;
> > +	}
> > +	if (set && ioasid_data->set != set) {
> > +		/* data found but does not belong to the set */
> > +		priv = ERR_PTR(-EACCES);
> > +		goto unlock;
> >  	}
> > +	/* Now IOASID and its set is verified, we can return the
> > private data */
> > +	priv = ioasid_data->private;
> > +	if (getter && !getter(priv))
> > +		priv = NULL;
> > +unlock:
> >  	rcu_read_unlock();
> >  
> >  	return priv;
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 6f3655a..e773c13 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -5,20 +5,33 @@
> >  #define INVALID_IOASID ((ioasid_t)-1)
> >  typedef unsigned int ioasid_t;
> >  typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void
> > *data); +typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min,
> > ioasid_t max, void *data); +typedef int
> > (*ioasid_free_fn_t)(ioasid_t ioasid, void *data); 
> >  struct ioasid_set {
> >  	int dummy;
> >  };
> >  
> > +struct ioasid_allocator {
> > +	ioasid_alloc_fn_t alloc;
> > +	ioasid_free_fn_t free;
> > +	void *pdata;
> > +	struct list_head list;
> > +};
> > +
> >  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> >  
> >  #ifdef CONFIG_IOASID
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private);
> > -void ioasid_free(ioasid_t ioasid);
> > +int ioasid_free(ioasid_t ioasid);  
> you need to change the definition for the !CONFIG_IOASID case too
Good catch! I am thinking there is no need to check return value of
free (as you pointed out in other comments).

> >  
> >  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> >  		  bool (*getter)(void *));
> > +int ioasid_register_allocator(struct ioasid_allocator *allocator);
> > +void ioasid_unregister_allocator(struct ioasid_allocator
> > *allocator); +
> > +int ioasid_set_data(ioasid_t ioasid, void *data);
> >  
> >  #else /* !CONFIG_IOASID */
> >  static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min,  
> Just to make sure, don't you need to define the new functions if
> !CONFIG_IOASID?
> 
Right, Thanks!

> Thanks
> 
> Eric
> >   

[Jacob Pan]
