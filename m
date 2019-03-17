Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D092C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DE120896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us7PAIbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCQUAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33313 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfCQUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:00:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so14775006wrm.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMO+4eUPKINZ4/8FY5IHI8GcteSGNIHkDKAIsP9H5yU=;
        b=us7PAIbAcrHixczjIH572uKOxzfkSD8mz/9VoShPkEqzKA2ibiC2a/CU+HAfNJsiQh
         TLOa0GzQ7B7682U7gwMPFjg+dx+Z5+KbNDv8mwzym77HBhYsfqztRQfLU6DBI313zLcm
         duedMAI/vj4rBu+pODYlvHKHMHzkV8BoV85inj2SOiP8849h6sC1DNF8I6ZeywBGwH0s
         zVzmk3r8Uqi0E8Awl0ydFZHpYpG/VddwCks3TjYaFW2urbRZXecg8L0klINvx5FMq2iK
         cMXWH23BwTOB/uqrHQA704g4/9Kj21y+fSRhd6zWJMvmCQ3SNCw4cT/SYRTgLQ0wY9Es
         G8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMO+4eUPKINZ4/8FY5IHI8GcteSGNIHkDKAIsP9H5yU=;
        b=j68oatSRj3RnwEslpV4U5iMIn6P8Fg1uq2TWn9XubvvzERYqDw2Ld8i/sG5yYqs+58
         225yV8VU3yPW6UYilX96B6CdKfxEZaAD0qMgTBXjxmPxfKUsD/sqHYLae13uaGxiZVRe
         H7rT9xh50qKVBJ/Wrbe6ctKy/UOuBIrWEjJCjpcPcH7/XX6WL0LW/uDuvZJKdYG54rcr
         1tF6t65Mmlu9PA94LUb36JSsoSKdvzbdyILvr6mzBlh/yJN/Wmff9B3JU9DDB4xVcHj9
         e+T8Npq+wZ4hSB5iUP4gzzVCI4fEfYFvsGfQ8T3EM8iFsGW2Cj3s3OwfUS23zSo8dau/
         0vuw==
X-Gm-Message-State: APjAAAV5pRS2WkFQ23V8IY/kc8AiY0EPBzMTbZGcWCPh7zr2dcX47hTa
        3Tpr8SwaO/WFA10QwZjqZ3e63wGI
X-Google-Smtp-Source: APXvYqw0bTqa6JnQscMCDBRFwfiUa/ibtV+LZursEONlx68y3mWpIH1EYbBspN4M/a2ukZ2C/i4cPA==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr9292224wrj.325.1552852798861;
        Sun, 17 Mar 2019 12:59:58 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:57 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 14/15] habanalabs: keep track of the device's dma mask
Date:   Sun, 17 Mar 2019 21:59:26 +0200
Message-Id: <20190317195927.26238-15-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the code that is responsible to set the DMA mask for
the device.

Upon each change of the dma mask, the driver will save the new value that
was set. This is needed in order to make sure we don't try to increase the
mask a second time, in case we failed in the first time. This is
especially relevant for Power machines, as that may cause a change in
configuration of the TVT which will break the device.

Goya will first try to set the device's dma mask to 39 bits, so that the
memory that is allocated on the host machine for communication with the
device's cpu will be in a bus address which is lower then 39 bits. Later,
Goya will try to increase that mask to 48 bits, but only if setting the
mask to 39 bits was successful.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c      | 32 ++++--------
 drivers/misc/habanalabs/habanalabs.h     |  5 +-
 drivers/misc/habanalabs/habanalabs_drv.c |  3 ++
 drivers/misc/habanalabs/pci.c            | 64 ++++++++++++++++++------
 4 files changed, 65 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b474651db0e5..a4bb963e33fa 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -483,7 +483,7 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev);
+	rc = hl_pci_init(hdev, 39);
 	if (rc)
 		return rc;
 
@@ -2446,28 +2446,16 @@ static int goya_hw_init(struct hl_device *hdev)
 		goto disable_msix;
 	}
 
-	/* CPU initialization is finished, we can now move to 48 bit DMA mask */
-	rc = pci_set_dma_mask(hdev->pdev, DMA_BIT_MASK(48));
-	if (rc) {
-		dev_warn(hdev->dev, "Unable to set pci dma mask to 48 bits\n");
-		rc = pci_set_dma_mask(hdev->pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Unable to set pci dma mask to 32 bits\n");
-			goto disable_pci_access;
-		}
-	}
-
-	rc = pci_set_consistent_dma_mask(hdev->pdev, DMA_BIT_MASK(48));
-	if (rc) {
-		dev_warn(hdev->dev,
-			"Unable to set pci consistent dma mask to 48 bits\n");
-		rc = pci_set_consistent_dma_mask(hdev->pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Unable to set pci consistent dma mask to 32 bits\n");
+	/*
+	 * Check if we managed to set the DMA mask to more then 32 bits. If so,
+	 * let's try to increase it again because in Goya we set the initial
+	 * dma mask to less then 39 bits so that the allocation of the memory
+	 * area for the device's cpu will be under 39 bits
+	 */
+	if (hdev->dma_mask > 32) {
+		rc = hl_pci_set_dma_mask(hdev, 48);
+		if (rc)
 			goto disable_pci_access;
-		}
 	}
 
 	/* Perform read from the device to flush all MSI-X configuration */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6991a7f260e8..e9253d937bfc 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1106,6 +1106,7 @@ struct hl_device_reset_work {
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
+ * @dma_mask: the dma mask that was set for this device
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1176,6 +1177,7 @@ struct hl_device {
 	u8				dram_default_page_mapping;
 	u8				init_done;
 	u8				device_cpu_disabled;
+	u8				dma_mask;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
@@ -1397,8 +1399,9 @@ int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
 				u64 addr);
 int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 			u64 dram_base_address, u64 host_phys_size);
-int hl_pci_init(struct hl_device *hdev);
+int hl_pci_init(struct hl_device *hdev, u8 dma_mask);
 void hl_pci_fini(struct hl_device *hdev);
+int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 748601463f11..b697339d3904 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -229,6 +229,9 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		hdev->asic_type = asic_type;
 	}
 
+	/* Set default DMA mask to 32 bits */
+	hdev->dma_mask = 32;
+
 	mutex_lock(&hl_devs_idr_lock);
 
 	if (minor == -1) {
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 822ac110b997..d472d02a8e6e 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -287,42 +287,74 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 }
 
 /**
- * hl_pci_init() - PCI initialization code.
+ * hl_pci_set_dma_mask() - Set DMA masks for the device.
  * @hdev: Pointer to hl_device structure.
+ * @dma_mask: number of bits for the requested dma mask.
  *
- * Set DMA masks, initialize the PCI controller and map the PCI BARs.
+ * This function sets the DMA masks (regular and consistent) for a specified
+ * value. If it doesn't succeed, it tries to set it to a fall-back value
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_pci_init(struct hl_device *hdev)
+int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
 
 	/* set DMA mask */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(39));
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
 	if (rc) {
-		dev_warn(hdev->dev, "Unable to set pci dma mask to 39 bits\n");
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		dev_warn(hdev->dev,
+			"Failed to set pci dma mask to %d bits, error %d\n",
+			dma_mask, rc);
+
+		dma_mask = hdev->dma_mask;
+
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
 		if (rc) {
 			dev_err(hdev->dev,
-				"Unable to set pci dma mask to 32 bits\n");
+				"Failed to set pci dma mask to %d bits, error %d\n",
+				dma_mask, rc);
 			return rc;
 		}
 	}
 
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(39));
+	/*
+	 * We managed to set the dma mask, so update the dma mask field. If
+	 * the set to the coherent mask will fail with that mask, we will
+	 * fail the entire function
+	 */
+	hdev->dma_mask = dma_mask;
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
 	if (rc) {
-		dev_warn(hdev->dev,
-			"Unable to set pci consistent dma mask to 39 bits\n");
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Unable to set pci consistent dma mask to 32 bits\n");
-			return rc;
-		}
+		dev_err(hdev->dev,
+			"Failed to set pci consistent dma mask to %d bits, error %d\n",
+			dma_mask, rc);
+		return rc;
 	}
 
+	return 0;
+}
+
+/**
+ * hl_pci_init() - PCI initialization code.
+ * @hdev: Pointer to hl_device structure.
+ * @dma_mask: number of bits for the requested dma mask.
+ *
+ * Set DMA masks, initialize the PCI controller and map the PCI BARs.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+int hl_pci_init(struct hl_device *hdev, u8 dma_mask)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int rc;
+
+	rc = hl_pci_set_dma_mask(hdev, dma_mask);
+	if (rc)
+		return rc;
+
 	if (hdev->reset_pcilink)
 		hl_pci_reset_link_through_bridge(hdev);
 
-- 
2.17.1

