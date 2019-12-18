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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8D5C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6244124679
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl/mcjN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLRSoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:44:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:44:31 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so2460379lfr.2;
        Wed, 18 Dec 2019 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOVKsDe9LGG5j1ETif1ZJ64tX9Yfod2gK7GPtOgEPIo=;
        b=fl/mcjN0Inn4J53cTISzwwKunBpVjOFs6mO2NmR74kNswtmnBdosMc6FyNU5wku3G9
         XsRq6fpgtpUuI/AqtzJAQmPT1NvMvN/ZgSO/zlYppUrf4JsnVllJTR2g1Z/lXPWiEUFL
         5LFxHSJjZnSHaUVvQgGXVQ/8FZt2hzxjS4VGX5D92gB0BHhzhLtj1KKi90YiuNPYCdrp
         qnwiN6Fnjdp66ITEjQpBPkX5iOtV4ySPXiMB5E8v4ifl7+45VQ0EGYcqZq7XGjSUBV8I
         oKqyDpX0/TPfKvmDhOTG5FGUEVdXzgpoXlwlIWp2Eo60CzA4yDKAGggoiN8gFjJ8ZhIX
         Ow/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOVKsDe9LGG5j1ETif1ZJ64tX9Yfod2gK7GPtOgEPIo=;
        b=l7ucKabOmFNDe0hvvqQ0CaNnvxmevZMZu9hzIizkJ3ZYOU8iAkIJbubOjqMgvFsf0q
         JY9oLYnerXa8SGoyrWv2ZjdL+bBQxHTZhTZMUqU0vBnXKZYjHOLHrJfUIkqb8i31Hh1q
         pg/3odFnaC7K3L8ySQ9DEKE7jEL3SfetgtAIS1rX281LAuRLGq1AQmPSvW8V8r4xIXCu
         5vMMSGQSkgNM33Shymp9GZDT79u9kAnhy0jheMUyXLuiMwxxjehCvYQNl93nwGgLtmRD
         fxMAFWFxW6VSMRQ6VYETmeCi9DNf01zPVP1C8fPl+y8YkjCePszt3mbU+hVXamSiBH+D
         P4Hg==
X-Gm-Message-State: APjAAAUseISSFdabruQ6NiYbCsN10FbkHUBB0ZcRmTEA0cRsFZRvn+B4
        59wdjBdA2Qksc4EbhZfFrx8=
X-Google-Smtp-Source: APXvYqxcOhEC+YyoDwD71+Fs8/hy9mFoRrOTi5mjrD5gpfu4V0qnSlUn6BTpa/nMq7OHBBIhV0a7WA==
X-Received: by 2002:a19:784:: with SMTP id 126mr2655011lfh.191.1576694668859;
        Wed, 18 Dec 2019 10:44:28 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j204sm1553354lfj.38.2019.12.18.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:44:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND for 5.6 v1 2/3] clk: tegra20/30: Don't pre-initialize displays parent clock
Date:   Wed, 18 Dec 2019 21:44:06 +0300
Message-Id: <20191218184407.25790-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218184407.25790-1-digetx@gmail.com>
References: <20191218184407.25790-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Tegra20 and Tegra30 are initializing display's parent clock
incorrectly because PLLP is running at 216/408MHz while display rate is
set to 600MHz, but pre-setting the parent isn't needed at all because
display driver selects proper parent anyways.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 2 --
 drivers/clk/tegra/clk-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 4d8222f5c638..0c14fb570343 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1046,8 +1046,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_SBC3, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_SBC4, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_HOST1X, TEGRA20_CLK_PLL_C, 150000000, 0 },
-	{ TEGRA20_CLK_DISP1, TEGRA20_CLK_PLL_P, 600000000, 0 },
-	{ TEGRA20_CLK_DISP2, TEGRA20_CLK_PLL_P, 600000000, 0 },
 	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c8bc18e4d7e5..bd4d42005897 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1251,8 +1251,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_SBC6, TEGRA30_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA30_CLK_PLL_C, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
 	{ TEGRA30_CLK_HOST1X, TEGRA30_CLK_PLL_C, 150000000, 0 },
-	{ TEGRA30_CLK_DISP1, TEGRA30_CLK_PLL_P, 600000000, 0 },
-	{ TEGRA30_CLK_DISP2, TEGRA30_CLK_PLL_P, 600000000, 0 },
 	{ TEGRA30_CLK_TWD, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_GR2D, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
-- 
2.24.0

