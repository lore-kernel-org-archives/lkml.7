Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E56C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C93206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Gg6+GUWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDZHrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:47:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22776 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726454AbfDZHrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:47:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q7k8NL022863;
        Fri, 26 Apr 2019 09:47:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=7BWq+h8VtCHoU3P0ceI2mrTpWNZF2WWtzR24GhXEryM=;
 b=Gg6+GUWg0Y6g9B2ZOeKQWbMpn3gxGlWsZPZtPIHDQek9R1PVgWNDv2M6tOkSvJNpg1o9
 +6iRDlm9mY2bslRaiKIwgXP0F0HR5UumSQTNMtY4CXjMTnm2eHirJtAqYMn+uQwLaa1m
 hlMzphk2tOYQ/W5RyaDYiKY8L5ROgmxR68ibC7YnAFCQHjH/NjiUAI/q5Xe678ww8XNP
 GqdMxh/czx8srYz69x0Sy0E1ipei0ZE3NsreA6KktcnprMgM5hnWEPn9r+G+uVs9C8+m
 V8HGXJw0jsZeXYWoiTrhIGsNa9N6XogV/FZCrunMiu0vPv/9SLCr6xYFpjUTxDX0C4JX iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj6jsx5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 09:47:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCC0441;
        Fri, 26 Apr 2019 07:46:48 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B400E13C2;
        Fri, 26 Apr 2019 07:46:48 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 26 Apr
 2019 09:46:48 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Apr
 2019 09:46:48 +0200
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
Subject: [PATCH V2 1/5] mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
Date:   Fri, 26 Apr 2019 09:46:34 +0200
Message-ID: <1556264798-18540-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch cleans mmci_cmd_irq function for busy detect feature.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e9596a..049f8e3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1205,12 +1205,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
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
@@ -1224,8 +1225,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	/*
 	 * ST Micro variant: handle busy detection.
 	 */
-	if (host->variant->busy_detect) {
-		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
+	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
 		if (host->busy_status &&
@@ -1238,7 +1238,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status && busy_resp &&
+		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
-- 
2.7.4

