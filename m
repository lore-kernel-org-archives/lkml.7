Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24B0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCMPZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:25:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:18652 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfCMPZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:25:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="140455719"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2019 08:25:10 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] EDAC, altera: Fix S10 Double Bit Error Notification
Date:   Wed, 13 Mar 2019 10:27:22 -0500
Message-Id: <1552490842-25440-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Stratix10 Double Bit Error Address was always read from
SDRAM Address register instead of each device's Address
register.
To determine which device had the DBE, cycle through
the EDAC devices comparing the DBE value to the db_irq
value. Once found, report the DBE Address from the device
registers as well as the device name.
Finally, notify the system via an SMC call and indicate
the panic should result in a system reboot.
Change a run-time check to a Stratix10 compile-time check
for a clean SMC notification.

Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 69 ++++++++++++++++++++++++++++++++++------------
 drivers/edac/altera_edac.h | 20 ++++++++++++++
 2 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 1bcf9aea0cdf..5ff263850cc7 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1930,6 +1930,15 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 		goto err_release_group1;
 	}
 
+#ifdef CONFIG_ARCH_STRATIX10
+	/* Use IRQ to determine SError origin instead of assigning IRQ */
+	rc = of_property_read_u32_index(np, "interrupts", 0, &altdev->db_irq);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to parse DB IRQ index\n");
+		goto err_release_group1;
+	}
+#else
 	altdev->db_irq = irq_of_parse_and_map(np, 1);
 	if (!altdev->db_irq) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
@@ -1943,6 +1952,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
 		goto err_release_group1;
 	}
+#endif
 
 	rc = edac_device_add_device(dci);
 	if (rc) {
@@ -2005,6 +2015,10 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
 /************** Stratix 10 EDAC Double Bit Error Handler ************/
 #define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
 
+#ifdef CONFIG_ARCH_STRATIX10
+/* panic routine issues reboot on non-zero panic_timeout */
+extern int panic_timeout;
+
 /*
  * The double bit error is handled through SError which is fatal. This is
  * called as a panic notifier to printout ECC error info as part of the panic.
@@ -2018,17 +2032,37 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
 	regmap_read(edac->ecc_mgr_map, S10_SYSMGR_ECC_INTSTAT_DERR_OFST,
 		    &dberror);
 	regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST, dberror);
-	if (dberror & S10_DDR0_IRQ_MASK) {
-		regmap_read(edac->ecc_mgr_map, A10_DERRADDR_OFST, &err_addr);
-		regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
-			     err_addr);
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "EDAC: [Uncorrectable errors @ 0x%08X]\n\n",
-			    err_addr);
+	if (dberror & S10_DBE_IRQ_MASK) {
+		struct list_head *position;
+		struct altr_edac_device_dev *ed;
+		struct arm_smccc_res result;
+
+		/* Find the matching DBE in the list of devices */
+		list_for_each(position, &edac->a10_ecc_devices) {
+			ed = list_entry(position, struct altr_edac_device_dev,
+					next);
+			if (!(BIT(ed->db_irq) & dberror))
+				continue;
+
+			writel(ALTR_A10_ECC_DERRPENA,
+			       ed->base + ALTR_A10_ECC_INTSTAT_OFST);
+			err_addr = readl(ed->base + ALTR_S10_DERR_ADDRA_OFST);
+			regmap_write(edac->ecc_mgr_map,
+				     S10_SYSMGR_UE_ADDR_OFST, err_addr);
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "EDAC: [Fatal DBE on %s @ 0x%08X]\n",
+				    ed->edac_dev_name, err_addr);
+			break;
+		}
+		/* Notify the System through SMC. Reboot delay = 1 second */
+		panic_timeout = 1;
+		arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0, 0,
+			      0, 0, &result);
 	}
 
 	return NOTIFY_DONE;
 }
+#endif
 
 /****************** Arria 10 EDAC Probe Function *********************/
 static int altr_edac_a10_probe(struct platform_device *pdev)
@@ -2098,16 +2132,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 					 altr_edac_a10_irq_handler,
 					 edac);
 
-	if (socfpga_is_a10()) {
-		edac->db_irq = platform_get_irq(pdev, 1);
-		if (edac->db_irq < 0) {
-			dev_err(&pdev->dev, "No DBERR IRQ resource\n");
-			return edac->db_irq;
-		}
-		irq_set_chained_handler_and_data(edac->db_irq,
-						 altr_edac_a10_irq_handler,
-						 edac);
-	} else {
+#ifdef CONFIG_ARCH_STRATIX10
+	{
 		int dberror, err_addr;
 
 		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
@@ -2130,6 +2156,15 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 				     S10_SYSMGR_UE_ADDR_OFST, 0);
 		}
 	}
+#else
+	edac->db_irq = platform_get_irq(pdev, 1);
+	if (edac->db_irq < 0) {
+		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+		return edac->db_irq;
+	}
+	irq_set_chained_handler_and_data(edac->db_irq,
+					 altr_edac_a10_irq_handler, edac);
+#endif
 
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 4213cb0bb2a7..bfc8053d10dc 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -289,6 +289,7 @@ struct altr_sdram_mc_data {
 #define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
 
 /************* Stratix10 Defines **************/
+#define ALTR_S10_DERR_ADDRA_OFST          0x2C
 
 /* Stratix10 ECC Manager Defines */
 #define S10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
@@ -299,6 +300,7 @@ struct altr_sdram_mc_data {
 #define S10_SYSMGR_UE_ADDR_OFST           0x124
 
 #define S10_DDR0_IRQ_MASK                 BIT(16)
+#define S10_DBE_IRQ_MASK                  0x3FE
 
 /* Define ECC Block Offsets for peripherals */
 #define ECC_BLK_ADDRESS_OFST              0x40
@@ -435,4 +437,22 @@ struct altr_arria10_edac {
 #define INTEL_SIP_SMC_REG_WRITE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
 
+/*
+ * Request INTEL_SIP_SMC_ECC_DBE
+ *
+ * Sync call used by service driver at EL1 alert EL3 that a Double Bit
+ * ECC error has occurred.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ECC_DBE
+ * a1 SysManager Double Bit Error value
+ * a2-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ */
+#define INTEL_SIP_SMC_FUNCID_ECC_DBE 13
+#define INTEL_SIP_SMC_ECC_DBE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
+
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.7.4

