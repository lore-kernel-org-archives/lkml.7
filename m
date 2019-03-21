Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635262190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b7MiIOk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfCURqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:46:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52030 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfCURp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:45:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LHjCa2083275;
        Thu, 21 Mar 2019 12:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553190312;
        bh=R0j882k21jSr+7+ghwqKWDOpETNjQKT5yBM/IuhYmVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b7MiIOk+vZCp8kz5TiOE0YBgZUZLiFMvhiSEUXHb2OJVgblYoSsNsEWAzM8x3rktN
         y2ekw7IE0nLDpINH46LJepFpSzITe3/cIMVkWBTHGLNQoNJbPSLYSaJXi495QV/f+0
         1Ne5cDvPuzGfPXQLI2fBHQ4Oy/K0Pv0AWJK2EoHo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LHjC0Z121578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 12:45:12 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 12:45:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 12:45:11 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LHiq2X018392;
        Thu, 21 Mar 2019 12:45:07 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [RFC PATCH v2 3/5] mtd: Add support for Hyperbus memory devices
Date:   Thu, 21 Mar 2019 23:15:46 +0530
Message-ID: <20190321174548.9288-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321174548.9288-1-vigneshr@ti.com>
References: <20190321174548.9288-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cypress' Hyperbus is Low Signal Count, High Performance Double Data Rate
Bus interface between a host system master and one or more slave
interfaces. Hyperbus is used to connect microprocessor, microcontroller,
or ASIC devices with random access NOR flash memory (called Hyperflash)
or self refresh DRAM (called HyperRAM).

Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
signal and either Single-ended clock(3.0V parts) or Differential clock
(1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
At bus level, it follows a separate protocol described in Hyperbus
specification[1].

Hyperflash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
Hyperbus operates at >166MHz frequencies.
HyperRAM provides direct random read/write access to flash memory
array.

But, Hyperbus memory controllers seem to abstract implementation details
and expose a simple MMIO interface to access connected flash.

Add support for registering Hyperflash devices with MTD framework. MTD
maps framework along with CFI chip support framework are used to support
communicating with flash.

Framework is modelled along the lines of spi-nor framework. Hyperbus
memory controller (HBMC) drivers calls hyperbus_register_device() to
register a single Hyperflash device. Hyperflash core parses MMIO access
information from DT, sets up the map_info struct, probes CFI flash and
registers it with MTD framework.

Some HBMC masters need calibration/training sequence[3] to be carried
out, in order for DLL inside the controller to lock, by reading a known
string/pattern. This is done by repeatedly reading CFI Query
Identification String. Calibration needs to be done before trying to detect
flash as part of CFI flash probe.

HyperRAM is not supported at the moment.

Hyperbus specification can be found at[1]
Hyperflash datasheet can be found at[2]

[1] https://www.cypress.com/file/213356/download
[2] https://www.cypress.com/file/213346/download
[3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
    Table 12-5741. HyperFlash Access Sequence

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 MAINTAINERS                          |   7 +
 drivers/mtd/Kconfig                  |   2 +
 drivers/mtd/Makefile                 |   1 +
 drivers/mtd/hyperbus/Kconfig         |  11 ++
 drivers/mtd/hyperbus/Makefile        |   3 +
 drivers/mtd/hyperbus/hyperbus-core.c | 183 +++++++++++++++++++++++++++
 include/linux/mtd/hyperbus.h         |  91 +++++++++++++
 7 files changed, 298 insertions(+)
 create mode 100644 drivers/mtd/hyperbus/Kconfig
 create mode 100644 drivers/mtd/hyperbus/Makefile
 create mode 100644 drivers/mtd/hyperbus/hyperbus-core.c
 create mode 100644 include/linux/mtd/hyperbus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 74e28172c637..48f1f227f65b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7188,6 +7188,13 @@ F:	include/uapi/linux/hyperv.h
 F:	tools/hv/
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 
+HYPERBUS SUPPORT
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+S:	Supported
+F:	drivers/mtd/hyperbus/
+F:	include/linux/mtd/hyperbus.h
+F:	Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
+
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 79a8ff542883..a915ff300390 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -290,4 +290,6 @@ source "drivers/mtd/spi-nor/Kconfig"
 
 source "drivers/mtd/ubi/Kconfig"
 
+source "drivers/mtd/hyperbus/Kconfig"
+
 endif # MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 58fc327a5276..04c154906631 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -35,3 +35,4 @@ obj-y		+= chips/ lpddr/ maps/ devices/ nand/ tests/
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor/
 obj-$(CONFIG_MTD_UBI)		+= ubi/
+obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus/
diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
new file mode 100644
index 000000000000..febbb4cdc25f
--- /dev/null
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -0,0 +1,11 @@
+menuconfig MTD_HYPERBUS
+	tristate "Hyperbus support"
+	select MTD_CFI
+	select MTD_MAP_BANK_WIDTH_2
+	select MTD_CFI_AMDSTD
+	select MTD_COMPLEX_MAPPINGS
+	help
+	  This is the framework for the Hyperbus which can be used by
+	  the Hyperbus Controller driver to communicate with
+	  Hyperflash. See Cypress Hyperbus specification for more
+	  details
diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
new file mode 100644
index 000000000000..ca61dedd730d
--- /dev/null
+++ b/drivers/mtd/hyperbus/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus-core.o
diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
new file mode 100644
index 000000000000..4c2876c367fc
--- /dev/null
+++ b/drivers/mtd/hyperbus/hyperbus-core.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+// Author: Vignesh Raghavendra <vigneshr@ti.com>
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/hyperbus.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/cfi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/types.h>
+
+#define HYPERBUS_CALIB_COUNT 25
+
+static struct hyperbus_device *map_to_hbdev(struct map_info *map)
+{
+	return container_of(map, struct hyperbus_device, map);
+}
+
+static map_word hyperbus_read16(struct map_info *map, unsigned long addr)
+{
+	struct hyperbus_device *hbdev = map_to_hbdev(map);
+	struct hyperbus_ctlr *ctlr = hbdev->ctlr;
+	map_word read_data;
+
+	read_data.x[0] = ctlr->ops->read16(hbdev, addr);
+
+	return read_data;
+}
+
+static void hyperbus_write16(struct map_info *map, map_word d,
+			     unsigned long addr)
+{
+	struct hyperbus_device *hbdev = map_to_hbdev(map);
+	struct hyperbus_ctlr *ctlr = hbdev->ctlr;
+
+	ctlr->ops->write16(hbdev, addr, d.x[0]);
+}
+
+static void hyperbus_copy_from(struct map_info *map, void *to,
+			       unsigned long from, ssize_t len)
+{
+	struct hyperbus_device *hbdev = map_to_hbdev(map);
+	struct hyperbus_ctlr *ctlr = hbdev->ctlr;
+
+	ctlr->ops->copy_from(hbdev, to, from, len);
+}
+
+static void hyperbus_copy_to(struct map_info *map, unsigned long to,
+			     const void *from, ssize_t len)
+{
+	struct hyperbus_device *hbdev = map_to_hbdev(map);
+	struct hyperbus_ctlr *ctlr = hbdev->ctlr;
+
+	ctlr->ops->copy_to(hbdev, to, from, len);
+}
+
+/* Default calibration routine for use by Hyperbus controller.
+ * Controller is calibrated by repeatedly reading known pattern ("QRY"
+ * string from CFI space)
+ * It is not enough to just ensure "QRY" string is read correctly, need
+ * to read mulitple times to ensure stability of the DLL lock.
+ */
+int hyperbus_calibrate(struct hyperbus_device *hbdev)
+{
+	struct map_info *map = &hbdev->map;
+	struct cfi_private cfi;
+	int count = HYPERBUS_CALIB_COUNT;
+	int ret;
+
+	cfi.interleave = 1;
+	cfi.device_type = CFI_DEVICETYPE_X16;
+	cfi_send_gen_cmd(0xF0, 0, 0, map, &cfi, cfi.device_type, NULL);
+	cfi_send_gen_cmd(0x98, 0x55, 0, map, &cfi, cfi.device_type, NULL);
+
+	while (count--)
+		cfi_qry_present(map, 0, &cfi);
+
+	ret = cfi_qry_present(map, 0, &cfi);
+	cfi_qry_mode_off(0, map, &cfi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperbus_calibrate);
+
+int hyperbus_register_device(struct hyperbus_device *hbdev)
+{
+	const struct hyperbus_ops *ops;
+	struct hyperbus_ctlr *ctlr;
+	struct device_node *np;
+	struct map_info *map;
+	struct resource res;
+	struct device *dev;
+	int ret;
+
+	if (!hbdev || !hbdev->np || !hbdev->ctlr || !hbdev->ctlr->dev) {
+		pr_err("hyperbus: please fill all the necessary fields!\n");
+		return -EINVAL;
+	}
+
+	np = hbdev->np;
+	ctlr = hbdev->ctlr;
+	if (!of_device_is_compatible(np, "cypress,hyperflash"))
+		return -ENODEV;
+
+	hbdev->memtype = HYPERFLASH;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -EINVAL;
+
+	dev = ctlr->dev;
+	map = &hbdev->map;
+	map->size = resource_size(&res);
+	map->virt = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(map->virt))
+		return PTR_ERR(map->virt);
+
+	map->name = dev_name(dev);
+	map->bankwidth = 2;
+
+	simple_map_init(map);
+	ops = ctlr->ops;
+	if (ops) {
+		if (ops->read16)
+			map->read = hyperbus_read16;
+		if (ops->write16)
+			map->write = hyperbus_write16;
+		if (ops->copy_to)
+			map->copy_to = hyperbus_copy_to;
+		if (ops->copy_from)
+			map->copy_from = hyperbus_copy_from;
+
+		if (ops->calibrate && !ctlr->calibrated) {
+			ret = ops->calibrate(hbdev);
+			if (!ret) {
+				dev_err(dev, "Calibration failed\n");
+				return -ENODEV;
+			}
+			ctlr->calibrated = true;
+		}
+	}
+
+	hbdev->mtd = do_map_probe("cfi_probe", map);
+	if (!hbdev->mtd) {
+		dev_err(dev, "probing of hyperbus device failed\n");
+		return -ENODEV;
+	}
+
+	hbdev->mtd->dev.parent = dev;
+	mtd_set_of_node(hbdev->mtd, np);
+
+	ret = mtd_device_register(hbdev->mtd, NULL, 0);
+	if (ret) {
+		dev_err(dev, "failed to register mtd device\n");
+		map_destroy(hbdev->mtd);
+		return ret;
+	}
+	hbdev->registered = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hyperbus_register_device);
+
+int hyperbus_unregister_device(struct hyperbus_device *hbdev)
+{
+	int ret = 0;
+
+	if (hbdev && hbdev->mtd && hbdev->registered) {
+		ret = mtd_device_unregister(hbdev->mtd);
+		map_destroy(hbdev->mtd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hyperbus_unregister_device);
+
+MODULE_DESCRIPTION("Hyperbus Framework");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
new file mode 100644
index 000000000000..57f273e87f29
--- /dev/null
+++ b/include/linux/mtd/hyperbus.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __LINUX_MTD_HYPERBUS_H__
+#define __LINUX_MTD_HYPERBUS_H__
+
+#include <linux/mtd/map.h>
+
+enum hyperbus_memtype {
+	HYPERFLASH,
+	HYPERRAM,
+};
+
+/**
+ * struct hyerbus_device - struct representing Hyperbus slave device
+ * @map: map_info struct for accessing MMIO Hyperbus flash memory
+ * @np:	pointer to Hyperbus slave device node
+ * @mtd: pointer to MTD struct
+ * @ctlr: pointer to Hyperbus controller struct
+ * @memtype: type of memory device: Hyperflash or HyperRAM
+ * @registered: flag to indicate whether device is registered with MTD core
+ */
+
+struct hyperbus_device {
+	struct map_info map;
+	struct device_node *np;
+	struct mtd_info *mtd;
+	struct hyperbus_ctlr *ctlr;
+	enum hyperbus_memtype memtype;
+	bool registered;
+};
+
+/**
+ * struct hyperbus_ops - struct representing custom Hyperbus operations
+ * @read16: read 16 bit of data, usually from register/ID-CFI space
+ * @write16: write 16 bit of data, usually to register/ID-CFI space
+ * @copy_from: copy data from flash memory
+ * @copy_to: copy data to flash memory
+ * @calibrate: calibrate Hyperbus controller
+ */
+
+struct hyperbus_ops {
+	u16 (*read16)(struct hyperbus_device *hbdev, unsigned long addr);
+	void (*write16)(struct hyperbus_device *hbdev,
+			unsigned long addr, u16 val);
+	void (*copy_from)(struct hyperbus_device *hbdev, void *to,
+			  unsigned long from, ssize_t len);
+	void (*copy_to)(struct hyperbus_device *dev, unsigned long to,
+			const void *from, ssize_t len);
+	int (*calibrate)(struct hyperbus_device *dev);
+};
+
+/**
+ * struct hyperbus_ctlr - struct representing Hyperbus controller
+ * @calibrated: flag to indicate ctlr calibration sequence is complete
+ * @ops: Hyperbus controller ops
+ */
+struct hyperbus_ctlr {
+	struct device *dev;
+	bool calibrated;
+
+	const struct hyperbus_ops *ops;
+};
+
+/**
+ * hyperbus_calibrate - default calibration routine for use by Hyperbus ctlr.
+ * @hbdev: hyperbus_device to be used for calibration
+ *
+ * Return: 0 for success, others for failure.
+ */
+int hyperbus_calibrate(struct hyperbus_device *hbdev);
+
+/**
+ * hyperbus_register_device - probe and register a Hyperbus slave memory device
+ * @hbdev: hyperbus_device struct with dev, np and ctlr field populated
+ *
+ * Return: 0 for success, others for failure.
+ */
+int hyperbus_register_device(struct hyperbus_device *hbdev);
+
+/**
+ * hb_unregister_device - deregister Hyperbus slave memory device
+ * @hbdev: hyperbus_device to be unregistered
+ *
+ * Return: 0 for success, others for failure.
+ */
+int hyperbus_unregister_device(struct hyperbus_device *hbdev);
+
+#endif /* __LINUX_MTD_HYPERBUS_H__ */
-- 
2.21.0

