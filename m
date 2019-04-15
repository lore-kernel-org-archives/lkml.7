Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94924C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5965F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8yy6Myc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfDOOz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37127 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfDOOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so15968957ljk.4;
        Mon, 15 Apr 2019 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rz6qwN3l7n5yC/HLWphu9AhhGsr+yXkjeWRq/trB/HY=;
        b=U8yy6MycGS/Hz77dF9jeE9cEQBG2ZT5X2wiPW4Kl/dsm3bIphuDke2S0B5dXcB7z18
         6gQIWU7LRieqXXsnZ1zdf0O9L9pGN8gLA0wWK7tdW61H+8oIIXxlNXXOvvIkf6TNfoCO
         Ozc41yIubuwFn8n76mh5MQIc3xKtXg1tNWbBhqKwENBEYBXYcB7P017Klq3q2RutDxXM
         qG1URiM8Q8AGyWS2kdts3qM5m5Iz9Gnuv95v0CIA53Jfj5JGJM4XDPS6i/zf25TeP05j
         9GPhr7ENlOgPLG257FCbtVN7M/vQnjzSSdNU1/+9+CGOo8h9ldlAV1PL0ZgQGRYsRD+H
         XgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rz6qwN3l7n5yC/HLWphu9AhhGsr+yXkjeWRq/trB/HY=;
        b=YWi7tn8IifX6pnAGe6xT4Rh0Um3eVi/fXa3+v5oPOVD2TQsBepzxTjfQeGK20a6SEg
         2KweKI/U/eZ44bDnft3tAUbRJ6MRBh0wq34/DV/U4Vh6BkgKoxodMBWoT0/x+u/1iU0T
         bdyX5Ga/Gcws5kcFpVv1lOgGtW1CG5SfiqDAU0du9ygMH4M9Bn1kzgCrcbXZRStWwYPW
         Ey6CwTQdEJqRGXOBWF7VuAyzqAqLfcToaONY5Z1UCJkFeZNhVu4FnVlCInGVvFyL1LBH
         RC7YCNILDss7rPR0eW8+2A2/MXGBbasuU0dx3EtWz0nKghXGHk46zMCaQrxxcN1rGyVf
         gz8Q==
X-Gm-Message-State: APjAAAWZfHupaJtCXkIH3nPC3hZt04YFZ7mzcV2bXTJ8lLpHV6aKi3I3
        Ng3rjQj8xsXudaA7zEf871c=
X-Google-Smtp-Source: APXvYqxri/AbVKMu1CBHp33I6bfobhOz191RQ5TvkQz504bC0xXgcmi28CxVXWUA/FrSs0wTfFb9ZQ==
X-Received: by 2002:a2e:420c:: with SMTP id p12mr40666011lja.1.1555340151996;
        Mon, 15 Apr 2019 07:55:51 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 15/19] PM / devfreq: tegra: Synchronize IRQ after masking it in hardware
Date:   Mon, 15 Apr 2019 17:55:01 +0300
Message-Id: <20190415145505.18397-16-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no guarantee that interrupt handling isn't running in parallel,
hence it is necessary to synchronize IRQ in order to ensure that interrupt
is indeed disabled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 46c61af8ca33..cfbfbe28e7bf 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -171,6 +171,8 @@ struct tegra_devfreq {
 	struct notifier_block	rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
+
+	int irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -432,6 +434,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 	}
 
 	actmon_write_barrier(tegra);
+
+	synchronize_irq(tegra->irq);
 }
 
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
@@ -603,7 +607,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
-	int irq;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -659,18 +662,18 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		tegra_actmon_configure_device(tegra, dev);
 	}
 
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+		return err;
+	}
+
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
 		dev_pm_opp_add(&pdev->dev, rate, 0);
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = irq;
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
-		goto remove_opps;
-	}
-
 	platform_set_drvdata(pdev, tegra);
 
 	err = devfreq_add_governor(&tegra_devfreq_governor);
@@ -689,10 +692,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		goto remove_governor;
 	}
 
-	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
-				   "tegra-devfreq", tegra);
+	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
+					"tegra-devfreq", tegra);
 	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
+		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
 		goto remove_devfreq;
 	}
 
@@ -701,14 +705,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
-		goto disable_interrupt;
+		goto remove_devfreq;
 	}
 
 	return 0;
 
-disable_interrupt:
-	free_irq(irq, tegra);
-
 remove_devfreq:
 	devfreq_remove_device(tegra->devfreq);
 
@@ -727,10 +728,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
-	free_irq(irq, tegra);
 
 	devfreq_remove_device(tegra->devfreq);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
-- 
2.21.0

