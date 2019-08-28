Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF5217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfH1Jpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:45:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51319 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfH1Jpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:45:39 -0400
X-UUID: dbefc3268e924de0aad6bd34d8917f83-20190828
X-UUID: dbefc3268e924de0aad6bd34d8917f83-20190828
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 816270884; Wed, 28 Aug 2019 17:45:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:45:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:45:40 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        yong mao <yong.mao@mediatek.com>
Subject: [PATCH v2] mmc: mediatek: enable SDIO IRQ low level trigger function
Date:   Wed, 28 Aug 2019 17:45:24 +0800
Message-ID: <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566985524-22749-1-git-send-email-yong.mao@mediatek.com>
References: <1566985524-22749-1-git-send-email-yong.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

SDIO IRQ is not defaultly triggered by low level,
but by falling edge. It needs to set related register
to enable SDIO IRQ low level trigger function.
Otherwise the SDIO IRQ may be lost in some specail condition.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b63..585f0c7 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -192,6 +192,7 @@
 #define SDC_STS_CMDBUSY         (0x1 << 1)	/* RW */
 #define SDC_STS_SWR_COMPL       (0x1 << 31)	/* RW */
 
+#define SDC_DAT1_IRQ_TRIGGER	(0x1 << 19)	/* RW */
 /* SDC_ADV_CFG0 mask */
 #define SDC_RX_ENHANCE_EN	(0x1 << 20)	/* RW */
 
@@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	/* Config SDIO device detect interrupt function */
 	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
 
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
-- 
1.9.1

