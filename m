Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7803120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+gfS5WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfDOO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfDOOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so15931552ljg.11;
        Mon, 15 Apr 2019 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wB9FAexEGLwnJBnw1ywqk+Ov7BUvvvxBDjWenbpsA4=;
        b=X+gfS5WEeVdxhn5Oso+e7HYsuk13vNT00h0e3BaO+AkzncvfcszMPJ9mpdrCgtu/Iv
         Iw2ma67fhHipDOKLP2mWXrXkol73/NKNJNedBgndIu16mLVNTTjJZqNJd/wBYniHa5D4
         Ov9K3cXJTQZhowq0+ASa47R7NOvZ6g1xeUhZieCzgFC2FC6cJ0g5QJxX3dfhMUfNsUti
         9gSIuq17KKA9c3AhoUHVrzKzWE1feI/ENarkbVkeQKAzZcqH/rivqQ4+npy40dAeldBM
         fiJh8Msldbnk5V1A9jCQwSIqQUEBpDWUrAHw9D807/rsr/D3oNUk/Vc2NpM6BQSrmNuP
         3NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wB9FAexEGLwnJBnw1ywqk+Ov7BUvvvxBDjWenbpsA4=;
        b=S67NoUriVvH9W23GWPayM+7/0Q8cGkVl/iq3i4KHs2vtVkI1zn6Ph7F0BnynGGIgQZ
         SY3IlVaJqtDbARR9oxGVj0qGLhePVIKHL1EG8+P+Mn1jlkFXOn3U7+8UhjnjxgnLbNDK
         2vQX/1bchjIY+MhMTQgTNT8eCAzyObwCvXK3IVlcI/YNLfiAmoz7nm15exN5YvENB/JX
         197n4xI/7rduCHx+T9923N2ya1q6GrpHDzSCxzUnUKGc8b5Sz6zykyVCChgW2Msi8+RE
         fTcx6SQjlBChUUJLRzTmLnIGij6pm/m76q1t9XW/ahJ74eC6x0meCeTgE5gQoBziyCV4
         g/ag==
X-Gm-Message-State: APjAAAWbfjcLypbG4q6WGBfFQM4y+FnXxrmRgV72uh7rzC0noatzzO5j
        BQED7tC4Tx/ydAKpGNsL+ws=
X-Google-Smtp-Source: APXvYqzTDB4fiI6qEbkssAst66En8rkkxwv/jehbiDOYC6ljmr7cgd7HhrH+QOuEunKgL1tO82ZLLQ==
X-Received: by 2002:a2e:9211:: with SMTP id k17mr39395691ljg.46.1555340147289;
        Mon, 15 Apr 2019 07:55:47 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 11/19] PM / devfreq: tegra: De-initialize properly on driver's probe error
Date:   Mon, 15 Apr 2019 17:54:57 +0300
Message-Id: <20190415145505.18397-12-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset hardware, disable ACTMON clock, release OPP's and free IRQ before
removing devfreq device since there is no guarantee that interrupt
handling won't run after masking interrupt in hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 53 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 69b557df5084..a668e4fbc874 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -663,28 +663,28 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
-		return irq;
+		err = irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+		goto remove_opps;
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
-	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
-						 &tegra_devfreq_profile,
-						 "tegra_actmon",
-						 NULL);
+	tegra->devfreq = devfreq_add_device(&pdev->dev,
+					    &tegra_devfreq_profile,
+					    "tegra_actmon",
+					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		return err;
+		goto remove_opps;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					actmon_thread_isr, IRQF_ONESHOT,
-					"tegra-devfreq", tegra);
+	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
+				   "tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-		goto remove_opps;
+		goto remove_devfreq;
 	}
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
@@ -692,14 +692,23 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to register rate change notifier\n");
-		goto remove_opps;
+		goto disable_interrupt;
 	}
 
 	return 0;
 
+disable_interrupt:
+	free_irq(irq, tegra);
+
+remove_devfreq:
+	devfreq_remove_device(tegra->devfreq);
+
 remove_opps:
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+
 	return err;
 }
 
@@ -707,24 +716,14 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
-	u32 val;
-	unsigned int i;
-
-	devm_devfreq_remove_device(&pdev->dev, tegra->devfreq);
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
-
-	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
-		val = device_readl(&tegra->devices[i], ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_ENB;
-		device_writel(&tegra->devices[i], val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
-
-	devm_free_irq(&pdev->dev, irq, tegra);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
+	free_irq(irq, tegra);
+
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
+	reset_control_reset(tegra->reset);
 	clk_disable_unprepare(tegra->clock);
 
 	return 0;
-- 
2.21.0

