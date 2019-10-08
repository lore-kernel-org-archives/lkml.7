Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D89C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A082196E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pEFTw1bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJHJ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:56:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58105 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730460AbfJHJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:56:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x989pbJd007847;
        Tue, 8 Oct 2019 11:56:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=+WKocQi+fVCxqzWsFLYGJL7udht10qEyhti+mMSoK38=;
 b=pEFTw1bpl0PaZnmFW25tB5LfSMtmfv2CAtArRTPHp6h3iRkMiJwoTYo1JoRlcqTjkcmY
 O0tkKTnXVKqmXSO8WViX7Dr8K67qIkTnyrALRVct1vi1m3q0SwGkKzLYXpSJhTlIcfhj
 rrR2uC5r2u4uhl290I048GdaFbdlFuIN//iwzRhJJqNkeKjSc86crVkp3IjUIpN+rFhr
 4iamTgdEPJNjy4x5NzzxiXiyIuNvEFnBf4+WI0ntMAXPV5JqmQVTRjIPQzTs3QicrUVI
 zsghJQ9ZjTrT7HasAl97eDx/conjixw9qlYTb43LOW/be4ahHE/ZDHiMU/L/+NCs4Otm OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxvqdq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 11:56:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 273CA100038;
        Tue,  8 Oct 2019 11:56:21 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AC742B40AD;
        Tue,  8 Oct 2019 11:56:21 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:21 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:20 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V7 2/3] mmc: mmci: add busy_complete callback
Date:   Tue, 8 Oct 2019 11:56:03 +0200
Message-ID: <20191008095604.20675-3-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
References: <20191008095604.20675-1-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds busy_completion callback at mmci_host_ops
to allow to define a specific busy completion by variant.

The legacy code corresponding to busy completion used
by ux500 variants is moved to ux500_busy_complete function.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 134 +++++++++++++++++++++-------------------
 drivers/mmc/host/mmci.h |   1 +
 2 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ed0b40287dea..5e53f9b6d82a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -44,6 +44,7 @@
 #define DRIVER_NAME "mmci-pl18x"
 
 static void mmci_variant_init(struct mmci_host *host);
+static void ux500_variant_init(struct mmci_host *host);
 static void ux500v2_variant_init(struct mmci_host *host);
 
 static unsigned int fmax = 515633;
@@ -184,7 +185,7 @@ static struct variant_data variant_ux500 = {
 	.irq_pio_mask		= MCI_IRQ_PIO_MASK,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
-	.init			= mmci_variant_init,
+	.init			= ux500_variant_init,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -610,6 +611,67 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
 	return MCI_DPSM_ENABLE | (host->data->blksz << 16);
 }
 
+static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
+{
+	void __iomem *base = host->base;
+
+	/*
+	 * Before unmasking for the busy end IRQ, confirm that the
+	 * command was sent successfully. To keep track of having a
+	 * command in-progress, waiting for busy signaling to end,
+	 * store the status in host->busy_status.
+	 *
+	 * Note that, the card may need a couple of clock cycles before
+	 * it starts signaling busy on DAT0, hence re-read the
+	 * MMCISTATUS register here, to allow the busy bit to be set.
+	 * Potentially we may even need to poll the register for a
+	 * while, to allow it to be set, but tests indicates that it
+	 * isn't needed.
+	 */
+	if (!host->busy_status && !(status & err_msk) &&
+	    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		writel(readl(base + MMCIMASK0) |
+		       host->variant->busy_detect_mask,
+		       base + MMCIMASK0);
+
+		host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
+		return false;
+	}
+
+	/*
+	 * If there is a command in-progress that has been successfully
+	 * sent, then bail out if busy status is set and wait for the
+	 * busy end IRQ.
+	 *
+	 * Note that, the HW triggers an IRQ on both edges while
+	 * monitoring DAT0 for busy completion, but there is only one
+	 * status bit in MMCISTATUS for the busy state. Therefore
+	 * both the start and the end interrupts needs to be cleared,
+	 * one after the other. So, clear the busy start IRQ here.
+	 */
+	if (host->busy_status &&
+	    (status & host->variant->busy_detect_flag)) {
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+		return false;
+	}
+
+	/*
+	 * If there is a command in-progress that has been successfully
+	 * sent and the busy bit isn't set, it means we have received
+	 * the busy end IRQ. Clear and mask the IRQ, then continue to
+	 * process the command.
+	 */
+	if (host->busy_status) {
+		writel(host->variant->busy_detect_mask, base + MMCICLEAR);
+
+		writel(readl(base + MMCIMASK0) &
+		       ~host->variant->busy_detect_mask, base + MMCIMASK0);
+		host->busy_status = 0;
+	}
+
+	return true;
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -953,9 +1015,16 @@ static void mmci_variant_init(struct mmci_host *host)
 	host->ops = &mmci_variant_ops;
 }
 
+static void ux500_variant_init(struct mmci_host *host)
+{
+	host->ops = &mmci_variant_ops;
+	host->ops->busy_complete = ux500_busy_complete;
+}
+
 static void ux500v2_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
+	host->ops->busy_complete = ux500_busy_complete;
 	host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
 }
 
@@ -1235,68 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		return;
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
-	if (busy_resp && host->variant->busy_detect) {
-
-		/*
-		 * Before unmasking for the busy end IRQ, confirm that the
-		 * command was sent successfully. To keep track of having a
-		 * command in-progress, waiting for busy signaling to end,
-		 * store the status in host->busy_status.
-		 *
-		 * Note that, the card may need a couple of clock cycles before
-		 * it starts signaling busy on DAT0, hence re-read the
-		 * MMCISTATUS register here, to allow the busy bit to be set.
-		 * Potentially we may even need to poll the register for a
-		 * while, to allow it to be set, but tests indicates that it
-		 * isn't needed.
-		 */
-		if (!host->busy_status && !(status & err_msk) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
-
-			writel(readl(base + MMCIMASK0) |
-			       host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-
-			host->busy_status =
-				status & (MCI_CMDSENT|MCI_CMDRESPEND);
-			return;
-		}
-
-		/*
-		 * If there is a command in-progress that has been successfully
-		 * sent, then bail out if busy status is set and wait for the
-		 * busy end IRQ.
-		 *
-		 * Note that, the HW triggers an IRQ on both edges while
-		 * monitoring DAT0 for busy completion, but there is only one
-		 * status bit in MMCISTATUS for the busy state. Therefore
-		 * both the start and the end interrupts needs to be cleared,
-		 * one after the other. So, clear the busy start IRQ here.
-		 */
-		if (host->busy_status &&
-		    (status & host->variant->busy_detect_flag)) {
-			writel(host->variant->busy_detect_mask,
-			       host->base + MMCICLEAR);
+	if (busy_resp && host->variant->busy_detect)
+		if (!host->ops->busy_complete(host, status, err_msk))
 			return;
-		}
-
-		/*
-		 * If there is a command in-progress that has been successfully
-		 * sent and the busy bit isn't set, it means we have received
-		 * the busy end IRQ. Clear and mask the IRQ, then continue to
-		 * process the command.
-		 */
-		if (host->busy_status) {
-
-			writel(host->variant->busy_detect_mask,
-			       host->base + MMCICLEAR);
-
-			writel(readl(base + MMCIMASK0) &
-			       ~host->variant->busy_detect_mask,
-			       base + MMCIMASK0);
-			host->busy_status = 0;
-		}
-	}
 
 	host->cmd = NULL;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d8b7f6774e8f..2a0b98f98c36 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -369,6 +369,7 @@ struct mmci_host_ops {
 	void (*dma_error)(struct mmci_host *host);
 	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
 	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
+	bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
 };
 
 struct mmci_host {
-- 
2.17.1

