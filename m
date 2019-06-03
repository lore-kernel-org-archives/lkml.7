Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFABC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A385A27A6D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfFCPvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbfFCPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1A8169E;
        Mon,  3 Jun 2019 08:51:13 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEF183F246;
        Mon,  3 Jun 2019 08:51:12 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [RFC PATCH 10/57] drivers: coresight: Use bus_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:49:36 +0100
Message-Id: <1559577023-558-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 7045930..9b7a0c0 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -18,11 +18,6 @@
 #include <asm/smp_plat.h>
 
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static struct device *
 of_coresight_get_endpoint_device(struct device_node *endpoint)
 {
@@ -32,8 +27,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * If we have a non-configurable replicator, it will be found on the
 	 * platform bus.
 	 */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      endpoint, of_dev_node_match);
+	dev = bus_find_device_by_of_node(&platform_bus_type, NULL, endpoint);
 	if (dev)
 		return dev;
 
@@ -41,8 +35,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 	 * We have a configurable component - circle through the AMBA bus
 	 * looking for the device that matches the endpoint node.
 	 */
-	return bus_find_device(&amba_bustype, NULL,
-			       endpoint, of_dev_node_match);
+	return bus_find_device_by_of_node(&amba_bustype, NULL, endpoint);
 }
 
 static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
-- 
2.7.4

