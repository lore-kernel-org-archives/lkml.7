Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DY5g4kf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfCHSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:03:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13706 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHSDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:03:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c82ae5e0000>; Fri, 08 Mar 2019 10:03:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Mar 2019 10:03:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Mar 2019 10:03:19 -0800
Received: from nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Mar
 2019 18:03:19 +0000
Date:   Fri, 8 Mar 2019 10:03:18 -0800
From:   Neo Jia <cjia@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, <ashok.raj@intel.com>,
        <sanjay.k.kumar@intel.com>, <jacob.jun.pan@intel.com>,
        <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <peterx@redhat.com>,
        <tiwei.bie@intel.com>, <xin.zeng@intel.com>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
Message-ID: <20190308180317.GA30821@nvidia.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-10-baolu.lu@linux.intel.com>
 <20190307084453.GA9288@nvidia.com>
 <20190307165623.1834cc93@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190307165623.1834cc93@w520.home>
X-NVConfidentiality: public
User-Agent: Mutt/1.6.2 (2016-07-01)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552068190; bh=fFrFN8XvDs31Sgdig4becaBwRkGdQLI18taXp+sytUY=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=DY5g4kf3975d/ppbRlSi9wRtoOzwG0pB6gpqV76vnOTQyQ2OjHO34txOAVNmz1eBA
         MdScblYqFdqFksSH0u3ip5+S+OnIYdv/7FuSHAnFc8TpENuTovvwLEG7SS5m3KmT5a
         IHdBH1F7ywm1mDkXqN0mjbfFX4D5CyGpgPRGpJtF9VzsdiDCF8uWN5i/vbVbPV3sId
         htlf6JLDy9xvnM+yGoTljZzhsYeuqTzDaVpVNBr0wiD3DogbXq89PZksz6a5kdneJp
         3QzK0oO+9WYC1832dO7JvM9U5/a5+bBPgiTkNf1W3bTiYo16SqYvQJmbRrPrXRO13V
         u6y1sOyVHSN8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:56:23PM -0700, Alex Williamson wrote:
> On Thu, 7 Mar 2019 00:44:54 -0800
> Neo Jia <cjia@nvidia.com> wrote:
> 
> > On Fri, Feb 22, 2019 at 10:19:27AM +0800, Lu Baolu wrote:
> > > This adds the support to determine the isolation type
> > > of a mediated device group by checking whether it has
> > > an iommu device. If an iommu device exists, an iommu
> > > domain will be allocated and then attached to the iommu
> > > device. Otherwise, keep the same behavior as it is.
> > > 
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
> > >  1 file changed, 41 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > > index ccc4165474aa..f1392c582a3c 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
> > >  		iommu_detach_group(domain->domain, group->iommu_group);
> > >  }
> > >    
> > 
> > Hi Baolu,
> > 
> > To allow IOMMU-awared mdev, I think you need to modify the
> > vfio_iommu_type1_pin_pages and vfio_iommu_type1_unpin_pages to remove the
> > iommu->external_domain check.
> > 
> > Could you please include that in your patch? If not, I can send out a separate
> > patch to address that issue.
> 
> I figured it was intentional that an IOMMU backed mdev would not use
> the pin/unpin interface and therefore the exiting -EINVAL returns would
> be correct.  Can you elaborate on the use case for still requiring the
> mdev pin/unpin interface for these devices?  Thanks,

Sure. We are using this api to fetch a pfn of a guest physical address so we can
access it for PV.

Thanks,
Neo

> 
> Alex
