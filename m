Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B24BC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AA921655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfL2Mp6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgABXO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:14:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39698 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgABXOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:14:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so7126647wmj.4;
        Thu, 02 Jan 2020 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTfXXdQ4DaxX2MrB4LmP+Aif0Q6oi4pCATE+/VJBSQM=;
        b=XfL2Mp6mF0j02+Mx1hWLUnGOA7wAsq0Bti5MnU/f4Mp/16QraUGtGG784B6fpIOoXA
         JU57eT5H5zbuOUuOvvAxB30ExpiB4JPT8KEBdhEB6y25Y9+aCUrmS1NgMxiY3mqEtEnH
         iUGNJzv0bF5vElNJH3Gp6ks1MLs9gjne1WugqSdDXFE0MrolZdHJMmQRk0YypblLJ1OH
         7OGI6Q+kY8OuRToLX4YYFDkgy/2U5PfUv39y5ygQfGgGZtD3YCFHXMToZcWTCUDIaM7h
         dFvtOWk2UhsQ7Eicu0L67WjGGissCqWwFacJQimimsVDSUsnpwguUvXQlqeUjPTnep3F
         yYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VTfXXdQ4DaxX2MrB4LmP+Aif0Q6oi4pCATE+/VJBSQM=;
        b=WlsihtR/5wfoWw17dkDJrPnmKjcV4RWGT5bg78gSs3v5TdoN+USsE8yPMdoZ6RsH56
         dHnJLdegwbVywNqf0eiMkItU6/uNMVzO8La1LQeDr9Dic/iLm4ryFPVArsr62c9fRN0k
         J3u6CmufjBluZnFM3QGc90tWp7nT/ZzSl0AefTOdeaeDlpql38upVmBzO/ik6aZ7XsBO
         rH6DMx9CGzdOS09H979Xy1oM/q/8/YhDevAWZYsR/wvYcAMD61ExvTbTugKfBDZNyszW
         Yd9aZlUj20+1VeDl27/nSu0GMF86TPGa6x9cCMWbjuFnwAyGf5dLQCmYOAUeC1VhA65e
         r/AA==
X-Gm-Message-State: APjAAAX12BOaidrFF+jDJATGL3bkXfzMzuC4Y3MV/kOQBQ29tjNuFAo5
        llXehAjgLJ1PCK9+h/e4Wf2wnI6x
X-Google-Smtp-Source: APXvYqy+KtO1EhMOojqacKzhBKB/AComoMyRoMJHdAeWNF0QTJABnPZu5GPo3N5iBDUHq9zKrk7itA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr16778749wmj.170.1578006891076;
        Thu, 02 Jan 2020 15:14:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i10sm58214711wru.16.2020.01.02.15.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:14:50 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <im2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v2 2/2] reset: Add Broadcom STB RESCAL reset controller
Date:   Thu,  2 Jan 2020 15:14:35 -0800
Message-Id: <20200102231435.21703-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102231435.21703-1-f.fainelli@gmail.com>
References: <20200102231435.21703-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

On BCM7216 there is a special purpose reset controller named RESCAL
(reset calibration) which is necessary for SATA and PCIe0/1 to operate
correctly. This commit adds support for such a reset controller to be
available.

Signed-off-by: Jim Quinlan <im2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/Kconfig                |   7 ++
 drivers/reset/Makefile               |   1 +
 drivers/reset/reset-brcmstb-rescal.c | 110 +++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 12f5c897788d..b7cc0a2049d9 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -49,6 +49,13 @@ config RESET_BRCMSTB
 	  This enables the reset controller driver for Broadcom STB SoCs using
 	  a SUN_TOP_CTRL_SW_INIT style controller.
 
+config RESET_BRCMSTB_RESCAL
+	bool "Broadcom STB RESCAL reset controller"
+	default ARCH_BRCMSTB || COMPILE_TEST
+	help
+	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
+	  BCM7216.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 00767c03f5f2..1e4291185c52 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
+obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
new file mode 100644
index 000000000000..e1c038e62855
--- /dev/null
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2020 Broadcom */
+
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#define BRCM_RESCAL_START	0x0
+#define  BRCM_RESCAL_START_BIT	BIT(0)
+#define BRCM_RESCAL_CTRL	0x4
+#define BRCM_RESCAL_STATUS	0x8
+#define  BRCM_RESCAL_STATUS_BIT	BIT(0)
+
+struct brcm_rescal_reset {
+	void __iomem	*base;
+	struct device *dev;
+	struct reset_controller_dev rcdev;
+};
+
+static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct brcm_rescal_reset *data =
+		container_of(rcdev, struct brcm_rescal_reset, rcdev);
+	void __iomem *base = data->base;
+	u32 reg;
+	int ret;
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	reg = readl(base + BRCM_RESCAL_START);
+	if (!(reg & BRCM_RESCAL_START_BIT)) {
+		dev_err(data->dev, "failed to start SATA/PCIe rescal\n");
+		return -EIO;
+	}
+
+	ret = readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
+				 !(reg & BRCM_RESCAL_STATUS_BIT), 100, 1000);
+	if (ret) {
+		dev_err(data->dev, "time out on SATA/PCIe rescal\n");
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg & ~BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	(void)readl(base + BRCM_RESCAL_START);
+
+	dev_dbg(data->dev, "SATA/PCIe rescal success\n");
+
+	return 0;
+}
+
+static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
+				   const struct of_phandle_args *reset_spec)
+{
+	/* This is needed if #reset-cells == 0. */
+	return 0;
+}
+
+static const struct reset_control_ops brcm_rescal_reset_ops = {
+	.reset = brcm_rescal_reset_set,
+};
+
+static int brcm_rescal_reset_probe(struct platform_device *pdev)
+{
+	struct brcm_rescal_reset *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	platform_set_drvdata(pdev, data);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = 1;
+	data->rcdev.ops = &brcm_rescal_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+	data->rcdev.of_xlate = brcm_rescal_reset_xlate;
+	data->dev = &pdev->dev;
+
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+}
+
+static const struct of_device_id brcm_rescal_reset_of_match[] = {
+	{ .compatible = "brcm,bcm7216-pcie-sata-rescal" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, brcm_rescal_reset_of_match);
+
+static struct platform_driver brcm_rescal_reset_driver = {
+	.probe = brcm_rescal_reset_probe,
+	.driver = {
+		.name	= "brcm-rescal-reset",
+		.of_match_table	= brcm_rescal_reset_of_match,
+	}
+};
+module_platform_driver(brcm_rescal_reset_driver);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom SATA/PCIe rescal reset controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

