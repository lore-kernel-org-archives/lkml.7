Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0320835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfCDNNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:13:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:33932 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCDNNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:13:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 05:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="151870448"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 05:13:48 -0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        jean-philippe.brucker@arm.com, peterx@redhat.com,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        yi.y.sun@intel.com, Liu@vger.kernel.org
Subject: [RFC v1 1/2] vfio/pci: register vfio-pci driver to mdev framework
Date:   Sun,  3 Mar 2019 20:58:00 +0800
Message-Id: <1551617881-8520-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
References: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new working mode in vfio-pci driver, may mentioned
as pci-mdev mode. User can config vfio-pci driver to work in this mode
by module param "vfio_pci_mdev_mode". When working in this mode, vfio-pci
driver will wrap a pci device as a mediated device. User space access of
this device will go through vfio mdev framework.

This new mode is exclusive to existing pci passthrough, i.e. once
enabled the physical device cannot be assigned directly but through
mdev framework. The next patch of this patchset will give a way to
ensure this exclusiveness.

To use this driver:
a) load vfio-pci.ko module with "vfio_pci_mdev_mode=1"
   > sudo modprobe vfio
   > sudo modprobe vfio-pci vfio_pci_mdev_mode=1
   > sudo modprobe vfio_mdev

b) unbind original device driver
   e.g. for device with its bdf as $dev_bdf, use following command
   to unbind its original driver
   > echo $dev_bdf > /sys/bus/pci/devices/$dev_bdf/driver/unbind

c) bind vfio-pci driver to the physical device
   > echo $vend_id $dev_id > /sys/bus/pci/drivers/vfio-pci/new_id

d) check the supported mdev instances
   > ls /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/
     vfio-pmdev-type1
   > ls /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/\
     vfio-pmdev-type1/
     available_instances  create  device_api  devices  name

e)  create mdev on this physical device
   > echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1003" > \
     /sys/bus/pci/devices/$dev_bdf/mdev_supported_types/\
     vfio-pmdev-type1/create

f) passthru the mdev to guest
   add the following line in Qemu boot command
   -device vfio-pci,\
    sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1003

g) destroy mdev
   > echo 1 > /sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1003/\
     remove

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index ff60bd1..d1c3fe6 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -29,6 +29,7 @@
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
 #include <linux/nospec.h>
+#include <linux/mdev.h>
 
 #include "vfio_pci_private.h"
 
@@ -56,6 +57,13 @@ module_param(disable_idle_d3, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(disable_idle_d3,
 		 "Disable using the PCI D3 low power state for idle, unused devices");
 
+static bool vfio_pci_mdev_mode;
+module_param(vfio_pci_mdev_mode, bool, 0644);
+MODULE_PARM_DESC(vfio_pci_mdev_mode,
+		 "A mode of vfio-pci driver, which wrapa a PCI device as a mediated device. Further user-space direct access of the PCI device will go thru mediated framework");
+
+static const struct mdev_parent_ops vfio_pci_mdev_ops;
+
 static inline bool vfio_vga_disabled(void)
 {
 #ifdef CONFIG_VFIO_PCI_VGA
@@ -1300,6 +1308,20 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
 
+	if (vfio_pci_mdev_mode) {
+		ret = mdev_register_device(&pdev->dev, &vfio_pci_mdev_ops);
+		if (ret)
+			pr_err("Cannot register mdev for device %s\n",
+				dev_name(&pdev->dev));
+		else
+			pr_info("vfio-pci will wrap %s as a mdev\n",
+				dev_name(&pdev->dev));
+	} else {
+
+		pr_info("vfio-pci work in legacy mode for %s\n",
+						dev_name(&pdev->dev));
+	}
+
 	return ret;
 }
 
@@ -1607,6 +1629,164 @@ static void __init vfio_pci_fill_ids(void)
 	}
 }
 
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
+	return vfio_pci_read(pmdev->vdev, buf, count, ppos);
+}
+
+static ssize_t vfio_pci_mdev_write(struct mdev_device *mdev,
+				const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct vfio_pci_mdev *pmdev = mdev_get_drvdata(mdev);
+
+	return vfio_pci_write(pmdev->vdev, buf, count, ppos);
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
 static int __init vfio_pci_init(void)
 {
 	int ret;
-- 
2.7.4

