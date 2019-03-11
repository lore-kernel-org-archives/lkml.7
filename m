Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DF62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCKFlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:41:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24782 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbfCKFlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:41:23 -0400
X-UUID: 68ffc28792fe44c69066f10b7a1c3793-20190311
X-UUID: 68ffc28792fe44c69066f10b7a1c3793-20190311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 157929164; Mon, 11 Mar 2019 13:41:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 13:41:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 13:41:10 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH v6 4/6] i2c: mediatek: Add i2c and apdma sync in i2c driver
Date:   Mon, 11 Mar 2019 13:40:38 +0800
Message-ID: <1552282840-12778-5-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
References: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 59F907CC2C80A94B60F21362E48223A79055842444E5E5838767CF9DFCEB56B72000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i2c and apdma use different source clocks, we should enable
synchronization between them.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 1a7235e..6137ad7 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -77,6 +77,8 @@
 #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
 #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
 #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
+#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
+#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
 #define I2C_CONTROL_WRAPPER             (0x1 << 0)
 
 #define I2C_DRV_NAME		"i2c-mt65xx"
@@ -169,6 +171,7 @@ struct mtk_i2c_compatible {
 	unsigned char aux_len_reg: 1;
 	unsigned char support_33bits: 1;
 	unsigned char timing_adjust: 1;
+	unsigned char dma_sync: 1;
 };
 
 struct mtk_i2c {
@@ -218,6 +221,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 1,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6577_compat = {
@@ -229,6 +233,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt6589_compat = {
@@ -240,6 +245,7 @@ struct mtk_i2c {
 	.aux_len_reg = 0,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt7622_compat = {
@@ -251,6 +257,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 0,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct mtk_i2c_compatible mt8173_compat = {
@@ -261,6 +268,7 @@ struct mtk_i2c {
 	.aux_len_reg = 1,
 	.support_33bits = 1,
 	.timing_adjust = 0,
+	.dma_sync = 0,
 };
 
 static const struct of_device_id mtk_i2c_of_match[] = {
@@ -360,6 +368,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
 
 	control_reg = I2C_CONTROL_ACKERR_DET_EN |
 		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
+	if (i2c->dev_comp->dma_sync)
+		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
+
 	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
 	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
 
-- 
1.7.9.5

