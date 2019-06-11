Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A4C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F51D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxSY1gVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404941AbfFKJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:21:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404180AbfFKJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:21:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so12120003wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=REo5vlaA8OSjWwpP5owVeB6nUwOl3VvQIkXRp78ncgE=;
        b=NxSY1gVDBPSMYwX2+LQNmgc0ZF/fTExu4HTYGxw2FbsH6aJlPH0tWnXwMqK1Bwnccx
         43fmx0Tfh8h3k/Un/Kos4vPWHlgAm5QvwDfjjBaPR50d7JWF3L+W3gqZEtzwQM5YofuX
         BHUm+J5xr2TZTpq1ZC7IUMJgXuXnuSe+tWU+Z5Aop9hCdmdAKTWaQ7PCdAKg7GmV4xtw
         q14IAW6b2MWt8iz4za2cxzoGc6Q7mj95+ZYhtxpjCOQMabxP8UIAAoQ+Ej1ntrGg7rnc
         6vsHBFcmoqtyI/YK9c0SDbmRR/mcYaq5lmCUYrm0+oTGqSLICNwXZxTQwgKFgIohOp2B
         jdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=REo5vlaA8OSjWwpP5owVeB6nUwOl3VvQIkXRp78ncgE=;
        b=rvjYTCO7611FCbX35zj/v+884n0vuW3jckWK10XDMS5U0peirjNoDDrUGfX2XY/oof
         ysod2xp1ZTcX81qmNcjNG7jemdodZEooSWlASKNpop3zyrMBnNfygwySIVJk4MPH6UVg
         T2AKnPofgpAW++uaxx5UvMcO3KQiljWNmp1UPDTFZz4SHQcc/le1Qig954aVFYiXyZBE
         nvXsSBRYsWNFCjw4yRtzzNb+bn3ODaJ7cJL/J87iN/rc95+0/P6iRnAZ98zmAIyps5fN
         SEFVWTdy9kTzNBEPds1BEFo2VwRIzc5DW2GTOwvTOWEe9n2ys+SXwflOtqhP9EKLB0Uf
         OisQ==
X-Gm-Message-State: APjAAAU4TurjRP9SKFPQPQu0Le6kVlPBCq7WAfHBtEdfXnetpMDNicXt
        0LqvhxLc5oxOcdfP63Z9p9eatmyj3YA=
X-Google-Smtp-Source: APXvYqxbfdPcsj/wly9LyV5sVNv7/pBaPJ+Jt9c0+8IQTqkDeqt5sHywRcJcPTiHGFnrSBFj8NGAgg==
X-Received: by 2002:adf:c614:: with SMTP id n20mr37027232wrg.17.1560244906213;
        Tue, 11 Jun 2019 02:21:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id v24sm1484562wmj.26.2019.06.11.02.21.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 02:21:45 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Date:   Tue, 11 Jun 2019 12:21:44 +0300
Message-Id: <20190611092144.11194-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support in the driver for 64-bit DMA mask when running
in a POWER9 machine.

POWER9 supports either 32-bit or 64-bit DMA mask. However, our ASICs
support 48-bit DMA mask. To support 64-bit, the driver needs to add a
special configuration to the ASIC's PCIe controller.

The activation of this special configuration is done in case the PCI
parent device of Goya is a PHB4 PCI device of IBM.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
- Remove kernel module parameter and instead read the PCI device ID of the
  parent PCI bus. If it is PHB4, do the special configuration.
 
 drivers/misc/habanalabs/goya/goya.c  |  6 +++++-
 drivers/misc/habanalabs/habanalabs.h |  4 ++++
 drivers/misc/habanalabs/pci.c        | 23 ++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e8b3a31d211f..71dc2341dd8c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -472,7 +472,11 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev, 48);
+	if (hl_pci_parent_is_phb4(hdev))
+		rc = hl_pci_init(hdev, 64);
+	else
+		rc = hl_pci_init(hdev, 48);
+
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 5e4a631b3d88..3ba94188884f 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1208,6 +1208,8 @@ struct hl_device_reset_work {
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fd_open_cnt, enforces
  *            that only a single user is configuring the debug infrastructure.
+ * @power9_64bit_dma_enable: true to enable 64-bit DMA mask support. Relevant
+ *                           only to POWER9 machines.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1281,6 +1283,7 @@ struct hl_device {
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
+	u8				power9_64bit_dma_enable;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
@@ -1504,6 +1507,7 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 int hl_pci_init(struct hl_device *hdev, u8 dma_mask);
 void hl_pci_fini(struct hl_device *hdev);
 int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
+bool hl_pci_parent_is_phb4(struct hl_device *hdev);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index c98d88c7a5c6..dcb737f9677c 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -10,6 +10,8 @@
 
 #include <linux/pci.h>
 
+#define PCI_DEVICE_ID_IBM_PHB4		0x04C1
+
 #define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 10)
 
 /**
@@ -182,6 +184,20 @@ static void hl_pci_reset_link_through_bridge(struct hl_device *hdev)
 	ssleep(3);
 }
 
+bool hl_pci_parent_is_phb4(struct hl_device *hdev)
+{
+	struct pci_dev *parent_port = hdev->pdev->bus->self;
+
+	if ((parent_port->vendor == PCI_VENDOR_ID_IBM) &&
+			(parent_port->device == PCI_DEVICE_ID_IBM_PHB4)) {
+		hdev->power9_64bit_dma_enable = 1;
+		return true;
+	}
+
+	hdev->power9_64bit_dma_enable = 0;
+	return false;
+}
+
 /**
  * hl_pci_set_dram_bar_base() - Set DDR BAR to map specific device address.
  * @hdev: Pointer to hl_device structure.
@@ -283,7 +299,12 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 				upper_32_bits(host_phys_base_address));
 	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
-	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
+	if ((hdev->power9_64bit_dma_enable) && (hdev->dma_mask == 64))
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0x08000000);
+	else
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
 	rc |= hl_pci_iatu_write(hdev, 0x020, upper_32_bits(host_phys_end_addr));
 	/* Increase region size */
 	rc |= hl_pci_iatu_write(hdev, 0x000, 0x00002000);
-- 
2.17.1

