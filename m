Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16099C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4C62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQS4H1z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfCLJEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:04:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfCLJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:04:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C94XsI022267;
        Tue, 12 Mar 2019 04:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552381473;
        bh=NI0G55xe65eMXfDiVmR4H5yKLy/RAvlNScN0OR42beY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AQS4H1z0g5tbsSX7bJexZudxh8BSn/9dCSYmfUUCvAJQh3FR2mKomZWlH2NGyO3zZ
         g7J8RvZMd8w7YNXLYg1BL0cFDC+nZc92ScIuCXIHjygbzhhW3LVo8lRdLWbtblTgBh
         49ZDlZD/qCL7Hdv76Q9lt53nNvtgDRSXtDRP+pi4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C94XYN004644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:04:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:04:32 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:04:32 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C94Lfs016945;
        Tue, 12 Mar 2019 04:04:29 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] clk: keystone: Add new driver to handle syscon based clock
Date:   Tue, 12 Mar 2019 14:35:18 +0530
Message-ID: <20190312090518.28666-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312090518.28666-1-vigneshr@ti.com>
References: <20190312090518.28666-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's K2 and K3 SoCs, certain clocks can be gated/ungated by setting a
single bit in SoC's System Control Module registers. Sometime more than
one clock control can be in the same register.
Add driver to support such clocks. Registers that control clocks will be
grouped into a syscon regmap. Each clock node will be child of the
syscon node.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/clk/keystone/Kconfig      |   8 ++
 drivers/clk/keystone/Makefile     |   1 +
 drivers/clk/keystone/syscon-clk.c | 143 ++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/clk/keystone/syscon-clk.c

diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
index b04927d06cd1..6a7b80ee62c9 100644
--- a/drivers/clk/keystone/Kconfig
+++ b/drivers/clk/keystone/Kconfig
@@ -14,3 +14,11 @@ config TI_SCI_CLK
 	  This adds the clock driver support over TI System Control Interface.
 	  If you wish to use clock resources from the PMMC firmware, say Y.
 	  Otherwise, say N.
+
+config TI_SYSCON_CLK
+	tristate "Syscon based clock driver for K2/K3 SoCs"
+	depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
+	default (ARCH_KEYSTONE || ARCH_K3)
+	help
+	  This adds clock driver support for syscon based gate
+	  clocks on TI's K2 and K3 SoCs.
diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
index c12593966f9b..30e481386316 100644
--- a/drivers/clk/keystone/Makefile
+++ b/drivers/clk/keystone/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= pll.o gate.o
 obj-$(CONFIG_TI_SCI_CLK)		+= sci-clk.o
+obj-$(CONFIG_TI_SYSCON_CLK)		+= syscon-clk.o
diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
new file mode 100644
index 000000000000..063a8e5df324
--- /dev/null
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+//
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct ti_syscon_gate_clk_priv {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u32 reg;
+	u32 idx;
+};
+
+static struct
+ti_syscon_gate_clk_priv *to_ti_syscon_gate_clk_priv(struct clk_hw *hw)
+{
+	return container_of(hw, struct ti_syscon_gate_clk_priv, hw);
+}
+
+static int ti_syscon_gate_clk_enable(struct clk_hw *hw)
+{
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	return regmap_write_bits(priv->regmap, priv->reg, priv->idx,
+				 priv->idx);
+}
+
+static void ti_syscon_gate_clk_disable(struct clk_hw *hw)
+{
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	regmap_write_bits(priv->regmap, priv->reg, priv->idx, 0);
+}
+
+static int ti_syscon_gate_clk_is_enabled(struct clk_hw *hw)
+{
+	unsigned int val;
+	struct ti_syscon_gate_clk_priv *priv = to_ti_syscon_gate_clk_priv(hw);
+
+	regmap_read(priv->regmap, priv->reg, &val);
+
+	return !!(val & priv->idx);
+}
+
+static const struct clk_ops ti_syscon_gate_clk_ops = {
+	.enable		= ti_syscon_gate_clk_enable,
+	.disable	= ti_syscon_gate_clk_disable,
+	.is_enabled	= ti_syscon_gate_clk_is_enabled,
+};
+
+static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct ti_syscon_gate_clk_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct clk_init_data init;
+	unsigned long flags = 0;
+	const char *parent_name;
+	struct clk *parent;
+	u32 idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_node_to_regmap(of_get_parent(node));
+	if (IS_ERR(priv->regmap)) {
+		if (PTR_ERR(priv->regmap) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(dev, "failed to find parent regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	if (of_property_read_u32(node, "reg", &priv->reg)) {
+		dev_err(dev, "missing reg property\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "ti,clock-bit-idx", &idx)) {
+		dev_err(dev, "missing ti,bit-shift property\n");
+		return -EINVAL;
+	}
+	priv->idx = BIT(idx);
+
+	if (of_clk_get_parent_count(node) != 1) {
+		dev_err(dev, "must have clk parent\n");
+		return -EINVAL;
+	}
+
+	parent = devm_clk_get(dev, NULL);
+	if (IS_ERR(parent)) {
+		if (PTR_ERR(priv->regmap) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		return PTR_ERR(parent);
+	}
+
+	parent_name = __clk_get_name(parent);
+
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn:%04x:%d",
+				   node, priv->reg, idx);
+	init.ops = &ti_syscon_gate_clk_ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	priv->hw.init = &init;
+	ret = devm_clk_hw_register(&pdev->dev, &priv->hw);
+	if (ret < 0) {
+		dev_err(dev, "failed to register clk err: %d\n", ret);
+		return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, priv);
+}
+
+static const struct of_device_id ti_syscon_gate_clk_ids[] = {
+	{ .compatible = "ti,syscon-gate-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
+
+static struct platform_driver ti_syscon_gate_clk_driver = {
+	.probe = ti_syscon_gate_clk_probe,
+	.driver = {
+		.name = "ti-syscon-gate-clk",
+		.of_match_table = ti_syscon_gate_clk_ids,
+	},
+};
+
+module_platform_driver(ti_syscon_gate_clk_driver);
+
+MODULE_ALIAS("platform:ti-syscon-gate-clk");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Syscon backed gate-clock driver");
+MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
-- 
2.21.0

