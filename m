Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ACC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfDWTVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfDWTVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:21:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6A45C051671;
        Tue, 23 Apr 2019 19:21:41 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5112D60C62;
        Tue, 23 Apr 2019 19:21:41 +0000 (UTC)
Date:   Tue, 23 Apr 2019 13:21:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
 life cycle APIs
Message-ID: <20190423132140.18b0d892@x1.home>
In-Reply-To: <VI1PR0501MB2271E8894B77BA8F316B6148D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
        <20190403152722.24efc561@x1.home>
        <VI1PR0501MB22714BE24CEA00E14A811918D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190404144428.1fa6afb2@x1.home>
        <VI1PR0501MB2271E8894B77BA8F316B6148D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 23 Apr 2019 19:21:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 23:05:43 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, April 4, 2019 3:44 PM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kwankhede@nvidia.com; cjia@nvidia.com
> > Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
> > life cycle APIs
> > 
> > On Thu, 4 Apr 2019 00:02:22 +0000
> > Parav Pandit <parav@mellanox.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Wednesday, April 3, 2019 4:27 PM
> > > > To: Parav Pandit <parav@mellanox.com>
> > > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > kwankhede@nvidia.com; cjia@nvidia.com
> > > > Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev
> > > > device life cycle APIs
> > > >
> > > > On Tue, 26 Mar 2019 22:45:45 -0500
> > > > Parav Pandit <parav@mellanox.com> wrote:
> > > >  
> > > > > Below race condition and call trace exist with current device life
> > > > > cycle sequence.
> > > > >
> > > > > 1. In following sequence, child devices created while removing
> > > > > mdev parent device can be left out, or it may lead to race of
> > > > > removing half initialized child mdev devices.
> > > > >
> > > > > issue-1:
> > > > > --------
> > > > >        cpu-0                         cpu-1
> > > > >        -----                         -----
> > > > >                                   mdev_unregister_device()
> > > > >                                      device_for_each_child()
> > > > >                                         mdev_device_remove_cb()
> > > > >                                             mdev_device_remove()
> > > > > create_store()
> > > > >   mdev_device_create()                   [...]
> > > > >        device_register()
> > > > >                                   parent_remove_sysfs_files()
> > > > >                                   /* BUG: device added by cpu-0
> > > > >                                    * whose parent is getting removed.
> > > > >                                    */
> > > > >
> > > > > issue-2:
> > > > > --------
> > > > >        cpu-0                         cpu-1
> > > > >        -----                         -----
> > > > > create_store()
> > > > >   mdev_device_create()                   [...]
> > > > >        device_register()
> > > > >
> > > > >        [...]                      mdev_unregister_device()
> > > > >                                      device_for_each_child()
> > > > >                                         mdev_device_remove_cb()
> > > > >                                             mdev_device_remove()
> > > > >
> > > > >        mdev_create_sysfs_files()
> > > > >        /* BUG: create is adding
> > > > >         * sysfs files for a device
> > > > >         * which is undergoing removal.
> > > > >         */
> > > > >                                  parent_remove_sysfs_files()
> > > > >
> > > > > 2. Below crash is observed when user initiated remove is in
> > > > > progress and mdev_unregister_driver() completes parent  
> > unregistration.  
> > > > >
> > > > >        cpu-0                         cpu-1
> > > > >        -----                         -----
> > > > > remove_store()
> > > > >    mdev_device_remove()
> > > > >    active = false;
> > > > >                                   mdev_unregister_device()
> > > > >                                     remove type
> > > > >    [...]
> > > > >    mdev_remove_ops() crashes.
> > > > >
> > > > > This is similar race like create() racing with mdev_unregister_device().
> > > > >
> > > > > mtty mtty: MDEV: Registered
> > > > > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group
> > > > > 57 vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id
> > > > > = 57 mtty mtty: MDEV: Unregistering
> > > > > mtty_dev: Unloaded!
> > > > > BUG: unable to handle kernel paging request at ffffffffc027d668
> > > > > PGD
> > > > > af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > > > > Oops: 0000 [#1] SMP PTI
> > > > > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted
> > > > > 5.0.0-rc7-vdevbus+ #2 Hardware name: Supermicro
> > > > > SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > > > > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev] Call Trace:
> > > > >  mdev_device_remove+0xef/0x130 [mdev]
> > > > >  remove_store+0x77/0xa0 [mdev]
> > > > >  kernfs_fop_write+0x113/0x1a0
> > > > >  __vfs_write+0x33/0x1b0
> > > > >  ? rcu_read_lock_sched_held+0x64/0x70
> > > > >  ? rcu_sync_lockdep_assert+0x2a/0x50  ?
> > > > > __sb_start_write+0x121/0x1b0  ? vfs_write+0x17c/0x1b0
> > > > >  vfs_write+0xad/0x1b0
> > > > >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> > > > >  ksys_write+0x55/0xc0
> > > > >  do_syscall_64+0x5a/0x210
> > > > >
> > > > > Therefore, mdev core is improved to overcome above issues.
> > > > >
> > > > > Wait for any ongoing mdev create() and remove() to finish before
> > > > > unregistering parent device using srcu. This continues to allow
> > > > > multiple create and remove to progress in parallel. At the same
> > > > > time guard parent removal while parent is being access by create()
> > > > > and remove  
> > > > callbacks.  
> > > > >
> > > > > mdev_device_remove() is refactored to not block on srcu when
> > > > > device is removed as part of parent removal.
> > > > >
> > > > > Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> > > > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > > > ---
> > > > >  drivers/vfio/mdev/mdev_core.c    | 83  
> > > > ++++++++++++++++++++++++++++++++++------  
> > > > >  drivers/vfio/mdev/mdev_private.h |  6 +++
> > > > >  2 files changed, 77 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > > > b/drivers/vfio/mdev/mdev_core.c index aefcf34..fa233c8 100644
> > > > > --- a/drivers/vfio/mdev/mdev_core.c
> > > > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > > > @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref)
> > > > >  						  ref);
> > > > >  	struct device *dev = parent->dev;
> > > > >
> > > > > +	cleanup_srcu_struct(&parent->unreg_srcu);
> > > > >  	kfree(parent);
> > > > >  	put_device(dev);
> > > > >  }
> > > > > @@ -147,10 +148,30 @@ static int mdev_device_remove_ops(struct  
> > > > mdev_device *mdev, bool force_remove)  
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > +static int mdev_device_remove_common(struct mdev_device *mdev,
> > > > > +				     bool force_remove)
> > > > > +{
> > > > > +	struct mdev_type *type;
> > > > > +	int ret;
> > > > > +
> > > > > +	type = to_mdev_type(mdev->type_kobj);  
> > > >
> > > > I know you're just moving this into the common function, but I think
> > > > we're just caching this for aesthetics, the mdev object is still
> > > > valid after the remove ops and I don't see anything touching this
> > > > field.  If so, maybe we should remove 'type' or at least set it
> > > > right before it's used so it doesn't appear that we're preserving it before  
> > the remove op.  
> > > >  
> > > Sure, yes.
> > > Type assignment should be done just before calling  
> > mdev_remove_sysfs_files().  
> > > Will send v2.
> > >  
> > > > > +
> > > > > +	ret = mdev_device_remove_ops(mdev, force_remove);
> > > > > +	if (ret && !force_remove) {
> > > > > +		mutex_lock(&mdev_list_lock);
> > > > > +		mdev->active = true;
> > > > > +		mutex_unlock(&mdev_list_lock);  
> > > >
> > > > The mutex around this is a change from the previous code and I'm not
> > > > sure it adds anything.  If there's a thread testing for active
> > > > racing with this thread setting active to true, there's no
> > > > meaningful difference in the result by acquiring the mutex.
> > > > 'active' may change from false->true during the critical section of
> > > > the other thread, but I don't think there are any strange out of
> > > > order things that give the wrong result, the other thread either sees true  
> > or false and continues or exits, regardless of this mutex.  
> > > >  
> > > Yes, I can drop the mutex.
> > > In future remove sequence fix, this will anyway vanish.
> > >
> > > Shall we finish this series with these 7 patches?
> > > Once you ack it will send v2 for these 7 patches and follow on to that we  
> > cleanup the sequencing?
> > 
> > Do you intend to move the removal of the mdev sanitization loop from
> > 6/7 to this patch?  I don't think we can really claim that what it's trying to do
> > is unnecessary until after we have the new code here that prevents the sysfs
> > remove path from running concurrent to the parent remove path.  It's not
> > really related to the changes in 6/7 anyway.  In fact, rather than moving that
> > chunk here, it could be added as a follow-on patch with explanation of why
> > it is now unnecessary.  Thanks,
> >   
> Device type cannot change from mdev to something else when it was invoked by the remove() sysfs cb.
> Neither it can be something else in parent removal is passes bus comparison check.

Hi Parav,

I tried to explain the concern in
Message-ID: <20190402163309.414c45ad@x1.home> It hinges on the fact that
remove_store() calls device_remove_file_self() before calling
mdev_device_remove().  Therefore imagine this scenarios:

Thread A			Thread B

mdev_device_remove()
 mdev_remove_sysfs_files()
				remove_store()
				 device_remove_file_self()
  sysfs_remove_files...
				 mdev_device_remove()
				  return -EAGAIN
                                 device_create_file()
 device_unregister()
 mdev_put_parent()

So Thread B recreated a stale sysfs attribute.  If it prevents the mdev
from being released via mdev_device_release() then it will forever
be !active and calling remove store will continue to error and recreate
it.  If the mdev does get freed, then remove_store() is working with a
stale device, which the sanitizing loop removed in 6/7 is meant to
catch.  Therefore, it makes sense to me to relocate that loop removal
until after we clean up the mess around removal.

BTW, I exchanged email with Kirti offline and I think we're in
agreement around your plans to fix this.  The confusion was around
whether the vendor driver remove callback can be called while the
device is still in use, but I believe vfio-core will prevent that with
the correct bus removal logic in place.

So where do we stand on this series?  I think patches 1-5 look good.
Should I incorporate them for v5.2?  Patch 6 looks ok, except I'd
rather see the sanitizing loop stay until we can otherwise fix the race
above.  Patch 7 needed more work, iirc.  Thanks,

Alex
