Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C57C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6F20640
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CauVxj6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfITQgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:36:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35102 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfITQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:36:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id v8so7100609eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7hzm3K7b35rEliLwtwWMBUwsKHdn+N/LZtz2QhNViq0=;
        b=CauVxj6MR1/RdV5hq7nYFTEiAQ38w+HRge127iXApIBR59r3qh4l0aPcKXW0Sbx/5A
         RTg+s1ZfTru6nN27dI2fp0QIy1jAxhK/pl9MW19Gaug4CV+G1dKXBsgMiTLIA2UVybqO
         UAmb13NlHSnT6mnFVOyne6rvTAbrt7Ej9OoVJFCBomxNr65ASSxT8YU4OTkLkMeT4JCj
         +bJsQXHFF0pcImSMExHzjCEk3x1AHLLm2nsUrmzbOQCK69plnVx/IYiZRHQPC+WVubqz
         Aegc9x+DYxt3BFMK0FyToqmU77UgRPf0rQW8PJc0lYgYLh/2uCixziS2U870hMWTxDnf
         gr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7hzm3K7b35rEliLwtwWMBUwsKHdn+N/LZtz2QhNViq0=;
        b=b+0w2gCnwhLQv1MmOlZrSNn6sBH9F1FmbAX11ZUNoUIuKJmu00vEqd0sRoyvcm1bJV
         tQGGJKOmeil7NzeF3gRHL0awZ3Q/hza2RWJxCOD4nM0Y0T31dEtQ02mjp4pkLi/27iai
         Mlll9YdW8cd1z9jXiJC/NxdNLbkAzg3fAdN9Q3xi41jBFVOek13vk2xtlDVBqPT8lbVc
         LBkJPb/efUAQLfUyOxGBjF0wcBJ/B1TGD8cHIT3LqNb76+5JLRpXndmM6T1jKRtJ3ETL
         0gJXFP/5bq9sHR0/nYttJe5iS1YUZk1kV0EeTuwWl9RYyVPu+QDoc+OY28pVIAZ48+sE
         q7fQ==
X-Gm-Message-State: APjAAAXaGXQmbryRf8mzHCFYCoOV9CrfnqhxcukKKrCT+ua+CNKIY/o+
        PCD0FR8u2sTzmPn/+p7X5klHqg==
X-Google-Smtp-Source: APXvYqzlxtJkxMrObFiFEfMvTttDlFX1Lhn2rxHuQzhFG8RUkiyWTAgaUrjIEHSvAzKzYqD39ju+AQ==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr22835043edr.253.1568997360481;
        Fri, 20 Sep 2019 09:36:00 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id y22sm277918eje.42.2019.09.20.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:35:59 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:35:58 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20190920163558.GC1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1568849194-47874-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568849194-47874-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:26:33PM -0700, Jacob Pan wrote:
> +/*
> + * struct ioasid_allocator_data - Internal data structure to hold information
> + * about an allocator. There are two types of allocators:
> + *
> + * - Default allocator always has its own XArray to track the IOASIDs allocated.
> + * - Custom allocators may share allocation helpers with different private data.
> + *   Custom allocators share the same helper functions also share the same
> + *   XArray.

"that share the same helper"

> + * Rules:
> + * 1. Default allocator is always available, not dynamically registered. This is
> + *    to prevent race conditions with early boot code that want to register
> + *    custom allocators or allocate IOASIDs.
> + * 2. Custom allocators take precedence over the default allocator.
> + * 3. When all custom allocators sharing the same helper functions are
> + *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
> + *    freed.
> + * 4. When switching between custom allocators sharing the same helper
> + *    functions, outstanding IOASIDs are preserved.
> + * 5. When switching between custom allocator and default allocator, all IOASIDs
> + *    must be freed to ensure unadulterated space for the new allocator.
> + *
> + * @ops:	allocator helper functions and its data
> + * @list:	registered custom allocators
> + * @slist:	allocators share the same ops but different data
> + * @flags:	attributes of the allocator
> + * @xa		xarray holds the IOASID space
> + * @users	number of allocators sharing the same ops and XArray
> + */
> +struct ioasid_allocator_data {
> +	struct ioasid_allocator_ops *ops;
> +	struct list_head list;
> +	struct list_head slist;
> +#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
> +	unsigned long flags;
> +	struct xarray xa;
> +	refcount_t users;
> +};
> +
> +static DEFINE_SPINLOCK(ioasid_allocator_lock);

Thanks for making this a spinlock! I hit that sleep-in-atomic problem
while updating iommu-sva to the new MMU notifier API, which doesn't
allow sleeping in the free() callback.

I don't like having to use GFP_ATOMIC everywhere as a result, but can't
see a better way. Maybe we can improve that later.

[...]
> +/**
> + * ioasid_unregister_allocator - Remove a custom IOASID allocator ops
> + * @ops: the custom allocator to be removed
> + *
> + * Remove an allocator from the list, activate the next allocator in
> + * the order it was registered. Or revert to default allocator if all
> + * custom allocators are unregistered without outstanding IOASIDs.
> + */
> +void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
> +{
> +	struct ioasid_allocator_data *pallocator;
> +	struct ioasid_allocator_ops *sops;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	if (list_empty(&allocators_list)) {
> +		pr_warn("No custom IOASID allocators active!\n");
> +		goto exit_unlock;
> +	}
> +
> +	list_for_each_entry(pallocator, &allocators_list, list) {
> +		if (!use_same_ops(pallocator->ops, ops))
> +			continue;
> +
> +		if (refcount_read(&pallocator->users) == 1) {
> +			/* No shared helper functions */
> +			list_del(&pallocator->list);
> +			/*
> +			 * All IOASIDs should have been freed before
> +			 * the last allocator that shares the same ops
> +			 * is unregistered.
> +			 */
> +			WARN_ON(!xa_empty(&pallocator->xa));

The function doc seems to say that we revert to the default allocator
only if there wasn't any outstanding IOASID, which isn't what this does.
To follow the doc, we'd need to return here instead of continuing. The
best solution would be to return with an error, but since we don't
propagate errors I think leaking stuff is preferable to leaving the
allocator registered, since the caller might free the ops when this
function return. So I would keep the code like that but change the
function's comment. What do you think is best?

> +			kfree(pallocator);
> +			if (list_empty(&allocators_list)) {
> +				pr_info("No custom IOASID allocators, switch to default.\n");
> +				active_allocator = &default_allocator;

I'm concerned about the active_allocator variable, because ioasid_find()
accesses it without holding ioasid_allocator_lock. It is holding the RCU
read lock, so I think we need to free pallocator after a RCU grace
period (using kfree_rcu)? I think we also need to update
active_allocator with rcu_assign_pointer() and dereference it with
rcu_dereference()

> +			} else if (pallocator == active_allocator) {
> +				active_allocator = list_first_entry(&allocators_list, struct ioasid_allocator_data, list);
> +				pr_info("IOASID allocator changed");
> +			}
> +			break;
> +		}
> +		/*
> +		 * Find the matching shared ops to delete,
> +		 * but keep outstanding IOASIDs
> +		 */
> +		list_for_each_entry(sops, &pallocator->slist, list) {
> +			if (sops == ops) {
> +				list_del(&ops->list);
> +				if (refcount_dec_and_test(&pallocator->users))
> +					pr_err("no shared ops\n");

That's not possible, right, since dec_and_test only returns true if
pallocator->users was 1, which we already checked against? I find
pallocator->users a bit redundant since you can use list_is_empty() or
list_is_singular() on pallocator->slist

[...]
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private)
>  {
> -	ioasid_t id;
>  	struct ioasid_data *data;
> +	void *adata;
> +	ioasid_t id;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -76,14 +324,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  	data->set = set;
>  	data->private = private;
>  
> -	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
> -		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
> +	/*
> +	 * Custom allocator needs allocator data to perform platform specific
> +	 * operations.
> +	 */
> +	spin_lock(&ioasid_allocator_lock);
> +	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
> +	id = active_allocator->ops->alloc(min, max, adata);
> +	if (id == INVALID_IOASID) {
> +		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
>  		goto exit_free;
>  	}
> +
> +	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> +		/* Custom allocator needs framework to store and track allocation results */
> +		min = max = id;
> +
> +		if (xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {

Or just XA_LIMIT(id, id), and merge the two ifs?

You do need GFP_ATOMIC here.

> +			pr_err("Failed to alloc ioasid from %d to %d\n", min, max);

Maybe just "Failed to alloc ioasid %d\n" then

> +			active_allocator->ops->free(id, NULL);

Why doesn't this call need to pass active_allocator->ops->pdata like the
one in ioasid_free()?

Thanks,
Jean
