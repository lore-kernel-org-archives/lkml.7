Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E682C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5420856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfH1JMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:12:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15642 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726246AbfH1JMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:07 -0400
X-UUID: 6acb42ef8b9a43818ee091a15fa781d8-20190828
X-UUID: 6acb42ef8b9a43818ee091a15fa781d8-20190828
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1062980437; Wed, 28 Aug 2019 17:11:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:12:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:12:04 +0800
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
Subject: [PATCH v7 04/13] soc: mediatek: Refactor regulator control
Date:   Wed, 28 Aug 2019 17:11:37 +0800
Message-ID: <1566983506-26598-5-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
References: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put regulator enable and disable control in separate functions.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e97fc0e..aed540d 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -191,6 +191,22 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
 	return -EINVAL;
 }
 
+static int scpsys_regulator_enable(struct scp_domain *scpd)
+{
+	if (!scpd->supply)
+		return 0;
+
+	return regulator_enable(scpd->supply);
+}
+
+static int scpsys_regulator_disable(struct scp_domain *scpd)
+{
+	if (!scpd->supply)
+		return 0;
+
+	return regulator_disable(scpd->supply);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
@@ -201,11 +217,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	int ret, tmp;
 	int i;
 
-	if (scpd->supply) {
-		ret = regulator_enable(scpd->supply);
-		if (ret)
-			return ret;
-	}
+	ret = scpsys_regulator_enable(scpd);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
 		ret = clk_prepare_enable(scpd->clk[i]);
@@ -273,8 +287,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 			clk_disable_unprepare(scpd->clk[i]);
 	}
 err_clk:
-	if (scpd->supply)
-		regulator_disable(scpd->supply);
+	scpsys_regulator_disable(scpd);
 
 	dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
 
@@ -333,8 +346,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
 		clk_disable_unprepare(scpd->clk[i]);
 
-	if (scpd->supply)
-		regulator_disable(scpd->supply);
+	ret = scpsys_regulator_disable(scpd);
+	if (ret < 0)
+		goto out;
 
 	return 0;
 
-- 
1.8.1.1.dirty

