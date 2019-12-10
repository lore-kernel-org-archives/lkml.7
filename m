Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D94C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8299E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwyahkVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLJUBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:01:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46973 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfLJUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:01:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so21419225wrl.13;
        Tue, 10 Dec 2019 12:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gXxjPhJ3Q7lu/30NWGeVZetMfJAJiDa+9jYWsXuiNY4=;
        b=QwyahkVI/O2HXvXv01ZnNh5RjagGtwlxGoPp97Kvt1FjORtnBVkybPbcIdhn/TT4z9
         McqMXz5y0280tJFMD4jzZbp5PXxqILyf876XCWN5b5V5dHyuGFyzXa3XXzmmxrWIoKAp
         jYwQlKE0XDAUaToLLRYvNuSvinUnoRCe7oM5GH1p6hCA0wvwAxFz1Dv9Ut6yBC9HHfZ9
         rjFW1blGL6I6LVWNSP9WJftoxojZ0GhrJeq5BY56psiNI871Wws7yWtsZYoLgVUlgt7h
         mab0mv0siqcdJXH+b6f0XxC1m/eWIoe+e9pxTmjcowk09VrNsPmte+xFOwqsdKp1RhuG
         B4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gXxjPhJ3Q7lu/30NWGeVZetMfJAJiDa+9jYWsXuiNY4=;
        b=nw1uq+LOglhpwOkNgIUYy/xonNTtVG/5J76x/PtXU0/worksVH8wpn7uhs/IjdRmXu
         BkZ7UBxaZK5sItNG+bHn7IhgfRm1xK+mpTC5cnuOtWuHuCGtPBrGBq+RAEB/4O1Q+5Oe
         FrSqZ3BxHe39WfRK+CHrAVw0CasWr0O5pkXHcFpijEUbDM/05eVZo6+JoSF0OaKc1WBs
         HCw0pm/hK956a0IKqzyq68a7yLsvZlIMoKRx+LOOjr7C7q0TYg05fNy3K5QBNm3t5ziG
         XQxaT6ykTBKPNbmEf7EVPEfObK57vyjg1eRPYwQg3/TxtBsS3tVLPtCjzytLjbyuLDCk
         +mpA==
X-Gm-Message-State: APjAAAXTalJwZQ0GlMLf2ubndlvcOJS/9KYaepL+tVNMJ5dMQVuk9eIu
        mekyw1BcT7kHt3S0uQuYsddl2YUX
X-Google-Smtp-Source: APXvYqzlwL2JVvC24iFfkTJHpiYHh759+P/FnYILdCUDrTo3HueHBW1pbEbI79hKMfNAMaulXP3iHA==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr5190052wrw.311.1576008102576;
        Tue, 10 Dec 2019 12:01:42 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6sm4352255wmz.12.2019.12.10.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:01:41 -0800 (PST)
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
Subject: [PATCH 2/2] reset: Add Broadcom STB RESCAL reset controller
Date:   Tue, 10 Dec 2019 11:59:03 -0800
Message-Id: <20191210195903.24127-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210195903.24127-1-f.fainelli@gmail.com>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
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
 drivers/reset/reset-brcmstb-rescal.c | 124 +++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
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
index 000000000000..58a30e624a14
--- /dev/null
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018 Broadcom */
+
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/types.h>
+
+#define BRCM_RESCAL_START	0
+#define	BRCM_RESCAL_START_BIT	BIT(0)
+#define BRCM_RESCAL_CTRL	4
+#define BRCM_RESCAL_STATUS	8
+#define BRCM_RESCAL_STATUS_BIT	BIT(0)
+
+struct brcm_rescal_reset {
+	void __iomem	*base;
+	struct device *dev;
+	struct reset_controller_dev rcdev;
+};
+
+static int brcm_rescal_reset_assert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	return 0;
+}
+
+static int brcm_rescal_reset_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct brcm_rescal_reset *data =
+		container_of(rcdev, struct brcm_rescal_reset, rcdev);
+	void __iomem *base = data->base;
+	const int NUM_RETRIES = 10;
+	u32 reg;
+	int i;
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	reg = readl(base + BRCM_RESCAL_START);
+	if (!(reg & BRCM_RESCAL_START_BIT)) {
+		dev_err(data->dev, "failed to start sata/pcie rescal\n");
+		return -EIO;
+	}
+
+	reg = readl(base + BRCM_RESCAL_STATUS);
+	for (i = NUM_RETRIES; i >= 0 &&  !(reg & BRCM_RESCAL_STATUS_BIT); i--) {
+		udelay(100);
+		reg = readl(base + BRCM_RESCAL_STATUS);
+	}
+	if (!(reg & BRCM_RESCAL_STATUS_BIT)) {
+		dev_err(data->dev, "timedout on sata/pcie rescal\n");
+		return -ETIMEDOUT;
+	}
+
+	reg = readl(base + BRCM_RESCAL_START);
+	writel(reg ^ BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	reg = readl(base + BRCM_RESCAL_START);
+	dev_dbg(data->dev, "sata/pcie rescal success\n");
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
+	.assert = brcm_rescal_reset_assert,
+	.deassert = brcm_rescal_reset_deassert,
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
+
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
+MODULE_DESCRIPTION("Broadcom Sata/PCIe rescal reset controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

