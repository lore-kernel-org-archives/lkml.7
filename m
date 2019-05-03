Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D51C004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A2C2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfECIrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:47:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:5527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfECIpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811533"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 03/22] intel_th: Rework resource passing between glue layers and core
Date:   Fri,  3 May 2019 11:44:36 +0300
Message-Id: <20190503084455.23436-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, MMIO resource numbers in the TH driver core correspond to
PCI BAR numbers, because in the beginning there was only the PCI glue
layer. This created some confusion when the ACPI glue layer was added.

To avoid confusion and remove glue-specific code from the driver core,
split the resource indices between core and glue layers and change the
API so that the driver core receives the MMIO resources in the same
fixed order. At the same time, make the IRQ always be a parameter to
intel_th_alloc() instead of sometimes passing it as a resource.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/acpi.c     | 12 ++++++++++--
 drivers/hwtracing/intel_th/core.c     | 27 +++++++--------------------
 drivers/hwtracing/intel_th/intel_th.h |  8 ++++----
 drivers/hwtracing/intel_th/pci.c      | 15 ++++++++++++---
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
index 87bc3744755f..b528e5b113ff 100644
--- a/drivers/hwtracing/intel_th/acpi.c
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -37,15 +37,23 @@ MODULE_DEVICE_TABLE(acpi, intel_th_acpi_ids);
 static int intel_th_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct resource resource[TH_MMIO_END];
 	const struct acpi_device_id *id;
 	struct intel_th *th;
+	int i, r, irq = -1;
 
 	id = acpi_match_device(intel_th_acpi_ids, &pdev->dev);
 	if (!id)
 		return -ENODEV;
 
-	th = intel_th_alloc(&pdev->dev, (void *)id->driver_data,
-			    pdev->resource, pdev->num_resources, -1);
+	for (i = 0, r = 0; i < pdev->num_resources && r < TH_MMIO_END; i++)
+		if (pdev->resource[i].flags & IORESOURCE_IRQ)
+			irq = pdev->resource[i].start;
+		else if (pdev->resource[i].flags & IORESOURCE_MEM)
+			resource[r++] = pdev->resource[i];
+
+	th = intel_th_alloc(&pdev->dev, (void *)id->driver_data, resource, r,
+			    irq);
 	if (IS_ERR(th))
 		return PTR_ERR(th);
 
diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7c1acc2f801c..c577b94ee606 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -491,7 +491,7 @@ static const struct intel_th_subdevice {
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.start	= 1, /* use resource[1] */
+				.start	= TH_MMIO_SW,
 				.end	= 0,
 				.flags	= IORESOURCE_MEM,
 			},
@@ -584,7 +584,6 @@ intel_th_subdevice_alloc(struct intel_th *th,
 	struct intel_th_device *thdev;
 	struct resource res[3];
 	unsigned int req = 0;
-	bool is64bit = false;
 	int r, err;
 
 	thdev = intel_th_device_alloc(th, subdev->type, subdev->name,
@@ -594,18 +593,12 @@ intel_th_subdevice_alloc(struct intel_th *th,
 
 	thdev->drvdata = th->drvdata;
 
-	for (r = 0; r < th->num_resources; r++)
-		if (th->resource[r].flags & IORESOURCE_MEM_64) {
-			is64bit = true;
-			break;
-		}
-
 	memcpy(res, subdev->res,
 	       sizeof(struct resource) * subdev->nres);
 
 	for (r = 0; r < subdev->nres; r++) {
 		struct resource *devres = th->resource;
-		int bar = 0; /* cut subdevices' MMIO from resource[0] */
+		int bar = TH_MMIO_CONFIG;
 
 		/*
 		 * Take .end == 0 to mean 'take the whole bar',
@@ -614,8 +607,6 @@ intel_th_subdevice_alloc(struct intel_th *th,
 		 */
 		if (!res[r].end && res[r].flags == IORESOURCE_MEM) {
 			bar = res[r].start;
-			if (is64bit)
-				bar *= 2;
 			res[r].start = 0;
 			res[r].end = resource_size(&devres[bar]) - 1;
 		}
@@ -812,8 +803,7 @@ static const struct file_operations intel_th_output_fops = {
 /**
  * intel_th_alloc() - allocate a new Intel TH device and its subdevices
  * @dev:	parent device
- * @devres:	parent's resources
- * @ndevres:	number of resources
+ * @devres:	resources indexed by th_mmio_idx
  * @irq:	irq number
  */
 struct intel_th *
@@ -823,12 +813,8 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 	struct intel_th *th;
 	int err, r;
 
-	if (irq == -1)
-		for (r = 0; r < ndevres; r++)
-			if (devres[r].flags & IORESOURCE_IRQ) {
-				irq = devres[r].start;
-				break;
-			}
+	if (ndevres < TH_MMIO_END)
+		return ERR_PTR(-EINVAL);
 
 	th = kzalloc(sizeof(*th), GFP_KERNEL);
 	if (!th)
@@ -849,7 +835,8 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 	th->dev = dev;
 	th->drvdata = drvdata;
 
-	th->resource = devres;
+	for (r = 0; r < ndevres; r++)
+		th->resource[r] = devres[r];
 	th->num_resources = ndevres;
 	th->irq = irq;
 
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 780206dc9012..8c90c8d01867 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -225,9 +225,9 @@ int intel_th_set_output(struct intel_th_device *thdev,
 			unsigned int master);
 int intel_th_output_enable(struct intel_th *th, unsigned int otype);
 
-enum {
+enum th_mmio_idx {
 	TH_MMIO_CONFIG = 0,
-	TH_MMIO_SW = 2,
+	TH_MMIO_SW = 1,
 	TH_MMIO_END,
 };
 
@@ -244,7 +244,7 @@ enum {
  * @hub:	"switch" subdevice (GTH)
  * @resource:	resources of the entire controller
  * @num_thdevs:	number of devices in the @thdev array
- * @num_resources:	number or resources in the @resource array
+ * @num_resources:	number of resources in the @resource array
  * @irq:	irq number
  * @id:		this Intel TH controller's device ID in the system
  * @major:	device node major for output devices
@@ -256,7 +256,7 @@ struct intel_th {
 	struct intel_th_device	*hub;
 	struct intel_th_drvdata	*drvdata;
 
-	struct resource		*resource;
+	struct resource		resource[TH_MMIO_END];
 	int			(*activate)(struct intel_th *);
 	void			(*deactivate)(struct intel_th *);
 	unsigned int		num_thdevs;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 1cf6290d6435..9dd2d75bd539 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -17,7 +17,12 @@
 
 #define DRIVER_NAME "intel_th_pci"
 
-#define BAR_MASK (BIT(TH_MMIO_CONFIG) | BIT(TH_MMIO_SW))
+enum {
+	TH_PCI_CONFIG_BAR	= 0,
+	TH_PCI_STH_SW_BAR	= 2,
+};
+
+#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -66,6 +71,10 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
 	struct intel_th_drvdata *drvdata = (void *)id->driver_data;
+	struct resource resource[TH_MMIO_END] = {
+		[TH_MMIO_CONFIG]	= pdev->resource[TH_PCI_CONFIG_BAR],
+		[TH_MMIO_SW]		= pdev->resource[TH_PCI_STH_SW_BAR],
+	};
 	struct intel_th *th;
 	int err;
 
@@ -77,8 +86,8 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	th = intel_th_alloc(&pdev->dev, drvdata, pdev->resource,
-			    DEVICE_COUNT_RESOURCE, pdev->irq);
+	th = intel_th_alloc(&pdev->dev, drvdata, resource, TH_MMIO_END,
+			    pdev->irq);
 	if (IS_ERR(th))
 		return PTR_ERR(th);
 
-- 
2.20.1

