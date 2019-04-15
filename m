Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C950320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfDOQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbfDOQG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAEE61AC1;
        Mon, 15 Apr 2019 09:06:26 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 712B73F68F;
        Mon, 15 Apr 2019 09:06:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 24/36] coresight: Reuse platform data structure for connection tracking
Date:   Mon, 15 Apr 2019 17:04:07 +0100
Message-Id: <1555344260-12375-25-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform specific information describes the connections and
the ports of a given coresigh device. This information is also
recorded in the coresight device as separate fields. Let us reuse
the original platform description to streamline the handling
of the data.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 +--
 drivers/hwtracing/coresight/coresight.c         | 46 ++++++++++++-------------
 include/linux/coresight.h                       |  8 ++---
 3 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 0911f9c..d3ff2c7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -747,8 +747,8 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 	if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
 		return NULL;
 
-	for (i = 0; i < etr->nr_outport; i++) {
-		tmp = etr->conns[i].child_dev;
+	for (i = 0; i < etr->pdata->nr_outport; i++) {
+		tmp = etr->pdata->conns[i].child_dev;
 		if (tmp && coresight_is_catu_device(tmp))
 			return tmp;
 	}
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 530ad69..f6c5244 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -100,8 +100,8 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < parent->nr_outport; i++) {
-		conn = &parent->conns[i];
+	for (i = 0; i < parent->pdata->nr_outport; i++) {
+		conn = &parent->pdata->conns[i];
 		if (conn->child_dev == csdev)
 			return conn->child_port;
 	}
@@ -118,8 +118,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	int i;
 	struct coresight_connection *conn;
 
-	for (i = 0; i < csdev->nr_outport; i++) {
-		conn = &csdev->conns[i];
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		conn = &csdev->pdata->conns[i];
 		if (conn->child_dev == child)
 			return conn->outport;
 	}
@@ -304,10 +304,10 @@ static void coresight_disable_link(struct coresight_device *csdev,
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
 		refport = inport;
-		nr_conns = csdev->nr_inport;
+		nr_conns = csdev->pdata->nr_inport;
 	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
 		refport = outport;
-		nr_conns = csdev->nr_outport;
+		nr_conns = csdev->pdata->nr_outport;
 	} else {
 		refport = 0;
 		nr_conns = 1;
@@ -593,9 +593,10 @@ static void coresight_grab_device(struct coresight_device *csdev)
 {
 	int i;
 
-	for (i = 0; i < csdev->nr_outport; i++) {
-		struct coresight_device *child = csdev->conns[i].child_dev;
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		struct coresight_device *child;
 
+		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			pm_runtime_get_sync(child->dev.parent);
 	}
@@ -611,9 +612,10 @@ static void coresight_drop_device(struct coresight_device *csdev)
 	int i;
 
 	pm_runtime_put(csdev->dev.parent);
-	for (i = 0; i < csdev->nr_outport; i++) {
-		struct coresight_device *child = csdev->conns[i].child_dev;
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		struct coresight_device *child;
 
+		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
 			pm_runtime_put(child->dev.parent);
 	}
@@ -643,9 +645,10 @@ static int _coresight_build_path(struct coresight_device *csdev,
 		goto out;
 
 	/* Not a sink - recursively explore each port found on this element */
-	for (i = 0; i < csdev->nr_outport; i++) {
-		struct coresight_device *child_dev = csdev->conns[i].child_dev;
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		struct coresight_device *child_dev;
 
+		child_dev = csdev->pdata->conns[i].child_dev;
 		if (child_dev &&
 		    _coresight_build_path(child_dev, sink, path) == 0) {
 			found = true;
@@ -998,8 +1001,8 @@ static int coresight_orphan_match(struct device *dev, void *data)
 	 * Circle throuch all the connection of that component.  If we find
 	 * an orphan connection whose name matches @csdev, link it.
 	 */
-	for (i = 0; i < i_csdev->nr_outport; i++) {
-		conn = &i_csdev->conns[i];
+	for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
+		conn = &i_csdev->pdata->conns[i];
 
 		/* We have found at least one orphan connection */
 		if (conn->child_dev == NULL) {
@@ -1038,8 +1041,8 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
 {
 	int i;
 
-	for (i = 0; i < csdev->nr_outport; i++) {
-		struct coresight_connection *conn = &csdev->conns[i];
+	for (i = 0; i < csdev->pdata->nr_outport; i++) {
+		struct coresight_connection *conn = &csdev->pdata->conns[i];
 		struct device *dev = NULL;
 
 		if (conn->child_name)
@@ -1073,8 +1076,8 @@ static int coresight_remove_match(struct device *dev, void *data)
 	 * Circle throuch all the connection of that component.  If we find
 	 * a connection whose name matches @csdev, remove it.
 	 */
-	for (i = 0; i < iterator->nr_outport; i++) {
-		conn = &iterator->conns[i];
+	for (i = 0; i < iterator->pdata->nr_outport; i++) {
+		conn = &iterator->pdata->conns[i];
 
 		if (conn->child_dev == NULL)
 			continue;
@@ -1106,7 +1109,7 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 	 * doesn't have at least one input port, there is no point
 	 * in searching all the devices.
 	 */
-	if (csdev->nr_inport)
+	if (csdev->pdata->nr_inport)
 		bus_for_each_dev(&coresight_bustype, NULL,
 				 csdev, coresight_remove_match);
 }
@@ -1193,10 +1196,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	csdev->refcnt = refcnts;
 
-	csdev->nr_inport = desc->pdata->nr_inport;
-	csdev->nr_outport = desc->pdata->nr_outport;
-
-	csdev->conns = desc->pdata->conns;
+	csdev->pdata = desc->pdata;
 
 	csdev->type = desc->type;
 	csdev->subtype = desc->subtype;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 84a2137..8c10def 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -140,9 +140,7 @@ struct coresight_connection {
 
 /**
  * struct coresight_device - representation of a device as used by the framework
- * @conns:	array of coresight_connections associated to this component.
- * @nr_inport:	number of input port associated to this component.
- * @nr_outport:	number of output port associated to this component.
+ * @pdata:	Platform data with device connections associated to this device.
  * @type:	as defined by @coresight_dev_type.
  * @subtype:	as defined by @coresight_dev_subtype.
  * @ops:	generic operations for this component, as defined
@@ -157,9 +155,7 @@ struct coresight_connection {
  * @ea:		Device attribute for sink representation under PMU directory.
  */
 struct coresight_device {
-	struct coresight_connection *conns;
-	int nr_inport;
-	int nr_outport;
+	struct coresight_platform_data *pdata;
 	enum coresight_dev_type type;
 	union coresight_dev_subtype subtype;
 	const struct coresight_ops *ops;
-- 
2.7.4

