Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F97C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6562146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfC0DqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:46:04 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40541 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733039AbfC0DqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:46:00 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2019 05:45:58 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2R3jlGA031531;
        Wed, 27 Mar 2019 05:45:57 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv1 6/7] vfio/mdev: Fix aborting mdev child device removal if one fails
Date:   Tue, 26 Mar 2019 22:45:44 -0500
Message-Id: <1553658345-43995-7-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553658345-43995-1-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_for_each_child() stops executing callback function for remaining
child devices, if callback hits an error.
Each child mdev device is independent of each other.
While unregistering parent device, mdev core must remove all child mdev
devices.
Therefore, mdev_device_remove_cb() always returns success so that
device_for_each_child doesn't abort if one child removal hits error.

While at it, improve remove and unregister functions for below simplicity.

There isn't need to pass forced flag pointer during mdev parent
removal which invokes mdev_device_remove(). So simplify the flow.

mdev_device_remove() is called from two paths.
1. mdev_unregister_driver()
     mdev_device_remove_cb()
       mdev_device_remove()
2. remove_store()
     mdev_device_remove()

When device is removed by user using remote_store(), device under
removal is mdev device.
When device is removed during parent device removal using generic child
iterator, mdev check is already done using dev_is_mdev().

Hence, remove the unnecessary loop in mdev_device_remove().

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 836d319..aefcf34 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -149,10 +149,10 @@ static int mdev_device_remove_ops(struct mdev_device *mdev, bool force_remove)
 
 static int mdev_device_remove_cb(struct device *dev, void *data)
 {
-	if (!dev_is_mdev(dev))
-		return 0;
+	if (dev_is_mdev(dev))
+		mdev_device_remove(dev, true);
 
-	return mdev_device_remove(dev, data ? *(bool *)data : true);
+	return 0;
 }
 
 /*
@@ -240,7 +240,6 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 void mdev_unregister_device(struct device *dev)
 {
 	struct mdev_parent *parent;
-	bool force_remove = true;
 
 	mutex_lock(&parent_list_lock);
 	parent = __find_parent_device(dev);
@@ -254,8 +253,7 @@ void mdev_unregister_device(struct device *dev)
 	list_del(&parent->next);
 	class_compat_remove_link(mdev_bus_compat_class, dev, NULL);
 
-	device_for_each_child(dev, (void *)&force_remove,
-			      mdev_device_remove_cb);
+	device_for_each_child(dev, NULL, mdev_device_remove_cb);
 
 	parent_remove_sysfs_files(parent);
 
@@ -348,24 +346,13 @@ int mdev_device_create(struct kobject *kobj,
 
 int mdev_device_remove(struct device *dev, bool force_remove)
 {
-	struct mdev_device *mdev, *tmp;
+	struct mdev_device *mdev;
 	struct mdev_parent *parent;
 	struct mdev_type *type;
 	int ret;
 
 	mdev = to_mdev_device(dev);
-
 	mutex_lock(&mdev_list_lock);
-	list_for_each_entry(tmp, &mdev_list, next) {
-		if (tmp == mdev)
-			break;
-	}
-
-	if (tmp != mdev) {
-		mutex_unlock(&mdev_list_lock);
-		return -ENODEV;
-	}
-
 	if (!mdev->active) {
 		mutex_unlock(&mdev_list_lock);
 		return -EAGAIN;
-- 
1.8.3.1

