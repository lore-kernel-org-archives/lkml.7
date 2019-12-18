Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B512C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE3A206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWu5k4UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLRSof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:44:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41821 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRSoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:44:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2434884lfp.8;
        Wed, 18 Dec 2019 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+s6MmvX7icUw9PqvAbzROxUfy5WGSHxEQBNGekKk1M=;
        b=eWu5k4UPSPnWt4SB9moFHFObPD8046g6FCMmloy9PcnDk3ptLRirVJw/39qIgsG0XO
         Lg4DZR/G2w4/834Cu8ZgnkBEcxXME7FuU1t5tfxAnkHHUKKWE999HQwuqSswry8kH5GH
         SNDlu/gQxRDqJhvrtPu0i7pzQtCb/kMGxOEzbG1DVzCKyqnKk25l3yHlTcZJKMczHdVU
         Zh/PhVy5A37OxRuSgZ17oHqAtxUCCbQHycGb2dRq8F103P/BgFVrakfALjnVHOhFLM7r
         coo6lqANCUQL06x2ggbSFlkSnrGwYUUWOWOzoGe7OMDW0s0uBaG2KoEoWcKi59SuShjP
         4Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+s6MmvX7icUw9PqvAbzROxUfy5WGSHxEQBNGekKk1M=;
        b=AFMsR8lois2J3IcIlcMCpNm57L9Tc7FU+saQJ3jLgpons0bpgricuEC/IYO8a5B5w8
         Cl27HH9/AYd2VM6jo+MpN6lPCyJj0R7nL9A3AeXKsslCr4SmI+A2TGODGVTQsrt2S9i7
         wO8Xvy2bVroV8rz19p5UuHQJHXIHfFefNscMCmuDRcYuOhBLE1wSF5UvUn0KhcRkdwMJ
         4iKEentshy2MxZ1fFmJzx3FFjpYqY8TA/Hk5ax3nXjY6r7AZ8peKtz75L0Bdoy67Vk7A
         UMcf6BIf4rr6i527ESok0bk/7qD6kYYFAYLntxXFB+fZeJJ73UpKAS1aDKugbz64rwiE
         Xt5g==
X-Gm-Message-State: APjAAAUrLxJLsKE6huqBDr2EXSnLXC0Or9P1W4njYiwb3EMrBHxEoAZ5
        YMb1oGnHWv5tKa00iqY2u4k=
X-Google-Smtp-Source: APXvYqx3pUFK4C9rEvv0I4zncfw0HhZuOlzK0cBQdhYTb2NqAe4bgmQqGDfSVjwRV67Eu/OOEAyKhQ==
X-Received: by 2002:a19:4f46:: with SMTP id a6mr2765387lfk.143.1576694669901;
        Wed, 18 Dec 2019 10:44:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j204sm1553354lfj.38.2019.12.18.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:44:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND for 5.6 v1 3/3] clk: tegra20/30: Explicitly set parent clock for Video Decoder
Date:   Wed, 18 Dec 2019 21:44:07 +0300
Message-Id: <20191218184407.25790-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218184407.25790-1-digetx@gmail.com>
References: <20191218184407.25790-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDE parent won't be changed automatically to PLLC if bootloader
didn't do that for us, hence let's explicitly set the parent for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 2 +-
 drivers/clk/tegra/clk-tegra30.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 0c14fb570343..fff5cba87637 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1048,7 +1048,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_HOST1X, TEGRA20_CLK_PLL_C, 150000000, 0 },
 	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
-	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
+	{ TEGRA20_CLK_VDE, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	/* must be the last entry */
 	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
 };
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index bd4d42005897..b20891489e11 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1256,7 +1256,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_GR3D2, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_PLL_U, TEGRA30_CLK_CLK_MAX, 480000000, 0 },
-	{ TEGRA30_CLK_VDE, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
+	{ TEGRA30_CLK_VDE, TEGRA30_CLK_PLL_C, 600000000, 0 },
 	{ TEGRA30_CLK_SPDIF_IN_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S0_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S1_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
-- 
2.24.0

