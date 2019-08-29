Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F4122CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfH2Bsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:48:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21395 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfH2Bsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:48:31 -0400
X-UUID: cda13f71516c48ffb5d3b1122ca666a8-20190829
X-UUID: cda13f71516c48ffb5d3b1122ca666a8-20190829
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1728235605; Thu, 29 Aug 2019 09:48:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 09:48:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 09:48:31 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v14 04/10] mailbox: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
Date:   Thu, 29 Aug 2019 09:48:10 +0800
Message-ID: <20190829014817.25482-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190829014817.25482-1-bibby.hsieh@mediatek.com>
References: <20190829014817.25482-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt mask and thread number has positive correlation,
so we move the CMDQ_IRQ_MASK into cmdq driver data and calculate
it by thread number.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 00d5219094e5..8fddd26288e8 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -18,7 +18,6 @@
 #include <linux/of_device.h>
 
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
-#define CMDQ_IRQ_MASK			0xffff
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
@@ -72,6 +71,7 @@ struct cmdq {
 	void __iomem		*base;
 	u32			irq;
 	u32			thread_nr;
+	u32			irq_mask;
 	struct cmdq_thread	*thread;
 	struct clk		*clock;
 	bool			suspended;
@@ -285,11 +285,11 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
 	unsigned long irq_status, flags = 0L;
 	int bit;
 
-	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
-	if (!(irq_status ^ CMDQ_IRQ_MASK))
+	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & cmdq->irq_mask;
+	if (!(irq_status ^ cmdq->irq_mask))
 		return IRQ_NONE;
 
-	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
+	for_each_clear_bit(bit, &irq_status, cmdq->thread_nr) {
 		struct cmdq_thread *thread = &cmdq->thread[bit];
 
 		spin_lock_irqsave(&thread->chan->lock, flags);
@@ -473,6 +473,9 @@ static int cmdq_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to get irq\n");
 		return -EINVAL;
 	}
+
+	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
+	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
 			       "mtk_cmdq", cmdq);
 	if (err < 0) {
@@ -489,7 +492,6 @@ static int cmdq_probe(struct platform_device *pdev)
 		return PTR_ERR(cmdq->clock);
 	}
 
-	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
 	cmdq->mbox.dev = dev;
 	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
 					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
-- 
2.18.0

