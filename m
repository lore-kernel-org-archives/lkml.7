Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F43CA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfYF08e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfJ3V7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:59:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45732 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJ3V67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:58:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so2789766lfa.12;
        Wed, 30 Oct 2019 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D2IZ9aCfy9I24RPB3SSOachEcmLjtwKim1mzoRC2zU=;
        b=jfYF08e02pu9RPv9FZfl8uObu2QvjBi+U9XrFdOBHhqUO5LuWR216QtFJaC0Illx2b
         cUjtBPPl6GWu9SMypVcQLl3r558Q8fM1o4dimiEw2XpniFvKwC3GEhFHKPOallicSaNz
         WYtp7MOwDY6BeftraeMsvXDtosDcG93jg1KRczYbrow4pMdFy+0BCK/VwpzqGicA0DcQ
         URu2bdhBidphbb3MqD36bpyX/eQXc2f0Zq3fcMeBkD1EZwidOcEgC87cxHWhf5AUIPBZ
         JSGsNNv4WM7fLU09U9HU4z/QPHmFHBq271l35c6IXMLNo4tC7noN/DOBv8ICScxxE2gR
         fhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D2IZ9aCfy9I24RPB3SSOachEcmLjtwKim1mzoRC2zU=;
        b=e6isHwN9xL71BAqew81IoryCwdlYnWl4bqGCc2eFgCLG93aBf3Y3ud9NmTW2RdFYbb
         qB3ZOz+qkKv2M7tUQCYmjHdjx7St06va36VtCGJZBWwCikm2Jsbmg6GlbkGz53UBTQLz
         Xc8xu4rECBq5oizEdmSyz6lFKyRgXDT7/xa3E9b1JJ1VUxePk5hsEawuXP/r7z7ey4WB
         r2Dy0MYnAhMwuFd9z8fz3AiPzY42hNrEycwRCQAJPopDhq/q3P8wRQgfyGkAkZtCjcYM
         WTZ6MtpgC1/ub5Q/9Bm7gP7NMZ9/uaxGO4zTilBGnrsifxxuEHGMl8tJv9iWWpC8oSj+
         c+tQ==
X-Gm-Message-State: APjAAAUfrb1mQ3vycZroDfzsNGP5l8W1cI7hpjJLJYaNad5rTI7G94zV
        qCTLRitHsi50V3qYcwWK06U=
X-Google-Smtp-Source: APXvYqyczW6OTna3YA3BhTHp8GcvXJ6hktP+iWoMc+jsZfsKO+XysuuVObH8VHpaGC7dtGRDZvavkg==
X-Received: by 2002:a19:dc4c:: with SMTP id f12mr302650lfj.86.1572472737719;
        Wed, 30 Oct 2019 14:58:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 9sm429988ljf.21.2019.10.30.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:58:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: tegra20/30: Don't pre-initialize displays parent clock
Date:   Thu, 31 Oct 2019 00:58:26 +0300
Message-Id: <20191030215827.15533-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Changelog:

v2: I accidentally didn't include the second "VDE" patch into the patchset
    in v1.

 drivers/clk/tegra/clk-tegra20.c | 2 --
 drivers/clk/tegra/clk-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index eb821666ca61..0d6441621989 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1049,8 +1049,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_SBC3, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_SBC4, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_HOST1X, TEGRA20_CLK_PLL_C, 150000000, 0 },
-	{ TEGRA20_CLK_DISP1, TEGRA20_CLK_PLL_P, 600000000, 0 },
-	{ TEGRA20_CLK_DISP2, TEGRA20_CLK_PLL_P, 600000000, 0 },
 	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 0fe03d69fe1a..8146cc49ca3b 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1253,8 +1253,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_SBC6, TEGRA30_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA30_CLK_PLL_C, TEGRA30_CLK_CLK_MAX, 600000000, 0 },
 	{ TEGRA30_CLK_HOST1X, TEGRA30_CLK_PLL_C, 150000000, 0 },
-	{ TEGRA30_CLK_DISP1, TEGRA30_CLK_PLL_P, 600000000, 0 },
-	{ TEGRA30_CLK_DISP2, TEGRA30_CLK_PLL_P, 600000000, 0 },
 	{ TEGRA30_CLK_TWD, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_GR2D, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
-- 
2.23.0

