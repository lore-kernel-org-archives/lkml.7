Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC568C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC6D2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568037862;
	bh=BceXqHBVAXO0SzdF8rTWqk9w5ctjbmxf4pw3jTBHQxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LGidZNRusALR4kkLQ3p14gMrK4KPsGV6TqvFC69r5W56b7Vj7E61EKySGdMCz7YIS
	 FW0HJKmU2qzGrmCu7+Q5p0CdH48vl6ByOOHpmRZr8p/5s0sumvYqSSNzXk9zLAGHRv
	 MhBGKBdr5Y82j282I7ETuloohCfwR8O2BzG2GIp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405141AbfIIOEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404997AbfIIOEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:04:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA0121924;
        Mon,  9 Sep 2019 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568037861;
        bh=BceXqHBVAXO0SzdF8rTWqk9w5ctjbmxf4pw3jTBHQxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y6wNq/EwRmggE4exMTqn9Sn14AIYiMuQxdJQ+5B6cgNVIHbomUOBQUwlo4hA6w6P5
         0uWyZboY2zCJ2Wq9XFAJLtSe2oyqHuAlwOLNa0ijdygIdPHq61SI0fHQ+bfttjJbIt
         f/neASzyNQKDqnEkxbmK8L67avoAN5oqG+YLMUeY=
Date:   Mon, 9 Sep 2019 15:04:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
Message-ID: <20190909140415.axszldhakgqifibg@willie-the-truck>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-2-thierry.reding@gmail.com>
 <0b7e050a-cec6-6ce7-9ed6-2146eabb2fe8@arm.com>
 <20190902150056.GD1445@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902150056.GD1445@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 05:00:56PM +0200, Thierry Reding wrote:
> On Mon, Sep 02, 2019 at 02:54:23PM +0100, Robin Murphy wrote:
> > On 29/08/2019 12:14, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > This is an implementation that IOMMU drivers can use to obtain reserved
> > > memory regions from a device tree node. It uses the reserved-memory DT
> > > bindings to find the regions associated with a given device. These
> > > regions will be used to create 1:1 mappings in the IOMMU domain that
> > > the devices will be attached to.
> > > 
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >   drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >   include/linux/of_iommu.h |  8 ++++++++
> > >   2 files changed, 47 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > > index 614a93aa5305..0d47f626b854 100644
> > > --- a/drivers/iommu/of_iommu.c
> > > +++ b/drivers/iommu/of_iommu.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/iommu.h>
> > >   #include <linux/limits.h>
> > >   #include <linux/of.h>
> > > +#include <linux/of_address.h>
> > >   #include <linux/of_iommu.h>
> > >   #include <linux/of_pci.h>
> > >   #include <linux/slab.h>
> > > @@ -225,3 +226,41 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> > >   	return ops;
> > >   }
> > > +
> > > +/**
> > > + * of_iommu_get_resv_regions - reserved region driver helper for device tree
> > > + * @dev: device for which to get reserved regions
> > > + * @list: reserved region list
> > > + *
> > > + * IOMMU drivers can use this to implement their .get_resv_regions() callback
> > > + * for memory regions attached to a device tree node. See the reserved-memory
> > > + * device tree bindings on how to use these:
> > > + *
> > > + *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > + */
> > > +void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
> > > +{
> > > +	struct of_phandle_iterator it;
> > > +	int err;
> > > +
> > > +	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
> > > +		struct iommu_resv_region *region;
> > > +		struct resource res;
> > > +
> > > +		err = of_address_to_resource(it.node, 0, &res);
> > > +		if (err < 0) {
> > > +			dev_err(dev, "failed to parse memory region %pOF: %d\n",
> > > +				it.node, err);
> > > +			continue;
> > > +		}
> > 
> > What if the device node has memory regions for other purposes, like private
> > CMA carveouts? We wouldn't want to force mappings of those (and in the very
> > worst case doing so could even render them unusable).
> 
> I suppose we could come up with additional properties to mark such
> memory regions and skip them here.

I think we need /something/ like that, both so that we can identify these
memory regions as requiring an identity mapping in the SMMU but also so
that we can place additional requirements on them, such as being 64k-aligned
and mandating properties of the mapping, such as cacheability based on the
device coherency.

I defer to the devicetree folks as to whether this should be an additional
property, or a phandle or whatever.

Will
