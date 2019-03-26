Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479BB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfCZP0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCZP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:26:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFB653086262;
        Tue, 26 Mar 2019 15:26:53 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD8460BFC;
        Tue, 26 Mar 2019 15:26:53 +0000 (UTC)
Date:   Tue, 26 Mar 2019 09:26:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Message-ID: <20190326092652.2876030d@x1.home>
In-Reply-To: <244348f7-4d72-b7c5-9d82-34db296ff885@nvidia.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <244348f7-4d72-b7c5-9d82-34db296ff885@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 26 Mar 2019 15:26:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:36:22 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > There are five problems with current code structure.
> > 1. mdev device is placed on the mdev bus before it is created in the
> > vendor driver. Once a device is placed on the mdev bus without creating
> > its supporting underlying vendor device, an open() can get triggered by
> > userspace on partially initialized device.
> > Below ladder diagram highlight it.
> > 
> >       cpu-0                                       cpu-1
> >       -----                                       -----
> >    create_store()
> >      mdev_create_device()
> >        device_register()
> >           ...
> >          vfio_mdev_probe()
> >          ...creates char device
> >                                         vfio_mdev_open()
> >                                           parent->ops->open(mdev)
> >                                             vfio_ap_mdev_open()
> >                                               matrix_mdev = NULL
> >         [...]
> >         parent->ops->create()
> >           vfio_ap_mdev_create()
> >             mdev_set_drvdata(mdev, matrix_mdev);
> >             /* Valid pointer set above */
> >   
> 
> VFIO interface uses sysfs path of device or PCI device's BDF where it
> checks sysfs file for that device exist.
> In case of VFIO mdev device, above situation will never happen as open
> will only get called if sysfs entry for that device exist.
> 
> If you don't use VFIO interface then this situation can arise. In that
> case probe() can be used for very basic initialization then create
> actual char device from create().
> 
> 
> > 2. Current creation sequence is,
> >    parent->ops_create()
> >    groups_register()
> > 
> > Remove sequence is,
> >    parent->ops->remove()
> >    groups_unregister()
> > However, remove sequence should be exact mirror of creation sequence.
> > Once this is achieved, all users of the mdev will be terminated first
> > before removing underlying vendor device.
> > (Follow standard linux driver model).
> > At that point vendor's remove() ops shouldn't failed because device is
> > taken off the bus that should terminate the users.
> >   
> 
> If VMM or user space application is using mdev device,
> parent->ops->remove() can return failure. In that case sysfs files
> shouldn't be removed. Hence above sequence is followed for remove.
> 
> Standard linux driver model doesn't allow remove() to fail, but in
> of mdev framework, interface is defined to handle such error case.
> 
> 
> > 3. Additionally any new mdev driver that wants to work on mdev device
> > during probe() routine registered using mdev_register_driver() needs to
> > get stable mdev structure.
> >   
> 
> Things that you are trying to handle with mdev structure from probe(),
> couldn't that be moved to create()?
> 
> 
> > 4. In following sequence, child devices created while removing mdev parent
> > device can be left out, or it may lead to race of removing half
> > initialized child mdev devices.
> > 
> > issue-1:
> > --------
> >        cpu-0                         cpu-1
> >        -----                         -----
> >                                   mdev_unregister_device()
> >                                      device_for_each_child()
> >                                         mdev_device_remove_cb()
> >                                             mdev_device_remove()
> > create_store()
> >   mdev_device_create()                   [...]
> >        device_register()
> >                                   parent_remove_sysfs_files()
> >                                   /* BUG: device added by cpu-0
> >                                    * whose parent is getting removed.
> >                                    */
> > 
> > issue-2:
> > --------
> >        cpu-0                         cpu-1
> >        -----                         -----
> > create_store()
> >   mdev_device_create()                   [...]
> >        device_register()
> > 
> >        [...]                      mdev_unregister_device()
> >                                      device_for_each_child()
> >                                         mdev_device_remove_cb()
> >                                             mdev_device_remove()
> > 
> >        mdev_create_sysfs_files()
> >        /* BUG: create is adding
> >         * sysfs files for a device
> >         * which is undergoing removal.
> >         */
> >                                  parent_remove_sysfs_files()
> > 
> > 5. Below crash is observed when user initiated remove is in progress
> > and mdev_unregister_driver() completes parent unregistration.
> > 
> >        cpu-0                         cpu-1
> >        -----                         -----
> > remove_store()
> >    mdev_device_remove()
> >    active = false;
> >                                   mdev_unregister_device()
> >                                     remove type
> >    [...]
> >    mdev_remove_ops() crashes.
> > 
> > This is similar race like create() racing with mdev_unregister_device().
> > 
> > mtty mtty: MDEV: Registered
> > iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
> > vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id = 57
> > mdev_device_remove sleep started
> > mtty mtty: MDEV: Unregistering
> > mtty_dev: Unloaded!
> > BUG: unable to handle kernel paging request at ffffffffc027d668
> > PGD af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> > Oops: 0000 [#1] SMP PTI
> > CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted 5.0.0-rc7-vdevbus+ #2
> > Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> > RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev]
> > Call Trace:
> >  mdev_device_remove+0xef/0x130 [mdev]
> >  remove_store+0x77/0xa0 [mdev]
> >  kernfs_fop_write+0x113/0x1a0
> >  __vfs_write+0x33/0x1b0
> >  ? rcu_read_lock_sched_held+0x64/0x70
> >  ? rcu_sync_lockdep_assert+0x2a/0x50
> >  ? __sb_start_write+0x121/0x1b0
> >  ? vfs_write+0x17c/0x1b0
> >  vfs_write+0xad/0x1b0
> >  ? trace_hardirqs_on_thunk+0x1a/0x1c
> >  ksys_write+0x55/0xc0
> >  do_syscall_64+0x5a/0x210
> > 
> > Therefore, mdev core is improved in following ways to overcome above
> > issues.
> > 
> > 1. Before placing mdev devices on the bus, perform vendor drivers
> > creation which supports the mdev creation.
> > This ensures that mdev specific all necessary fields are initialized
> > before a given mdev can be accessed by bus driver.
> > 
> > 2. During remove flow, first remove the device from the bus. This
> > ensures that any bus specific devices and data is cleared.
> > Once device is taken of the mdev bus, perform remove() of mdev from the
> > vendor driver.
> >  
> 
> If user space application is using the device and someone underneath
> remove the device from bus, how would use space application know that
> device is being removed?
> If DMA is setup, user space application is accessing that memory and
> device is removed from bus - how will you restrict to not to remove that
> device? If remove() is not restricted then host might crash.
> I know Linux kernel device core model doesn't allow remove() to fail,
> but we had tackled that problem for mdev devices in this framework. I
> prefer not to change this behavior. This will regress existing working
> drivers.


We have exactly this issue with vfio-pci, or really any vfio driver,
where the solution is that a remove request is blocked until the device
becomes unused by the user.  In fact there's a notification that
userspace can connect to so that we don't need to silently wait for
userspace to be done.  We could also potentially kill the userspace
application using the device, or if we ever implemented revoke support
for mmaps, we could unmap the device and the use could handle the
SIGBUS.  With Parav's suggestion to fix the ordering such that the
device is first removed from the bus, where the blocking opportunity
comes into play, it might be time to let go of this one-off
force/not-force behavior.  Thanks,

Alex
