Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C62084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCKFli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:41:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33688 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbfCKFlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:41:25 -0400
X-UUID: f5542a9f09c54a52a44b31efa48f8db8-20190311
X-UUID: f5542a9f09c54a52a44b31efa48f8db8-20190311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 680816167; Mon, 11 Mar 2019 13:41:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 13:41:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 13:41:11 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH v6 5/6] i2c: mediatek: Add i2c support for MediaTek MT8183
Date:   Mon, 11 Mar 2019 13:40:39 +0800
Message-ID: <1552282840-12778-6-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2c compatible for MT8183. Compare to MT2712 i2c controller,
MT8183 has different register offsets. Ltiming_reg is added to
adjust low width of SCL. Arb clock and dma_sync are needed.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c |   62 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 6137ad7..745b0d0 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -133,6 +133,7 @@ enum I2C_REGS_OFFSET {
 	OFFSET_DEBUGCTRL,
 	OFFSET_TRANSFER_LEN_AUX,
 	OFFSET_CLOCK_DIV,
+	OFFSET_LTIMING,
 };
 
 static const u16 mt_i2c_regs_v1[] = {
@@ -162,6 +163,32 @@ enum I2C_REGS_OFFSET {
 	[OFFSET_CLOCK_DIV] = 0x70,
 };
 
+static const u16 mt_i2c_regs_v2[] = {
+	[OFFSET_DATA_PORT] = 0x0,
+	[OFFSET_SLAVE_ADDR] = 0x4,
+	[OFFSET_INTR_MASK] = 0x8,
+	[OFFSET_INTR_STAT] = 0xc,
+	[OFFSET_CONTROL] = 0x10,
+	[OFFSET_TRANSFER_LEN] = 0x14,
+	[OFFSET_TRANSAC_LEN] = 0x18,
+	[OFFSET_DELAY_LEN] = 0x1c,
+	[OFFSET_TIMING] = 0x20,
+	[OFFSET_START] = 0x24,
+	[OFFSET_EXT_CONF] = 0x28,
+	[OFFSET_LTIMING] = 0x2c,
+	[OFFSET_HS] = 0x30,
+	[OFFSET_IO_CONFIG] = 0x34,
+	[OFFSET_FIFO_ADDR_CLR] = 0x38,
+	[OFFSET_TRANSFER_LEN_AUX] = 0x44,
+	[OFFSET_CLOCK_DIV] = 0x48,
+	[OFFSET_SOFTRESET] = 0x50,
+	[OFFSET_DEBUGSTAT] = 0xe0,
+	[OFFSET_DEBUGCTRL] = 0xe8,
+	[OFFSET_FIFO_STAT] = 0xf4,
+	[OFFSET_FIFO_THRESH] = 0xf8,
+	[OFFSET_DCM_EN] = 0xf88,
+};
+
 struct mtk_i2c_compatible {
 	const struct i2c_adapter_quirks *quirks;
 	const u16 *regs;
@@ -172,6 +199,7 @@ struct mtk_i2c_compatible {
 	unsigned char support_33bits: 1;
 	unsigned char timing_adjust: 1;
 	unsigned char dma_sync: 1;
+	unsigned char ltiming_adjust: 1;
 };
 
 struct mtk_i2c {
@@ -195,6 +223,7 @@ struct mtk_i2c {
 	enum mtk_trans_op op;
 	u16 timing_reg;
 	u16 high_speed_reg;
+	u16 ltiming_reg;
 	unsigned char auto_restart;
 	bool ignore_restart_irq;
 	const struct mtk_i2c_compatible *dev_comp;
@@ -222,6 +251,7 @@ struct mtk_i2c {
 	.support_33bits = 1,
 	.timing_adjust = 1,
 	.dma_sync = 0,
+	.ltiming_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt6577_compat = {
@@ -234,6 +264,7 @@ struct mtk_i2c {
 	.support_33bits = 0,
 	.timing_adjust = 0,
 	.dma_sync = 0,
+	.ltiming_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -246,6 +277,7 @@ struct mtk_i2c {
 	.support_33bits = 0,
 	.timing_adjust = 0,
 	.dma_sync = 0,
+	.ltiming_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt7622_compat = {
@@ -258,6 +290,7 @@ struct mtk_i2c {
 	.support_33bits = 0,
 	.timing_adjust = 0,
 	.dma_sync = 0,
+	.ltiming_adjust = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -269,6 +302,19 @@ struct mtk_i2c {
 	.support_33bits = 1,
 	.timing_adjust = 0,
 	.dma_sync = 0,
+	.ltiming_adjust = 0,
+};
+
+static const struct mtk_i2c_compatible mt8183_compat = {
+	.regs = mt_i2c_regs_v2,
+	.pmic_i2c = 0,
+	.dcm = 0,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.support_33bits = 1,
+	.timing_adjust = 1,
+	.dma_sync = 1,
+	.ltiming_adjust = 1,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -277,6 +323,7 @@ struct mtk_i2c {
 	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
 	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
+	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
@@ -361,6 +408,8 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 
 	mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
 	mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
+	if (i2c->dev_comp->ltiming_adjust)
+		mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);
 
 	/* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
 	if (i2c->have_pmic)
@@ -460,6 +509,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 	unsigned int clk_src;
 	unsigned int step_cnt;
 	unsigned int sample_cnt;
+	unsigned int l_step_cnt;
+	unsigned int l_sample_cnt;
 	unsigned int target_speed;
 	int ret;
 
@@ -469,11 +520,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 	if (target_speed > MAX_FS_MODE_SPEED) {
 		/* Set master code speed register */
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
-					      &step_cnt, &sample_cnt);
+					      &l_step_cnt, &l_sample_cnt);
 		if (ret < 0)
 			return ret;
 
-		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
+		i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
 
 		/* Set the high speed mode register */
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
@@ -483,6 +534,10 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 
 		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
 			(sample_cnt << 12) | (step_cnt << 8);
+
+		if (i2c->dev_comp->ltiming_adjust)
+			i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
+					   (sample_cnt << 12) | (step_cnt << 9);
 	} else {
 		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
 					      &step_cnt, &sample_cnt);
@@ -493,6 +548,9 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
 
 		/* Disable the high speed transaction */
 		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
+
+		if (i2c->dev_comp->ltiming_adjust)
+			i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
 	}
 
 	return 0;
-- 
1.7.9.5

