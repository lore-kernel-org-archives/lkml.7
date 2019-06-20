Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81ABC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B82B21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfFTCjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:39:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41789 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726370AbfFTCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:38:29 -0400
X-UUID: a1cbd5c3b77c4125a388f77f01f26e61-20190620
X-UUID: a1cbd5c3b77c4125a388f77f01f26e61-20190620
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1916497800; Thu, 20 Jun 2019 10:38:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 10:38:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 10:38:19 +0800
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
Subject: [PATCH v6 09/14] soc: mediatek: Add basic_clk_id to scp_power_data
Date:   Thu, 20 Jun 2019 10:38:01 +0800
Message-ID: <1560998286-9189-10-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
References: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
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
index 178198b..4a0752e 100644
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

