Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6605ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B65208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfJ1Csh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:48:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730571AbfJ1Csf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:48:35 -0400
X-UUID: 72c1721ea2d64c5e85a74d587b7ab78f-20191028
X-UUID: 72c1721ea2d64c5e85a74d587b7ab78f-20191028
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 212091960; Mon, 28 Oct 2019 10:48:28 +0800
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
Subject: [PATCH v8 09/14] soc: mediatek: Add multiple step bus protection control
Date:   Mon, 28 Oct 2019 10:48:13 +0800
Message-ID: <1572230898-7860-10-git-send-email-weiyi.lu@mediatek.com>
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

Both MT8183 & MT6765 have more control steps of bus protection
than previous project. And there add more bus protection registers
reside at infracfg & smi-common. Also add new APIs for multiple
step bus protection control with more customized arguments.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/Makefile           |  2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c   | 99 +++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c       | 39 +++++++++----
 include/linux/soc/mediatek/scpsys-ext.h | 39 +++++++++++++
 4 files changed, 168 insertions(+), 11 deletions(-)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h

diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index b017330..b442be9 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
-obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
+obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
new file mode 100644
index 0000000..b24321e
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Owen Chen <Owen.Chen@mediatek.com>
+ */
+#include <linux/ktime.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/mediatek/scpsys-ext.h>
+
+#define MTK_POLL_DELAY_US   10
+#define MTK_POLL_TIMEOUT    USEC_PER_SEC
+
+static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
+		u32 reg_set, u32 reg_sta, u32 reg_en)
+{
+	u32 val;
+
+	if (reg_set)
+		regmap_write(map, reg_set, mask);
+	else
+		regmap_update_bits(map, reg_en, mask, mask);
+
+	return regmap_read_poll_timeout(map, reg_sta,
+			val, (val & ack_mask) == ack_mask,
+			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int clear_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
+		u32 reg_clr, u32 reg_sta, u32 reg_en)
+{
+	u32 val;
+
+	if (reg_clr)
+		regmap_write(map, reg_clr, mask);
+	else
+		regmap_update_bits(map, reg_en, mask, 0);
+
+	return regmap_read_poll_timeout(map, reg_sta,
+			val, !(val & ack_mask),
+			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
+	struct regmap *infracfg, struct regmap *smi_common)
+{
+	int i;
+
+	for (i = 0; i < MAX_STEPS; i++) {
+		struct regmap *map;
+		int ret;
+
+		if (bp_table[i].type == INVALID_TYPE)
+			continue;
+		else if (bp_table[i].type == IFR_TYPE)
+			map = infracfg;
+		else if (bp_table[i].type == SMI_TYPE)
+			map = smi_common;
+
+		ret = set_bus_protection(map,
+				bp_table[i].mask, bp_table[i].mask,
+				bp_table[i].set_ofs, bp_table[i].sta_ofs,
+				bp_table[i].en_ofs);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
+	struct regmap *infracfg, struct regmap *smi_common)
+{
+	int i;
+
+	for (i = MAX_STEPS - 1; i >= 0; i--) {
+		struct regmap *map;
+		int ret;
+
+		if (bp_table[i].type == INVALID_TYPE)
+			continue;
+		else if (bp_table[i].type == IFR_TYPE)
+			map = infracfg;
+		else if (bp_table[i].type == SMI_TYPE)
+			map = smi_common;
+
+		ret = clear_bus_protection(map,
+				bp_table[i].mask, bp_table[i].clr_ack_mask,
+				bp_table[i].clr_ofs, bp_table[i].sta_ofs,
+				bp_table[i].en_ofs);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index d31e1a4..f25101f 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -12,6 +12,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
+#include <linux/soc/mediatek/scpsys-ext.h>
 
 #include <dt-bindings/power/mt2701-power.h>
 #include <dt-bindings/power/mt2712-power.h>
@@ -120,6 +121,7 @@ enum clk_id {
  * @basic_clk_id: provide the same purpose with field "clk_id"
  *                by declaring basic clock prefix name rather than clk_id.
  * @caps: The flag for active wake-up action.
+ * @bp_table: The mask table for multiple step bus protection.
  */
 struct scp_domain_data {
 	const char *name;
@@ -131,6 +133,7 @@ struct scp_domain_data {
 	enum clk_id clk_id[MAX_CLKS];
 	const char *basic_clk_id[MAX_CLKS];
 	u8 caps;
+	struct bus_prot bp_table[MAX_STEPS];
 };
 
 struct scp;
@@ -154,6 +157,7 @@ struct scp {
 	struct device *dev;
 	void __iomem *base;
 	struct regmap *infracfg;
+	struct regmap *smi_common;
 	struct scp_ctrl_reg ctrl_reg;
 	bool bus_prot_reg_update;
 };
@@ -281,24 +285,28 @@ static int scpsys_bus_protect_enable(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
 
-	if (!scpd->data->bus_prot_mask)
-		return 0;
+	if (scpd->data->bus_prot_mask) {
+		return mtk_infracfg_set_bus_protection(scp->infracfg,
+				scpd->data->bus_prot_mask,
+				scp->bus_prot_reg_update);
+	}
 
-	return mtk_infracfg_set_bus_protection(scp->infracfg,
-			scpd->data->bus_prot_mask,
-			scp->bus_prot_reg_update);
+	return mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
+			scp->infracfg, scp->smi_common);
 }
 
 static int scpsys_bus_protect_disable(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
 
-	if (!scpd->data->bus_prot_mask)
-		return 0;
+	if (scpd->data->bus_prot_mask) {
+		return mtk_infracfg_clear_bus_protection(scp->infracfg,
+				scpd->data->bus_prot_mask,
+				scp->bus_prot_reg_update);
+	}
 
-	return mtk_infracfg_clear_bus_protection(scp->infracfg,
-			scpd->data->bus_prot_mask,
-			scp->bus_prot_reg_update);
+	return mtk_scpsys_ext_clear_bus_protection(scpd->data->bp_table,
+			scp->infracfg, scp->smi_common);
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
@@ -466,6 +474,17 @@ static struct scp *init_scp(struct platform_device *pdev,
 		return ERR_CAST(scp->infracfg);
 	}
 
+	scp->smi_common = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+			"smi_comm");
+
+	if (scp->smi_common == ERR_PTR(-ENODEV)) {
+		scp->smi_common = NULL;
+	} else if (IS_ERR(scp->smi_common)) {
+		dev_err(&pdev->dev, "Cannot find smi_common controller: %ld\n",
+				PTR_ERR(scp->smi_common));
+		return ERR_CAST(scp->smi_common);
+	}
+
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
 		const struct scp_domain_data *data = &scp_domain_data[i];
diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
new file mode 100644
index 0000000..3e5b84d
--- /dev/null
+++ b/include/linux/soc/mediatek/scpsys-ext.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
+#define __SOC_MEDIATEK_SCPSYS_EXT_H
+
+#define MAX_STEPS	4
+
+#define BUS_PROT(_type, _set_ofs, _clr_ofs,			\
+		_en_ofs, _sta_ofs, _mask, _clr_ack_mask) {	\
+		.type = _type,					\
+		.set_ofs = _set_ofs,				\
+		.clr_ofs = _clr_ofs,				\
+		.en_ofs = _en_ofs,				\
+		.sta_ofs = _sta_ofs,				\
+		.mask = _mask,					\
+		.clr_ack_mask = _clr_ack_mask,			\
+	}
+
+enum regmap_type {
+	INVALID_TYPE = 0,
+	IFR_TYPE,
+	SMI_TYPE,
+};
+
+struct bus_prot {
+	enum regmap_type type;
+	u32 set_ofs;
+	u32 clr_ofs;
+	u32 en_ofs;
+	u32 sta_ofs;
+	u32 mask;
+	u32 clr_ack_mask;
+};
+
+int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
+	struct regmap *infracfg, struct regmap *smi_common);
+int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
+	struct regmap *infracfg, struct regmap *smi_common);
+
+#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
-- 
1.8.1.1.dirty

