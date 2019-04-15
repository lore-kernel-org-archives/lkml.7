Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48809C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367920818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRIJJWq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfDOO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35494 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfDOOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so463578lfh.2;
        Mon, 15 Apr 2019 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a8fC0nP20eaK/s3RenDJHXOepQxRNKrtNn7R1x2Vjo=;
        b=uRIJJWq2YA3kWKYjwX06jPxaMSyogcJu01QNlmhKgqMbyMQOguY8YSS/WCc+rddofI
         CSgi0WYajepCTMXpsWdyJEfUJvKOmRE7jXv5mXcHuc+95BkNFKRgq1Izepzh0iOs+5+X
         4wBi3pBoGegzdi2ofyf1iP1jjVbKunepe+48KMso6sI87CsK5FhmVQBl57wbT4KxEiTy
         BXvbjIRATXm5goLzRiC/CkHYMRBQIUdPSbHhDeDJuDBPOKScccIfrtUjvhPDJCQNbvMi
         0WQ9u5VdIEsWpMUD2F9/FSX0oryu3BCoNnayZrxQ/4UmZVdH0Z7jC+dMyWJnVNwPQu+e
         BISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a8fC0nP20eaK/s3RenDJHXOepQxRNKrtNn7R1x2Vjo=;
        b=hc4vVyySQZZtt7xCaxlUDIMZPbBDWlcFZ17Snu6rqSi9MsX1i3x3wp7rmb0P6Ls8/o
         7OGbjdFA47TpaEw+WHRL17a+iUVpAjVbwJsQw+J5wlzI1/rDGxfttZEtmQU7LSq5BI7T
         MvAR3zIU02QYodeRPA+kky6r+P5K5c5E1R7e4FFKi7f2xAZefi5vBfYl03aZ8KHlvKdw
         oQ3Dv2wjbA04nfjnBBBBXmEbRKCK1F7taEBY9gun1Gn7f2uhumLeL7IphKd+ZF5/YKy5
         Q8MU3uyFy1lDql3zPpuB1Nn7EG/9nTrJsLKEu2sxrWm6Z/bxK8RzqjjiMp2DrXfGnFm8
         Aeqw==
X-Gm-Message-State: APjAAAWKX0/8PdW6ePoloBS7yBioxsm/zPPZN8+YCuxpXvTSKWBZ4Og1
        nlzYnsGcUAq0Z8yF8jedwlY=
X-Google-Smtp-Source: APXvYqyZSWBC4cOgGPTu1zJCyzOgYxzDijCZ86WHxy8xW5eOOBvAov2/xdjbaKUli3hJBmlaWCeaOw==
X-Received: by 2002:a19:e30a:: with SMTP id a10mr22844700lfh.58.1555340150792;
        Mon, 15 Apr 2019 07:55:50 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 14/19] PM / devfreq: tegra: Move governor registration to driver's probe
Date:   Mon, 15 Apr 2019 17:55:00 +0300
Message-Id: <20190415145505.18397-15-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to register the ACTMON's governor separately from
the driver, hence let's move the registration into the driver's probe
function for consistency and to make code cleaner a tad.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 44 +++++++++------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 832e4f5aa11b..46c61af8ca33 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -673,6 +673,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
+	err = devfreq_add_governor(&tegra_devfreq_governor);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
+		goto remove_opps;
+	}
+
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devfreq_add_device(&pdev->dev,
 					    &tegra_devfreq_profile,
@@ -680,7 +686,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		goto remove_opps;
+		goto remove_governor;
 	}
 
 	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
@@ -706,6 +712,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_devfreq:
 	devfreq_remove_device(tegra->devfreq);
 
+remove_governor:
+	devfreq_remove_governor(&tegra_devfreq_governor);
+
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
@@ -729,7 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
-	return 0;
+	return devfreq_remove_governor(&tegra_devfreq_governor);
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
@@ -747,36 +756,7 @@ static struct platform_driver tegra_devfreq_driver = {
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

