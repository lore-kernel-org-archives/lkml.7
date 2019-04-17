Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8C421850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTrb038y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfDQWnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:43:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34721 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:43:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so222491pgq.1;
        Wed, 17 Apr 2019 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fNoakO5VGR+YqCvREKu6Ww81w6B+n7Tmbl7xvjsl6s=;
        b=oTrb038yLMNUyy4lKfkvUg9bMSq6XXqmjJsEG1M/3N9CBhee9YJR/6IaKp24VwIGqZ
         /p/525WPOZ1/vof0g2a41pEywrCBkWpiELaY48KOXuhRWaQe1Mmt2MIb/+c5tPe+b3Aj
         8r5yuVkN+MCu3fjk+ZluropNZrcqSxGRtSFi++HBV73nEz6FCbtEDw+idROnFQN+A4np
         +rKL1NcjX9IdufXVzXweI/ltbVXV6djgspnddu1ThOxYk/w9rmnZNVMDCRTuM1VPHlEP
         TyF/k4AzFFvw2Bgm3KdicaP9+strpx8aRzgiOI7d+RQ8vbOZ7sze6N8L3LC8SjbonNnS
         EEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fNoakO5VGR+YqCvREKu6Ww81w6B+n7Tmbl7xvjsl6s=;
        b=aibdyzp97ny5AbGfU78Xw5WNWYyJuqgiI8n/AiEMHBvbMSWedLzYIbqTHSXVYPy3KU
         /ibAOKUa3YWCCUuXTeL66d77i4/Qp0y39efprj6coBLh3H/yAh4nAHg9zjYxQDHFT6UP
         r1GpPIdjzOvjKSCoE8K1SP+FCm/pF3E1fPdTdcnZcF+h64pPQaqxYitO/NGkeRBarRv0
         00JlrrhnWM8UoKvc9YEl446Z9BAR0p7dqqjw1xI2Wkkl4SwX8dwMP3didzz/vphiNPzS
         Nzf3Ad4qGHN0PHRTzsoprK8yK/58DkzG83h3ziFKXYU8++kDjbmmRHS687+yqOcZRZLm
         iUsA==
X-Gm-Message-State: APjAAAVrmLzjRzcuqM5MH+TIdFkl0T6WasrpbFSzXnTIovICkXK70Tyu
        QAK4+/7PiwQOm5CUjAtVfws=
X-Google-Smtp-Source: APXvYqzuBKXpLz5w5/+N6A3xfVdyZtGa9JO1YBV5vFrogX5oLpEZPXG5F4sBKW2VAT3ILssx4ZS78w==
X-Received: by 2002:a63:cc0a:: with SMTP id x10mr82524102pgf.179.1555540511286;
        Wed, 17 Apr 2019 15:35:11 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 11/16] PM / devfreq: tegra: Move governor registration to driver's probe
Date:   Thu, 18 Apr 2019 01:29:20 +0300
Message-Id: <20190417222925.5815-12-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to register the ACTMON's governor separately from
the driver, hence let's move the registration into the driver's probe
function for consistency and to make code cleaner a tad.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 43 +++++++++------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 272232ce2960..62f35e818122 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -695,6 +695,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		goto remove_opps;
 	}
 
+	err = devfreq_add_governor(&tegra_devfreq_governor);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
+		goto unreg_notifier;
+	}
+
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devfreq_add_device(&pdev->dev,
 					    &tegra_devfreq_profile,
@@ -702,7 +708,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		goto unreg_notifier;
+		goto remove_governor;
 	}
 
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
@@ -718,6 +724,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_devfreq:
 	devfreq_remove_device(tegra->devfreq);
 
+remove_governor:
+	devfreq_remove_governor(&tegra_devfreq_governor);
+
 unreg_notifier:
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
@@ -735,6 +744,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 
 	devfreq_remove_device(tegra->devfreq);
+	devfreq_remove_governor(&tegra_devfreq_governor);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
@@ -760,36 +770,7 @@ static struct platform_driver tegra_devfreq_driver = {
 		.of_match_table = tegra_devfreq_of_match,
 	},
 };
-
-static int __init tegra_devfreq_init(void)
-{
-	int ret = 0;
-
-	ret = devfreq_add_governor(&tegra_devfreq_governor);
-	if (ret) {
-		pr_err("%s: failed to add governor: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = platform_driver_register(&tegra_devfreq_driver);
-	if (ret)
-		devfreq_remove_governor(&tegra_devfreq_governor);
-
-	return ret;
-}
-module_init(tegra_devfreq_init)
-
-static void __exit tegra_devfreq_exit(void)
-{
-	int ret = 0;
-
-	platform_driver_unregister(&tegra_devfreq_driver);
-
-	ret = devfreq_remove_governor(&tegra_devfreq_governor);
-	if (ret)
-		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
-}
-module_exit(tegra_devfreq_exit)
+module_platform_driver(tegra_devfreq_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Tegra devfreq driver");
-- 
2.21.0

