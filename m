Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8256C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CF5216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI0yAGTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfG2WLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:11:24 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48875 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbfG2WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:11:20 -0400
Received: by mail-yw1-f73.google.com with SMTP id j144so46398978ywa.15
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N0L4iNekUGqJYZQaobiFZCt7hu/s6VKSbOUHPr5bUeE=;
        b=oI0yAGTDJSlRXI+V7s2NNNTNti8bavxPGDKV06+TUJflSNka8Pt5nUmUr6PDnRPOgr
         N8RXaR02DHGi2ncO8nMxBs/r8n3+ZWnRtskE5/z3oq70lfPpVUu97/75Vvdmj9CDtB5J
         MdQQqWYdTnLTOnEOanTIiXM/lIT7ucwxzhseQcQwCVNSWlRYzekmxOIg/JNIZvH/nJEb
         iWinrJcAuTewF8aNF1gprWtOncqV2IMVhWDjzdAQcE11BHAj+LSuKvHwF+8PFCnHGei/
         RDpd090z8PXXJgezKoAbKgvD2u4bU6RPjHKlx5H1q6jJHpSPul1jqU8vWFjBvPY85nJO
         SNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N0L4iNekUGqJYZQaobiFZCt7hu/s6VKSbOUHPr5bUeE=;
        b=Va7W6ZH0FdB2BQk5dM3nhq3Seo/F5bHGKa6Jy7ilCEh0FGMq5b9ZaPdWPx+rVZxsQt
         GNjsSK2HAKh3S5TIcfcHgKgS6FKZuPUPVp6JvnX9VmVQ8+lSFxI7QQeouigJPhS1CG3I
         QITQ7oAF2U/6XdwuIEWNt+jqDXfTZTt6oYdYD69zHiYbAxN5Sg+9zsq12AQMp4qGVGIT
         Q539B1YK8bhxnsn+p5JcUZqKXxOMkjK4mbAWMwECWwFNdnVE2oe2DrqbtqW9nmJUlGy9
         PdWvuIo3FE6L9NgeV0mrIUsKFOopZJMepnPflxrpDsR+wCgEU9CoVvah3NWdNJFia5Fw
         wmcA==
X-Gm-Message-State: APjAAAWlThNorav9mxiqJ1cJjuQyb/VUjb2+4w4Cwn10qindSeVNERug
        TifFy/gfR/NgLJhSGy5V2t5josHR5zt+4+Q=
X-Google-Smtp-Source: APXvYqzbfnt5cBCGPp0db7ynIs+brTHYMYqKaAzc/a1H4HymRR145HN2vNgUUlKxW72OyHCDN9T38MFmiNPzMLk=
X-Received: by 2002:a25:6346:: with SMTP id x67mr65226738ybb.346.1564438278861;
 Mon, 29 Jul 2019 15:11:18 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:10:58 -0700
In-Reply-To: <20190729221101.228240-1-saravanak@google.com>
Message-Id: <20190729221101.228240-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190729221101.228240-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v8 4/7] driver core: Add sync_state driver/bus callback
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

Also, when multiple devices are added after kernel init, some
suppliers could be added before their consumer devices get added. In
these instances, the supplier devices could get their sync_state
callback called right after they probe because the consumers devices
haven't had a chance to create device links to the suppliers.

To handle this correctly, this change also provides APIs to
pause/resume sync state callbacks so that when multiple devices are
added, their sync_state callback evaluation can be postponed to happen
after all of them are added.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 23 +++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fec2e8ae75fe..8528b5298e14 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,6 +46,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
+static LIST_HEAD(deferred_sync);
+static unsigned int supplier_sync_state_disabled;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -649,6 +651,62 @@ int device_links_check_suppliers(struct device *dev)
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
+		if (!(link->flags & DL_FLAG_MANAGED))
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
+void device_links_supplier_sync_state_pause(void)
+{
+	device_links_write_lock();
+	supplier_sync_state_disabled++;
+	device_links_write_unlock();
+}
+
+void device_links_supplier_sync_state_resume(void)
+{
+	struct device *dev, *tmp;
+
+	device_links_write_lock();
+	if (!supplier_sync_state_disabled) {
+		WARN(true, "Unmatched sync_state pause/resume!");
+		goto out;
+	}
+	supplier_sync_state_disabled--;
+	if (supplier_sync_state_disabled)
+		goto out;
+
+	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
+		__device_links_supplier_sync_state(dev);
+		list_del_init(&dev->links.defer_sync);
+	}
+out:
+	device_links_write_unlock();
+}
+
+static void __device_links_supplier_defer_sync(struct device *sup)
+{
+	if (list_empty(&sup->links.defer_sync))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
+}
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
@@ -693,6 +751,11 @@ void device_links_driver_bound(struct device *dev)
 
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+
+		if (supplier_sync_state_disabled)
+			__device_links_supplier_defer_sync(link->supplier);
+		else
+			__device_links_supplier_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
@@ -809,6 +872,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -1783,6 +1847,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
+	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index 65ac1fa40939..224d0126badc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -84,6 +84,8 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		available at the time this function is called.  As in, the
  *		function should NOT stop at the first failed device link if
  *		other unlinked supplier devices are present in the system.
+ *		This is necessary for the sync_state() callback to work
+ *		correctly.
  *
  *		Return 0 if device links have been successfully created to all
  *		the suppliers of this device.  Return an error if some of the
@@ -91,6 +93,13 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		reattempted in the future.
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
@@ -135,6 +144,7 @@ struct bus_type {
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	int (*add_links)(struct device *dev);
 	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 
@@ -280,6 +290,13 @@ enum probe_type {
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
@@ -318,6 +335,7 @@ struct device_driver {
 
 	int (*edit_links)(struct device *dev);
 	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
@@ -923,12 +941,14 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	struct list_head needs_suppliers;
+	struct list_head defer_sync;
 	enum dl_dev_state status;
 };
 
@@ -1101,6 +1121,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			has_edit_links:1;
+	bool			state_synced:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1445,6 +1466,8 @@ struct device_link *device_link_add(struct device *consumer,
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_link_remove_from_wfs(struct device *consumer);
+void device_links_supplier_sync_state_pause(void);
+void device_links_supplier_sync_state_resume(void);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.709.g102302147b-goog

