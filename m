Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D75BC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76868206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEPJ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:28:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53913 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbfEPJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:28:03 -0400
X-UUID: d86e117a3c794947902cb259459271e0-20190516
X-UUID: d86e117a3c794947902cb259459271e0-20190516
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1025656641; Thu, 16 May 2019 17:27:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 16 May 2019 17:27:55 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 16 May 2019 17:27:55 +0800
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
Subject: [PATCH v6 10/12] soc: mediatek: cmdq: add cmdq_dev_get_subsys function
Date:   Thu, 16 May 2019 17:27:53 +0800
Message-ID: <20190516092754.33425-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190516092754.33425-1-bibby.hsieh@mediatek.com>
References: <20190516092754.33425-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCE cannot know the register base address, this function
can help cmdq client to get the relationship of subsys
and register base address.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index a53cdd71cfc2..a64060a34e01 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -27,6 +27,31 @@ struct cmdq_instruction {
 	u8 op;
 };
 
+struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx)
+{
+	struct cmdq_subsys *subsys;
+	struct of_phandle_args spec;
+
+	subsys = devm_kzalloc(dev, sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return NULL;
+
+	if (of_parse_phandle_with_args(dev->of_node, "mediatek,gce-client-reg",
+				       "#subsys-cells", idx, &spec)) {
+		dev_err(dev, "can't parse gce-client-reg property");
+
+		return (struct cmdq_subsys *)-ENODEV;
+	}
+
+	subsys->id = spec.args[0];
+	subsys->offset = spec.args[1];
+	subsys->size = spec.args[2];
+	of_node_put(spec.np);
+
+	return subsys;
+}
+EXPORT_SYMBOL(cmdq_dev_get_subsys);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 0651a0bffa54..574006c5cd76 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -15,6 +15,12 @@
 
 struct cmdq_pkt;
 
+struct cmdq_subsys {
+	u8 id;
+	u16 offset;
+	u16 size;
+};
+
 struct cmdq_client {
 	spinlock_t lock;
 	u32 pkt_cnt;
@@ -142,4 +148,16 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
  */
 int cmdq_pkt_flush(struct cmdq_pkt *pkt);
 
+/**
+ * cmdq_dev_get_subsys() - parse sub system from the device node of CMDQ client
+ * @dev:	device of CMDQ mailbox client
+ * @idx:	the index of desired subsys
+ *
+ * Return: CMDQ subsys pointer
+ *
+ * Help CMDQ client pasing the sub system number
+ * from the device node of CMDQ client.
+ */
+struct cmdq_subsys *cmdq_dev_get_subsys(struct device *dev, int idx);
+
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.18.0

