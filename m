Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B1C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E011F2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rJYyeO73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfEUXcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:32:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1178 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEUXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a470000>; Tue, 21 May 2019 16:31:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 May 2019 16:31:17 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450005>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 02/12] pinctrl: tegra: add suspend and resume support
Date:   Tue, 21 May 2019 16:31:13 -0700
Message-ID: <1558481483-22254-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481479; bh=p3J1CYhwsjtUtkBmkpttxn2JlqCbqP5w81Q4lI707ZU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rJYyeO73U545i9zJ0lsG0uWoGlnDU4Pwc8GR3+chu6EGxhk3SWc/GCx54u514E6a5
         whH20hlUCKTSnStqxjqHq3m1Mk7mcd8mvPK+g/rmjQ45Nkh6Q075NzTHM4aj9kSj/r
         GrrRT9iL80ih4gDAVNREV19ODSH1B0mLmcEN6nj0/RI76jLfLjdHVkrxydeNcqIykF
         VSHmQ5if+cwLJYmVFCu+xZ9tpLE/WheI/L094LuV+G/5gl7RmJP7MlMPaxw9WUVQ6r
         vuiO/5VWed8hOozKaBVYDRY8IKOnhX3j51fIM3xh6iWtOt2fR5VPg1hnf9hXF8H3WX
         8a54lB/dEbEuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume support for Tegra pinctrl driver
and registers them to syscore so the pinmux settings are restored
before the devices resume.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c    | 68 +++++++++++++++++++++++++++++++-
 drivers/pinctrl/tegra/pinctrl-tegra.h    |  3 ++
 drivers/pinctrl/tegra/pinctrl-tegra114.c |  1 +
 drivers/pinctrl/tegra/pinctrl-tegra124.c |  1 +
 drivers/pinctrl/tegra/pinctrl-tegra20.c  |  1 +
 drivers/pinctrl/tegra/pinctrl-tegra210.c |  1 +
 drivers/pinctrl/tegra/pinctrl-tegra30.c  |  1 +
 7 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index a5008c066bac..585debbc4291 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -28,11 +28,18 @@
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
 #include "pinctrl-tegra.h"
 
+#define EMMC2_PAD_CFGPADCTRL_0			0x1c8
+#define EMMC4_PAD_CFGPADCTRL_0			0x1e0
+#define EMMC_DPD_PARKING			(0x1FFF << 14)
+
+static struct tegra_pmx *pmx;
+
 static inline u32 pmx_readl(struct tegra_pmx *pmx, u32 bank, u32 reg)
 {
 	return readl(pmx->regs[bank] + reg);
@@ -629,6 +636,50 @@ static void tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
 	}
 }
 
+static int __maybe_unused tegra_pinctrl_suspend(void)
+{
+	u32 *pg_data = pmx->pg_data;
+	u32 *regs;
+	int i, j;
+
+	for (i = 0; i < pmx->nbanks; i++) {
+		regs = pmx->regs[i];
+		for (j = 0; j < pmx->reg_bank_size[i] / 4; j++)
+			*pg_data++ = readl(regs++);
+	}
+
+	return pinctrl_force_sleep(pmx->pctl);
+}
+
+static void __maybe_unused tegra_pinctrl_resume(void)
+{
+	u32 *pg_data = pmx->pg_data;
+	u32 *regs;
+	u32 val;
+	int i, j;
+
+	for (i = 0; i < pmx->nbanks; i++) {
+		regs = pmx->regs[i];
+		for (j = 0; j < pmx->reg_bank_size[i] / 4; j++)
+			writel(*pg_data++, regs++);
+	}
+
+	if (pmx->soc->has_park_padcfg) {
+		val = pmx_readl(pmx, 0, EMMC2_PAD_CFGPADCTRL_0);
+		val &= ~EMMC_DPD_PARKING;
+		pmx_writel(pmx, val, 0, EMMC2_PAD_CFGPADCTRL_0);
+
+		val = pmx_readl(pmx, 0, EMMC4_PAD_CFGPADCTRL_0);
+		val &= ~EMMC_DPD_PARKING;
+		pmx_writel(pmx, val, 0, EMMC4_PAD_CFGPADCTRL_0);
+	}
+}
+
+static struct syscore_ops pinctrl_syscore_ops = {
+	.suspend = tegra_pinctrl_suspend,
+	.resume = tegra_pinctrl_resume,
+};
+
 static bool gpio_node_has_range(const char *compatible)
 {
 	struct device_node *np;
@@ -648,11 +699,11 @@ static bool gpio_node_has_range(const char *compatible)
 int tegra_pinctrl_probe(struct platform_device *pdev,
 			const struct tegra_pinctrl_soc_data *soc_data)
 {
-	struct tegra_pmx *pmx;
 	struct resource *res;
 	int i;
 	const char **group_pins;
 	int fn, gn, gfn;
+	int pg_data_size = 0;
 
 	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
 	if (!pmx)
@@ -705,6 +756,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res)
 			break;
+		pg_data_size += resource_size(res);
 	}
 	pmx->nbanks = i;
 
@@ -712,12 +764,25 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 				 GFP_KERNEL);
 	if (!pmx->regs)
 		return -ENOMEM;
+#ifdef CONFIG_PM_SLEEP
+	pmx->reg_bank_size = devm_kcalloc(&pdev->dev, pmx->nbanks,
+					  sizeof(*pmx->reg_bank_size),
+					  GFP_KERNEL);
+	if (!pmx->reg_bank_size)
+		return -ENOMEM;
 
+	pmx->pg_data = devm_kzalloc(&pdev->dev, pg_data_size, GFP_KERNEL);
+	if (!pmx->pg_data)
+		return -ENOMEM;
+#endif
 	for (i = 0; i < pmx->nbanks; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		pmx->regs[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmx->regs[i]))
 			return PTR_ERR(pmx->regs[i]);
+#ifdef CONFIG_PM_SLEEP
+		pmx->reg_bank_size[i] = resource_size(res);
+#endif
 	}
 
 	pmx->pctl = devm_pinctrl_register(&pdev->dev, &tegra_pinctrl_desc, pmx);
@@ -732,6 +797,7 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 		pinctrl_add_gpio_range(pmx->pctl, &tegra_pinctrl_gpio_range);
 
 	platform_set_drvdata(pdev, pmx);
+	register_syscore_ops(&pinctrl_syscore_ops);
 
 	dev_dbg(&pdev->dev, "Probed Tegra pinctrl driver\n");
 
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index 44c71941b5f8..8c7cd94124ea 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -25,6 +25,8 @@ struct tegra_pmx {
 
 	int nbanks;
 	void __iomem **regs;
+	int *reg_bank_size;
+	u32 *pg_data;
 };
 
 enum tegra_pinconf_param {
@@ -199,6 +201,7 @@ struct tegra_pinctrl_soc_data {
 	bool hsm_in_mux;
 	bool schmitt_in_mux;
 	bool drvtype_in_mux;
+	bool has_park_padcfg;
 };
 
 int tegra_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index d43c209e9c30..4ac44f34dccf 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1849,6 +1849,7 @@ static const struct tegra_pinctrl_soc_data tegra114_pinctrl = {
 	.hsm_in_mux = false,
 	.schmitt_in_mux = false,
 	.drvtype_in_mux = false,
+	.has_park_padcfg = false,
 };
 
 static int tegra114_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 5b07a5834d15..1dac7648b41f 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -2061,6 +2061,7 @@ static const struct tegra_pinctrl_soc_data tegra124_pinctrl = {
 	.hsm_in_mux = false,
 	.schmitt_in_mux = false,
 	.drvtype_in_mux = false,
+	.has_park_padcfg = false,
 };
 
 static int tegra124_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 1fc82a9576e0..9d2b25200f32 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2231,6 +2231,7 @@ static const struct tegra_pinctrl_soc_data tegra20_pinctrl = {
 	.hsm_in_mux = false,
 	.schmitt_in_mux = false,
 	.drvtype_in_mux = false,
+	.has_park_padcfg = false,
 };
 
 static const char *cdev1_parents[] = {
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index 3e77f5474dd8..dc06c36e698a 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1563,6 +1563,7 @@ static const struct tegra_pinctrl_soc_data tegra210_pinctrl = {
 	.hsm_in_mux = true,
 	.schmitt_in_mux = true,
 	.drvtype_in_mux = true,
+	.has_park_padcfg = true,
 };
 
 static int tegra210_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index 10e617003e9c..42182d714950 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2484,6 +2484,7 @@ static const struct tegra_pinctrl_soc_data tegra30_pinctrl = {
 	.hsm_in_mux = false,
 	.schmitt_in_mux = false,
 	.drvtype_in_mux = false,
+	.has_park_padcfg = false,
 };
 
 static int tegra30_pinctrl_probe(struct platform_device *pdev)
-- 
2.7.4

