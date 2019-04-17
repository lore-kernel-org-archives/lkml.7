Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A6C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836720693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxzCQdrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfDQWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfDQWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so132205pfi.9;
        Wed, 17 Apr 2019 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IH0pLwwRbv47T9XNR0cT/BCMrgmfF5LArY0xNHrsMrc=;
        b=uxzCQdrK32LVR/6ByHW6SGfzwOQ2gAHoFwnuQ7n/yVCD6qfUB4AopLgzerWHvH9z77
         +yYX5bSn5lk7n1gooHQs0PVVShyaevjS2KyTKMUwnwb3jAPUsCvRIqZdWPWbscpytTzB
         xDSxFGWd9iY4U1b5+8XNJLVEZx9A3AQEeKhwprr/buDchXio/Ne3hC2/hzppDWxLHSh1
         WARFxVPfphsYsJJqije6l8jtknfiT3SyoT9QfZWpYIh1IO1PdB5ECN0w7aF3i38hGvYq
         CVON4biIS8m8qH/9ke2Qm9oXIlKCs2B92Q/tAv3fP2jXKxqD7j217AOyTD9zNLoxU8iO
         873Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IH0pLwwRbv47T9XNR0cT/BCMrgmfF5LArY0xNHrsMrc=;
        b=BTp+s1WLdqYDMsDZo7g5x2zDzWMA79g907mCMJqIB5UK8lDFTnD4eZBOVXJFnbkwpB
         dFH8wh+sDG1buUycaak8GAZO1pXzAEV9gSUs9neY5C1o1sg+jCVafUWzai9wo1Nd1UQy
         lhzEZtCY2KWZjCRv+i+wzf20qQMwup2zXuGVuQWENvTW0cFe005oDmZ6UAQ3l4ChPjwn
         oZrd3rLZiQKqyLbwfxCEbKOzRcQ7sADJrxF04HZvoz/oHt0+WdmDupLmrflC2tvDEJZf
         uRIUjMkt+jC4Xt43ca6UEgnKuFyUOtEd88qJTunoO9p/T/k8kxLrlBs33OXQLWeu0ioe
         cPww==
X-Gm-Message-State: APjAAAWittL9OqFYI41+zE2JGkm8dkzuAYKk1zyzBk6+BJAUE3ZvrfAj
        EexbiJWjEwycqbv2lNz/u38=
X-Google-Smtp-Source: APXvYqx9xBvUto5kHMobG06D9k07efckxEfhWjdZJEEbsgN4lDp4fVhNLnDp4uPdeLvyhswxDCtBWA==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr82284143pgi.399.1555540477636;
        Wed, 17 Apr 2019 15:34:37 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 06/16] PM / devfreq: tegra: Drop primary interrupt handler
Date:   Thu, 18 Apr 2019 01:29:15 +0300
Message-Id: <20190417222925.5815-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
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
 drivers/devfreq/tegra-devfreq.c | 55 +++++++++++----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 24ec65556c39..b65313fe3c2e 100644
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
@@ -348,15 +324,12 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 	unsigned long cpu_freq = 0;
 	unsigned long static_cpu_emc_freq = 0;
 	unsigned int avg_sustain_coef;
-	unsigned long flags;
 
 	if (dev->config->avg_dependency_threshold) {
 		cpu_freq = cpufreq_get(0);
 		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
 	}
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
 	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
 	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
@@ -364,19 +337,31 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
 
 	if (dev->avg_count >= dev->config->avg_dependency_threshold)
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
@@ -386,7 +371,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -398,9 +382,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -682,7 +664,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
@@ -700,8 +681,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
 		dev_err(&pdev->dev, "Interrupt request failed\n");
-- 
2.21.0

