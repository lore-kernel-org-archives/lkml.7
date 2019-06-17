Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A6C31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3C20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfFQLE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:04:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11867 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726164AbfFQLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:04:27 -0400
X-UUID: b6d4cb7dd89a4b7fbaef042d397fbd85-20190617
X-UUID: b6d4cb7dd89a4b7fbaef042d397fbd85-20190617
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jjian.zhou@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1232003957; Mon, 17 Jun 2019 19:04:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Jun 2019 19:04:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Jun 2019 19:04:12 +0800
From:   Jjian Zhou <jjian.zhou@mediatek.com>
To:     <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
        <matthias.bgg@gmail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yong.mao@mediatek.com>, <srv_heupstream@mediatek.com>,
        jjian zhou <jjian.zhou@mediatek.com>
Subject: [PATCH V2 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
Date:   Mon, 17 Jun 2019 19:04:07 +0800
Message-ID: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

SDIO IRQ is triggered by low level. It need disable SDIO IRQ
detected function. Otherwise the interrupt register can't be cleared.
It will process the interrupt more.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c518cc2..fa7d420 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1383,24 +1383,25 @@ static void msdc_request_timeout(struct work_struct *work)
 	}
 }

-static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
 {
-	unsigned long flags;
-	struct msdc_host *host = mmc_priv(mmc);
-
-	spin_lock_irqsave(&host->lock, flags);
-	if (enb)
+	if (enb) {
 		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-	else
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	} else {
 		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-	spin_unlock_irqrestore(&host->lock, flags);
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	}
 }

 static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 {
+	unsigned long flags;
 	struct msdc_host *host = mmc_priv(mmc);

-	__msdc_enable_sdio_irq(mmc, enb);
+	spin_lock_irqsave(&host->lock, flags);
+	__msdc_enable_sdio_irq(host, enb);
+	spin_unlock_irqrestore(&host->lock, flags);

 	if (enb)
 		pm_runtime_get_noresume(host->dev);
@@ -1422,6 +1423,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		spin_lock_irqsave(&host->lock, flags);
 		events = readl(host->base + MSDC_INT);
 		event_mask = readl(host->base + MSDC_INTEN);
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
+			__msdc_enable_sdio_irq(host, 0);
 		/* clear interrupts */
 		writel(events & event_mask, host->base + MSDC_INT);

@@ -1430,10 +1433,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		data = host->data;
 		spin_unlock_irqrestore(&host->lock, flags);

-		if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
-			__msdc_enable_sdio_irq(host->mmc, 0);
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
 			sdio_signal_irq(host->mmc);
-		}

 		if ((events & event_mask) & MSDC_INT_CDSC) {
 			if (host->internal_cd)
@@ -1572,10 +1573,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);

 	/* Config SDIO device detect interrupt function */
-	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
-		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-	else
-		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
@@ -2103,7 +2101,12 @@ static void msdc_hw_reset(struct mmc_host *mmc)

 static void msdc_ack_sdio_irq(struct mmc_host *mmc)
 {
-	__msdc_enable_sdio_irq(mmc, 1);
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+	__msdc_enable_sdio_irq(host, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
 }

 static int msdc_get_cd(struct mmc_host *mmc)
--
1.9.1

