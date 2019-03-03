Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB24C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871C5206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCCQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:31315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfCCQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="128667522"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2019 08:47:13 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/9] HID: intel-ish-hid: Move the common functions from client.h
Date:   Sun,  3 Mar 2019 08:46:51 -0800
Message-Id: <20190303164654.29400-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the interface functions in client.h to common include. These are
already abstracted well to use as is. Also move any associated structures
used by these functions.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/client.h    | 24 -----------
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h | 26 -----------
 include/linux/intel-ish-client-if.h         | 48 +++++++++++++++++++++
 3 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index afa8b1f521d0..6ed00947d6bc 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -19,15 +19,6 @@
 #include <linux/types.h>
 #include "ishtp-dev.h"
 
-/* Client state */
-enum cl_state {
-	ISHTP_CL_INITIALIZING = 0,
-	ISHTP_CL_CONNECTING,
-	ISHTP_CL_CONNECTED,
-	ISHTP_CL_DISCONNECTING,
-	ISHTP_CL_DISCONNECTED
-};
-
 /* Tx and Rx ring size */
 #define	CL_DEF_RX_RING_SIZE	2
 #define	CL_DEF_TX_RING_SIZE	2
@@ -169,19 +160,4 @@ static inline bool ishtp_cl_cmp_id(const struct ishtp_cl *cl1,
 		(cl1->fw_client_id == cl2->fw_client_id);
 }
 
-/* exported functions from ISHTP under client management scope */
-struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
-void ishtp_cl_free(struct ishtp_cl *cl);
-int ishtp_cl_link(struct ishtp_cl *cl);
-void ishtp_cl_unlink(struct ishtp_cl *cl);
-int ishtp_cl_disconnect(struct ishtp_cl *cl);
-int ishtp_cl_connect(struct ishtp_cl *cl);
-int ishtp_cl_send(struct ishtp_cl *cl, uint8_t *buf, size_t length);
-int ishtp_cl_flush_queues(struct ishtp_cl *cl);
-
-/* exported functions from ISHTP client buffer management scope */
-int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb);
-bool ishtp_cl_tx_empty(struct ishtp_cl *cl);
-struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl);
-
 #endif /* _ISHTP_CLIENT_H_ */
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index e54ce1ef27dd..e0a320e67a41 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -79,32 +79,6 @@ struct ishtp_fw_client {
 	uint8_t client_id;
 };
 
-/**
- * struct ishtp_msg_data - ISHTP message data struct
- * @size:	Size of data in the *data
- * @data:	Pointer to data
- */
-struct ishtp_msg_data {
-	uint32_t size;
-	unsigned char *data;
-};
-
-/*
- * struct ishtp_cl_rb - request block structure
- * @list:	Link to list members
- * @cl:		ISHTP client instance
- * @buffer:	message header
- * @buf_idx:	Index into buffer
- * @read_time:	 unused at this time
- */
-struct ishtp_cl_rb {
-	struct list_head list;
-	struct ishtp_cl *cl;
-	struct ishtp_msg_data buffer;
-	unsigned long buf_idx;
-	unsigned long read_time;
-};
-
 /*
  * Control info for IPC messages ISHTP/IPC sending FIFO -
  * list with inline data buffer
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index abc0b8122f07..7ce172f656f8 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -9,6 +9,16 @@
 #define _INTEL_ISH_CLIENT_IF_H_
 
 struct ishtp_cl_device;
+struct ishtp_cl;
+
+/* Client state */
+enum cl_state {
+	ISHTP_CL_INITIALIZING = 0,
+	ISHTP_CL_CONNECTING,
+	ISHTP_CL_CONNECTED,
+	ISHTP_CL_DISCONNECTING,
+	ISHTP_CL_DISCONNECTED
+};
 
 /**
  * struct ishtp_cl_device - ISHTP device handle
@@ -29,6 +39,32 @@ struct ishtp_cl_driver {
 	const struct dev_pm_ops *pm;
 };
 
+/**
+ * struct ishtp_msg_data - ISHTP message data struct
+ * @size:	Size of data in the *data
+ * @data:	Pointer to data
+ */
+struct ishtp_msg_data {
+	uint32_t size;
+	unsigned char *data;
+};
+
+/*
+ * struct ishtp_cl_rb - request block structure
+ * @list:	Link to list members
+ * @cl:		ISHTP client instance
+ * @buffer:	message header
+ * @buf_idx:	Index into buffer
+ * @read_time:	 unused at this time
+ */
+struct ishtp_cl_rb {
+	struct list_head list;
+	struct ishtp_cl *cl;
+	struct ishtp_msg_data buffer;
+	unsigned long buf_idx;
+	unsigned long read_time;
+};
+
 int ishtp_cl_driver_register(struct ishtp_cl_driver *driver,
 			     struct module *owner);
 void ishtp_cl_driver_unregister(struct ishtp_cl_driver *driver);
@@ -40,4 +76,16 @@ struct device *ishtp_device(struct ishtp_cl_device *cl_device);
 /* Trace interface for clients */
 void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
 
+struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
+void ishtp_cl_free(struct ishtp_cl *cl);
+int ishtp_cl_link(struct ishtp_cl *cl);
+void ishtp_cl_unlink(struct ishtp_cl *cl);
+int ishtp_cl_disconnect(struct ishtp_cl *cl);
+int ishtp_cl_connect(struct ishtp_cl *cl);
+int ishtp_cl_send(struct ishtp_cl *cl, uint8_t *buf, size_t length);
+int ishtp_cl_flush_queues(struct ishtp_cl *cl);
+int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb);
+bool ishtp_cl_tx_empty(struct ishtp_cl *cl);
+struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl);
+
 #endif /* _INTEL_ISH_CLIENT_IF_H_ */
-- 
2.17.2

