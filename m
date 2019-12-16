Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745BDC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458BE207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fIF4BGPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLPJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:03:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbfLPJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:03:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBG907Md015521;
        Mon, 16 Dec 2019 10:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=UdMl4jxtKK5tEbnHy5CiO3//LkXhcmJ0JMTyto/hDvo=;
 b=fIF4BGPT1D+5/YfiWTebDA+CJvlQ+aDI5rNyt751gl8etpfOUNh2Y/S5M8n9yj0n0kD/
 vJI+B8gJzCQDiSpF5uXhd7tEe5rVGRd4OxIJg6bF/WtOlrQ54ERVgUZzeQi54Hwdmp5M
 A2gueFhbAUPxrAWwVQVR3nlZLLZx9cc2alddDAM2x+hIwpa3mbBAvNWHXguIZFi8GuWG
 +RJxfz6Ede/tvDGxQkruUO0t+WO2EKO0sNfOiChv6syGzAfLPIw6xJmw4YxMA5o7bhAo
 v4dYvbyx2Bmt/tg1LCBaPOq70ZmnT3X9P3d4GdxYrdm/wiuOmPEx/S/psSqTB2E+k8kA sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvnre8gg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 10:02:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D25D100051;
        Mon, 16 Dec 2019 10:02:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7583A2B6A14;
        Mon, 16 Dec 2019 10:02:17 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 10:02:16
 +0100
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: mtd: rawnand: stm32_fmc2: avoid to lock the CPU bus
Date:   Mon, 16 Dec 2019 10:01:55 +0100
Message-ID: <1576486915-7517-1-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_02:2019-12-16,2019-12-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently using nand_soft_waitrdy to poll the status of the NAND
flash. FMC2 enables the wait feature bit (this feature is mandatory for
the sequencer mode). By enabling this feature, we can't poll the status
of the NAND flash, the read status command is stucked in FMC2 pipeline
until R/B# signal is high, and locks the CPU bus.
To avoid to lock the CPU bus, we poll FMC2 ISR register. This register
reports the status of the R/B# signal.

Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")
Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 38 ++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 9e63800..3ba73f1 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -37,6 +37,7 @@
 /* Max ECC buffer length */
 #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
 
+#define FMC2_TIMEOUT_US			1000
 #define FMC2_TIMEOUT_MS			1000
 
 /* Timings */
@@ -53,6 +54,8 @@
 #define FMC2_PMEM			0x88
 #define FMC2_PATT			0x8c
 #define FMC2_HECCR			0x94
+#define FMC2_ISR			0x184
+#define FMC2_ICR			0x188
 #define FMC2_CSQCR			0x200
 #define FMC2_CSQCFGR1			0x204
 #define FMC2_CSQCFGR2			0x208
@@ -118,6 +121,12 @@
 #define FMC2_PATT_ATTHIZ(x)		(((x) & 0xff) << 24)
 #define FMC2_PATT_DEFAULT		0x0a0a0a0a
 
+/* Register: FMC2_ISR */
+#define FMC2_ISR_IHLF			BIT(1)
+
+/* Register: FMC2_ICR */
+#define FMC2_ICR_CIHLF			BIT(1)
+
 /* Register: FMC2_CSQCR */
 #define FMC2_CSQCR_CSQSTART		BIT(0)
 
@@ -1322,6 +1331,31 @@ static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
 		stm32_fmc2_set_buswidth_16(fmc2, true);
 }
 
+static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
+{
+	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
+	const struct nand_sdr_timings *timings;
+	u32 isr, sr;
+
+	/* Check if there is no pending requests to the NAND flash */
+	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
+					      sr & FMC2_SR_NWRF, 1,
+					      FMC2_TIMEOUT_US))
+		dev_warn(fmc2->dev, "Waitrdy timeout\n");
+
+	/* Wait tWB before R/B# signal is low */
+	timings = nand_get_sdr_timings(&chip->data_interface);
+	ndelay(PSEC_TO_NSEC(timings->tWB_max));
+
+	/* R/B# signal is low, clear high level flag */
+	writel_relaxed(FMC2_ICR_CIHLF, fmc2->io_base + FMC2_ICR);
+
+	/* Wait R/B# signal is high */
+	return readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_ISR,
+						 isr, isr & FMC2_ISR_IHLF,
+						 5, 1000 * timeout_ms);
+}
+
 static int stm32_fmc2_exec_op(struct nand_chip *chip,
 			      const struct nand_operation *op,
 			      bool check_only)
@@ -1366,8 +1400,8 @@ static int stm32_fmc2_exec_op(struct nand_chip *chip,
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-			ret = nand_soft_waitrdy(chip,
-						instr->ctx.waitrdy.timeout_ms);
+			ret = stm32_fmc2_waitrdy(chip,
+						 instr->ctx.waitrdy.timeout_ms);
 			break;
 		}
 	}
-- 
1.9.1

