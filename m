Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0515C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99C120851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfFNF0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:26:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23345 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfFNF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:26:22 -0400
X-UUID: 2d7c01dfa82c4ee29a17adb5923a69cb-20190614
X-UUID: 2d7c01dfa82c4ee29a17adb5923a69cb-20190614
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jjian.zhou@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1271578018; Fri, 14 Jun 2019 13:26:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Jun 2019 13:26:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Jun 2019 13:26:14 +0800
From:   Jjian Zhou <jjian.zhou@mediatek.com>
To:     <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
        <matthias.bgg@gmail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yong.mao@mediatek.com>, <srv_heupstream@mediatek.com>,
        jjian zhou <jjian.zhou@mediatek.com>
Subject: [PATCH 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
Date:   Fri, 14 Jun 2019 13:26:09 +0800
Message-ID: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
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
 drivers/mmc/host/mtk-sd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c518cc2..29992ae 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1389,10 +1389,12 @@ static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	struct msdc_host *host = mmc_priv(mmc);

 	spin_lock_irqsave(&host->lock, flags);
-	if (enb)
+	if (enb) {
 		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-	else
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	} else {
 		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
+	}
 	spin_unlock_irqrestore(&host->lock, flags);
 }

@@ -1422,6 +1424,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		spin_lock_irqsave(&host->lock, flags);
 		events = readl(host->base + MSDC_INT);
 		event_mask = readl(host->base + MSDC_INTEN);
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
+			sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
 		/* clear interrupts */
 		writel(events & event_mask, host->base + MSDC_INT);

@@ -1572,10 +1576,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);

 	/* Config SDIO device detect interrupt function */
-	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
-		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-	else
-		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
--
1.9.1

