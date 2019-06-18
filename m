Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0283F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfFRRB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:01:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:31480 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfFRRB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:01:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 10:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="334915185"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2019 10:01:56 -0700
Date:   Tue, 18 Jun 2019 10:05:08 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
Message-ID: <20190618100508.7835780f@jacob-builder>
In-Reply-To: <13e19d8c-8918-a3bb-f398-2ac41c71d307@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
        <20190610184714.6786-2-jean-philippe.brucker@arm.com>
        <20190611103625.00001399@huawei.com>
        <62d1f310-0cba-4d55-0f16-68bba3c64927@arm.com>
        <20190611111333.425ce809@jacob-builder>
        <13e19d8c-8918-a3bb-f398-2ac41c71d307@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:22:20 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 11/06/2019 19:13, Jacob Pan wrote:
> >>>> +/**
> >>>> + * ioasid_find - Find IOASID data
> >>>> + * @set: the IOASID set
> >>>> + * @ioasid: the IOASID to find
> >>>> + * @getter: function to call on the found object
> >>>> + *
> >>>> + * The optional getter function allows to take a reference to
> >>>> the found object
> >>>> + * under the rcu lock. The function can also check if the object
> >>>> is still valid:
> >>>> + * if @getter returns false, then the object is invalid and NULL
> >>>> is returned.
> >>>> + *
> >>>> + * If the IOASID has been allocated for this set, return the
> >>>> private pointer
> >>>> + * passed to ioasid_alloc. Private data can be NULL if not set.
> >>>> Return an error
> >>>> + * if the IOASID is not found or does not belong to the set.    
> >>>
> >>> Perhaps should make it clear that @set can be null.    
> >>
> >> Indeed. But I'm not sure allowing @set to be NULL is such a good
> >> idea, because the data type associated to an ioasid depends on its
> >> set. For example SVA will put an mm_struct in there, and auxiliary
> >> domains use some structure private to the IOMMU domain.
> >>  
> > I am not sure we need to count on @set to decipher data type.
> > Whoever does the allocation and owns the IOASID should knows its
> > own data type. My thought was that @set is only used to group IDs,
> > permission check etc.
> >   
> >> Jacob, could me make @set mandatory, or do you see a use for a
> >> global search? If @set is NULL, then callers can check if the
> >> return pointer is NULL, but will run into trouble if they try to
> >> dereference it. 
> > A global search use case can be for PRQ. IOMMU driver gets a IOASID
> > (first interrupt then retrieve from a queue), it has no idea which
> > @set it belongs to. But the data types are the same for all IOASIDs
> > used by the IOMMU.  
> 
> They aren't when we use a generic SVA handler. Following a call to
> iommu_sva_bind_device(), iommu-sva.c allocates an IOASID and store an
> mm_struct. If auxiliary domains are also enabled for the device,
> following a call to iommu_aux_attach_device() the IOMMU driver
> allocates an IOASID and stores some private object.
> 
> Now for example the IOMMU driver receives a PPR and calls
> ioasid_find() with @set = NULL. ioasid_find() may return either an
> mm_struct or a private object, and the driver cannot know which it is
> so the returned value is unusable.
I think we might have a misunderstanding of what ioasid_set is. Or i
have misused your original intention for it:) So my understanding of an
ioasid_set is to identify a sub set of IOASIDs that
1. shares the same data type
2. belongs to the same permission group, owner.

Our usage is #2., we put a mm_struct as the set to do permission
check. E.g VFIO can check guest PASID ownership based on QEMU process
mm. This will make sure IOASID allocated by one guest can only be used
by the same guest.

For IOASID used for sva bind, let it be native or guest sva, we always
have the same data type. Therefore, when page request handler gets
called to search with ioasid_find(), it knows its data type. An
additional flag will tell if it is a guest bind or native bind.

I was under the assumption that aux domain and its IOASID is a 1:1
mapping, there is no need for a search. Or even it needs to search, it
will be searched by the same caller that did the allocation, therefore
it knows what private data type is.

In addition, aux domain is used for request w/o PASID. And PPR for
request w/o PASID is not to be supported. So there would not be a need
to search from page request handler.

Now if we take the above assumption away, and use ioasid_set strictly
to differentiate the data types (Usage #1). Then I agree we can get
rid of NULL set and global search.

That would require we converge on the generic sva_bind for both
native and guest. The additional implication is that VFIO layer has to
be SVA struct aware in order to sanitize the mm_struct for guest bind.
i.e. check guest ownership by using QEMU process mm. Whereas we have
today, VFIO just use IOASID set as mm to check ownership, no need to
know the type.

Can we keep the NULL set for now and remove it __after__ we converge on
the sva bind flows?

Thanks,

Jacob
