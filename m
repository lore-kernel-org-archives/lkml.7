Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB936C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDB72089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128336;
	bh=Tbto7VOcWpcp4JkzBUhDKCdWw3GZzcbMR6by2PWFsaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFwM9HjyRmgkg8Ssw/HNaObIYuzbHK7EdZjD0xaThMEeSqn7MSvZyZramDZLaj38Z
	 rSOaAJ7f/cib9VhEmcS/LjvlvczOBOTT1WoyQq0+owKwtC57fSOP9R5xZl/B8oU6C7
	 QMcD6wqak5Kst897kO2Gm+qS3/Ih/X0JgOYtY9v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbfDXR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390591AbfDXR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:05 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34825206BA;
        Wed, 24 Apr 2019 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126883;
        bh=Tbto7VOcWpcp4JkzBUhDKCdWw3GZzcbMR6by2PWFsaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuqzgkObswXfrRJeMhlik8fNyPBcVjTuzAzabuT4bKhd4OY1ZCRXi+vgmDU3IQwli
         SutbNABdYMUMNN5K12SGuDjuMXpKzRU+9QW+Ua9OOWV6Ogr1Dl4K6moFE0EhvMylor
         nmNXtGBGVAkyq2Lpl7llGHBdyfrMwrvBgL/Nalz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 51/70] mmc: sdhci: Handle auto-command errors
Date:   Wed, 24 Apr 2019 19:10:11 +0200
Message-Id: <20190424170916.907286525@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
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
index 8abbe40a9a05..9540fda7fc6b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -790,6 +790,11 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
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
@@ -2560,6 +2565,21 @@ static void sdhci_timeout_data_timer(unsigned long data)
 
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
@@ -2594,6 +2614,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
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
index 860b2c729e68..c0d5458c36d4 100644
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



