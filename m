Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6292196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zgf+CpZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbfISKZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:25:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389225AbfISKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so2475862wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfVN9sS5ICyBISD9/bSWhyU3cvwrbDco1DEGdifcoMw=;
        b=Zgf+CpZxtIoGz/4c7gSJv4YQIT/AIZGYY5ONX3aWeXVn+UltgLZQP7rUIMGKJGcA/5
         3hAwcCcqR4JO27SBuv0gUBe+2soEpC0+Ywl6RVlxx9GS6D2SX88/urlqxokJhMh2ypHP
         vaa5wjrtEgY+NUGLyaq8920OPXWIYrzhavXJoRIv7FNwEKbeCk6ZHpybUNoUwdCI2OgO
         gALZrQmDYTi/6bwt+K9Safk+8yqSpole+FRyuciLFFYW0nnK+voIq0J1HQIk0tw7lLmq
         BVOsYEg28zw1zKZoI/0S2JRXFho5o79D97lrKXJziR7O480vfv89VmD/AptN9cuFXywH
         GTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfVN9sS5ICyBISD9/bSWhyU3cvwrbDco1DEGdifcoMw=;
        b=rkDeuwmvFuAljrKE/al1CJMYLC0b9BoQMxQtMhQSHUJWPnnhTCfG1pEiD6n6vBYyX2
         U9cJXDwu5h+QInAC3QBbF/HDHCzwG6ddW7XWCPcNQk+M36dFJOt7roslMv7m84sxwr1R
         YSsfrLRvu2j0zUGsqvuO+spTBf2nkS+pUGC1eqJBrJyjGvFIBnVs3iyJ/F8vkt6Y2SE7
         Va+e3NKRhHDNAZPFEAkY6kHR78NKd5NoGKj/Hm/R5OhDzIPGiTNiUbUpl+O26t85MxO2
         UP2zZYAcHQhj2EXQlDHRowstA3I1Gu55br/aFVQPC3pg9fCkWv4XwBHFOuo7JbTaaoLw
         4itw==
X-Gm-Message-State: APjAAAUAQzXqA/IA1e5QNMkZGY/R+3GbOX3yKYLkdjH9Lco9iJVEsS1x
        79obF+nGT9K545NyGEu9hetv5g==
X-Google-Smtp-Source: APXvYqz5GUMlGa0iJ43OkLkqJuHmVrUcsQGvNUSJgX9WQP+bvNX6a0EK/ak4iYRlIe/z7cwDlrDXeg==
X-Received: by 2002:a5d:62c6:: with SMTP id o6mr6940968wrv.243.1568888724854;
        Thu, 19 Sep 2019 03:25:24 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a18sm19542000wrh.25.2019.09.19.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:25:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com, mturquette@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] clk: meson: g12a: add suspend-resume hooks
Date:   Thu, 19 Sep 2019 12:25:18 +0200
Message-Id: <20190919102518.25126-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190919102518.25126-1-narmstrong@baylibre.com>
References: <20190919102518.25126-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend and resume hooks used to refresh the CPU clock tree
when resuming from suspend, in the case where the PSCI firmware
alters the clock tree.

In the Amlogic G12A suspend/resume case, the PSCI firmware will
alter the Fixed PLL dyn tree when entering with the CPU clock from
this same tree, but using a different path to achieve the same rate.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 71 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index b3af61cc6fb9..9f6f634225b7 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4992,6 +4992,19 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 	return 0;
 }
 
+static int meson_g12b_resume(struct device *dev)
+{
+	u32 ret;
+
+	ret = clk_invalidate_rate(
+			__clk_lookup(clk_hw_get_name(&g12b_cpu_clk.hw)));
+	if (ret)
+		return ret;
+
+	return clk_invalidate_rate(
+			__clk_lookup(clk_hw_get_name(&g12b_cpub_clk.hw)));
+}
+
 static int meson_g12a_dvfs_setup(struct platform_device *pdev)
 {
 	struct clk_hw **hws = g12a_hw_onecell_data.hws;
@@ -5024,34 +5037,68 @@ static int meson_g12a_dvfs_setup(struct platform_device *pdev)
 	return 0;
 }
 
+static int meson_g12a_resume(struct device *dev)
+{
+	return clk_invalidate_rate(
+			__clk_lookup(clk_hw_get_name(&g12a_cpu_clk.hw)));
+}
+
 struct meson_g12a_data {
 	const struct meson_eeclkc_data eeclkc_data;
 	int (*dvfs_setup)(struct platform_device *pdev);
+	int (*resume)(struct device *dev);
 };
 
+static const struct
+meson_g12a_data *meson_g12a_get_data(struct device *dev)
+{
+	const struct meson_eeclkc_data *eeclkc_data =
+			of_device_get_match_data(dev);
+
+	if (!eeclkc_data)
+		return ERR_PTR(-EINVAL);
+
+	return container_of(eeclkc_data, struct meson_g12a_data,
+			    eeclkc_data);
+}
+
 static int meson_g12a_probe(struct platform_device *pdev)
 {
-	const struct meson_eeclkc_data *eeclkc_data;
-	const struct meson_g12a_data *g12a_data;
 	int ret;
+	const struct meson_g12a_data *g12a_data =
+			meson_g12a_get_data(&pdev->dev);
 
-	eeclkc_data = of_device_get_match_data(&pdev->dev);
-	if (!eeclkc_data)
-		return -EINVAL;
+	if (IS_ERR(g12a_data))
+		return PTR_ERR(g12a_data);
 
 	ret = meson_eeclkc_probe(pdev);
 	if (ret)
 		return ret;
 
-	g12a_data = container_of(eeclkc_data, struct meson_g12a_data,
-				 eeclkc_data);
-
 	if (g12a_data->dvfs_setup)
 		return g12a_data->dvfs_setup(pdev);
 
 	return 0;
 }
 
+static int __maybe_unused g12a_clkc_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused g12a_clkc_resume(struct device *dev)
+{
+	const struct meson_g12a_data *g12a_data = meson_g12a_get_data(dev);
+
+	if (IS_ERR(g12a_data))
+		return PTR_ERR(g12a_data);
+
+	if (g12a_data->resume)
+		return g12a_data->resume(dev);
+
+	return 0;
+}
+
 static const struct meson_g12a_data g12a_clkc_data = {
 	.eeclkc_data = {
 		.regmap_clks = g12a_clk_regmaps,
@@ -5061,6 +5108,7 @@ static const struct meson_g12a_data g12a_clkc_data = {
 		.init_count = ARRAY_SIZE(g12a_init_regs),
 	},
 	.dvfs_setup = meson_g12a_dvfs_setup,
+	.resume = meson_g12a_resume,
 };
 
 static const struct meson_g12a_data g12b_clkc_data = {
@@ -5070,6 +5118,7 @@ static const struct meson_g12a_data g12b_clkc_data = {
 		.hw_onecell_data = &g12b_hw_onecell_data,
 	},
 	.dvfs_setup = meson_g12b_dvfs_setup,
+	.resume = meson_g12b_resume,
 };
 
 static const struct meson_g12a_data sm1_clkc_data = {
@@ -5079,6 +5128,11 @@ static const struct meson_g12a_data sm1_clkc_data = {
 		.hw_onecell_data = &sm1_hw_onecell_data,
 	},
 	.dvfs_setup = meson_g12a_dvfs_setup,
+	.resume = meson_g12a_resume,
+};
+
+static const struct dev_pm_ops g12a_clkc_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(g12a_clkc_suspend, g12a_clkc_resume)
 };
 
 static const struct of_device_id clkc_match_table[] = {
@@ -5102,6 +5156,7 @@ static struct platform_driver g12a_driver = {
 	.driver		= {
 		.name	= "g12a-clkc",
 		.of_match_table = clkc_match_table,
+		.pm	= &g12a_clkc_dev_pm_ops,
 	},
 };
 
-- 
2.22.0

