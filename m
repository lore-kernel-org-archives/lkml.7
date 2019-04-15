Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0B220880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfDOQGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:38 -0400
Received: from foss.arm.com ([217.140.101.70]:38036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfDOQGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F40F41AC1;
        Mon, 15 Apr 2019 09:06:35 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A2693F68F;
        Mon, 15 Apr 2019 09:06:34 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 29/36] coresight: Use fwnode handle instead of device names
Date:   Mon, 15 Apr 2019 17:04:12 +0100
Message-Id: <1555344260-12375-30-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on the device names to find a CoreSight device on the
coresight bus. The device name however is obtained from the platform,
which is bound to the real platform/amba device. As we are about
to use different naming scheme for the coresight devices, we can't
rely on the platform device name to find the corresponding
coresight device. Instead we use the platform agnostic
"fwnode handle" of the parent device to find the devices.
We also reuse the same fwnode as the parent for the Coresight
device we create.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 12 +++++--
 drivers/hwtracing/coresight/coresight-priv.h     |  4 +--
 drivers/hwtracing/coresight/coresight.c          | 42 +++++++++++++++++++-----
 include/linux/coresight.h                        |  4 +--
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 318a6ff..c9a59fb 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -214,9 +214,15 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		conn->outport = endpoint.port;
-		conn->child_name = devm_kstrdup(dev,
-						dev_name(rdev),
-						GFP_KERNEL);
+		/*
+		 * Hold the refcount to the target device. This could be
+		 * released via:
+		 * 1) coresight_release_platform_data() if the probe fails or
+		 *    this device is unregistered.
+		 * 2) While removing the target device via
+		 *    coresight_remove_match()
+		 */
+		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn->child_port = rendpoint.port;
 		/* Connection record updated */
 		ret = 1;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c216421..61d7f9f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -200,8 +200,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 	return 0;
 }
 
-static inline void
-coresight_release_platform_data(struct coresight_platform_data *pdata)
-{}
+void coresight_release_platform_data(struct coresight_platform_data *pdata);
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 82fb411..5169ce1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -976,6 +976,7 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
+	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
 }
@@ -1007,13 +1008,11 @@ static int coresight_orphan_match(struct device *dev, void *data)
 		/* We have found at least one orphan connection */
 		if (conn->child_dev == NULL) {
 			/* Does it match this newly added device? */
-			if (conn->child_name &&
-			    !strcmp(dev_name(&csdev->dev), conn->child_name)) {
+			if (conn->child_fwnode ==  csdev->dev.fwnode)
 				conn->child_dev = csdev;
-			} else {
+			else
 				/* This component still has an orphan */
 				still_orphan = true;
-			}
 		}
 	}
 
@@ -1045,9 +1044,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 		struct coresight_connection *conn = &csdev->pdata->conns[i];
 		struct device *dev = NULL;
 
-		if (conn->child_name)
-			dev = bus_find_device_by_name(&coresight_bustype, NULL,
-						      conn->child_name);
+		dev = bus_find_device(&coresight_bustype, NULL,
+				      (void *)conn->child_fwnode,
+				      device_fwnode_match);
 		if (dev) {
 			conn->child_dev = to_coresight_device(dev);
 			/* and put reference from 'bus_find_device()' */
@@ -1082,9 +1081,15 @@ static int coresight_remove_match(struct device *dev, void *data)
 		if (conn->child_dev == NULL)
 			continue;
 
-		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
+		if (csdev->dev.fwnode == conn->child_fwnode) {
 			iterator->orphan = true;
 			conn->child_dev = NULL;
+			/*
+			 * Drop the reference to the handle for the remote
+			 * device acquired in parsing the connections from
+			 * platform data.
+			 */
+			fwnode_handle_put(conn->child_fwnode);
 			/* No need to continue */
 			break;
 		}
@@ -1164,6 +1169,22 @@ static int __init coresight_init(void)
 }
 postcore_initcall(coresight_init);
 
+/*
+ * coresight_release_platform_data: Release references to the devices connected
+ * to the output port of this device.
+ */
+void coresight_release_platform_data(struct coresight_platform_data *pdata)
+{
+	int i;
+
+	for (i = 0; i < pdata->nr_outport; i++) {
+		if (pdata->conns[i].child_fwnode) {
+			fwnode_handle_put(pdata->conns[i].child_fwnode);
+			pdata->conns[i].child_fwnode = 0;
+		}
+	}
+}
+
 struct coresight_device *coresight_register(struct coresight_desc *desc)
 {
 	int ret;
@@ -1208,6 +1229,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->dev.parent = desc->dev;
 	csdev->dev.release = coresight_device_release;
 	csdev->dev.bus = &coresight_bustype;
+	/*
+	 * Hold the reference to our parent device. This will be
+	 * dropped only in coresight_device_release().
+	 */
+	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
 	dev_set_name(&csdev->dev, "%s", desc->name);
 
 	ret = device_register(&csdev->dev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8c10def..188e759 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -126,15 +126,15 @@ struct coresight_desc {
 /**
  * struct coresight_connection - representation of a single connection
  * @outport:	a connection's output port number.
- * @chid_name:	remote component's name.
  * @child_port:	remote component's port number @output is connected to.
+ * @chid_fwnode: remote component's fwnode handle.
  * @child_dev:	a @coresight_device representation of the component
 		connected to @outport.
  */
 struct coresight_connection {
 	int outport;
-	const char *child_name;
 	int child_port;
+	struct fwnode_handle *child_fwnode;
 	struct coresight_device *child_dev;
 };
 
-- 
2.7.4

