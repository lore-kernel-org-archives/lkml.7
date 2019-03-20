Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iwSYGfdY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c02nylt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfCTJu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51576 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfCTJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E0FE6155E; Wed, 20 Mar 2019 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075423;
        bh=VZTHR6HLMsAqO1DlnUeZRPMqWPJZemu+fAHVc5nzg20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwSYGfdYbKot2LNwuL1K24gwANpQKsUrt+3re3N24mn0chYGIDDryymbyPnS/suWD
         62RY8F5AX3EkdEdthTsSu4UXsi6mLD3fBUMgIBM09nH82R9Ofndu1upewEkaTbvYmq
         yYh3mdh9HpDPWivz8E+OqQJc073kYRUO4JtANmfk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C25606141D;
        Wed, 20 Mar 2019 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075417;
        bh=VZTHR6HLMsAqO1DlnUeZRPMqWPJZemu+fAHVc5nzg20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c02nylt+scrxcb3PU35/ROd2TY23MEakDhJvIZ3cC0OgMenW/gVibmur+yR/aKvlM
         o9r5GibJkQ8Nla6mvJsSYoXw8IoSOCrI+M4uKTnD7HWW8qxb+LTmOm0ZcM+x/EqCbT
         85SMwPbM2Z1/DkXkjh0NvQ4kaLJ3Gb0OdUy+06tQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C25606141D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 10/11] drm/msm: dsi: Use OPP API to set clk/perf state
Date:   Wed, 20 Mar 2019 15:19:17 +0530
Message-Id: <20190320094918.20234-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SDM845 DSI needs to express a perforamnce state
requirement on a power domain depending on the clock rates.
Use OPP table from DT to register with OPP framework and use
dev_pm_opp_set_rate() to set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h      |  2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  |  4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c | 88 +++++++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 9c6b31c2d79f..b4398a798370 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -188,8 +188,10 @@ int msm_dsi_runtime_suspend(struct device *dev);
 int msm_dsi_runtime_resume(struct device *dev);
 int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
 int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
+int dsi_link_clk_enable_6g_v2(struct msm_dsi_host *msm_host);
 void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host);
 void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host);
+void dsi_link_clk_disable_6g_v2(struct msm_dsi_host *msm_host);
 int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size);
 int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size);
 void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index dcdfb1bb54f9..c18532f92e4a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -159,8 +159,8 @@ const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
 };
 
 const static struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
-	.link_clk_enable = dsi_link_clk_enable_6g,
-	.link_clk_disable = dsi_link_clk_disable_6g,
+	.link_clk_enable = dsi_link_clk_enable_6g_v2,
+	.link_clk_disable = dsi_link_clk_disable_6g_v2,
 	.clk_init_ver = dsi_clk_init_6g_v2,
 	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
 	.tx_buf_get = dsi_tx_buf_get_6g,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 610183db1daf..6ed9e6a0520c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_opp.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
@@ -511,7 +512,7 @@ int msm_dsi_runtime_resume(struct device *dev)
 	return dsi_bus_clk_enable(msm_host);
 }
 
-int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
+static int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
@@ -521,29 +522,65 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 	ret = clk_set_rate(msm_host->byte_clk, msm_host->byte_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate byte clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_set_rate(msm_host->pixel_clk, msm_host->pixel_clk_rate);
 	if (ret) {
 		pr_err("%s: Failed to set rate pixel clk, %d\n", __func__, ret);
-		goto error;
+		return ret;
 	}
 
 	if (msm_host->byte_intf_clk) {
 		ret = clk_set_rate(msm_host->byte_intf_clk,
 				   msm_host->byte_clk_rate / 2);
-		if (ret) {
+		if (ret)
+			pr_err("%s: Failed to set rate byte intf clk, %d\n",
+			       __func__, ret);
+	}
+
+	return ret;
+}
+
+static int dsi_link_clk_set_rate_6g_v2(struct msm_dsi_host *msm_host)
+{
+	int ret;
+	struct device *dev = &msm_host->pdev->dev;
+
+	DBG("Set clk rates: pclk=%d, byteclk=%d",
+		msm_host->mode->clock, msm_host->byte_clk_rate);
+
+	ret = dev_pm_opp_set_rate(dev, msm_host->byte_clk_rate);
+	if (ret) {
+		pr_err("%s: dev_pm_opp_set_rate failed %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = clk_set_rate(msm_host->pixel_clk, msm_host->pixel_clk_rate);
+	if (ret) {
+		pr_err("%s: Failed to set rate pixel clk, %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (msm_host->byte_intf_clk) {
+		ret = clk_set_rate(msm_host->byte_intf_clk,
+				msm_host->byte_clk_rate / 2);
+		if (ret)
 			pr_err("%s: Failed to set rate byte intf clk, %d\n",
 			       __func__, ret);
-			goto error;
-		}
 	}
 
+	return ret;
+}
+
+static int dsi_link_clk_prepare_enable_6g(struct msm_dsi_host *msm_host)
+{
+	int ret;
+
 	ret = clk_prepare_enable(msm_host->esc_clk);
 	if (ret) {
 		pr_err("%s: Failed to enable dsi esc clk\n", __func__);
-		goto error;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(msm_host->byte_clk);
@@ -575,10 +612,31 @@ int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 	clk_disable_unprepare(msm_host->byte_clk);
 byte_clk_err:
 	clk_disable_unprepare(msm_host->esc_clk);
-error:
 	return ret;
 }
 
+int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
+{
+	int ret;
+
+	ret = dsi_link_clk_set_rate_6g(msm_host);
+	if (ret)
+		return ret;
+
+	return dsi_link_clk_prepare_enable_6g(msm_host);
+}
+
+int dsi_link_clk_enable_6g_v2(struct msm_dsi_host *msm_host)
+{
+	int ret;
+
+	ret = dsi_link_clk_set_rate_6g_v2(msm_host);
+	if (ret)
+		return ret;
+
+	return dsi_link_clk_prepare_enable_6g(msm_host);
+}
+
 int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
 {
 	int ret;
@@ -656,6 +714,13 @@ void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
 	clk_disable_unprepare(msm_host->byte_clk);
 }
 
+void dsi_link_clk_disable_6g_v2(struct msm_dsi_host *msm_host)
+{
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(&msm_host->pdev->dev, 0);
+	dsi_link_clk_disable_6g(msm_host);
+}
+
 void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
 {
 	clk_disable_unprepare(msm_host->pixel_clk);
@@ -1864,6 +1929,12 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		goto fail;
 	}
 
+	dev_pm_opp_set_clkname(&pdev->dev, "byte");
+
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+
 	msm_host->rx_buf = devm_kzalloc(&pdev->dev, SZ_4K, GFP_KERNEL);
 	if (!msm_host->rx_buf) {
 		ret = -ENOMEM;
@@ -1896,6 +1967,7 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
 	DBG("");
+	dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
 	dsi_tx_buf_free(msm_host);
 	if (msm_host->workqueue) {
 		flush_workqueue(msm_host->workqueue);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

