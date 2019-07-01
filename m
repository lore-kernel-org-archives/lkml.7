Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E9FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48151208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGAHtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:49:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728000AbfGAHs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:48:56 -0400
X-UUID: 301efc2f5d1c42138a73dd0db6d935c4-20190701
X-UUID: 301efc2f5d1c42138a73dd0db6d935c4-20190701
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 987321481; Mon, 01 Jul 2019 15:48:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Jul 2019 15:48:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Jul 2019 15:48:44 +0800
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
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v10 07/12] soc: mediatek: cmdq: reorder the parameter
Date:   Mon, 1 Jul 2019 15:48:37 +0800
Message-ID: <20190701074842.15401-8-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190701074842.15401-1-bibby.hsieh@mediatek.com>
References: <20190701074842.15401-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of gce instructions is [subsys offset value]
so reorder the parameter of cmdq_pkt_write_mask
and cmdq_pkt_write function.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c |  6 +++---
 include/linux/soc/mediatek/mtk-cmdq.h  | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index ff9fef5a032b..082b8978651e 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -136,7 +136,7 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
 	return 0;
 }
 
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value)
 {
 	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
 		    (subsys << CMDQ_SUBSYS_SHIFT);
@@ -145,8 +145,8 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
 }
 EXPORT_SYMBOL(cmdq_pkt_write);
 
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
-			u32 subsys, u32 offset, u32 mask)
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
+			u32 offset, u32 value, u32 mask)
 {
 	u32 offset_mask = offset;
 	int err = 0;
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 4e8899972db4..39d813dde4b4 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -60,26 +60,26 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @value:	the specified target register value
  * @subsys:	the CMDQ sub system code
  * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value);
 
 /**
  * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
  * @pkt:	the CMDQ packet
- * @value:	the specified target register value
  * @subsys:	the CMDQ sub system code
  * @offset:	register offset from CMDQ sub system
+ * @value:	the specified target register value
  * @mask:	the specified target register mask
  *
  * Return: 0 for success; else the error code is returned
  */
-int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
-			u32 subsys, u32 offset, u32 mask);
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
+			u32 offset, u32 value, u32 mask);
 
 /**
  * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
-- 
2.18.0

