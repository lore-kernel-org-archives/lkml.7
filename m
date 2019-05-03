Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5AAC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E012081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfECIpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:5535 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfECIpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811552"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:30 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 07/22] intel_th: pci: Use MSI interrupt signalling
Date:   Fri,  3 May 2019 11:44:40 +0300
Message-Id: <20190503084455.23436-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Intel TH is capable of MSI interrupt signalling, make use of it.
The way it works is, each of the 7 interrupt triggering events has its
own vector in this mode, as opposed to interrupt line delivery, where
all events are signalled via the same line. Failing to enable MSI, the
driver falls back to using an interrupt line.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/intel_th.h |  3 +++
 drivers/hwtracing/intel_th/pci.c      | 16 ++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 6c6eb87e48a0..db3ad8ca1c48 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -238,6 +238,9 @@ enum th_mmio_idx {
 #define TH_CONFIGURABLE_MASTERS 256
 #define TH_MSC_MAX		2
 
+/* Maximum IRQ vectors */
+#define TH_NVEC_MAX		8
+
 /**
  * struct intel_th - Intel TH controller
  * @dev:	driver core's device
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 03d6894cd9c9..f5643444481b 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -72,11 +72,11 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
 	struct intel_th_drvdata *drvdata = (void *)id->driver_data;
-	struct resource resource[TH_MMIO_END + 1] = {
+	struct resource resource[TH_MMIO_END + TH_NVEC_MAX] = {
 		[TH_MMIO_CONFIG]	= pdev->resource[TH_PCI_CONFIG_BAR],
 		[TH_MMIO_SW]		= pdev->resource[TH_PCI_STH_SW_BAR],
 	};
-	int err, r = TH_MMIO_SW + 1;
+	int err, r = TH_MMIO_SW + 1, i;
 	struct intel_th *th;
 
 	err = pcim_enable_device(pdev);
@@ -92,10 +92,12 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 		r++;
 	}
 
-	if (pdev->irq > 0) {
-		resource[r].flags   = IORESOURCE_IRQ;
-		resource[r++].start = pdev->irq;
-	}
+	err = pci_alloc_irq_vectors(pdev, 1, 8, PCI_IRQ_ALL_TYPES);
+	if (err > 0)
+		for (i = 0; i < err; i++, r++) {
+			resource[r].flags = IORESOURCE_IRQ;
+			resource[r].start = pci_irq_vector(pdev, i);
+		}
 
 	th = intel_th_alloc(&pdev->dev, drvdata, resource, r);
 	if (IS_ERR(th))
@@ -114,6 +116,8 @@ static void intel_th_pci_remove(struct pci_dev *pdev)
 	struct intel_th *th = pci_get_drvdata(pdev);
 
 	intel_th_free(th);
+
+	pci_free_irq_vectors(pdev);
 }
 
 static const struct intel_th_drvdata intel_th_2x = {
-- 
2.20.1

