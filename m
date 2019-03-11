Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5341C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0782084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfCKDs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:48:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41264 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727041AbfCKDsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:48:25 -0400
X-UUID: 6e0c2be5f12e4778b57297680578e052-20190311
X-UUID: 6e0c2be5f12e4778b57297680578e052-20190311
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1842584796; Mon, 11 Mar 2019 11:48:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 11:48:08 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 11:48:09 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ran Bi <ran.bi@mediatek.com>
Subject: [PATCH v2 9/9] rtc: Add support for the MediaTek MT6358 RTC
Date:   Mon, 11 Mar 2019 11:46:31 +0800
Message-ID: <1552275991-34648-10-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 940FE17246965C8CCC8881607C3F0EE8685B22C125EC05FBADDFF8DE90F0C90C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Bi <ran.bi@mediatek.com>

This add support for the MediaTek MT6358 RTC. MT6397 mfd will pass
RTC_WRTGR address offset to RTC driver.

Signed-off-by: Ran Bi <ran.bi@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index f85f1fc..c8a0090 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -27,7 +27,7 @@
 #define RTC_BBPU		0x0000
 #define RTC_BBPU_CBUSY		BIT(6)
 
-#define RTC_WRTGR		0x003c
+#define RTC_WRTGR_DEFAULT	0x003c
 
 #define RTC_IRQ_STA		0x0002
 #define RTC_IRQ_STA_AL		BIT(0)
@@ -78,6 +78,7 @@ struct mt6397_rtc {
 	struct regmap		*regmap;
 	int			irq;
 	u32			addr_base;
+	u32			wrtgr_offset;
 };
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
@@ -86,7 +87,8 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 	int ret;
 	u32 data;
 
-	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
+	ret = regmap_write(rtc->regmap,
+			   rtc->addr_base + rtc->wrtgr_offset, 1);
 	if (ret < 0)
 		return ret;
 
@@ -341,6 +343,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->addr_base = res->start;
 
+	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (res) {
+		rtc->wrtgr_offset = res->start;
+		dev_info(&pdev->dev, "register offset:%d\n", rtc->wrtgr_offset);
+	} else {
+		rtc->wrtgr_offset = RTC_WRTGR_DEFAULT;
+		dev_err(&pdev->dev, "Failed to get register offset\n");
+	}
+
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0)
 		return rtc->irq;
@@ -420,6 +431,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
 			mt6397_rtc_resume);
 
 static const struct of_device_id mt6397_rtc_of_match[] = {
+	{ .compatible = "mediatek,mt6358-rtc", },
 	{ .compatible = "mediatek,mt6397-rtc", },
 	{ }
 };
-- 
1.9.1

