Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7C020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfDBMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:36:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730371AbfDBMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:36:16 -0400
X-UUID: ad22af807a914084be1f1b94ef151c19-20190402
X-UUID: ad22af807a914084be1f1b94ef151c19-20190402
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 203089298; Tue, 02 Apr 2019 20:36:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 20:36:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 20:36:09 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH RESEND v6 3/6] i2c: mediatek: Add arb clock in i2c driver
Date:   Tue, 2 Apr 2019 20:35:57 +0800
Message-ID: <1554208560-14817-4-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F667A60E98AAC97AC6022E4B507BD1DDB4F6965D142566EE88B017C13EC2E8D22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When two i2c controllers are internally connected to the same
GPIO pins, the arb clock is needed to ensure that the waveforms
do not interfere with each other. And we also need to enable
the interrupt to find arb lost, old i2c controllers also have
the bit.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index be36018..1a7235e 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 
 #define I2C_RS_TRANSFER			(1 << 4)
+#define I2C_ARB_LOST			(1 << 3)
 #define I2C_HS_NACKERR			(1 << 2)
 #define I2C_ACKERR			(1 << 1)
 #define I2C_TRANSAC_COMP		(1 << 0)
@@ -181,6 +182,7 @@ struct mtk_i2c {
 	struct clk *clk_main;		/* main clock for i2c bus */
 	struct clk *clk_dma;		/* DMA clock for i2c via DMA */
 	struct clk *clk_pmic;		/* PMIC clock for i2c from PMIC */
+	struct clk *clk_arb;		/* Arbitrator clock for i2c */
 	bool have_pmic;			/* can use i2c pins from PMIC */
 	bool use_push_pull;		/* IO config push-pull mode */
 
@@ -299,8 +301,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
 		if (ret)
 			goto err_pmic;
 	}
+
+	if (i2c->clk_arb) {
+		ret = clk_prepare_enable(i2c->clk_arb);
+		if (ret)
+			goto err_arb;
+	}
+
 	return 0;
 
+err_arb:
+	if (i2c->have_pmic)
+		clk_disable_unprepare(i2c->clk_pmic);
 err_pmic:
 	clk_disable_unprepare(i2c->clk_main);
 err_main:
@@ -311,6 +323,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
 
 static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
 {
+	if (i2c->clk_arb)
+		clk_disable_unprepare(i2c->clk_arb);
+
 	if (i2c->have_pmic)
 		clk_disable_unprepare(i2c->clk_pmic);
 
@@ -519,13 +534,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	/* Clear interrupt status */
 	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
 
 	mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
 
 	/* Enable interrupt */
 	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
 
 	/* Set transfer and transaction len */
 	if (i2c->op == I2C_MASTER_WRRD) {
@@ -659,7 +674,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	/* Clear interrupt mask */
 	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
-	       I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
+			    I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
 
 	if (i2c->op == I2C_MASTER_WR) {
 		dma_unmap_single(i2c->dev, wpaddr,
@@ -884,6 +899,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->clk_dma);
 	}
 
+	i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
+	if (IS_ERR(i2c->clk_arb))
+		i2c->clk_arb = NULL;
+
 	clk = i2c->clk_main;
 	if (i2c->have_pmic) {
 		i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
-- 
1.7.9.5

