Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E56C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F72133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCSICO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:02:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2245 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727399AbfCSICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:02:10 -0400
X-UUID: ad1c2b2d06364257bca3d961d68f8971-20190319
X-UUID: ad1c2b2d06364257bca3d961d68f8971-20190319
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1742679652; Tue, 19 Mar 2019 16:01:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 16:01:57 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 16:01:57 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v5 09/14] soc: mediatek: Add basic_clk_name to scp_power_data
Date:   Tue, 19 Mar 2019 16:01:35 +0800
Message-ID: <20190319080140.24055-10-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190319080140.24055-1-weiyi.lu@mediatek.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to stop extending the clk_id or clk_names if there are
more and more new BASIC clocks. To get its own clocks by the
basic_clk_name of each power domain.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 6bf846cb1893..c6360de4e41e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -118,6 +118,8 @@ static const char * const clk_names[] = {
  * @bus_prot_mask: The mask for single step bus protection.
  * @clk_id: The basic clock needs to be enabled before enabling certain
  *          power domains.
+ * @basic_clk_name: provide the same purpose with field "clk_id"
+ *                  by declaring basic clock prefix name rather than clk_id.
  * @caps: The flag for active wake-up action.
  */
 struct scp_domain_data {
@@ -128,6 +130,7 @@ struct scp_domain_data {
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
+	const char *basic_clk_name[MAX_CLKS];
 	u8 caps;
 };
 
@@ -499,16 +502,24 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 		scpd->data = data;
 
-		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
-			struct clk *c = clk[data->clk_id[j]];
+		if (data->clk_id[0]) {
+			for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
+				struct clk *c = clk[data->clk_id[j]];
 
-			if (IS_ERR(c)) {
-				dev_err(&pdev->dev, "%s: clk unavailable\n",
-					data->name);
-				return ERR_CAST(c);
-			}
+				if (IS_ERR(c)) {
+					dev_err(&pdev->dev,
+						"%s: clk unavailable\n",
+						data->name);
+					return ERR_CAST(c);
+				}
 
-			scpd->clk[j] = c;
+				scpd->clk[j] = c;
+			}
+		} else if (data->basic_clk_name[0]) {
+			for (j = 0; j < MAX_CLKS &&
+					data->basic_clk_name[j]; j++)
+				scpd->clk[j] = devm_clk_get(&pdev->dev,
+						data->basic_clk_name[j]);
 		}
 
 		genpd->name = data->name;
-- 
2.18.0

