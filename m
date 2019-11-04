Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCBCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22564214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdCjSD8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbfKDWTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:19:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33804 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbfKDWBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:01:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so19447487ljf.1;
        Mon, 04 Nov 2019 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1R8aUcZkIlTPITklCBswnMHd9GSu3KTIu0/oTyANNB4=;
        b=AdCjSD8TnsTPwI4dFdR0KQGG86VvivC4CHxoQEHZFgXtYxIe04LMlVEyzMMVo+k35I
         r5xzm06wZt/7uwOCNPpnvyeYCxEX8xU6mq3qB3emhUUfD3rll39D2PXzd5CRYNRdYDuG
         q99yY6GWGcIlUeCGAizEeyjhpFLGfFifdVRFwPtZdpY27kIRbPxWGMg1my64B4HBre8u
         jMCVZM17pJLLlWrmxD1hOMVQwvziKJDVqoiBU14PoeM+nhdasvkwzTNuBPjqEv6KQ/c7
         q8CpVCuhoOmzQ6tf/MyPQt2DbZ49L+PWc6gRvbE1/MWrexx1rPUT5d8kRLh15Esz0mbD
         cIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1R8aUcZkIlTPITklCBswnMHd9GSu3KTIu0/oTyANNB4=;
        b=V95CFftRt0Pu84xDAEpgGqzUwbnzqcVRihqIMH8XFH0txANl166q3e80o2JgAjupdc
         D13OjoJoSxnaffE/KwnapsHviFjpKSVsSqQH2o9MWhwe4sQhU6LpFM5UaCc8+20p2zf2
         F7D5u1XesIu1JbcKMaTO0WneHi6lp4UMPKVHmUYKFelzxmCNGafiTM8emICMJIDFwbD+
         +DQtQZNpcbZInrvheYsj5JA55Ry+8JkY3cmpxCqrSLlmeF926O5fLi3EsqejUwDLemde
         VJd4YrLvSkQfKn6T15uRcQRax2xUuErQw4CsQR9EORwbINwEKp8wDmdkPjCv4A1BkgRq
         QLvA==
X-Gm-Message-State: APjAAAU4N0KkpYRNF5EhDqih77CzWG1P1sOoCNsjPVfC4yFGXolnIl7H
        sOZ6BOOTq1qLuRTeb1m7TLM=
X-Google-Smtp-Source: APXvYqwoC5tiuhzzXdz5nXIupEbKytBtgYU2M8i1VDswQwmIJLCpT4jGS7xdYXsy77a+5/0pthzofg==
X-Received: by 2002:a2e:b5c4:: with SMTP id g4mr20568516ljn.169.1572904872002;
        Mon, 04 Nov 2019 14:01:12 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/19] PM / devfreq: tegra30: Don't enable already enabled consecutive interrupts
Date:   Tue,  5 Nov 2019 00:56:11 +0300
Message-Id: <20191104215617.25544-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consecutive up/down interrupt-bit is set in the interrupt status register
only if that interrupt was previously enabled. Thus enabling the already
enabled interrupt doesn't do much for us.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 7c8126e74750..4a5d513904a2 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -261,8 +261,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq >= tegra->max_freq)
 			dev->boost_freq = tegra->max_freq;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
 		/*
 		 * new_boost = old_boost * down_coef
@@ -275,8 +273,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 
 		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
 			dev->boost_freq = 0;
-		else
-			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	}
 
 	if (dev->config->avg_dependency_threshold) {
-- 
2.23.0

