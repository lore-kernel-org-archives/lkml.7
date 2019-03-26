Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA942075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfCZV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:27:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:22518 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZV1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:27:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 14:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="135039059"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2019 14:27:09 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 2/2] EDAC, altera: Initialize peripheral FIFOs in probe()
Date:   Tue, 26 Mar 2019 16:29:31 -0500
Message-Id: <1553635771-32693-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553635771-32693-1-git-send-email-thor.thayer@linux.intel.com>
References: <1553635771-32693-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The FIFO memory and ECC initialization doesn't need to be
done as a separate operation early in the startup.

Improve the Arria10 and Stratix10 peripheral FIFO init
by initializing memory and enabling ECC as part of the
device driver initialization.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 162 +++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 71 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index acb3006df631..761199175c76 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1361,8 +1361,19 @@ static const struct edac_device_prv_data a10_l2ecc_data = {
 
 #ifdef CONFIG_EDAC_ALTERA_ETHERNET
 
+static int __init socfpga_init_ethernet_ecc(struct altr_edac_device_dev *dev)
+{
+	int ret;
+
+	ret = altr_init_a10_ecc_device_type("altr,socfpga-eth-mac-ecc");
+	if (ret)
+		return ret;
+
+	return altr_check_ecc_deps(dev);
+}
+
 static const struct edac_device_prv_data a10_enetecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = socfpga_init_ethernet_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1374,21 +1385,25 @@ static const struct edac_device_prv_data a10_enetecc_data = {
 	.inject_fops = &altr_edac_a10_device_inject2_fops,
 };
 
-static int __init socfpga_init_ethernet_ecc(void)
-{
-	return altr_init_a10_ecc_device_type("altr,socfpga-eth-mac-ecc");
-}
-
-early_initcall(socfpga_init_ethernet_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_ETHERNET */
 
 /********************** NAND Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_NAND
 
+static int __init socfpga_init_nand_ecc(struct altr_edac_device_dev *device)
+{
+	int ret;
+
+	ret = altr_init_a10_ecc_device_type("altr,socfpga-nand-ecc");
+	if (ret)
+		return ret;
+
+	return altr_check_ecc_deps(device);
+}
+
 static const struct edac_device_prv_data a10_nandecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = socfpga_init_nand_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1400,21 +1415,25 @@ static const struct edac_device_prv_data a10_nandecc_data = {
 	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
-static int __init socfpga_init_nand_ecc(void)
-{
-	return altr_init_a10_ecc_device_type("altr,socfpga-nand-ecc");
-}
-
-early_initcall(socfpga_init_nand_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_NAND */
 
 /********************** DMA Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_DMA
 
+static int __init socfpga_init_dma_ecc(struct altr_edac_device_dev *device)
+{
+	int ret;
+
+	ret = altr_init_a10_ecc_device_type("altr,socfpga-dma-ecc");
+	if (ret)
+		return ret;
+
+	return altr_check_ecc_deps(device);
+}
+
 static const struct edac_device_prv_data a10_dmaecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = socfpga_init_dma_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1426,21 +1445,25 @@ static const struct edac_device_prv_data a10_dmaecc_data = {
 	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
-static int __init socfpga_init_dma_ecc(void)
-{
-	return altr_init_a10_ecc_device_type("altr,socfpga-dma-ecc");
-}
-
-early_initcall(socfpga_init_dma_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_DMA */
 
 /********************** USB Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_USB
 
+static int __init socfpga_init_usb_ecc(struct altr_edac_device_dev *device)
+{
+	int ret;
+
+	ret = altr_init_a10_ecc_device_type("altr,socfpga-usb-ecc");
+	if (ret)
+		return ret;
+
+	return altr_check_ecc_deps(device);
+}
+
 static const struct edac_device_prv_data a10_usbecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = socfpga_init_usb_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1452,21 +1475,25 @@ static const struct edac_device_prv_data a10_usbecc_data = {
 	.inject_fops = &altr_edac_a10_device_inject2_fops,
 };
 
-static int __init socfpga_init_usb_ecc(void)
-{
-	return altr_init_a10_ecc_device_type("altr,socfpga-usb-ecc");
-}
-
-early_initcall(socfpga_init_usb_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_USB */
 
 /********************** QSPI Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_QSPI
 
+static int __init socfpga_init_qspi_ecc(struct altr_edac_device_dev *device)
+{
+	int ret;
+
+	ret = altr_init_a10_ecc_device_type("altr,socfpga-qspi-ecc");
+	if (ret)
+		return ret;
+
+	return altr_check_ecc_deps(device);
+}
+
 static const struct edac_device_prv_data a10_qspiecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = socfpga_init_qspi_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1478,13 +1505,6 @@ static const struct edac_device_prv_data a10_qspiecc_data = {
 	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
-static int __init socfpga_init_qspi_ecc(void)
-{
-	return altr_init_a10_ecc_device_type("altr,socfpga-qspi-ecc");
-}
-
-early_initcall(socfpga_init_qspi_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_QSPI */
 
 /********************* SDMMC Device Functions **********************/
@@ -1593,6 +1613,35 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	return rc;
 }
 
+static int __init socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
+{
+	int rc = -ENODEV;
+	struct device_node *child;
+
+	child = of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
+	if (!child)
+		return -ENODEV;
+
+	if (!of_device_is_available(child))
+		goto exit;
+
+	if (validate_parent_available(child))
+		goto exit;
+
+	/* Init portB */
+	rc = altr_init_a10_ecc_block(child, ALTR_A10_SDMMC_IRQ_MASK,
+				     a10_sdmmceccb_data.ecc_enable_mask, 1);
+	if (rc)
+		goto exit;
+
+	/* Setup portB */
+	return altr_portb_setup(device);
+
+exit:
+	of_node_put(child);
+	return rc;
+}
+
 static irqreturn_t altr_edac_a10_ecc_irq_portb(int irq, void *dev_id)
 {
 	struct altr_edac_device_dev *ad = dev_id;
@@ -1617,7 +1666,7 @@ static irqreturn_t altr_edac_a10_ecc_irq_portb(int irq, void *dev_id)
 }
 
 static const struct edac_device_prv_data a10_sdmmcecca_data = {
-	.setup = altr_portb_setup,
+	.setup = socfpga_init_sdmmc_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1630,7 +1679,7 @@ static const struct edac_device_prv_data a10_sdmmcecca_data = {
 };
 
 static const struct edac_device_prv_data a10_sdmmceccb_data = {
-	.setup = altr_portb_setup,
+	.setup = socfpga_init_sdmmc_ecc,
 	.ce_clear_mask = ALTR_A10_ECC_SERRPENB,
 	.ue_clear_mask = ALTR_A10_ECC_DERRPENB,
 	.ecc_enable_mask = ALTR_A10_COMMON_ECC_EN_CTL,
@@ -1642,35 +1691,6 @@ static const struct edac_device_prv_data a10_sdmmceccb_data = {
 	.inject_fops = &altr_edac_a10_device_inject_fops,
 };
 
-static int __init socfpga_init_sdmmc_ecc(void)
-{
-	int rc = -ENODEV;
-	struct device_node *child;
-
-	if (!socfpga_is_a10() && !socfpga_is_s10())
-		return -ENODEV;
-
-	child = of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
-	if (!child) {
-		edac_printk(KERN_WARNING, EDAC_DEVICE, "SDMMC node not found\n");
-		return -ENODEV;
-	}
-
-	if (!of_device_is_available(child))
-		goto exit;
-
-	if (validate_parent_available(child))
-		goto exit;
-
-	rc = altr_init_a10_ecc_block(child, ALTR_A10_SDMMC_IRQ_MASK,
-				     a10_sdmmcecca_data.ecc_enable_mask, 1);
-exit:
-	of_node_put(child);
-	return rc;
-}
-
-early_initcall(socfpga_init_sdmmc_ecc);
-
 #endif	/* CONFIG_EDAC_ALTERA_SDMMC */
 
 /********************* Arria10 EDAC Device Functions *************************/
-- 
2.7.4

