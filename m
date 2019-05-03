Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A82C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD92081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfECIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:5530 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfECIp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811545"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:27 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 05/22] intel_th: Add "rtit" source device
Date:   Fri,  3 May 2019 11:44:38 +0300
Message-Id: <20190503084455.23436-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some versions of Intel TH, the Software Trace Hub (STH) has a second
MMIO BAR dedicated to the input from Intel PT. This calls for a new
subdevice that will be enumerated if the corresponding BAR is present.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 18 ++++++++++++++++++
 drivers/hwtracing/intel_th/intel_th.h |  1 +
 drivers/hwtracing/intel_th/pci.c      | 11 ++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 8c221e1ed12d..a0b8b0182daa 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -500,6 +500,24 @@ static const struct intel_th_subdevice {
 		.name	= "sth",
 		.type	= INTEL_TH_SOURCE,
 	},
+	{
+		.nres	= 2,
+		.res	= {
+			{
+				.start	= REG_STH_OFFSET,
+				.end	= REG_STH_OFFSET + REG_STH_LENGTH - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= TH_MMIO_RTIT,
+				.end	= 0,
+				.flags	= IORESOURCE_MEM,
+			},
+		},
+		.id	= -1,
+		.name	= "rtit",
+		.type	= INTEL_TH_SOURCE,
+	},
 	{
 		.nres	= 1,
 		.res	= {
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 8c90c8d01867..3fca86d78fdd 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -228,6 +228,7 @@ int intel_th_output_enable(struct intel_th *th, unsigned int otype);
 enum th_mmio_idx {
 	TH_MMIO_CONFIG = 0,
 	TH_MMIO_SW = 1,
+	TH_MMIO_RTIT = 2,
 	TH_MMIO_END,
 };
 
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 9dd2d75bd539..fd8267bbaf2c 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -20,6 +20,7 @@
 enum {
 	TH_PCI_CONFIG_BAR	= 0,
 	TH_PCI_STH_SW_BAR	= 2,
+	TH_PCI_RTIT_BAR		= 4,
 };
 
 #define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
@@ -75,8 +76,8 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 		[TH_MMIO_CONFIG]	= pdev->resource[TH_PCI_CONFIG_BAR],
 		[TH_MMIO_SW]		= pdev->resource[TH_PCI_STH_SW_BAR],
 	};
+	int err, r = TH_MMIO_SW + 1;
 	struct intel_th *th;
-	int err;
 
 	err = pcim_enable_device(pdev);
 	if (err)
@@ -86,8 +87,12 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	th = intel_th_alloc(&pdev->dev, drvdata, resource, TH_MMIO_END,
-			    pdev->irq);
+	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
+		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
+		r++;
+	}
+
+	th = intel_th_alloc(&pdev->dev, drvdata, resource, r, pdev->irq);
 	if (IS_ERR(th))
 		return PTR_ERR(th);
 
-- 
2.20.1

