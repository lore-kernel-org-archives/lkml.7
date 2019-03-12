Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EBD214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EuKqXK6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCLJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:21:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44725 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCLJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:21:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so1334074pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGL7IoA5RIuiJaJU+dd65dIaXKzkiZ2Fm6PnX/9A/OI=;
        b=EuKqXK6SROiKkw4nz4HDRfKdOOLyQlqP5gtEvpjx1MKt40WILsZi5VJcQ7+ghEbGpS
         m4CW/5UrpYjNGVGI/P9/vrOFiDTbgCImHtoB/G77YFhUK+8YW9cJhhUWz1e1btaP35Tw
         G9ETkpqWhS4qpgMDTRFtOx1y88QWCm64wVdD/nIspR5Ci4uwc8cb2vEC8NWsGP7MPLO3
         LTBgrH8+eTs3CPK+HTmcemx951v5srQNkq3pUsT41VOO7MwckzuYF81J6sEBiHjg6Hzl
         RX3t/n1Z+F4Jp7jfPndYQWAmxEpInvJtW9guDCLcJ2Bs2RikgCxCnBktDETy3nN7GINB
         crtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGL7IoA5RIuiJaJU+dd65dIaXKzkiZ2Fm6PnX/9A/OI=;
        b=MdDvJt9E4vbTdCVgR8I/MfP7yjQHCmd4bZuDFFzyzWvubbCRCt4TuOhiwX3EQe7nWT
         4BGqgeBuhtsEqMcB2GLFvffMXwyRXAwOZ04jvVZTPKz4HGTByzEmDobVK0Zv3MAEZ1Ak
         vfsuIItW1WD3Y4kQK+X4AeRTLOxPXeL+54H3/p0qSnsZcm2oXSbw/NHTrwibI7XxgjQj
         6m6HuHN21kqHXZF/no04R1lzFTxm1MR/eNz0r90x+F+bZow4B6Zdqs9GKrc9h7uGJops
         KYSCdLziEOxRRTZMYgBVRUUy1oqQ8gpzrNMTCi2XytwGkCA6Dt6SHXk83gO3z5LBzsU1
         30Aw==
X-Gm-Message-State: APjAAAXXjFTHf6ocIe1+I8whRg5uzlnO1TcJRjw9d97alNM0Cg2r3GFi
        610fgNDUc4Lwwkb94+q7NYX1KQ==
X-Google-Smtp-Source: APXvYqzeVlY17C+K+EyX1HWkzvbQJSe1wnvgRqp+s9qJE3tSW+/9i5nC4fNvgGHUlEjyI0Ij+0z4hQ==
X-Received: by 2002:a63:974a:: with SMTP id d10mr22069475pgo.344.1552382490054;
        Tue, 12 Mar 2019 02:21:30 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d86sm17569638pfm.18.2019.03.12.02.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 02:21:29 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache Controller
Date:   Tue, 12 Mar 2019 14:51:01 +0530
Message-Id: <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the SiFive L2 cache controller
on the HiFive Unleashed board

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/Kconfig            |   1 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/sifive_edac-l2.c | 292 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 301 insertions(+)
 create mode 100644 drivers/edac/sifive_edac-l2.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 515fc3c..fede4b6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
+	select EDAC_SUPPORT
 
 config MMU
 	def_bool y
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index e286b5b..63ccdf1 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -440,6 +440,13 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_SIFIVE_L2
+	tristate "Sifive L2 Cache"
+	depends on RISCV
+	help
+	  Support for error detection and correction on the SiFive L2
+	  cache controller.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 716096d..ad9e3d3 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
+obj-$(CONFIG_EDAC_SIFIVE_L2)		+= sifive_edac-l2.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
diff --git a/drivers/edac/sifive_edac-l2.c b/drivers/edac/sifive_edac-l2.c
new file mode 100644
index 0000000..124f43a
--- /dev/null
+++ b/drivers/edac/sifive_edac-l2.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive L2 Cache EDAC Driver
+ *
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ *
+ */
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include "edac_module.h"
+
+#define SIFIVE_EDAC_DIRFIX_LOW 0x100
+#define SIFIVE_EDAC_DIRFIX_HIGH 0x104
+#define SIFIVE_EDAC_DIRFIX_COUNT 0x108
+
+#define SIFIVE_EDAC_DIRFAIL_LOW 0x120
+#define SIFIVE_EDAC_DIRFAIL_HIGH 0x124
+#define SIFIVE_EDAC_DIRFAIL_COUNT 0x128
+
+#define SIFIVE_EDAC_DATFIX_LOW 0x140
+#define SIFIVE_EDAC_DATFIX_HIGH 0x144
+#define SIFIVE_EDAC_DATFIX_COUNT 0x148
+
+#define SIFIVE_EDAC_DATFAIL_LOW 0x160
+#define SIFIVE_EDAC_DATFAIL_HIGH 0x164
+#define SIFIVE_EDAC_DATFAIL_COUNT 0x168
+
+#define SIFIVE_EDAC_ECCINJECTERR 0x40
+#define SIFIVE_EDAC_CONFIG 0x00
+
+#define SIFIVE_EDAC_MAX_INTR 4
+
+/**
+ * struct sifive_edac_l2_priv - L2 cache controller private instance data
+ * @base:		Base address of the controller
+ * @irq[]:		Array of interrupt numbers
+ */
+struct sifive_edac_l2_priv {
+	void __iomem *base;
+	int irq[SIFIVE_EDAC_MAX_INTR];
+};
+
+enum {
+	dir_corr = 0,
+	dir_uncorr,
+	data_corr,
+	data_uncorr,
+};
+
+static struct dentry *sifive_edac_test;
+
+static ssize_t sifive_edac_l2_write(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *dci = file->private_data;
+	struct sifive_edac_l2_priv *priv = dci->pvt_info;
+	unsigned int val;
+
+	if (kstrtouint_from_user(data, count, 0, &val))
+		return -EINVAL;
+	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
+		writel(val, priv->base + SIFIVE_EDAC_ECCINJECTERR);
+	else
+		return -EINVAL;
+	return count;
+}
+
+static const struct file_operations sifive_edac_l2_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = sifive_edac_l2_write
+};
+
+static void setup_sifive_debug(struct edac_device_ctl_info *edac_dev)
+{
+	sifive_edac_test = edac_debugfs_create_dir("sifive_edac_test");
+	edac_debugfs_create_file("sifive_debug_inject_error", 0200,
+				 sifive_edac_test, edac_dev,
+				 &sifive_edac_l2_fops);
+}
+
+static void teardown_sifive_debug(void)
+{
+	debugfs_remove_recursive(sifive_edac_test);
+}
+
+/**
+ * sifive_edac_l2_int_handler - ISR function for l2 cache controller
+ * @irq:	Irq Number
+ * @device:	Pointer to the edac device controller instance
+ *
+ * This routine is triggered whenever there is ECC error detected
+ *
+ * Return: Always returns IRQ_HANDLED
+ */
+static irqreturn_t sifive_edac_l2_int_handler(int irq, void *device)
+{
+	struct edac_device_ctl_info *dci =
+					(struct edac_device_ctl_info *)device;
+	struct sifive_edac_l2_priv *priv = dci->pvt_info;
+	u32 regval, add_h, add_l;
+
+	if (irq == priv->irq[dir_corr]) {
+		add_h = readl(priv->base + SIFIVE_EDAC_DIRFIX_HIGH);
+		add_l = readl(priv->base + SIFIVE_EDAC_DIRFIX_LOW);
+		dev_err(dci->dev,
+			"DirError at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(priv->base + SIFIVE_EDAC_DIRFIX_COUNT);
+		edac_device_handle_ce(dci, 0, 0, "DirECCFix");
+	}
+	if (irq == priv->irq[dir_uncorr]) {
+		regval = readl(priv->base + SIFIVE_EDAC_DIRFAIL_COUNT);
+		edac_device_handle_ue(dci, 0, 0, "DirECCFail");
+		add_h = readl(priv->base + SIFIVE_EDAC_DIRFAIL_HIGH);
+		add_l = readl(priv->base + SIFIVE_EDAC_DIRFAIL_LOW);
+		panic("\nDirFail at address 0x%08X.%08X\n", add_h, add_l);
+	}
+	if (irq == priv->irq[data_corr]) {
+		add_h = readl(priv->base + SIFIVE_EDAC_DATFIX_HIGH);
+		add_l = readl(priv->base + SIFIVE_EDAC_DATFIX_LOW);
+		dev_err(dci->dev,
+			"DataError at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(priv->base + SIFIVE_EDAC_DATFIX_COUNT);
+		edac_device_handle_ce(dci, 0, 0, "DatECCFix");
+	}
+	if (irq == priv->irq[data_uncorr]) {
+		add_h = readl(priv->base + SIFIVE_EDAC_DATFAIL_HIGH);
+		add_l = readl(priv->base + SIFIVE_EDAC_DATFAIL_LOW);
+		dev_err(dci->dev,
+			"DataFail at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(priv->base + SIFIVE_EDAC_DATFAIL_COUNT);
+		edac_device_handle_ue(dci, 0, 0, "DatECCFail");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void sifive_edac_config_read(struct edac_device_ctl_info *dci)
+{
+	struct sifive_edac_l2_priv *priv = dci->pvt_info;
+	u32 regval, val;
+
+	regval = readl(priv->base + SIFIVE_EDAC_CONFIG);
+	val = regval & 0xFF;
+	dev_info(dci->dev, "No. of Banks in the cache: %d\n", val);
+	val = (regval & 0xFF00) >> 8;
+	dev_info(dci->dev, "No. of ways per bank: %d\n", val);
+	val = (regval & 0xFF0000) >> 16;
+	dev_info(dci->dev, "Sets per bank: %llu\n", (uint64_t)1 << val);
+	val = (regval & 0xFF000000) >> 24;
+	dev_info(dci->dev,
+		 "Bytes per cache block: %llu\n", (uint64_t)1 << val);
+}
+
+/**
+ * sifive_edac_l2_probe
+ * @pdev:	Pointer to the platform_device struct
+ *
+ * This routine probes a specific sifive-cache instance for binding
+ * with the driver.
+ *
+ * Return: 0 if the controller instance was successfully bound to the
+ * driver; otherwise, < 0 on error.
+ */
+static int sifive_edac_l2_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci;
+	struct sifive_edac_l2_priv *priv;
+	int rc, i, k;
+	struct resource *res;
+	void __iomem *baseaddr;
+	u32 intr_num, intr_offset = 0;
+
+	/* Get the data from the platform device */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	dci = edac_device_alloc_ctl_info(sizeof(*priv), "l2cache",
+					 1, "L", 1, 1, NULL, 0, 0);
+	if (IS_ERR(dci))
+		return PTR_ERR(dci);
+
+	priv = dci->pvt_info;
+	priv->base = baseaddr;
+	dci->dev = &pdev->dev;
+	dci->mod_name = "sifive_edac_l2";
+	dci->ctl_name = "sifive_l2_controller";
+	dci->dev_name = dev_name(&pdev->dev);
+
+	setup_sifive_debug(dci);
+	sifive_edac_config_read(dci);
+
+	intr_num = of_property_count_u32_elems(pdev->dev.of_node, "interrupts");
+	if (!intr_num) {
+		dev_err(&pdev->dev, "no interrupts property\n");
+		rc = -ENODEV;
+		goto del_edac_device;
+	}
+
+	/**
+	 * Only FU540 have 3 interrupts. Rest all instances of this IP have
+	 * 4 interrupts (+dirfail). Therefore intr_offest is required to
+	 * skip dirfail interrupt entry in case of FU540
+	 */
+	if (intr_num == 3)
+		intr_offset = 1;
+
+	priv->irq[dir_corr] = platform_get_irq(pdev, 0);
+	rc = devm_request_irq(&pdev->dev, priv->irq[dir_corr],
+			      sifive_edac_l2_int_handler, 0,
+			      dev_name(&pdev->dev), (void *)dci);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"Could not request IRQ %d\n", priv->irq[dir_corr]);
+		goto del_edac_device;
+	}
+
+	for (i = 1; i < intr_num; i++) {
+		k = i + intr_offset;
+		priv->irq[k] = platform_get_irq(pdev, i);
+		rc = devm_request_irq(&pdev->dev, priv->irq[k],
+				      sifive_edac_l2_int_handler, 0,
+				      dev_name(&pdev->dev), (void *)dci);
+		if (rc) {
+			dev_err(&pdev->dev,
+				"Could not request IRQ %d\n", priv->irq[k]);
+			goto del_edac_device;
+		}
+	}
+
+	rc = edac_device_add_device(dci);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to register with EDAC core\n");
+		goto del_edac_device;
+	}
+
+	return rc;
+
+del_edac_device:
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return rc;
+}
+
+/**
+ * sifive_edac_l2_remove - Unbind driver from controller
+ * @pdev:	Pointer to the platform_device struct
+ *
+ * This routine unbinds the EDAC device controller instance associated
+ * with the specified sifive-cache controller.
+ *
+ * Return: Always returns 0
+ */
+static int sifive_edac_l2_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+
+	teardown_sifive_debug();
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return 0;
+}
+
+/* Device tree node type and compatible tuples this driver can match on */
+static const struct of_device_id sifive_edac_l2_match[] = {
+	{ .compatible = "sifive,ccache0" },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, sifive_edac_l2_match);
+
+static struct platform_driver sifive_edac_l2_driver = {
+	.driver = {
+		 .name = "sifive-edac-l2",
+		 .owner = THIS_MODULE,
+		 .of_match_table = sifive_edac_l2_match,
+	},
+	.probe = sifive_edac_l2_probe,
+	.remove = sifive_edac_l2_remove,
+};
+
+module_platform_driver(sifive_edac_l2_driver);
+
+MODULE_AUTHOR("SiFive Inc.");
+MODULE_DESCRIPTION("sifive L2 EDAC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

