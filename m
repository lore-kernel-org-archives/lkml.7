Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3587C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4E720B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEGKyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfEGKyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00324374;
        Tue,  7 May 2019 03:54:16 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C146D3F5AF;
        Tue,  7 May 2019 03:54:14 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 24/30] coresight: platform: Use fwnode handle for device search
Date:   Tue,  7 May 2019 11:52:51 +0100
Message-Id: <1557226378-10131-25-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
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
Change since v2:
 - Drop the generic helper. It requires further clean up,
   and will be dealt with a separate series.
---
 drivers/hwtracing/coresight/coresight-platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 53d6eed..4394095 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -36,14 +36,13 @@ static int coresight_alloc_conns(struct device *dev,
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static int of_dev_node_match(struct device *dev, void *data)
+static int coresight_device_fwnode_match(struct device *dev, void *fwnode)
 {
-	return dev->of_node == data;
+	return dev_fwnode(dev) == fwnode;
 }
 
 static struct device *
-of_coresight_get_endpoint_device(struct device_node *endpoint)
+coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = NULL;
 
@@ -52,7 +51,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * platform bus.
 	 */
 	dev = bus_find_device(&platform_bus_type, NULL,
-			      endpoint, of_dev_node_match);
+			      fwnode, coresight_device_fwnode_match);
 	if (dev)
 		return dev;
 
@@ -61,9 +60,10 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * looking for the device that matches the endpoint node.
 	 */
 	return bus_find_device(&amba_bustype, NULL,
-			       endpoint, of_dev_node_match);
+			       fwnode, coresight_device_fwnode_match);
 }
 
+#ifdef CONFIG_OF
 static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
 {
 	return of_property_read_bool(ep, "slave-mode");
@@ -191,6 +191,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct device_node *rparent = NULL;
 	struct device_node *rep = NULL;
 	struct device *rdev = NULL;
+	struct fwnode_handle *rdev_fwnode;
 
 	do {
 		/* Parse the local port details */
@@ -209,8 +210,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
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

