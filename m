Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0D920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhz2Pxgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDKWac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46896 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfDKWaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r25so5902201lfn.13;
        Thu, 11 Apr 2019 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vu3fL/lG05rgrLw+zye7dpk+bIBQvGSxJRe4aRXrJLs=;
        b=Nhz2PxgmRHPGeX3gywKMUa7GlBStjpbZ31NDnRPIOJzmo3cXYy5BkvF0zqrOl/3qDi
         Z9DghuRfEHwx3VbkIbHMXkeJWo7Y+3cKj5oWXEw7yNEagOl08pw5Av76qrQK1WAR6+Ro
         yWKcvFzxVEwmGW12y7cCIwBarJLUcCMiQzkGM34pfY6zl0z+d666A9dj7Q3sp2u32ARu
         aeSb+JwNvZjh6tBF07skdqztvQ3ZLNQKDriOV46LEVhEL2hEKLqOZnEj75tI6/FRgG5V
         b54aYc6IW9wRiQqHHxEObCenae+mxSEO4W3maVcoDPIGBHA49NJL4rnkpL42Z6iuapkC
         unNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vu3fL/lG05rgrLw+zye7dpk+bIBQvGSxJRe4aRXrJLs=;
        b=sVZT/j9TcK59e/fWocE1at5+fpsoHLqOHwdExIbUB8aORQ65Mu5Xt8xsxiXzlIY9J5
         cuhYh8GBxScfjPPozMKvAV8BmnPjWDp4YZsPET0Z82o8WXWONepJeV2N/kJrIwZPK9MH
         q+Cuql9pBj8RsVfKkFT5hJxMi4OKxmdKEmamcdvkRqR89G5lnXsrd8+/z1q23T1TAcWE
         FaWyM+yTGN1g6x4TeSLAaksOv/RKtGsIEzSER/UUd7BNa/OHrOt4oix1ZKgKtPulAhfZ
         uot93qG14LdGNBWL2mgHRDnn5QfYLiop66DY+16AFKmKSYQVWcfXMjqdbZxIA9PuOpqy
         LhfA==
X-Gm-Message-State: APjAAAWWvCk3m+Pwh8bzvykGQCaWKFgEeiMXtiz1yJ+9JMjC3M5TLL43
        IqKKO17wLmvfQxAfaUech54=
X-Google-Smtp-Source: APXvYqwYYq/DjwNy0GepugE29b9V3Jj2m5SJdMOpSGFjPfBUTjh3X479fzgRGG+xBvvR10U5d/peZg==
X-Received: by 2002:a19:f705:: with SMTP id z5mr12100324lfe.93.1555021804942;
        Thu, 11 Apr 2019 15:30:04 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 6/8] PM / devfreq: tegra: Drop spinlock
Date:   Fri, 12 Apr 2019 01:29:12 +0300
Message-Id: <20190411222914.25539-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real need to use locking since we can simply read out the
volatile variable value once and the watermark changing shouldn't clash
with the changes made by the interrupt handler.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index aefd4874b5a2..96f1e8e64e46 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
 struct tegra_devfreq_device {
 	const struct tegra_devfreq_device_config *config;
 	void __iomem *regs;
-	spinlock_t lock;
 
 	/* Average event count sampled in the last interrupt */
 	u32 avg_count;
@@ -250,11 +249,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
-	unsigned long flags;
 	u32 intr_status, dev_ctrl;
 
-	spin_lock_irqsave(&dev->lock, flags);
-
 	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
 	tegra_devfreq_update_avg_wmark(tegra, dev);
 
@@ -303,8 +299,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
 	actmon_write_barrier(tegra);
-
-	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 static irqreturn_t actmon_isr(int irq, void *data)
@@ -349,24 +343,21 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
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
+	avg_count = READ_ONCE(dev->avg_count);
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
@@ -387,7 +378,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
 	unsigned int i;
-	unsigned long flags;
 
 	if (action != POST_RATE_CHANGE)
 		return NOTIFY_OK;
@@ -399,9 +389,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
-		spin_lock_irqsave(&dev->lock, flags);
 		tegra_devfreq_update_wmark(tegra, dev);
-		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	actmon_write_barrier(tegra);
@@ -677,7 +665,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-		spin_lock_init(&dev->lock);
 
 		tegra_actmon_configure_device(tegra, dev);
 	}
-- 
2.21.0

