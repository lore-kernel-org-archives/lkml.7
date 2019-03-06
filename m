Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF34C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4A20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKRcvIa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfCFRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:47:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38655 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbfCFRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:47:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id m2so8978997pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQqRiUcOBnf84owwha1uaK826K7g8AcK1SIu5pAC4cY=;
        b=yKRcvIa0DkIaHDQxu1z4+ypdBKlq6eamk8w3W+jcg+s/8cpAdwFSARvx0egLS8JL9H
         CS5/NHTedguwCIt/3AZXEEz771qMkyNa9+v3m1OPfHKieGPNy6hu/mkB56br8ECcPCBG
         nZCD2YaZHUyT2m9TdqPwgtyaV4p/akJPn4w1OtEDmKs3JWjP+q94mz0DNHu8EliWVcqs
         9IT/28u0wylN6Dg6CFlNW0GCyIujGYNWx5iA+AbYA/y3hML9THBqby78VVc0NNKnKcP7
         nkzJzPfIzzUAeP2Fp4Jt7ZUEn1lKM3jBbBlDC7Ix5DMcCynV8uCGyMhwKzlCayCMvCEC
         oCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQqRiUcOBnf84owwha1uaK826K7g8AcK1SIu5pAC4cY=;
        b=guEM35ODoL8tyAM6w4otNlkc4hBY8CcmiVp0XD31Lobo98c9YytaYIZh+4iQ5o+v6K
         80x9XqY8OaI7ICnEe1/fdRkpItSZbArYLhx0sR0Bl7G0xDgSIUpXo32/xAM5W3GjF7Ri
         qmBTnWd/xrNpgZC4nBPM7d0KFRXRYu8sYw3TSrWxZhBskPqj+e0QZLUwgNP5WyexZN6k
         dbEvdBINjJHCbVtpttduF/26sadgfMowJbQvEoSfA1LYGgws76xFVkzsQRfhs8xzvao1
         t2u/VislYXz95nrhs+yM4hm6PN/e4H2TYvI9sG8IXGRfbvjvGINu4B+G5B5S8qLn+yM3
         YBtQ==
X-Gm-Message-State: APjAAAVd2ax9zFh4e84M/JaW5e6aQJf5mkmUeEZvepxz+794kJP26+Pk
        P+xgwBvCJF60ZL0vbzZHsunJpQ==
X-Google-Smtp-Source: APXvYqyoyy8QD4QZPgCyvUZnyDFGKoidnJexwhZekrgpy3BMswO/hlD4V1uBvgGFEupbUzqGhOxTyw==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr8297130pfj.118.1551894434669;
        Wed, 06 Mar 2019 09:47:14 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h64sm4098293pfj.40.2019.03.06.09.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:47:14 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: qcom: Add QCS404 TuringCC
Date:   Wed,  6 Mar 2019 09:47:58 -0800
Message-Id: <20190306174758.22462-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190306174758.22462-1-bjorn.andersson@linaro.org>
References: <20190306174758.22462-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Turing Clock Controller provides resources related to running the
Turing subsystem.

PM runtime is used to ensure that the associated AHB clock is ticking
while the clock framework is accessing the registers in the Turing clock
controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/Kconfig           |   6 +
 drivers/clk/qcom/Makefile          |   1 +
 drivers/clk/qcom/turingcc-qcs404.c | 170 +++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/clk/qcom/turingcc-qcs404.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1c04575c118f..18bdf34d5e64 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -243,6 +243,12 @@ config SDM_GCC_660
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2C, USB, UFS, SDDC, PCIe, etc.
 
+config QCS_TURING_404
+	tristate "QCS404 Turing Clock Controller"
+	help
+	  Support for the Turing Clock Controller on QCS404, provides clocks
+	  and resets for the Turing subsystem.
+
 config SDM_GCC_845
 	tristate "SDM845 Global Clock Controller"
 	select QCOM_GDSC
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index ee8d0698e370..f0768fb1f037 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
+obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
 obj-$(CONFIG_SDM_CAMCC_845) += camcc-sdm845.o
 obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SDM_GCC_660) += gcc-sdm660.o
diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
new file mode 100644
index 000000000000..aa859e6ec9bd
--- /dev/null
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,turingcc-qcs404.h>
+
+#include "clk-regmap.h"
+#include "clk-branch.h"
+#include "common.h"
+#include "reset.h"
+
+static struct clk_branch turing_wrapper_aon_cbcr = {
+	.halt_reg = 0x5098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "turing_wrapper_aon_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch turing_q6ss_ahbm_aon_cbcr = {
+	.halt_reg = 0x9000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "turing_q6ss_ahbm_aon_cbcr",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch turing_q6ss_q6_axim_clk = {
+	.halt_reg = 0xb000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xb000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "turing_q6ss_q6_axim_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch turing_q6ss_ahbs_aon_cbcr = {
+	.halt_reg = 0x10000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x10000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "turing_q6ss_ahbs_aon_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch turing_wrapper_qos_ahbs_aon_cbcr = {
+	.halt_reg = 0x11014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x11014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data) {
+			.name = "turing_wrapper_qos_ahbs_aon_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_regmap *turingcc_clocks[] = {
+	[TURING_WRAPPER_AON_CLK] = &turing_wrapper_aon_cbcr.clkr,
+	[TURING_Q6SS_AHBM_AON_CLK] = &turing_q6ss_ahbm_aon_cbcr.clkr,
+	[TURING_Q6SS_Q6_AXIM_CLK] = &turing_q6ss_q6_axim_clk.clkr,
+	[TURING_Q6SS_AHBS_AON_CLK] = &turing_q6ss_ahbs_aon_cbcr.clkr,
+	[TURING_WRAPPER_QOS_AHBS_AON_CLK] = &turing_wrapper_qos_ahbs_aon_cbcr.clkr,
+};
+
+static const struct regmap_config turingcc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x30000,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc turingcc_desc = {
+	.config = &turingcc_regmap_config,
+	.clks = turingcc_clocks,
+	.num_clks = ARRAY_SIZE(turingcc_clocks),
+};
+
+static int turingcc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_clk_create(&pdev->dev);
+	if (ret)
+		goto disable_pm_runtime;
+
+	ret = pm_clk_add(&pdev->dev, NULL);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to acquire iface clock\n");
+		goto destroy_pm_clk;
+	}
+
+	ret = qcom_cc_probe(pdev, &turingcc_desc);
+	if (ret < 0)
+		goto destroy_pm_clk;
+
+	return 0;
+
+destroy_pm_clk:
+	pm_clk_destroy(&pdev->dev);
+
+disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int turingcc_remove(struct platform_device *pdev)
+{
+	pm_clk_destroy(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops turingcc_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
+static const struct of_device_id turingcc_match_table[] = {
+	{ .compatible = "qcom,qcs404-turingcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, turingcc_match_table);
+
+static struct platform_driver turingcc_driver = {
+	.probe		= turingcc_probe,
+	.remove		= turingcc_remove,
+	.driver		= {
+		.name	= "qcs404-turingcc",
+		.of_match_table = turingcc_match_table,
+		.pm = &turingcc_pm_ops,
+	},
+};
+
+module_platform_driver(turingcc_driver);
+
+MODULE_DESCRIPTION("Qualcomm QCS404 Turing Clock Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

