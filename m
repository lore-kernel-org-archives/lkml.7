Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA34C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9818D2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fp9lMzTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGBAs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:48:28 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:34457 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfGBAs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:48:27 -0400
Received: by mail-ua1-f74.google.com with SMTP id d16so926014uaq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r4MU4SHJzzYyZ5/iUUPNCdYqyDak+GslVidR5J/lGww=;
        b=fp9lMzTmc3+Y9hHrp/XO10C5Tc8S4TXIeNNT3Ix4hZfkLU1Ya28g13jXO7HcNk4Iri
         aARBRWhigmXUlX0HRBaPh/my31XUjDoRO3Z3Gtmzpwl3AEsml019KDKi426WEqduQqac
         NA8c9NxDldjO8A4UR/MWT1lhbeZVCkb0BsYQM9Ax6bU9owEwo0ouJ+tDDGtzTaSxEqcB
         A4hwByDzB09oaXrHsXceDOfkN71nEQyawfShiiZNlm/TjYz8GklQOqBZVhov3aEbxq3g
         VfENBqGZACLPv4mAITY/KG1cMn8PHIsHn1QKL/wKQl13qNxIKLwCFvateHpQ/lo7NsSl
         Yw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r4MU4SHJzzYyZ5/iUUPNCdYqyDak+GslVidR5J/lGww=;
        b=cE1IH5SENNu9fUOkFbb4u0xx1zvv1zMKiQh21sLsJKN/YqR0BI/DGAEkOOpHUdbnUL
         SHnNRGDOFqyWL4PGE3bsdbBpUapkFs6N2kuDJ8jPdWjAYNhr8rKpNfYJKzGZvpgdeSlm
         xePPaRpl8gR4hfp7mYNi8tTh09FZ0ffZRoTTU0M2OTGWjylwegYi6gij9vgfJmY/CVrF
         GyB1RBQYo0g8jQiQI00ei0i+JzbV7yt8OpYvwy3KrhBmwACjg1qMQN5tQtkC/BOz5Zjb
         y3ZvwlRqHoUUv0zL/KozytEAUDNEE1gq8z7Wz4HBVYlmbUJaXClQ5Gkow8C0i03s3FNn
         Z+lg==
X-Gm-Message-State: APjAAAUWeSFfOv1w88cdEBzxsXNbvPI+RWb4twnpfikQk2VVRmifHlfw
        AeytdXvaqFC/peAp7VglHrZK5/ddwLCb1qs=
X-Google-Smtp-Source: APXvYqztO+88htZkcayPDsx0qngT6IzADYCywoWDkDyYZmscyCNXz1QvwyozxKmSxfzabx7ftSxNkfjS4dfmKEs=
X-Received: by 2002:a67:7d83:: with SMTP id y125mr16972170vsc.126.1562028505581;
 Mon, 01 Jul 2019 17:48:25 -0700 (PDT)
Date:   Mon,  1 Jul 2019 17:48:10 -0700
In-Reply-To: <20190702004811.136450-1-saravanak@google.com>
Message-Id: <20190702004811.136450-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 3/4] driver core: Add sync_state driver/bus callback
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
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
index 0705926d362f..8b8b812d26f1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,6 +46,7 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
+static bool supplier_sync_state_enabled;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -614,6 +615,41 @@ int device_links_check_suppliers(struct device *dev)
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
@@ -658,6 +694,9 @@ void device_links_driver_bound(struct device *dev)
 
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+
+		if (supplier_sync_state_enabled)
+			__device_links_supplier_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a53717168aca..ebafa2410045 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -596,6 +596,15 @@ static int __init of_platform_default_populate_init(void)
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
index 7f8ae7e5fc6b..4a0db34ae650 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -84,6 +84,13 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		in the future.
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
@@ -128,6 +135,7 @@ struct bus_type {
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	int (*add_links)(struct device *dev);
 	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 
@@ -257,6 +265,13 @@ enum probe_type {
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
@@ -294,6 +309,7 @@ struct device_driver {
 	const struct acpi_device_id	*acpi_match_table;
 
 	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
@@ -1065,6 +1081,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			state_synced:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1404,6 +1421,8 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+int device_links_supplier_sync_state(struct device *dev, void *data);
+void device_links_supplier_sync_state_enable(void);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.410.gd8fdbe21b5-goog

