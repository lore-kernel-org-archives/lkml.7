Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D38C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F47F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Ux8kZ65k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDZHrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:47:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46474 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbfDZHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:47:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q7fq4h006576;
        Fri, 26 Apr 2019 09:46:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=GoDpApWVqjvmatuiwcrcqafX/zB0q4mq+rKlGGv6JV4=;
 b=Ux8kZ65kfiSxUWm6rCPyuxitXjnL/tkL4AQUmnlTxdoPDVhj31hdozgGTwUTOwQKFq65
 LSZlhXvleWH+rTN2SUqHKEeObJNQssNC9/Q4PB0FCZgyeBm55nNPC46ZLunhG8CiZzmY
 gjo7q8ttFSTu0K/bosaHGXEVAWdw+ij3/+hf3saX7TKKyhfBHJ3+DNlvzVoVZmOMmBiS
 kamhXv0KVD2m9ovlUpEJFP+ahR03LMB5E4oVsr+QuBXHgyo1smPWRRBgTGV+lDGrRQ7H
 llZSC/W9gPJ8rfqVkEIA+Nt8ub9gMcwNjEm2U5GR2tmSIVy/bsruPOBDbnLsH9xy7hAh mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadjmnf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 09:46:53 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2A3FC49;
        Fri, 26 Apr 2019 07:46:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A381013CB;
        Fri, 26 Apr 2019 07:46:51 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 26 Apr
 2019 09:46:51 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Apr
 2019 09:46:51 +0200
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
Subject: [PATCH V2 4/5] mmc: mmci: add hardware busy timeout feature
Date:   Fri, 26 Apr 2019 09:46:37 +0200
Message-ID: <1556264798-18540-5-git-send-email-ludovic.Barre@st.com>
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

In some variants, the data timer is enabled when the DPSM is in
busy state (while data transfert or MMC_RSP_BUSY), and could
generate a data timeout error if the counter reach 0.

-Define max_busy_timeout (in ms) according to clock.
-Set data timer register if the command has rsp_busy flag.
 If busy_timeout is not defined by framework, the busy
 length after Data Burst is defined as 1 second
 (refer: 4.6.2.2 Write of sd specification part1 v6-0).
-Add MCI_DATATIMEOUT error management in mmci_cmd_irq.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 43 ++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3cd52e8..8dcb980 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1078,6 +1078,7 @@ static void
 mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
+	unsigned long long clks = 0;
 
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
@@ -1100,6 +1101,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		else
 			c |= host->variant->cmdreg_srsp;
 	}
+
+	if (host->variant->busy_timeout && !cmd->data) {
+		if (cmd->flags & MMC_RSP_BUSY) {
+			if (!cmd->busy_timeout)
+				cmd->busy_timeout = 1000;
+
+			clks = (unsigned long long)cmd->busy_timeout;
+			clks *=	host->cclk;
+			do_div(clks, MSEC_PER_SEC);
+		}
+		writel_relaxed(clks, host->base + MMCIDATATIMER);
+	}
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1206,6 +1220,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 {
 	void __iomem *base = host->base;
 	bool sbc, busy_resp;
+	u32 err_msk;
 
 	if (!cmd)
 		return;
@@ -1218,8 +1233,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	 * handling. Note that we tag on any latent IRQs postponed
 	 * due to waiting for busy status.
 	 */
-	if (!((status|host->busy_status) &
-	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
+	err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
+	if (host->variant->busy_timeout && busy_resp)
+		err_msk |= MCI_DATATIMEOUT;
+
+	if (!((status | host->busy_status) &
+	      (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
 		return;
 
 	/*
@@ -1228,7 +1247,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
-		if (host->busy_status &&
+		if (host->busy_status && !(status & (err_msk)) &&
 		    (status & host->variant->busy_detect_flag))
 			return;
 
@@ -1238,9 +1257,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status &&
-		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		if (!host->busy_status && !(status & (err_msk)) &&
+		    (readl(base + MMCISTATUS) &
+		     host->variant->busy_detect_flag)) {
 
 			/* Clear the busy start IRQ */
 			writel(host->variant->busy_detect_mask,
@@ -1282,6 +1301,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else if (host->variant->busy_timeout && busy_resp &&
+		   status & MCI_DATATIMEOUT) {
+		cmd->error = -ETIMEDOUT;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1543,6 +1565,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
+
 	} while (status);
 
 	spin_unlock(&host->lock);
@@ -1947,6 +1970,8 @@ static int mmci_probe(struct amba_device *dev,
 	 * Enable busy detection.
 	 */
 	if (variant->busy_detect) {
+		u32 max_busy_timeout = 0;
+
 		mmci_ops.card_busy = mmci_card_busy;
 		/*
 		 * Not all variants have a flag to enable busy detection
@@ -1956,7 +1981,11 @@ static int mmci_probe(struct amba_device *dev,
 			mmci_write_datactrlreg(host,
 					       host->variant->busy_dpsm_flag);
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
-		mmc->max_busy_timeout = 0;
+
+		if (variant->busy_timeout)
+			max_busy_timeout = ~0UL / (mmc->f_max / MSEC_PER_SEC);
+
+		mmc->max_busy_timeout = max_busy_timeout;
 	}
 
 	/* Prepare a CMD12 - needed to clear the DPSM on some variants. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4f071bd..b43a958 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -290,6 +290,7 @@ struct mmci_host;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_timeout: true if the variant supports hardware busy timeout on R1B.
  * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
  * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
  *		      indicating that the card is busy
@@ -336,6 +337,7 @@ struct variant_data {
 	u8			signal_direction:1;
 	u8			pwrreg_clkgate:1;
 	u8			busy_detect:1;
+	u8			busy_timeout:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-- 
2.7.4

