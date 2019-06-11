Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058AD2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbfFKJgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:36:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404137AbfFKJgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:36:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E1052B1E12D93060B1E;
        Tue, 11 Jun 2019 17:36:40 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 17:36:35 +0800
Date:   Tue, 11 Jun 2019 10:36:25 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <robh+dt@kernel.org>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
Message-ID: <20190611103625.00001399@huawei.com>
In-Reply-To: <20190610184714.6786-2-jean-philippe.brucker@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
        <20190610184714.6786-2-jean-philippe.brucker@arm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 19:47:07 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator is primarily used by IOMMU subsystem but in rare occasions
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Hi,

A few trivial comments inline.  May be more because I'm not that familiar
with xa_array than anything else.

Jonathan

> ---
> The most recent discussion on this patch was at:
> https://lkml.kernel.org/lkml/1556922737-76313-4-git-send-email-jacob.jun.pan@linux.intel.com/
> I fixed it up a bit following comments in that series, and removed the
> definitions for the custom allocator for now.
> 
> There also is a new version that includes the custom allocator into this
> patch, but is currently missing the RCU fixes, at:
> https://lore.kernel.org/lkml/1560087862-57608-13-git-send-email-jacob.jun.pan@linux.intel.com/
> ---

...

> +
> +/**
> + * ioasid_alloc - Allocate an IOASID
> + * @set: the IOASID set
> + * @min: the minimum ID (inclusive)
> + * @max: the maximum ID (inclusive)
> + * @private: data private to the caller
> + *
> + * Allocate an ID between @min and @max. The @private pointer is stored
> + * internally and can be retrieved with ioasid_find().
> + *
> + * Return: the allocated ID on success, or %INVALID_IOASID on failure.
> + */
> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> +		      void *private)
> +{
> +	u32 id = INVALID_IOASID;
> +	struct ioasid_data *data;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return INVALID_IOASID;
> +
> +	data->set = set;
> +	data->private = private;
> +
> +	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
> +		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
> +		goto exit_free;
> +	}
> +	data->id = id;
> +
> +exit_free:

This error flow is perhaps a little more confusing than it needs to be?

My assumption (perhaps wrong) is that we only have an id == INVALID_IOASID
if the xa_alloc fails, and that we will always have such an id value if
it does (I'm not totally sure this second element is true in __xa_alloc).

If I'm missing something perhaps a comment on how else we'd get here.

> +	if (id == INVALID_IOASID) {
> +		kfree(data);
> +		return INVALID_IOASID;
> +	}
> +	return id;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc);
> +
> +/**
> + * ioasid_free - Free an IOASID
> + * @ioasid: the ID to remove
> + */
> +void ioasid_free(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	ioasid_data = xa_erase(&ioasid_xa, ioasid);
> +
> +	kfree_rcu(ioasid_data, rcu);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free);
> +
> +/**
> + * ioasid_find - Find IOASID data
> + * @set: the IOASID set
> + * @ioasid: the IOASID to find
> + * @getter: function to call on the found object
> + *
> + * The optional getter function allows to take a reference to the found object
> + * under the rcu lock. The function can also check if the object is still valid:
> + * if @getter returns false, then the object is invalid and NULL is returned.
> + *
> + * If the IOASID has been allocated for this set, return the private pointer
> + * passed to ioasid_alloc. Private data can be NULL if not set. Return an error
> + * if the IOASID is not found or does not belong to the set.

Perhaps should make it clear that @set can be null.

> + */
> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> +		  bool (*getter)(void *))
> +{
> +	void *priv = NULL;

Set in all paths, so does need to be set here.

> +	struct ioasid_data *ioasid_data;
> +
> +	rcu_read_lock();
> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
> +	if (!ioasid_data) {
> +		priv = ERR_PTR(-ENOENT);
> +		goto unlock;
> +	}
> +	if (set && ioasid_data->set != set) {
> +		/* data found but does not belong to the set */
> +		priv = ERR_PTR(-EACCES);
> +		goto unlock;
> +	}
> +	/* Now IOASID and its set is verified, we can return the private data */
> +	priv = rcu_dereference(ioasid_data->private);
> +	if (getter && !getter(priv))
> +		priv = NULL;
> +unlock:
> +	rcu_read_unlock();
> +
> +	return priv;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find);
> +
> +MODULE_LICENSE("GPL");
...

