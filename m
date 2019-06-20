Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDBEC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25202147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfFTCid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:38:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13850 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbfFTCic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:38:32 -0400
X-UUID: 09b4ea62795349a68dc81b365e4d835b-20190620
X-UUID: 09b4ea62795349a68dc81b365e4d835b-20190620
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1645961367; Thu, 20 Jun 2019 10:38:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 07/14] soc: mediatek: Refactor sram control
Date:   Thu, 20 Jun 2019 10:37:59 +0800
Message-ID: <1560998286-9189-8-git-send-email-weiyi.lu@mediatek.com>
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

Put sram enable and disable control in separate functions.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/soc/mediatek/mtk-scpsys.c | 79 +++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 5b73e4e..58627ab 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -230,12 +230,55 @@ static int scpsys_clk_enable(struct clk *clk[], int max_num)
 	return ret;
 }
 
+static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
+{
+	u32 val;
+	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	int tmp;
+
+	val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
+	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
+		/*
+		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
+		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
+		 * is applied here.
+		 */
+		usleep_range(12000, 12100);
+	} else {
+		/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+		int ret = readl_poll_timeout(ctl_addr, tmp,
+				(tmp & pdn_ack) == 0,
+				MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
+{
+	u32 val;
+	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
+	int tmp;
+
+	val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
+	writel(val, ctl_addr);
+
+	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+	return readl_poll_timeout(ctl_addr, tmp,
+			(tmp & pdn_ack) == pdn_ack,
+			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
 static int scpsys_power_on(struct generic_pm_domain *genpd)
 {
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
 	struct scp *scp = scpd->scp;
 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
 
@@ -247,6 +290,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		goto err_clk;
 
+	/* subsys power on */
 	val = readl(ctl_addr);
 	val |= PWR_ON_BIT;
 	writel(val, ctl_addr);
@@ -268,24 +312,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	val |= PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
-	val &= ~scpd->data->sram_pdn_bits;
-	writel(val, ctl_addr);
-
-	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
-	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
-		/*
-		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
-		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
-		 * applied here.
-		 */
-		usleep_range(12000, 12100);
-
-	} else {
-		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
-					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-		if (ret < 0)
-			goto err_pwr_ack;
-	}
+	ret = scpsys_sram_enable(scpd, ctl_addr);
+	if (ret < 0)
+		goto err_pwr_ack;
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
@@ -312,7 +341,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
 	struct scp *scp = scpd->scp;
 	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
-	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
 	u32 val;
 	int ret, tmp;
 
@@ -324,17 +352,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 			goto out;
 	}
 
-	val = readl(ctl_addr);
-	val |= scpd->data->sram_pdn_bits;
-	writel(val, ctl_addr);
-
-	/* wait until SRAM_PDN_ACK all 1 */
-	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
-				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	ret = scpsys_sram_disable(scpd, ctl_addr);
 	if (ret < 0)
 		goto out;
 
-	val |= PWR_ISO_BIT;
+	/* subsys power off */
+	val = readl(ctl_addr) | PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
 	val &= ~PWR_RST_B_BIT;
-- 
1.8.1.1.dirty

