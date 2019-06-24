Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB2AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A827208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OPRUZujR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfFXDDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:03:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13211 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfFXDD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:03:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d103d800000>; Sun, 23 Jun 2019 20:03:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 23 Jun 2019 20:03:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 23 Jun 2019 20:03:28 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 03:03:28 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 03:03:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 03:03:28 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.126]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d103d7d0002>; Sun, 23 Jun 2019 20:03:28 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 09/18] clk: tegra: add suspend resume support for DFLL
Date:   Sun, 23 Jun 2019 20:02:50 -0700
Message-ID: <1561345379-2429-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561345379-2429-1-git-send-email-skomatineni@nvidia.com>
References: <1561345379-2429-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561345408; bh=dps+xdpNYqPp4cSiwoi1+rWcYiqKiL43QEvLjCGhFJY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OPRUZujR2TR2fc5xPjvlERr2nQpYcS7/Xhi0yMLvzzi0oaORMGHHWEgyBWAKChmB9
         ocrBjWiBSBsAvaSPAqEGdbITyeEcwvm+viibo8HNBvoDwuqI7+mgNVpRKA8mTgmQli
         aD3RcPSPLUk0ZbzBlHqJAL9zGMjgKvsKsdcWYVq2oj0gd2qz/vjGm47S6ZRqSwBVWL
         2B+1jsl2X2S2mDNFHkVc7uKPwJ9KosJVGBdD7osCnN6EY2cB8rZJ968f7ZfL6LBuek
         WRiIANrerBMESoJwMUyxkcdzEe6ePOYONm5QTjM5H2ERUyAFn/Xj2Y9AvQVQR6QeeH
         mywqxQSfsLbzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates APIs for supporting Tegra210 clock driver to
perform DFLL suspend and resume operation.

During suspend, DFLL mode is saved and on resume Tegra210 clock driver
invokes DFLL resume API to re-initialize DFLL to enable target device
clock in open loop mode or closed loop mode.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index f8688c2ddf1a..a1f37cf99b00 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -277,6 +277,7 @@ struct tegra_dfll {
 	unsigned long			dvco_rate_min;
 
 	enum dfll_ctrl_mode		mode;
+	enum dfll_ctrl_mode		resume_mode;
 	enum dfll_tune_range		tune_range;
 	struct dentry			*debugfs_dir;
 	struct clk_hw			dfll_clk_hw;
@@ -1864,6 +1865,83 @@ static int dfll_fetch_common_params(struct tegra_dfll *td)
 }
 
 /*
+ * tegra_dfll_suspend
+ * @pdev: DFLL instance
+ *
+ * dfll controls clock/voltage to other devices, including CPU. Therefore,
+ * dfll driver pm suspend callback does not stop cl-dvfs operations.
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
index 1b14ebe7268b..c21fc2061a20 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -40,6 +40,8 @@ struct tegra_dfll_soc_data {
 int tegra_dfll_register(struct platform_device *pdev,
 			struct tegra_dfll_soc_data *soc);
 struct tegra_dfll_soc_data *tegra_dfll_unregister(struct platform_device *pdev);
+void tegra_dfll_suspend(struct platform_device *pdev);
+void tegra_dfll_resume(struct platform_device *pdev, bool on_dfll);
 int tegra_dfll_runtime_suspend(struct device *dev);
 int tegra_dfll_runtime_resume(struct device *dev);
 
-- 
2.7.4

