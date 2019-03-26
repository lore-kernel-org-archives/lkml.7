Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7763A2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfCZAFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCZAFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:05:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB04683F40;
        Tue, 26 Mar 2019 00:05:38 +0000 (UTC)
Received: from x1.home (ovpn-116-33.phx2.redhat.com [10.3.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47C271001DC8;
        Tue, 26 Mar 2019 00:05:38 +0000 (UTC)
Date:   Mon, 25 Mar 2019 18:05:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Message-ID: <20190325180537.11842c03@x1.home>
In-Reply-To: <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <20190325171831.1ac2a441@x1.home>
        <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 26 Mar 2019 00:05:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 23:34:28 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Monday, March 25, 2019 6:19 PM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kwankhede@nvidia.com
> > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
> > 
> > On Fri, 22 Mar 2019 18:20:35 -0500
> > Parav Pandit <parav@mellanox.com> wrote:
> >   
> > > There are five problems with current code structure.
> > > 1. mdev device is placed on the mdev bus before it is created in the
> > > vendor driver. Once a device is placed on the mdev bus without
> > > creating its supporting underlying vendor device, an open() can get
> > > triggered by userspace on partially initialized device.
> > > Below ladder diagram highlight it.
> > >
> > >       cpu-0                                       cpu-1
> > >       -----                                       -----
> > >    create_store()
> > >      mdev_create_device()
> > >        device_register()
> > >           ...
> > >          vfio_mdev_probe()
> > >          ...creates char device
> > >                                         vfio_mdev_open()
> > >                                           parent->ops->open(mdev)
> > >                                             vfio_ap_mdev_open()
> > >                                               matrix_mdev = NULL
> > >         [...]
> > >         parent->ops->create()
> > >           vfio_ap_mdev_create()
> > >             mdev_set_drvdata(mdev, matrix_mdev);
> > >             /* Valid pointer set above */
> > >
> > > 2. Current creation sequence is,
> > >    parent->ops_create()
> > >    groups_register()
> > >
> > > Remove sequence is,
> > >    parent->ops->remove()
> > >    groups_unregister()
> > > However, remove sequence should be exact mirror of creation sequence.
> > > Once this is achieved, all users of the mdev will be terminated first
> > > before removing underlying vendor device.
> > > (Follow standard linux driver model).
> > > At that point vendor's remove() ops shouldn't failed because device is
> > > taken off the bus that should terminate the users.
> > >
> > > 3. Additionally any new mdev driver that wants to work on mdev device
> > > during probe() routine registered using mdev_register_driver() needs
> > > to get stable mdev structure.
> > >
> > > 4. In following sequence, child devices created while removing mdev
> > > parent device can be left out, or it may lead to race of removing half
> > > initialized child mdev devices.
> > >
> > > issue-1:
> > > --------
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > >                                   mdev_unregister_device()
> > >                                      device_for_each_child()
> > >                                         mdev_device_remove_cb()
> > >                                             mdev_device_remove()
> > > create_store()
> > >   mdev_device_create()                   [...]
> > >        device_register()
> > >                                   parent_remove_sysfs_files()
> > >                                   /* BUG: device added by cpu-0
> > >                                    * whose parent is getting removed.
> > >                                    */
> > >
> > > issue-2:
> > > --------
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > > create_store()
> > >   mdev_device_create()                   [...]
> > >        device_register()
> > >
> > >        [...]                      mdev_unregister_device()
> > >                                      device_for_each_child()
> > >                                         mdev_device_remove_cb()
> > >                                             mdev_device_remove()
> > >
> > >        mdev_create_sysfs_files()
> > >        /* BUG: create is adding
> > >         * sysfs files for a device
> > >         * which is undergoing removal.
> > >         */
> > >                                  parent_remove_sysfs_files()  
> > 
> > In both cases above, it looks like the device will hold a reference to the
> > parent, so while there is a race, the parent object isn't released.  
> Yes, parent object is not released but parent fields are not stable.
> 
> >   
> > >
> > > 5. Below crash is observed when user initiated remove is in progress
> > > and mdev_unregister_driver() completes parent unregistration.
> > >
> > >        cpu-0                         cpu-1
> > >        -----                         -----
> > > remove_store()
> > >    mdev_device_remove()
> > >    active = false;
> > >                                   mdev_unregister_device()
> > >                                     remove type
> > >    [...]
> > >    mdev_remove_ops() crashes.
> > >
> > > This is similar race like create() racing with mdev_unregister_device().  
> > 
> > Not sure I catch this, the device should have a reference to the parent, and
> > we don't specifically clear parent->ops, so what's getting removed that
> > causes this oops?  Is .remove pointing at bad text regardless?
> >   
> I guess the mdev_attr_groups being stale now.
> 
> > > mtty mtty: MDEV: Registered
> > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
> > > vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id = 57
> > > mdev_device_remove sleep started mtty mtty: MDEV: Unregistering
> > > mtty_dev: Unloaded!
> > > BUG: unable to handle kernel paging request at ffffffffc027d668 PGD
> > > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > > Oops: 0000 [#1] SMP PTI
> > > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> > >  mdev_device_remove+0xef/0x130 [mdev]
> > >  remove_store+0x77/0xa0 [mdev]
> > >  kernfs_fop_write+0x113/0x1a0
> > >  __vfs_write+0x33/0x1b0
> > >  ? rcu_read_lock_sched_held+0x64/0x70
> > >  ? rcu_sync_lockdep_assert+0x2a/0x50
> > >  ? __sb_start_write+0x121/0x1b0
> > >  ? vfs_write+0x17c/0x1b0
> > >  vfs_write+0xad/0x1b0
> > >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> > >  ksys_write+0x55/0xc0
> > >  do_syscall_64+0x5a/0x210
> > >
> > > Therefore, mdev core is improved in following ways to overcome above
> > > issues.
> > >
> > > 1. Before placing mdev devices on the bus, perform vendor drivers
> > > creation which supports the mdev creation.
> > > This ensures that mdev specific all necessary fields are initialized
> > > before a given mdev can be accessed by bus driver.
> > >
> > > 2. During remove flow, first remove the device from the bus. This
> > > ensures that any bus specific devices and data is cleared.
> > > Once device is taken of the mdev bus, perform remove() of mdev from
> > > the vendor driver.
> > >
> > > 3. Linux core device model provides way to register and auto
> > > unregister the device sysfs attribute groups at dev->groups.
> > > Make use of this groups to let core create the groups and simplify
> > > code to avoid explicit groups creation and removal.
> > >
> > > 4. Wait for any ongoing mdev create() and remove() to finish before
> > > unregistering parent device using srcu. This continues to allow
> > > multiple create and remove to progress in parallel. At the same time
> > > guard parent removal while parent is being access by create() and remove  
> > callbacks.
> > 
> > So there should be 4-5 separate patches here?  Wishful thinking?
> >   
> create, remove racing with unregister is handled using srcu.
> Change-3 cannot be done without fixing the sequence so it should be in patch that fixes it.
> Change described changes 1-2-3 are just one change. It is just the patch description to bring clarity.
> Change-4 can be possibly done as split to different patch.
> 
> > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > ---
> > >  drivers/vfio/mdev/mdev_core.c    | 142 +++++++++++++++++++++--------------  
> > ----  
> > >  drivers/vfio/mdev/mdev_private.h |   7 +-
> > >  drivers/vfio/mdev/mdev_sysfs.c   |   6 +-
> > >  3 files changed, 84 insertions(+), 71 deletions(-)
> > >
> > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > b/drivers/vfio/mdev/mdev_core.c index 944a058..8fe0ed1 100644
> > > --- a/drivers/vfio/mdev/mdev_core.c
> > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref)
> > >  						  ref);
> > >  	struct device *dev = parent->dev;
> > >
> > > +	cleanup_srcu_struct(&parent->unreg_srcu);
> > >  	kfree(parent);
> > >  	put_device(dev);
> > >  }
> > > @@ -103,56 +104,30 @@ static inline void mdev_put_parent(struct  
> > mdev_parent *parent)  
> > >  		kref_put(&parent->ref, mdev_release_parent);  }
> > >
> > > -static int mdev_device_create_ops(struct kobject *kobj,
> > > -				  struct mdev_device *mdev)
> > > +static int mdev_device_must_remove(struct mdev_device *mdev)  
> > 
> > Naming is off here, mdev_device_remove_common()?
> >   
> Yes, sounds better.
> 
> > >  {
> > > -	struct mdev_parent *parent = mdev->parent;
> > > +	struct mdev_parent *parent;
> > > +	struct mdev_type *type;
> > >  	int ret;
> > >
> > > -	ret = parent->ops->create(kobj, mdev);
> > > -	if (ret)
> > > -		return ret;
> > > +	type = to_mdev_type(mdev->type_kobj);
> > >
> > > -	ret = sysfs_create_groups(&mdev->dev.kobj,
> > > -				  parent->ops->mdev_attr_groups);
> > > +	mdev_remove_sysfs_files(&mdev->dev, type);
> > > +	device_del(&mdev->dev);
> > > +	parent = mdev->parent;
> > > +	ret = parent->ops->remove(mdev);
> > >  	if (ret)
> > > -		parent->ops->remove(mdev);
> > > +		dev_err(&mdev->dev, "Remove failed: err=%d\n", ret);  
> > 
> > Let the caller decide whether to be verbose with the error, parent removal
> > might want to warn, sysfs remove might just return an error.
> >   
> I didn't follow. Caller meaning mdev_device_remove_common() or vendor driver?

I mean the callback iterator on the parent remove can do a WARN_ON if
this returns an error while the device remove path can silently return
-EBUSY, the common function doesn't need to decide whether the parent
ops remove function deserves a dev_err.

> > >
> > > +	/* Balances with device_initialize() */
> > > +	put_device(&mdev->dev);
> > >  	return ret;
> > >  }
> > >
> > > -/*
> > > - * mdev_device_remove_ops gets called from sysfs's 'remove' and when
> > > parent
> > > - * device is being unregistered from mdev device framework.
> > > - * - 'force_remove' is set to 'false' when called from sysfs's 'remove' which
> > > - *   indicates that if the mdev device is active, used by VMM or userspace
> > > - *   application, vendor driver could return error then don't remove the  
> > device.  
> > > - * - 'force_remove' is set to 'true' when called from  
> > mdev_unregister_device()  
> > > - *   which indicate that parent device is being removed from mdev device
> > > - *   framework so remove mdev device forcefully.
> > > - */
> > > -static int mdev_device_remove_ops(struct mdev_device *mdev, bool
> > > force_remove) -{
> > > -	struct mdev_parent *parent = mdev->parent;
> > > -	int ret;
> > > -
> > > -	/*
> > > -	 * Vendor driver can return error if VMM or userspace application is
> > > -	 * using this mdev device.
> > > -	 */
> > > -	ret = parent->ops->remove(mdev);
> > > -	if (ret && !force_remove)
> > > -		return ret;
> > > -
> > > -	sysfs_remove_groups(&mdev->dev.kobj, parent->ops-
> > >mdev_attr_groups);
> > > -	return 0;
> > > -}  
> > 
> > Seems like there's easily a separate patch in pushing the create/remove ops
> > into the calling function and separating for the iterator callback, that would
> > make this easier to review.
> >   
> > > -
> > >  static int mdev_device_remove_cb(struct device *dev, void *data)  {
> > >  	if (dev_is_mdev(dev))
> > > -		mdev_device_remove(dev, true);
> > > -
> > > +		mdev_device_must_remove(to_mdev_device(dev));
> > >  	return 0;
> > >  }
> > >
> > > @@ -194,6 +169,7 @@ int mdev_register_device(struct device *dev, const  
> > struct mdev_parent_ops *ops)  
> > >  	}
> > >
> > >  	kref_init(&parent->ref);
> > > +	init_srcu_struct(&parent->unreg_srcu);
> > >
> > >  	parent->dev = dev;
> > >  	parent->ops = ops;
> > > @@ -214,6 +190,7 @@ int mdev_register_device(struct device *dev, const  
> > struct mdev_parent_ops *ops)  
> > >  	if (ret)
> > >  		dev_warn(dev, "Failed to create compatibility class link\n");
> > >
> > > +	rcu_assign_pointer(parent->self, parent);
> > >  	list_add(&parent->next, &parent_list);
> > >  	mutex_unlock(&parent_list_lock);
> > >
> > > @@ -244,21 +221,36 @@ void mdev_unregister_device(struct device *dev)
> > >
> > >  	mutex_lock(&parent_list_lock);
> > >  	parent = __find_parent_device(dev);
> > > -
> > >  	if (!parent) {
> > >  		mutex_unlock(&parent_list_lock);
> > >  		return;
> > >  	}
> > > +	list_del(&parent->next);
> > > +	mutex_unlock(&parent_list_lock);
> > > +
> > >  	dev_info(dev, "MDEV: Unregistering\n");
> > >
> > > -	list_del(&parent->next);
> > > +	/* Publish that this mdev parent is unregistering. So any new
> > > +	 * create/remove cannot start on this parent anymore by user.
> > > +	 */  
> > 
> > Comment style, we're not in netdev.  
> Yep. Will fix it.
> >   
> > > +	rcu_assign_pointer(parent->self, NULL);
> > > +
> > > +	/*
> > > +	 * Wait for any active create() or remove() mdev ops on the parent
> > > +	 * to complete.
> > > +	 */
> > > +	synchronize_srcu(&parent->unreg_srcu);
> > > +
> > > +	/* At this point it is confirmed that any pending user initiated
> > > +	 * create or remove callbacks accessing the parent are completed.
> > > +	 * It is safe to remove the parent now.
> > > +	 */
> > >  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
> > >
> > >  	device_for_each_child(dev, NULL, mdev_device_remove_cb);
> > >
> > >  	parent_remove_sysfs_files(parent);
> > >
> > > -	mutex_unlock(&parent_list_lock);
> > >  	mdev_put_parent(parent);
> > >  }
> > >  EXPORT_SYMBOL(mdev_unregister_device);
> > > @@ -278,14 +270,24 @@ static void mdev_device_release(struct device
> > > *dev)  int mdev_device_create(struct kobject *kobj, struct device
> > > *dev, uuid_le uuid)  {
> > >  	int ret;
> > > +	struct mdev_parent *valid_parent;
> > >  	struct mdev_device *mdev, *tmp;
> > >  	struct mdev_parent *parent;
> > >  	struct mdev_type *type = to_mdev_type(kobj);
> > > +	int srcu_idx;
> > >
> > >  	parent = mdev_get_parent(type->parent);
> > >  	if (!parent)
> > >  		return -EINVAL;
> > >
> > > +	srcu_idx = srcu_read_lock(&parent->unreg_srcu);
> > > +	valid_parent = srcu_dereference(parent->self, &parent->unreg_srcu);
> > > +	if (!valid_parent) {
> > > +		/* parent is undergoing unregistration */
> > > +		ret = -ENODEV;
> > > +		goto mdev_fail;
> > > +	}
> > > +
> > >  	mutex_lock(&mdev_list_lock);
> > >
> > >  	/* Check for duplicate */
> > > @@ -310,68 +312,76 @@ int mdev_device_create(struct kobject *kobj,
> > > struct device *dev, uuid_le uuid)
> > >
> > >  	mdev->parent = parent;
> > >
> > > +	device_initialize(&mdev->dev);
> > >  	mdev->dev.parent  = dev;
> > >  	mdev->dev.bus     = &mdev_bus_type;
> > >  	mdev->dev.release = mdev_device_release;
> > > +	mdev->dev.groups = type->parent->ops->mdev_attr_groups;
> > >  	dev_set_name(&mdev->dev, "%pUl", uuid.b);
> > >
> > > -	ret = device_register(&mdev->dev);
> > > +	ret = type->parent->ops->create(kobj, mdev);
> > >  	if (ret)
> > > -		goto mdev_fail;
> > > +		goto create_fail;
> > >
> > > -	ret = mdev_device_create_ops(kobj, mdev);
> > > +	ret = device_add(&mdev->dev);  
> > 
> > Separating device_initialize() and device_add() also looks like a separate
> > patch, then the srcu could be added at the end.  Thanks,
> > 
> > Alex  
> 
> I saw little more core generated that way, but I think its fine.
> Basically, create/remove callback sequencing that does the device_inititailze/add etc in one patch and 
> User side race handling using srcu in another patch.
> Sounds good?

Splitting device_register into device_intialize/device_add solves the
first issue alone, that can be one patch.  Creating the common remove
function seems like a logical next patch.  The third patch could be
using the driver-core group attribute via those paths.  Another patch
could then incorporate the srcu code to gate the create/remove around
parent removal.  This basically matches your steps to address these
issues, it seems very split-able.  Thanks,

Alex
