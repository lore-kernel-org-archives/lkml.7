Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140DA20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/kASAQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfJ3V7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:59:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40179 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfJ3V7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:59:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id u22so4388351lji.7;
        Wed, 30 Oct 2019 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PTvruMyJudl8KIl7cB1h1Hs9ux7BvolUSo2ebbahMc=;
        b=J/kASAQNnXbwLD/iXj8zuYKLlj+95pio3K1ygpMtBqiXjVyW1pjEmsqb0pBe+6z8or
         23WZPac7j+FVjwj82qUV4YlgnPXmQzwcjtce4sGqHpWDI021jGHvYRFFWBr8+aBv7vaI
         /Cp/M9QpBwlNhIsDXEVKlOyv6nAugClAQ8TvjoJFnXGd4aj8NoWzrNznQ6w2qTt0aFBT
         mHpO6G6/3xVEFwaJ/7CUPd6F9JTcipXYdNho5Z+CNEGgmMLiXMaXPax5oAgsdHLdkNZM
         E78J8+HWybh+USRxKpPs5vLDYk6qYHk/t6QyNvFdUlia7SWhdcCi7SjSO9mHB0IgR32k
         tEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PTvruMyJudl8KIl7cB1h1Hs9ux7BvolUSo2ebbahMc=;
        b=jFsfNwYqttmcpIJHRr+yIxjna8lt7XJe7JlX/QF3gUXEb6YXrHHVOq0h/wGciy2K7e
         CYEoRPJfL3SZGUfpxyB9lM+XjtJ92121D+OhBJZuEeMSrobAllkr21IGDsUDNaDgF8jj
         IbPKXb8NBTvNoGUJE6YgToEfLnI4Yc3rdsEsjhtFiquNagl7DIaYNT/LpAnaGaEHTtiT
         KSc5tIJwsCbGLm1ehkD0SBJ6PPDJ3y4mgpYI7n29JfdsQtfgqCxT9N7ct9Lxxpa89W+l
         Knq8h14mBiCKY612K7S4MfWhJcmNnnpkmZysms5JafLEMwqmU4qp4D0fCf4+2MYppExU
         L0qg==
X-Gm-Message-State: APjAAAVaSNligRA1ayg6cjlOyCzfvR+d0n5TVVZjheXmZhIcDtjXFzbD
        6Gy/szTVmI+pU8ciwEXNL9M=
X-Google-Smtp-Source: APXvYqyqTI9sAZowqVntg9lV7gOzQ/W2frzM85pFu9EjT/g3St3eAIDRSJrFSyusJ2E6OFXKSHXcFQ==
X-Received: by 2002:a2e:6c0b:: with SMTP id h11mr1334976ljc.76.1572472738672;
        Wed, 30 Oct 2019 14:58:58 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 9sm429988ljf.21.2019.10.30.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:58:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: tegra20/30: Explicitly set parent clock for Video Decoder
Date:   Thu, 31 Oct 2019 00:58:27 +0300
Message-Id: <20191030215827.15533-2-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030215827.15533-1-digetx@gmail.com>
References: <20191030215827.15533-1-digetx@gmail.com>
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
index 0d6441621989..abc6a2bc828a 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1051,7 +1051,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_HOST1X, TEGRA20_CLK_PLL_C, 150000000, 0 },
 	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
-	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
+	{ TEGRA20_CLK_VDE, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	/* must be the last entry */
 	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
 };
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 8146cc49ca3b..43b94175ff33 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1258,7 +1258,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_GR3D2, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_PLL_U, TEGRA30_CLK_CLK_MAX, 480000000, 0 },
-	{ TEGRA30_CLK_VDE, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
+	{ TEGRA30_CLK_VDE, TEGRA30_CLK_PLL_C, 600000000, 0 },
 	{ TEGRA30_CLK_SPDIF_IN_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S0_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S1_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
-- 
2.23.0

