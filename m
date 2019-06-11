Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C09AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7005521734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406890AbfFKSKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:10:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:44341 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406685AbfFKSKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:10:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 11:10:25 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2019 11:10:25 -0700
Date:   Tue, 11 Jun 2019 11:13:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
Message-ID: <20190611111333.425ce809@jacob-builder>
In-Reply-To: <62d1f310-0cba-4d55-0f16-68bba3c64927@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
        <20190610184714.6786-2-jean-philippe.brucker@arm.com>
        <20190611103625.00001399@huawei.com>
        <62d1f310-0cba-4d55-0f16-68bba3c64927@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 15:35:22 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 11/06/2019 10:36, Jonathan Cameron wrote:
> >> +/**
> >> + * ioasid_alloc - Allocate an IOASID
> >> + * @set: the IOASID set
> >> + * @min: the minimum ID (inclusive)
> >> + * @max: the maximum ID (inclusive)
> >> + * @private: data private to the caller
> >> + *
> >> + * Allocate an ID between @min and @max. The @private pointer is
> >> stored
> >> + * internally and can be retrieved with ioasid_find().
> >> + *
> >> + * Return: the allocated ID on success, or %INVALID_IOASID on
> >> failure.
> >> + */
> >> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> >> ioasid_t max,
> >> +		      void *private)
> >> +{
> >> +	u32 id = INVALID_IOASID;
> >> +	struct ioasid_data *data;
> >> +
> >> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >> +	if (!data)
> >> +		return INVALID_IOASID;
> >> +
> >> +	data->set = set;
> >> +	data->private = private;
> >> +
> >> +	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max),
> >> GFP_KERNEL)) {
> >> +		pr_err("Failed to alloc ioasid from %d to %d\n",
> >> min, max);
> >> +		goto exit_free;
> >> +	}
> >> +	data->id = id;
> >> +
> >> +exit_free:  
> > 
> > This error flow is perhaps a little more confusing than it needs to
> > be?
> > 
> > My assumption (perhaps wrong) is that we only have an id ==
> > INVALID_IOASID if the xa_alloc fails, and that we will always have
> > such an id value if it does (I'm not totally sure this second
> > element is true in __xa_alloc).
> > 
> > If I'm missing something perhaps a comment on how else we'd get
> > here.  
> 
> Yes we can simplify this:
> 
> 		return id;
> 	exit_free:
> 		kfree(data)
> 		return INVALID_IOASID;
> 	}
> 
> The XA API doesn't say that @id passed to xa_alloc() won't be modified
> in case of error. It's true in the current implementation, but won't
> necessarily stay that way. On the other hand I think it's safe to
> expect @id to always be set when xa_alloc() succeeds.
> 
the flow with custom allocator is slightly different, but you are right
I can simplify it as you suggested.
Jonathan, I will add you to the cc list in next version. If you could
also review the current version, it would be greatly appreciated.

https://lore.kernel.org/lkml/1560087862-57608-13-git-send-email-jacob.jun.pan@linux.intel.com/

> >> +/**
> >> + * ioasid_find - Find IOASID data
> >> + * @set: the IOASID set
> >> + * @ioasid: the IOASID to find
> >> + * @getter: function to call on the found object
> >> + *
> >> + * The optional getter function allows to take a reference to the
> >> found object
> >> + * under the rcu lock. The function can also check if the object
> >> is still valid:
> >> + * if @getter returns false, then the object is invalid and NULL
> >> is returned.
> >> + *
> >> + * If the IOASID has been allocated for this set, return the
> >> private pointer
> >> + * passed to ioasid_alloc. Private data can be NULL if not set.
> >> Return an error
> >> + * if the IOASID is not found or does not belong to the set.  
> > 
> > Perhaps should make it clear that @set can be null.  
> 
> Indeed. But I'm not sure allowing @set to be NULL is such a good idea,
> because the data type associated to an ioasid depends on its set. For
> example SVA will put an mm_struct in there, and auxiliary domains use
> some structure private to the IOMMU domain.
> 
I am not sure we need to count on @set to decipher data type. Whoever
does the allocation and owns the IOASID should knows its own data type.
My thought was that @set is only used to group IDs, permission check
etc.

> Jacob, could me make @set mandatory, or do you see a use for a global
> search? If @set is NULL, then callers can check if the return pointer
> is NULL, but will run into trouble if they try to dereference it.
> 
A global search use case can be for PRQ. IOMMU driver gets a IOASID
(first interrupt then retrieve from a queue), it has no idea which
@set it belongs to. But the data types are the same for all IOASIDs
used by the IOMMU.
If @set is NULL, the search does not check set match. It is separate
from return pointer. Sorry i am not seeing the problems here.

> >   
> >> + */
> >> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> >> +		  bool (*getter)(void *))
> >> +{
> >> +	void *priv = NULL;  
> > 
> > Set in all paths, so does need to be set here.  
> 
> Right
> 
> Thanks,
> Jean

[Jacob Pan]
