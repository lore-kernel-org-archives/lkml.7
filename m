Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618F2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfwiCI/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfD2LyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:54:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51035 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:54:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so11877747wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0BIuwk58CaJsk9RrgR9sqqUo2JdknvUluNTd07CFIkQ=;
        b=GfwiCI/Wm1y3BZLlgVOyL4IuBhWqOeZGovQWThy39oT670A1eyapWbfQHb2m+EfZJy
         RexPxGSL2phcNfpkmej/gvo8Lz+FfzHjaJHMXz+effqkD9YdFvwr7U33At/0U3Zf0HiS
         ORGzHb8Jx4xS+7sd5/CsnbMrT2xRqMzRfDIoM+tfaSgmDENSP3hxbbhzBNF+2Jl5dy9l
         ExcT9VPDIQ98FvWlWsMRSco83o+oPnjSNvQrNItDwgVhfu0bXYMs32c0Q9QF6qJKqEBz
         h1nWq4TcncSNCthe2M/TqS56h6nB5/WJliu0rUIFFs4JqNDaR8bEiVntZ+gTdPxrfNZ9
         GuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0BIuwk58CaJsk9RrgR9sqqUo2JdknvUluNTd07CFIkQ=;
        b=XPynLjFVl1Fcze5NWR8PrQjw7wxrkOrFq+S08DxPLKVieYbl4q7gPZBMeSxKYqRZrr
         2kHnLyl/g5CsxT8o2L8T/eH68WRvfg+6tvsg3A9//X/eKNUnND4HH7Merh/nyC9nOjnG
         sy9bOnWQfYFFi4lCDmS3Q9X5AUvB+2ca1S7dzmYj/6Zf/XZ2utdTmqvGHgpr2zXAsHcu
         V2tvjfaybw9tsuK60r5xoMe2mRB4LC8aK0GKPYvDaneZKcS+GklCigVyDDlsJKzy8kfF
         vFqlUytLsuhlLWRKrAI+G3qZ5M/Y5p6xrqHHENAlOzN2CcDKOmD1cUc77rwaCeqvX+9I
         Ukjw==
X-Gm-Message-State: APjAAAWVz8nJOQlPAbdTEP1jmhJGgKnUHBD2qnsjKHzGTuJf1XGxxCW1
        XQcKI8NfnxvY2b28jucxV+qTpnUd
X-Google-Smtp-Source: APXvYqwgbM/mK0g4q7DjPlH/DnDaE+oQ+Y5CGY+jF6bIfe37BjLBQmtMslgS2DV/bGLXxe11oMlDRQ==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr4518743wmi.57.1556538844981;
        Mon, 29 Apr 2019 04:54:04 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h16sm9527141wrb.31.2019.04.29.04.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:54:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: return old dram bar address upon change
Date:   Mon, 29 Apr 2019 14:54:01 +0300
Message-Id: <20190429115402.8156-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the ASIC interface function that changes the DRAM bar
window. The change is to return the old address that the DRAM bar pointed
to instead of an error code.

This simplifies the code that use this function (mainly in debugfs) to
restore the bar to the old setting.

This is also needed for easier support in future ASICs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 60 +++++++++++++---------------
 drivers/misc/habanalabs/habanalabs.h |  5 ++-
 drivers/misc/habanalabs/pci.c        |  5 ++-
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 8ee3b00b0fab..04e4ed8a0be6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -389,33 +389,26 @@ static int goya_pci_bars_map(struct hl_device *hdev)
 	return 0;
 }
 
-/*
- * goya_set_ddr_bar_base - set DDR bar to map specific device address
- *
- * @hdev: pointer to hl_device structure
- * @addr: address in DDR. Must be aligned to DDR bar size
- *
- * This function configures the iATU so that the DDR bar will start at the
- * specified addr.
- *
- */
-static int goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
+static u64 goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
+	u64 old_addr = addr;
 	int rc;
 
 	if ((goya) && (goya->ddr_bar_cur_addr == addr))
-		return 0;
+		return old_addr;
 
 	/* Inbound Region 1 - Bar 4 - Point to DDR */
 	rc = hl_pci_set_dram_bar_base(hdev, 1, 4, addr);
 	if (rc)
-		return rc;
+		return U64_MAX;
 
-	if (goya)
+	if (goya) {
+		old_addr = goya->ddr_bar_cur_addr;
 		goya->ddr_bar_cur_addr = addr;
+	}
 
-	return 0;
+	return old_addr;
 }
 
 /*
@@ -2215,11 +2208,10 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 	 * Before pushing u-boot/linux to device, need to set the ddr bar to
 	 * base address of dram
 	 */
-	rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
-	if (rc) {
+	if (goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE) == U64_MAX) {
 		dev_err(hdev->dev,
 			"failed to map DDR bar to DRAM base address\n");
-		return rc;
+		return -EIO;
 	}
 
 	if (hdev->pldm) {
@@ -2454,12 +2446,12 @@ static int goya_hw_init(struct hl_device *hdev)
 	 * After CPU initialization is finished, change DDR bar mapping inside
 	 * iATU to point to the start address of the MMU page tables
 	 */
-	rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
-		(MMU_PAGE_TABLES_ADDR & ~(prop->dram_pci_bar_size - 0x1ull)));
-	if (rc) {
+	if (goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
+			(MMU_PAGE_TABLES_ADDR &
+			~(prop->dram_pci_bar_size - 0x1ull))) == U64_MAX) {
 		dev_err(hdev->dev,
 			"failed to map DDR bar to MMU page tables\n");
-		return rc;
+		return -EIO;
 	}
 
 	rc = goya_mmu_init(hdev);
@@ -3958,6 +3950,7 @@ void goya_restore_phase_topology(struct hl_device *hdev)
 static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 ddr_bar_addr;
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
@@ -3975,15 +3968,16 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
-		rc = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (!rc) {
+		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (ddr_bar_addr != U64_MAX) {
 			*val = readl(hdev->pcie_bar[DDR_BAR_ID] +
 						(addr - bar_base_addr));
 
-			rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
-				(MMU_PAGE_TABLES_ADDR &
-					~(prop->dram_pci_bar_size - 0x1ull)));
+			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
+							ddr_bar_addr);
 		}
+		if (ddr_bar_addr == U64_MAX)
+			rc = -EIO;
 	} else {
 		rc = -EFAULT;
 	}
@@ -4008,6 +4002,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 ddr_bar_addr;
 	int rc = 0;
 
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
@@ -4025,15 +4020,16 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
 
-		rc = goya_set_ddr_bar_base(hdev, bar_base_addr);
-		if (!rc) {
+		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (ddr_bar_addr != U64_MAX) {
 			writel(val, hdev->pcie_bar[DDR_BAR_ID] +
 						(addr - bar_base_addr));
 
-			rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
-				(MMU_PAGE_TABLES_ADDR &
-					~(prop->dram_pci_bar_size - 0x1ull)));
+			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
+							ddr_bar_addr);
 		}
+		if (ddr_bar_addr == U64_MAX)
+			rc = -EIO;
 	} else {
 		rc = -EFAULT;
 	}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a624d1e1e1e5..65717e4055da 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -487,7 +487,8 @@ enum hl_pll_frequency {
  * @send_cpu_message: send buffer to ArmCP.
  * @get_hw_state: retrieve the H/W state
  * @pci_bars_map: Map PCI BARs.
- * @set_dram_bar_base: Set DRAM BAR to map specific device address.
+ * @set_dram_bar_base: Set DRAM BAR to map specific device address. Returns
+ *                     old address the bar pointed to or U64_MAX for failure
  * @init_iatu: Initialize the iATU unit inside the PCI controller.
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
@@ -564,7 +565,7 @@ struct hl_asic_funcs {
 				u16 len, u32 timeout, long *result);
 	enum hl_device_hw_state (*get_hw_state)(struct hl_device *hdev);
 	int (*pci_bars_map)(struct hl_device *hdev);
-	int (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
+	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index d472d02a8e6e..5278f086d65d 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -259,7 +259,10 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 	/* Point to DRAM */
 	if (!hdev->asic_funcs->set_dram_bar_base)
 		return -EINVAL;
-	rc |= hdev->asic_funcs->set_dram_bar_base(hdev, dram_base_address);
+	if (hdev->asic_funcs->set_dram_bar_base(hdev, dram_base_address) ==
+								U64_MAX)
+		return -EIO;
+
 
 	/* Outbound Region 0 - Point to Host */
 	host_phys_end_addr = prop->host_phys_base_address + host_phys_size - 1;
-- 
2.17.1

