Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94F2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emoZLf1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKMCgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:36:08 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33761 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKMCgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:36:07 -0500
Received: by mail-pf1-f202.google.com with SMTP id s24so448478pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dqYWcuqJCYF2DIwhal3vpOQp7Yt4OvsCSXwltwv2I6I=;
        b=emoZLf1Qo49INtXaIdJLRTXdz2Uh4QjL4oW3gRJeYVhbppMTroIiUNco5S8wyDYwCx
         Jlp3cwYDcEb6t/iqxxDqyGe/xCK4pHgDXK/rv4IXPYzSZZ1TLwGJ0zbJp9vRK3ndzWON
         dIvPdbWLcV5lj8CCgrpNQH3bFUIk9sSRsz20THh7HwPBAantg7ixIV0zkWHEs46/Euwx
         +zMtjKes5GDrucJawt/nHx6wg3KfID0CDh6HoUn8cMkWYjNc+HZA9xEtDL3lDtDF+mFQ
         GLqUzxuKctqUBglk6A0NRE7kz8X11XSl3WJ+KUMw9P+iBspaaISP3ts199yRghTCBzoq
         ceYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dqYWcuqJCYF2DIwhal3vpOQp7Yt4OvsCSXwltwv2I6I=;
        b=e0JZYATzGaqHTQLrtYpc9kzkkO36iSTZnk98raF1KeFngAmBesP0KbVm1dHzlZxNKR
         I1VgwtckbkC1z0qKsULVq3bgfuBTcVDq5jgwjOAVRBe1w1UWxTDRPgynsQrp6A6FxYM+
         vX/OQHlKS2Gq6e5fplJxqa/dkBnG3fA3fcNAphiI7tRvCJCp+bhCYMup3mO2jU2E97/B
         L+6G792T62z6SvRvVgJQLCx824Oh+sMXpXN6lg4yhycQ7IFs9yRj1/D8e7OSs3ZHlqjS
         JuPY4k63UT1ZruV+CLkiG3li5n+EiWnqQfkEy9TuCTXU3HCW4MO9S+XMWCwYbkXl+LdY
         BgdA==
X-Gm-Message-State: APjAAAXvtyLro69+Zin6I/haH5Uv4pr7lX5YegaPMT9lNZWz6yzi0V78
        cXyRA1i8iwRQy9E/4jUL57rRxSq6Em6CjMI=
X-Google-Smtp-Source: APXvYqxarlbUKIeBElLqSduGWPuRn1cTe50trKLzDRGJfSo+q4fddsrZNSGyeawCnk1tAD6yYMrXa4XVUx0Cc+k=
X-Received: by 2002:a63:f48:: with SMTP id 8mr874046pgp.329.1573612565147;
 Tue, 12 Nov 2019 18:36:05 -0800 (PST)
Date:   Tue, 12 Nov 2019 18:35:58 -0800
Message-Id: <20191113023559.62295-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1] driver core: Allow device link operations inside sync_state()
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
 drivers/base/core.c | 63 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e6d3e6d485da..d396b0597c10 100644
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
 
@@ -709,12 +727,35 @@ static void __device_links_supplier_sync_state(struct device *dev)
 			return;
 	}
 
-	if (dev->bus->sync_state)
-		dev->bus->sync_state(dev);
-	else if (dev->driver && dev->driver->sync_state)
-		dev->driver->sync_state(dev);
-
 	dev->state_synced = true;
+
+	mutex_lock(&sync_lock);
+	WARN_ON(!list_empty(&dev->links.defer_sync));
+	if (list_empty(&dev->links.defer_sync)) {
+		get_device(dev);
+		list_add_tail(&dev->links.defer_sync, &sync_list);
+	}
+	mutex_unlock(&sync_lock);
+}
+
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
@@ -738,11 +779,16 @@ void device_links_supplier_sync_state_resume(void)
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
@@ -815,12 +861,13 @@ void device_links_driver_bound(struct device *dev)
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
2.24.0.rc1.363.gb1bccd3e3d-goog

