Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB152075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXtCDKVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfDOOzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34912 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfDOOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so7446049ljc.2;
        Mon, 15 Apr 2019 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxFXcnZ0+kTwKn7yZtNdaeYIBolFlxe3a8rBh8lAM/Q=;
        b=eXtCDKVf6nAyyLh0sq7KGY+Ll04nN2O252ndlmQYempdbdaSqB1IItDZWFqtrrnONr
         z6vVYoywUJZ1YZIDNk6JBY+UUqX47LEkPiAXxbz20v726ovK9x+YFX0CPaRrwdrkFiO4
         xrQ2DO2jvCB2mhcxxwuLorYDrAkmJCqmdymYfzsSl2M7TiL/TiuQUcJt2JPfzQTaBbhx
         07KwwqoFReOa+rc6TcQvzDBz2nfrv8Y9Q1RFRQsgZVD3kFvwQ5BQhSKcaqie1oTHPtrh
         piNCYnLA+/ecjFZHXrbMARWAexzKKeu1Wbh/R58kINTIleosUp37RpghcDtxSvJpluGZ
         ukqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxFXcnZ0+kTwKn7yZtNdaeYIBolFlxe3a8rBh8lAM/Q=;
        b=ajIpuwHFPMmXIm8cEmgSOpuSOg1RIefVhcAQBIaqdhMsQ0LZIrE5l16ic9jFSe1UkR
         hL2bV64Ka2s0SwSVfP6KsEx2aupvjrQTkx+wOL2Bja6qRWwuNqhd0cncl1Ygpycjbsln
         6aLaOZGwpvK1Ull0Lr201Lglu1xutt6KLfMK0FZPzLfIorkRdO3IAdY1ypbB1T3aFFTn
         mAUegl9y9NfnqdpCFSGDBUuu3OMAT5JUkMDn1OtyTY3fdR1h6y4vkjLwpStmgjHVT1a4
         fjGRGWE3MJWn0SA79AMx92KLw4bnfZGVfA4B8NFfTQf8zPxguAojS8dBRSVHlAXg4myK
         HfcQ==
X-Gm-Message-State: APjAAAWu5u1l1GSYVIL1uIfnU0v21By6IkP24coBEvC5+UxqjcjTG8ww
        abu9IPFH2DrKcZxoCUpmKRaWKXGm
X-Google-Smtp-Source: APXvYqxLiSuG3c38oCHCQXCoarUgZ8Cc5n+iWYgvYKnRltOWSIQti2P8fyCaHg5KtpkMJx+UUAZuyg==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr39395786lja.164.1555340146091;
        Mon, 15 Apr 2019 07:55:46 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 10/19] PM / devfreq: tegra: Drop primary interrupt handler
Date:   Mon, 15 Apr 2019 17:54:56 +0300
Message-Id: <20190415145505.18397-11-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real need in the primary interrupt handler, hence move
everything to the secondary (threaded) handler. In a result locking
is consistent now and there are no potential races with the interrupt
handler because it is protected with the devfreq's mutex.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 61 ++++++++++++---------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 2a1464098200..69b557df5084 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
 	void __iomem *regs;
-	spinlock_t lock;
 
 	/* Average event count sampled in the last interrupt */
 	u32 avg_count;
@@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	unsigned long flags;
 	u32 intr_status, dev_ctrl;
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	tegra_devfreq_update_avg_wmark(tegra, dev);
 
@@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
 	actmon_write_barrier(tegra);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
-}
-
-static irqreturn_t actmon_isr(int irq, void *data)
-{
-	struct tegra_devfreq *tegra = data;
-	bool handled = false;
-	unsigned int i;
-	u32 val;
-
-	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		if (val & tegra->devices[i].config->irq_mask) {
-			actmon_isr_device(tegra, tegra->devices + i);
-			handled = true;
-		}
-	}
-
-	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
 }
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
@@ -348,35 +324,46 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 	unsigned int avg_sustain_coef;
-	unsigned long flags;
+	u32 avg_count;
 
 	if (dev->config->avg_dependency_threshold) {
 		cpu_freq = cpufreq_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
-
-	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
+	avg_count = dev->avg_count;
+	dev->target_freq = avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
 	dev->target_freq += dev->boost_freq;
 
-	if (dev->avg_count >= dev->config->avg_dependency_threshold)
+	if (avg_count >= dev->config->avg_dependency_threshold)
 		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static irqreturn_t actmon_thread_isr(int irq, void *data)
 {
 	struct tegra_devfreq *tegra = data;
+	bool handled = false;
+	unsigned int i;
+	u32 val;
 
 	mutex_lock(&tegra->devfreq->lock);
-	update_devfreq(tegra->devfreq);
+
+	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		if (val & tegra->devices[i].config->irq_mask) {
+			actmon_isr_device(tegra, tegra->devices + i);
+			handled = true;
+		}
+	}
+
+	if (handled)
+		update_devfreq(tegra->devfreq);
+
 	mutex_unlock(&tegra->devfreq->lock);
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
@@ -386,7 +373,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -398,9 +384,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -668,7 +652,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
@@ -696,8 +679,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-- 
2.21.0

