Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8C324698
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLWORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:17:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:47069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLWORa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="219511761"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Dec 2019 06:17:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A028D167B; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 34/37] mfd: intel_pmc_bxt: Convert to use MFD APIs
Date:   Mon, 23 Dec 2019 17:17:13 +0300
Message-Id: <20191223141716.13727-35-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating platform devices manually we can take advantage of
MFD APIs that are designed exactly for this. Unfortunately the ACPI
device includes separate resources for most of the subdevices so we
cannot simply call mfd_add_devices() to create all of them but instead
we need to call it separately for each device.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mfd/Kconfig         |   1 +
 drivers/mfd/intel_pmc_bxt.c | 254 +++++++++++-------------------------
 2 files changed, 75 insertions(+), 180 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 93ab1b6a9733..04542feffe25 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -636,6 +636,7 @@ config MFD_INTEL_PMC_BXT
 	tristate "Intel PMC Driver for Broxton"
 	depends on X86 && X86_PLATFORM_DEVICES && ACPI
 	select INTEL_SCU_IPC
+	select MFD_CORE
 	help
 	  This driver provides support for PMC (Power Management
 	  Controller) on Intel Broxton and Apollo Lake. PMC is a
diff --git a/drivers/mfd/intel_pmc_bxt.c b/drivers/mfd/intel_pmc_bxt.c
index 8974fe46d6b5..850ed55deef0 100644
--- a/drivers/mfd/intel_pmc_bxt.c
+++ b/drivers/mfd/intel_pmc_bxt.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/intel_pmc_bxt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -62,8 +63,6 @@
 #define TELEM_SSRAM_SIZE		240
 #define TELEM_PMC_SSRAM_OFFSET		0x1B00
 #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
-#define TCO_PMC_OFFSET			0x08
-#define TCO_PMC_SIZE			0x04
 
 /* PMC register bit definitions */
 
@@ -75,27 +74,19 @@
 static struct intel_pmc_dev {
 	struct device *dev;
 
-	/* The following PMC BARs share the same ACPI device with the IPC */
-	resource_size_t acpi_io_base;
-	int acpi_io_size;
-	struct platform_device *tco_dev;
+	/* iTCO */
+	struct resource tco_res[2];
 
 	/* gcr */
 	void __iomem *gcr_mem_base;
-	bool has_gcr_regs;
 	spinlock_t gcr_lock;
 
 	/* punit */
-	struct platform_device *punit_dev;
+	struct resource punit_res[6];
 	unsigned int punit_res_count;
 
 	/* Telemetry */
-	resource_size_t telem_pmc_ssram_base;
-	resource_size_t telem_punit_ssram_base;
-	int telem_pmc_ssram_size;
-	int telem_punit_ssram_size;
-	u8 telem_res_inval;
-	struct platform_device *telemetry_dev;
+	struct resource *telem_base;
 } pmcdev;
 
 static inline u64 gcr_data_readq(u32 offset)
@@ -105,7 +96,7 @@ static inline u64 gcr_data_readq(u32 offset)
 
 static inline int is_gcr_valid(u32 offset)
 {
-	if (!pmcdev.has_gcr_regs)
+	if (!pmcdev.gcr_mem_base)
 		return -EACCES;
 
 	if (offset > PLAT_RESOURCE_GCR_SIZE)
@@ -254,141 +245,62 @@ static const struct attribute_group intel_pmc_group = {
 	.attrs = intel_pmc_attrs,
 };
 
-static struct resource punit_res_array[] = {
-	/* Punit BIOS */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit ISP */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit GTD */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-#define TCO_RESOURCE_ACPI_IO		0
-#define TCO_RESOURCE_SMI_EN_IO		1
-#define TCO_RESOURCE_GCR_MEM		2
-static struct resource tco_res[] = {
-	/* ACPI - TCO */
-	{
-		.flags = IORESOURCE_IO,
-	},
-	/* ACPI - SMI */
-	{
-		.flags = IORESOURCE_IO,
-	},
-};
-
-static struct itco_wdt_platform_data tco_info = {
-	.name = "Apollo Lake SoC",
-	.version = 5,
-	.no_reboot_priv = &pmcdev,
-	.update_no_reboot_bit = update_no_reboot_bit,
-};
-
-#define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
-#define TELEMETRY_RESOURCE_PMC_SSRAM	1
-static struct resource telemetry_res[] = {
-	/*Telemetry*/
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
 static int pmc_create_punit_device(void)
 {
-	struct platform_device *pdev;
-	const struct platform_device_info pdevinfo = {
-		.parent = pmcdev.dev,
+	struct mfd_cell punit = {
 		.name = PUNIT_DEVICE_NAME,
-		.id = -1,
-		.res = punit_res_array,
-		.num_res = pmcdev.punit_res_count,
-		};
+		.resources = pmcdev.punit_res,
+		.num_resources = pmcdev.punit_res_count,
+	};
 
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pmcdev.punit_res_count)
+		return 0;
 
-	pmcdev.punit_dev = pdev;
-
-	return 0;
+	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &punit, 1,
+				    NULL, 0, NULL);
 }
 
 static int pmc_create_tco_device(void)
 {
-	struct platform_device *pdev;
-	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = pmcdev.dev,
+	struct itco_wdt_platform_data tco_info = {
+		.name = "Apollo Lake SoC",
+		.version = 5,
+		.no_reboot_priv = &pmcdev,
+		.update_no_reboot_bit = update_no_reboot_bit,
+	};
+	struct mfd_cell tco = {
 		.name = TCO_DEVICE_NAME,
-		.id = -1,
-		.res = tco_res,
-		.num_res = ARRAY_SIZE(tco_res),
-		.data = &tco_info,
-		.size_data = sizeof(tco_info),
-		};
-
-	res = tco_res + TCO_RESOURCE_ACPI_IO;
-	res->start = pmcdev.acpi_io_base + TCO_BASE_OFFSET;
-	res->end = res->start + TCO_REGS_SIZE - 1;
-
-	res = tco_res + TCO_RESOURCE_SMI_EN_IO;
-	res->start = pmcdev.acpi_io_base + SMI_EN_OFFSET;
-	res->end = res->start + SMI_EN_SIZE - 1;
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	pmcdev.tco_dev = pdev;
-
-	return 0;
+		.ignore_resource_conflicts = true,
+		.platform_data = &tco_info,
+		.pdata_size = sizeof(tco_info),
+		.resources = pmcdev.tco_res,
+		.num_resources = ARRAY_SIZE(pmcdev.tco_res),
+	};
+
+	if (!pmcdev.tco_res[0].start)
+		return 0;
+
+	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &tco, 1,
+				    NULL, 0, NULL);
 }
 
 static int pmc_create_telemetry_device(void)
 {
-	struct platform_device *pdev;
-	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = pmcdev.dev,
+	struct resource telem_res[] = {
+		DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
+		DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
+	};
+	struct mfd_cell telem  = {
 		.name = TELEMETRY_DEVICE_NAME,
-		.id = -1,
-		.res = telemetry_res,
-		.num_res = ARRAY_SIZE(telemetry_res),
-		};
-
-	res = telemetry_res + TELEMETRY_RESOURCE_PUNIT_SSRAM;
-	res->start = pmcdev.telem_punit_ssram_base;
-	res->end = res->start + pmcdev.telem_punit_ssram_size - 1;
+		.resources = telem_res,
+		.num_resources = ARRAY_SIZE(telem_res),
+	};
 
-	res = telemetry_res + TELEMETRY_RESOURCE_PMC_SSRAM;
-	res->start = pmcdev.telem_pmc_ssram_base;
-	res->end = res->start + pmcdev.telem_pmc_ssram_size - 1;
+	if (!pmcdev.telem_base)
+		return 0;
 
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	pmcdev.telemetry_dev = pdev;
-
-	return 0;
+	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &telem, 1,
+				    pmcdev.telem_base, 0, NULL);
 }
 
 static int pmc_create_devices(void)
@@ -407,19 +319,12 @@ static int pmc_create_devices(void)
 	ret = pmc_create_punit_device();
 	if (ret) {
 		dev_err(pmcdev.dev, "Failed to add punit platform device\n");
-		platform_device_unregister(pmcdev.tco_dev);
 		return ret;
 	}
 
-	if (!pmcdev.telem_res_inval) {
-		ret = pmc_create_telemetry_device();
-		if (ret) {
-			dev_warn(pmcdev.dev,
-				"Failed to add telemetry platform device\n");
-			platform_device_unregister(pmcdev.punit_dev);
-			platform_device_unregister(pmcdev.tco_dev);
-		}
-	}
+	ret = pmc_create_telemetry_device();
+	if (ret)
+		dev_warn(pmcdev.dev, "Failed to add telemetry platform device\n");
 
 	return ret;
 }
@@ -427,20 +332,25 @@ static int pmc_create_devices(void)
 static int pmc_plat_get_res(struct platform_device *pdev,
 			    struct intel_scu_ipc_pdata *pdata)
 {
-	struct resource *res, *punit_res = punit_res_array;
+	struct resource *res, *punit_res = pmcdev.punit_res;
+	struct resource *tco_res = pmcdev.tco_res;
 	void __iomem *addr;
 	int size;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO,
 				    PLAT_RESOURCE_ACPI_IO_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get io resource\n");
+		dev_err(&pdev->dev, "Failed to get IO resource\n");
 		return -ENXIO;
+
 	}
-	size = resource_size(res);
-	pmcdev.acpi_io_base = res->start;
-	pmcdev.acpi_io_size = size;
-	dev_info(&pdev->dev, "io res: %pR\n", res);
+	tco_res[0].flags = IORESOURCE_IO;
+	tco_res[0].start = res->start + TCO_BASE_OFFSET;
+	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
+	tco_res[1].flags = IORESOURCE_IO;
+	tco_res[1].start = res->start + SMI_EN_OFFSET;
+	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
+	dev_dbg(&pdev->dev, "IO: %pR\n", res);
 
 	pmcdev.punit_res_count = 0;
 
@@ -448,28 +358,28 @@ static int pmc_plat_get_res(struct platform_device *pdev,
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_BIOS_DATA_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
+		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS data\n");
 		return -ENXIO;
 	}
 	punit_res[pmcdev.punit_res_count++] = *res;
-	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
+	dev_dbg(&pdev->dev, "P-unit BIOS data: %pR\n", res);
 
 	/* This is index 1 to cover BIOS interface register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
+		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS iface\n");
 		return -ENXIO;
 	}
 	punit_res[pmcdev.punit_res_count++] = *res;
-	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
+	dev_dbg(&pdev->dev, "P-unit BIOS interface: %pR\n", res);
 
 	/* This is index 2 to cover ISP data register, optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_ISP_DATA_INDEX);
 	if (res) {
 		punit_res[pmcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
+		dev_dbg(&pdev->dev, "P-unit ISP data: %pR\n", res);
 	}
 
 	/* This is index 3 to cover ISP interface register, optional */
@@ -477,7 +387,7 @@ static int pmc_plat_get_res(struct platform_device *pdev,
 				    PLAT_RESOURCE_ISP_IFACE_INDEX);
 	if (res) {
 		punit_res[pmcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
+		dev_dbg(&pdev->dev, "P-unit ISP interface: %pR\n", res);
 	}
 
 	/* This is index 4 to cover GTD data register, optional */
@@ -485,7 +395,7 @@ static int pmc_plat_get_res(struct platform_device *pdev,
 				    PLAT_RESOURCE_GTD_DATA_INDEX);
 	if (res) {
 		punit_res[pmcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
+		dev_dbg(&pdev->dev, "P-unit GTD data: %pR\n", res);
 	}
 
 	/* This is index 5 to cover GTD interface register, optional */
@@ -493,13 +403,13 @@ static int pmc_plat_get_res(struct platform_device *pdev,
 				    PLAT_RESOURCE_GTD_IFACE_INDEX);
 	if (res) {
 		punit_res[pmcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
+		dev_dbg(&pdev->dev, "P-unit GTD interface: %pR\n", res);
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_IPC_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get ipc resource\n");
+		dev_err(&pdev->dev, "Failed to get IPC resource\n");
 		return -ENXIO;
 	}
 	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
@@ -512,22 +422,15 @@ static int pmc_plat_get_res(struct platform_device *pdev,
 	pdata->ipc_regs = addr;
 
 	pmcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	dev_info(&pdev->dev, "ipc res: %pR\n", res);
+	dev_dbg(&pdev->dev, "IPC: %pR\n", res);
 
-	pmcdev.telem_res_inval = 0;
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get telemetry ssram resource\n");
-		pmcdev.telem_res_inval = 1;
+		dev_err(&pdev->dev, "Failed to get telemetry SSRAM resource\n");
 	} else {
-		pmcdev.telem_punit_ssram_base = res->start +
-						TELEM_PUNIT_SSRAM_OFFSET;
-		pmcdev.telem_punit_ssram_size = TELEM_SSRAM_SIZE;
-		pmcdev.telem_pmc_ssram_base = res->start +
-						TELEM_PMC_SSRAM_OFFSET;
-		pmcdev.telem_pmc_ssram_size = TELEM_SSRAM_SIZE;
-		dev_info(&pdev->dev, "telemetry ssram res: %pR\n", res);
+		dev_dbg(&pdev->dev, "Telemetry SSRAM: %pR\n", res);
+		pmcdev.telem_base = res;
 	}
 
 	return 0;
@@ -543,7 +446,7 @@ int intel_pmc_s0ix_counter_read(u64 *data)
 {
 	u64 deep, shlw;
 
-	if (!pmcdev.has_gcr_regs)
+	if (!pmcdev.gcr_mem_base)
 		return -EACCES;
 
 	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
@@ -597,19 +500,13 @@ static int intel_pmc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
 			ret);
-		goto err_devs;
+		goto err_ipc;
 	}
 
-	pmcdev.has_gcr_regs = true;
-
 	return 0;
 
 err_ipc:
 	intel_scu_ipc_remove(scu);
-err_devs:
-	platform_device_unregister(pmcdev.tco_dev);
-	platform_device_unregister(pmcdev.punit_dev);
-	platform_device_unregister(pmcdev.telemetry_dev);
 
 	return ret;
 }
@@ -617,9 +514,6 @@ static int intel_pmc_probe(struct platform_device *pdev)
 static int intel_pmc_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &intel_pmc_group);
-	platform_device_unregister(pmcdev.tco_dev);
-	platform_device_unregister(pmcdev.punit_dev);
-	platform_device_unregister(pmcdev.telemetry_dev);
 	intel_scu_ipc_remove(platform_get_drvdata(pdev));
 	pmcdev.dev = NULL;
 	return 0;
-- 
2.24.0

