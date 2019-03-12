Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D517C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4030C214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfCMIeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:34:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:51480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfCMIeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:34:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 01:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="154566607"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2019 01:34:14 -0700
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, joro@8bytes.org, jean-philippe.brucker@arm.com,
        peterx@redhat.com, linux-kernel@vger.kernel.org,
        Liu@vger.kernel.org
Subject: [RFC v2 1/2] vfio/pci: export common symbols in vfio-pci
Date:   Tue, 12 Mar 2019 16:18:22 +0800
Message-Id: <1552378703-11202-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
References: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the following symbols from vfio-pci driver
for vfio-pci alike driver. e.g. vfio-pci-mdev driver

*) vfio_pci_set_vga_decode();
*) vfio_pci_release();
*) vfio_pci_open();
*) vfio_pci_register_dev_region();
*) vfio_pci_ioctl();
*) vfio_pci_rw();
*) vfio_pci_mmap();
*) vfio_pci_request();
*) vfio_pci_probe_misc();
*) vfio_pci_remove_misc();
*) vfio_err_handlers;
*) vfio_pci_reflck_attach();
*) vfio_pci_reflck_put();

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci.c         | 101 ++++++++++++++++++++++--------------
 drivers/vfio/pci/vfio_pci_private.h |  17 ++++++
 2 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index ff60bd1..e36b922 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -73,7 +73,7 @@ static inline bool vfio_vga_disabled(void)
  * has no way to get to it and routing can be disabled externally at the
  * bridge.
  */
-static unsigned int vfio_pci_set_vga_decode(void *opaque, bool single_vga)
+unsigned int vfio_pci_set_vga_decode(void *opaque, bool single_vga)
 {
 	struct vfio_pci_device *vdev = opaque;
 	struct pci_dev *tmp = NULL, *pdev = vdev->pdev;
@@ -103,6 +103,7 @@ static unsigned int vfio_pci_set_vga_decode(void *opaque, bool single_vga)
 
 	return decodes;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_set_vga_decode);
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 {
@@ -410,7 +411,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
 
-static void vfio_pci_release(void *device_data)
+void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
@@ -425,8 +426,9 @@ static void vfio_pci_release(void *device_data)
 
 	module_put(THIS_MODULE);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_release);
 
-static int vfio_pci_open(void *device_data)
+int vfio_pci_open(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 	int ret = 0;
@@ -450,6 +452,7 @@ static int vfio_pci_open(void *device_data)
 		module_put(THIS_MODULE);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_open);
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 {
@@ -634,9 +637,10 @@ int vfio_pci_register_dev_region(struct vfio_pci_device *vdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_register_dev_region);
 
-static long vfio_pci_ioctl(void *device_data,
-			   unsigned int cmd, unsigned long arg)
+long vfio_pci_ioctl(void *device_data,
+		   unsigned int cmd, unsigned long arg)
 {
 	struct vfio_pci_device *vdev = device_data;
 	unsigned long minsz;
@@ -1079,8 +1083,9 @@ static long vfio_pci_ioctl(void *device_data,
 
 	return -ENOTTY;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_ioctl);
 
-static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
+ssize_t vfio_pci_rw(void *device_data, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite)
 {
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
@@ -1111,6 +1116,7 @@ static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_rw);
 
 static ssize_t vfio_pci_read(void *device_data, char __user *buf,
 			     size_t count, loff_t *ppos)
@@ -1130,7 +1136,7 @@ static ssize_t vfio_pci_write(void *device_data, const char __user *buf,
 	return vfio_pci_rw(device_data, (char __user *)buf, count, ppos, true);
 }
 
-static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
+int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 {
 	struct vfio_pci_device *vdev = device_data;
 	struct pci_dev *pdev = vdev->pdev;
@@ -1173,7 +1179,7 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	 */
 	if (!vdev->barmap[index]) {
 		ret = pci_request_selected_regions(pdev,
-						   1 << index, "vfio-pci");
+						   1 << index, vdev->name);
 		if (ret)
 			return ret;
 
@@ -1191,8 +1197,9 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       req_len, vma->vm_page_prot);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_mmap);
 
-static void vfio_pci_request(void *device_data, unsigned int count)
+void vfio_pci_request(void *device_data, unsigned int count)
 {
 	struct vfio_pci_device *vdev = device_data;
 
@@ -1211,6 +1218,7 @@ static void vfio_pci_request(void *device_data, unsigned int count)
 
 	mutex_unlock(&vdev->igate);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_request);
 
 static const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
@@ -1223,8 +1231,31 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.request	= vfio_pci_request,
 };
 
-static int vfio_pci_reflck_attach(struct vfio_pci_device *vdev);
-static void vfio_pci_reflck_put(struct vfio_pci_reflck *reflck);
+int vfio_pci_probe_misc(struct pci_dev *pdev, struct vfio_pci_device *vdev)
+{
+	if (vfio_pci_is_vga(pdev)) {
+		vga_client_register(pdev, vdev, NULL, vfio_pci_set_vga_decode);
+		vga_set_legacy_decoding(pdev,
+					vfio_pci_set_vga_decode(vdev, false));
+	}
+
+	if (!disable_idle_d3) {
+		/*
+		 * pci-core sets the device power state to an unknown value at
+		 * bootup and after being removed from a driver.  The only
+		 * transition it allows from this unknown state is to D0, which
+		 * typically happens when a driver calls pci_enable_device().
+		 * We're not ready to enable the device yet, but we do want to
+		 * be able to get to D3.  Therefore first do a D0 transition
+		 * before going to D3.
+		 */
+		pci_set_power_state(pdev, PCI_D0);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_probe_misc);
 
 static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -1259,6 +1290,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	vdev->pdev = pdev;
+	vdev->name = "vfio-pci";
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
@@ -1280,28 +1312,23 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
+	ret = vfio_pci_probe_misc(pdev, vdev);
+	return ret;
+}
+
+void vfio_pci_remove_misc(struct pci_dev *pdev)
+{
 	if (vfio_pci_is_vga(pdev)) {
-		vga_client_register(pdev, vdev, NULL, vfio_pci_set_vga_decode);
+		vga_client_register(pdev, NULL, NULL, NULL);
 		vga_set_legacy_decoding(pdev,
-					vfio_pci_set_vga_decode(vdev, false));
+				VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
+				VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
 	}
 
-	if (!disable_idle_d3) {
-		/*
-		 * pci-core sets the device power state to an unknown value at
-		 * bootup and after being removed from a driver.  The only
-		 * transition it allows from this unknown state is to D0, which
-		 * typically happens when a driver calls pci_enable_device().
-		 * We're not ready to enable the device yet, but we do want to
-		 * be able to get to D3.  Therefore first do a D0 transition
-		 * before going to D3.
-		 */
+	if (!disable_idle_d3)
 		pci_set_power_state(pdev, PCI_D0);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-
-	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_remove_misc);
 
 static void vfio_pci_remove(struct pci_dev *pdev)
 {
@@ -1317,16 +1344,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	kfree(vdev->region);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev);
-
-	if (vfio_pci_is_vga(pdev)) {
-		vga_client_register(pdev, NULL, NULL, NULL);
-		vga_set_legacy_decoding(pdev,
-				VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
-				VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
-	}
-
-	if (!disable_idle_d3)
-		pci_set_power_state(pdev, PCI_D0);
+	vfio_pci_remove_misc(pdev);
 }
 
 static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
@@ -1357,9 +1375,10 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
-static const struct pci_error_handlers vfio_err_handlers = {
+const struct pci_error_handlers vfio_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
 };
+EXPORT_SYMBOL_GPL(vfio_err_handlers);
 
 static struct pci_driver vfio_pci_driver = {
 	.name		= "vfio-pci",
@@ -1418,7 +1437,7 @@ static int vfio_pci_reflck_find(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-static int vfio_pci_reflck_attach(struct vfio_pci_device *vdev)
+int vfio_pci_reflck_attach(struct vfio_pci_device *vdev)
 {
 	bool slot = !pci_probe_reset_slot(vdev->pdev->slot);
 
@@ -1433,6 +1452,7 @@ static int vfio_pci_reflck_attach(struct vfio_pci_device *vdev)
 
 	return PTR_ERR_OR_ZERO(vdev->reflck);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_reflck_attach);
 
 static void vfio_pci_reflck_release(struct kref *kref)
 {
@@ -1444,10 +1464,11 @@ static void vfio_pci_reflck_release(struct kref *kref)
 	mutex_unlock(&reflck_lock);
 }
 
-static void vfio_pci_reflck_put(struct vfio_pci_reflck *reflck)
+void vfio_pci_reflck_put(struct vfio_pci_reflck *reflck)
 {
 	kref_put_mutex(&reflck->kref, vfio_pci_reflck_release, &reflck_lock);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_reflck_put);
 
 struct vfio_devices {
 	struct vfio_device **devices;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8c0009f..da9afe5 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -90,6 +90,7 @@ struct vfio_pci_reflck {
 struct vfio_pci_device {
 	struct pci_dev		*pdev;
 	void __iomem		*barmap[PCI_STD_RESOURCE_END + 1];
+	char			*name;
 	bool			bar_mmap_supported[PCI_STD_RESOURCE_END + 1];
 	u8			*pci_config_map;
 	u8			*vconfig;
@@ -125,6 +126,8 @@ struct vfio_pci_device {
 	struct list_head	ioeventfds_list;
 };
 
+extern const struct pci_error_handlers vfio_err_handlers;
+
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
 #define is_msi(vdev) (vdev->irq_type == VFIO_PCI_MSI_IRQ_INDEX)
 #define is_msix(vdev) (vdev->irq_type == VFIO_PCI_MSIX_IRQ_INDEX)
@@ -154,6 +157,20 @@ extern long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
 extern int vfio_pci_init_perm_bits(void);
 extern void vfio_pci_uninit_perm_bits(void);
 
+int vfio_pci_open(void *device_data);
+void vfio_pci_release(void *device_data);
+long vfio_pci_ioctl(void *device_data,
+			   unsigned int cmd, unsigned long arg);
+ssize_t vfio_pci_rw(void *device_data, char __user *buf,
+			   size_t count, loff_t *ppos, bool iswrite);
+int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma);
+void vfio_pci_request(void *device_data, unsigned int count);
+int vfio_pci_reflck_attach(struct vfio_pci_device *vdev);
+void vfio_pci_reflck_put(struct vfio_pci_reflck *reflck);
+unsigned int vfio_pci_set_vga_decode(void *opaque, bool single_vga);
+int vfio_pci_probe_misc(struct pci_dev *pdev, struct vfio_pci_device *vdev);
+void vfio_pci_remove_misc(struct pci_dev *pdev);
+
 extern int vfio_config_init(struct vfio_pci_device *vdev);
 extern void vfio_config_free(struct vfio_pci_device *vdev);
 
-- 
2.7.4

