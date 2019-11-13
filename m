Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45FAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58646206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XHQBKkOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKMRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:25:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1780 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfKMRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:25:44 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADHMA1i002755;
        Wed, 13 Nov 2019 18:25:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=8jtImWavCrw85wxjiK84rn3kDNWNi5jgBLEtUg33Spo=;
 b=XHQBKkOM82F7cd0cUFcxuRXBJxe+owe/lgMT1KfYbk40byD1Xl9Bm0qZadrWGqwOgDQS
 7TQ4GGkDrSYy8+i/G8Y89p10QQpznyl3pOIEEAN/tdZK0Wi85+5wen3kHRJLzcGoso5N
 zMXTS4+oRUMxdo7Tq14aGPlD0161SdB7rA96dSpflsiL/2OVbViOYkRY9Y2ASucsjbeT
 sDLx3rh4EAzI7W9UnulU5vSeHeSre0V5WXwiovLORWc6ct116U3jmFDt6+pHcvFVS/Yr
 nbClOJFbIgF+w7CqLMTO+2llSeZEnGjbsacGAO9Y3iHA3sSEnfnt1zOApjPtXbjkZWXV 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psb9g09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 18:25:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7393910002A;
        Wed, 13 Nov 2019 18:25:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 613B12BA7D0;
        Wed, 13 Nov 2019 18:25:28 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 18:25:27 +0100
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
Subject: [PATCH 1/1] mmc: mmci: add threaded irq to abort DPSM of non-functional state
Date:   Wed, 13 Nov 2019 18:25:14 +0100
Message-ID: <20191113172514.19052-1-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_04:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

If datatimeout occurs on R1B request, the Data Path State Machine stays
in busy and is non-functional. Only a reset aborts the DPSM.

Like a reset must be outside of critical section, this patch adds
threaded irq function to release state machine. In this case,
the mmc_request_done is called at the end of threaded irq and
skipped into irq handler.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e72c30ea84..ec6e249c87ca 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
+	if (host->irq_action == IRQ_WAKE_THREAD)
+		return;
+
 	writel(0, host->base + MMCICOMMAND);
 
 	BUG_ON(host->data);
@@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
 		cmd->error = -ETIMEDOUT;
+		host->irq_action = IRQ_WAKE_THREAD;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
 	u32 status;
-	int ret = 0;
 
 	spin_lock(&host->lock);
+	host->irq_action = IRQ_HANDLED;
 
 	do {
 		status = readl(host->base + MMCISTATUS);
@@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
-		ret = 1;
 	} while (status);
 
 	spin_unlock(&host->lock);
 
-	return IRQ_RETVAL(ret);
+	return host->irq_action;
+}
+
+/*
+ * mmci_irq_threaded is call if the mmci host need to release state machines
+ * before to terminate the request.
+ * If datatimeout occurs on R1B request, the Data Path State Machine stays
+ * in busy and is non-functional. Only a reset can to abort the DPSM.
+ */
+static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
+{
+	struct mmci_host *host = dev_id;
+	unsigned long flags;
+
+	if (host->rst) {
+		reset_control_assert(host->rst);
+		udelay(2);
+		reset_control_deassert(host->rst);
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+	writel(host->clk_reg, host->base + MMCICLOCK);
+	writel(host->pwr_reg, host->base + MMCIPOWER);
+	writel(MCI_IRQENABLE | host->variant->start_err,
+	       host->base + MMCIMASK0);
+
+	host->irq_action = IRQ_HANDLED;
+	mmci_request_end(host, host->mrq);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return host->irq_action;
 }
 
 static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
-	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
-			DRIVER_NAME " (cmd)", host);
+	ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], mmci_irq,
+					mmci_irq_threaded, IRQF_SHARED,
+					DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto clk_disable;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 158e1231aa23..5e63c0596364 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -412,6 +412,7 @@ struct mmci_host {
 
 	struct timer_list	timer;
 	unsigned int		oldstat;
+	u32			irq_action;
 
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
-- 
2.17.1

