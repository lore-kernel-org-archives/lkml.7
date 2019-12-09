Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEE320726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575920010;
	bh=1+4cv0elUsUtBtfbnQfqB0tdV1ghjpaZFmWqOWucRaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RqEJZjnZkTXDJjhbKQr04jcklhkEfWo1Z3Hvm00I77Bk4JIuL82TVlpiOih8V18s5
	 iEBl3+F/NLY0O1vxfjseRanJtmWjdxtA03pIN3v5ftrbszjrhEWODFK3OV8jX+dU0Z
	 A6d6rCixONHXQAdn4OhixwBJZQD/oiPLyG7qXQg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLITd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfLITd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68D420726;
        Mon,  9 Dec 2019 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575920005;
        bh=1+4cv0elUsUtBtfbnQfqB0tdV1ghjpaZFmWqOWucRaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGqDNFhQRgfhFBTE7V0R0dFE4mTws57wkx85kIz0C4qjpwxBmtH24g2xYqqOWxNfm
         vekjJ4kGBxJ6QfzWHRYZfXFcHrKm7Ni4dSCjIVCcKmB+u6zrrQuD5lrgHq6Ki9zEOc
         rXnpmjmCz3inQ2Bgw8sV7x11VGwPFCtpvFgir8RQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4/6] device.h: move 'struct bus' stuff out to device/bus.h
Date:   Mon,  9 Dec 2019 20:33:01 +0100
Message-Id: <20191209193303.1694546-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device.h has everything and the kitchen sink when it comes to struct
device things, so split out the struct bus things things to a separate
.h file to make things easier to maintain and manage over time.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         |   1 +
 include/linux/device.h     | 265 +---------------------------------
 include/linux/device/bus.h | 288 +++++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+), 264 deletions(-)
 create mode 100644 include/linux/device/bus.h

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a1d1e8256324..886e9054999a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/async.h>
+#include <linux/device/bus.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
diff --git a/include/linux/device.h b/include/linux/device.h
index 7a00f25efef7..cb0ea7e66d53 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -26,6 +26,7 @@
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
+#include <linux/device/bus.h>
 #include <asm/device.h>
 
 struct device;
@@ -35,7 +36,6 @@ struct driver_private;
 struct module;
 struct class;
 struct subsys_private;
-struct bus_type;
 struct device_node;
 struct fwnode_handle;
 struct iommu_ops;
@@ -44,269 +44,6 @@ struct iommu_fwspec;
 struct dev_pin_info;
 struct iommu_param;
 
-struct bus_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct bus_type *bus, char *buf);
-	ssize_t (*store)(struct bus_type *bus, const char *buf, size_t count);
-};
-
-#define BUS_ATTR_RW(_name) \
-	struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
-#define BUS_ATTR_RO(_name) \
-	struct bus_attribute bus_attr_##_name = __ATTR_RO(_name)
-#define BUS_ATTR_WO(_name) \
-	struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
-
-extern int __must_check bus_create_file(struct bus_type *,
-					struct bus_attribute *);
-extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
-
-/**
- * struct bus_type - The bus type of the device
- *
- * @name:	The name of the bus.
- * @dev_name:	Used for subsystems to enumerate devices like ("foo%u", dev->id).
- * @dev_root:	Default device to use as the parent.
- * @bus_groups:	Default attributes of the bus.
- * @dev_groups:	Default attributes of the devices on the bus.
- * @drv_groups: Default attributes of the device drivers on the bus.
- * @match:	Called, perhaps multiple times, whenever a new device or driver
- *		is added for this bus. It should return a positive value if the
- *		given device can be handled by the given driver and zero
- *		otherwise. It may also return error code if determining that
- *		the driver supports the device is not possible. In case of
- *		-EPROBE_DEFER it will queue the device for deferred probing.
- * @uevent:	Called when a device is added, removed, or a few other things
- *		that generate uevents to add the environment variables.
- * @probe:	Called when a new device or driver add to this bus, and callback
- *		the specific driver's probe to initial the matched device.
- * @sync_state:	Called to sync device state to software state after all the
- *		state tracking consumers linked to this device (present at
- *		the time of late_initcall) have successfully bound to a
- *		driver. If the device has no consumers, this function will
- *		be called at late_initcall_sync level. If the device has
- *		consumers that are never bound to a driver, this function
- *		will never get called until they do.
- * @remove:	Called when a device removed from this bus.
- * @shutdown:	Called at shut-down time to quiesce the device.
- *
- * @online:	Called to put the device back online (after offlining it).
- * @offline:	Called to put the device offline for hot-removal. May fail.
- *
- * @suspend:	Called when a device on this bus wants to go to sleep mode.
- * @resume:	Called to bring a device on this bus out of sleep mode.
- * @num_vf:	Called to find out how many virtual functions a device on this
- *		bus supports.
- * @dma_configure:	Called to setup DMA configuration on a device on
- *			this bus.
- * @pm:		Power management operations of this bus, callback the specific
- *		device driver's pm-ops.
- * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
- *              driver implementations to a bus and allow the driver to do
- *              bus-specific setup
- * @p:		The private data of the driver core, only the driver core can
- *		touch this.
- * @lock_key:	Lock class key for use by the lock validator
- * @need_parent_lock:	When probing or removing a device on this bus, the
- *			device core should lock the device's parent.
- *
- * A bus is a channel between the processor and one or more devices. For the
- * purposes of the device model, all devices are connected via a bus, even if
- * it is an internal, virtual, "platform" bus. Buses can plug into each other.
- * A USB controller is usually a PCI device, for example. The device model
- * represents the actual connections between buses and the devices they control.
- * A bus is represented by the bus_type structure. It contains the name, the
- * default attributes, the bus' methods, PM operations, and the driver core's
- * private data.
- */
-struct bus_type {
-	const char		*name;
-	const char		*dev_name;
-	struct device		*dev_root;
-	const struct attribute_group **bus_groups;
-	const struct attribute_group **dev_groups;
-	const struct attribute_group **drv_groups;
-
-	int (*match)(struct device *dev, struct device_driver *drv);
-	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
-	int (*probe)(struct device *dev);
-	void (*sync_state)(struct device *dev);
-	int (*remove)(struct device *dev);
-	void (*shutdown)(struct device *dev);
-
-	int (*online)(struct device *dev);
-	int (*offline)(struct device *dev);
-
-	int (*suspend)(struct device *dev, pm_message_t state);
-	int (*resume)(struct device *dev);
-
-	int (*num_vf)(struct device *dev);
-
-	int (*dma_configure)(struct device *dev);
-
-	const struct dev_pm_ops *pm;
-
-	const struct iommu_ops *iommu_ops;
-
-	struct subsys_private *p;
-	struct lock_class_key lock_key;
-
-	bool need_parent_lock;
-};
-
-extern int __must_check bus_register(struct bus_type *bus);
-
-extern void bus_unregister(struct bus_type *bus);
-
-extern int __must_check bus_rescan_devices(struct bus_type *bus);
-
-/* iterator helpers for buses */
-struct subsys_dev_iter {
-	struct klist_iter		ki;
-	const struct device_type	*type;
-};
-void subsys_dev_iter_init(struct subsys_dev_iter *iter,
-			 struct bus_type *subsys,
-			 struct device *start,
-			 const struct device_type *type);
-struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
-void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
-
-int device_match_name(struct device *dev, const void *name);
-int device_match_of_node(struct device *dev, const void *np);
-int device_match_fwnode(struct device *dev, const void *fwnode);
-int device_match_devt(struct device *dev, const void *pdevt);
-int device_match_acpi_dev(struct device *dev, const void *adev);
-int device_match_any(struct device *dev, const void *unused);
-
-int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
-		     int (*fn)(struct device *dev, void *data));
-struct device *bus_find_device(struct bus_type *bus, struct device *start,
-			       const void *data,
-			       int (*match)(struct device *dev, const void *data));
-/**
- * bus_find_device_by_name - device iterator for locating a particular device
- * of a specific name.
- * @bus: bus type
- * @start: Device to begin with
- * @name: name of the device to match
- */
-static inline struct device *bus_find_device_by_name(struct bus_type *bus,
-						     struct device *start,
-						     const char *name)
-{
-	return bus_find_device(bus, start, name, device_match_name);
-}
-
-/**
- * bus_find_device_by_of_node : device iterator for locating a particular device
- * matching the of_node.
- * @bus: bus type
- * @np: of_node of the device to match.
- */
-static inline struct device *
-bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
-{
-	return bus_find_device(bus, NULL, np, device_match_of_node);
-}
-
-/**
- * bus_find_device_by_fwnode : device iterator for locating a particular device
- * matching the fwnode.
- * @bus: bus type
- * @fwnode: fwnode of the device to match.
- */
-static inline struct device *
-bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwnode)
-{
-	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
-}
-
-/**
- * bus_find_device_by_devt : device iterator for locating a particular device
- * matching the device type.
- * @bus: bus type
- * @devt: device type of the device to match.
- */
-static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
-						     dev_t devt)
-{
-	return bus_find_device(bus, NULL, &devt, device_match_devt);
-}
-
-/**
- * bus_find_next_device - Find the next device after a given device in a
- * given bus.
- * @bus: bus type
- * @cur: device to begin the search with.
- */
-static inline struct device *
-bus_find_next_device(struct bus_type *bus,struct device *cur)
-{
-	return bus_find_device(bus, cur, NULL, device_match_any);
-}
-
-#ifdef CONFIG_ACPI
-struct acpi_device;
-
-/**
- * bus_find_device_by_acpi_dev : device iterator for locating a particular device
- * matching the ACPI COMPANION device.
- * @bus: bus type
- * @adev: ACPI COMPANION device to match.
- */
-static inline struct device *
-bus_find_device_by_acpi_dev(struct bus_type *bus, const struct acpi_device *adev)
-{
-	return bus_find_device(bus, NULL, adev, device_match_acpi_dev);
-}
-#else
-static inline struct device *
-bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
-{
-	return NULL;
-}
-#endif
-
-struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
-					struct device *hint);
-int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-		     void *data, int (*fn)(struct device_driver *, void *));
-void bus_sort_breadthfirst(struct bus_type *bus,
-			   int (*compare)(const struct device *a,
-					  const struct device *b));
-/*
- * Bus notifiers: Get notified of addition/removal of devices
- * and binding/unbinding of drivers to devices.
- * In the long run, it should be a replacement for the platform
- * notify hooks.
- */
-struct notifier_block;
-
-extern int bus_register_notifier(struct bus_type *bus,
-				 struct notifier_block *nb);
-extern int bus_unregister_notifier(struct bus_type *bus,
-				   struct notifier_block *nb);
-
-/* All 4 notifers below get called with the target struct device *
- * as an argument. Note that those functions are likely to be called
- * with the device lock held in the core, so be careful.
- */
-#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
-#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
-#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
-#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
-						      bound */
-#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
-#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
-						      unbound */
-#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
-						      from the device */
-#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
-
-extern struct kset *bus_get_kset(struct bus_type *bus);
-extern struct klist *bus_get_device_klist(struct bus_type *bus);
-
 /**
  * enum probe_type - device driver probe type to try
  *	Device drivers may opt in for special handling of their
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
new file mode 100644
index 000000000000..1ea5e1d1545b
--- /dev/null
+++ b/include/linux/device/bus.h
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * bus.h - the bus-specific portions of the driver model
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ * Copyright (c) 2012-2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2012-2019 Linux Foundation
+ *
+ * See Documentation/driver-api/driver-model/ for more information.
+ */
+
+#ifndef _DEVICE_BUS_H_
+#define _DEVICE_BUS_H_
+
+#include <linux/kobject.h>
+#include <linux/klist.h>
+#include <linux/pm.h>
+
+struct device_driver;
+struct fwnode_handle;
+
+/**
+ * struct bus_type - The bus type of the device
+ *
+ * @name:	The name of the bus.
+ * @dev_name:	Used for subsystems to enumerate devices like ("foo%u", dev->id).
+ * @dev_root:	Default device to use as the parent.
+ * @bus_groups:	Default attributes of the bus.
+ * @dev_groups:	Default attributes of the devices on the bus.
+ * @drv_groups: Default attributes of the device drivers on the bus.
+ * @match:	Called, perhaps multiple times, whenever a new device or driver
+ *		is added for this bus. It should return a positive value if the
+ *		given device can be handled by the given driver and zero
+ *		otherwise. It may also return error code if determining that
+ *		the driver supports the device is not possible. In case of
+ *		-EPROBE_DEFER it will queue the device for deferred probing.
+ * @uevent:	Called when a device is added, removed, or a few other things
+ *		that generate uevents to add the environment variables.
+ * @probe:	Called when a new device or driver add to this bus, and callback
+ *		the specific driver's probe to initial the matched device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
+ * @remove:	Called when a device removed from this bus.
+ * @shutdown:	Called at shut-down time to quiesce the device.
+ *
+ * @online:	Called to put the device back online (after offlining it).
+ * @offline:	Called to put the device offline for hot-removal. May fail.
+ *
+ * @suspend:	Called when a device on this bus wants to go to sleep mode.
+ * @resume:	Called to bring a device on this bus out of sleep mode.
+ * @num_vf:	Called to find out how many virtual functions a device on this
+ *		bus supports.
+ * @dma_configure:	Called to setup DMA configuration on a device on
+ *			this bus.
+ * @pm:		Power management operations of this bus, callback the specific
+ *		device driver's pm-ops.
+ * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
+ *              driver implementations to a bus and allow the driver to do
+ *              bus-specific setup
+ * @p:		The private data of the driver core, only the driver core can
+ *		touch this.
+ * @lock_key:	Lock class key for use by the lock validator
+ * @need_parent_lock:	When probing or removing a device on this bus, the
+ *			device core should lock the device's parent.
+ *
+ * A bus is a channel between the processor and one or more devices. For the
+ * purposes of the device model, all devices are connected via a bus, even if
+ * it is an internal, virtual, "platform" bus. Buses can plug into each other.
+ * A USB controller is usually a PCI device, for example. The device model
+ * represents the actual connections between buses and the devices they control.
+ * A bus is represented by the bus_type structure. It contains the name, the
+ * default attributes, the bus' methods, PM operations, and the driver core's
+ * private data.
+ */
+struct bus_type {
+	const char		*name;
+	const char		*dev_name;
+	struct device		*dev_root;
+	const struct attribute_group **bus_groups;
+	const struct attribute_group **dev_groups;
+	const struct attribute_group **drv_groups;
+
+	int (*match)(struct device *dev, struct device_driver *drv);
+	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
+	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
+	int (*remove)(struct device *dev);
+	void (*shutdown)(struct device *dev);
+
+	int (*online)(struct device *dev);
+	int (*offline)(struct device *dev);
+
+	int (*suspend)(struct device *dev, pm_message_t state);
+	int (*resume)(struct device *dev);
+
+	int (*num_vf)(struct device *dev);
+
+	int (*dma_configure)(struct device *dev);
+
+	const struct dev_pm_ops *pm;
+
+	const struct iommu_ops *iommu_ops;
+
+	struct subsys_private *p;
+	struct lock_class_key lock_key;
+
+	bool need_parent_lock;
+};
+
+extern int __must_check bus_register(struct bus_type *bus);
+
+extern void bus_unregister(struct bus_type *bus);
+
+extern int __must_check bus_rescan_devices(struct bus_type *bus);
+
+struct bus_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct bus_type *bus, char *buf);
+	ssize_t (*store)(struct bus_type *bus, const char *buf, size_t count);
+};
+
+#define BUS_ATTR_RW(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
+#define BUS_ATTR_RO(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_RO(_name)
+#define BUS_ATTR_WO(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
+
+extern int __must_check bus_create_file(struct bus_type *,
+					struct bus_attribute *);
+extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
+
+/* Generic device matching functions that all busses can use to match with */
+int device_match_name(struct device *dev, const void *name);
+int device_match_of_node(struct device *dev, const void *np);
+int device_match_fwnode(struct device *dev, const void *fwnode);
+int device_match_devt(struct device *dev, const void *pdevt);
+int device_match_acpi_dev(struct device *dev, const void *adev);
+int device_match_any(struct device *dev, const void *unused);
+
+/* iterator helpers for buses */
+struct subsys_dev_iter {
+	struct klist_iter		ki;
+	const struct device_type	*type;
+};
+void subsys_dev_iter_init(struct subsys_dev_iter *iter,
+			 struct bus_type *subsys,
+			 struct device *start,
+			 const struct device_type *type);
+struct device *subsys_dev_iter_next(struct subsys_dev_iter *iter);
+void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
+
+int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
+		     int (*fn)(struct device *dev, void *data));
+struct device *bus_find_device(struct bus_type *bus, struct device *start,
+			       const void *data,
+			       int (*match)(struct device *dev, const void *data));
+/**
+ * bus_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @name: name of the device to match
+ */
+static inline struct device *bus_find_device_by_name(struct bus_type *bus,
+						     struct device *start,
+						     const char *name)
+{
+	return bus_find_device(bus, start, name, device_match_name);
+}
+
+/**
+ * bus_find_device_by_of_node : device iterator for locating a particular device
+ * matching the of_node.
+ * @bus: bus type
+ * @np: of_node of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
+{
+	return bus_find_device(bus, NULL, np, device_match_of_node);
+}
+
+/**
+ * bus_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @bus: bus type
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwnode)
+{
+	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
+}
+
+/**
+ * bus_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @bus: bus type
+ * @devt: device type of the device to match.
+ */
+static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
+						     dev_t devt)
+{
+	return bus_find_device(bus, NULL, &devt, device_match_devt);
+}
+
+/**
+ * bus_find_next_device - Find the next device after a given device in a
+ * given bus.
+ * @bus: bus type
+ * @cur: device to begin the search with.
+ */
+static inline struct device *
+bus_find_next_device(struct bus_type *bus,struct device *cur)
+{
+	return bus_find_device(bus, cur, NULL, device_match_any);
+}
+
+#ifdef CONFIG_ACPI
+struct acpi_device;
+
+/**
+ * bus_find_device_by_acpi_dev : device iterator for locating a particular device
+ * matching the ACPI COMPANION device.
+ * @bus: bus type
+ * @adev: ACPI COMPANION device to match.
+ */
+static inline struct device *
+bus_find_device_by_acpi_dev(struct bus_type *bus, const struct acpi_device *adev)
+{
+	return bus_find_device(bus, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+bus_find_device_by_acpi_dev(struct bus_type *bus, const void *adev)
+{
+	return NULL;
+}
+#endif
+
+struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
+					struct device *hint);
+int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
+		     void *data, int (*fn)(struct device_driver *, void *));
+void bus_sort_breadthfirst(struct bus_type *bus,
+			   int (*compare)(const struct device *a,
+					  const struct device *b));
+/*
+ * Bus notifiers: Get notified of addition/removal of devices
+ * and binding/unbinding of drivers to devices.
+ * In the long run, it should be a replacement for the platform
+ * notify hooks.
+ */
+struct notifier_block;
+
+extern int bus_register_notifier(struct bus_type *bus,
+				 struct notifier_block *nb);
+extern int bus_unregister_notifier(struct bus_type *bus,
+				   struct notifier_block *nb);
+
+/* All 4 notifers below get called with the target struct device *
+ * as an argument. Note that those functions are likely to be called
+ * with the device lock held in the core, so be careful.
+ */
+#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
+#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
+#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
+#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
+						      bound */
+#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
+#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
+						      unbound */
+#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
+						      from the device */
+#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
+
+extern struct kset *bus_get_kset(struct bus_type *bus);
+extern struct klist *bus_get_device_klist(struct bus_type *bus);
+
+#endif
-- 
2.24.0

