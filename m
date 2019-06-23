Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE8C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B27A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJJ+DAig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFXB6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:58:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46194 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXB6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:58:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so8719122lfh.13;
        Sun, 23 Jun 2019 18:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=lJJ+DAigEEWSZ0iZcKVLVADsMkXpYMRq/4hgfXLDM4WddCHfXWIq6KwPvQnx9YDrpG
         gjswmyHmeu7Uz53jPMNj52gKyb9/aXJar7YWQkqhEc3yjrV+3cc+bHNZUsZDJdDqf9zV
         6K7zxKH/7FJvnVclS3xHu6/NS5lzcpovpK+P8Wu9GwCgrXJIrxAIKGwZwCk+P2abtWTf
         tKNs4b9IOX4vy2D5O9OWolnnzWgk7FeLkUlH/IhHE4JIjhxg/Xx9pSzNoFcy9ZzzKn0k
         luFtU+SpIn3ERf1pOUFP+Z4CAtgiM4BrEinMd6aNVk4nI212Aao0iRNJSX+ntwphM+XV
         Bujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlaXfET5L4G5Q3oIQtoqkvvOO4wQfddYSuicKTgAAs4=;
        b=UKNh4byHAXlUZqbm5GwQHQhctCMtN/BifyH26PCEO61xjJVqyAw+oVy5t8r1O7MlMM
         UrjyAUvzLpuADfguO+xjHKqz+DqY5eSGry3Xzs9+Ccjbn6cqOVQW/TyInJFRmW/NuiMJ
         RJQ0GCOrXwxqmkRFUBDUFLK/UCVFEu2qCtYqbn6vvzjaGqADr9Cx/+R3tEfP7SvKWrEP
         506qraipQE6jnK3IFGho0ZjtPcA/0kUVAPyRfx3B4jmqiXVg+VCAE+SmUW5F71ChwC+F
         1K5EknEHgT8AjmoxP9Z0Yj6p2+Jg2JifOmBTpPgYER09fxx+DMlAVU3kgxpW4HgxutBq
         1dAw==
X-Gm-Message-State: APjAAAUqilD5pI/CoheDZKSspf4asKf724Rtoz7xxqNG8cBF9dL8W6Gi
        u6UkODftqEGinab/7GRogR+8R8wf
X-Google-Smtp-Source: APXvYqyym5mhGZi374E3oda5UerOu6AhLVBE6xpUJREvtKx9JcTanA/G90osamA3KqJoKPBu5wMMzw==
X-Received: by 2002:a19:4:: with SMTP id 4mr8144577lfa.162.1561326517853;
        Sun, 23 Jun 2019 14:48:37 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/11] PM / devfreq: tegra30: Handle possible round-rate error
Date:   Mon, 24 Jun 2019 00:46:50 +0300
Message-Id: <20190623214658.11680-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
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
index 5e2b133babdd..5e606ae3f238 100644
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

