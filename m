Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAF52064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfDOM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:59:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37755 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727509AbfDOM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:58:48 -0400
X-UUID: a85e6d22ba2a4b43ac1f08e3b7140316-20190415
X-UUID: a85e6d22ba2a4b43ac1f08e3b7140316-20190415
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1341644486; Mon, 15 Apr 2019 20:58:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Apr 2019 20:58:38 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Apr 2019 20:58:38 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH v4 09/12] soc: mediatek: cmdq: add polling function
Date:   Mon, 15 Apr 2019 20:58:30 +0800
Message-ID: <20190415125833.38704-10-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
References: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5D93F1FD5E2961F2281EE69481537788D33C48AD105743452147FA19D363ED0B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add polling function in cmdq helper functions

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 30 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
 include/linux/soc/mediatek/mtk-cmdq.h    | 15 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index d3873ab21db3..80856b8c2385 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -231,6 +231,36 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
 }
 EXPORT_SYMBOL(cmdq_pkt_clear_event);
 
+int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
+		  u16 offset, u32 value, u32 mask)
+{
+	int err;
+
+	if (mask != 0xffffffff) {
+		err = cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(~mask),
+					      CMDQ_GET_ARG_B(~mask),
+					      CMDQ_IMMEDIATE_VALUE,
+					      CMDQ_IMMEDIATE_VALUE,
+					      CMDQ_IMMEDIATE_VALUE,
+					      CMDQ_IMMEDIATE_VALUE,
+					      CMDQ_IMMEDIATE_VALUE,
+					      CMDQ_CODE_MASK);
+
+		if (err != 0)
+			return err;
+	}
+	offset = offset | 0x1;
+
+	return cmdq_pkt_append_command(pkt, CMDQ_GET_ARG_C(value),
+				       CMDQ_GET_ARG_B(value),
+				       offset, subsys,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_IMMEDIATE_VALUE,
+				       CMDQ_CODE_POLL);
+}
+EXPORT_SYMBOL(cmdq_pkt_poll);
+
 static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 {
 	int err;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index f21801d32a3a..1dfd5ed5c8c5 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -46,6 +46,7 @@
 enum cmdq_code {
 	CMDQ_CODE_MASK = 0x02,
 	CMDQ_CODE_WRITE = 0x04,
+	CMDQ_CODE_POLL = 0x08,
 	CMDQ_CODE_JUMP = 0x10,
 	CMDQ_CODE_WFE = 0x20,
 	CMDQ_CODE_EOC = 0x40,
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 52f69c8db8de..0651a0bffa54 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -99,6 +99,21 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
  */
 int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
 
+/**
+ * cmdq_pkt_poll() - Append polling command to the CMDQ packet, ask GCE to
+ *		     execute an instruction that wait for a specified hardware
+ *		     register to check for the value. All GCE hardware
+ *		     threads will be blocked by this instruction.
+ * @pkt:	the CMDQ packet
+ * @subsys:	the CMDQ sub system code
+ * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
+ * @mask:	the specified target register mask
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
+		  u16 offset, u32 value, u32 mask);
 /**
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
  *                          packet and call back at the end of done packet
-- 
2.18.0

