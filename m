Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C17AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12275206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjPcaR49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfG3Qca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:32:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfG3QcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:32:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so66466211wrl.7;
        Tue, 30 Jul 2019 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OA59L/PDO/fIoCl0NQYE6ljbPRlOkug9V9TGpbxlIc=;
        b=UjPcaR49D0raHN5n5LpUrIqLVIYxGuUgcwKIDR20hVmAi42K9J3Teum4Dv8hqXp4tT
         sXOgPorkDuBqQmL7Yd44zH02PTJrqOu7El6TvYdo8KaOBvf1Qa9MIghdVG4OtX1st45d
         U2bP4rcMIten7LhVc7K6cy5G8rMFJy3w5U4dprMmCMGXfjPEVK/4QFwgr9dTLBoMElbq
         Tpa5+m03HzVrT1bM2I7m9+wv+D9Fz52UeeF9i6kIocwZKlAjbhLNenr86ggWwM6AJKoW
         UD+xuD+s6viJQiekJKb8f08MrYVnJzGzjq747zXbfzfBXE8vAxrvjPjsUPDojTbentmc
         aLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OA59L/PDO/fIoCl0NQYE6ljbPRlOkug9V9TGpbxlIc=;
        b=XQPnX1+BYb4OC08bytCwkAwokaaUiHyhpMaVVsLgZax4DcRs8lSIgHGNWObNGtq0/7
         OK/vR+J0kEDc4mzeF7U6E7EioZxkd4YAhTQf5icJGzdFERO8qVMKAefhO3Mbhhfs7Z48
         tUI94U4NhsXJjMgB1A4MBdxngUTf55sSpb8vDdVFxl3vo3olYAJnfVAKQTPX3eDtLxTk
         gbbrCR2M5S4n4CyUZ/Bm1slXI3V7GDRVffyyMLzakq52UkKaUlmzjjcaCK3DPNI/r3lM
         BuQCAbUjNNVOpHBYdprKmrvBqAldhT0J0jC2JjUXJk+yvJcKaOAPGjZEuzRnlixe5+Dm
         wGig==
X-Gm-Message-State: APjAAAXGWX7drDkAasrVPL/246iUmTKDTc5/Tq1+Lh43mv+D9J2NXqtu
        vzFtjubGgJkMYSTnkYk9swE=
X-Google-Smtp-Source: APXvYqy55VJPIwBbpJxEJ+BkBJhd8VlXEglnPIl5cXskz3bIVLr622tIHUGMZfgTFWN6OuXcGhe+2w==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr40299198wrm.265.1564504342627;
        Tue, 30 Jul 2019 09:32:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/20] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Tue, 30 Jul 2019 19:22:19 +0300
Message-Id: <20190730162236.6063-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730162236.6063-1-digetx@gmail.com>
References: <20190730162236.6063-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EMC clock rate rounding technically could fail, hence let's handle
the error cases properly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8be6a33beb9c..bfee9d43de1e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct tegra_devfreq_device *dev;
 	struct tegra_devfreq *tegra;
 	struct devfreq *devfreq;
-	unsigned long rate;
 	unsigned int i;
+	long rate;
 	int err;
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
@@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	reset_control_deassert(tegra->reset);
 
-	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
+	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+	if (rate < 0) {
+		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
+		return rate;
+	}
+
 	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
+	tegra->max_freq = rate / KHZ;
 
 	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
 		dev = tegra->devices + i;
@@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
 		rate = clk_round_rate(tegra->emc_clock, rate);
 
+		if (rate < 0) {
+			dev_err(&pdev->dev,
+				"Failed to round clock rate: %ld\n", rate);
+			err = rate;
+			goto remove_opps;
+		}
+
 		err = dev_pm_opp_add(&pdev->dev, rate, 0);
 		if (err) {
 			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
-- 
2.22.0

