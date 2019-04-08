Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D6C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8495E20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDHX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:58:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:63285 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfDHX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169949"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 06/18] iommu: introduce device fault report API
Date:   Mon,  8 Apr 2019 16:59:21 -0700
Message-Id: <1554767973-30125-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, device specific faults are detected and handled within
their own device drivers. When IOMMU is enabled, faults such as DMA
related transactions are detected by IOMMU. There is no generic
reporting mechanism to report faults back to the in-kernel device
driver or the guest OS in case of assigned devices.

Faults detected by IOMMU is based on the transaction's source ID which
can be reported at per device basis, regardless of the device type is a
PCI device or not.

The fault types include recoverable (e.g. page request) and
unrecoverable faults(e.g. access error). In most cases, faults can be
handled by IOMMU drivers internally. The primary use cases are as
follows:
1. page request fault originated from an SVM capable device that is
assigned to guest via vIOMMU. In this case, the first level page tables
are owned by the guest. Page request must be propagated to the guest to
let guest OS fault in the pages then send page response. In this
mechanism, the direct receiver of IOMMU fault notification is VFIO,
which can relay notification events to QEMU or other user space
software.

2. faults need more subtle handling by device drivers. Other than
simply invoke reset function, there are needs to let device driver
handle the fault with a smaller impact.

This patchset is intended to create a generic fault report API such
that it can scale as follows:
- all IOMMU types
- PCI and non-PCI devices
- recoverable and unrecoverable faults
- VFIO and other other in kernel users
- DMA & IRQ remapping (TBD)
The original idea was brought up by David Woodhouse and discussions
summarized at https://lwn.net/Articles/608914/.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
[adapt to new iommu_fault fault field, test fault_param on
 iommu_unregister_device_fault_handler]
---
 drivers/iommu/iommu.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h |  36 +++++++++++-
 2 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 109de67..ac7e6b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -648,6 +648,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
+	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
+	if (!dev->iommu_param) {
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+	mutex_init(&dev->iommu_param->lock);
+
 	kobject_get(group->devices_kobj);
 
 	dev->iommu_group = group;
@@ -678,6 +685,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_unlock(&group->mutex);
 	dev->iommu_group = NULL;
 	kobject_put(group->devices_kobj);
+	kfree(dev->iommu_param);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
@@ -724,7 +732,7 @@ void iommu_group_remove_device(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
 	trace_remove_device_from_group(group->id, dev);
-
+	kfree(dev->iommu_param);
 	kfree(device->name);
 	kfree(device);
 	dev->iommu_group = NULL;
@@ -859,6 +867,150 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
 /**
+ * iommu_register_device_fault_handler() - Register a device fault handler
+ * @dev: the device
+ * @handler: the fault handler
+ * @data: private data passed as argument to the handler
+ *
+ * When an IOMMU fault event is received, call this handler with the fault event
+ * and data as argument. The handler should return 0 on success. If the fault is
+ * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete
+ * the fault by calling iommu_page_response() with one of the following
+ * response code:
+ * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
+ * - IOMMU_PAGE_RESP_INVALID: terminate the fault
+ * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
+ *   page faults if possible.
+ *
+ * Return 0 if the fault handler was installed successfully, or an error.
+ */
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = 0;
+
+	/*
+	 * Device iommu_param should have been allocated when device is
+	 * added to its iommu_group.
+	 */
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+	/* Only allow one fault handler registered for each device */
+	if (param->fault_param) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+
+	get_device(dev);
+	param->fault_param =
+		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
+	if (!param->fault_param) {
+		put_device(dev);
+		ret = -ENOMEM;
+		goto done_unlock;
+	}
+	mutex_init(&param->fault_param->lock);
+	param->fault_param->handler = handler;
+	param->fault_param->data = data;
+	INIT_LIST_HEAD(&param->fault_param->faults);
+
+done_unlock:
+	mutex_unlock(&param->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
+
+/**
+ * iommu_unregister_device_fault_handler() - Unregister the device fault handler
+ * @dev: the device
+ *
+ * Remove the device fault handler installed with
+ * iommu_register_device_fault_handler().
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = 0;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+
+	if (!param->fault_param)
+		goto unlock;
+
+	/* we cannot unregister handler if there are pending faults */
+	if (!list_empty(&param->fault_param->faults)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	kfree(param->fault_param);
+	param->fault_param = NULL;
+	put_device(dev);
+unlock:
+	mutex_unlock(&param->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
+
+
+/**
+ * iommu_report_device_fault() - Report fault event to device
+ * @dev: the device
+ * @evt: fault event data
+ *
+ * Called by IOMMU model specific drivers when fault is detected, typically
+ * in a threaded IRQ handler.
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	int ret = 0;
+	struct iommu_fault_event *evt_pending;
+	struct iommu_fault_param *fparam;
+
+	/* iommu_param is allocated when device is added to group */
+	if (!dev->iommu_param | !evt)
+		return -EINVAL;
+	/* we only report device fault if there is a handler registered */
+	mutex_lock(&dev->iommu_param->lock);
+	if (!dev->iommu_param->fault_param ||
+		!dev->iommu_param->fault_param->handler) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	fparam = dev->iommu_param->fault_param;
+	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
+	    evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE) {
+		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
+				GFP_KERNEL);
+		if (!evt_pending) {
+			ret = -ENOMEM;
+			goto done_unlock;
+		}
+		mutex_lock(&fparam->lock);
+		list_add_tail(&evt_pending->list, &fparam->faults);
+		mutex_unlock(&fparam->lock);
+	}
+	ret = fparam->handler(evt, fparam->data);
+done_unlock:
+	mutex_unlock(&dev->iommu_param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_fault);
+
+/**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c8108e7..f12f251 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -260,11 +260,13 @@ struct iommu_device {
  * - DMA remapping and IRQ remapping faults
  *
  * @fault: fault descriptor
+ * @list pending fault event list, used for tracking responses
  * @iommu_private: used by the IOMMU driver for storing fault-specific
  *                 data. Users should not modify this field before
  *                 sending the fault response.
  */
 struct iommu_fault_event {
+	struct list_head list;
 	struct iommu_fault fault;
 	u64 iommu_private;
 };
@@ -273,10 +275,13 @@ struct iommu_fault_event {
  * struct iommu_fault_param - per-device IOMMU fault data
  * @dev_fault_handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
- *
+ * @faults: holds the pending faults which needs response, e.g. page response.
+ * @lock: protect pending PRQ event list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
+	struct list_head faults;
+	struct mutex lock;
 	void *data;
 };
 
@@ -290,6 +295,7 @@ struct iommu_fault_param {
  *	struct iommu_fwspec	*iommu_fwspec;
  */
 struct iommu_param {
+	struct mutex lock;
 	struct iommu_fault_param *fault_param;
 };
 
@@ -382,6 +388,15 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data);
+
+extern int iommu_unregister_device_fault_handler(struct device *dev);
+
+extern int iommu_report_device_fault(struct device *dev,
+				     struct iommu_fault_event *evt);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -662,6 +677,25 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	return 0;
+}
+
+static inline
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4

