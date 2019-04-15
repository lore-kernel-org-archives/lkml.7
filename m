Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfDOQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:40 -0400
Received: from foss.arm.com ([217.140.101.70]:38020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfDOQGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6211AC1;
        Mon, 15 Apr 2019 09:06:34 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B73993F68F;
        Mon, 15 Apr 2019 09:06:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 28/36] coresight: platform: Use fwnode handle for device search
Date:   Mon, 15 Apr 2019 17:04:11 +0100
Message-Id: <1555344260-12375-29-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We match of_node while searching for a device. Make this
more generic in preparation for the ACPI support by using
fwnode_handle.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index a408b01..318a6ff 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -36,14 +36,8 @@ static int coresight_alloc_conns(struct device *dev,
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static struct device *
-of_coresight_get_endpoint_device(struct device_node *endpoint)
+coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = NULL;
 
@@ -52,7 +46,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * platform bus.
 	 */
 	dev = bus_find_device(&platform_bus_type, NULL,
-			      endpoint, of_dev_node_match);
+			      fwnode, device_fwnode_match);
 	if (dev)
 		return dev;
 
@@ -61,9 +55,10 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * looking for the device that matches the endpoint node.
 	 */
 	return bus_find_device(&amba_bustype, NULL,
-			       endpoint, of_dev_node_match);
+			       fwnode, device_fwnode_match);
 }
 
+#ifdef CONFIG_OF
 static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
 {
 	return of_property_read_bool(ep, "slave-mode");
@@ -191,6 +186,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct device_node *rparent = NULL;
 	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
+	struct fwnode_handle *rdev_fwnode;
 
 	do {
 		/* Parse the local port details */
@@ -209,8 +205,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		if (of_graph_parse_endpoint(rep, &rendpoint))
 			break;
 
+		rdev_fwnode = of_fwnode_handle(rparent);
 		/* If the remote device is not available, defer probing */
-		rdev = of_coresight_get_endpoint_device(rparent);
+		rdev = coresight_find_device_by_fwnode(rdev_fwnode);
 		if (!rdev) {
 			ret = -EPROBE_DEFER;
 			break;
-- 
2.7.4

