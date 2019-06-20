Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BACC4646B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ACF21721
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfFTCim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:38:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63894 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731393AbfFTCig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:38:36 -0400
X-UUID: 62ee20090a25452fac4c73e336be049e-20190620
X-UUID: 62ee20090a25452fac4c73e336be049e-20190620
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1491762159; Thu, 20 Jun 2019 10:38:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 06/14] soc: mediatek: Refactor clock control
Date:   Thu, 20 Jun 2019 10:37:58 +0800
Message-ID: <1560998286-9189-7-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
References: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C634D6192B9CAFB2B23B6D42EC8F5BCF7EEE8EC8F02001862F004CB784B1DF612000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put clock enable and disable control in separate function.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 45 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 1a6a4ab..5b73e4e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -207,6 +207,29 @@ static int scpsys_regulator_disable(struct scp_domain *scpd)
 	return regulator_disable(scpd->supply);
 }
 
+static void scpsys_clk_disable(struct clk *clk[], int max_num)
+{
+	int i;
+
+	for (i = max_num - 1; i >= 0; i--)
+		clk_disable_unprepare(clk[i]);
+}
+
+static int scpsys_clk_enable(struct clk *clk[], int max_num)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < max_num && clk[i]; i++) {
+		ret = clk_prepare_enable(clk[i]);
+		if (ret) {
+			scpsys_clk_disable(clk, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
@@ -215,21 +238,14 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
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
@@ -282,10 +298,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	return 0;
 
 err_pwr_ack:
-	for (i = MAX_CLKS - 1; i >= 0; i--) {
-		if (scpd->clk[i])
-			clk_disable_unprepare(scpd->clk[i]);
-	}
+	scpsys_clk_disable(scpd->clk, MAX_CLKS);
 err_clk:
 	scpsys_regulator_disable(scpd);
 
@@ -302,7 +315,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
-	int i;
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
@@ -343,8 +355,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
-		clk_disable_unprepare(scpd->clk[i]);
+	scpsys_clk_disable(scpd->clk, MAX_CLKS);
 
 	ret = scpsys_regulator_disable(scpd);
 	if (ret < 0)
-- 
1.8.1.1.dirty

