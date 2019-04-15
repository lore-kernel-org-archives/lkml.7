Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8163C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3RwG5xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfDOO5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40772 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfDOOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so862968ljq.7;
        Mon, 15 Apr 2019 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnaqtyRtTlaHL2UEB1k08xrsRa/S/S1jgRZuYKlkVb4=;
        b=r3RwG5xOZrYWr5Vu768+o9qsYi9mVE+j8SHbjuZH64VXwezByoejTXsU8+ft5FGk1G
         ePnl7QPD/Ewltk/nOq3FlvRf76ymZS4UUEfJypzh//0aGf3Obs0wwJ/r72yTjnTJ+I5Z
         E+pxf7/Qm/cOy0T//NmfDaJLTAsRB1Fd5Ekq1y0DyPHOl85KV4gmUSYtg0E79/3Lyp5p
         6Yiu2FNBE7IbjY761jPFq/BP7vBLkl0mUjByMO1qksY8dYHcq7aTYWt+Vyj13RTQYPlO
         /7mMWeLlyNpTfymaqw0MSbNpAuR2U+aIzTIfdZlEg83OSTQiOL0qcDzteupz1XdiHtlD
         kn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnaqtyRtTlaHL2UEB1k08xrsRa/S/S1jgRZuYKlkVb4=;
        b=A+su8J295wdxDMLVRceAjUiP7A6DBv3g1HMn84/iAglne9EFd3kFOrlD6vF5A/oiSW
         NZTzhnacWbR0MMY+UR57jTHilt4Xx+Cii4VfxtQp0XlyViCk6VaLFMHsrtg3i4nlEs75
         6e9KHJIpCQ269D/Ry1s9fzR9xXUdxkK609FqnGItUhzLxgLjQ3zSO5Sxeea2uHmGfz4o
         rh1H9KnfUGykT3R/N1Wk7aNIDJDEbWxVEAMxuLYljEti6aVVsM/h6G9eRgpKoGTF5TNE
         OuaUqWNYsg2VtU7bME0+iOsebmXuPqRNIX8r5MiqIzumYs6jK1jPoyOkUUovqFJRw+3W
         /l5w==
X-Gm-Message-State: APjAAAXqyYqEBrKzCEt10ekMdqQMMdSn1HIEDpjbgJpkUGLjzdBT06aO
        e5pPuOn2rns3m3pBuhebdTs=
X-Google-Smtp-Source: APXvYqxPpUBRM55MstIKfsBLSYuOcuoZD3Yi84OCCf/eJHpfnPixrk2uKZvL1Ab+Gv77VS29jqly2w==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr24530275lji.85.1555340153143;
        Mon, 15 Apr 2019 07:55:53 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 16/19] PM / devfreq: tegra: Reconfigure hardware on governor's restart
Date:   Mon, 15 Apr 2019 17:55:02 +0300
Message-Id: <20190415145505.18397-17-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
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
 drivers/devfreq/tegra-devfreq.c | 84 ++++++++++++---------------------
 1 file changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index cfbfbe28e7bf..f0711d5ad27d 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -394,50 +394,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
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
-	}
-
-	actmon_write_barrier(tegra);
-
-	synchronize_irq(tegra->irq);
-}
-
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 					  struct tegra_devfreq_device *dev)
 {
@@ -461,13 +417,40 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
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
+	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
+		      ACTMON_GLB_PERIOD_CTRL);
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
 
 	actmon_write_barrier(tegra);
 }
 
+static void tegra_actmon_stop(struct tegra_devfreq *tegra)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
+		device_writel(&tegra->devices[i], 0x00000000, ACTMON_DEV_CTRL);
+
+	actmon_write_barrier(tegra);
+
+	synchronize_irq(tegra->irq);
+}
+
 static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
@@ -571,22 +554,22 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
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
 
@@ -651,15 +634,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
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
 
 	tegra->irq = platform_get_irq(pdev, 0);
-- 
2.21.0

