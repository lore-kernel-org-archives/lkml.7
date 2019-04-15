Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869C20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfDOM6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:58:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57412 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfDOM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:58:45 -0400
X-UUID: d967b69c2beb475a82d358ba78ac7a5d-20190415
X-UUID: d967b69c2beb475a82d358ba78ac7a5d-20190415
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1363294485; Mon, 15 Apr 2019 20:58:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v4 11/12] soc: mediatek: cmdq: add cmdq_dev_get_event function
Date:   Mon, 15 Apr 2019 20:58:32 +0800
Message-ID: <20190415125833.38704-12-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
References: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When client ask gce to clear or wait for event,
client need to pass event number to the API.
We suggest client store the event information in device node,
so we provide an API for client parse the event property.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 32 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 12 ++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index d86f800d40dc..bc8e10121f9b 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -72,6 +72,38 @@ struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx)
 }
 EXPORT_SYMBOL(cmdq_dev_get_subsys);
 
+s32 cmdq_dev_get_event(struct device *dev, const char *name)
+{
+	s32 index = 0;
+	struct of_phandle_args spec;
+	s32 result;
+
+	if (!dev)
+		return -EINVAL;
+
+	index = of_property_match_string(dev->of_node,
+					 "mediatek,gce-event-names", name);
+	if (index < 0) {
+		dev_err(dev, "no gce-event-names property or no such event:%s",
+			name);
+
+		return index;
+	}
+
+	if (of_parse_phandle_with_args(dev->of_node, "mediatek,gce-events",
+				       "#event-cells", index, &spec)) {
+		dev_err(dev, "can't parse gce-events property");
+
+		return -ENODEV;
+	}
+
+	result = spec.args[0];
+	of_node_put(spec.np);
+
+	return result;
+}
+EXPORT_SYMBOL(cmdq_dev_get_event);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 574006c5cd76..15884354af20 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -160,4 +160,16 @@ int cmdq_pkt_flush(struct cmdq_pkt *pkt);
  */
 struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx);
 
+/**
+ * cmdq_dev_get_event() - parse event from the device node of CMDQ client
+ * @dev:	device of CMDQ mailbox client
+ * @name:	the name of desired event
+ *
+ * Return: CMDQ event number
+ *
+ * Help CMDQ client pasing the event number
+ * from the device node of CMDQ client.
+ */
+s32 cmdq_dev_get_event(struct device *dev, const char *name);
+
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.18.0

