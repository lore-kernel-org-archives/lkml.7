Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A181C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF424E66
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfFCPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:53:31 -0400
Received: from foss.arm.com ([217.140.101.70]:53938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbfFCPv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 520A91B4B;
        Mon,  3 Jun 2019 08:51:57 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F017E3F246;
        Mon,  3 Jun 2019 08:51:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: [RFC PATCH 38/57] drivers: fpga: Use generic helpers to match by of_node
Date:   Mon,  3 Jun 2019 16:50:04 +0100
Message-Id: <1559577023-558-39-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helpers available to find device matching of_node.

Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/fpga/fpga-bridge.c    | 8 +-------
 drivers/fpga/fpga-mgr.c       | 8 +-------
 drivers/fpga/of-fpga-region.c | 7 +------
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 80bd8f1..f1222a9 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -19,11 +19,6 @@ static struct class *fpga_bridge_class;
 /* Lock for adding/removing bridges to linked lists*/
 static spinlock_t bridge_list_lock;
 
-static int fpga_bridge_of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * fpga_bridge_enable - Enable transactions on the bridge
  *
@@ -104,8 +99,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 {
 	struct device *dev;
 
-	dev = class_find_device(fpga_bridge_class, NULL, np,
-				fpga_bridge_of_node_match);
+	dev = class_find_device_by_of_node(fpga_bridge_class, NULL, np);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c386681..78d2ddb1 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -482,11 +482,6 @@ struct fpga_manager *fpga_mgr_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
-static int fpga_mgr_of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_fpga_mgr_get - Given a device node, get a reference to a fpga mgr.
  *
@@ -498,8 +493,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(fpga_mgr_class, NULL, node,
-				fpga_mgr_of_node_match);
+	dev = class_find_device_by_of_node(fpga_mgr_class, NULL, node);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 75f64ab..e405309 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -22,11 +22,6 @@ static const struct of_device_id fpga_region_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, fpga_region_of_match);
 
-static int fpga_region_of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_fpga_region_find - find FPGA region
  * @np: device node of FPGA Region
@@ -37,7 +32,7 @@ static int fpga_region_of_node_match(struct device *dev, const void *data)
  */
 static struct fpga_region *of_fpga_region_find(struct device_node *np)
 {
-	return fpga_region_class_find(NULL, np, fpga_region_of_node_match);
+	return fpga_region_class_find(NULL, np, device_match_of_node);
 }
 
 /**
-- 
2.7.4

