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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4F5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05FF20644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1DpDdnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfFXB5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:57:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34461 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFXB5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:57:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so10957939ljg.1;
        Sun, 23 Jun 2019 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPiHCgSWlyFbcnT0W5lDiXP3U67kYIPo6pYV48G/ks4=;
        b=C1DpDdnAs/+ZUXfe2fzAHS/UGr5Kfwk03xsK7piYc3a4y31Wsl0HCxa1IPpTNCe/xL
         xIR5VtV2bX/3eiziVZQeieEbrrDaT8Bb5k1ZkD+eBL6HEvTYC4tFE/4IVgM75Jmf0leo
         53+UZxGdQ0suo0D2va3pXO0JUx7BfcV3N5qZOCpqGnvGT4oHV7rc2yoisj1xpQUsRBEV
         F0Ui/7GYb569tH24oUl9/bWwawj92caTrnGQoDwlbcHepb/BYWchPrxaI7gxxZPyW81m
         A5Vml1XF/I/xqVJX7fnYJtjUu/gEb1/fdLxDQ/aooEHHh8DMuiAEFt1gnE9zDDtTKdGm
         xjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPiHCgSWlyFbcnT0W5lDiXP3U67kYIPo6pYV48G/ks4=;
        b=sfD0v4TweFsINSDYDJNi/t727YAITq11nTuitzKMe+Hl/5On0B6lOSTylpX5X8GAi+
         rh/YQri1NXQ2TJZVTn4go8HFwYscBKXzrL8tTDUW7ffGnSx6QdkYn9c0pjxsQZPSq1io
         kUj4x7Jlw255O72yAQYqeCOCardHu0/ZbVsa1GTCC76VGS1v7miFbOsZYJ0D64h538UT
         7gbrwlLJpHxNVXV3NvKEbYYgpiFENQPNT8w7Wgfag2WeWdMeQ3Lf5S6+9brgKk0PjXH9
         nO+lqzEtXnLPLAnBBApyuucSvc+FqTpyAEBTwoPBbn/ecYB5ZGDnUGwdZj1CZox8wDzE
         Bc4w==
X-Gm-Message-State: APjAAAU012jgqwB40vDPLLNTYCU0sv/iH+MMrLGmbOw7U+iJg4rWGCa1
        NKPvA0zugIEG2n3TzLEOeD+JYegP
X-Google-Smtp-Source: APXvYqxsJTx6rkvjW2d4Bcz7J2N9z0vFpkzEtCo9H2lCBuyurngQxI5WazFn9GloUrAxKt8D7HDBGw==
X-Received: by 2002:a2e:6e0e:: with SMTP id j14mr12976611ljc.85.1561326520760;
        Sun, 23 Jun 2019 14:48:40 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/11] PM / devfreq: tegra30: Reset boosting on startup
Date:   Mon, 24 Jun 2019 00:46:53 +0300
Message-Id: <20190623214658.11680-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Governor could be stopped while boosting is active. We have assumption
that everything is reset on governor's restart, including the boosting
value, which was missed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 813b0f490b90..fc278f2f1b62 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -544,6 +544,9 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 {
 	u32 val = 0, target_freq;
 
+	/* we don't want boosting on restart */
+	dev->boost_freq = 0;
+
 	target_freq = clk_get_rate(tegra->emc_clock) / KHZ;
 	dev->avg_count = target_freq * ACTMON_SAMPLING_PERIOD;
 	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
-- 
2.22.0

