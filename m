Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04ADC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898121741
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY38NHGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCQT77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:59:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfCQT7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so14742179wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q21XSC/5DuvqmH6ABdwDvVQDjo+eoX+7pnvnm3KbSg8=;
        b=pY38NHGRoVCRp3Pc1BywDYKUaxgRzgbGVG1t+qZXgdA5WlTi0WUqEtdv7CGNoY6owo
         e13HxDscKu1Y3miqFpJiCPETV6pVGZoAaolJ7BQ0NJ077IlilhlkhoFka0CJkOIiWWG5
         6rp0czVnUOSzgfv9XFnmf1LcgIBOVqczldck2sGFqg+H4PMG3P+eqS1Ho19OvEwZgvuR
         FNCo+LsjoFs7z2uC+HEVSStqMz+U7iDPqbMt2bqU9CPcTesBAA8M+1TPNju7WwrjiAE5
         hWQQLaYSiO/VqUY198DziAZxy7h3CecHNwy5LH8xR2E3feT4Px3mEWYNWAlxrmak2qZV
         UqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q21XSC/5DuvqmH6ABdwDvVQDjo+eoX+7pnvnm3KbSg8=;
        b=aJAFV88cfFqbFc0/amf3Fv4QhgxbaceHYneXdCMibi7lCCi6m2x5SqOUDW4s7bEv6v
         3aG6sMApfT8SdL8quOvy3CbzyNPblkg0mo+9shtAivGKmnn7wbxyl6XfUeQWvU48hT1m
         ZbdgWmeTeX15vmfNB+k8eXM6IjiTfu5v7t6lOt07XyDSxqFPnqb39173GW5YonNI+TY5
         oI+i0/+JlNZ2XS2tOJeNFuNRGFuZMKOsZ4/fzTWmhOfviaDs1LDle5wS0k9Sc0T7hewK
         Y7GLWKizAWGj3Sb6SMtiY34LaqFUY7OVyFyGD+3+x3pCrMEu1yZ4FSi2EfH9zKcveRc3
         4o9w==
X-Gm-Message-State: APjAAAV2Wbt+NxvOCP5B6w4tCdDH2RM6B3J4DyukCkxrFSgfXqvpPCQk
        gz2qrEp7eo0Hn/NqizXSvGiNel96
X-Google-Smtp-Source: APXvYqxaurTx/nVxj3TK+Gslier2wcVvYJ4bKZlOdOv7cNO1FQPiv4K/9G6nXpSM7PwY5ATu/WY+Ug==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr3370392wru.161.1552852789453;
        Sun, 17 Mar 2019 12:59:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/15] habanalabs: Move PCI code into common file
Date:   Sun, 17 Mar 2019 21:59:20 +0200
Message-Id: <20190317195927.26238-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Move duplicated PCI-related code from ASIC-specific files into the common
pci.c file.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Makefile              |   2 +-
 drivers/misc/habanalabs/goya/goya.c           | 272 +------------
 drivers/misc/habanalabs/habanalabs.h          |  20 +
 .../include/goya/asic_reg/goya_masks.h        |  12 -
 .../include/hw_ip/pci/pci_general.h           |  23 ++
 drivers/misc/habanalabs/pci.c                 | 370 ++++++++++++++++++
 6 files changed, 434 insertions(+), 265 deletions(-)
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
 create mode 100644 drivers/misc/habanalabs/pci.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 598740d235f8..f8e85243d672 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -6,7 +6,7 @@ obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
 		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
-		command_submission.o mmu.o firmware_if.o
+		command_submission.o mmu.o firmware_if.o pci.o
 
 habanalabs-$(CONFIG_DEBUG_FS) += debugfs.o
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6ba0faa979bd..7e98383ec774 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -364,12 +364,13 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->cfg_size = CFG_SIZE;
 	prop->max_asid = MAX_ASID;
 	prop->num_of_events = GOYA_ASYNC_EVENT_ID_SIZE;
+	prop->high_pll = PLL_HIGH_DEFAULT;
 	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 	prop->max_power_default = MAX_POWER_DEFAULT;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
-
-	prop->high_pll = PLL_HIGH_DEFAULT;
+	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
+	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 }
 
 /*
@@ -383,161 +384,20 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
  */
 static int goya_pci_bars_map(struct hl_device *hdev)
 {
-	struct pci_dev *pdev = hdev->pdev;
+	static const char * const name[] = {"SRAM_CFG", "MSIX", "DDR"};
+	bool is_wc[3] = {false, false, true};
 	int rc;
 
-	rc = pci_request_regions(pdev, HL_NAME);
-	if (rc) {
-		dev_err(hdev->dev, "Cannot obtain PCI resources\n");
+	rc = hl_pci_bars_map(hdev, name, is_wc);
+	if (rc)
 		return rc;
-	}
-
-	hdev->pcie_bar[SRAM_CFG_BAR_ID] =
-			pci_ioremap_bar(pdev, SRAM_CFG_BAR_ID);
-	if (!hdev->pcie_bar[SRAM_CFG_BAR_ID]) {
-		dev_err(hdev->dev, "pci_ioremap_bar failed for CFG\n");
-		rc = -ENODEV;
-		goto err_release_regions;
-	}
-
-	hdev->pcie_bar[MSIX_BAR_ID] = pci_ioremap_bar(pdev, MSIX_BAR_ID);
-	if (!hdev->pcie_bar[MSIX_BAR_ID]) {
-		dev_err(hdev->dev, "pci_ioremap_bar failed for MSIX\n");
-		rc = -ENODEV;
-		goto err_unmap_sram_cfg;
-	}
-
-	hdev->pcie_bar[DDR_BAR_ID] = pci_ioremap_wc_bar(pdev, DDR_BAR_ID);
-	if (!hdev->pcie_bar[DDR_BAR_ID]) {
-		dev_err(hdev->dev, "pci_ioremap_bar failed for DDR\n");
-		rc = -ENODEV;
-		goto err_unmap_msix;
-	}
 
 	hdev->rmmio = hdev->pcie_bar[SRAM_CFG_BAR_ID] +
-				(CFG_BASE - SRAM_BASE_ADDR);
-
-	return 0;
-
-err_unmap_msix:
-	iounmap(hdev->pcie_bar[MSIX_BAR_ID]);
-err_unmap_sram_cfg:
-	iounmap(hdev->pcie_bar[SRAM_CFG_BAR_ID]);
-err_release_regions:
-	pci_release_regions(pdev);
-
-	return rc;
-}
-
-/*
- * goya_pci_bars_unmap - Unmap PCI BARS of Goya device
- *
- * @hdev: pointer to hl_device structure
- *
- * Release all PCI BARS and unmap their virtual addresses
- *
- */
-static void goya_pci_bars_unmap(struct hl_device *hdev)
-{
-	struct pci_dev *pdev = hdev->pdev;
-
-	iounmap(hdev->pcie_bar[DDR_BAR_ID]);
-	iounmap(hdev->pcie_bar[MSIX_BAR_ID]);
-	iounmap(hdev->pcie_bar[SRAM_CFG_BAR_ID]);
-	pci_release_regions(pdev);
-}
-
-/*
- * goya_elbi_write - Write through the ELBI interface
- *
- * @hdev: pointer to hl_device structure
- *
- * return 0 on success, -1 on failure
- *
- */
-static int goya_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
-{
-	struct pci_dev *pdev = hdev->pdev;
-	ktime_t timeout;
-	u32 val;
-
-	/* Clear previous status */
-	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, 0);
-
-	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_ADDR, (u32) addr);
-	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
-	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_CTRL,
-				PCI_CONFIG_ELBI_CTRL_WRITE);
-
-	timeout = ktime_add_ms(ktime_get(), 10);
-	for (;;) {
-		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, &val);
-		if (val & PCI_CONFIG_ELBI_STS_MASK)
-			break;
-		if (ktime_compare(ktime_get(), timeout) > 0) {
-			pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS,
-						&val);
-			break;
-		}
-		usleep_range(300, 500);
-	}
-
-	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE)
-		return 0;
-
-	if (val & PCI_CONFIG_ELBI_STS_ERR) {
-		dev_err(hdev->dev, "Error writing to ELBI\n");
-		return -EIO;
-	}
-
-	if (!(val & PCI_CONFIG_ELBI_STS_MASK)) {
-		dev_err(hdev->dev, "ELBI write didn't finish in time\n");
-		return -EIO;
-	}
-
-	dev_err(hdev->dev, "ELBI write has undefined bits in status\n");
-	return -EIO;
-}
-
-/*
- * goya_iatu_write - iatu write routine
- *
- * @hdev: pointer to hl_device structure
- *
- */
-static int goya_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
-{
-	u32 dbi_offset;
-	int rc;
-
-	dbi_offset = addr & 0xFFF;
-
-	rc = goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0x00300000);
-	rc |= goya_elbi_write(hdev, mmPCIE_DBI_BASE + dbi_offset, data);
-
-	if (rc)
-		return -EIO;
+			(CFG_BASE - SRAM_BASE_ADDR);
 
 	return 0;
 }
 
-static void goya_reset_link_through_bridge(struct hl_device *hdev)
-{
-	struct pci_dev *pdev = hdev->pdev;
-	struct pci_dev *parent_port;
-	u16 val;
-
-	parent_port = pdev->bus->self;
-	pci_read_config_word(parent_port, PCI_BRIDGE_CONTROL, &val);
-	val |= PCI_BRIDGE_CTL_BUS_RESET;
-	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
-	ssleep(1);
-
-	val &= ~(PCI_BRIDGE_CTL_BUS_RESET);
-	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
-	ssleep(3);
-}
-
 /*
  * goya_set_ddr_bar_base - set DDR bar to map specific device address
  *
@@ -557,20 +417,9 @@ static int goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
 		return 0;
 
 	/* Inbound Region 1 - Bar 4 - Point to DDR */
-	rc = goya_iatu_write(hdev, 0x314, lower_32_bits(addr));
-	rc |= goya_iatu_write(hdev, 0x318, upper_32_bits(addr));
-	rc |= goya_iatu_write(hdev, 0x300, 0);
-	/* Enable + Bar match + match enable + Bar 4 */
-	rc |= goya_iatu_write(hdev, 0x304, 0xC0080400);
-
-	/* Return the DBI window to the default location */
-	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0);
-	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI_32, 0);
-
-	if (rc) {
-		dev_err(hdev->dev, "failed to map DDR bar to 0x%08llx\n", addr);
-		return -EIO;
-	}
+	rc = hl_pci_set_dram_bar_base(hdev, 1, 4, addr);
+	if (rc)
+		return rc;
 
 	if (goya)
 		goya->ddr_bar_cur_addr = addr;
@@ -588,40 +437,8 @@ static int goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
  */
 static int goya_init_iatu(struct hl_device *hdev)
 {
-	int rc;
-
-	/* Inbound Region 0 - Bar 0 - Point to SRAM_BASE_ADDR */
-	rc  = goya_iatu_write(hdev, 0x114, lower_32_bits(SRAM_BASE_ADDR));
-	rc |= goya_iatu_write(hdev, 0x118, upper_32_bits(SRAM_BASE_ADDR));
-	rc |= goya_iatu_write(hdev, 0x100, 0);
-	/* Enable + Bar match + match enable */
-	rc |= goya_iatu_write(hdev, 0x104, 0xC0080000);
-
-	/* Inbound Region 1 - Bar 4 - Point to DDR */
-	rc |= goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
-
-	/* Outbound Region 0 - Point to Host */
-	rc |= goya_iatu_write(hdev, 0x008, lower_32_bits(HOST_PHYS_BASE));
-	rc |= goya_iatu_write(hdev, 0x00C, upper_32_bits(HOST_PHYS_BASE));
-	rc |= goya_iatu_write(hdev, 0x010,
-		lower_32_bits(HOST_PHYS_BASE + HOST_PHYS_SIZE - 1));
-	rc |= goya_iatu_write(hdev, 0x014, 0);
-	rc |= goya_iatu_write(hdev, 0x018, 0);
-	rc |= goya_iatu_write(hdev, 0x020,
-		upper_32_bits(HOST_PHYS_BASE + HOST_PHYS_SIZE - 1));
-	/* Increase region size */
-	rc |= goya_iatu_write(hdev, 0x000, 0x00002000);
-	/* Enable */
-	rc |= goya_iatu_write(hdev, 0x004, 0x80000000);
-
-	/* Return the DBI window to the default location */
-	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI, 0);
-	rc |= goya_elbi_write(hdev, CFG_BASE + mmPCIE_AUX_DBI_32, 0);
-
-	if (rc)
-		return -EIO;
-
-	return 0;
+	return hl_pci_init_iatu(hdev, SRAM_BASE_ADDR, DRAM_PHYS_BASE,
+				HOST_PHYS_SIZE);
 }
 
 /*
@@ -667,52 +484,9 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	/* set DMA mask for GOYA */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(39));
-	if (rc) {
-		dev_warn(hdev->dev, "Unable to set pci dma mask to 39 bits\n");
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Unable to set pci dma mask to 32 bits\n");
-			return rc;
-		}
-	}
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(39));
-	if (rc) {
-		dev_warn(hdev->dev,
-			"Unable to set pci consistent dma mask to 39 bits\n");
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Unable to set pci consistent dma mask to 32 bits\n");
-			return rc;
-		}
-	}
-
-	if (hdev->reset_pcilink)
-		goya_reset_link_through_bridge(hdev);
-
-	rc = pci_enable_device_mem(pdev);
-	if (rc) {
-		dev_err(hdev->dev, "can't enable PCI device\n");
+	rc = hl_pci_init(hdev);
+	if (rc)
 		return rc;
-	}
-
-	pci_set_master(pdev);
-
-	rc = goya_init_iatu(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize iATU\n");
-		goto disable_device;
-	}
-
-	rc = goya_pci_bars_map(hdev);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize PCI BARS\n");
-		goto disable_device;
-	}
 
 	if (!hdev->pldm) {
 		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
@@ -722,12 +496,6 @@ static int goya_early_init(struct hl_device *hdev)
 	}
 
 	return 0;
-
-disable_device:
-	pci_clear_master(pdev);
-	pci_disable_device(pdev);
-
-	return rc;
 }
 
 /*
@@ -740,10 +508,7 @@ static int goya_early_init(struct hl_device *hdev)
  */
 static int goya_early_fini(struct hl_device *hdev)
 {
-	goya_pci_bars_unmap(hdev);
-
-	pci_clear_master(hdev->pdev);
-	pci_disable_device(hdev->pdev);
+	hl_pci_fini(hdev);
 
 	return 0;
 }
@@ -5072,7 +4837,10 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.send_cpu_message = goya_send_cpu_message,
-	.get_hw_state = goya_get_hw_state
+	.get_hw_state = goya_get_hw_state,
+	.pci_bars_map = goya_pci_bars_map,
+	.set_dram_bar_base = goya_set_ddr_bar_base,
+	.init_iatu = goya_init_iatu
 };
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 1445ba1cafd4..ed3649d38ff8 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -148,6 +148,8 @@ enum hl_device_hw_state {
  *                             mapping DRAM memory.
  * @dram_size_for_default_page_mapping: DRAM size needed to map to avoid page
  *                                      fault.
+ * @pcie_dbi_base_address: Base address of the PCIE_DBI block.
+ * @pcie_aux_dbi_reg_addr: Address of the PCIE_AUX DBI register.
  * @mmu_pgt_addr: base physical address in DRAM of MMU page tables.
  * @mmu_dram_default_page_addr: DRAM default page physical address.
  * @mmu_pgt_size: MMU page tables total size.
@@ -189,6 +191,8 @@ struct asic_fixed_properties {
 	u64			va_space_dram_start_address;
 	u64			va_space_dram_end_address;
 	u64			dram_size_for_default_page_mapping;
+	u64			pcie_dbi_base_address;
+	u64			pcie_aux_dbi_reg_addr;
 	u64			mmu_pgt_addr;
 	u64			mmu_dram_default_page_addr;
 	u32			mmu_pgt_size;
@@ -485,6 +489,9 @@ enum hl_pll_frequency {
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @send_cpu_message: send buffer to ArmCP.
  * @get_hw_state: retrieve the H/W state
+ * @pci_bars_map: Map PCI BARs.
+ * @set_dram_bar_base: Set DRAM BAR to map specific device address.
+ * @init_iatu: Initialize the iATU unit inside the PCI controller.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -558,6 +565,9 @@ struct hl_asic_funcs {
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
 				u16 len, u32 timeout, long *result);
 	enum hl_device_hw_state (*get_hw_state)(struct hl_device *hdev);
+	int (*pci_bars_map)(struct hl_device *hdev);
+	int (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
+	int (*init_iatu)(struct hl_device *hdev);
 };
 
 
@@ -1368,6 +1378,16 @@ int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_armcp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 
+int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
+			bool is_wc[3]);
+int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data);
+int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
+				u64 addr);
+int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
+			u64 dram_base_address, u64 host_phys_size);
+int hl_pci_init(struct hl_device *hdev);
+void hl_pci_fini(struct hl_device *hdev);
+
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
 long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
index a161ecfe74de..8618891d5afa 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
@@ -189,18 +189,6 @@
 			1 << CPU_CA53_CFG_ARM_RST_CONTROL_NL2RESET_SHIFT |\
 			1 << CPU_CA53_CFG_ARM_RST_CONTROL_NMBISTRESET_SHIFT)
 
-/* PCI CONFIGURATION SPACE */
-#define mmPCI_CONFIG_ELBI_ADDR		0xFF0
-#define mmPCI_CONFIG_ELBI_DATA		0xFF4
-#define mmPCI_CONFIG_ELBI_CTRL		0xFF8
-#define PCI_CONFIG_ELBI_CTRL_WRITE	(1 << 31)
-
-#define mmPCI_CONFIG_ELBI_STS		0xFFC
-#define PCI_CONFIG_ELBI_STS_ERR		(1 << 30)
-#define PCI_CONFIG_ELBI_STS_DONE	(1 << 31)
-#define PCI_CONFIG_ELBI_STS_MASK	(PCI_CONFIG_ELBI_STS_ERR | \
-					PCI_CONFIG_ELBI_STS_DONE)
-
 #define GOYA_IRQ_HBW_ID_MASK			0x1FFF
 #define GOYA_IRQ_HBW_ID_SHIFT			0
 #define GOYA_IRQ_HBW_INTERNAL_ID_MASK		0xE000
diff --git a/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h b/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
new file mode 100644
index 000000000000..d232081d4e0f
--- /dev/null
+++ b/drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2019 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef INCLUDE_PCI_GENERAL_H_
+#define INCLUDE_PCI_GENERAL_H_
+
+/* PCI CONFIGURATION SPACE */
+#define mmPCI_CONFIG_ELBI_ADDR		0xFF0
+#define mmPCI_CONFIG_ELBI_DATA		0xFF4
+#define mmPCI_CONFIG_ELBI_CTRL		0xFF8
+#define PCI_CONFIG_ELBI_CTRL_WRITE	(1 << 31)
+
+#define mmPCI_CONFIG_ELBI_STS		0xFFC
+#define PCI_CONFIG_ELBI_STS_ERR		(1 << 30)
+#define PCI_CONFIG_ELBI_STS_DONE	(1 << 31)
+#define PCI_CONFIG_ELBI_STS_MASK	(PCI_CONFIG_ELBI_STS_ERR | \
+					PCI_CONFIG_ELBI_STS_DONE)
+
+#endif /* INCLUDE_PCI_GENERAL_H_ */
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
new file mode 100644
index 000000000000..822ac110b997
--- /dev/null
+++ b/drivers/misc/habanalabs/pci.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2019 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+#include "include/hw_ip/pci/pci_general.h"
+
+#include <linux/pci.h>
+
+/**
+ * hl_pci_bars_map() - Map PCI BARs.
+ * @hdev: Pointer to hl_device structure.
+ * @bar_name: Array of BAR names.
+ * @is_wc: Array with flag per BAR whether a write-combined mapping is needed.
+ *
+ * Request PCI regions and map them to kernel virtual addresses.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
+			bool is_wc[3])
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int rc, i, bar;
+
+	rc = pci_request_regions(pdev, HL_NAME);
+	if (rc) {
+		dev_err(hdev->dev, "Cannot obtain PCI resources\n");
+		return rc;
+	}
+
+	for (i = 0 ; i < 3 ; i++) {
+		bar = i * 2; /* 64-bit BARs */
+		hdev->pcie_bar[bar] = is_wc[i] ?
+				pci_ioremap_wc_bar(pdev, bar) :
+				pci_ioremap_bar(pdev, bar);
+		if (!hdev->pcie_bar[bar]) {
+			dev_err(hdev->dev, "pci_ioremap%s_bar failed for %s\n",
+					is_wc[i] ? "_wc" : "", name[i]);
+			rc = -ENODEV;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	for (i = 2 ; i >= 0 ; i--) {
+		bar = i * 2; /* 64-bit BARs */
+		if (hdev->pcie_bar[bar])
+			iounmap(hdev->pcie_bar[bar]);
+	}
+
+	pci_release_regions(pdev);
+
+	return rc;
+}
+
+/*
+ * hl_pci_bars_unmap() - Unmap PCI BARS.
+ * @hdev: Pointer to hl_device structure.
+ *
+ * Release all PCI BARs and unmap their virtual addresses.
+ */
+static void hl_pci_bars_unmap(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int i, bar;
+
+	for (i = 2 ; i >= 0 ; i--) {
+		bar = i * 2; /* 64-bit BARs */
+		iounmap(hdev->pcie_bar[bar]);
+	}
+
+	pci_release_regions(pdev);
+}
+
+/*
+ * hl_pci_elbi_write() - Write through the ELBI interface.
+ * @hdev: Pointer to hl_device structure.
+ *
+ * Return: 0 on success, negative value for failure.
+ */
+static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	ktime_t timeout;
+	u32 val;
+
+	/* Clear previous status */
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, 0);
+
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_ADDR, (u32) addr);
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_CTRL,
+				PCI_CONFIG_ELBI_CTRL_WRITE);
+
+	timeout = ktime_add_ms(ktime_get(), 10);
+	for (;;) {
+		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, &val);
+		if (val & PCI_CONFIG_ELBI_STS_MASK)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS,
+						&val);
+			break;
+		}
+
+		usleep_range(300, 500);
+	}
+
+	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE)
+		return 0;
+
+	if (val & PCI_CONFIG_ELBI_STS_ERR) {
+		dev_err(hdev->dev, "Error writing to ELBI\n");
+		return -EIO;
+	}
+
+	if (!(val & PCI_CONFIG_ELBI_STS_MASK)) {
+		dev_err(hdev->dev, "ELBI write didn't finish in time\n");
+		return -EIO;
+	}
+
+	dev_err(hdev->dev, "ELBI write has undefined bits in status\n");
+	return -EIO;
+}
+
+/**
+ * hl_pci_iatu_write() - iatu write routine.
+ * @hdev: Pointer to hl_device structure.
+ *
+ * Return: 0 on success, negative value for failure.
+ */
+int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 dbi_offset;
+	int rc;
+
+	dbi_offset = addr & 0xFFF;
+
+	rc = hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0x00300000);
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_dbi_base_address + dbi_offset,
+				data);
+
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * hl_pci_reset_link_through_bridge() - Reset PCI link.
+ * @hdev: Pointer to hl_device structure.
+ */
+static void hl_pci_reset_link_through_bridge(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	struct pci_dev *parent_port;
+	u16 val;
+
+	parent_port = pdev->bus->self;
+	pci_read_config_word(parent_port, PCI_BRIDGE_CONTROL, &val);
+	val |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
+	ssleep(1);
+
+	val &= ~(PCI_BRIDGE_CTL_BUS_RESET);
+	pci_write_config_word(parent_port, PCI_BRIDGE_CONTROL, val);
+	ssleep(3);
+}
+
+/**
+ * hl_pci_set_dram_bar_base() - Set DDR BAR to map specific device address.
+ * @hdev: Pointer to hl_device structure.
+ * @inbound_region: Inbound region number.
+ * @bar: PCI BAR number.
+ * @addr: Address in DRAM. Must be aligned to DRAM bar size.
+ *
+ * Configure the iATU so that the DRAM bar will start at the specified address.
+ *
+ * Return: 0 on success, negative value for failure.
+ */
+int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
+				u64 addr)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 offset;
+	int rc;
+
+	switch (inbound_region) {
+	case 0:
+		offset = 0x100;
+		break;
+	case 1:
+		offset = 0x300;
+		break;
+	case 2:
+		offset = 0x500;
+		break;
+	default:
+		dev_err(hdev->dev, "Invalid inbound region %d\n",
+			inbound_region);
+		return -EINVAL;
+	}
+
+	if (bar != 0 && bar != 2 && bar != 4) {
+		dev_err(hdev->dev, "Invalid PCI BAR %d\n", bar);
+		return -EINVAL;
+	}
+
+	/* Point to the specified address */
+	rc = hl_pci_iatu_write(hdev, offset + 0x14, lower_32_bits(addr));
+	rc |= hl_pci_iatu_write(hdev, offset + 0x18, upper_32_bits(addr));
+	rc |= hl_pci_iatu_write(hdev, offset + 0x0, 0);
+	/* Enable + BAR match + match enable + BAR number */
+	rc |= hl_pci_iatu_write(hdev, offset + 0x4, 0xC0080000 | (bar << 8));
+
+	/* Return the DBI window to the default location */
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to map DRAM bar to 0x%08llx\n",
+			addr);
+
+	return rc;
+}
+
+/**
+ * hl_pci_init_iatu() - Initialize the iATU unit inside the PCI controller.
+ * @hdev: Pointer to hl_device structure.
+ * @sram_base_address: SRAM base address.
+ * @dram_base_address: DRAM base address.
+ * @host_phys_size: Size of host memory for device transactions.
+ *
+ * This is needed in case the firmware doesn't initialize the iATU.
+ *
+ * Return: 0 on success, negative value for failure.
+ */
+int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
+			u64 dram_base_address, u64 host_phys_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 host_phys_end_addr;
+	int rc = 0;
+
+	/* Inbound Region 0 - Bar 0 - Point to SRAM base address */
+	rc  = hl_pci_iatu_write(hdev, 0x114, lower_32_bits(sram_base_address));
+	rc |= hl_pci_iatu_write(hdev, 0x118, upper_32_bits(sram_base_address));
+	rc |= hl_pci_iatu_write(hdev, 0x100, 0);
+	/* Enable + Bar match + match enable */
+	rc |= hl_pci_iatu_write(hdev, 0x104, 0xC0080000);
+
+	/* Point to DRAM */
+	if (!hdev->asic_funcs->set_dram_bar_base)
+		return -EINVAL;
+	rc |= hdev->asic_funcs->set_dram_bar_base(hdev, dram_base_address);
+
+	/* Outbound Region 0 - Point to Host */
+	host_phys_end_addr = prop->host_phys_base_address + host_phys_size - 1;
+	rc |= hl_pci_iatu_write(hdev, 0x008,
+				lower_32_bits(prop->host_phys_base_address));
+	rc |= hl_pci_iatu_write(hdev, 0x00C,
+				upper_32_bits(prop->host_phys_base_address));
+	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
+	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
+	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+	rc |= hl_pci_iatu_write(hdev, 0x020, upper_32_bits(host_phys_end_addr));
+	/* Increase region size */
+	rc |= hl_pci_iatu_write(hdev, 0x000, 0x00002000);
+	/* Enable */
+	rc |= hl_pci_iatu_write(hdev, 0x004, 0x80000000);
+
+	/* Return the DBI window to the default location */
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
+
+	if (rc)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * hl_pci_init() - PCI initialization code.
+ * @hdev: Pointer to hl_device structure.
+ *
+ * Set DMA masks, initialize the PCI controller and map the PCI BARs.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+int hl_pci_init(struct hl_device *hdev)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	int rc;
+
+	/* set DMA mask */
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(39));
+	if (rc) {
+		dev_warn(hdev->dev, "Unable to set pci dma mask to 39 bits\n");
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(39));
+	if (rc) {
+		dev_warn(hdev->dev,
+			"Unable to set pci consistent dma mask to 39 bits\n");
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci consistent dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	if (hdev->reset_pcilink)
+		hl_pci_reset_link_through_bridge(hdev);
+
+	rc = pci_enable_device_mem(pdev);
+	if (rc) {
+		dev_err(hdev->dev, "can't enable PCI device\n");
+		return rc;
+	}
+
+	pci_set_master(pdev);
+
+	rc = hdev->asic_funcs->init_iatu(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize iATU\n");
+		goto disable_device;
+	}
+
+	rc = hdev->asic_funcs->pci_bars_map(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to initialize PCI BARs\n");
+		goto disable_device;
+	}
+
+	return 0;
+
+disable_device:
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
+	return rc;
+}
+
+/**
+ * hl_fw_fini() - PCI finalization code.
+ * @hdev: Pointer to hl_device structure
+ *
+ * Unmap PCI bars and disable PCI device.
+ */
+void hl_pci_fini(struct hl_device *hdev)
+{
+	hl_pci_bars_unmap(hdev);
+
+	pci_clear_master(hdev->pdev);
+	pci_disable_device(hdev->pdev);
+}
-- 
2.17.1

