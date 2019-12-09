Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29969C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06262080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575920015;
	bh=lPGB69Ul9Z+to5pHDNq2b5gcrgJvKozGNnmvEu3SFDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7FRBxawc1d0KvEV30xzlQCVrUlKTUrTWg6yeRRwZGja4zKHaR9GQW4zYj0A0RCRQ
	 o5qAZC2Wh7ewamz7tCLYM4rkgBtqbbueXGJ5O8dDEDzvxNH0zdGGS6qqrv4Ka4tk5n
	 NiZTAk8HjpVXODEaB9PyHCCPofDiY30N0xqXZzPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLITdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfLITdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4E22080D;
        Mon,  9 Dec 2019 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575920010;
        bh=lPGB69Ul9Z+to5pHDNq2b5gcrgJvKozGNnmvEu3SFDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkqmy0lQnrOGWCEgn031HajNumfeaO0dcOMO5YDG4w+xuBHivXEX8VB6oxS9ap5My
         5+eY2h8Kx416w0GJ45TJE32rid5KRtU/IcYCQ5vd16ulwvfmAZow7cYtmI1/OnXpIN
         yPxZ6B5wF95dRub3mRyWxwPwSGGHVN5NGWAoIy7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6/6] device.h: move 'struct driver' stuff out to device/driver.h
Date:   Mon,  9 Dec 2019 20:33:03 +0100
Message-Id: <20191209193303.1694546-7-gregkh@linuxfoundation.org>
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
device things, so split out the struct driver things things to a
separate .h file to make things easier to maintain and manage over time.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/driver.c         |   1 +
 include/linux/device.h        | 272 +------------------------------
 include/linux/device/driver.h | 292 ++++++++++++++++++++++++++++++++++
 init/main.c                   |   2 +-
 4 files changed, 295 insertions(+), 272 deletions(-)
 create mode 100644 include/linux/device/driver.h

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 4e5ca632f35e..57c68769e157 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2007 Novell Inc.
  */
 
+#include <linux/device/driver.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
diff --git a/include/linux/device.h b/include/linux/device.h
index 2d697159bfbc..5cb4ff1d7601 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -28,6 +28,7 @@
 #include <linux/overflow.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
+#include <linux/device/driver.h>
 #include <asm/device.h>
 
 struct device;
@@ -45,227 +46,6 @@ struct iommu_fwspec;
 struct dev_pin_info;
 struct iommu_param;
 
-/**
- * enum probe_type - device driver probe type to try
- *	Device drivers may opt in for special handling of their
- *	respective probe routines. This tells the core what to
- *	expect and prefer.
- *
- * @PROBE_DEFAULT_STRATEGY: Used by drivers that work equally well
- *	whether probed synchronously or asynchronously.
- * @PROBE_PREFER_ASYNCHRONOUS: Drivers for "slow" devices which
- *	probing order is not essential for booting the system may
- *	opt into executing their probes asynchronously.
- * @PROBE_FORCE_SYNCHRONOUS: Use this to annotate drivers that need
- *	their probe routines to run synchronously with driver and
- *	device registration (with the exception of -EPROBE_DEFER
- *	handling - re-probing always ends up being done asynchronously).
- *
- * Note that the end goal is to switch the kernel to use asynchronous
- * probing by default, so annotating drivers with
- * %PROBE_PREFER_ASYNCHRONOUS is a temporary measure that allows us
- * to speed up boot process while we are validating the rest of the
- * drivers.
- */
-enum probe_type {
-	PROBE_DEFAULT_STRATEGY,
-	PROBE_PREFER_ASYNCHRONOUS,
-	PROBE_FORCE_SYNCHRONOUS,
-};
-
-/**
- * struct device_driver - The basic device driver structure
- * @name:	Name of the device driver.
- * @bus:	The bus which the device of this driver belongs to.
- * @owner:	The module owner.
- * @mod_name:	Used for built-in modules.
- * @suppress_bind_attrs: Disables bind/unbind via sysfs.
- * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
- * @of_match_table: The open firmware table.
- * @acpi_match_table: The ACPI match table.
- * @probe:	Called to query the existence of a specific device,
- *		whether this driver can work with it, and bind the driver
- *		to a specific device.
- * @sync_state:	Called to sync device state to software state after all the
- *		state tracking consumers linked to this device (present at
- *		the time of late_initcall) have successfully bound to a
- *		driver. If the device has no consumers, this function will
- *		be called at late_initcall_sync level. If the device has
- *		consumers that are never bound to a driver, this function
- *		will never get called until they do.
- * @remove:	Called when the device is removed from the system to
- *		unbind a device from this driver.
- * @shutdown:	Called at shut-down time to quiesce the device.
- * @suspend:	Called to put the device to sleep mode. Usually to a
- *		low power state.
- * @resume:	Called to bring a device from sleep mode.
- * @groups:	Default attributes that get created by the driver core
- *		automatically.
- * @dev_groups:	Additional attributes attached to device instance once the
- *		it is bound to the driver.
- * @pm:		Power management operations of the device which matched
- *		this driver.
- * @coredump:	Called when sysfs entry is written to. The device driver
- *		is expected to call the dev_coredump API resulting in a
- *		uevent.
- * @p:		Driver core's private data, no one other than the driver
- *		core can touch this.
- *
- * The device driver-model tracks all of the drivers known to the system.
- * The main reason for this tracking is to enable the driver core to match
- * up drivers with new devices. Once drivers are known objects within the
- * system, however, a number of other things become possible. Device drivers
- * can export information and configuration variables that are independent
- * of any specific device.
- */
-struct device_driver {
-	const char		*name;
-	struct bus_type		*bus;
-
-	struct module		*owner;
-	const char		*mod_name;	/* used for built-in modules */
-
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
-	enum probe_type probe_type;
-
-	const struct of_device_id	*of_match_table;
-	const struct acpi_device_id	*acpi_match_table;
-
-	int (*probe) (struct device *dev);
-	void (*sync_state)(struct device *dev);
-	int (*remove) (struct device *dev);
-	void (*shutdown) (struct device *dev);
-	int (*suspend) (struct device *dev, pm_message_t state);
-	int (*resume) (struct device *dev);
-	const struct attribute_group **groups;
-	const struct attribute_group **dev_groups;
-
-	const struct dev_pm_ops *pm;
-	void (*coredump) (struct device *dev);
-
-	struct driver_private *p;
-};
-
-
-extern int __must_check driver_register(struct device_driver *drv);
-extern void driver_unregister(struct device_driver *drv);
-
-extern struct device_driver *driver_find(const char *name,
-					 struct bus_type *bus);
-extern int driver_probe_done(void);
-extern void wait_for_device_probe(void);
-
-/* sysfs interface for exporting driver attributes */
-
-struct driver_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct device_driver *driver, char *buf);
-	ssize_t (*store)(struct device_driver *driver, const char *buf,
-			 size_t count);
-};
-
-#define DRIVER_ATTR_RW(_name) \
-	struct driver_attribute driver_attr_##_name = __ATTR_RW(_name)
-#define DRIVER_ATTR_RO(_name) \
-	struct driver_attribute driver_attr_##_name = __ATTR_RO(_name)
-#define DRIVER_ATTR_WO(_name) \
-	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
-
-extern int __must_check driver_create_file(struct device_driver *driver,
-					const struct driver_attribute *attr);
-extern void driver_remove_file(struct device_driver *driver,
-			       const struct driver_attribute *attr);
-
-extern int __must_check driver_for_each_device(struct device_driver *drv,
-					       struct device *start,
-					       void *data,
-					       int (*fn)(struct device *dev,
-							 void *));
-struct device *driver_find_device(struct device_driver *drv,
-				  struct device *start, const void *data,
-				  int (*match)(struct device *dev, const void *data));
-
-/**
- * driver_find_device_by_name - device iterator for locating a particular device
- * of a specific name.
- * @drv: the driver we're iterating
- * @name: name of the device to match
- */
-static inline struct device *driver_find_device_by_name(struct device_driver *drv,
-							const char *name)
-{
-	return driver_find_device(drv, NULL, name, device_match_name);
-}
-
-/**
- * driver_find_device_by_of_node- device iterator for locating a particular device
- * by of_node pointer.
- * @drv: the driver we're iterating
- * @np: of_node pointer to match.
- */
-static inline struct device *
-driver_find_device_by_of_node(struct device_driver *drv,
-			      const struct device_node *np)
-{
-	return driver_find_device(drv, NULL, np, device_match_of_node);
-}
-
-/**
- * driver_find_device_by_fwnode- device iterator for locating a particular device
- * by fwnode pointer.
- * @drv: the driver we're iterating
- * @fwnode: fwnode pointer to match.
- */
-static inline struct device *
-driver_find_device_by_fwnode(struct device_driver *drv,
-			     const struct fwnode_handle *fwnode)
-{
-	return driver_find_device(drv, NULL, fwnode, device_match_fwnode);
-}
-
-/**
- * driver_find_device_by_devt- device iterator for locating a particular device
- * by devt.
- * @drv: the driver we're iterating
- * @devt: devt pointer to match.
- */
-static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
-							dev_t devt)
-{
-	return driver_find_device(drv, NULL, &devt, device_match_devt);
-}
-
-static inline struct device *driver_find_next_device(struct device_driver *drv,
-						     struct device *start)
-{
-	return driver_find_device(drv, start, NULL, device_match_any);
-}
-
-#ifdef CONFIG_ACPI
-/**
- * driver_find_device_by_acpi_dev : device iterator for locating a particular
- * device matching the ACPI_COMPANION device.
- * @drv: the driver we're iterating
- * @adev: ACPI_COMPANION device to match.
- */
-static inline struct device *
-driver_find_device_by_acpi_dev(struct device_driver *drv,
-			       const struct acpi_device *adev)
-{
-	return driver_find_device(drv, NULL, adev, device_match_acpi_dev);
-}
-#else
-static inline struct device *
-driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
-{
-	return NULL;
-}
-#endif
-
-void driver_deferred_probe_add(struct device *dev);
-int driver_deferred_probe_check_state(struct device *dev);
-int driver_deferred_probe_check_state_continue(struct device *dev);
-
 /**
  * struct subsys_interface - interfaces to device functions
  * @name:       name of the device function
@@ -1018,8 +798,6 @@ static inline struct device_node *dev_of_node(struct device *dev)
 	return dev->of_node;
 }
 
-void driver_init(void);
-
 /*
  * High level routines for use by the bus drivers
  */
@@ -1193,52 +971,4 @@ extern long sysfs_deprecated;
 #define sysfs_deprecated 0
 #endif
 
-/**
- * module_driver() - Helper macro for drivers that don't do anything
- * special in module init/exit. This eliminates a lot of boilerplate.
- * Each module may only use this macro once, and calling it replaces
- * module_init() and module_exit().
- *
- * @__driver: driver name
- * @__register: register function for this driver type
- * @__unregister: unregister function for this driver type
- * @...: Additional arguments to be passed to __register and __unregister.
- *
- * Use this macro to construct bus specific macros for registering
- * drivers, and do not use it on its own.
- */
-#define module_driver(__driver, __register, __unregister, ...) \
-static int __init __driver##_init(void) \
-{ \
-	return __register(&(__driver) , ##__VA_ARGS__); \
-} \
-module_init(__driver##_init); \
-static void __exit __driver##_exit(void) \
-{ \
-	__unregister(&(__driver) , ##__VA_ARGS__); \
-} \
-module_exit(__driver##_exit);
-
-/**
- * builtin_driver() - Helper macro for drivers that don't do anything
- * special in init and have no exit. This eliminates some boilerplate.
- * Each driver may only use this macro once, and calling it replaces
- * device_initcall (or in some cases, the legacy __initcall).  This is
- * meant to be a direct parallel of module_driver() above but without
- * the __exit stuff that is not used for builtin cases.
- *
- * @__driver: driver name
- * @__register: register function for this driver type
- * @...: Additional arguments to be passed to __register
- *
- * Use this macro to construct bus specific macros for registering
- * drivers, and do not use it on its own.
- */
-#define builtin_driver(__driver, __register, ...) \
-static int __init __driver##_init(void) \
-{ \
-	return __register(&(__driver) , ##__VA_ARGS__); \
-} \
-device_initcall(__driver##_init);
-
 #endif /* _DEVICE_H_ */
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
new file mode 100644
index 000000000000..1188260f9a02
--- /dev/null
+++ b/include/linux/device/driver.h
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The driver-specific portions of the driver model
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
+#ifndef _DEVICE_DRIVER_H_
+#define _DEVICE_DRIVER_H_
+
+#include <linux/kobject.h>
+#include <linux/klist.h>
+#include <linux/pm.h>
+#include <linux/device/bus.h>
+
+/**
+ * enum probe_type - device driver probe type to try
+ *	Device drivers may opt in for special handling of their
+ *	respective probe routines. This tells the core what to
+ *	expect and prefer.
+ *
+ * @PROBE_DEFAULT_STRATEGY: Used by drivers that work equally well
+ *	whether probed synchronously or asynchronously.
+ * @PROBE_PREFER_ASYNCHRONOUS: Drivers for "slow" devices which
+ *	probing order is not essential for booting the system may
+ *	opt into executing their probes asynchronously.
+ * @PROBE_FORCE_SYNCHRONOUS: Use this to annotate drivers that need
+ *	their probe routines to run synchronously with driver and
+ *	device registration (with the exception of -EPROBE_DEFER
+ *	handling - re-probing always ends up being done asynchronously).
+ *
+ * Note that the end goal is to switch the kernel to use asynchronous
+ * probing by default, so annotating drivers with
+ * %PROBE_PREFER_ASYNCHRONOUS is a temporary measure that allows us
+ * to speed up boot process while we are validating the rest of the
+ * drivers.
+ */
+enum probe_type {
+	PROBE_DEFAULT_STRATEGY,
+	PROBE_PREFER_ASYNCHRONOUS,
+	PROBE_FORCE_SYNCHRONOUS,
+};
+
+/**
+ * struct device_driver - The basic device driver structure
+ * @name:	Name of the device driver.
+ * @bus:	The bus which the device of this driver belongs to.
+ * @owner:	The module owner.
+ * @mod_name:	Used for built-in modules.
+ * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
+ * @of_match_table: The open firmware table.
+ * @acpi_match_table: The ACPI match table.
+ * @probe:	Called to query the existence of a specific device,
+ *		whether this driver can work with it, and bind the driver
+ *		to a specific device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
+ * @remove:	Called when the device is removed from the system to
+ *		unbind a device from this driver.
+ * @shutdown:	Called at shut-down time to quiesce the device.
+ * @suspend:	Called to put the device to sleep mode. Usually to a
+ *		low power state.
+ * @resume:	Called to bring a device from sleep mode.
+ * @groups:	Default attributes that get created by the driver core
+ *		automatically.
+ * @dev_groups:	Additional attributes attached to device instance once the
+ *		it is bound to the driver.
+ * @pm:		Power management operations of the device which matched
+ *		this driver.
+ * @coredump:	Called when sysfs entry is written to. The device driver
+ *		is expected to call the dev_coredump API resulting in a
+ *		uevent.
+ * @p:		Driver core's private data, no one other than the driver
+ *		core can touch this.
+ *
+ * The device driver-model tracks all of the drivers known to the system.
+ * The main reason for this tracking is to enable the driver core to match
+ * up drivers with new devices. Once drivers are known objects within the
+ * system, however, a number of other things become possible. Device drivers
+ * can export information and configuration variables that are independent
+ * of any specific device.
+ */
+struct device_driver {
+	const char		*name;
+	struct bus_type		*bus;
+
+	struct module		*owner;
+	const char		*mod_name;	/* used for built-in modules */
+
+	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	enum probe_type probe_type;
+
+	const struct of_device_id	*of_match_table;
+	const struct acpi_device_id	*acpi_match_table;
+
+	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
+	int (*remove) (struct device *dev);
+	void (*shutdown) (struct device *dev);
+	int (*suspend) (struct device *dev, pm_message_t state);
+	int (*resume) (struct device *dev);
+	const struct attribute_group **groups;
+	const struct attribute_group **dev_groups;
+
+	const struct dev_pm_ops *pm;
+	void (*coredump) (struct device *dev);
+
+	struct driver_private *p;
+};
+
+
+extern int __must_check driver_register(struct device_driver *drv);
+extern void driver_unregister(struct device_driver *drv);
+
+extern struct device_driver *driver_find(const char *name,
+					 struct bus_type *bus);
+extern int driver_probe_done(void);
+extern void wait_for_device_probe(void);
+
+/* sysfs interface for exporting driver attributes */
+
+struct driver_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct device_driver *driver, char *buf);
+	ssize_t (*store)(struct device_driver *driver, const char *buf,
+			 size_t count);
+};
+
+#define DRIVER_ATTR_RW(_name) \
+	struct driver_attribute driver_attr_##_name = __ATTR_RW(_name)
+#define DRIVER_ATTR_RO(_name) \
+	struct driver_attribute driver_attr_##_name = __ATTR_RO(_name)
+#define DRIVER_ATTR_WO(_name) \
+	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
+
+extern int __must_check driver_create_file(struct device_driver *driver,
+					const struct driver_attribute *attr);
+extern void driver_remove_file(struct device_driver *driver,
+			       const struct driver_attribute *attr);
+
+extern int __must_check driver_for_each_device(struct device_driver *drv,
+					       struct device *start,
+					       void *data,
+					       int (*fn)(struct device *dev,
+							 void *));
+struct device *driver_find_device(struct device_driver *drv,
+				  struct device *start, const void *data,
+				  int (*match)(struct device *dev, const void *data));
+
+/**
+ * driver_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @drv: the driver we're iterating
+ * @name: name of the device to match
+ */
+static inline struct device *driver_find_device_by_name(struct device_driver *drv,
+							const char *name)
+{
+	return driver_find_device(drv, NULL, name, device_match_name);
+}
+
+/**
+ * driver_find_device_by_of_node- device iterator for locating a particular device
+ * by of_node pointer.
+ * @drv: the driver we're iterating
+ * @np: of_node pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_of_node(struct device_driver *drv,
+			      const struct device_node *np)
+{
+	return driver_find_device(drv, NULL, np, device_match_of_node);
+}
+
+/**
+ * driver_find_device_by_fwnode- device iterator for locating a particular device
+ * by fwnode pointer.
+ * @drv: the driver we're iterating
+ * @fwnode: fwnode pointer to match.
+ */
+static inline struct device *
+driver_find_device_by_fwnode(struct device_driver *drv,
+			     const struct fwnode_handle *fwnode)
+{
+	return driver_find_device(drv, NULL, fwnode, device_match_fwnode);
+}
+
+/**
+ * driver_find_device_by_devt- device iterator for locating a particular device
+ * by devt.
+ * @drv: the driver we're iterating
+ * @devt: devt pointer to match.
+ */
+static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
+							dev_t devt)
+{
+	return driver_find_device(drv, NULL, &devt, device_match_devt);
+}
+
+static inline struct device *driver_find_next_device(struct device_driver *drv,
+						     struct device *start)
+{
+	return driver_find_device(drv, start, NULL, device_match_any);
+}
+
+#ifdef CONFIG_ACPI
+/**
+ * driver_find_device_by_acpi_dev : device iterator for locating a particular
+ * device matching the ACPI_COMPANION device.
+ * @drv: the driver we're iterating
+ * @adev: ACPI_COMPANION device to match.
+ */
+static inline struct device *
+driver_find_device_by_acpi_dev(struct device_driver *drv,
+			       const struct acpi_device *adev)
+{
+	return driver_find_device(drv, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
+{
+	return NULL;
+}
+#endif
+
+void driver_deferred_probe_add(struct device *dev);
+int driver_deferred_probe_check_state(struct device *dev);
+int driver_deferred_probe_check_state_continue(struct device *dev);
+void driver_init(void);
+
+/**
+ * module_driver() - Helper macro for drivers that don't do anything
+ * special in module init/exit. This eliminates a lot of boilerplate.
+ * Each module may only use this macro once, and calling it replaces
+ * module_init() and module_exit().
+ *
+ * @__driver: driver name
+ * @__register: register function for this driver type
+ * @__unregister: unregister function for this driver type
+ * @...: Additional arguments to be passed to __register and __unregister.
+ *
+ * Use this macro to construct bus specific macros for registering
+ * drivers, and do not use it on its own.
+ */
+#define module_driver(__driver, __register, __unregister, ...) \
+static int __init __driver##_init(void) \
+{ \
+	return __register(&(__driver) , ##__VA_ARGS__); \
+} \
+module_init(__driver##_init); \
+static void __exit __driver##_exit(void) \
+{ \
+	__unregister(&(__driver) , ##__VA_ARGS__); \
+} \
+module_exit(__driver##_exit);
+
+/**
+ * builtin_driver() - Helper macro for drivers that don't do anything
+ * special in init and have no exit. This eliminates some boilerplate.
+ * Each driver may only use this macro once, and calling it replaces
+ * device_initcall (or in some cases, the legacy __initcall).  This is
+ * meant to be a direct parallel of module_driver() above but without
+ * the __exit stuff that is not used for builtin cases.
+ *
+ * @__driver: driver name
+ * @__register: register function for this driver type
+ * @...: Additional arguments to be passed to __register
+ *
+ * Use this macro to construct bus specific macros for registering
+ * drivers, and do not use it on its own.
+ */
+#define builtin_driver(__driver, __register, ...) \
+static int __init __driver##_init(void) \
+{ \
+	return __register(&(__driver) , ##__VA_ARGS__); \
+} \
+device_initcall(__driver##_init);
+
+#endif	/* _DEVICE_DRIVER_H_ */
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef0..dc50a803ea8f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -63,7 +63,7 @@
 #include <linux/lockdep.h>
 #include <linux/kmemleak.h>
 #include <linux/pid_namespace.h>
-#include <linux/device.h>
+#include <linux/device/driver.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/sched/init.h>
-- 
2.24.0

