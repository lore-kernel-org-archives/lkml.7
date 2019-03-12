Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54186C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF34E214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCMIeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:34:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:51480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfCMIeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:34:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 01:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="154566615"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2019 01:34:17 -0700
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, joro@8bytes.org, jean-philippe.brucker@arm.com,
        peterx@redhat.com, linux-kernel@vger.kernel.org,
        Liu@vger.kernel.org
Subject: [RFC v2 2/2] vfio/pci: add vfio-pci-mdev driver
Date:   Tue, 12 Mar 2019 16:18:23 +0800
Message-Id: <1552378703-11202-3-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new driver named vfio-pci-mdev. It is similar
with vfio-pci driver. Thus consumes some symbols from vfio-pci
driver. However, this new driver wraps a pci device as a
mediated device. For a pci device, once bound to vfio-pci-mdev
driver, user space access of this device will go through vfio
mdev framework. User should create a mdev before exposing the
device to user-space.

Benefit of this new driver would be acting as a sample driver
for recent changes from "vfio/mdev: IOMMU aware mediated device"
patchset. Also it could be a good start for future device specific
mdev migration support.

To use this driver:
a) build and load vfio-pci-mdev.ko module
   execute "make menuconfig" and config VFIO_PCI_MDEV
   then load it with following command
   > sudo modprobe vfio
   > sudo modprobe vfio-pci
   > sudo modprobe vfio-pci-mdev

b) unbind original device driver
   e.g. for device with its bdf as $dev_bdf, use following command
   to unbind its original driver
   > echo $dev_bdf > /sys/bus/pci/devices/$dev_bdf/driver/unbind

c) bind vfio-pci-mdev driver to the physical device
   > echo $vend_id $dev_id > /sys/bus/pci/drivers/vfio-pci-mdev/new_id

d) check the supported mdev instances
   > ls /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/
     vfio-pci-mdev-type1
   > ls /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/\
     vfio-pci-mdev-type1/
     available_instances  create  device_api  devices  name

e)  create mdev on this physical device
   > echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1003" > \
     /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/\
     vfio-pci-mdev-type1/create

f) passthru the mdev to guest
   add the following line in Qemu boot command
   -device vfio-pci,\
    sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1003

g) destroy mdev
   > echo 1 > /sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1003/\
     remove

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/Kconfig         |  11 ++
 drivers/vfio/pci/Makefile        |   5 +
 drivers/vfio/pci/vfio_pci_mdev.c | 334 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_mdev.c

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index d0f8e4f..30c6b15 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -9,6 +9,17 @@ config VFIO_PCI
 
 	  If you don't know what to do here, say N.
 
+config VFIO_PCI_MDEV
+	tristate "VFIO MDEV support for PCI devices"
+	depends on VFIO && PCI && EVENTFD && VFIO_PCI && VFIO_MDEV_DEVICE
+	select VFIO_VIRQFD
+	select IRQ_BYPASS_MANAGER
+	help
+	  Support for the PCI VFIO Mdev bus driver.  This is required to
+	  make use of PCI drivers using the VFIO Mdev framework.
+
+	  If you don't know what to do here, say N.
+
 config VFIO_PCI_VGA
 	bool "VFIO PCI support for VGA devices"
 	depends on VFIO_PCI && X86 && VGA_ARB
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 9662c06..e840947 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -3,4 +3,9 @@ vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
 vfio-pci-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
 
+vfio-pci-mdev-y := vfio_pci_mdev.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-mdev-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-mdev-$(CONFIG_VFIO_PCI_NVLINK2) += vfio_pci_nvlink2.o
+
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
+obj-$(CONFIG_VFIO_PCI_MDEV) += vfio-pci-mdev.o
diff --git a/drivers/vfio/pci/vfio_pci_mdev.c b/drivers/vfio/pci/vfio_pci_mdev.c
new file mode 100644
index 0000000..15c8f7e
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_mdev.c
@@ -0,0 +1,334 @@
+/*
+ * Copyright © 2019 Intel Corporation.
+ *     Author: Liu, Yi L <yi.l.liu@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Derived from original vfio_pci.c:
+ * Copyright (C) 2012 Red Hat, Inc.  All rights reserved.
+ *     Author: Alex Williamson <alex.williamson@redhat.com>
+ *
+ * Derived from original vfio:
+ * Copyright 2010 Cisco Systems, Inc.  All rights reserved.
+ * Author: Tom Lyon, pugs@cisco.com
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/vgaarb.h>
+#include <linux/nospec.h>
+#include <linux/mdev.h>
+
+#include "vfio_pci_private.h"
+
+#define DRIVER_VERSION  "0.2"
+#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
+#define DRIVER_DESC     "VFIO PCI Mdev - User Level meta-driver"
+
+#define VFIO_PCI_MDEV_NAME  "vfio-pci-mdev"
+
+static ssize_t
+name_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s-type1\n", dev_name(dev));
+}
+
+MDEV_TYPE_ATTR_RO(name);
+
+static ssize_t
+available_instances_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n", 1);
+}
+
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
+		char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_DEVICE_API_PCI_STRING);
+}
+
+MDEV_TYPE_ATTR_RO(device_api);
+
+static struct attribute *vfio_pci_mdev_types_attrs[] = {
+	&mdev_type_attr_name.attr,
+	&mdev_type_attr_device_api.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group vfio_pci_mdev_type_group1 = {
+	.name  = "type1",
+	.attrs = vfio_pci_mdev_types_attrs,
+};
+
+struct attribute_group *vfio_pci_mdev_type_groups[] = {
+	&vfio_pci_mdev_type_group1,
+	NULL,
+};
+
+struct vfio_pci_mdev {
+	struct vfio_pci_device *vdev;
+	struct mdev_device *mdev;
+	unsigned long handle;
+};
+
+static int vfio_pci_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct device *pdev;
+	struct vfio_pci_device *vdev;
+	struct vfio_pci_mdev *pmdev;
+	int ret;
+
+	pdev = mdev_parent_dev(mdev);
+	vdev = dev_get_drvdata(pdev);
+	pmdev = kzalloc(sizeof(struct vfio_pci_mdev), GFP_KERNEL);
+	if (pmdev == NULL) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pmdev->mdev = mdev;
+	pmdev->vdev = vdev;
+	mdev_set_drvdata(mdev, pmdev);
+	ret = mdev_set_iommu_device(mdev_dev(mdev), pdev);
+	if (ret) {
+		pr_info("%s, failed to config iommu isolation for mdev: %s on pf: %s\n",
+			__func__, dev_name(mdev_dev(mdev)), dev_name(pdev));
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static int vfio_pci_mdev_remove(struct mdev_device *mdev)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	kfree(pmdev);
+	pr_info("%s, succeeded for mdev: %s\n", __func__,
+		     dev_name(mdev_dev(mdev)));
+
+	return 0;
+}
+
+static int vfio_pci_mdev_open(struct mdev_device *mdev)
+{
+	int ret = 0;
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	ret = vfio_pci_open(pmdev->vdev);
+	if (!ret)
+		pr_info("Succeeded to open mdev: %s on pf: %s\n",
+		dev_name(mdev_dev(mdev)), dev_name(&pmdev->vdev->pdev->dev));
+	else
+		pr_info("Failed to open mdev: %s on pf: %s\n",
+		dev_name(mdev_dev(mdev)), dev_name(&pmdev->vdev->pdev->dev));
+	return ret;
+}
+
+static void vfio_pci_mdev_release(struct mdev_device *mdev)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	pr_info("Release mdev: %s on pf: %s\n",
+		dev_name(mdev_dev(mdev)), dev_name(&pmdev->vdev->pdev->dev));
+	vfio_pci_release(pmdev->vdev);
+}
+
+static long vfio_pci_mdev_ioctl(struct mdev_device *mdev, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	return vfio_pci_ioctl(pmdev->vdev, cmd, arg);
+}
+
+static int vfio_pci_mdev_mmap(struct mdev_device *mdev,
+				struct vm_area_struct *vma)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	return vfio_pci_mmap(pmdev->vdev, vma);
+}
+
+static ssize_t vfio_pci_mdev_read(struct mdev_device *mdev, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	if (!count)
+		return 0;
+
+	return vfio_pci_rw(pmdev->vdev, buf, count, ppos, false);
+}
+
+static ssize_t vfio_pci_mdev_write(struct mdev_device *mdev,
+				const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	if (!count)
+		return 0;
+
+	return vfio_pci_rw(pmdev->vdev, (char __user *)buf, count, ppos, true);
+}
+
+static const struct mdev_parent_ops vfio_pci_mdev_ops = {
+	.supported_type_groups	= vfio_pci_mdev_type_groups,
+	.create			= vfio_pci_mdev_create,
+	.remove			= vfio_pci_mdev_remove,
+
+	.open			= vfio_pci_mdev_open,
+	.release		= vfio_pci_mdev_release,
+
+	.read			= vfio_pci_mdev_read,
+	.write			= vfio_pci_mdev_write,
+	.mmap			= vfio_pci_mdev_mmap,
+	.ioctl			= vfio_pci_mdev_ioctl,
+};
+
+static int vfio_pci_mdev_driver_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct vfio_pci_device *vdev;
+	struct iommu_group *group;
+	int ret;
+
+	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Prevent binding to PFs with VFs enabled, this too easily allows
+	 * userspace instance with VFs and PFs from the same device, which
+	 * cannot work.  Disabling SR-IOV here would initiate removing the
+	 * VFs, which would unbind the driver, which is prone to blocking
+	 * if that VF is also in use by vfio-pci.  Just reject these PFs
+	 * and let the user sort it out.
+	 */
+	if (pci_num_vf(pdev)) {
+		pci_warn(pdev, "Cannot bind to PF with SR-IOV enabled\n");
+		return -EBUSY;
+	}
+
+	group = vfio_iommu_group_get(&pdev->dev);
+	if (!group)
+		return -EINVAL;
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev) {
+		vfio_iommu_group_put(group, &pdev->dev);
+		return -ENOMEM;
+	}
+
+	vdev->pdev = pdev;
+	vdev->name = VFIO_PCI_MDEV_NAME;
+	vdev->irq_type = VFIO_PCI_NUM_IRQS;
+	mutex_init(&vdev->igate);
+	spin_lock_init(&vdev->irqlock);
+	mutex_init(&vdev->ioeventfds_lock);
+	INIT_LIST_HEAD(&vdev->ioeventfds_list);
+
+	pci_set_drvdata(pdev, vdev);
+
+	ret = vfio_pci_reflck_attach(vdev);
+	if (ret) {
+		vfio_del_group_dev(&pdev->dev);
+		vfio_iommu_group_put(group, &pdev->dev);
+		kfree(vdev);
+		return ret;
+	}
+
+	ret = vfio_pci_probe_misc(pdev, vdev);
+	if (ret) {
+		pr_err("failed to probe %s\n", dev_name(&pdev->dev));
+		return ret;
+	}
+
+	ret = mdev_register_device(&pdev->dev, &vfio_pci_mdev_ops);
+	if (ret)
+		pr_err("Cannot register mdev for device %s\n",
+			dev_name(&pdev->dev));
+	else
+		pr_info("Wrap device %s as a mdev\n", dev_name(&pdev->dev));
+
+	return ret;
+}
+
+static void vfio_pci_mdev_driver_remove(struct pci_dev *pdev)
+{
+	struct vfio_pci_device *vdev;
+
+	vdev = pci_get_drvdata(pdev);
+	if (!vdev)
+		return;
+
+	vfio_pci_reflck_put(vdev->reflck);
+
+	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
+	kfree(vdev->region);
+	mutex_destroy(&vdev->ioeventfds_lock);
+	kfree(vdev);
+
+	vfio_pci_remove_misc(pdev);
+}
+
+static struct pci_driver vfio_pci_mdev_driver = {
+	.name		= VFIO_PCI_MDEV_NAME,
+	.id_table	= NULL, /* only dynamic ids */
+	.probe		= vfio_pci_mdev_driver_probe,
+	.remove		= vfio_pci_mdev_driver_remove,
+	.err_handler	= &vfio_err_handlers,
+};
+
+static void __exit vfio_pci_mdev_cleanup(void)
+{
+	pci_unregister_driver(&vfio_pci_mdev_driver);
+	vfio_pci_uninit_perm_bits();
+}
+
+static int __init vfio_pci_mdev_init(void)
+{
+	int ret;
+
+	/* Allocate shared config space permision data used by all devices */
+	ret = vfio_pci_init_perm_bits();
+	if (ret)
+		return ret;
+
+	/* Register and scan for devices */
+	ret = pci_register_driver(&vfio_pci_mdev_driver);
+	if (ret)
+		goto out_driver;
+
+	return 0;
+out_driver:
+	vfio_pci_uninit_perm_bits();
+	return ret;
+}
+
+module_init(vfio_pci_mdev_init);
+module_exit(vfio_pci_mdev_cleanup);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.7.4

