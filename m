Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDED82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCTSut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:49 -0400
Received: from foss.arm.com ([217.140.101.70]:45018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfCTSuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0124F1BF7;
        Wed, 20 Mar 2019 11:50:46 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B9853F59C;
        Wed, 20 Mar 2019 11:50:44 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 21/25] coresight: Use fwnode handle instead of device names
Date:   Wed, 20 Mar 2019 18:49:38 +0000
Message-Id: <1553107783-3340-22-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
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
 drivers/hwtracing/coresight/coresight-platform.c | 10 ++++------
 drivers/hwtracing/coresight/coresight-priv.h     |  2 ++
 drivers/hwtracing/coresight/coresight.c          | 19 +++++++++++--------
 include/linux/coresight.h                        |  4 ++--
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 877ed2b..5eee987 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -31,7 +31,7 @@ static int coresight_alloc_conns(struct device *dev,
 	return 0;
 }
 
-static int coresight_fwnode_handle_match(struct device *dev, void *data)
+int coresight_match_fwnode_handle(struct device *dev, void *data)
 {
 	return dev_fwnode(dev) == data;
 }
@@ -46,7 +46,7 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 	 * platform bus.
 	 */
 	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, coresight_fwnode_handle_match);
+			      fwnode, coresight_match_fwnode_handle);
 	if (dev)
 		return dev;
 
@@ -55,7 +55,7 @@ coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 	 * looking for the device that matches the endpoint node.
 	 */
 	return bus_find_device(&amba_bustype, NULL,
-			       fwnode, coresight_fwnode_handle_match);
+			       fwnode, coresight_match_fwnode_handle);
 }
 
 #ifdef CONFIG_OF
@@ -214,9 +214,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		conn->outport = endpoint.port;
-		conn->child_name = devm_kstrdup(dev,
-						dev_name(rdev),
-						GFP_KERNEL);
+		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn->child_port = rendpoint.port;
 		/* Connection record updated */
 		ret = 1;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index e0684d0..8fb1243 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -153,6 +153,8 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
+int coresight_match_fwnode_handle(struct device *dev, void *data);
+
 #ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29cef89..9cdedab 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1005,13 +1005,11 @@ static int coresight_orphan_match(struct device *dev, void *data)
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
 
@@ -1043,9 +1041,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 		struct coresight_connection *conn = &csdev->conns[i];
 		struct device *dev = NULL;
 
-		if (conn->child_name)
-			dev = bus_find_device_by_name(&coresight_bustype, NULL,
-						      conn->child_name);
+		dev = bus_find_device(&coresight_bustype, NULL,
+				      (void *)conn->child_fwnode,
+				      coresight_match_fwnode_handle);
 		if (dev) {
 			conn->child_dev = to_coresight_device(dev);
 			/* and put reference from 'bus_find_device()' */
@@ -1080,9 +1078,11 @@ static int coresight_remove_match(struct device *dev, void *data)
 		if (conn->child_dev == NULL)
 			continue;
 
-		if (!strcmp(dev_name(&csdev->dev), conn->child_name)) {
+		if (csdev->dev.fwnode == conn->child_fwnode) {
 			iterator->orphan = true;
 			conn->child_dev = NULL;
+			/* Drop the reference to the handle for connection */
+			fwnode_handle_put(conn->child_fwnode);
 			/* No need to continue */
 			break;
 		}
@@ -1198,6 +1198,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->dev.parent = desc->dev;
 	csdev->dev.release = coresight_device_release;
 	csdev->dev.bus = &coresight_bustype;
+	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
+
 	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
 
 	ret = device_register(&csdev->dev);
@@ -1247,6 +1249,7 @@ void coresight_unregister(struct coresight_device *csdev)
 	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
+	fwnode_handle_put(csdev->dev.fwnode);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a48cd9b..76c31b2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -128,14 +128,14 @@ struct coresight_desc {
 /**
  * struct coresight_connection - representation of a single connection
  * @outport:	a connection's output port number.
- * @chid_name:	remote component's name.
+ * @chid_fwnode: remote component's fwnode handle.
  * @child_port:	remote component's port number @output is connected to.
  * @child_dev:	a @coresight_device representation of the component
 		connected to @outport.
  */
 struct coresight_connection {
 	int outport;
-	const char *child_name;
+	struct fwnode_handle *child_fwnode;
 	int child_port;
 	struct coresight_device *child_dev;
 };
-- 
2.7.4

