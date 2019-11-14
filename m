Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF931C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44962071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUMwx+xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKNWYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:24:00 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36436 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:24:00 -0500
Received: by mail-pf1-f201.google.com with SMTP id f21so5930843pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b6U6slm4w2TTC9uTYmfvzZw1H8jHw9pJ122PMPOdkGU=;
        b=sUMwx+xLJ29ogeKaGX45fuqum+jqv8BMVvsWujoygzA0FqxjkBL8pHYghuQcB8mfWQ
         XAypanXZTp9v/Sun6ITwMiJsp1bIEVvh2a89PWxiA8AgNhS2WNlH2urUHRUKQxC8EBFd
         lPzrVYXZ4cRygULSI3PN98n6rDF/vw3TPoPcRXVxx88cCh5YjcqzErwSFOLHjqWqzDKB
         fSgPPZxZrpToajqxV3UWw56eONNeFV4JoGIjR+UrWYPgTRTW3MyXnKxiCb3tmat7RajN
         VhbLtE2SzOFtluWWGQL1u+HeDK0V09KCQA6MMIfgRRXWBSeJLYurmq835bf9zq7IOJlJ
         gFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b6U6slm4w2TTC9uTYmfvzZw1H8jHw9pJ122PMPOdkGU=;
        b=afJfc3aeuGVj3jVOzSt2BDcIAFx61e5p4A9Ou2KDc8T06w3UTAuj2RrXSUDTzt8pUM
         9tAKn2lT1chpCQFzMkOA2Ya8sau+AzavVN9ecmdZjmlTfJSD3lGYuIx2GzeOW0z0POYz
         VFcc8xpeimQX1LU0lQM330pZvSrGB4YAjVVjF5UmOA0JiJsfqVhsXM/YUmkO/VUlfz77
         9JHKbujcgHrYwhWzpWgPK+3Dt81C4FRAZxqDhOUu7uROPUkxiehIGdkK2h88f9Um7O6P
         o3/Ij31gdvZwJq8g46Np4Aj4vwIM/Z79t+bexyLdpivs1qfiF4RtZMG/WmE/7UqM2OAb
         pn2g==
X-Gm-Message-State: APjAAAXiHMB0RwkMRkJjo0q49bw3PH5uR1U7wk8s/JBVHY7oYbBKCeL/
        dxo4454tQs1hmsisH8oP952hbB+z7CeUDX0=
X-Google-Smtp-Source: APXvYqwpb7tFKstuTKdGcosADXNJ2n0mc/S/imfqXloTmUWALuKFKLjJBQwK+h4f5wiPbof6ARvGblwN6Kzu6oQ=
X-Received: by 2002:a63:1624:: with SMTP id w36mr11853264pgl.404.1573770237263;
 Thu, 14 Nov 2019 14:23:57 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:23:48 -0800
Message-Id: <20191114222348.226355-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3] driver core: Allow device link operations inside sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sync_state() implementations might need to call APIs that in turn
make calls to device link APIs. So, do the sync_state() callbacks
without holding the device link lock.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e6d3e6d485da..9a88bcfd5d33 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -695,7 +695,26 @@ int device_links_check_suppliers(struct device *dev)
 	return ret;
 }
 
-static void __device_links_supplier_sync_state(struct device *dev)
+/**
+ * __device_links_queue_sync_state - Queue a device for sync_state() callback
+ * @dev: Device to call sync_state() on
+ * @list: List head to queue the @dev on
+ *
+ * Queues a device for a sync_state() callback when the device links write lock
+ * isn't held. This allows the sync_state() execution flow to use device links
+ * APIs.  The caller must ensure this function is called with
+ * device_links_write_lock() held.
+ *
+ * This function does a get_device() to make sure the device is not freed while
+ * on this list.
+ *
+ * So the caller must also ensure that device_links_flush_sync_list() is called
+ * as soon as the caller releases device_links_write_lock().  This is necessary
+ * to make sure the sync_state() is called in a timely fashion and the
+ * put_device() is called on this device.
+ */
+static void __device_links_queue_sync_state(struct device *dev,
+					    struct list_head *list)
 {
 	struct device_link *link;
 
@@ -709,12 +728,46 @@ static void __device_links_supplier_sync_state(struct device *dev)
 			return;
 	}
 
-	if (dev->bus->sync_state)
-		dev->bus->sync_state(dev);
-	else if (dev->driver && dev->driver->sync_state)
-		dev->driver->sync_state(dev);
-
+	/*
+	 * Set the flag here to avoid adding the same device to a list more
+	 * than once. This can happen if new consumers get added to the device
+	 * and probed before the list is flushed.
+	 */
 	dev->state_synced = true;
+
+	if (list_empty(&dev->links.defer_sync)) {
+		get_device(dev);
+		list_add_tail(&dev->links.defer_sync, list);
+	} else {
+		WARN_ON(1);
+	}
+}
+
+/**
+ * device_links_flush_sync_list - Call sync_state() on a list of devices
+ * @list: List of devices to call sync_state() on
+ *
+ * Calls sync_state() on all the devices that have been queued for it. This
+ * function is used in conjunction with __device_links_queue_sync_state().
+ */
+static void device_links_flush_sync_list(struct list_head *list)
+{
+	struct device *dev, *tmp;
+
+	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
+		list_del_init(&dev->links.defer_sync);
+
+		device_lock(dev);
+
+		if (dev->bus->sync_state)
+			dev->bus->sync_state(dev);
+		else if (dev->driver && dev->driver->sync_state)
+			dev->driver->sync_state(dev);
+
+		device_unlock(dev);
+
+		put_device(dev);
+	}
 }
 
 void device_links_supplier_sync_state_pause(void)
@@ -727,6 +780,7 @@ void device_links_supplier_sync_state_pause(void)
 void device_links_supplier_sync_state_resume(void)
 {
 	struct device *dev, *tmp;
+	LIST_HEAD(sync_list);
 
 	device_links_write_lock();
 	if (!defer_sync_state_count) {
@@ -738,11 +792,17 @@ void device_links_supplier_sync_state_resume(void)
 		goto out;
 
 	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
-		__device_links_supplier_sync_state(dev);
+		/*
+		 * Delete from deferred_sync list before queuing it to
+		 * sync_list because defer_sync is used for both lists.
+		 */
 		list_del_init(&dev->links.defer_sync);
+		__device_links_queue_sync_state(dev, &sync_list);
 	}
 out:
 	device_links_write_unlock();
+
+	device_links_flush_sync_list(&sync_list);
 }
 
 static int sync_state_resume_initcall(void)
@@ -772,6 +832,7 @@ static void __device_links_supplier_defer_sync(struct device *sup)
 void device_links_driver_bound(struct device *dev)
 {
 	struct device_link *link;
+	LIST_HEAD(sync_list);
 
 	/*
 	 * If a device probes successfully, it's expected to have created all
@@ -815,12 +876,15 @@ void device_links_driver_bound(struct device *dev)
 		if (defer_sync_state_count)
 			__device_links_supplier_defer_sync(link->supplier);
 		else
-			__device_links_supplier_sync_state(link->supplier);
+			__device_links_queue_sync_state(link->supplier,
+							&sync_list);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
 
 	device_links_write_unlock();
+
+	device_links_flush_sync_list(&sync_list);
 }
 
 static void device_link_drop_managed(struct device_link *link)
-- 
2.24.0.432.g9d3f5f5b63-goog

