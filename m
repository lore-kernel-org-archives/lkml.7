Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6BD24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDe6ldyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfLRUWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:22:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38080 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLRUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:22:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so2638963lfm.5;
        Wed, 18 Dec 2019 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMs+lSRV0i1HSQ3p/ltut5IB/OSBXwDLX74KO1dTGWY=;
        b=mDe6ldyN4hmYq3D927ONzNjoBO1W3jOj5hYLATMVKxKxJObYmc56/Qrz3++NA6YpYJ
         nnsECK3ppHOfNMaCGbe0Zz7WXGY23dPtq5zSSr4biEoqt217dENwOeUMQphhWlER1x+t
         QpdDEFPMzl0uGp1D0+w/5sSYbM0OMHESBwuz9k8BCm4zdLaBicvubV+ZDZqeXqZKZVa6
         n9JzwhIGtdEzF4qeV7648Dr3juegCTdACJN/UKWV6yqM2S7H7bemiwXzGTlCAME2NWHV
         Xb4httOLph8A5DUmwfw38hkfeON5/82AxEP/4ofOF3WLPgYKCNnXIrHiLDFGJV187n1r
         VjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMs+lSRV0i1HSQ3p/ltut5IB/OSBXwDLX74KO1dTGWY=;
        b=n6IH7yn1IcdEH0xTDIStREAAVFIBY004K3+7tubSTlv+zgUjYxfX3OR+8n4kQJtWae
         GbFGSHDx4aDGMLALIUjmI3X9m4UsBeowNf5CvD/huwKKg25nTa/iLgcxXh1KtVxaa1nj
         DTI0dw7C+zQ/XpSeb6u0fuKCKdF8A8wVN4+Rll3TgVOtyaqetGoYzmWoAOlI9OZ0e9Qu
         fm3mSQrfW+oPb7irsg82bjHQlrt4F1Fo3cyUw/oXiEGRF8Fu2R3VUVDDfgWMDSxPz6CS
         DsLHoorDp7U/hQhbLYgd1+jWUmJrfNy4Ocpu3yQhVv/7Lcpnb5uF+522ctKakqHmfhH7
         440w==
X-Gm-Message-State: APjAAAWx4r0TxcG2QODgV1r6JWegFVGUtSbsHXq+QFwA/U7H6e+IveZs
        FjFSBZh4dGwGY7iqYxmop+I=
X-Google-Smtp-Source: APXvYqyvx8mSEOPrPIxmtyyllhYTF8IDDPTSjcpse+kxz+ZT+ZiPI/q3j6LWY6NgIEtzPvGn69dnlg==
X-Received: by 2002:a19:710a:: with SMTP id m10mr2962379lfc.58.1576700522931;
        Wed, 18 Dec 2019 12:22:02 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/12] clk: tegra30: Use custom CCLK implementation
Date:   Wed, 18 Dec 2019 23:21:35 +0300
Message-Id: <20191218202142.11717-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to use the generic cpufreq-dt driver on Tegra30 and thus CCLK
intermediate re-parenting will be performed by the clock driver. There is
now special CCLK implementation that supports all CCLK quirks, this patch
makes Tegra30 SoCs to use that implementation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c8bc18e4d7e5..0fe03d69fe1a 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -499,6 +499,8 @@ static struct tegra_clk_pll_params pll_x_params __ro_after_init = {
 	.freq_table = pll_x_freq_table,
 	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_DCCON |
 		 TEGRA_PLL_USE_LOCK | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.pre_rate_change = tegra_cclk_pre_pllx_rate_change,
+	.post_rate_change = tegra_cclk_post_pllx_rate_change,
 };
 
 static struct tegra_clk_pll_params pll_e_params __ro_after_init = {
@@ -932,11 +934,11 @@ static void __init tegra30_super_clk_init(void)
 	clk_register_clkdev(clk, "pll_p_out4_cclkg", NULL);
 
 	/* CCLKG */
-	clk = tegra_clk_register_super_mux("cclk_g", cclk_g_parents,
+	clk = tegra_clk_register_super_cclk("cclk_g", cclk_g_parents,
 				  ARRAY_SIZE(cclk_g_parents),
 				  CLK_SET_RATE_PARENT,
 				  clk_base + CCLKG_BURST_POLICY,
-				  0, 4, 0, 0, NULL);
+				  0, NULL);
 	clks[TEGRA30_CLK_CCLK_G] = clk;
 
 	/*
-- 
2.24.0

