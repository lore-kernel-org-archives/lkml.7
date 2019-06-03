Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C75C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E189E27AD9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PBhVDBGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfFCPzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:55:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32442 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729430AbfFCPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:55:43 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53Ffkrc011068;
        Mon, 3 Jun 2019 17:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=etA1bRR7f0xtxrGNfl8KQhV4H88uuHhQNEMpJ2vi+mQ=;
 b=PBhVDBGPiiI25H1VtUkAXq517b5hzXRR7DVsSHIQ3qDYyDTKGe5Qzv5XlM9QqL0GYy3e
 RtjV7TYs3fQBw3JtkkLpMqJ3JstDiDlx6dWZGBVsK+/PTqmK7tzxzmMAiseWcZ3LSPCk
 u3VequspPPUQ1bRk/bwPixinvLrBodI3SVYVhSo+JnlPM0Q82uJeVrxYIkOmzoopqw1m
 pUAXkzBl4YlOPyuTLpI5T6w/N26YDU4W+uIUB4PT8kX3cQ8nTfFxEKLMxXt875ffScrJ
 9z2l4pgMINN+h137bje50eE5xFuCKWyBFT5LIKJ/qBPp+h1z2u0RKI0b6dWuf9fScj1z BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sunmc2xs3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 17:55:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9292D31;
        Mon,  3 Jun 2019 15:55:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BDD74E66;
        Mon,  3 Jun 2019 15:55:29 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:29 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:55:28 +0200
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
Subject: [PATCH V3 1/3] mmc: mmci: fix read status for busy detect
Date:   Mon, 3 Jun 2019 17:55:23 +0200
Message-ID: <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

"busy_detect_flag" is used to read & clear busy value of mmci status.
"busy_detect_mask" is used to manage busy irq of mmci mask.
So to read mmci status the busy_detect_flag must be take account.
if the variant does not support busy detect feature the flag is null
and there is no impact.

Not need to re-read the status register in mmci_cmd_irq, the
status parameter can be used.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 356833a..5b5cc45 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1240,7 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 */
 		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		    (status & host->variant->busy_detect_flag)) {
 
 			/* Clear the busy start IRQ */
 			writel(host->variant->busy_detect_mask,
@@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		 * to make sure that both start and end interrupts are always
 		 * cleared one after the other.
 		 */
-		status &= readl(host->base + MMCIMASK0);
+		status &= readl(host->base + MMCIMASK0) |
+			host->variant->busy_detect_flag;
 		if (host->variant->busy_detect)
 			writel(status & ~host->variant->busy_detect_mask,
 			       host->base + MMCICLEAR);
-- 
2.7.4

