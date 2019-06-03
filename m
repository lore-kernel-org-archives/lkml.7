Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A96C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E9227930
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFCPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:17 -0400
Received: from foss.arm.com ([217.140.101.70]:54058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfFCPwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C51169E;
        Mon,  3 Jun 2019 08:52:14 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45D393F246;
        Mon,  3 Jun 2019 08:52:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Thor Thayer <thor.thayer@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [RFC PATCH 49/57] drivers: mfd: altera: Use driver_find_device_by_of_node() helper
Date:   Mon,  3 Jun 2019 16:50:15 +0100
Message-Id: <1559577023-558-50-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper to find device by of_node.

Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/mfd/altera-sysmgr.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 2ee14d8..1fbe06c 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -88,16 +88,6 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
 };
 
 /**
- * sysmgr_match_phandle
- * Matching function used by driver_find_device().
- * Return: True if match is found, otherwise false.
- */
-static int sysmgr_match_phandle(struct device *dev, const void *data)
-{
-	return dev->of_node == (const struct device_node *)data;
-}
-
-/**
  * altr_sysmgr_regmap_lookup_by_phandle
  * Find the sysmgr previous configured in probe() and return regmap property.
  * Return: regmap if found or error if not found.
@@ -117,8 +107,8 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 	if (!sysmgr_np)
 		return ERR_PTR(-ENODEV);
 
-	dev = driver_find_device(&altr_sysmgr_driver.driver, NULL,
-				 (void *)sysmgr_np, sysmgr_match_phandle);
+	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver, NULL,
+					    (void *)sysmgr_np);
 	of_node_put(sysmgr_np);
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
-- 
2.7.4

