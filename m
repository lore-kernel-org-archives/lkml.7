Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C1C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2732087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfECIrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:47:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:5532 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfECIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811548"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:28 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 06/22] intel_th: Communicate IRQ via resource
Date:   Fri,  3 May 2019 11:44:39 +0300
Message-Id: <20190503084455.23436-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IRQ is passed between the glue layers and the core as a
separate argument, while the MMIO resources are passed as resources.
This also limits the number of IRQs thus used to one, while the current
versions of Intel TH use a different MSI vector for each interrupt
triggering event, of which there are 7.

Change this to pass IRQ in the resources array.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/acpi.c     | 10 ++++------
 drivers/hwtracing/intel_th/core.c     | 23 ++++++++++++++++++-----
 drivers/hwtracing/intel_th/intel_th.h |  2 +-
 drivers/hwtracing/intel_th/pci.c      |  9 +++++++--
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/intel_th/acpi.c b/drivers/hwtracing/intel_th/acpi.c
index b528e5b113ff..87f9024e4bbb 100644
--- a/drivers/hwtracing/intel_th/acpi.c
+++ b/drivers/hwtracing/intel_th/acpi.c
@@ -40,20 +40,18 @@ static int intel_th_acpi_probe(struct platform_device *pdev)
 	struct resource resource[TH_MMIO_END];
 	const struct acpi_device_id *id;
 	struct intel_th *th;
-	int i, r, irq = -1;
+	int i, r;
 
 	id = acpi_match_device(intel_th_acpi_ids, &pdev->dev);
 	if (!id)
 		return -ENODEV;
 
 	for (i = 0, r = 0; i < pdev->num_resources && r < TH_MMIO_END; i++)
-		if (pdev->resource[i].flags & IORESOURCE_IRQ)
-			irq = pdev->resource[i].start;
-		else if (pdev->resource[i].flags & IORESOURCE_MEM)
+		if (pdev->resource[i].flags &
+		    (IORESOURCE_IRQ | IORESOURCE_MEM))
 			resource[r++] = pdev->resource[i];
 
-	th = intel_th_alloc(&pdev->dev, (void *)id->driver_data, resource, r,
-			    irq);
+	th = intel_th_alloc(&pdev->dev, (void *)id->driver_data, resource, r);
 	if (IS_ERR(th))
 		return PTR_ERR(th);
 
diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index a0b8b0182daa..0205fca4c606 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -834,10 +834,10 @@ static const struct file_operations intel_th_output_fops = {
  */
 struct intel_th *
 intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
-	       struct resource *devres, unsigned int ndevres, int irq)
+	       struct resource *devres, unsigned int ndevres)
 {
+	int err, r, nr_mmios = 0;
 	struct intel_th *th;
-	int err, r;
 
 	th = kzalloc(sizeof(*th), GFP_KERNEL);
 	if (!th)
@@ -855,13 +855,26 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 		err = th->major;
 		goto err_ida;
 	}
+	th->irq = -1;
 	th->dev = dev;
 	th->drvdata = drvdata;
 
 	for (r = 0; r < ndevres; r++)
-		th->resource[r] = devres[r];
-	th->num_resources = ndevres;
-	th->irq = irq;
+		switch (devres[r].flags & IORESOURCE_TYPE_BITS) {
+		case IORESOURCE_MEM:
+			th->resource[nr_mmios++] = devres[r];
+			break;
+		case IORESOURCE_IRQ:
+			if (th->irq == -1)
+				th->irq = devres[r].start;
+			break;
+		default:
+			dev_warn(dev, "Unknown resource type %lx\n",
+				 devres[r].flags);
+			break;
+		}
+
+	th->num_resources = nr_mmios;
 
 	dev_set_drvdata(dev, th);
 
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 3fca86d78fdd..6c6eb87e48a0 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -213,7 +213,7 @@ static inline struct intel_th *to_intel_th(struct intel_th_device *thdev)
 
 struct intel_th *
 intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
-	       struct resource *devres, unsigned int ndevres, int irq);
+	       struct resource *devres, unsigned int ndevres);
 void intel_th_free(struct intel_th *th);
 
 int intel_th_driver_register(struct intel_th_driver *thdrv);
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index fd8267bbaf2c..03d6894cd9c9 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -72,7 +72,7 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
 	struct intel_th_drvdata *drvdata = (void *)id->driver_data;
-	struct resource resource[TH_MMIO_END] = {
+	struct resource resource[TH_MMIO_END + 1] = {
 		[TH_MMIO_CONFIG]	= pdev->resource[TH_PCI_CONFIG_BAR],
 		[TH_MMIO_SW]		= pdev->resource[TH_PCI_STH_SW_BAR],
 	};
@@ -92,7 +92,12 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 		r++;
 	}
 
-	th = intel_th_alloc(&pdev->dev, drvdata, resource, r, pdev->irq);
+	if (pdev->irq > 0) {
+		resource[r].flags   = IORESOURCE_IRQ;
+		resource[r++].start = pdev->irq;
+	}
+
+	th = intel_th_alloc(&pdev->dev, drvdata, resource, r);
 	if (IS_ERR(th))
 		return PTR_ERR(th);
 
-- 
2.20.1

