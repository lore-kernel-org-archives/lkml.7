Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF8C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5119D206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCCQrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfCCQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="128667525"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2019 08:47:13 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/9] HID: intel-ish-hid: Move functions related to bus and device
Date:   Sun,  3 Mar 2019 08:46:53 -0800
Message-Id: <20190303164654.29400-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move function idefinitions related to bus and device to common header file.
Also create new function to get fw client id and move ish_hw_reset() from
inline to exported function.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c       | 26 +++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h       | 11 ---------
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |  5 ----
 include/linux/intel-ish-client-if.h         | 12 ++++++++++
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 2ca65864192f..66a485a41481 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -170,6 +170,19 @@ struct ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
 }
 EXPORT_SYMBOL(ishtp_fw_cl_get_client);
 
+/**
+ * ishtp_get_fw_client_id() - Get fw client id
+ *
+ * This interface is used to reset HW get FW client id.
+ *
+ * Return: firmware client id.
+ */
+int ishtp_get_fw_client_id(struct ishtp_fw_client *fw_client)
+{
+	return fw_client->client_id;
+}
+EXPORT_SYMBOL(ishtp_get_fw_client_id);
+
 /**
  * ishtp_fw_cl_by_id() - return index to fw_clients for client_id
  * @dev: the ishtp device structure
@@ -855,6 +868,19 @@ void *ishtp_trace_callback(struct ishtp_cl_device *cl_device)
 }
 EXPORT_SYMBOL(ishtp_trace_callback);
 
+/**
+ * ish_hw_reset() - Call HW reset IPC callback
+ *
+ * This interface is used to reset HW in case of error.
+ *
+ * Return: value from IPC hw_reset callback
+ */
+int ish_hw_reset(struct ishtp_device *dev)
+{
+	return dev->ops->hw_reset(dev);
+}
+EXPORT_SYMBOL(ish_hw_reset);
+
 /**
  * ishtp_bus_register() - Function to register bus
  *
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index 4aed195719de..93d516f5a853 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -80,16 +80,5 @@ void	ishtp_recv(struct ishtp_device *dev);
 void	ishtp_reset_handler(struct ishtp_device *dev);
 void	ishtp_reset_compl_handler(struct ishtp_device *dev);
 
-void	ishtp_put_device(struct ishtp_cl_device *);
-void	ishtp_get_device(struct ishtp_cl_device *);
-
-void	ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
-void	*ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
-
-int	ishtp_register_event_cb(struct ishtp_cl_device *device,
-				void (*read_cb)(struct ishtp_cl_device *));
 int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const guid_t *cuuid);
-struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
-						const guid_t *uuid);
-
 #endif /* _LINUX_ISHTP_CL_BUS_H */
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index e0a320e67a41..3cfef084b9fc 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -238,11 +238,6 @@ static inline int ish_ipc_reset(struct ishtp_device *dev)
 	return dev->ops->ipc_reset(dev);
 }
 
-static inline int ish_hw_reset(struct ishtp_device *dev)
-{
-	return dev->ops->hw_reset(dev);
-}
-
 /* Exported function */
 void	ishtp_device_init(struct ishtp_device *dev);
 int	ishtp_start(struct ishtp_device *dev);
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index 526e3048e09f..e98bfbb1e07e 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -9,7 +9,9 @@
 #define _INTEL_ISH_CLIENT_IF_H_
 
 struct ishtp_cl_device;
+struct ishtp_device;
 struct ishtp_cl;
+struct ishtp_fw_client;
 
 /* Client state */
 enum cl_state {
@@ -95,4 +97,14 @@ void ishtp_set_rx_ring_size(struct ishtp_cl *cl, int size);
 void ishtp_set_connection_state(struct ishtp_cl *cl, int state);
 void ishtp_cl_set_fw_client_id(struct ishtp_cl *cl, int fw_client_id);
 
+void ishtp_put_device(struct ishtp_cl_device *cl_dev);
+void ishtp_get_device(struct ishtp_cl_device *cl_dev);
+void ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
+void *ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
+int ishtp_register_event_cb(struct ishtp_cl_device *device,
+				void (*read_cb)(struct ishtp_cl_device *));
+struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const guid_t *uuid);
+int ishtp_get_fw_client_id(struct ishtp_fw_client *fw_client);
+int ish_hw_reset(struct ishtp_device *dev);
 #endif /* _INTEL_ISH_CLIENT_IF_H_ */
-- 
2.17.2

