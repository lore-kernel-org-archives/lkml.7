Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7279F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6vG3Ryw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbfEXBBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:01:50 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40437 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbfEXBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:01:47 -0400
Received: by mail-qt1-f202.google.com with SMTP id 37so4411036qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iYnVK2VD7dXgk219JDN+y0uuA5LmcWu2ozSqT/x3Gx0=;
        b=h6vG3RywMpkLK2DTBamjZ8Uqf1d3pZJw3iVdq2lYkdwV2uN03YHpTp3js030aSG0sd
         TlaBNb1vadFcJpkBSF8CHArDuJqVJh1sjCVRYzTgAxWdfMHFDi319SN34vzrI81YspMP
         SYpaN77QmXhnEtD2wqfOi5T4WiYaUxVxwFZM2BKRCp5/wkKy1YAyUi5E/4Pj5o5Hz4qs
         LqyFjV4du6CNrsW51mQ/S3E6cOy7tvT8qh4Cb9YrnPwFS10LaBfujiKAQLWN1BzFkJkX
         tw+jTcn9d6zETTyJSEcZmJCZhXVpmHgL6JHjKeYn4NyfQqCccwU7X1TjTQ9bysAdWT4D
         QywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iYnVK2VD7dXgk219JDN+y0uuA5LmcWu2ozSqT/x3Gx0=;
        b=r2j5zvB6VubYO9zro6QOXGn07/l/PTVlxGgW/YulIbPOwO1qASnXrj2TL6yH9Iz3xX
         YrG3bUIShszy6QBVME9syMGxc86nZ46jkqQnboirHUEaPvJjvcpLL5HMWS/cEGjzfVlq
         sBwVMUCyGw0dkvR62NmpzAK3E1H+SPruVVru9bnfubag0ifBIPKDVsu9a9RnmPCzRf03
         32whMolDn4WGwspcR2u/urmJFkM77T6mtPqBsV0A3CrKINQmhvltq4bytL4ePoaInrdn
         oGtD/DGg9+m9GWQvSwMyGESerZd9qUJ50nvby+CF0CiRIbiJZQ6xQhGEs0vDRv5HT6MO
         K5Pg==
X-Gm-Message-State: APjAAAWD0aNFGi6vUHrvTJ93MTkk1PuhTyjx+sc020xXkSVNdtMHsmba
        V+4nwgXWdnHMJYqzA6XNlD4cjjw7/F0e+EY=
X-Google-Smtp-Source: APXvYqwDRh5ncgTUmFDPqd81INOpz1nqJ1SSauuwRKL5N2kg2CekpRGI8Zqdid9y0uL1cmOCqt0QDc7MGaJAtOM=
X-Received: by 2002:ac8:5446:: with SMTP id d6mr747422qtq.315.1558659706575;
 Thu, 23 May 2019 18:01:46 -0700 (PDT)
Date:   Thu, 23 May 2019 18:01:16 -0700
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Message-Id: <20190524010117.225219-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v1 5/5] driver core: Add sync_state driver/bus callback
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sync_state driver/bus callback is called once all the consumers
of a supplier have probed successfully.

This allows the supplier device's driver/bus to sync the supplier
device's state to the software state with the guarantee that all the
consumers are actively managing the resources provided by the supplier
device.

To maintain backwards compatibility and ease transition from existing
frameworks and resource cleanup schemes, late_initcall_sync is the
earliest when the sync_state callback might be called.

There is no upper bound on the time by which the sync_state callback
has to be called. This is because if a consumer device never probes,
the supplier has to maintain its resources in the state left by the
bootloader. For example, if the bootloader leaves the display
backlight at a fixed voltage and the backlight driver is never probed,
you don't want the backlight to ever be turned off after boot up.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c  |  9 +++++++++
 include/linux/device.h | 19 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9ab6782dda1c..7a8777a33e8c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,6 +46,7 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
+static bool supplier_sync_state_enabled;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -616,6 +617,41 @@ int device_links_check_suppliers(struct device *dev)
 	return ret;
 }
 
+static void __device_links_supplier_sync_state(struct device *dev)
+{
+	struct device_link *link;
+
+	if (dev->state_synced)
+		return;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+		if (link->status != DL_STATE_ACTIVE)
+			return;
+	}
+
+	if (dev->bus->sync_state)
+		dev->bus->sync_state(dev);
+	else if (dev->driver && dev->driver->sync_state)
+		dev->driver->sync_state(dev);
+
+	dev->state_synced = true;
+}
+
+int device_links_supplier_sync_state(struct device *dev, void *data)
+{
+	device_links_write_lock();
+	__device_links_supplier_sync_state(dev);
+	device_links_write_unlock();
+	return 0;
+}
+
+void device_links_supplier_sync_state_enable(void)
+{
+	supplier_sync_state_enabled = true;
+}
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
@@ -660,6 +696,9 @@ void device_links_driver_bound(struct device *dev)
 
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+
+		if (supplier_sync_state_enabled)
+			__device_links_supplier_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index da1aa52b310a..b5cce0c2496a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -604,6 +604,15 @@ static int __init of_platform_default_populate_init(void)
 	return 0;
 }
 arch_initcall_sync(of_platform_default_populate_init);
+
+static int __init of_platform_sync_state_init(void)
+{
+	device_links_supplier_sync_state_enable();
+	bus_for_each_dev(&platform_bus_type, NULL, NULL,
+			 device_links_supplier_sync_state);
+	return 0;
+}
+late_initcall_sync(of_platform_sync_state_init);
 #endif
 
 int of_platform_device_destroy(struct device *dev, void *data)
diff --git a/include/linux/device.h b/include/linux/device.h
index 4e71e5386aae..f6d5bba098df 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -79,6 +79,13 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		that generate uevents to add the environment variables.
  * @probe:	Called when a new device or driver add to this bus, and callback
  *		the specific driver's probe to initial the matched device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
  *
@@ -122,6 +129,7 @@ struct bus_type {
 	int (*match)(struct device *dev, struct device_driver *drv);
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 
@@ -251,6 +259,13 @@ enum probe_type {
  * @probe:	Called to query the existence of a specific device,
  *		whether this driver can work with it, and bind the driver
  *		to a specific device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
@@ -288,6 +303,7 @@ struct device_driver {
 	const struct acpi_device_id	*acpi_match_table;
 
 	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
@@ -1058,6 +1074,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			state_synced:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1400,6 +1417,8 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_link_wait_for_supplier(struct device *consumer);
 void device_link_check_waiting_consumers(
 		int (*add_suppliers)(struct device *consumer));
+int device_links_supplier_sync_state(struct device *dev, void *data);
+void device_links_supplier_sync_state_enable(void);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.rc1.257.g3120a18244-goog

