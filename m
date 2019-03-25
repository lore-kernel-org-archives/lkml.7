Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61682083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfCYVwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfCYVwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CBFE3084026;
        Mon, 25 Mar 2019 21:52:13 +0000 (UTC)
Received: from x1.home (ovpn-116-33.phx2.redhat.com [10.3.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48BB960E3D;
        Mon, 25 Mar 2019 21:52:13 +0000 (UTC)
Date:   Mon, 25 Mar 2019 15:52:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal
 if one fails
Message-ID: <20190325155212.12cf7355@x1.home>
In-Reply-To: <VI1PR0501MB2271F32EF956C838A19D460CD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-8-git-send-email-parav@mellanox.com>
        <d3a9ba59-59dd-7924-72e0-09652dce8914@nvidia.com>
        <20190325144935.0696668a@x1.home>
        <VI1PR0501MB2271F32EF956C838A19D460CD15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 25 Mar 2019 21:52:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 21:36:42 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Monday, March 25, 2019 3:50 PM
> > To: Kirti Wankhede <kwankhede@nvidia.com>
> > Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 7/8] vfio/mdev: Fix aborting mdev child device removal if
> > one fails
> > 
> > On Tue, 26 Mar 2019 01:05:34 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> > > On 3/23/2019 4:50 AM, Parav Pandit wrote:  
> > > > device_for_each_child() stops executing callback function for
> > > > remaining child devices, if callback hits an error.
> > > > Each child mdev device is independent of each other.
> > > > While unregistering parent device, mdev core must remove all child
> > > > mdev devices.
> > > > Therefore, mdev_device_remove_cb() always returns success so that
> > > > device_for_each_child doesn't abort if one child removal hits error.
> > > >  
> > >
> > > When unregistering parent device, force_remove is set to true amd
> > > mdev_device_remove_ops() always returns success.  
> > 
> > Can we know that?  mdev_device_remove() doesn't guarantee to return
> > zero.
> >   
> > > > While at it, improve remove and unregister functions for below  
> > simplicity.  
> > > >
> > > > There isn't need to pass forced flag pointer during mdev parent
> > > > removal which invokes mdev_device_remove().  
> > >
> > > There is a need to pass the flag, pasting here the comment above
> > > mdev_device_remove_ops() which explains why the flag is needed:
> > >
> > > /*
> > >  * mdev_device_remove_ops gets called from sysfs's 'remove' and when
> > > parent
> > >  * device is being unregistered from mdev device framework.
> > >  * - 'force_remove' is set to 'false' when called from sysfs's 'remove'
> > > which
> > >  *   indicates that if the mdev device is active, used by VMM or userspace
> > >  *   application, vendor driver could return error then don't remove the
> > > device.
> > >  * - 'force_remove' is set to 'true' when called from
> > > mdev_unregister_device()
> > >  *   which indicate that parent device is being removed from mdev device
> > >  *   framework so remove mdev device forcefully.
> > >  */  
> > 
> > I don't see that this changes the force behavior, it's simply noting that in
> > order to continue the device_for_each_child() iterator, we need to return
> > zero, regardless of what mdev_device_remove() returns, and the parent
> > remove path is the only caller of mdev_device_remove_cb(), so we can
> > assume force = true when calling mdev_device_remove().  Aside from maybe
> > a WARN_ON if mdev_device_remove() returns non-zero, that much looks
> > reasonable to me.
> >   
> > >  So simplify the flow.  
> > > >
> > > > mdev_device_remove() is called from two paths.
> > > > 1. mdev_unregister_driver()
> > > >      mdev_device_remove_cb()
> > > >        mdev_device_remove()
> > > > 2. remove_store()
> > > >      mdev_device_remove()
> > > >
> > > > When device is removed by user using remote_store(), device under
> > > > removal is mdev device.
> > > > When device is removed during parent device removal using generic
> > > > child iterator, mdev check is already done using dev_is_mdev().
> > > >
> > > > Hence, remove the unnecessary loop in mdev_device_remove().  
> > 
> > I don't think knowing the device type is the only reason for this loop though.
> > Both paths you mention above can race with each other, so we need to
> > serialize them and pick a winner.  The mdev_list_lock allows us to do that.
> > Additionally...
> >   
> > > >
> > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > ---
> > > >  drivers/vfio/mdev/mdev_core.c | 24 +++++-------------------
> > > >  1 file changed, 5 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > b/drivers/vfio/mdev/mdev_core.c index ab05464..944a058 100644
> > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > @@ -150,10 +150,10 @@ static int mdev_device_remove_ops(struct
> > > > mdev_device *mdev, bool force_remove)
> > > >
> > > >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> > > > -	if (!dev_is_mdev(dev))
> > > > -		return 0;
> > > > +	if (dev_is_mdev(dev))
> > > > +		mdev_device_remove(dev, true);
> > > >
> > > > -	return mdev_device_remove(dev, data ? *(bool *)data : true);
> > > > +	return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -241,7 +241,6 @@ int mdev_register_device(struct device *dev,
> > > > const struct mdev_parent_ops *ops)  void
> > > > mdev_unregister_device(struct device *dev)  {
> > > >  	struct mdev_parent *parent;
> > > > -	bool force_remove = true;
> > > >
> > > >  	mutex_lock(&parent_list_lock);
> > > >  	parent = __find_parent_device(dev); @@ -255,8 +254,7 @@ void
> > > > mdev_unregister_device(struct device *dev)
> > > >  	list_del(&parent->next);
> > > >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> > > >
> > > > -	device_for_each_child(dev, (void *)&force_remove,
> > > > -			      mdev_device_remove_cb);
> > > > +	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > > >
> > > >  	parent_remove_sysfs_files(parent);
> > > >
> > > > @@ -346,24 +344,12 @@ int mdev_device_create(struct kobject *kobj,
> > > > struct device *dev, uuid_le uuid)
> > > >
> > > >  int mdev_device_remove(struct device *dev, bool force_remove)  {
> > > > -	struct mdev_device *mdev, *tmp;
> > > > +	struct mdev_device *mdev;
> > > >  	struct mdev_parent *parent;
> > > >  	struct mdev_type *type;
> > > >  	int ret;
> > > >
> > > >  	mdev = to_mdev_device(dev);
> > > > -
> > > > -	mutex_lock(&mdev_list_lock);  
> > 
> > Acquiring the lock is removed, but...
> >   
> Crap. Missed the lower part.
> 
> > > > -	list_for_each_entry(tmp, &mdev_list, next) {
> > > > -		if (tmp == mdev)
> > > > -			break;
> > > > -	}
> > > > -
> > > > -	if (tmp != mdev) {
> > > > -		mutex_unlock(&mdev_list_lock);
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > >  	if (!mdev->active) {
> > > >  		mutex_unlock(&mdev_list_lock);
> > > >  		return -EAGAIN;
> > > >  
> > 
> > We still release it in this path and the code below here.  If we don't find the
> > device on the list under lock, then we're working with a stale device and
> > playing with the 'active' flag of that device outside of any sort of mutual
> > exclusion is racy.  Thanks,  
> Subsequent patch makes the order sane.
> I think I should merge this change with patch-8 in the series.

Please don't incorporate more fixes into patch 8, it has too many
already.  I'd really prefer to see patch 8 split into issues you've
identified as much as possible.  Thanks,

Alex
