Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud8t+g48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbfDQWmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so168239plj.8;
        Wed, 17 Apr 2019 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGhwmqxYys+b5h8DSBtXrBhmaqFi5uiahazIWk9yJ4o=;
        b=Ud8t+g48EJkehj64M7LPHWSvRVF+mFT8SaCxQaKt49aXSrFWR0qq1RAvP7XRyDq19U
         96K0RiP3pwMpSwcfisKWOkPb+ByVzX4ltq8/F5wccUThuHwSUrB5XSu+eDfiHBTF61fz
         W7CWwbz+L0N6UnNY0tflWnNcbOBVhWLBcz+imMMt3KwAGlekaWmLiHdiYQf0dIvmserQ
         z3QqDTiRvPBEI36yc8CXm0NDv/fgo6pw965DeQd7Y9v39ocZE3s7Vv7iZM71TNd+6wGF
         UbFVNoZA5fkITG+cocQiC6fvaRchOLXa9+h+Hl4z8ueHNayyG3NW4IK0/JnhI79KChU0
         4KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGhwmqxYys+b5h8DSBtXrBhmaqFi5uiahazIWk9yJ4o=;
        b=X6vpZSfNyWYTqbWpuzDd76M/F1FhWS97bq/k+iNP4f1WSbb8CCGTWokFo+4HCEV4h+
         tCLgiZLkeSJbUBQ6FtvX80HhvduRhAWmOrj7sXP9XovUyzARy+aUKVZbMpG6V8F+5xk7
         Qhc7YeM578Vm7h7dYvNrVc/XjfzZyZRKnRRFB0/HDhhS3KeiD2D3F3Tp0cJN3EBjjx8h
         C1UmXvGiT7+HLDHZLljN50iYwF0cw4f6VSvoOUd5TsiI9JmqeMD58SkETIdnZSJqp8wd
         /9JSRxX2+hnd2tf589IhWR1zLXrGmJ3pFeabdItau2XOAtLZBIWBc+L3dLuX39ul8klZ
         HeNg==
X-Gm-Message-State: APjAAAWGVEYbsdRjQkDE5+s+B3TgJl8Teyrak+8wO3GxyCFf1WItR0cp
        YNxgx8Eq+xZIw/FWFFXE4d4=
X-Google-Smtp-Source: APXvYqyZvSgsANYMTvaaumL4t7Ffe8MKILHQoXvLsg0WySxH92STATA/nh+Q+XUx2qMjTFFLxOQsog==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr44488019plv.90.1555540518043;
        Wed, 17 Apr 2019 15:35:18 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 12/16] PM / devfreq: tegra: Reconfigure hardware on governor's restart
Date:   Thu, 18 Apr 2019 01:29:21 +0300
Message-Id: <20190417222925.5815-13-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move hardware configuration to governor's start/resume methods.
This allows to re-initialize hardware counters and reconfigure
cleanly if governor was stopped/paused. That is needed because we
are not aware of all hardware changes that happened while governor
was stopped and the paused state may get out of sync with reality,
hence it's better to start with a clean slate after the pause. In
a result there is no memory bandwidth starvation after resume from
suspend-to-ram that results in display controller underflowing that
happens on resume because of improper decision made by devfreq about
the required memory frequency. This change also cleans up code a tad
by moving hardware-configuration code into a single location.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 98 ++++++++++++++-------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 62f35e818122..e9ab49394d35 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -392,55 +392,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void tegra_actmon_enable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-	}
-
-	actmon_write_barrier(tegra);
-}
-
-static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
-{
-	struct tegra_devfreq_device *dev;
-	u32 val;
-	unsigned int i;
-
-	disable_irq(tegra->irq);
-
-	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
-		dev = &tegra->devices[i];
-
-		val = device_readl(dev, ACTMON_DEV_CTRL);
-		val &= ~ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
-		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
-
-		device_writel(dev, val, ACTMON_DEV_CTRL);
-
-		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
-			      ACTMON_DEV_INTR_STATUS);
-	}
-
-	actmon_write_barrier(tegra);
-
-	enable_irq(tegra->irq);
-}
-
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -464,11 +415,47 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_NUM_SHIFT;
 	val |= (ACTMON_ABOVE_WMARK_WINDOW - 1)
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
+	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
+	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
 	device_writel(dev, val, ACTMON_DEV_CTRL);
+}
+
+static void tegra_actmon_start(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+		      ACTMON_GLB_PERIOD_CTRL);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
+
+	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
+}
+
+static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	disable_irq(tegra->irq);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
+		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
+		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
+	}
 
 	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
 }
 
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
@@ -580,22 +567,22 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 	switch (event) {
 	case DEVFREQ_GOV_START:
 		devfreq_monitor_start(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 
 	case DEVFREQ_GOV_STOP:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_stop(devfreq);
 		break;
 
 	case DEVFREQ_GOV_SUSPEND:
-		tegra_actmon_disable_interrupts(tegra);
+		tegra_actmon_stop(tegra);
 		devfreq_monitor_suspend(devfreq);
 		break;
 
 	case DEVFREQ_GOV_RESUME:
 		devfreq_monitor_resume(devfreq);
-		tegra_actmon_enable_interrupts(tegra);
+		tegra_actmon_start(tegra);
 		break;
 	}
 
@@ -664,15 +651,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 
-	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
-		      ACTMON_GLB_PERIOD_CTRL);
-
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
 		dev->config = actmon_device_configs + i;
 		dev->regs = tegra->regs + dev->config->offset;
-
-		tegra_actmon_configure_device(tegra, dev);
 	}
 
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
-- 
2.21.0

