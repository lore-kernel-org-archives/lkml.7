Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43119CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149CF20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfJ1Csf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:48:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53869 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729515AbfJ1Csd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:48:33 -0400
X-UUID: 7025ec5653e64cc392e1e7b9cb9a962d-20191028
X-UUID: 7025ec5653e64cc392e1e7b9cb9a962d-20191028
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 171030631; Mon, 28 Oct 2019 10:48:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 10:48:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 10:48:26 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v8 08/14] soc: mediatek: Add basic_clk_id to scp_power_data
Date:   Mon, 28 Oct 2019 10:48:12 +0800
Message-ID: <1572230898-7860-9-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1572230898-7860-1-git-send-email-weiyi.lu@mediatek.com>
References: <1572230898-7860-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to stop extending the clk_id or clk_names if there are
more and more new BASIC clocks. To get its own clocks by the
basic_clk_id of each power domain.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index fb2b027..d31e1a4 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -117,6 +117,8 @@ enum clk_id {
  * @sram_pdn_ack_bits: The mask for sram power control acked bits.
  * @bus_prot_mask: The mask for single step bus protection.
  * @clk_id: The basic clocks required by this power domain.
+ * @basic_clk_id: provide the same purpose with field "clk_id"
+ *                by declaring basic clock prefix name rather than clk_id.
  * @caps: The flag for active wake-up action.
  */
 struct scp_domain_data {
@@ -127,6 +129,7 @@ struct scp_domain_data {
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
+	const char *basic_clk_id[MAX_CLKS];
 	u8 caps;
 };
 
@@ -490,16 +493,26 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 		scpd->data = data;
 
-		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
-			struct clk *c = clk[data->clk_id[j]];
+		if (data->clk_id[0]) {
+			WARN_ON(data->basic_clk_id[0]);
 
-			if (IS_ERR(c)) {
-				dev_err(&pdev->dev, "%s: clk unavailable\n",
-					data->name);
-				return ERR_CAST(c);
-			}
+			for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
+				struct clk *c = clk[data->clk_id[j]];
+
+				if (IS_ERR(c)) {
+					dev_err(&pdev->dev,
+						"%s: clk unavailable\n",
+						data->name);
+					return ERR_CAST(c);
+				}
 
-			scpd->clk[j] = c;
+				scpd->clk[j] = c;
+			}
+		} else if (data->basic_clk_id[0]) {
+			for (j = 0; j < MAX_CLKS &&
+					data->basic_clk_id[j]; j++)
+				scpd->clk[j] = devm_clk_get(&pdev->dev,
+						data->basic_clk_id[j]);
 		}
 
 		genpd->name = data->name;
-- 
1.8.1.1.dirty

