Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47BC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C8921744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfD3Jph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:45:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56534 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727094AbfD3Jpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:45:31 -0400
X-UUID: d16948d04a5742ac88815ba0da306b03-20190430
X-UUID: d16948d04a5742ac88815ba0da306b03-20190430
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1515585535; Tue, 30 Apr 2019 17:45:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 17:45:20 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 17:45:20 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC V2 10/11] interconnect: mediatek: Add mt8183 interconnect provider driver
Date:   Tue, 30 Apr 2019 16:51:04 +0800
Message-ID: <1556614265-12745-11-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Mediatek MT8183 specific provider driver using the
interconnect framework.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/interconnect/Kconfig           |   1 +
 drivers/interconnect/Makefile          |   1 +
 drivers/interconnect/mediatek/Kconfig  |  13 ++
 drivers/interconnect/mediatek/Makefile |   5 +
 drivers/interconnect/mediatek/mt8183.c | 223 +++++++++++++++++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/mt8183.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 07a8276..ac41ea6 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -11,5 +11,6 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/mediatek/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0..253f24a3 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,3 +4,4 @@ icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_MTK)		+= mediatek/
diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
new file mode 100644
index 0000000..0686494
--- /dev/null
+++ b/drivers/interconnect/mediatek/Kconfig
@@ -0,0 +1,13 @@
+config INTERCONNECT_MTK
+	bool "Mediatek Network-on-Chip interconnect drivers"
+	depends on ARCH_MEDIATEK
+	help
+	  Support for Mediatek's Network-on-Chip interconnect hardware.
+
+config INTERCONNECT_MTK_MT8183
+	tristate "Mediatek MT8183 interconnect driver"
+	depends on INTERCONNECT_MTK
+	depends on (MTK_DVFSRC && OF)
+	help
+	  This is a driver for the Mediatek Network-on-Chip on mt8183-based
+	  platforms.
diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
new file mode 100644
index 0000000..a39ceee
--- /dev/null
+++ b/drivers/interconnect/mediatek/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+mtk-mt8183-objs			:= mt8183.o
+
+obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mtk-mt8183.o
\ No newline at end of file
diff --git a/drivers/interconnect/mediatek/mt8183.c b/drivers/interconnect/mediatek/mt8183.c
new file mode 100644
index 0000000..38ffe0b
--- /dev/null
+++ b/drivers/interconnect/mediatek/mt8183.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <dt-bindings/interconnect/mtk,mt8183.h>
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <soc/mediatek/mtk_dvfsrc.h>
+
+#define MT8183_MAX_LINKS	6
+
+/**
+ * struct mtk_icc_node - Mediatek specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @ep: true if the node is an end point.
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @buswidth: width of the interconnect between a node and the bus
+ * @sum_avg: current sum aggregate value of all avg bw requests
+ * @max_peak: current max aggregate value of all peak bw requests
+ */
+struct mtk_icc_node {
+	unsigned char *name;
+	bool ep;
+	u16 id;
+	u16 links[MT8183_MAX_LINKS];
+	u16 num_links;
+	u16 buswidth;
+	u64 sum_avg;
+	u64 max_peak;
+};
+
+struct mtk_icc_desc {
+	struct mtk_icc_node **nodes;
+	size_t num_nodes;
+};
+
+#define DEFINE_MNODE(_name, _id, _buswidth, _ep, _numlinks, ...)	\
+		static struct mtk_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.buswidth = _buswidth,					\
+		.ep = _ep,						\
+		.num_links = _numlinks,					\
+		.links = { __VA_ARGS__ },				\
+}
+
+DEFINE_MNODE(ddr_emi, SLAVE_DDR_EMI, 1024, 1, 0, 0);
+DEFINE_MNODE(mcusys, MASTER_MCUSYS, 256, 0, 1, SLAVE_DDR_EMI);
+DEFINE_MNODE(gpu, MASTER_GPU, 256, 0, 1, SLAVE_DDR_EMI);
+DEFINE_MNODE(mmsys, MASTER_MMSYS, 256, 0, 1, SLAVE_DDR_EMI);
+DEFINE_MNODE(mm_vpu, MASTER_MM_VPU, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_disp, MASTER_MM_DISP, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_vdec, MASTER_MM_VDEC, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_venc, MASTER_MM_VENC, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_cam, MASTER_MM_CAM, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_img, MASTER_MM_IMG, 128, 0, 1, MASTER_MMSYS);
+DEFINE_MNODE(mm_mdp, MASTER_MM_MDP, 128, 0, 1, MASTER_MMSYS);
+
+static struct mtk_icc_node *mt8183_icc_nodes[] = {
+	&ddr_emi,
+	&mcusys,
+	&gpu,
+	&mmsys,
+	&mm_vpu,
+	&mm_disp,
+	&mm_vdec,
+	&mm_venc,
+	&mm_cam,
+	&mm_img,
+	&mm_mdp,
+};
+
+static struct mtk_icc_desc mt8183_icc = {
+	.nodes = mt8183_icc_nodes,
+	.num_nodes = ARRAY_SIZE(mt8183_icc_nodes),
+};
+
+static int mt8183_icc_aggregate(struct icc_node *node, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	struct mtk_icc_node *in;
+
+	in = node->data;
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+
+	in->sum_avg = *agg_avg;
+	in->max_peak = *agg_peak;
+
+	return 0;
+}
+
+static int mt8183_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	int ret = 0;
+	struct mtk_icc_node *node;
+
+	node = dst->data;
+	if (node->ep) {
+		pr_debug("sum_avg (%llu), max_peak (%llu)\n",
+			node->sum_avg, node->max_peak);
+		mtk_dvfsrc_send_request(src->provider->dev->parent,
+					MTK_DVFSRC_CMD_BW_REQUEST,
+					node->max_peak);
+	}
+
+	return ret;
+}
+
+static int mt8183_icc_probe(struct platform_device *pdev)
+{
+	int ret;
+	const struct mtk_icc_desc *desc;
+	struct icc_node *node;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct mtk_icc_node **mnodes;
+	size_t num_nodes, i, j;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	mnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	provider = devm_kzalloc(&pdev->dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+
+	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider->dev = &pdev->dev;
+	provider->set = mt8183_icc_set;
+	provider->aggregate = mt8183_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = data;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		node = icc_node_create(mnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = mnodes[i]->name;
+		node->data = mnodes[i];
+		icc_node_add(node, provider);
+
+		dev_dbg(&pdev->dev, "registered node %s, num link: %d\n",
+			mnodes[i]->name, mnodes[i]->num_links);
+
+		/* populate links */
+		for (j = 0; j < mnodes[i]->num_links; j++)
+			icc_link_create(node, mnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	platform_set_drvdata(pdev, provider);
+
+	return ret;
+err:
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		icc_node_del(node);
+		icc_node_destroy(node->id);
+	}
+
+	icc_provider_del(provider);
+	return ret;
+}
+
+static int mt8183_icc_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct icc_node *n;
+
+	list_for_each_entry(n, &provider->nodes, node_list) {
+		icc_node_del(n);
+		icc_node_destroy(n->id);
+	}
+
+	return icc_provider_del(provider);
+}
+
+static const struct of_device_id mt8183_icc_of_match[] = {
+	{ .compatible = "mediatek,mt8183-emi-icc", .data = &mt8183_icc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mt8183_icc_of_match);
+
+static struct platform_driver mt8183_icc_driver = {
+	.probe = mt8183_icc_probe,
+	.remove = mt8183_icc_remove,
+	.driver = {
+		.name = "mt8183-emi-icc",
+		.of_match_table = mt8183_icc_of_match,
+	},
+};
+module_platform_driver(mt8183_icc_driver);
+
+MODULE_AUTHOR("Henry Chen <henryc.chen@mediatek.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

