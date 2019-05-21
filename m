Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8FC16A69
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8009821773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XO9Dv5bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUXb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8575 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEUXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a430000>; Tue, 21 May 2019 16:31:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:18 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a45000a>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 06/12] clk: tegra: add suspend resume support for DFLL clock
Date:   Tue, 21 May 2019 16:31:17 -0700
Message-ID: <1558481483-22254-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481475; bh=lTpT7DxosrZ9TQTC+BpXXH/Ud8iXV1MHsBfPb7XBsEY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XO9Dv5bMvzgyWYlN3n5KvB1sC26LQ5LYyhAhpcsd80V6qscy8tNn6Grb9fKuWXouM
         jVw2vj5wXaIRVbivv5jFopVHL6CWDKh5hUFoej46YcpFvcbDH157Fc6zhqKCq87djW
         5W6mtC6iWxDQFl42/dNioIj1n1KjszK0jq0xjgskBHLR3TnUebK0Os2e0093bCfUTN
         Scv2uDRhTlFwIJYoCHzb2QCAl0EgcAldrlPiZnWJgjJzGFQidOdj2tWR11eboiSuln
         3uj2Y3omvlziTuxKvwoFlnHuQitbQFByp8YjfB6XAAtQmPceTZdVHnriDzjFV3/XR2
         vIWe82QNxq6ig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for suspend and resume for DFLL clock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h |  2 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 1fc71baae13b..d92a5a05fbbc 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -286,6 +286,7 @@ struct tegra_dfll {
 	unsigned long			dvco_rate_min;
 
 	enum dfll_ctrl_mode		mode;
+	enum dfll_ctrl_mode		resume_mode;
 	enum dfll_tune_range		tune_range;
 	struct dentry			*debugfs_dir;
 	struct clk_hw			dfll_clk_hw;
@@ -1873,6 +1874,87 @@ static int dfll_fetch_common_params(struct tegra_dfll *td)
 }
 
 /*
+ * tegra_dfll_suspend
+ * @pdev: DFLL instance
+ *
+ * dfll controls clock/voltage to other devices, including CPU. Therefore,
+ * dfll driver pm suspend callback does not stop cl-dvfs operations. It is
+ * only used to enforce cold voltage limit, since SoC may cool down during
+ * suspend without waking up. The correct temperature zone after suspend will
+ * be updated via dfll cooling device interface during resume of temperature
+ * sensor.
+ */
+void tegra_dfll_suspend(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	if (!td)
+		return;
+
+	if (td->mode <= DFLL_DISABLED)
+		return;
+
+	td->resume_mode = td->mode;
+	switch (td->mode) {
+	case DFLL_CLOSED_LOOP:
+		dfll_set_mode(td, DFLL_CLOSED_LOOP);
+		dfll_set_frequency_request(td, &td->last_req);
+
+		dfll_unlock(td);
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * tegra_dfll_resume - reprogram the DFLL after context-loss
+ * @pdev: DFLL instance
+ *
+ * Re-initialize and enable target device clock in open loop mode. Called
+ * directly from SoC clock resume syscore operation. Closed loop will be
+ * re-entered in platform syscore ops as well after CPU clock source is
+ * switched to DFLL in open loop.
+ */
+void tegra_dfll_resume(struct platform_device *pdev, bool on_dfll)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	if (!td)
+		return;
+
+	if (on_dfll) {
+		if (td->resume_mode == DFLL_CLOSED_LOOP)
+			dfll_lock(td);
+		td->resume_mode = DFLL_DISABLED;
+		return;
+	}
+
+	reset_control_deassert(td->dvco_rst);
+
+	pm_runtime_get(td->dev);
+
+	/* Re-init DFLL */
+	dfll_init_out_if(td);
+	dfll_set_default_params(td);
+	dfll_set_open_loop_config(td);
+
+	pm_runtime_put(td->dev);
+
+	/* Restore last request and mode up to open loop */
+	switch (td->resume_mode) {
+	case DFLL_CLOSED_LOOP:
+	case DFLL_OPEN_LOOP:
+		dfll_set_mode(td, DFLL_OPEN_LOOP);
+		if (td->pmu_if == TEGRA_DFLL_PMU_I2C)
+			dfll_i2c_set_output_enabled(td, false);
+		break;
+	default:
+		break;
+	}
+}
+
+/*
  * API exported to per-SoC platform drivers
  */
 
diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
index 85d0d95223f3..44160b0495fe 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -48,6 +48,8 @@ struct tegra_dfll_soc_data {
 int tegra_dfll_register(struct platform_device *pdev,
 			struct tegra_dfll_soc_data *soc);
 struct tegra_dfll_soc_data *tegra_dfll_unregister(struct platform_device *pdev);
+void tegra_dfll_suspend(struct platform_device *pdev);
+void tegra_dfll_resume(struct platform_device *pdev, bool on_dfll);
 int tegra_dfll_runtime_suspend(struct device *dev);
 int tegra_dfll_runtime_resume(struct device *dev);
 
-- 
2.7.4

