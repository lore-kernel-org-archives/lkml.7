Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1948E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfEWPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:37:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:65249 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfEWPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:37:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 08:37:21 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2019 08:37:21 -0700
Date:   Thu, 23 May 2019 08:40:19 -0700
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
Subject: Re: [PATCH v3 04/16] ioasid: Add custom IOASID allocator
Message-ID: <20190523084019.7f940aa5@jacob-builder>
In-Reply-To: <a33797e9-d34b-b0a9-4f39-700dce8252b3@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556922737-76313-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <c991ff0c-87bf-574a-bf31-9b37f0421385@redhat.com>
        <20190522124255.117de6f6@jacob-builder>
        <a33797e9-d34b-b0a9-4f39-700dce8252b3@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 09:14:07 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 5/22/19 9:42 PM, Jacob Pan wrote:
> > On Tue, 21 May 2019 11:55:55 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 5/4/19 12:32 AM, Jacob Pan wrote:  
> >>> Sometimes, IOASID allocation must be handled by platform specific
> >>> code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs
> >>> need to be allocated by the host via enlightened or paravirt
> >>> interfaces.
> >>>
> >>> This patch adds an extension to the IOASID allocator APIs such
> >>> that platform drivers can register a custom allocator, possibly
> >>> at boot time, to take over the allocation. Xarray is still used
> >>> for tracking and searching purposes internal to the IOASID code.
> >>> Private data of an IOASID can also be set after the allocation.
> >>>
> >>> There can be multiple custom allocators registered but only one is
> >>> used at a time. In case of hot removal of devices that provides
> >>> the allocator, all IOASIDs must be freed prior to unregistering
> >>> the allocator. Default XArray based allocator cannot be mixed with
> >>> custom allocators, i.e. custom allocators will not be used if
> >>> there are outstanding IOASIDs allocated by the default XA
> >>> allocator.
> >>>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/ioasid.c | 125
> >>> +++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed,
> >>> 125 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> >>> index 99f5e0a..ed2915a 100644
> >>> --- a/drivers/iommu/ioasid.c
> >>> +++ b/drivers/iommu/ioasid.c
> >>> @@ -17,6 +17,100 @@ struct ioasid_data {
> >>>  };
> >>>  
> >>>  static DEFINE_XARRAY_ALLOC(ioasid_xa);
> >>> +static DEFINE_MUTEX(ioasid_allocator_lock);
> >>> +static struct ioasid_allocator *active_custom_allocator;
> >>> +
> >>> +static LIST_HEAD(custom_allocators);
> >>> +/*
> >>> + * A flag to track if ioasid default allocator is in use, this
> >>> will
> >>> + * prevent custom allocator from being used. The reason is that
> >>> custom allocator
> >>> + * must have unadulterated space to track private data with
> >>> xarray, there cannot
> >>> + * be a mix been default and custom allocated IOASIDs.
> >>> + */
> >>> +static int default_allocator_active;
> >>> +
> >>> +/**
> >>> + * ioasid_register_allocator - register a custom allocator
> >>> + * @allocator: the custom allocator to be registered
> >>> + *
> >>> + * Custom allocators take precedence over the default xarray
> >>> based allocator.
> >>> + * Private data associated with the ASID are managed by ASID
> >>> common code
> >>> + * similar to data stored in xa.
> >>> + *
> >>> + * There can be multiple allocators registered but only one is
> >>> active. In case
> >>> + * of runtime removal of a custom allocator, the next one is
> >>> activated based
> >>> + * on the registration ordering.
> >>> + */
> >>> +int ioasid_register_allocator(struct ioasid_allocator *allocator)
> >>> +{
> >>> +	struct ioasid_allocator *pallocator;
> >>> +	int ret = 0;
> >>> +
> >>> +	if (!allocator)
> >>> +		return -EINVAL;    
> >> is it really necessary? Sin't it the caller responsibility?  
> > makes sense. will remove this one and below.  
> >>> +
> >>> +	mutex_lock(&ioasid_allocator_lock);
> >>> +	/*
> >>> +	 * No particular preference since all custom allocators
> >>> end up calling
> >>> +	 * the host to allocate IOASIDs. We activate the first
> >>> one and keep
> >>> +	 * the later registered allocators in a list in case the
> >>> first one gets
> >>> +	 * removed due to hotplug.
> >>> +	 */
> >>> +	if (list_empty(&custom_allocators))
> >>> +		active_custom_allocator = allocator;> +
> >>> else {
> >>> +		/* Check if the allocator is already registered
> >>> */
> >>> +		list_for_each_entry(pallocator,
> >>> &custom_allocators, list) {
> >>> +			if (pallocator == allocator) {
> >>> +				pr_err("IOASID allocator already
> >>> registered\n");
> >>> +				ret = -EEXIST;
> >>> +				goto out_unlock;
> >>> +			}
> >>> +		}
> >>> +	}
> >>> +	list_add_tail(&allocator->list, &custom_allocators);
> >>> +
> >>> +out_unlock:
> >>> +	mutex_unlock(&ioasid_allocator_lock);
> >>> +	return ret;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(ioasid_register_allocator);
> >>> +
> >>> +/**
> >>> + * ioasid_unregister_allocator - Remove a custom IOASID allocator
> >>> + * @allocator: the custom allocator to be removed
> >>> + *
> >>> + * Remove an allocator from the list, activate the next allocator
> >>> in
> >>> + * the order it was registered.
> >>> + */
> >>> +void ioasid_unregister_allocator(struct ioasid_allocator
> >>> *allocator) +{
> >>> +	if (!allocator)
> >>> +		return;    
> >> is it really necessary?  
> >>> +
> >>> +	if (list_empty(&custom_allocators)) {
> >>> +		pr_warn("No custom IOASID allocators active!\n");
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	mutex_lock(&ioasid_allocator_lock);
> >>> +	list_del(&allocator->list);
> >>> +	if (list_empty(&custom_allocators)) {
> >>> +		pr_info("No custom IOASID allocators\n")>
> >>> +		/*
> >>> +		 * All IOASIDs should have been freed before the
> >>> last custom
> >>> +		 * allocator is unregistered. Unless default
> >>> allocator is in
> >>> +		 * use.
> >>> +		 */
> >>> +		BUG_ON(!xa_empty(&ioasid_xa)
> >>> && !default_allocator_active);
> >>> +		active_custom_allocator = NULL;
> >>> +	} else if (allocator == active_custom_allocator) {    
> >> In case you are removing the active custom allocator don't you also
> >> need to check that all ioasids were freed. Otherwise you are likely
> >> to switch to a different allocator whereas the asid space is
> >> partially populated.  
> > The assumption is that all custom allocators on the same guest will
> > end up calling the same host allocator. Having multiple custom
> > allocators in the list is just a way to support multiple (p)vIOMMUs
> > with hotplug. Therefore, we cannot nor need to free all PASIDs when
> > one custom allocator goes away. This is a different situation then
> > switching between default allocator and custom allocator, where
> > custom allocator has to start with a clean space.  
> Although I understand your specific usecase, this framework may have
> other users, where custom allocators behave differently.
> 
> Also the commit msg says:"
> In case of hot removal of devices that provides the
> allocator, all IOASIDs must be freed prior to unregistering the
> allocator."
> 
Right, it is inconsistent.
Consider the following scenario on a single guest with two vIOMMUs:
1. vIOMMU1 register allocator A1 first
2. vIOMMU2 register allocator A2 stored to the allocator list
3. device belong to vIOMMU1 bind_sva(), allocate PASID1 from A1
4. device belong to vIOMMU2 bind_sva(), allocate PASID2 from A1
5. vIOMMU1 hot removed, free PASID1, then unregister A1
6. IOASID framework will try to free A1 then install A2 as the active
allocator but PASID2 is in use. It will be unnecessarily disruptive to
free PASID2

I can think of a solution:
 - Add a flag when registering ioasid custom allocator,
IOASID_ALLOC_RETAIN, which means when switching to another custom
allocator, all outstanding PASIDs will be retained. Of course it does
not include switching to default allocator which does not have this
RETAIN flag.

 - For the allocators do not have this flag, their PASIDs must be freed
upon unregistering.

Any thoughts?

Jacob

> Thanks
> 
> Eric
> > 
> >    
> >>> +		active_custom_allocator =
> >>> list_entry(&custom_allocators, struct ioasid_allocator, list);
> >>> +		pr_info("IOASID allocator changed");
> >>> +	}
> >>> +	mutex_unlock(&ioasid_allocator_lock);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
> >>>  
> >>>  /**
> >>>   * ioasid_set_data - Set private data for an allocated ioasid
> >>> @@ -68,6 +162,29 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> >>> ioasid_t min, ioasid_t max, data->set = set;
> >>>  	data->private = private;
> >>>  
> >>> +	mutex_lock(&ioasid_allocator_lock);
> >>> +	/*
> >>> +	 * Use custom allocator if available, otherwise use
> >>> default.
> >>> +	 * However, if there are active IOASIDs already been
> >>> allocated by default
> >>> +	 * allocator, custom allocator cannot be used.
> >>> +	 */
> >>> +	if (!default_allocator_active &&
> >>> active_custom_allocator) {
> >>> +		id = active_custom_allocator->alloc(min, max,
> >>> active_custom_allocator->pdata);
> >>> +		if (id == INVALID_IOASID) {
> >>> +			pr_err("Failed ASID allocation by custom
> >>> allocator\n");
> >>> +			mutex_unlock(&ioasid_allocator_lock);
> >>> +			goto exit_free;
> >>> +		}
> >>> +		/*
> >>> +		 * Use XA to manage private data also sanitiy
> >>> check custom
> >>> +		 * allocator for duplicates.
> >>> +		 */
> >>> +		min = id;
> >>> +		max = id + 1;
> >>> +	} else
> >>> +		default_allocator_active = 1;    
> >> nit: true?  
> > yes, i can turn default_allocator_active into a bool type.
> >   
> >>> +	mutex_unlock(&ioasid_allocator_lock);
> >>> +
> >>>  	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max),
> >>> GFP_KERNEL)) { pr_err("Failed to alloc ioasid from %d to %d\n",
> >>> min, max); goto exit_free;> @@ -91,9 +208,17 @@ void
> >>> ioasid_free(ioasid_t ioasid) {
> >>>  	struct ioasid_data *ioasid_data;
> >>>  
> >>> +	mutex_lock(&ioasid_allocator_lock);
> >>> +	if (active_custom_allocator)
> >>> +		active_custom_allocator->free(ioasid,
> >>> active_custom_allocator->pdata);
> >>> +	mutex_unlock(&ioasid_allocator_lock);
> >>> +
> >>>  	ioasid_data = xa_erase(&ioasid_xa, ioasid);
> >>>  
> >>>  	kfree_rcu(ioasid_data, rcu);
> >>> +
> >>> +	if (xa_empty(&ioasid_xa))
> >>> +		default_allocator_active = 0;    
> >> Isn't it racy? what if an xa_alloc occurs inbetween?
> >>
> >>  
> > yes, i will move it under the mutex. Thanks.  
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(ioasid_free);
> >>>  
> >>>     
> >>
> >> Thanks
> >>
> >> Eric  
> > 
> > [Jacob Pan]
> >   

[Jacob Pan]
