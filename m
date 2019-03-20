Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE382186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Acfp+eAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfCTLxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:53:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46535 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfCTLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:53:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so1521945pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LrD9ef6jRi4Ew9eqOrL8wZ6fmVnDcVu1JDMZzlUdXhI=;
        b=Acfp+eAuP4FcMzudDyaISlQscfeq6qEVrip9EmU6wJSr68mBEsOLpc+L54O4cHGjnx
         nLR198WR+TNRZZEkGR5+v1bDr3Y7HvHhWLScSdMZuagtXD1QUQlD4LFW0xP3wg8L4zLP
         O3dj8rOy4kJVAm9QypTO2bTFzxohzgaXH/DH18lLNOu5UmpUqTysp8F5PLfYh0AKmmfr
         4gOCL7S/DPxdyvrq/ZHf2pEGE0o2q/JYXIK2fhRIwR/7P+ZMO2pSV/VpJsQK1IDdoY8z
         s94G5rKQARpJDsrQ1YitbbNDzMxinluNx9Lu/GYdDp83BjigNjmGHz19/jWwQjREzEdH
         qVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LrD9ef6jRi4Ew9eqOrL8wZ6fmVnDcVu1JDMZzlUdXhI=;
        b=RVJ+gG7KB5sUJpNV7iynKqkqAu2e21d8ibqmQrAUlAZNWF8+0Pr0HfBMd6Y6L0M9eb
         btXVtwJVltG8rLEq2/8P3J5++JfrVY5sKaUM0jROhAufv4xSQqQXTS3rYm8jhRso/wAp
         c5HHZqgzqHGAvTTwO39/50z1VXezLKJBIZIbYv1SQl7++u8ha9Kzpqhy5fD+7flflZHS
         L+U25pGt6mQn9HcUHv5QKToRANVmMDducsbH27BmyPn4B/VqD3xZ438iUR6WU4VQT8o+
         F4c/TBwymrqWJwEElsiQ+MkMYfPJBQer6ejkHN5JaLa7g94hC2klitSkkWaNPTPDNfmd
         xSPw==
X-Gm-Message-State: APjAAAVxMWA/j/G/DEoL+fOeFNtYqL+Gf6p2rYt/WSJ50lvjc2+v3302
        IhQyH6o7pozfipkIXox3oNjRqg==
X-Google-Smtp-Source: APXvYqwwpLIdxLHcYrba/mguyegxfGR9Ysvb9Rp2MSHSyc2iPeB3O8JmvkZP/HRor//68tk5Qn+v+g==
X-Received: by 2002:aa7:8609:: with SMTP id p9mr7538948pfn.166.1553082830117;
        Wed, 20 Mar 2019 04:53:50 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id u10sm1999435pgr.2.2019.03.20.04.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 04:53:49 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000 chip
Date:   Wed, 20 Mar 2019 17:22:08 +0530
Message-Id: <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This EDAC driver supports:
- Initial configuration reporting on bootup via debug logs
- ECC event monitoring and reporting through the EDAC framework
- ECC event injection

This driver is partially based on pnd2_edac.c and altera_edac.c

Initially L2 Cache controller is added as a subcomponent to
this EDAC driver.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/Kconfig         |   1 +
 drivers/edac/Kconfig       |  13 ++
 drivers/edac/Makefile      |   1 +
 drivers/edac/sifive_edac.c | 297 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 drivers/edac/sifive_edac.c

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
index e286b5b..112d9d1 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -440,6 +440,19 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_SIFIVE
+	tristate "Sifive ECC"
+	depends on RISCV
+	help
+	  Support for error detection and correction on the SiFive SoCs.
+
+config EDAC_SIFIVE_L2
+	bool "SiFive L2 Cache ECC"
+	depends on EDAC_SIFIVE=y
+	help
+	  Support for error detection and correction of the L2 cache
+	  memory on SiFive SoCs.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 716096d..b16dce8 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
 
 obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
+obj-$(CONFIG_EDAC_SIFIVE)		+= sifive_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
new file mode 100644
index 0000000..e11ae6b5
--- /dev/null
+++ b/drivers/edac/sifive_edac.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive EDAC Driver
+ *
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ *
+ */
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include "edac_module.h"
+
+#define SIFIVE_EDAC_DIRFIX_LOW 0x100
+#define SIFIVE_EDAC_DIRFIX_HIGH 0x104
+#define SIFIVE_EDAC_DIRFIX_COUNT 0x108
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
+#define SIFIVE_EDAC_MAX_INTR 3
+
+/************************* EDAC Parent Probe *************************/
+
+static const struct of_device_id sifive_edac_device_of_match[];
+
+static const struct of_device_id sifive_edac_of_match[] = {
+	{ .compatible = "sifive,ecc-manager" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sifive_edac_of_match);
+
+static int sifive_edac_probe(struct platform_device *pdev)
+{
+	of_platform_populate(pdev->dev.of_node, sifive_edac_device_of_match,
+			     NULL, &pdev->dev);
+	return 0;
+}
+
+static struct platform_driver sifive_edac_driver = {
+	.probe =  sifive_edac_probe,
+	.driver = {
+		.name = "ecc_manager",
+		.of_match_table = sifive_edac_of_match,
+	},
+};
+module_platform_driver(sifive_edac_driver);
+
+struct sifive_edac_device_prv {
+	void (*setup)(struct edac_device_ctl_info *dci);
+	irqreturn_t (*ecc_irq_handler)(int irq, void *dev_id);
+	const struct file_operations *inject_fops;
+};
+
+struct sifive_edac_device_dev {
+	void __iomem *base;
+	int irq[SIFIVE_EDAC_MAX_INTR];
+	struct sifive_edac_device_prv *data;
+	char *edac_dev_name;
+};
+
+enum {
+	dir_corr = 0,
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
+	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
+	unsigned int val;
+
+	if (kstrtouint_from_user(data, count, 0, &val))
+		return -EINVAL;
+	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
+		writel(val, drvdata->base + SIFIVE_EDAC_ECCINJECTERR);
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
+static void setup_sifive_debug(struct edac_device_ctl_info *edac_dci,
+			       const struct sifive_edac_device_prv *prv)
+{
+	struct sifive_edac_device_dev *drvdata = edac_dci->pvt_info;
+
+	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
+		return;
+
+	sifive_edac_test = edac_debugfs_create_dir(drvdata->edac_dev_name);
+	if (!sifive_edac_test)
+		return;
+
+	if (!edac_debugfs_create_file("sifive_debug_inject_error", 0200,
+				      sifive_edac_test, edac_dci,
+				      prv->inject_fops))
+		debugfs_remove_recursive(sifive_edac_test);
+}
+
+static void teardown_sifive_debug(void)
+{
+	debugfs_remove_recursive(sifive_edac_test);
+}
+
+/*
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
+	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
+	u32 regval, add_h, add_l;
+
+	if (irq == drvdata->irq[dir_corr]) {
+		add_h = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_HIGH);
+		add_l = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_LOW);
+		dev_err(dci->dev,
+			"DirError at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_COUNT);
+		edac_device_handle_ce(dci, 0, 0, "DirECCFix");
+	}
+	if (irq == drvdata->irq[data_corr]) {
+		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFIX_HIGH);
+		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFIX_LOW);
+		dev_err(dci->dev,
+			"DataError at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(drvdata->base + SIFIVE_EDAC_DATFIX_COUNT);
+		edac_device_handle_ce(dci, 0, 0, "DatECCFix");
+	}
+	if (irq == drvdata->irq[data_uncorr]) {
+		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_HIGH);
+		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_LOW);
+		dev_err(dci->dev,
+			"DataFail at address 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_COUNT);
+		edac_device_handle_ue(dci, 0, 0, "DatECCFail");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void sifive_edac_l2_config_read(struct edac_device_ctl_info *dci)
+{
+	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
+	u32 regval, val;
+
+	regval = readl(drvdata->base + SIFIVE_EDAC_CONFIG);
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
+static const struct sifive_edac_device_prv l2ecc_data = {
+	.setup = sifive_edac_l2_config_read,
+	.inject_fops = &sifive_edac_l2_fops,
+	.ecc_irq_handler = sifive_edac_l2_int_handler,
+};
+
+/*
+ * sifive_edac_device_probe()
+ *	This is a generic EDAC device driver that will support
+ *	various SiFive memory devices as well as the memories
+ *	for other peripherals. Module specific initialization is
+ *	done by passing the function index in the device tree.
+ */
+static int sifive_edac_device_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci;
+	struct sifive_edac_device_dev *drvdata;
+	int rc, i;
+	struct resource *res;
+	void __iomem *baseaddr;
+	struct device_node *np = pdev->dev.of_node;
+	char *ecc_name = (char *)np->name;
+	static int dev_instance;
+
+	/* Get the data from the platform device */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
+					 1, ecc_name, 1, 1, NULL, 0,
+					 dev_instance++);
+	if (IS_ERR(dci))
+		return PTR_ERR(dci);
+
+	drvdata = dci->pvt_info;
+	drvdata->base = baseaddr;
+	drvdata->edac_dev_name = ecc_name;
+	dci->dev = &pdev->dev;
+	dci->mod_name = "Sifive ECC Manager";
+	dci->ctl_name = dev_name(&pdev->dev);
+	dci->dev_name = dev_name(&pdev->dev);
+
+	 /* Get driver specific data for this EDAC device */
+	drvdata->data = of_match_node(sifive_edac_device_of_match, np)->data;
+
+	setup_sifive_debug(dci, drvdata->data);
+
+	if (drvdata->data->setup)
+		drvdata->data->setup(dci);
+
+	for (i = 0; i < SIFIVE_EDAC_MAX_INTR; i++) {
+		drvdata->irq[i] = platform_get_irq(pdev, i);
+		rc = devm_request_irq(&pdev->dev, drvdata->irq[i],
+				      sifive_edac_l2_int_handler, 0,
+				      dev_name(&pdev->dev), (void *)dci);
+		if (rc) {
+			dev_err(&pdev->dev,
+				"Could not request IRQ %d\n", drvdata->irq[i]);
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
+	teardown_sifive_debug();
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return rc;
+}
+
+static int sifive_edac_device_remove(struct platform_device *pdev)
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
+static const struct of_device_id sifive_edac_device_of_match[] = {
+	{ .compatible = "sifive,ccache0", .data = &l2ecc_data },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, sifive_edac_device_of_match);
+
+static struct platform_driver sifive_edac_device_driver = {
+	.driver = {
+		 .name = "sifive_edac_device",
+		 .owner = THIS_MODULE,
+		 .of_match_table = sifive_edac_device_of_match,
+	},
+	.probe = sifive_edac_device_probe,
+	.remove = sifive_edac_device_remove,
+};
+
+module_platform_driver(sifive_edac_device_driver);
+
+MODULE_AUTHOR("SiFive Inc.");
+MODULE_DESCRIPTION("SiFive EDAC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

