Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB84C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BE927B12
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfFCO6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:58:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfFCO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:58:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E3FC1688;
        Mon,  3 Jun 2019 07:58:45 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71AD43F246;
        Mon,  3 Jun 2019 07:58:43 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org, alex.williamson@redhat.com
Cc:     jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: [PATCH v2 4/4] iommu: Add recoverable fault reporting
Date:   Mon,  3 Jun 2019 15:57:49 +0100
Message-Id: <20190603145749.46347-5-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IOMMU hardware features, for example PCI PRI and Arm SMMU Stall,
enable recoverable I/O page faults. Allow IOMMU drivers to report PRI Page
Requests and Stall events through the new fault reporting API. The
consumer of the fault can be either an I/O page fault handler in the host,
or a guest OS.

Once handled, the fault must be completed by sending a page response back
to the IOMMU. Add an iommu_page_response() function to complete a page
fault.

There are two ways to extend the userspace API:
* Add a field to iommu_page_response and a flag to
  iommu_page_response::flags describing the validity of this field.
* Introduce a new iommu_page_response_X structure with a different version
  number. The kernel must then support both versions.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c      | 94 +++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h      | 19 ++++++++
 include/uapi/linux/iommu.h | 35 ++++++++++++++
 3 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8037a3f07f07..956a80364efd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -891,7 +891,14 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  * @data: private data passed as argument to the handler
  *
  * When an IOMMU fault event is received, this handler gets called with the
- * fault event and data as argument. The handler should return 0 on success.
+ * fault event and data as argument. The handler should return 0 on success. If
+ * the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the consumer should also
+ * complete the fault by calling iommu_page_response() with one of the following
+ * response code:
+ * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
+ * - IOMMU_PAGE_RESP_INVALID: terminate the fault
+ * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
+ *   page faults if possible.
  *
  * Return 0 if the fault handler was installed successfully, or an error.
  */
@@ -921,6 +928,8 @@ int iommu_register_device_fault_handler(struct device *dev,
 	}
 	param->fault_param->handler = handler;
 	param->fault_param->data = data;
+	mutex_init(&param->fault_param->lock);
+	INIT_LIST_HEAD(&param->fault_param->faults);
 
 done_unlock:
 	mutex_unlock(&param->lock);
@@ -951,6 +960,12 @@ int iommu_unregister_device_fault_handler(struct device *dev)
 	if (!param->fault_param)
 		goto unlock;
 
+	/* we cannot unregister handler if there are pending faults */
+	if (!list_empty(&param->fault_param->faults)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	kfree(param->fault_param);
 	param->fault_param = NULL;
 	put_device(dev);
@@ -967,13 +982,15 @@ EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
  * @evt: fault event data
  *
  * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
- * handler.
+ * handler. When this function fails and the fault is recoverable, it is the
+ * caller's responsibility to complete the fault.
  *
  * Return 0 on success, or an error.
  */
 int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
 	struct iommu_param *param = dev->iommu_param;
+	struct iommu_fault_event *evt_pending = NULL;
 	struct iommu_fault_param *fparam;
 	int ret = 0;
 
@@ -987,13 +1004,86 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		ret = -EINVAL;
 		goto done_unlock;
 	}
+
+	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
+	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
+		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
+				      GFP_KERNEL);
+		if (!evt_pending) {
+			ret = -ENOMEM;
+			goto done_unlock;
+		}
+		mutex_lock(&fparam->lock);
+		list_add_tail(&evt_pending->list, &fparam->faults);
+		mutex_unlock(&fparam->lock);
+	}
+
 	ret = fparam->handler(&evt->fault, fparam->data);
+	if (ret && evt_pending) {
+		mutex_lock(&fparam->lock);
+		list_del(&evt_pending->list);
+		mutex_unlock(&fparam->lock);
+		kfree(evt_pending);
+	}
 done_unlock:
 	mutex_unlock(&param->lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 
+int iommu_page_response(struct device *dev,
+			struct iommu_page_response *msg)
+{
+	bool pasid_valid;
+	int ret = -EINVAL;
+	struct iommu_fault_event *evt;
+	struct iommu_fault_page_request *prm;
+	struct iommu_param *param = dev->iommu_param;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !domain->ops->page_response)
+		return -ENODEV;
+
+	if (!param || !param->fault_param)
+		return -EINVAL;
+
+	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
+	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
+		return -EINVAL;
+
+	/* Only send response if there is a fault report pending */
+	mutex_lock(&param->fault_param->lock);
+	if (list_empty(&param->fault_param->faults)) {
+		dev_warn_ratelimited(dev, "no pending PRQ, drop response\n");
+		goto done_unlock;
+	}
+	/*
+	 * Check if we have a matching page request pending to respond,
+	 * otherwise return -EINVAL
+	 */
+	list_for_each_entry(evt, &param->fault_param->faults, list) {
+		prm = &evt->fault.prm;
+		pasid_valid = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+
+		if ((pasid_valid && prm->pasid != msg->pasid) ||
+		    prm->grpid != msg->grpid)
+			continue;
+
+		/* Sanitize the reply */
+		msg->flags = pasid_valid ? IOMMU_PAGE_RESP_PASID_VALID : 0;
+
+		ret = domain->ops->page_response(dev, evt, msg);
+		list_del(&evt->list);
+		kfree(evt);
+		break;
+	}
+
+done_unlock:
+	mutex_unlock(&param->fault_param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_page_response);
+
 /**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3e783f5bf472..76c8cda61dfd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -227,6 +227,7 @@ struct iommu_sva_ops {
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
+ * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -287,6 +288,10 @@ struct iommu_ops {
 	void (*sva_unbind)(struct iommu_sva *handle);
 	int (*sva_get_pasid)(struct iommu_sva *handle);
 
+	int (*page_response)(struct device *dev,
+			     struct iommu_fault_event *evt,
+			     struct iommu_page_response *msg);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -311,19 +316,25 @@ struct iommu_device {
  * unrecoverable faults such as DMA or IRQ remapping faults.
  *
  * @fault: fault descriptor
+ * @list: pending fault event list, used for tracking responses
  */
 struct iommu_fault_event {
 	struct iommu_fault fault;
+	struct list_head list;
 };
 
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
  * @handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
+ * @faults: holds the pending faults which needs response
+ * @lock: protect pending faults list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
 	void *data;
+	struct list_head faults;
+	struct mutex lock;
 };
 
 /**
@@ -437,6 +448,8 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
+extern int iommu_page_response(struct device *dev,
+			       struct iommu_page_response *msg);
 
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -765,6 +778,12 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	return -ENODEV;
 }
 
+static inline int iommu_page_response(struct device *dev,
+				      struct iommu_page_response *msg)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 796402174d6c..f45d8e9e59c3 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -115,4 +115,39 @@ struct iommu_fault {
 		struct iommu_fault_page_request prm;
 	};
 };
+
+/**
+ * enum iommu_page_response_code - Return status of fault handlers
+ * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum iommu_page_response_code {
+	IOMMU_PAGE_RESP_SUCCESS = 0,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_page_response - Generic page response information
+ * @version: API version of this structure
+ * @flags: encodes whether the corresponding fields are valid
+ *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: response code from &enum iommu_page_response_code
+ */
+struct iommu_page_response {
+#define IOMMU_PAGE_RESP_VERSION_1	1
+	__u32	version;
+#define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
+	__u32	flags;
+	__u32	pasid;
+	__u32	grpid;
+	__u32	code;
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.21.0

