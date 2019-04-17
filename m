Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84901C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5116620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp8qCbUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfDQWmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43708 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so199531pgu.10;
        Wed, 17 Apr 2019 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bd6CuU34AilBms8eSyHr+RYrpMcFPF6MtjKM0lW5yy0=;
        b=bp8qCbUSM8fk5ikmVaYDZHCOm5pWkt4TscIrcrDyOmQlyy4vu2OAAW6fD1p2GVpBa5
         2I0fxxhyys+fyMSYEkQYcZ3MLKuwsNx6r9RnN5S0L0Fi+RWSptbbxF6gJBMSQHv4uFpV
         3MBHLGrcJ3CllW8MmHGtSItV1WqaY4uyoKHFtskQlcjrpf5/x62xpw2SuffeQTwRJu3n
         VIjSifTb/Br3JrugO63aGHbD51i3eMWCPGt/o45tTxfnJ8o4g6Oep9gnDSLhyqPklahe
         ow4Pl5bdkdySxkHiLYE8xYll/eotnZiNphaj8HsOH0Q7jtj5GTl0/YgdX5gV5FDRmKNH
         wvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bd6CuU34AilBms8eSyHr+RYrpMcFPF6MtjKM0lW5yy0=;
        b=R1zmslewvy4bbQNmtWgGf/rhsXgrkQ7qnXi5LVsyiWjEaZjdtYFGXC1O6+RW6SklCp
         DMgxtHfxKxzujiDcrhskM1AYIZ71LKVGZN+bR4gQRQ8Xs8GdnEvZflhNGsk3irWVNcUT
         cXzkj7BbbxL2DMM2uPvpp0S+FXLPp7oj30js5V5SEExJUyF5FcDq/DVoXJw2RC5ertDX
         DPmHDIgJ4K2LLbnpRp9uBEq5nRwx6OYo4aOiEU4dhZnNs9iJeueId73F3Ou06fTpXrLC
         dnPg5G/ZcQ1Qco3NDRGsxDnDgkYWut4jWga+awCaGF//5nbEEkf7pxfLt5FSHKgOJzg7
         nf6A==
X-Gm-Message-State: APjAAAUy6Ldt96RMq2Y7YVy1foqRy4ClAvhLDOWEGdCOQSsdmxkHrho5
        QqZfROkyCjzD7LdzBvh1x08=
X-Google-Smtp-Source: APXvYqywS8RqrxMwKtai/xDuvIet5MYHvg3YV6tHi7dqnQsHfBCJ0a6joxu1te5dyJy3Q/g0rqAQJQ==
X-Received: by 2002:a65:448b:: with SMTP id l11mr85063289pgq.185.1555540484380;
        Wed, 17 Apr 2019 15:34:44 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 07/16] PM / devfreq: tegra: Properly disable interrupts
Date:   Thu, 18 Apr 2019 01:29:16 +0300
Message-Id: <20190417222925.5815-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no guarantee that interrupt handling isn't running in parallel
with tegra_actmon_disable_interrupts(), hence it is necessary to protect
DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
disabled in the Interrupt Controller in order to ensure that device
interrupt is indeed being disabled.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index b65313fe3c2e..ce1eb97a2090 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -171,6 +171,8 @@ struct tegra_devfreq {
 	struct notifier_block	rate_change_nb;
 
 	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
+
+	int irq;
 };
 
 struct tegra_actmon_emc_ratio {
@@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 	u32 val;
 	unsigned int i;
 
+	disable_irq(tegra->irq);
+
 	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
 		dev = &tegra->devices[i];
 
@@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
 		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 
 		device_writel(dev, val, ACTMON_DEV_CTRL);
+
+		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
+			      ACTMON_DEV_INTR_STATUS);
 	}
 
 	actmon_write_barrier(tegra);
+
+	enable_irq(tegra->irq);
 }
 
 static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
@@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int i;
 	unsigned long rate;
-	int irq;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		dev_pm_opp_add(&pdev->dev, rate, 0);
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
-		return irq;
+	tegra->irq = platform_get_irq(pdev, 0);
+	if (tegra->irq < 0) {
+		err = tegra->irq;
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
+		return err;
 	}
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
 	if (err) {
-- 
2.21.0

