Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C942186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfCAFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:07 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42671 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbfCAFiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:05 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:01 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYW016903;
        Fri, 1 Mar 2019 07:37:58 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 1/8] subdev: Introducing subdev bus
Date:   Thu, 28 Feb 2019 23:37:45 -0600
Message-Id: <1551418672-12822-2-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new subdev bus which holds sub devices created from a
primary device. These devices are named as 'subdev'.
A subdev is identified similarly to pci device using 16-bit vendor id
and device id.
Unlike PCI devices, scope of subdev is limited to Linux kernel.
A central entry that assigns unique subdev vendor and device id is:
include/linux/subdev_ids.h enums. Enum are chosen over define macro so
that two vendors do not end up with vendor id in kernel development
process.

subdev bus holds subdevices of multiple devices. A typical created
subdev for a PCI device in sysfs tree appears under their parent's
device as using core's default device naming scheme:

subdev<instance_id>.
i.e.
subdev0
subdev1

$ ls -l /sys/bus/pci/devices/0000:05:00.0
[..]
drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev0
drwxr-xr-x 4 root root        0 Feb 13 15:57 subvdev1

Device model view:
------------------
               +------+    +------+       +------+
               |subdev|    |subdev|       |subdev|
          -----|  1   |----|  2   |-------|  3   |----------
          |    +--|---+    +-|----+       +--|---+         |
          --------|----------|---subdev bus--|--------------
                  |          |               |
               +--+----+-----+           +---+---+
               |pcidev |                 |pcidev |
          -----|   A   |-----------------|   B   |----------
          |    +-------+                 +-------+         |
          -------------------pci bus------------------------

subdev are allocated and freed using subdev_alloc(), subdev_free() APIs.
A driver which wants to create actual class driver such as
net/block/infiniband need to use subdev_register_driver(),
subdev_unregister_driver() APIs.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/subdev/Kconfig          |  12 ++++
 drivers/subdev/Makefile         |   8 +++
 drivers/subdev/subdev_main.c    | 153 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  12 ++++
 include/linux/subdev_bus.h      |  63 +++++++++++++++++
 include/linux/subdev_ids.h      |  17 +++++
 8 files changed, 268 insertions(+)
 create mode 100644 drivers/subdev/Kconfig
 create mode 100644 drivers/subdev/Makefile
 create mode 100644 drivers/subdev/subdev_main.c
 create mode 100644 include/linux/subdev_bus.h
 create mode 100644 include/linux/subdev_ids.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4f9f990..1818796 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/subdev/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index e1ce029..a040e96 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
+obj-$(CONFIG_SUBDEV)		+= subdev/
diff --git a/drivers/subdev/Kconfig b/drivers/subdev/Kconfig
new file mode 100644
index 0000000..8ce3acc
--- /dev/null
+++ b/drivers/subdev/Kconfig
@@ -0,0 +1,12 @@
+#
+# subdev configuration
+#
+
+config SUBDEV
+	tristate "subdev bus driver"
+	help
+	The subdev bus driver allows creating hardware based sub devices
+	from a parent device. The subdev bus driver is required to create,
+	discover devices and to attach device drivers to this subdev
+	devices. These subdev devices are created using devlink tool by
+	user.
diff --git a/drivers/subdev/Makefile b/drivers/subdev/Makefile
new file mode 100644
index 0000000..405b74a
--- /dev/null
+++ b/drivers/subdev/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for subdev bus driver
+#
+
+obj-$(CONFIG_SUBDEV)	+= subdev.o
+
+subdev-y := subdev_main.o
diff --git a/drivers/subdev/subdev_main.c b/drivers/subdev/subdev_main.c
new file mode 100644
index 0000000..4aabcaa
--- /dev/null
+++ b/drivers/subdev/subdev_main.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/subdev_bus.h>
+
+static DEFINE_XARRAY_FLAGS(subdev_ids, XA_FLAGS_ALLOC);
+
+static int subdev_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct subdev_driver *subdev_drv = to_subdev_driver(drv);
+	const struct subdev_id *ids = subdev_drv->id_table;
+	const struct subdev *subdev = to_subdev_device(dev);
+
+	while (ids) {
+		if (ids->vendor_id == subdev->dev_id.vendor_id &&
+		    ids->device_id == subdev->dev_id.device_id)
+			return 1;
+
+		ids++;
+	}
+	return 0;
+}
+
+static struct bus_type subdev_bus_type = {
+	.dev_name = "subdev",
+	.name = "subdev",
+	.match = subdev_bus_match,
+};
+
+int __subdev_register_driver(struct subdev_driver *drv, struct module *owner,
+			     const char *mod_name)
+{
+	drv->driver.name = mod_name;
+	drv->driver.bus = &subdev_bus_type;
+	drv->driver.owner = owner;
+	drv->driver.mod_name = mod_name;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(__subdev_register_driver);
+
+void subdev_unregister_driver(struct subdev_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(subdev_unregister_driver);
+
+static void subdev_release(struct device *dev)
+{
+	struct subdev *subdev = to_subdev_device(dev);
+
+	kfree(subdev);
+}
+
+/**
+ * _subdev_alloc_subdev - Allocate a subdev device.
+ * @size:	Size of the device that to allocate that contains subdev
+ *		device as the first element.
+ * Returns pointer to a valid subdev structure or returns ERR_PTR.
+ *
+ */
+struct subdev *_subdev_alloc_dev(size_t size)
+{
+	struct subdev *subdev;
+
+	subdev = kzalloc(size, GFP_KERNEL);
+	if (!subdev)
+		return ERR_PTR(-ENOMEM);
+	subdev->dev.release = subdev_release;
+	device_initialize(&subdev->dev);
+	return subdev;
+}
+EXPORT_SYMBOL(_subdev_alloc_dev);
+
+/**
+ * subdev_free_dev - Free allocated subdev device.
+ * @subdev:	Pointer to subdev
+ *
+ */
+void subdev_free_dev(struct subdev *subdev)
+{
+	put_device(&subdev->dev);
+}
+EXPORT_SYMBOL(subdev_free_dev);
+
+/**
+ * subdev_add_dev - Add a sub device to bus.
+ * @subdev:	subdev devie to be placed on the bus
+ * @parent_dev:	Parent device of the subdev
+ * @vid:	Vendor ID of the device
+ * @did:	Device ID of the device
+ *
+ * Returns 0 on successfully adding subdev to bus or error code on failure.
+ * Once the device is added, it can be probed by the device driver who
+ * wish to match it.
+ *
+ */
+int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
+		   enum subdev_vendor_id vid, enum subdev_device_id did)
+{
+	u32 id = 0;
+	int ret;
+
+	if (!parent_dev)
+		return -EINVAL;
+
+	ret = xa_alloc(&subdev_ids, &id, UINT_MAX, NULL, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	subdev->dev.id = id;
+	subdev->dev_id.vendor_id = vid;
+	subdev->dev_id.device_id = did;
+	subdev->dev.parent = parent_dev;
+	subdev->dev.bus = &subdev_bus_type;
+	subdev->dev.dma_mask = parent_dev->dma_mask;
+	subdev->dev.dma_parms = parent_dev->dma_parms;
+	subdev->dev.coherent_dma_mask = parent_dev->coherent_dma_mask;
+	ret = device_add(&subdev->dev);
+	if (ret)
+		xa_erase(&subdev_ids, id);
+	return ret;
+}
+EXPORT_SYMBOL(subdev_add_dev);
+
+/**
+ * subdev_delete_dev - Delete previously added subdev device
+ *
+ * @subdev:	Pointer to subdev device to delete
+ */
+void subdev_delete_dev(struct subdev *subdev)
+{
+	device_del(&subdev->dev);
+	xa_erase(&subdev_ids, subdev->dev.id);
+}
+EXPORT_SYMBOL(subdev_delete_dev);
+
+static int __init subdev_init(void)
+{
+	return bus_register(&subdev_bus_type);
+}
+
+static void __exit subdev_exit(void)
+{
+	bus_unregister(&subdev_bus_type);
+}
+
+module_init(subdev_init);
+module_exit(subdev_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f9bd2f3..f271dab 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -779,4 +779,16 @@ struct typec_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/**
+ * struct subdev_id - subdev device identifiers defined in
+ *		      include/linux/subdev_ids.h
+ *
+ * @vendor_id: Vendor ID
+ * @device_id: Device ID
+ */
+struct subdev_id {
+	__u16 vendor_id;
+	__u16 device_id;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/include/linux/subdev_bus.h b/include/linux/subdev_bus.h
new file mode 100644
index 0000000..c6410e3
--- /dev/null
+++ b/include/linux/subdev_bus.h
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef SUBDEV_BUS_H
+#define SUBDEV_BUS_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/device.h>
+#include <linux/subdev_ids.h>
+
+struct subdev_driver {
+	const struct subdev_id *id_table;
+	struct device_driver driver;
+	struct list_head list;
+};
+
+#define to_subdev_driver(x) container_of(x, struct subdev_driver, driver)
+
+int __subdev_register_driver(struct subdev_driver *drv, struct module *owner,
+			     const char *mod_name);
+#define subdev_register_driver(driver)		\
+	__subdev_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
+
+void subdev_unregister_driver(struct subdev_driver *dev);
+
+/**
+ * subdev - A subdev device representation
+ *
+ * @dev:	device struct that represent subdev device in core device model
+ * @dev_id:	Unique vendor id, device id that subdev device drivers match
+ *		against. A unique id that defines this subdev assigned in
+ *		include/linux/subdev_ids.h
+ */
+struct subdev {
+	struct device dev;
+	struct subdev_id dev_id;
+};
+
+#define to_subdev_device(x) container_of(x, struct subdev, dev)
+
+struct subdev *_subdev_alloc_dev(size_t size);
+
+/**
+ * subdev_alloc_dev -	allocate memory for driver structure which holds
+ *			subdev structure and other driver's device specific
+ *			fields.
+ * @drv_struct:		Driver's device structure which defines subdev device
+ *			as the first member in the structure.
+ * @member:		Name of the subdev instance name in drivers device
+ *			structure.
+ */
+#define subdev_alloc_dev(drv_struct, member)                                \
+	container_of(_subdev_alloc_dev(sizeof(struct drv_struct) +          \
+				      BUILD_BUG_ON_ZERO(offsetof(           \
+					      struct drv_struct, member))), \
+		     struct drv_struct, member)
+
+void subdev_free_dev(struct subdev *subdev);
+
+int subdev_add_dev(struct subdev *subdev, struct device *parent_dev,
+		   enum subdev_vendor_id vid, enum subdev_device_id did);
+void subdev_delete_dev(struct subdev *subdev);
+
+#endif
diff --git a/include/linux/subdev_ids.h b/include/linux/subdev_ids.h
new file mode 100644
index 0000000..361faa3
--- /dev/null
+++ b/include/linux/subdev_ids.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef SUBDEV_IDS_H
+#define SUBDEV_IDS_H
+
+enum subdev_vendor_id {
+	SUBDEV_VENDOR_ID_MELLANOX,
+
+	/* new device id must be added above at the end */
+};
+
+enum subdev_device_id {
+	SUBDEV_DEVICE_ID_MELLANOX_SF,
+
+	/* new device id mst be added above at the end */
+};
+#endif
-- 
1.8.3.1

