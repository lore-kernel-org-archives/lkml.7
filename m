Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHHto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:49:44 -0500
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:41254
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbfCHHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:49:44 -0500
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id B51C6203C6;
        Fri,  8 Mar 2019 07:49:41 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        fkan@apm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] power: reset: syscon-reboot: add a mask property
Date:   Fri,  8 Mar 2019 08:49:30 +0100
Message-Id: <20190308074930.15270-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the syscon-reboot driver accept value and mask instead of
just value.

Prior to this patch, the property name for the value was 'mask'. If
only the mask property is defined on a node, maintain compatibility
by using it as the value.

This patch is based on commit
f2c199db477e ("power: reset: syscon-poweroff: add a mask property")
and does the same change for the syscon-reboot driver.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 .../devicetree/bindings/power/reset/syscon-reboot.txt | 11 +++++++++--
 drivers/power/reset/syscon-reboot.c                   | 19 +++++++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
index 11906316b43d..e23dea8344f8 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
@@ -3,13 +3,20 @@ Generic SYSCON mapped register reset driver
 This is a generic reset driver using syscon to map the reset register.
 The reset is generally performed with a write to the reset register
 defined by the register map pointed by syscon reference plus the offset
-with the mask defined in the reboot node.
+with the value and mask defined in the reboot node.
 
 Required properties:
 - compatible: should contain "syscon-reboot"
 - regmap: this is phandle to the register map node
 - offset: offset in the register map for the reboot register (in bytes)
-- mask: the reset value written to the reboot register (32 bit access)
+- value: the reset value written to the reboot register (32 bit access)
+
+Optional properties:
+- mask: update only the register bits defined by the mask (32 bit)
+
+Legacy usage:
+If a node doesn't contain a value property but contains a mask property, the
+mask property is used as the value.
 
 Default will be little endian mode, 32 bit access only.
 
diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 7d0d269a0837..5a6bb638c331 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -27,6 +27,7 @@
 struct syscon_reboot_context {
 	struct regmap *map;
 	u32 offset;
+	u32 value;
 	u32 mask;
 	struct notifier_block restart_handler;
 };
@@ -39,7 +40,7 @@ static int syscon_restart_handle(struct notifier_block *this,
 					restart_handler);
 
 	/* Issue the reboot */
-	regmap_write(ctx->map, ctx->offset, ctx->mask);
+	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
 
 	mdelay(1000);
 
@@ -51,6 +52,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 {
 	struct syscon_reboot_context *ctx;
 	struct device *dev = &pdev->dev;
+	int mask_err, value_err;
 	int err;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -64,8 +66,21 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
 		return -EINVAL;
 
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
+	value_err = of_property_read_u32(pdev->dev.of_node, "value", &ctx->value);
+	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask);
+	if (value_err && mask_err) {
+		dev_err(dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
+	}
+
+	if (value_err) {
+		/* support old binding */
+		ctx->value = ctx->mask;
+		ctx->mask = 0xFFFFFFFF;
+	} else if (mask_err) {
+		/* support value without mask*/
+		ctx->mask = 0xFFFFFFFF;
+	}
 
 	ctx->restart_handler.notifier_call = syscon_restart_handle;
 	ctx->restart_handler.priority = 192;
-- 
2.11.0

