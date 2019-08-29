Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A82C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F07822CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfH2Bsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:48:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45669 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727433AbfH2Bsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:48:37 -0400
X-UUID: 9fe4e16b24d94559b06d37bebe63a4d6-20190829
X-UUID: 9fe4e16b24d94559b06d37bebe63a4d6-20190829
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1025539183; Thu, 29 Aug 2019 09:48:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 09:48:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 09:48:32 +0800
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
Subject: [PATCH v14 08/10] soc: mediatek: cmdq: add polling function
Date:   Thu, 29 Aug 2019 09:48:15 +0800
Message-ID: <20190829014817.25482-10-bibby.hsieh@mediatek.com>
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

add polling function in cmdq helper functions

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 30 ++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
 include/linux/soc/mediatek/mtk-cmdq.h    | 32 ++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 9472526ab076..bec7bb6c3988 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -211,6 +211,36 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 }
 EXPORT_SYMBOL(cmdq_pkt_clear_event);
 
+int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
+		  u16 offset, u32 value)
+{
+	struct cmdq_instruction inst;
+
+	inst.op = CMDQ_CODE_POLL;
+	inst.value = value;
+	inst.offset = offset;
+	inst.subsys = subsys;
+
+	return cmdq_pkt_append_command(pkt, inst);
+}
+EXPORT_SYMBOL(cmdq_pkt_poll);
+
+int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
+		       u16 offset, u32 value, u32 mask)
+{
+	struct cmdq_instruction inst = { {0} };
+	int err = 0;
+
+	inst.op = CMDQ_CODE_MASK;
+	inst.mask = ~mask;
+	err = cmdq_pkt_append_command(pkt, inst);
+	offset = offset | 0x1;
+	err |= cmdq_pkt_poll(pkt, subsys, offset, value);
+
+	return err;
+}
+EXPORT_SYMBOL(cmdq_pkt_poll_mask);
+
 static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	struct cmdq_instruction inst = { {0} };
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 678760548791..a4dc45fbec0a 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -55,6 +55,7 @@
 enum cmdq_code {
 	CMDQ_CODE_MASK = 0x02,
 	CMDQ_CODE_WRITE = 0x04,
+	CMDQ_CODE_POLL = 0x08,
 	CMDQ_CODE_JUMP = 0x10,
 	CMDQ_CODE_WFE = 0x20,
 	CMDQ_CODE_EOC = 0x40,
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 9618debb9ceb..92bd5b5c6341 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -99,6 +99,38 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
  */
 int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
 
+/**
+ * cmdq_pkt_poll() - Append polling command to the CMDQ packet, ask GCE to
+ *		     execute an instruction that wait for a specified
+ *		     hardware register to check for the value w/o mask.
+ *		     All GCE hardware threads will be blocked by this
+ *		     instruction.
+ * @pkt:	the CMDQ packet
+ * @subsys:	the CMDQ sub system code
+ * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
+		  u16 offset, u32 value);
+
+/**
+ * cmdq_pkt_poll_mask() - Append polling command to the CMDQ packet, ask GCE to
+ *		          execute an instruction that wait for a specified
+ *		          hardware register to check for the value w/ mask.
+ *		          All GCE hardware threads will be blocked by this
+ *		          instruction.
+ * @pkt:	the CMDQ packet
+ * @subsys:	the CMDQ sub system code
+ * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
+ * @mask:	the specified target register mask
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
+		       u16 offset, u32 value, u32 mask);
 /**
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
  *                          packet and call back at the end of done packet
-- 
2.18.0

