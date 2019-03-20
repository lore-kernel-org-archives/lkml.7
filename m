Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31219C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116A42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfCTSwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:52:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44896 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfCTSu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42FB168F;
        Wed, 20 Mar 2019 11:50:26 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A3933F59C;
        Wed, 20 Mar 2019 11:50:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 10/25] coresight: tpiu: Clean up device specific data
Date:   Wed, 20 Mar 2019 18:49:27 +0000
Message-Id: <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the coresight device instead of the parent
amba device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1..9763721 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -48,15 +48,13 @@
 
 /**
  * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated to this component.
+ * @dev:	the coresight device entity associated to this component.
  * @atclk:	optional clock for the core parts of the TPIU.
- * @csdev:	component vitals needed by the framework.
  */
 struct tpiu_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
-	struct coresight_device	*csdev;
 };
 
 static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
@@ -121,6 +119,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct tpiu_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct coresight_device *csdev;
 	struct device_node *np = adev->dev.of_node;
 
 	if (np) {
@@ -134,7 +133,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
@@ -160,9 +158,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpiu_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
-	drvdata->csdev = coresight_register(&desc);
+	csdev = coresight_register(&desc);
+	if (!IS_ERR(csdev))
+		drvdata->dev = &csdev->dev;
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	return PTR_ERR_OR_ZERO(csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4

