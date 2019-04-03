Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DAFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCAB2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDCV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCV1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5B6966979;
        Wed,  3 Apr 2019 21:27:23 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D485608E7;
        Wed,  3 Apr 2019 21:27:23 +0000 (UTC)
Date:   Wed, 3 Apr 2019 15:27:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, cjia@nvidia.com
Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
 life cycle APIs
Message-ID: <20190403152722.24efc561@x1.home>
In-Reply-To: <1553658345-43995-8-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 03 Apr 2019 21:27:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 22:45:45 -0500
Parav Pandit <parav@mellanox.com> wrote:

> Below race condition and call trace exist with current device life cycle
> sequence.
> 
> 1. In following sequence, child devices created while removing mdev parent
> device can be left out, or it may lead to race of removing half
> initialized child mdev devices.
> 
> issue-1:
> --------
>        cpu-0                         cpu-1
>        -----                         -----
>                                   mdev_unregister_device()
>                                      device_for_each_child()
>                                         mdev_device_remove_cb()
>                                             mdev_device_remove()
> create_store()
>   mdev_device_create()                   [...]
>        device_register()
>                                   parent_remove_sysfs_files()
>                                   /* BUG: device added by cpu-0
>                                    * whose parent is getting removed.
>                                    */
> 
> issue-2:
> --------
>        cpu-0                         cpu-1
>        -----                         -----
> create_store()
>   mdev_device_create()                   [...]
>        device_register()
> 
>        [...]                      mdev_unregister_device()
>                                      device_for_each_child()
>                                         mdev_device_remove_cb()
>                                             mdev_device_remove()
> 
>        mdev_create_sysfs_files()
>        /* BUG: create is adding
>         * sysfs files for a device
>         * which is undergoing removal.
>         */
>                                  parent_remove_sysfs_files()
> 
> 2. Below crash is observed when user initiated remove is in progress
> and mdev_unregister_driver() completes parent unregistration.
> 
>        cpu-0                         cpu-1
>        -----                         -----
> remove_store()
>    mdev_device_remove()
>    active = false;
>                                   mdev_unregister_device()
>                                     remove type
>    [...]
>    mdev_remove_ops() crashes.
> 
> This is similar race like create() racing with mdev_unregister_device().
> 
> mtty mtty: MDEV: Registered
> iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
> vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id = 57
> mtty mtty: MDEV: Unregistering
> mtty_dev: Unloaded!
> BUG: unable to handle kernel paging request at ffffffffc027d668
> PGD af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
> Oops: 0000 [#1] SMP PTI
> CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted 5.0.0-rc7-vdevbus+ #2
> Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
> RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev]
> Call Trace:
>  mdev_device_remove+0xef/0x130 [mdev]
>  remove_store+0x77/0xa0 [mdev]
>  kernfs_fop_write+0x113/0x1a0
>  __vfs_write+0x33/0x1b0
>  ? rcu_read_lock_sched_held+0x64/0x70
>  ? rcu_sync_lockdep_assert+0x2a/0x50
>  ? __sb_start_write+0x121/0x1b0
>  ? vfs_write+0x17c/0x1b0
>  vfs_write+0xad/0x1b0
>  ? trace_hardirqs_on_thunk+0x1a/0x1c
>  ksys_write+0x55/0xc0
>  do_syscall_64+0x5a/0x210
> 
> Therefore, mdev core is improved to overcome above issues.
> 
> Wait for any ongoing mdev create() and remove() to finish before
> unregistering parent device using srcu. This continues to allow multiple
> create and remove to progress in parallel. At the same time guard parent
> removal while parent is being access by create() and remove callbacks.
> 
> mdev_device_remove() is refactored to not block on srcu when device is
> removed as part of parent removal.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 83 ++++++++++++++++++++++++++++++++++------
>  drivers/vfio/mdev/mdev_private.h |  6 +++
>  2 files changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index aefcf34..fa233c8 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref)
>  						  ref);
>  	struct device *dev = parent->dev;
>  
> +	cleanup_srcu_struct(&parent->unreg_srcu);
>  	kfree(parent);
>  	put_device(dev);
>  }
> @@ -147,10 +148,30 @@ static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
>  	return 0;
>  }
>  
> +static int mdev_device_remove_common(struct mdev_device *mdev,
> +				     bool force_remove)
> +{
> +	struct mdev_type *type;
> +	int ret;
> +
> +	type = to_mdev_type(mdev->type_kobj);

I know you're just moving this into the common function, but I think
we're just caching this for aesthetics, the mdev object is still valid
after the remove ops and I don't see anything touching this field.  If
so, maybe we should remove 'type' or at least set it right before it's
used so it doesn't appear that we're preserving it before the remove op.

> +
> +	ret = mdev_device_remove_ops(mdev, force_remove);
> +	if (ret && !force_remove) {
> +		mutex_lock(&mdev_list_lock);
> +		mdev->active = true;
> +		mutex_unlock(&mdev_list_lock);

The mutex around this is a change from the previous code and I'm not
sure it adds anything.  If there's a thread testing for active racing
with this thread setting active to true, there's no meaningful
difference in the result by acquiring the mutex.  'active' may change
from false->true during the critical section of the other thread, but I
don't think there are any strange out of order things that give the
wrong result, the other thread either sees true or false and continues
or exits, regardless of this mutex.

> +		return ret;
> +	}
> +	mdev_remove_sysfs_files(&mdev->dev, type);
> +	device_unregister(&mdev->dev);
> +	return ret;
> +}
> +
>  static int mdev_device_remove_cb(struct device *dev, void *data)
>  {
>  	if (dev_is_mdev(dev))
> -		mdev_device_remove(dev, true);
> +		mdev_device_remove_common(to_mdev_device(dev), true);
>  
>  	return 0;
>  }
> @@ -193,6 +214,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	}
>  
>  	kref_init(&parent->ref);
> +	init_srcu_struct(&parent->unreg_srcu);
>  
>  	parent->dev = dev;
>  	parent->ops = ops;
> @@ -213,6 +235,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	if (ret)
>  		dev_warn(dev, "Failed to create compatibility class link\n");
>  
> +	rcu_assign_pointer(parent->self, parent);
>  	list_add(&parent->next, &parent_list);
>  	mutex_unlock(&parent_list_lock);
>  
> @@ -251,13 +274,31 @@ void mdev_unregister_device(struct device *dev)
>  	dev_info(dev, "MDEV: Unregistering\n");
>  
>  	list_del(&parent->next);
> +	mutex_unlock(&parent_list_lock);
> +
> +	/*
> +	 * Publish that this mdev parent is unregistering. So any new
> +	 * create/remove cannot start on this parent anymore by user.
> +	 */
> +	rcu_assign_pointer(parent->self, NULL);
> +
> +	/*
> +	 * Wait for any active create() or remove() mdev ops on the parent
> +	 * to complete.
> +	 */
> +	synchronize_srcu(&parent->unreg_srcu);
> +
> +	/*
> +	 * At this point it is confirmed that any pending user initiated
> +	 * create or remove callbacks accessing the parent are completed.
> +	 * It is safe to remove the parent now.
> +	 */

Thanks for the good documentation here.

Alex

>  	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
>  
>  	device_for_each_child(dev, NULL, mdev_device_remove_cb);
>  
>  	parent_remove_sysfs_files(parent);
>  
> -	mutex_unlock(&parent_list_lock);
>  	mdev_put_parent(parent);
>  }
>  EXPORT_SYMBOL(mdev_unregister_device);
> @@ -278,14 +319,24 @@ int mdev_device_create(struct kobject *kobj,
>  		       struct device *dev, const guid_t *uuid)
>  {
>  	int ret;
> +	struct mdev_parent *valid_parent;
>  	struct mdev_device *mdev, *tmp;
>  	struct mdev_parent *parent;
>  	struct mdev_type *type = to_mdev_type(kobj);
> +	int srcu_idx;
>  
>  	parent = mdev_get_parent(type->parent);
>  	if (!parent)
>  		return -EINVAL;
>  
> +	srcu_idx = srcu_read_lock(&parent->unreg_srcu);
> +	valid_parent = srcu_dereference(parent->self, &parent->unreg_srcu);
> +	if (!valid_parent) {
> +		/* parent is undergoing unregistration */
> +		ret = -ENODEV;
> +		goto mdev_fail;
> +	}
> +
>  	mutex_lock(&mdev_list_lock);
>  
>  	/* Check for duplicate */
> @@ -334,44 +385,52 @@ int mdev_device_create(struct kobject *kobj,
>  	mdev->type_kobj = kobj;
>  	mdev->active = true;
>  	dev_dbg(&mdev->dev, "MDEV: created\n");
> +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
>  
>  	return 0;
>  
>  create_fail:
>  	device_unregister(&mdev->dev);
>  mdev_fail:
> +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
>  	mdev_put_parent(parent);
>  	return ret;
>  }
>  
>  int mdev_device_remove(struct device *dev, bool force_remove)
>  {
> +	struct mdev_parent *valid_parent;
>  	struct mdev_device *mdev;
>  	struct mdev_parent *parent;
> -	struct mdev_type *type;
> +	int srcu_idx;
>  	int ret;
>  
>  	mdev = to_mdev_device(dev);
> +	parent = mdev->parent;
> +
> +	srcu_idx = srcu_read_lock(&parent->unreg_srcu);
> +	valid_parent = srcu_dereference(parent->self, &parent->unreg_srcu);
> +	if (!valid_parent) {
> +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> +		/* parent is undergoing unregistration */
> +		return -ENODEV;
> +	}
> +
>  	mutex_lock(&mdev_list_lock);
>  	if (!mdev->active) {
>  		mutex_unlock(&mdev_list_lock);
> +		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
>  		return -EAGAIN;
>  	}
>  
>  	mdev->active = false;
>  	mutex_unlock(&mdev_list_lock);
>  
> -	type = to_mdev_type(mdev->type_kobj);
> -	parent = mdev->parent;
> -
> -	ret = mdev_device_remove_ops(mdev, force_remove);
> -	if (ret) {
> -		mdev->active = true;
> +	ret = mdev_device_remove_common(mdev, force_remove);
> +	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
> +	if (ret)
>  		return ret;
> -	}
>  
> -	mdev_remove_sysfs_files(dev, type);
> -	device_unregister(dev);
>  	mdev_put_parent(parent);
>  
>  	return 0;
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index ddcf9c7..b799978 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -23,6 +23,12 @@ struct mdev_parent {
>  	struct list_head next;
>  	struct kset *mdev_types_kset;
>  	struct list_head type_list;
> +	/*
> +	 * Protects unregistration to wait until create/remove
> +	 * are completed.
> +	 */
> +	struct srcu_struct unreg_srcu;
> +	struct mdev_parent __rcu *self;
>  };
>  
>  struct mdev_device {

