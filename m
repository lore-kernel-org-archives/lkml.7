Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D906AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3981213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfCSIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:02:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2245 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbfCSICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:02:05 -0400
X-UUID: 69f12a1d5c6e4ea69b145907ab0e7550-20190319
X-UUID: 69f12a1d5c6e4ea69b145907ab0e7550-20190319
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1464174651; Tue, 19 Mar 2019 16:01:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v5 06/14] soc: mediatek: Refactor clock control
Date:   Tue, 19 Mar 2019 16:01:32 +0800
Message-ID: <20190319080140.24055-7-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190319080140.24055-1-weiyi.lu@mediatek.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C4BDC881A96B2214192B7C69363E5436C42C8F701167E299705B974385915BF82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put clock enable and disable control in separate function.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 49 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 765ad4a5e5df..3e9be07a2627 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -208,6 +208,33 @@ static int scpsys_regulator_disable(struct scp_domain *scpd)
 	return regulator_disable(scpd->supply);
 }
 
+static int scpsys_clk_enable(struct clk *clk[], int max_num)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < max_num && clk[i]; i++) {
+		ret = clk_prepare_enable(clk[i]);
+		if (ret) {
+			for (--i; i >= 0; i--)
+				clk_disable_unprepare(clk[i]);
+
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void scpsys_clk_disable(struct clk *clk[], int max_num)
+{
+	int i;
+
+	for (i = max_num - 1; i >= 0; i--) {
+		if (clk[i])
+			clk_disable_unprepare(clk[i]);
+	}
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
@@ -216,21 +243,14 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
-	int i;
 
 	ret = scpsys_regulator_enable(scpd);
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
-		ret = clk_prepare_enable(scpd->clk[i]);
-		if (ret) {
-			for (--i; i >= 0; i--)
-				clk_disable_unprepare(scpd->clk[i]);
-
-			goto err_clk;
-		}
-	}
+	ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
+	if (ret)
+		goto err_clk;
 
 	val = readl(ctl_addr);
 	val |= PWR_ON_BIT;
@@ -283,10 +303,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	return 0;
 
 err_pwr_ack:
-	for (i = MAX_CLKS - 1; i >= 0; i--) {
-		if (scpd->clk[i])
-			clk_disable_unprepare(scpd->clk[i]);
-	}
+	scpsys_clk_disable(scpd->clk, MAX_CLKS);
 err_clk:
 	scpsys_regulator_disable(scpd);
 
@@ -303,7 +320,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
-	int i;
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
@@ -344,8 +360,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
-		clk_disable_unprepare(scpd->clk[i]);
+	scpsys_clk_disable(scpd->clk, MAX_CLKS);
 
 	ret = scpsys_regulator_disable(scpd);
 	if (ret < 0)
-- 
2.18.0

