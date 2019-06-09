Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFCC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E73206BA
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RvdAEHZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfFIKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:32:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38218 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfFIKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:32:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x59AW8Tp086498;
        Sun, 9 Jun 2019 05:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560076328;
        bh=kEnQbaVnRCfu13tNDcBQcT3nclwNLkDBI0PsyU/g5Yk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RvdAEHZDruuL8C9rRgymnkn/TBOGw3e3RnxLtUFzOFsIQdzLNBz/9VxWfQdYFD/ZU
         HbTIJP8TKgGPngDf1fp4crf0AwDZWnZu3w3YxZlaEK7/yk4ZaIIujqmpF3882vBNbY
         m+/sbXu/ZbXevp33tKR1BAUDMBIv7OVPtix6Cc+0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x59AW8uF093595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Jun 2019 05:32:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 9 Jun
 2019 05:32:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 9 Jun 2019 05:32:08 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x59AVe1i049269;
        Sun, 9 Jun 2019 05:32:04 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/5] mtd: hyperbus: Add driver for TI's HyperBus memory controller
Date:   Sun, 9 Jun 2019 16:02:27 +0530
Message-ID: <20190609103227.24875-6-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609103227.24875-1-vigneshr@ti.com>
References: <20190609103227.24875-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for HyperBus memory controller on TI's AM654 SoC. Programming
IP is pretty simple and provides direct memory mapped access to
connected Flash devices.

Add basic support for the IP without DMA. Second chipSelect is not
supported for now.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
v5:
Drop unused fields from driver private struct

 drivers/mtd/hyperbus/Kconfig      |  12 ++++
 drivers/mtd/hyperbus/Makefile     |   1 +
 drivers/mtd/hyperbus/hbmc-am654.c | 110 ++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/mtd/hyperbus/hbmc-am654.c

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index 98147e28caa0..cff6bbd226f5 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -9,3 +9,15 @@ menuconfig MTD_HYPERBUS
 	  the HyperBus Controller driver to communicate with
 	  HyperFlash. See Cypress HyperBus specification for more
 	  details
+
+if MTD_HYPERBUS
+
+config HBMC_AM654
+	tristate "HyperBus controller driver for AM65x SoC"
+	select MULTIPLEXER
+	select MUX_MMIO
+	help
+	 This is the driver for HyperBus controller on TI's AM65x and
+	 other SoCs
+
+endif # MTD_HYPERBUS
diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
index ca61dedd730d..8a936e066f48 100644
--- a/drivers/mtd/hyperbus/Makefile
+++ b/drivers/mtd/hyperbus/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus-core.o
+obj-$(CONFIG_HBMC_AM654)	+= hbmc-am654.o
diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
new file mode 100644
index 000000000000..720d830aff60
--- /dev/null
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+// Author: Vignesh Raghavendra <vigneshr@ti.com>
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/hyperbus.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mux/consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+struct am654_hbmc_priv {
+	struct hyperbus_ctlr ctlr;
+	struct hyperbus_device hbdev;
+};
+
+static const struct hyperbus_ops am654_hbmc_ops = {
+	.calibrate = hyperbus_calibrate,
+};
+
+static int am654_hbmc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct am654_hbmc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	if (of_property_read_bool(dev->of_node, "mux-controls")) {
+		struct mux_control *control = devm_mux_control_get(dev, NULL);
+
+		if (IS_ERR(control))
+			return PTR_ERR(control);
+
+		ret = mux_control_select(control, 1);
+		if (ret) {
+			dev_err(dev, "Failed to select HBMC mux\n");
+			return ret;
+		}
+	}
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto disable_pm;
+	}
+
+	priv->ctlr.dev = dev;
+	priv->ctlr.ops = &am654_hbmc_ops;
+	priv->hbdev.ctlr = &priv->ctlr;
+	priv->hbdev.np = of_get_next_child(dev->of_node, NULL);
+	ret = hyperbus_register_device(&priv->hbdev);
+	if (ret) {
+		dev_err(dev, "failed to register controller\n");
+		pm_runtime_put_sync(&pdev->dev);
+		goto disable_pm;
+	}
+
+	return 0;
+disable_pm:
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int am654_hbmc_remove(struct platform_device *pdev)
+{
+	struct am654_hbmc_priv *priv = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = hyperbus_unregister_device(&priv->hbdev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static const struct of_device_id am654_hbmc_dt_ids[] = {
+	{
+		.compatible = "ti,am654-hbmc",
+	},
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, am654_hbmc_dt_ids);
+
+static struct platform_driver am654_hbmc_platform_driver = {
+	.probe = am654_hbmc_probe,
+	.remove = am654_hbmc_remove,
+	.driver = {
+		.name = "hbmc-am654",
+		.of_match_table = am654_hbmc_dt_ids,
+	},
+};
+
+module_platform_driver(am654_hbmc_platform_driver);
+
+MODULE_DESCRIPTION("HBMC driver for AM654 SoC");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:hbmc-am654");
+MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
-- 
2.21.0

