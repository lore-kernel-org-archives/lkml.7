Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6272C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A059B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vDXfFgVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfJKNPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:15:44 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7682 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727909AbfJKNPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:15:42 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BD6ljb021876;
        Fri, 11 Oct 2019 15:15:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=PQgs8CoqvM995ovl1uQ7tJ5NlLE2fITGlZC6osBYYt8=;
 b=vDXfFgVo1O2lnmvawKkSumMa9e+ROwcNsmkLeb1Z+o/dVjBSjFPMT/uAYYzUblXiRBvk
 2mA896h+9ObTJywMzlzAKMKYr4TAWnOtJElFTLQz2wCsVpDW4mqxfPOJq6wqwRiU1EA5
 lXk0ZWrNBdOU1x+GQJi44utEkdnyC6rE5EAGgM4zl+0EkXD/fmS2WXausslvklcjxt7M
 tbpMqYblYChW3lu/Om8OlO5YRNurZk2CLGmRGFkcegx9P0JeqE8hffUWbJFH44zm+84A
 WZoePXBNsJXXYmo8s2pSKmE4Uu48GdDjviIKhmT7cGeuJp+e+EpnvRYGELg9JfnWIVES oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxw9yan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 15:15:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A32C10002A;
        Fri, 11 Oct 2019 15:15:32 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AEF72BEC72;
        Fri, 11 Oct 2019 15:15:32 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:32 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:31 +0200
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
Subject: [PATCH 2/2] mmc: mmci: add unstuck feature
Date:   Fri, 11 Oct 2019 15:15:02 +0200
Message-ID: <20191011131502.29579-3-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011131502.29579-1-ludovic.Barre@st.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

On busy_timeout feature if busy is too long on R1B command
a datatimeout occurs and a specific actions is needed to clear
the DPSM bit:
-reset the controller to clear the DPSM bit.
-restore registers: clk, pwr, datactrl.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e72c30ea84..dafba4e0afc5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1320,7 +1320,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -EILSEQ;
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
-		cmd->error = -ETIMEDOUT;
+		cmd->error = -EDEADLK;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1332,7 +1332,6 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		if (host->data) {
 			/* Terminate the DMA transfer */
 			mmci_dma_error(host);
-
 			mmci_stop_data(host);
 			if (host->variant->cmdreg_stop && cmd->error) {
 				mmci_stop_command(host);
@@ -1787,6 +1786,25 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static void mmci_hw_unstuck(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
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
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
@@ -1795,6 +1813,7 @@ static struct mmc_host_ops mmci_ops = {
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmci_get_cd,
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
+	.hw_unstuck	= mmci_hw_unstuck,
 };
 
 static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
-- 
2.17.1

