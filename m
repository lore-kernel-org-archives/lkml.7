Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED92C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CE7217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShvckbTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfDQWlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46222 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbfDQWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so156025pll.13;
        Wed, 17 Apr 2019 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86fe+O7jXPA0qhy2wYrXIFfPfbOKD6IEbw+ZHbB55Jw=;
        b=ShvckbTbf5uva6JBmfeHPUGpnJfTmMF6naxlXa7RdilrKH23aKbj2xIXQGH6h27Q2J
         j1SLP+f8zCRPUFVrQkGcHuYZm/J2/ne9liMR1MEOM2s0tFnGp7V0tiWqmghH86XCHb/l
         nvucwylTk7Yi4VCFbKuQNsJ9RFpzPl+ZiAgGC20sKaNCugtMeTUfaNvME7+xOa/yakgG
         9BiwXbjV9cKRhHV9JW373oD8BAP2lBJq2RJaJVheUaCP9znFA+T7amL/lr51YErnJ2Ke
         ndgSroPIOO9I9s/npm0CtEeVKYoWXOHp4UhWN+vL6DAjyxxHv8CEamsrEGq5+rKmLk31
         c0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86fe+O7jXPA0qhy2wYrXIFfPfbOKD6IEbw+ZHbB55Jw=;
        b=FhD84aoAgKTHgDEtfc9Aeia4QofPKlCFd0SLgY09Sufo7+dds4QHogHuoZYFMLoAQt
         RTD6DyglfkZrEPpFNSlpzZeBLvUEPREajIuomPWk44wzZ7FOe8Kl+Sl7PNI7utJLjgs7
         wjpN/SoIaP786hqx3x0Z9CFOejKSxsiDCZgTdDMGx4TBVGBPgR87nkrCODw2y2Je4QrE
         NS4RWWNmNAQC0th9Vb4PCDCxyhJAA6gwN77uihmJsFXmYmdX0xpY8lprbIvBcys1+ijF
         bvEUqwkOB/wAbsKk9reMmwdnW6LNWWdFx6gJrZR2YjKrTkhvdrfRcgmn1MoaMHMYGmfV
         XLNA==
X-Gm-Message-State: APjAAAWEh3WpEessIj+z7DyxfubGySi4fTSO6U/iA43CVLyzE6USi0Fg
        YjNkHV97T/F5C1J4hXzPjbI=
X-Google-Smtp-Source: APXvYqw94dZ5ZmRzzGoBYKd0tZ3CBOJF5VuewFILC9V1lenb/mv0W5ESdXarsfImkv/NIoJZfKwHtw==
X-Received: by 2002:a17:902:be04:: with SMTP id r4mr93253916pls.218.1555540491074;
        Wed, 17 Apr 2019 15:34:51 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 08/16] PM / devfreq: tegra: Clean up driver's probe / remove
Date:   Thu, 18 Apr 2019 01:29:17 +0300
Message-Id: <20190417222925.5815-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset hardware, disable ACTMON clock, release OPP's and handle all
possible error cases correctly, maintaining the correct tear down
order. Also use devm_platform_ioremap_resource() which is now available
in the kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index ce1eb97a2090..70946e432d3c 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -610,7 +610,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
-	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
 	int err;
@@ -619,9 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (!tegra)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tegra->regs))
 		return PTR_ERR(tegra->regs);
 
@@ -643,11 +640,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
 		return err;
 	}
 
@@ -678,54 +674,69 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
-		dev_pm_opp_add(&pdev->dev, rate, 0);
-	}
 
-	tegra->irq = platform_get_irq(pdev, 0);
-	if (tegra->irq < 0) {
-		err = tegra->irq;
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
-		return err;
+		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
+			goto remove_opps;
+		}
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
+	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to register rate change notifier\n");
+		goto remove_opps;
+	}
+
+	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		goto unreg_notifier;
+	}
+
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
-		return err;
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+		goto remove_devfreq;
 	}
 
-	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
-
 	return 0;
+
+remove_devfreq:
+	devfreq_remove_device(tegra->devfreq);
+
+unreg_notifier:
+	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+
+	return err;
 }
 
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
-		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
 
-	devm_free_irq(&pdev->dev, irq, tegra);
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
+	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
 	return 0;
-- 
2.21.0

