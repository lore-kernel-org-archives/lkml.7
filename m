Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88127C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4981B218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfCVXVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:21:07 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56856 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728560AbfCVXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:21:04 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 23 Mar 2019 01:20:59 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2MNKaw6007896;
        Sat, 23 Mar 2019 01:20:57 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     parav@mellanox.com
Subject: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Date:   Fri, 22 Mar 2019 18:20:35 -0500
Message-Id: <1553296835-37522-9-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553296835-37522-1-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five problems with current code structure.
1. mdev device is placed on the mdev bus before it is created in the
vendor driver. Once a device is placed on the mdev bus without creating
its supporting underlying vendor device, an open() can get triggered by
userspace on partially initialized device.
Below ladder diagram highlight it.

      cpu-0                                       cpu-1
      -----                                       -----
   create_store()
     mdev_create_device()
       device_register()
          ...
         vfio_mdev_probe()
         ...creates char device
                                        vfio_mdev_open()
                                          parent->ops->open(mdev)
                                            vfio_ap_mdev_open()
                                              matrix_mdev = NULL
        [...]
        parent->ops->create()
          vfio_ap_mdev_create()
            mdev_set_drvdata(mdev, matrix_mdev);
            /* Valid pointer set above */

2. Current creation sequence is,
   parent->ops_create()
   groups_register()

Remove sequence is,
   parent->ops->remove()
   groups_unregister()
However, remove sequence should be exact mirror of creation sequence.
Once this is achieved, all users of the mdev will be terminated first
before removing underlying vendor device.
(Follow standard linux driver model).
At that point vendor's remove() ops shouldn't failed because device is
taken off the bus that should terminate the users.

3. Additionally any new mdev driver that wants to work on mdev device
during probe() routine registered using mdev_register_driver() needs to
get stable mdev structure.

4. In following sequence, child devices created while removing mdev parent
device can be left out, or it may lead to race of removing half
initialized child mdev devices.

issue-1:
--------
       cpu-0                         cpu-1
       -----                         -----
                                  mdev_unregister_device()
                                     device_for_each_child()
                                        mdev_device_remove_cb()
                                            mdev_device_remove()
create_store()
  mdev_device_create()                   [...]
       device_register()
                                  parent_remove_sysfs_files()
                                  /* BUG: device added by cpu-0
                                   * whose parent is getting removed.
                                   */

issue-2:
--------
       cpu-0                         cpu-1
       -----                         -----
create_store()
  mdev_device_create()                   [...]
       device_register()

       [...]                      mdev_unregister_device()
                                     device_for_each_child()
                                        mdev_device_remove_cb()
                                            mdev_device_remove()

       mdev_create_sysfs_files()
       /* BUG: create is adding
        * sysfs files for a device
        * which is undergoing removal.
        */
                                 parent_remove_sysfs_files()

5. Below crash is observed when user initiated remove is in progress
and mdev_unregister_driver() completes parent unregistration.

       cpu-0                         cpu-1
       -----                         -----
remove_store()
   mdev_device_remove()
   active = false;
                                  mdev_unregister_device()
                                    remove type
   [...]
   mdev_remove_ops() crashes.

This is similar race like create() racing with mdev_unregister_device().

mtty mtty: MDEV: Registered
iommu: Adding device 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001 to group 57
vfio_mdev 83b8f4f2-509f-382f-3c1e-e6bfe0fa1001: MDEV: group_id = 57
mdev_device_remove sleep started
mtty mtty: MDEV: Unregistering
mtty_dev: Unloaded!
BUG: unable to handle kernel paging request at ffffffffc027d668
PGD af9818067 P4D af9818067 PUD af981a067 PMD 8583c3067 PTE 0
Oops: 0000 [#1] SMP PTI
CPU: 15 PID: 3517 Comm: bash Kdump: loaded Not tainted 5.0.0-rc7-vdevbus+ #2
Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
RIP: 0010:mdev_device_remove_ops+0x1a/0x50 [mdev]
Call Trace:
 mdev_device_remove+0xef/0x130 [mdev]
 remove_store+0x77/0xa0 [mdev]
 kernfs_fop_write+0x113/0x1a0
 __vfs_write+0x33/0x1b0
 ? rcu_read_lock_sched_held+0x64/0x70
 ? rcu_sync_lockdep_assert+0x2a/0x50
 ? __sb_start_write+0x121/0x1b0
 ? vfs_write+0x17c/0x1b0
 vfs_write+0xad/0x1b0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ksys_write+0x55/0xc0
 do_syscall_64+0x5a/0x210

Therefore, mdev core is improved in following ways to overcome above
issues.

1. Before placing mdev devices on the bus, perform vendor drivers
creation which supports the mdev creation.
This ensures that mdev specific all necessary fields are initialized
before a given mdev can be accessed by bus driver.

2. During remove flow, first remove the device from the bus. This
ensures that any bus specific devices and data is cleared.
Once device is taken of the mdev bus, perform remove() of mdev from the
vendor driver.

3. Linux core device model provides way to register and auto unregister
the device sysfs attribute groups at dev->groups.
Make use of this groups to let core create the groups and simplify code
to avoid explicit groups creation and removal.

4. Wait for any ongoing mdev create() and remove() to finish before
unregistering parent device using srcu. This continues to allow multiple
create and remove to progress in parallel. At the same time guard parent
removal while parent is being access by create() and remove callbacks.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c    | 142 +++++++++++++++++++++------------------
 drivers/vfio/mdev/mdev_private.h |   7 +-
 drivers/vfio/mdev/mdev_sysfs.c   |   6 +-
 3 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 944a058..8fe0ed1 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -84,6 +84,7 @@ static void mdev_release_parent(struct kref *kref)
 						  ref);
 	struct device *dev = parent->dev;
 
+	cleanup_srcu_struct(&parent->unreg_srcu);
 	kfree(parent);
 	put_device(dev);
 }
@@ -103,56 +104,30 @@ static inline void mdev_put_parent(struct mdev_parent *parent)
 		kref_put(&parent->ref, mdev_release_parent);
 }
 
-static int mdev_device_create_ops(struct kobject *kobj,
-				  struct mdev_device *mdev)
+static int mdev_device_must_remove(struct mdev_device *mdev)
 {
-	struct mdev_parent *parent = mdev->parent;
+	struct mdev_parent *parent;
+	struct mdev_type *type;
 	int ret;
 
-	ret = parent->ops->create(kobj, mdev);
-	if (ret)
-		return ret;
+	type = to_mdev_type(mdev->type_kobj);
 
-	ret = sysfs_create_groups(&mdev->dev.kobj,
-				  parent->ops->mdev_attr_groups);
+	mdev_remove_sysfs_files(&mdev->dev, type);
+	device_del(&mdev->dev);
+	parent = mdev->parent;
+	ret = parent->ops->remove(mdev);
 	if (ret)
-		parent->ops->remove(mdev);
+		dev_err(&mdev->dev, "Remove failed: err=%d\n", ret);
 
+	/* Balances with device_initialize() */
+	put_device(&mdev->dev);
 	return ret;
 }
 
-/*
- * mdev_device_remove_ops gets called from sysfs's 'remove' and when parent
- * device is being unregistered from mdev device framework.
- * - 'force_remove' is set to 'false' when called from sysfs's 'remove' which
- *   indicates that if the mdev device is active, used by VMM or userspace
- *   application, vendor driver could return error then don't remove the device.
- * - 'force_remove' is set to 'true' when called from mdev_unregister_device()
- *   which indicate that parent device is being removed from mdev device
- *   framework so remove mdev device forcefully.
- */
-static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
-{
-	struct mdev_parent *parent = mdev->parent;
-	int ret;
-
-	/*
-	 * Vendor driver can return error if VMM or userspace application is
-	 * using this mdev device.
-	 */
-	ret = parent->ops->remove(mdev);
-	if (ret && !force_remove)
-		return ret;
-
-	sysfs_remove_groups(&mdev->dev.kobj, parent->ops->mdev_attr_groups);
-	return 0;
-}
-
 static int mdev_device_remove_cb(struct device *dev, void *data)
 {
 	if (dev_is_mdev(dev))
-		mdev_device_remove(dev, true);
-
+		mdev_device_must_remove(to_mdev_device(dev));
 	return 0;
 }
 
@@ -194,6 +169,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	}
 
 	kref_init(&parent->ref);
+	init_srcu_struct(&parent->unreg_srcu);
 
 	parent->dev = dev;
 	parent->ops = ops;
@@ -214,6 +190,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	if (ret)
 		dev_warn(dev, "Failed to create compatibility class link\n");
 
+	rcu_assign_pointer(parent->self, parent);
 	list_add(&parent->next, &parent_list);
 	mutex_unlock(&parent_list_lock);
 
@@ -244,21 +221,36 @@ void mdev_unregister_device(struct device *dev)
 
 	mutex_lock(&parent_list_lock);
 	parent = __find_parent_device(dev);
-
 	if (!parent) {
 		mutex_unlock(&parent_list_lock);
 		return;
 	}
+	list_del(&parent->next);
+	mutex_unlock(&parent_list_lock);
+
 	dev_info(dev, "MDEV: Unregistering\n");
 
-	list_del(&parent->next);
+	/* Publish that this mdev parent is unregistering. So any new
+	 * create/remove cannot start on this parent anymore by user.
+	 */
+	rcu_assign_pointer(parent->self, NULL);
+
+	/*
+	 * Wait for any active create() or remove() mdev ops on the parent
+	 * to complete.
+	 */
+	synchronize_srcu(&parent->unreg_srcu);
+
+	/* At this point it is confirmed that any pending user initiated
+	 * create or remove callbacks accessing the parent are completed.
+	 * It is safe to remove the parent now.
+	 */
 	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
 
 	device_for_each_child(dev, NULL, mdev_device_remove_cb);
 
 	parent_remove_sysfs_files(parent);
 
-	mutex_unlock(&parent_list_lock);
 	mdev_put_parent(parent);
 }
 EXPORT_SYMBOL(mdev_unregister_device);
@@ -278,14 +270,24 @@ static void mdev_device_release(struct device *dev)
 int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 {
 	int ret;
+	struct mdev_parent *valid_parent;
 	struct mdev_device *mdev, *tmp;
 	struct mdev_parent *parent;
 	struct mdev_type *type = to_mdev_type(kobj);
+	int srcu_idx;
 
 	parent = mdev_get_parent(type->parent);
 	if (!parent)
 		return -EINVAL;
 
+	srcu_idx = srcu_read_lock(&parent->unreg_srcu);
+	valid_parent = srcu_dereference(parent->self, &parent->unreg_srcu);
+	if (!valid_parent) {
+		/* parent is undergoing unregistration */
+		ret = -ENODEV;
+		goto mdev_fail;
+	}
+
 	mutex_lock(&mdev_list_lock);
 
 	/* Check for duplicate */
@@ -310,68 +312,76 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 
 	mdev->parent = parent;
 
+	device_initialize(&mdev->dev);
 	mdev->dev.parent  = dev;
 	mdev->dev.bus     = &mdev_bus_type;
 	mdev->dev.release = mdev_device_release;
+	mdev->dev.groups = type->parent->ops->mdev_attr_groups;
 	dev_set_name(&mdev->dev, "%pUl", uuid.b);
 
-	ret = device_register(&mdev->dev);
+	ret = type->parent->ops->create(kobj, mdev);
 	if (ret)
-		goto mdev_fail;
+		goto create_fail;
 
-	ret = mdev_device_create_ops(kobj, mdev);
+	ret = device_add(&mdev->dev);
 	if (ret)
-		goto create_fail;
+		goto dev_fail;
 
 	ret = mdev_create_sysfs_files(&mdev->dev, type);
-	if (ret) {
-		mdev_device_remove_ops(mdev, true);
-		goto create_fail;
-	}
+	if (ret)
+		goto sysfs_fail;
 
 	mdev->type_kobj = kobj;
 	mdev->active = true;
 	dev_dbg(&mdev->dev, "MDEV: created\n");
+	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
 
 	return 0;
 
+sysfs_fail:
+	device_del(&mdev->dev);
+dev_fail:
+	type->parent->ops->remove(mdev);
 create_fail:
-	device_unregister(&mdev->dev);
+	put_device(&mdev->dev);
 mdev_fail:
+	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
 	mdev_put_parent(parent);
 	return ret;
 }
 
-int mdev_device_remove(struct device *dev, bool force_remove)
+int mdev_device_remove(struct device *dev)
 {
+	struct mdev_parent *valid_parent;
 	struct mdev_device *mdev;
 	struct mdev_parent *parent;
-	struct mdev_type *type;
+	int srcu_idx;
 	int ret;
 
 	mdev = to_mdev_device(dev);
+	parent = mdev->parent;
+	srcu_idx = srcu_read_lock(&parent->unreg_srcu);
+	valid_parent = srcu_dereference(parent->self, &parent->unreg_srcu);
+	if (!valid_parent) {
+		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
+		/* parent is undergoing unregistration */
+		return -ENODEV;
+	}
+
+	mutex_lock(&mdev_list_lock);
 	if (!mdev->active) {
 		mutex_unlock(&mdev_list_lock);
-		return -EAGAIN;
+		srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
+		return -ENODEV;
 	}
-
 	mdev->active = false;
 	mutex_unlock(&mdev_list_lock);
 
-	type = to_mdev_type(mdev->type_kobj);
-	parent = mdev->parent;
-
-	ret = mdev_device_remove_ops(mdev, force_remove);
-	if (ret) {
-		mdev->active = true;
-		return ret;
-	}
+	ret = mdev_device_must_remove(mdev);
+	srcu_read_unlock(&parent->unreg_srcu, srcu_idx);
 
-	mdev_remove_sysfs_files(dev, type);
-	device_unregister(dev);
 	mdev_put_parent(parent);
-
-	return 0;
+	return ret;
 }
 
 static int __init mdev_init(void)
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 84b2b6c..3d17db9 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -23,6 +23,11 @@ struct mdev_parent {
 	struct list_head next;
 	struct kset *mdev_types_kset;
 	struct list_head type_list;
+	/* Protects unregistration to wait until create/remove
+	 * are completed.
+	 */
+	struct srcu_struct unreg_srcu;
+	struct mdev_parent __rcu *self;
 };
 
 struct mdev_device {
@@ -58,6 +63,6 @@ struct mdev_type {
 void mdev_remove_sysfs_files(struct device *dev, struct mdev_type *type);
 
 int  mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid);
-int  mdev_device_remove(struct device *dev, bool force_remove);
+int  mdev_device_remove(struct device *dev);
 
 #endif /* MDEV_PRIVATE_H */
diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index c782fa9..68a8191 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -236,11 +236,9 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (val && device_remove_file_self(dev, attr)) {
 		int ret;
 
-		ret = mdev_device_remove(dev, false);
-		if (ret) {
-			device_create_file(dev, attr);
+		ret = mdev_device_remove(dev);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return count;
-- 
1.8.3.1

