Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7645C20723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFzpZuq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKNTmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:42:11 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33697 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:42:10 -0500
Received: by mail-pf1-f202.google.com with SMTP id s24so5484753pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nDZeHAIVCcvlS1IpbzKWQwBcP1GEe8ZhiOoImWGBCMw=;
        b=SFzpZuq331PQQWdOL6C1oY93Cfa68wkxNBtpyqOqUkJUbpqG4JIVKDYa33qCoPV9Wz
         R/xPa3Tv61lYo9SYslI4EiW2mDXgTY6YgUjxU1u+T7eZn29Dhne+tqF4lk0UWhpI+z+z
         BHQXPBNbDyr7jsU8EVj3hXj8FWxOIGJSC1dFaLh9QW7mHYk1PVaYRtdQjkyiBkjA8Jh5
         6lzhnLld3pGxMJpM/nKAnmz3dvdmhh7DDU9nqRjf7fQmAk/RYTknhxFV5mnD0BqYKFZz
         4kjWWPM8JBI1DH2tyyHM9mrsNm7VQ0NDMTAIGNVajYzaUEnsYfnooN/8KQnGytjxf972
         nl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nDZeHAIVCcvlS1IpbzKWQwBcP1GEe8ZhiOoImWGBCMw=;
        b=rTQAnKBHB3G6tGyOYM57/DFPs+/icIBZceCKLibaYxxieRIznypxof9jTYheo1YoC0
         q8wU1t804Z5BPZlOVs8yz7pBdfmafgtMESBlF50oZlmWpPL2AN5amSxJRuAR/wu8Yg9A
         BwCBfF7PhvuSbdVEZI/T3ZmJ6lHs+Xkf6fiyHJu49L1k0X4Uj0HIGPEgDMzqkJXHg0EC
         lUA93V7CmKbN8H/C5XzNgxIJ1+9jz0JoowEHAbjnvnXOHmzty7nFoNN4HYgIeR62t0vs
         6gGCAj7RPo7dm9xWANnnzozO94q3PHB75ySexw3dh69XO1C6zrlYLLgWfrWch5iCh1hJ
         sGBg==
X-Gm-Message-State: APjAAAWzSydbtqGLYUNmuNjCRR32xIdOAKMjLD0NPV1XM4hdBIN8w3Bi
        pH7+2Nn9X65gSL14ie5pBsJZjnK22mvUysY=
X-Google-Smtp-Source: APXvYqxaV4oUfjSMy5HB6U9u/V0i3mta7Rods96gV/75vde1xxEQQ9hCtT3zv07fthdhWynnEAMb8MoYxjpRm0Y=
X-Received: by 2002:a63:d703:: with SMTP id d3mr11723746pgg.102.1573760529527;
 Thu, 14 Nov 2019 11:42:09 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:42:05 -0800
Message-Id: <20191114194205.21730-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2] driver core: Allow device link operations inside sync_state()
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
 drivers/base/core.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e6d3e6d485da..2f14d4bf1472 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -48,6 +48,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
+static LIST_HEAD(sync_list);
+static DEFINE_MUTEX(sync_lock);
 static unsigned int defer_sync_state_count = 1;
 
 #ifdef CONFIG_SRCU
@@ -695,7 +697,23 @@ int device_links_check_suppliers(struct device *dev)
 	return ret;
 }
 
-static void __device_links_supplier_sync_state(struct device *dev)
+/** __device_links_queue_sync_state - Queue a device for sync_state() callback
+ * @dev: Device to call sync_state() on
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
+static void __device_links_queue_sync_state(struct device *dev)
 {
 	struct device_link *link;
 
@@ -709,12 +727,48 @@ static void __device_links_supplier_sync_state(struct device *dev)
 			return;
 	}
 
-	if (dev->bus->sync_state)
-		dev->bus->sync_state(dev);
-	else if (dev->driver && dev->driver->sync_state)
-		dev->driver->sync_state(dev);
-
+	/*
+	 * Set the flag here to avoid adding the same device to the sync_list
+	 * more than once. This can happen if new consumers get added to the
+	 * device before the sync_list is flushed.
+	 */
 	dev->state_synced = true;
+
+	mutex_lock(&sync_lock);
+
+	if (list_empty(&dev->links.defer_sync)) {
+		get_device(dev);
+		list_add_tail(&dev->links.defer_sync, &sync_list);
+	} else {
+		WARN_ON(1);
+	}
+
+	mutex_unlock(&sync_lock);
+}
+
+/** device_links_flush_sync_list - Call sync_state() on devices queued for it
+ *
+ * Calls sync_state() on all the devices that have been queued for it. This
+ * function is used in conjunction with __device_links_queue_sync_state().
+ */
+static void device_links_flush_sync_list(void)
+{
+	struct device *dev, *tmp;
+
+	mutex_lock(&sync_lock);
+
+	list_for_each_entry_safe(dev, tmp, &sync_list, links.defer_sync) {
+		list_del_init(&dev->links.defer_sync);
+		device_lock(dev);
+		if (dev->bus->sync_state)
+			dev->bus->sync_state(dev);
+		else if (dev->driver && dev->driver->sync_state)
+			dev->driver->sync_state(dev);
+		device_unlock(dev);
+		put_device(dev);
+	}
+
+	mutex_unlock(&sync_lock);
 }
 
 void device_links_supplier_sync_state_pause(void)
@@ -738,11 +792,16 @@ void device_links_supplier_sync_state_resume(void)
 		goto out;
 
 	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
-		__device_links_supplier_sync_state(dev);
+		/*
+		 * Delete from deferred_sync list before queuing it to
+		 * sync_list because defer_sync is used for both lists.
+		 */
 		list_del_init(&dev->links.defer_sync);
+		__device_links_queue_sync_state(dev);
 	}
 out:
 	device_links_write_unlock();
+	device_links_flush_sync_list();
 }
 
 static int sync_state_resume_initcall(void)
@@ -815,12 +874,13 @@ void device_links_driver_bound(struct device *dev)
 		if (defer_sync_state_count)
 			__device_links_supplier_defer_sync(link->supplier);
 		else
-			__device_links_supplier_sync_state(link->supplier);
+			__device_links_queue_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
 
 	device_links_write_unlock();
+	device_links_flush_sync_list();
 }
 
 static void device_link_drop_managed(struct device_link *link)
-- 
2.24.0.432.g9d3f5f5b63-goog

