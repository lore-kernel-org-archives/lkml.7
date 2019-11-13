Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E0EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BB0206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfKMRP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:15:26 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49593 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfKMRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:20 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B183EE000A;
        Wed, 13 Nov 2019 17:15:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 4/4] mtd: Add driver for concatenating devices
Date:   Wed, 13 Nov 2019 18:15:05 +0100
Message-Id: <20191113171505.26128-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113171505.26128-1-miquel.raynal@bootlin.com>
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernhard Frauendienst <kernel@nospam.obeliks.de>

Some MTD drivers like physmap variants have support for concatenating
multiple MTD devices, but there is no generic way to define such a
concatenated device from within the device tree.

This is useful for boards where memory range has been extended with
the use of multiple flash chips as memory banks of a single MTD
device, with partitions spanning chip borders.

Add a driver for creating virtual mtd-concat devices. They must have
the "mtd-concat" compatible, and define a list of 'devices' to
concatenate, ie:

        flash {
                compatible = "mtd-concat";
                devices = <&flash0 &flash1>;

                partitions {
                        ...
                };
        };

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
[<miquel.raynal@bootlin.com>:
Reword commit message a bit.
Use the word 'virtual' instead of 'composite'.
Do not probe the virtual device last: SPI is after MTD anyway.
Change the driver's location.
Update the driver logic and coding style.]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/Kconfig           |   8 +++
 drivers/mtd/Makefile          |   1 +
 drivers/mtd/mtd_virt_concat.c | 132 ++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/mtd/mtd_virt_concat.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 79a8ff542883..3e1e55e7158f 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -276,6 +276,14 @@ config MTD_PARTITIONED_MASTER
 	  the parent of the partition device be the master device, rather than
 	  what lies behind the master.
 
+config MTD_VIRT_CONCAT
+	tristate "Virtual concatenated MTD devices"
+	help
+	  This driver allows creation of a virtual MTD device, which
+	  concatenates multiple physical MTD devices into a single one.
+	  This is useful to create partitions bigger than the underlying
+	  physical chips by allowing cross-chip boundaries.
+
 source "drivers/mtd/chips/Kconfig"
 
 source "drivers/mtd/maps/Kconfig"
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 58fc327a5276..c7ee13368a66 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SSFDC)		+= ssfdc.o
 obj-$(CONFIG_SM_FTL)		+= sm_ftl.o
 obj-$(CONFIG_MTD_OOPS)		+= mtdoops.o
 obj-$(CONFIG_MTD_SWAP)		+= mtdswap.o
+obj-$(CONFIG_MTD_VIRT_CONCAT)	+= mtd_virt_concat.o
 
 nftl-objs		:= nftlcore.o nftlmount.o
 inftl-objs		:= inftlcore.o inftlmount.o
diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
new file mode 100644
index 000000000000..d184c58f7e09
--- /dev/null
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Virtual concat MTD device driver
+ *
+ * Copyright (C) 2018 Bernhard Frauendienst
+ * Author: Bernhard Frauendienst <kernel@nospam.obeliks.de>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mtd/concat.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/**
+ * struct mtd_virt_concat - platform device driver data.
+ * @vmtd: Virtual mtd_concat device
+ * @count: Number of physical underlaying devices in @devices
+ * @devices: Array of the physical devices used
+ */
+struct mtd_virt_concat {
+	struct mtd_info	*vmtd;
+	unsigned int count;
+	struct mtd_info	**devices;
+};
+
+static void mtd_virt_concat_put_devices(struct mtd_virt_concat *concat)
+{
+	int i;
+
+	for (i = 0; i < concat->count; i++)
+		put_mtd_device(concat->devices[i]);
+}
+
+static int mtd_virt_concat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct mtd_virt_concat *concat;
+	struct of_phandle_iterator it;
+	struct mtd_info *mtd;
+	int ret, count;
+
+	count = of_count_phandle_with_args(node, "devices", NULL);
+	if (count < 2) {
+		dev_err(dev, "minimum 2 devices, given: %d\n", count);
+		return -EINVAL;
+	}
+
+	concat = devm_kzalloc(dev, sizeof(*concat), GFP_KERNEL);
+	if (!concat)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, concat);
+
+	concat->devices = devm_kcalloc(dev, count, sizeof(*concat->devices),
+				       GFP_KERNEL);
+	if (!concat->devices)
+		return -ENOMEM;
+
+	/* Aggregate the physical devices */
+	of_for_each_phandle(&it, ret, node, "devices", NULL, 0) {
+		mtd = get_mtd_device_by_node(it.node);
+		if (IS_ERR(mtd)) {
+			ret = -EPROBE_DEFER;
+			goto put_mtd_devices;
+		}
+
+		concat->devices[concat->count++] = mtd;
+	}
+
+	/* Create the virtual device */
+	concat->vmtd = mtd_concat_create(concat->devices, concat->count,
+					 dev_name(dev));
+	if (!concat->vmtd) {
+		ret = -ENXIO;
+		goto put_mtd_devices;
+	}
+
+	concat->vmtd->dev.parent = dev;
+	mtd_set_of_node(concat->vmtd, node);
+
+	/* Register the platform device */
+	ret = mtd_device_register(concat->vmtd, NULL, 0);
+	if (ret)
+		goto destroy_concat;
+
+	return 0;
+
+destroy_concat:
+	mtd_concat_destroy(concat->vmtd);
+put_mtd_devices:
+	mtd_virt_concat_put_devices(concat);
+
+	return ret;
+}
+
+static int mtd_virt_concat_remove(struct platform_device *pdev)
+{
+	struct mtd_virt_concat *concat = platform_get_drvdata(pdev);
+
+	mtd_device_unregister(concat->vmtd);
+	mtd_concat_destroy(concat->vmtd);
+	mtd_virt_concat_put_devices(concat);
+
+	return 0;
+}
+
+static const struct of_device_id mtd_virt_concat_of_match[] = {
+	{
+		.compatible = "mtd-concat",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtd_virt_concat_of_match);
+
+static struct platform_driver mtd_virt_concat_driver = {
+	.probe = mtd_virt_concat_probe,
+	.remove = mtd_virt_concat_remove,
+	.driver	 = {
+		.name   = "mtd-virt-concat",
+		.of_match_table = mtd_virt_concat_of_match,
+	},
+};
+module_platform_driver(mtd_virt_concat_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Bernhard Frauendienst <kernel@nospam.obeliks.de>");
+MODULE_DESCRIPTION("Virtual concat MTD device driver");
-- 
2.20.1

