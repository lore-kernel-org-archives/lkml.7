Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC042C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE21C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCTSuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfCTSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 404491BC0;
        Wed, 20 Mar 2019 11:50:37 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAEC93F59C;
        Wed, 20 Mar 2019 11:50:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 16/25] coresight: stm: Rearrange probing the stimulus area
Date:   Wed, 20 Mar 2019 18:49:33 +0000
Message-Id: <1553107783-3340-17-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to refactor the platform specific handling
re-arrange some of the DT specific property handling.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 6afe033..eb96bba 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -684,14 +684,15 @@ static const struct attribute_group *coresight_stm_groups[] = {
 	NULL,
 };
 
-static int stm_get_resource_byname(struct device_node *np,
-				   char *ch_base, struct resource *res)
+#ifdef CONFIG_OF
+static int of_stm_get_stimulus_area(struct device *dev, struct resource *res)
 {
 	const char *name = NULL;
 	int index = 0, found = 0;
+	struct device_node *np = dev->of_node;
 
 	while (!of_property_read_string_index(np, "reg-names", index, &name)) {
-		if (strcmp(ch_base, name)) {
+		if (strcmp("stm-stimulus-base", name)) {
 			index++;
 			continue;
 		}
@@ -706,6 +707,20 @@ static int stm_get_resource_byname(struct device_node *np,
 
 	return of_address_to_resource(np, index, res);
 }
+#else
+static inline int of_stm_get_stimulus_area(struct device *dev,
+					   struct resource *res)
+{
+	return -ENOENT;
+}
+#endif
+
+static int stm_get_stimulus_area(struct device *dev, struct resource *res)
+{
+	if (dev->of_node)
+		return of_stm_get_stimulus_area(dev, res);
+	return -ENOENT;
+}
 
 static u32 stm_fundamental_data_size(struct stm_drvdata *drvdata)
 {
@@ -819,7 +834,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 	drvdata->base = base;
 
-	ret = stm_get_resource_byname(np, "stm-stimulus-base", &ch_res);
+	ret = stm_get_stimulus_area(dev, &ch_res);
 	if (ret)
 		return ret;
 	drvdata->chs.phys = ch_res.start;
-- 
2.7.4

