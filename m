Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD811C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B493520880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDILZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:25:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:5538 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfDILZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:25:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 04:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="141230473"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Apr 2019 04:25:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D50E82C2; Tue,  9 Apr 2019 14:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        junxiao.chang@intel.com, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] platform/x86: intel_pmc_ipc: Don't map non-used optional resources
Date:   Tue,  9 Apr 2019 14:25:14 +0300
Message-Id: <20190409112515.84725-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_pmc_ipc driver has a placeholder for all possible resources
that may have been provided by ACPI. Since there are few optional ones,
the driver still uses them and binds to wrong ranges in resource tree:

  # grep intel_punit_ipc /proc/iomem
  00000000-00000000 : intel_punit_ipc
    00000000-00000000 : intel_punit_ipc
      00000000-00000000 : intel_punit_ipc
        00000000-00000000 : intel_punit_ipc

This leads to issues with resource management during inserting and
removing modules, such as intel_pmc_ipc itself, which can't be inserted
anymore after first removal.

Count the actual resources provided and supply only them to the child device.

This is a real fix of the commit 8cc7fb4a6523

  ("intel_pmc_ipc: update acpi resource structure for Punit")

that also fixes a symptoms described in the commit 6cc8cbbc8868

  ("platform/x86: intel_punit_ipc: Fix resource ioremap warning")

that is going to be reverted afterwards.

Reported-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 9007aa717586..55037ff258f8 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -131,6 +131,7 @@ static struct intel_pmc_ipc_dev {
 
 	/* punit */
 	struct platform_device *punit_dev;
+	unsigned int punit_res_count;
 
 	/* Telemetry */
 	resource_size_t telem_pmc_ssram_base;
@@ -682,7 +683,7 @@ static int ipc_create_punit_device(void)
 		.name = PUNIT_DEVICE_NAME,
 		.id = -1,
 		.res = punit_res_array,
-		.num_res = ARRAY_SIZE(punit_res_array),
+		.num_res = ipcdev.punit_res_count,
 		};
 
 	pdev = platform_device_register_full(&pdevinfo);
@@ -789,7 +790,7 @@ static int ipc_create_pmc_devices(void)
 
 static int ipc_plat_get_res(struct platform_device *pdev)
 {
-	struct resource *res, *punit_res;
+	struct resource *res, *punit_res = punit_res_array;
 	void __iomem *addr;
 	int size;
 
@@ -804,7 +805,8 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	ipcdev.acpi_io_size = size;
 	dev_info(&pdev->dev, "io res: %pR\n", res);
 
-	punit_res = punit_res_array;
+	ipcdev.punit_res_count = 0;
+
 	/* This is index 0 to cover BIOS data register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_BIOS_DATA_INDEX);
@@ -812,7 +814,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
 		return -ENXIO;
 	}
-	*punit_res = *res;
+	punit_res[ipcdev.punit_res_count++] = *res;
 	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
 
 	/* This is index 1 to cover BIOS interface register */
@@ -822,42 +824,38 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
 		return -ENXIO;
 	}
-	*++punit_res = *res;
+	punit_res[ipcdev.punit_res_count++] = *res;
 	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
 
 	/* This is index 2 to cover ISP data register, optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_ISP_DATA_INDEX);
-	++punit_res;
 	if (res) {
-		*punit_res = *res;
+		punit_res[ipcdev.punit_res_count++] = *res;
 		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
 	}
 
 	/* This is index 3 to cover ISP interface register, optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_ISP_IFACE_INDEX);
-	++punit_res;
 	if (res) {
-		*punit_res = *res;
+		punit_res[ipcdev.punit_res_count++] = *res;
 		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
 	}
 
 	/* This is index 4 to cover GTD data register, optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_GTD_DATA_INDEX);
-	++punit_res;
 	if (res) {
-		*punit_res = *res;
+		punit_res[ipcdev.punit_res_count++] = *res;
 		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
 	}
 
 	/* This is index 5 to cover GTD interface register, optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM,
 				    PLAT_RESOURCE_GTD_IFACE_INDEX);
-	++punit_res;
 	if (res) {
-		*punit_res = *res;
+		punit_res[ipcdev.punit_res_count++] = *res;
 		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
 	}
 
-- 
2.20.1

