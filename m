Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E220880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iikz0tPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfDOO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:57:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfDOOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id z9so13310047lfh.6;
        Mon, 15 Apr 2019 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7D/dM4fBipnsxvEmjwhEN3m1qZVftiiLl0htXbGoqfk=;
        b=Iikz0tPMSJHo/9b4xUuPm1im8HadYaPqh9vcZPmXfTqQZF/t4h05StVCLF/4NTrpJj
         yyQ2i6Jp8cEAIrOYfhXumCM8t52K35kto+ikNmNtPkfkayLdpks7b4rmaV57jlhqxItP
         xrrQbJaFk37lYOic8Xbb9DQdhhntERlEVJilNvfBxgpA49/svNhSPvqXiukIUyBe8PgE
         nxC/lPlk2ncCaCQuggJAdKMP25/9d9yO4Y1YGHFEgUy5tebiuOSJdZIvgPz0RnS1WkCG
         qZ5lwAnepwTY8UUmdDAwmWfsZUu7oGBotbJ2HgUC+dWjXLFVq8JsVpgMPNk+w4SMp2NZ
         wQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D/dM4fBipnsxvEmjwhEN3m1qZVftiiLl0htXbGoqfk=;
        b=qYx+cj9lKhM4ue89LE7A5kFNf7hwcn1tojpT99LGoHPTn+4hgOJLv3O1StaHJcoLi3
         LgrdpEN3yt6u/y1hcslvfFBaTOlAU/cqb3csjl/+4u3MsO0MZWcPIomWf/SE571piysC
         ZeFWjQ6pb3dEFNF2RRLhKcw1z5Zk+alF9x1ozP40FTyQnV+D/YLuhIPdMRWzm8BXfa+P
         flDjGUNz6xm4LNoMG17wT2HfyMLZuDli1dSUKyb/HRB3ekDMa5bqY94Thy4x8iRuxVir
         OZBoX4ZhkJn50kR/6RmHRpFj6f3IEjSiVgncI7bnRFxjIzeEQlJAlC7AhtQjDyUDz+js
         Za3g==
X-Gm-Message-State: APjAAAV4VEvZ42rMvYo74YNDwQnJb+wFwklQdeSQgQCHv5BId7s1ujr3
        +Dis8US60+FnfO0GONseq0I=
X-Google-Smtp-Source: APXvYqy1bMLic7CfWsqtXpzVp1bacFt6Mzr6xcju2cRaYJXXHDIdXlquzv+f1H75V6XYOfX06v8JXA==
X-Received: by 2002:ac2:4355:: with SMTP id o21mr40392111lfl.123.1555340142627;
        Mon, 15 Apr 2019 07:55:42 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 07/19] PM / devfreq: tegra: Register clk notifier in the end of driver's probe
Date:   Mon, 15 Apr 2019 17:54:53 +0300
Message-Id: <20190415145505.18397-8-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notifier isn't unregistered if something fails after the registration,
move it to the end of probe to fix the potential use-after-free problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index aa0478464b35..c248c18431d9 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -647,14 +647,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
-	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to register rate change notifier\n");
-		return err;
-	}
-
 	reset_control_assert(tegra->reset);
 
 	err = clk_prepare_enable(tegra->clock);
@@ -712,6 +704,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
+	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to register rate change notifier\n");
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.21.0

