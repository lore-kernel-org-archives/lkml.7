Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5B821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127988;
	bh=adpl9U5/cJrbRawGhvQLQOPZNPKkNOgroLkj2pwstw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khbAK9Wh6mBnunrD2usB0bYdqIg1q/CzijyLoBOrFnTqDhnVWEWBpsK6LBAME+Wg3
	 BTywPMw0/hSkARhO4wCyXsA01c8vRDPiOM829fvHqt1bxkP/yzTe/X+cXmrNqKNA93
	 SqCbTqGxxnOC4tdeyt8as9un4lKSuI81FXbAVl8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391443AbfDXRq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391363AbfDXRcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:39 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C841A2054F;
        Wed, 24 Apr 2019 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127158;
        bh=adpl9U5/cJrbRawGhvQLQOPZNPKkNOgroLkj2pwstw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXJhtcHpBCLcwmW1kNpKjlxWFeCAb9tu7YwW7HKue/Gxqp1VLrDRhG8X5xSmBkuYv
         uD7c6GfkK6QQSxToIzAALncKvpl5BDvP/ylq/sqJFnM6P2XB3SWkh6xE00IhrrqdFu
         o73C5+PYw70SJT9fQ8qahpGQHJt8VzmqIHSwTALw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 83/96] mmc: sdhci: Handle auto-command errors
Date:   Wed, 24 Apr 2019 19:10:28 +0200
Message-Id: <20190424170925.419866103@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit af849c86109d79222e549826068bbf4e7f9a2472 ]

If the host controller supports auto-commands then enable the auto-command
error interrupt and handle it. In the case of auto-CMD23, the error is
treated the same as manual CMD23 error. In the case of auto-CMD12,
commands-during-transfer are not permitted, so the error handling is
treated the same as a data error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  7 ++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0eb05a42a857..c749d3dc1d36 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -841,6 +841,11 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	else
 		host->ier = (host->ier & ~dma_irqs) | pio_irqs;
 
+	if (host->flags & (SDHCI_AUTO_CMD23 | SDHCI_AUTO_CMD12))
+		host->ier |= SDHCI_INT_AUTO_CMD_ERR;
+	else
+		host->ier &= ~SDHCI_INT_AUTO_CMD_ERR;
+
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
@@ -2642,6 +2647,21 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 {
+	/* Handle auto-CMD12 error */
+	if (intmask & SDHCI_INT_AUTO_CMD_ERR && host->data_cmd) {
+		struct mmc_request *mrq = host->data_cmd->mrq;
+		u16 auto_cmd_status = sdhci_readw(host, SDHCI_AUTO_CMD_STATUS);
+		int data_err_bit = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
+				   SDHCI_INT_DATA_TIMEOUT :
+				   SDHCI_INT_DATA_CRC;
+
+		/* Treat auto-CMD12 error the same as data error */
+		if (!mrq->sbc && (host->flags & SDHCI_AUTO_CMD12)) {
+			*intmask_p |= data_err_bit;
+			return;
+		}
+	}
+
 	if (!host->cmd) {
 		/*
 		 * SDHCI recovers from errors by resetting the cmd and data
@@ -2676,6 +2696,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 		return;
 	}
 
+	/* Handle auto-CMD23 error */
+	if (intmask & SDHCI_INT_AUTO_CMD_ERR) {
+		struct mmc_request *mrq = host->cmd->mrq;
+		u16 auto_cmd_status = sdhci_readw(host, SDHCI_AUTO_CMD_STATUS);
+		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
+			  -ETIMEDOUT :
+			  -EILSEQ;
+
+		if (mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+			mrq->sbc->error = err;
+			sdhci_finish_mrq(host, mrq);
+			return;
+		}
+	}
+
 	if (intmask & SDHCI_INT_RESPONSE)
 		sdhci_finish_command(host);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 33a7728c71fa..0f8c4f3ccafc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -151,7 +151,8 @@
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
 #define  SDHCI_INT_CMD_MASK	(SDHCI_INT_RESPONSE | SDHCI_INT_TIMEOUT | \
-		SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
+		SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX | \
+		SDHCI_INT_AUTO_CMD_ERR)
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
@@ -167,6 +168,10 @@
 #define SDHCI_CQE_INT_MASK (SDHCI_CQE_INT_ERR_MASK | SDHCI_INT_CQE)
 
 #define SDHCI_AUTO_CMD_STATUS	0x3C
+#define  SDHCI_AUTO_CMD_TIMEOUT	0x00000002
+#define  SDHCI_AUTO_CMD_CRC	0x00000004
+#define  SDHCI_AUTO_CMD_END_BIT	0x00000008
+#define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
-- 
2.19.1



