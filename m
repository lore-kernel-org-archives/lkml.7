Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83153CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE521783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfJVDy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:54:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53990 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730597AbfJVDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:54:54 -0400
X-UUID: d289a01a8e544498a9ea56792d8861a6-20191022
X-UUID: d289a01a8e544498a9ea56792d8861a6-20191022
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <anthony.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 565567059; Tue, 22 Oct 2019 11:54:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Oct 2019 11:54:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Oct 2019 11:54:43 +0800
From:   Anthony Huang <anthony.huang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Anthony Huang <anthony.huang@mediatek.com>
Subject: [RFC PATCH 2/2] soc: mediatek: Add mtk-mmdvfs driver
Date:   Tue, 22 Oct 2019 11:51:53 +0800
Message-ID: <1571716313-10215-3-git-send-email-anthony.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1571716313-10215-1-git-send-email-anthony.huang@mediatek.com>
References: <1571716313-10215-1-git-send-email-anthony.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek MMDVFS driver is used to set clk for Mediatek multimedia
hardwares. The MMDVFS registers a regulator callback and multimedia
hardwares set voltage by regulator API and then this callback will be
triggered. The MMDVFS will get current opp level from opp table according
to the voltage, and then the MMDVFS sets all the clock MUXs to the clock
sources according to the opp level.

On some platforms, both clock MUX and frequency hopping need to be used
together. The MMDVFS supports these two clock setting methods and the
execution sequence of them can be configured in DTS.

Signed-off-by: Anthony Huang <anthony.huang@mediatek.com>
---
 drivers/soc/mediatek/Kconfig      |    9 ++
 drivers/soc/mediatek/Makefile     |    1 +
 drivers/soc/mediatek/mtk-mmdvfs.c |  313 +++++++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-mmdvfs.c

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 2114b56..e92762b 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -44,4 +44,13 @@ config MTK_SCPSYS
 	  Say yes here to add support for the MediaTek SCPSYS power domain
 	  driver.
 
+config MTK_MMDVFS
+	tristate "MediaTek MMDVFS Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Say yes here to add support for the MediaTek Multimedia DVFS (MMDVFS)
+	  driver. The MMDVFS is used to set clk for Mediatek multimedia hardwares
+	  , such as display, camera, mdp and video codec. Say no if your device
+	  does not need to do DVFS for Multimedia hardwares.
+
 endmenu
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index b017330..faf52944 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
+obj-$(CONFIG_MTK_MMDVFS) += mtk-mmdvfs.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
diff --git a/drivers/soc/mediatek/mtk-mmdvfs.c b/drivers/soc/mediatek/mtk-mmdvfs.c
new file mode 100644
index 0000000..f6e45b0
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-mmdvfs.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 MediaTek Inc.
+ */
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+#define MAX_OPP_NUM (6)
+#define MAX_MUX_NUM (10)
+#define MAX_HOPPING_CLK_NUM (2)
+
+enum {
+	ACTION_DEFAULT,
+	ACTION_IHDM, /* Voltage Increase: Hopping First, Decrease: MUX First*/
+};
+
+struct mmdvfs_mux_data {
+	const char *mux_name;
+	struct clk *mux;
+	struct clk *clk_src[MAX_OPP_NUM];
+};
+
+struct mmdvfs_hopping_data {
+	const char *hopping_name;
+	struct clk *hopping_clk;
+	u32 hopping_rate[MAX_OPP_NUM];
+};
+
+struct mmdvfs_drv_data {
+	bool need_change_voltage;
+	u32 request_voltage;
+	u32 num_muxes;
+	struct mmdvfs_mux_data muxes[MAX_MUX_NUM];
+	u32 num_hoppings;
+	struct mmdvfs_hopping_data hoppings[MAX_HOPPING_CLK_NUM];
+	u32 action;
+	struct notifier_block nb;
+	u32 voltages[MAX_OPP_NUM];
+};
+
+static void set_all_muxes(struct mmdvfs_drv_data *drv_data, u32 opp_level)
+{
+	u32 num_muxes = drv_data->num_muxes;
+	u32 i;
+	struct clk *mux, *clk_src;
+	s32 err;
+
+	for (i = 0; i < num_muxes; i++) {
+		mux = drv_data->muxes[i].mux;
+		clk_src = drv_data->muxes[i].clk_src[opp_level];
+		err = clk_prepare_enable(mux);
+
+		if (err) {
+			pr_notice("prepare mux(%s) fail:%d opp_level:%d\n",
+				  drv_data->muxes[i].mux_name, err, opp_level);
+			continue;
+		}
+		err = clk_set_parent(mux, clk_src);
+		if (err)
+			pr_notice("set parent(%s) fail:%d opp_level:%d\n",
+				  drv_data->muxes[i].mux_name, err, opp_level);
+		clk_disable_unprepare(mux);
+	}
+}
+
+static void set_all_hoppings(struct mmdvfs_drv_data *drv_data, u32 opp_level)
+{
+	u32 num_hoppings = drv_data->num_hoppings;
+	u32 i, hopping_rate;
+	struct clk *hopping;
+	s32 err;
+
+	for (i = 0; i < num_hoppings; i++) {
+		hopping = drv_data->hoppings[i].hopping_clk;
+		hopping_rate = drv_data->hoppings[i].hopping_rate[opp_level];
+		err = clk_prepare_enable(hopping);
+
+		if (err) {
+			pr_notice("prepare hopping(%s) fail:%d opp_level:%d\n",
+				  drv_data->hoppings[i].hopping_name,
+				  err, opp_level);
+			continue;
+		}
+		err = clk_set_rate(hopping, hopping_rate);
+		if (err)
+			pr_notice("set %s rate(%u) fail:%d opp_level:%d\n",
+				  drv_data->hoppings[i].hopping_name,
+				  hopping_rate, err, opp_level);
+		clk_disable_unprepare(hopping);
+	}
+}
+
+static void set_all_clk(struct mmdvfs_drv_data *drv_data,
+			u32 voltage, bool vol_inc)
+{
+	u32 i;
+	u32 opp_level;
+
+	for (i = 0; i < MAX_OPP_NUM; i++) {
+		if (drv_data->voltages[i] == voltage) {
+			opp_level = i;
+			break;
+		}
+	}
+	if (i == MAX_OPP_NUM) {
+		pr_notice("voltage(%d) is not found\n", voltage);
+		return;
+	}
+
+	switch (drv_data->action) {
+	/* Voltage Increase: Hopping First, Decrease: MUX First*/
+	case ACTION_IHDM:
+		if (vol_inc) {
+			set_all_hoppings(drv_data, opp_level);
+			set_all_muxes(drv_data, opp_level);
+		} else {
+			set_all_muxes(drv_data, opp_level);
+			set_all_hoppings(drv_data, opp_level);
+		}
+		break;
+	default:
+		set_all_muxes(drv_data, opp_level);
+		break;
+	}
+	pr_debug("set clk to opp level:%d\n", opp_level);
+}
+
+static int regulator_event_notify(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	unsigned long uV;
+	struct mmdvfs_drv_data *drv_data;
+	struct pre_voltage_change_data *pvc_data;
+
+	drv_data = container_of(nb, struct mmdvfs_drv_data, nb);
+
+	if (event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
+		pvc_data = data;
+		uV = pvc_data->min_uV;
+
+		if (uV < pvc_data->old_uV) {
+			set_all_clk(drv_data, uV, false);
+			drv_data->request_voltage = uV;
+		} else if (uV > pvc_data->old_uV) {
+			drv_data->need_change_voltage = true;
+		}
+		pr_debug("regulator event=PRE_VOLTAGE_CHANGE old=%lu new=%lu\n",
+			 pvc_data->old_uV, pvc_data->min_uV);
+	} else if (event == REGULATOR_EVENT_VOLTAGE_CHANGE) {
+		uV = (unsigned long)data;
+		if (drv_data->need_change_voltage) {
+			set_all_clk(drv_data, uV, true);
+			drv_data->need_change_voltage = false;
+			drv_data->request_voltage = uV;
+		}
+		pr_debug("regulator event=VOLTAGE_CHANGE voltage=%lu\n", uV);
+	} else if (event == REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) {
+		uV = (unsigned long)data;
+		/* If clk was changed, restore to previous setting */
+		if (uV != drv_data->request_voltage) {
+			set_all_clk(drv_data, uV,
+				    uV > drv_data->request_voltage);
+			drv_data->need_change_voltage = false;
+			drv_data->request_voltage = uV;
+		}
+		pr_info("regulator event=ABORT_VOLTAGE_CHANGE voltage=%lu\n",
+			uV);
+	}
+	return 0;
+}
+
+static const struct of_device_id of_mmdvfs_match_tbl[] = {
+	{
+		.compatible = "mediatek,mmdvfs",
+	},
+	{}
+};
+
+static int mmdvfs_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mmdvfs_drv_data *drv_data;
+	struct regulator *reg;
+	u32 num_mux = 0, num_hopping = 0;
+	u32 num_clksrc, index, hopping_rate, num_hopping_rate;
+	struct property *mux_prop, *clksrc_prop;
+	struct property *hopping_prop, *hopping_rate_prop;
+	const char *mux_name, *clksrc_name, *hopping_name;
+	char prop_name[32];
+	const __be32 *p;
+	s32 ret;
+	unsigned long freq;
+	struct dev_pm_opp *opp;
+
+	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	of_property_for_each_string(dev->of_node, "mediatek,support_mux",
+				    mux_prop, mux_name) {
+		if (num_mux >= MAX_MUX_NUM) {
+			pr_notice("Too many items in support_mux\n");
+			return -EINVAL;
+		}
+		drv_data->muxes[num_mux].mux = devm_clk_get(dev, mux_name);
+		drv_data->muxes[num_mux].mux_name = mux_name;
+		snprintf(prop_name, sizeof(prop_name) - 1,
+			 "mediatek,mux_%s", mux_name);
+		num_clksrc = 0;
+		of_property_for_each_string(dev->of_node, prop_name,
+					    clksrc_prop, clksrc_name) {
+			if (num_clksrc >= MAX_OPP_NUM) {
+				pr_notice("Too many items in %s\n", prop_name);
+				return -EINVAL;
+			}
+			drv_data->muxes[num_mux].clk_src[num_clksrc] =
+				devm_clk_get(dev, clksrc_name);
+			num_clksrc++;
+		}
+		num_mux++;
+	}
+	drv_data->num_muxes = num_mux;
+
+	of_property_for_each_string(dev->of_node, "mediatek,support_hopping",
+				    hopping_prop, hopping_name) {
+		if (num_hopping >= MAX_HOPPING_CLK_NUM) {
+			pr_notice("Too many items in support_hopping\n");
+			return -EINVAL;
+		}
+		drv_data->hoppings[num_hopping].hopping_clk =
+					devm_clk_get(dev, hopping_name);
+		drv_data->hoppings[num_hopping].hopping_name = hopping_name;
+		snprintf(prop_name, sizeof(prop_name) - 1,
+			 "mediatek,hopping_%s", hopping_name);
+		num_hopping_rate = 0;
+		of_property_for_each_u32(dev->of_node, prop_name,
+					 hopping_rate_prop, p, hopping_rate) {
+			if (num_hopping_rate >= MAX_OPP_NUM) {
+				pr_notice("Too many items in %s\n", prop_name);
+				return -EINVAL;
+			}
+			drv_data->hoppings[num_hopping].hopping_rate
+					[num_hopping_rate] = hopping_rate;
+			num_hopping_rate++;
+		}
+		num_hopping++;
+	}
+	drv_data->num_hoppings = num_hopping;
+
+	of_property_read_u32(dev->of_node,
+			     "mediatek,action", &drv_data->action);
+
+	/* Get voltage info from opp table */
+	dev_pm_opp_of_add_table(dev);
+	freq = 0;
+	index = 0;
+	while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
+		drv_data->voltages[index] = dev_pm_opp_get_voltage(opp);
+		freq++;
+		index++;
+		dev_pm_opp_put(opp);
+	}
+
+	reg = devm_regulator_get(dev, "dvfsrc-vcore");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	drv_data->nb.notifier_call = regulator_event_notify;
+	ret = devm_regulator_register_notifier(reg, &drv_data->nb);
+	if (ret)
+		pr_notice("Failed to register notifier: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver mmdvfs_drv = {
+	.probe = mmdvfs_probe,
+	.driver = {
+		.name = "mtk-mmdvfs",
+		.owner = THIS_MODULE,
+		.of_match_table = of_mmdvfs_match_tbl,
+	},
+};
+
+static int __init mtk_mmdvfs_init(void)
+{
+	s32 status;
+
+	status = platform_driver_register(&mmdvfs_drv);
+	if (status) {
+		pr_notice("Failed to register MMDVFS driver(%d)\n", status);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void __exit mtk_mmdvfs_exit(void)
+{
+	platform_driver_unregister(&mmdvfs_drv);
+}
+
+module_init(mtk_mmdvfs_init);
+module_exit(mtk_mmdvfs_exit);
+
+MODULE_DESCRIPTION("MTK MMDVFS driver");
+MODULE_AUTHOR("Anthony Huang<anthony.huang@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

