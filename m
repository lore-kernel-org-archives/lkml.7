Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B8020449
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfCEQKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:10:30 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30260 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728329AbfCEQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:10:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25G82gf012346;
        Tue, 5 Mar 2019 17:10:10 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgatff5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 17:10:10 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E42734;
        Tue,  5 Mar 2019 16:10:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1371D4DF7;
        Tue,  5 Mar 2019 16:10:10 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 17:10:09 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 17:10:09 +0100
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
Subject: [PATCH  1/4] mmc: mmci: avoid fake busy polling
Date:   Tue, 5 Mar 2019 17:10:02 +0100
Message-ID: <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The busy status bit could occurred even if no busy response is
expected (example cmd11). On sdmmc variant, the busy_detect_flag
reflects inverted value of d0 state, it's sampled at the end of a
CMD response and a second time 2 clk cycles after the CMD response.
To avoid a fake busy, the busy status could be checked and polled
only if the command has RSP_BUSY flag.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..4901b73 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
-	bool sbc;
+	bool sbc, busy_resp;
 
 	if (!cmd)
 		return;
 
 	sbc = (cmd == host->mrq->sbc);
+	busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
 
 	/*
 	 * We need to be one of these interrupts to be considered worth
@@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	/*
 	 * ST Micro variant: handle busy detection.
 	 */
-	if (host->variant->busy_detect) {
-		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
+	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
 		if (host->busy_status &&
@@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status && busy_resp &&
+		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
@@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
 	u32 status;
+	bool busy_resp;
 	int ret = 0;
 
 	spin_lock(&host->lock);
@@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Don't poll for:
+		 * -busy completion in irq context.
+		 * -no busy response expected.
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		busy_resp = host->cmd ?
+			!!(host->cmd->flags & MMC_RSP_BUSY) : false;
+
+		if (host->variant->busy_detect &&
+		    (!busy_resp || host->busy_status))
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.7.4

