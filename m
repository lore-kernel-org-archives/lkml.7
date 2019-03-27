Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FDEC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7543C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbfC0SQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389751AbfC0SQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 907133087BCC;
        Wed, 27 Mar 2019 18:16:27 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFBFE82B84;
        Wed, 27 Mar 2019 18:16:25 +0000 (UTC)
Date:   Wed, 27 Mar 2019 12:16:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "xin.zeng@intel.com" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in
 mdev_device
Message-ID: <20190327121625.4a8db805@x1.home>
In-Reply-To: <VI1PR0501MB2271172964AFA3CDD6F1B02CD1580@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
        <20190325013036.18400-8-baolu.lu@linux.intel.com>
        <b45dabe5-04ef-0e05-db25-c8edf111e355@nvidia.com>
        <VI1PR0501MB2271172964AFA3CDD6F1B02CD1580@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Mar 2019 18:16:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 14:17:57 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-  
> > owner@vger.kernel.org> On Behalf Of Kirti Wankhede  
> > Sent: Tuesday, March 26, 2019 4:33 AM
> > To: Lu Baolu <baolu.lu@linux.intel.com>; Joerg Roedel <joro@8bytes.org>;
> > David Woodhouse <dwmw2@infradead.org>; Alex Williamson
> > <alex.williamson@redhat.com>
> > Cc: ashok.raj@intel.com; sanjay.k.kumar@intel.com;
> > jacob.jun.pan@intel.com; kevin.tian@intel.com; Jean-Philippe Brucker <jean-  
> > philippe.brucker@arm.com>; yi.l.liu@intel.com; yi.y.sun@intel.com;  
> > peterx@redhat.com; tiwei.bie@intel.com; xin.zeng@intel.com;
> > iommu@lists.linux-foundation.org; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Jacob Pan <jacob.jun.pan@linux.intel.com>; Neo Jia
> > <cjia@nvidia.com>
> > Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in
> > mdev_device
> > 
> > 
> > 
> > On 3/25/2019 7:00 AM, Lu Baolu wrote:  
> > > A parent device might create different types of mediated devices. For
> > > example, a mediated device could be created by the parent device with
> > > full isolation and protection provided by the IOMMU. One usage case
> > > could be found on Intel platforms where a mediated device is an
> > > assignable subset of a PCI, the DMA requests on behalf of it are all
> > > tagged with a PASID. Since IOMMU supports PASID-granular translations
> > > (scalable mode in VT-d 3.0), this mediated device could be
> > > individually protected and isolated by an IOMMU.
> > >
> > > This patch adds a new member in the struct mdev_device to indicate
> > > that the mediated device represented by mdev could be isolated and
> > > protected by attaching a domain to a device represented by
> > > mdev->iommu_device. It also adds a helper to add or set the iommu
> > > device.
> > >
> > > * mdev_device->iommu_device
> > >   - This, if set, indicates that the mediated device could
> > >     be fully isolated and protected by IOMMU via attaching
> > >     an iommu domain to this device. If empty, it indicates
> > >     using vendor defined isolation, hence bypass IOMMU.
> > >
> > > * mdev_set/get_iommu_device(dev, iommu_device)
> > >   - Set or get the iommu device which represents this mdev
> > >     in IOMMU's device scope. Drivers don't need to set the
> > >     iommu device if it uses vendor defined isolation.
> > >
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Liu Yi L <yi.l.liu@intel.com>
> > > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > ---
> > >  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
> > >  drivers/vfio/mdev/mdev_private.h |  1 +
> > >  include/linux/mdev.h             | 14 ++++++++++++++
> > >  3 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > b/drivers/vfio/mdev/mdev_core.c index b96fedc77ee5..1b6435529166
> > > 100644
> > > --- a/drivers/vfio/mdev/mdev_core.c
> > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool  
> > force_remove)  
> > >  	return 0;
> > >  }
> > >
> > > +int mdev_set_iommu_device(struct device *dev, struct device
> > > +*iommu_device) {
> > > +	struct mdev_device *mdev = to_mdev_device(dev);
> > > +
> > > +	mdev->iommu_device = iommu_device;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(mdev_set_iommu_device);
> > > +
> > > +struct device *mdev_get_iommu_device(struct device *dev) {
> > > +	struct mdev_device *mdev = to_mdev_device(dev);
> > > +
> > > +	return mdev->iommu_device;
> > > +}
> > > +EXPORT_SYMBOL(mdev_get_iommu_device);
> > > +
> > >  static int __init mdev_init(void)
> > >  {
> > >  	return mdev_bus_register();
> > > diff --git a/drivers/vfio/mdev/mdev_private.h
> > > b/drivers/vfio/mdev/mdev_private.h
> > > index 379758c52b1b..bfb7b22a7cb6 100644
> > > --- a/drivers/vfio/mdev/mdev_private.h
> > > +++ b/drivers/vfio/mdev/mdev_private.h
> > > @@ -34,6 +34,7 @@ struct mdev_device {
> > >  	struct list_head next;
> > >  	struct kobject *type_kobj;
> > >  	bool active;
> > > +	struct device *iommu_device;
> > >  };
> > >  
> This is not a performance path, but it is a good practice to create naturally aligned/packed structures.
> You should define struct device *iommu_device; before bool active.

Agreed, if someone wants to fixup before commit or if there's another
spin please do so, otherwise we can adjust it in a trivial follow-up
patch.  Thanks,

Alex
