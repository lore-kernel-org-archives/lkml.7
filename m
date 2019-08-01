Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB494C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4B720838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564685073;
	bh=3y+RqDak0UkrCLxvk0BuKlXenYkKsg6JY6DZHMkLiA8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qeNcpeiwEQHpvYuRS1dRVbNNkV7sBEg2gbrCdS/SOc1pBhVduWnNGWVkHhhmwV5K+
	 2Q2tUkm3hCrGV0lWkFWHhJkzrTxujgtHyZk8B4kd9z1u57w/0tOvf7x0Ss1n2pplTK
	 aufDW11COv6rABEX2yNVfUAQPWEYkl1Y2D/9XUEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfHASoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfHASoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:44:32 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6392084C;
        Thu,  1 Aug 2019 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564685071;
        bh=3y+RqDak0UkrCLxvk0BuKlXenYkKsg6JY6DZHMkLiA8=;
        h=From:To:Cc:Subject:Date:From;
        b=YAexMpfN0WJQniiBCxagjhF5dbmJMGAUQx2JqGVz9+1X3mHJcDG3IJ020o3weANxz
         Ar9X7Qoksy6LHObkkDF70yWBkXlDwEwcDpDt7EMuOHyDU7HedKVOWKYsPOKZVlHi8o
         B3jD5BKDPL96GC7cMGte3LtdYRo8tzYqI46Q86fA=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH] drivers/amba: add reset control to primecell probe
Date:   Thu,  1 Aug 2019 13:43:46 -0500
Message-Id: <20190801184346.7015-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
default. Until recently, the DMA controller was brought out of reset by the
bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals that
are not used are held in reset and are left to Linux to bring them out of
reset.

Add a mechanism for getting the reset property and de-assert the primecell
module from reset if found. This is a not a hard fail if the reset property
is not present in the device tree node, so the driver will continue to probe.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/of/platform.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7801e25e6895..d8945705313d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -21,6 +21,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
@@ -229,6 +230,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	struct amba_device *dev;
 	const void *prop;
 	int i, ret;
+	struct reset_control *rstc;
 
 	pr_debug("Creating amba device %pOF\n", node);
 
@@ -270,6 +272,18 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		goto err_free;
 	}
 
+	/*
+	 * reset control of the primecell block is optional
+	 * and will not fail if the reset property is not found.
+	 */
+	rstc = of_reset_control_get_exclusive(node, "dma");
+	if (!IS_ERR(rstc)) {
+		reset_control_deassert(rstc);
+		reset_control_put(rstc);
+	} else {
+		pr_debug("amba: reset control not found\n");
+	}
+
 	ret = amba_device_add(dev, &iomem_resource);
 	if (ret) {
 		pr_err("amba_device_add() failed (%d) for %pOF\n",
-- 
2.20.0

