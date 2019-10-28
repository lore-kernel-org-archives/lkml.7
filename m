Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC8CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D33C2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfJ1Csi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:48:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730569AbfJ1Csf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:48:35 -0400
X-UUID: 5936937a6aec4597b79673e9bd4271b1-20191028
X-UUID: 5936937a6aec4597b79673e9bd4271b1-20191028
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 754973708; Mon, 28 Oct 2019 10:48:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v8 05/14] soc: mediatek: Refactor clock control
Date:   Mon, 28 Oct 2019 10:48:09 +0800
Message-ID: <1572230898-7860-6-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1572230898-7860-1-git-send-email-weiyi.lu@mediatek.com>
References: <1572230898-7860-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6723FCDA35A5BB6B8D3304725DAA499F115E234A111C0B7D9E10159298ACF7582000:8
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
index aed540d..73e4a1a 100644
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

