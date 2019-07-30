Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC42C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E6B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAUTUufv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfG3Q6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40945 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfG3Q63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so66553090wrl.7;
        Tue, 30 Jul 2019 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=NAUTUufvGlYmbXtx0BrQ8Spn8k75k1hrcxu9yVpNJkqC8LcPX8MAYRiSQVyEayJLaA
         Qf6L1YYID/3lYDmM3id6l4pdn1Hgnh5GvKD1/hyPriJCsrTh3Cxr8/IiGPS6rSEEnb83
         VgA6Fb3d9xLCPLJoM3ZcRfYJOIboxAgQPtf6dklFi4JnuKUHLZs4aMC4CE41p2Tzd2sN
         ufgG1ukv9LYcKP8h0rt96QI5CCrx1ugDu+D+ocSMLU04cQJtR5zqK6PI9ai3Qu3Lg1HC
         ELfKLuzFJBpFIMloFOWr1XrA7Ecdznj8pg1FxJud99qclPn4gQ1i6Zv2Jg1sm3IQJsZ+
         ndKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=YlbD6m4dv2VF7u8xLbuC1hzqruEkHvqMP9m/5DeJZyUV3nv2SjpzEMWdjzxvTyLtRq
         I04KdwAb7TZu+EGEcUN6hcyu7FH2QTxiwNvl4hSRO3FZA3vjDQOvspLrSmfBs4ResY/H
         y+2k+Z88j3Y73quRllD/GiqGKuW6gqUod43e2kTbQiL8rRytMKojXntFIOFFNP1udFXZ
         5oxp3QdqoTrRJAYYzjNMfA4ftqheAUizaZNCwScpHtXLL/yAz5CsylZyXxUqYAHyKaE2
         gJ9iO6MFdV+uttxAG5AZjD+AYAU+AFspJN+6gO3Mjy8yh7RSwFun+4TuUcoXYHUPGf1r
         3MWA==
X-Gm-Message-State: APjAAAXUxn3spKNIp5PnpufxVQ2Yr+v0Bqr1n86ROceODvSR8Blh01T3
        zR3WAv1/A8OkBrDGzNcXwYg=
X-Google-Smtp-Source: APXvYqxFbS1QWM38dnF3WEBnBl9kriovIj8ld+XbjcoBMJ21dVonGpleiHaLuj5/unTRN8SpJjZB9A==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr33499453wrm.218.1564505907062;
        Tue, 30 Jul 2019 09:58:27 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/15] memory: tegra: Ensure timing control debug features are disabled
Date:   Tue, 30 Jul 2019 19:56:16 +0300
Message-Id: <20190730165618.10122-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 43819e8df95c..1bad7f238881 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -657,6 +657,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 410efc4d7e7b..cd52628c2b96 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -30,6 +30,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

