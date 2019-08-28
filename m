Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4372233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfH1M3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:29:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46449 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbfH1M3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:29:04 -0400
X-UUID: aa0007ba038d434086a15393bb0e0ce8-20190828
X-UUID: aa0007ba038d434086a15393bb0e0ce8-20190828
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 762124500; Wed, 28 Aug 2019 20:28:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 20:28:58 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 20:28:58 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V3 03/10] soc: mediatek: add support for the performance state
Date:   Wed, 28 Aug 2019 20:28:41 +0800
Message-ID: <1566995328-15158-4-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support power domain performance state, add header file for scp event.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 58 +++++++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.h | 22 +++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e072810..50bc254 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -10,7 +10,9 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/scpsys-ext.h>
 
@@ -21,6 +23,7 @@
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/power/mt8183-power.h>
+#include "mtk-scpsys.h"
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
@@ -187,6 +190,18 @@ struct scp_soc_data {
 	bool bus_prot_reg_update;
 };
 
+static BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
+
+int register_scpsys_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
+}
+
+int unregister_scpsys_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
+}
+
 static int scpsys_domain_is_on(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
@@ -505,6 +520,41 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
 }
 
+static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
+				  unsigned int state)
+{
+	int i;
+	struct scp_domain *scpd =
+		container_of(genpd, struct scp_domain, genpd);
+	struct scp_event_data scpe;
+	struct scp *scp = scpd->scp;
+	struct genpd_onecell_data *pd_data = &scp->pd_data;
+
+	for (i = 0; i < pd_data->num_domains; i++) {
+		if (genpd == pd_data->domains[i]) {
+			dev_dbg(scp->dev, "%d. %s = %d\n",
+				i, genpd->name, state);
+			break;
+		}
+	}
+
+	if (i == pd_data->num_domains)
+		return 0;
+
+	scpe.event_type = MTK_SCPSYS_PSTATE;
+	scpe.genpd = genpd;
+	scpe.domain_id = i;
+	blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
+
+	return 0;
+}
+
+static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
+					   struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
 static struct scp *init_scp(struct platform_device *pdev,
 			const struct scp_domain_data *scp_domain_data, int num,
 			const struct scp_ctrl_reg *scp_ctrl_reg,
@@ -630,6 +680,14 @@ static struct scp *init_scp(struct platform_device *pdev,
 		genpd->power_on = scpsys_power_on;
 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+
+		/* Add opp table check first to avoid OF runtime parse failed */
+		if (of_count_phandle_with_args(pdev->dev.of_node,
+		   "operating-points-v2", NULL) > 0) {
+			genpd->set_performance_state = mtk_pd_set_performance;
+			genpd->opp_to_performance_state =
+				mtk_pd_get_performance;
+		}
 	}
 
 	return scp;
diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
new file mode 100644
index 0000000..c1e8325
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-scpsys.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+
+#ifndef __MTK_SCPSYS_H__
+#define __MTK_SCPSYS_H__
+
+struct scp_event_data {
+	int event_type;
+	int domain_id;
+	struct generic_pm_domain *genpd;
+};
+
+enum scp_event_type {
+	MTK_SCPSYS_PSTATE,
+};
+
+int register_scpsys_notifier(struct notifier_block *nb);
+int unregister_scpsys_notifier(struct notifier_block *nb);
+
+#endif /* __MTK_SCPSYS_H__ */
-- 
1.9.1

