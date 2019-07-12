Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A76EC742DD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5348620874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZCr2g6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGLXxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33885 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfGLXw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:52:59 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so6464106pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1hfAR7BJm0sl3XPWVF757MMKVHLS5GkBR3sqRxDFXmo=;
        b=NZCr2g6j2XTVkDM8sddBX9CA+DZ+f7VYb+AfIh7DRGhfxple/RYPVAvjuZaD9ct75F
         +/nD5txyHUGrW6AH7QzN0Yd5ZRYeOEbPWMQ2q79jGdyIHcFgmC482AI7pTVC/gJmh+AL
         Xyu4rt5d1voQ6EmaVCdGLJrca/EUrKX/naRxLX1fw90dUnZQdR3s0YBzpbHOdyZT/ShG
         JPyrQHtvyAEHYHrqn2SusHz8TuwVS7ZBrgzAiB7fUv4lDOaW9EpLvx/B1rulgpqZw9kw
         XSwxzsEvOh2AJf4CvEEdp3GECtkOn+mK80Pamo4lug5whKHoFCXRv1we+cxURpsN4Hdk
         fXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1hfAR7BJm0sl3XPWVF757MMKVHLS5GkBR3sqRxDFXmo=;
        b=m5oh1XB1dJgo4sLRL1XOq/kf2Vs/6HMTcofxWAcaGninhHOvNVhxqkw/iqhDqd1h7q
         695GnsRkKNIEohzQ55BGov0wHlpCiumj3BI8U+ibhomhH4TQ+sanURdAB63cEpdLCDUV
         MvgvOttdg0mJODz2vkxyMY1+XNTjwUAcn6lDKe764rIYxu3BnKIBNpAdlf+412mQ+f+A
         cc+LA80zOgNCHfmBnxCsNEmnyYrCrXwmFlODQY3nrWm+tqGM2fgvNiMR1Ven6hf5i11X
         FwrhZOtxzcxgepwKw5UwbHbknOYKMHK8lbfSxrQDR+pipFBWNJfssiRvL7/MQBelBD7y
         AkPw==
X-Gm-Message-State: APjAAAWQsUnG1ej7+ZdMIIe8tPJ5ja1zMwvrzvEg0oHM/OlEx+inAS1C
        R//2D/D7dFlmm0BAaQRBZjvq/yOtyja+4pM=
X-Google-Smtp-Source: APXvYqyn05EQCLzIXw17cC7j+//sPfbdO/T5uCdhNZS/3v31ukGZAoMdQAI2fvB/ZGSY0BPYyNyCugk1o+yR52I=
X-Received: by 2002:a63:d950:: with SMTP id e16mr14668466pgj.271.1562975578822;
 Fri, 12 Jul 2019 16:52:58 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:36 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 03/11] driver core: Add sync_state driver/bus callback
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
index 0930f9f89571..4d12d6658999 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -601,6 +601,15 @@ static int __init of_platform_default_populate_init(void)
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
2.22.0.510.g264f2c817a-goog

