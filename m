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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455D1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A07C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYnGNFvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfJ3VuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:50:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41468 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfJ3VuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:50:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id j14so2786622lfb.8;
        Wed, 30 Oct 2019 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f826ICSvIVirQihDI3HVEjVvtOOLrMfG1BZagGTqEPc=;
        b=AYnGNFvhajSJaSsqLIIMSL5b8ZYYXqWtA5T4dwg8P6InokKbnLedKPC628kiNE+F8h
         HIuzr1mBmoH7eBEeJA6CFHbT+cI65gyUXU+77zrL2+9vbi1WUUPGd0BcdC4NduSfI1YW
         0qwhQ710B+NpoQ3Sp83jjdt0b74Tu+fGtqRO4aTsAwbX7/YrJFMLG0ZYuWxz4rW4qbP5
         HBmkoeANrrEPHGO7qtl4xjH3pV69A3EEguZRQNXMzHd+P7hsf1Mxl4rfvLxyMDR69v1+
         zloMLB2uczRDg/WBI0kmMncGDqH9OxUdRTTqO8tu0yvsEsEAIjIGdhg33wvijZaeYwIo
         E4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f826ICSvIVirQihDI3HVEjVvtOOLrMfG1BZagGTqEPc=;
        b=ZSLhHBrveGAH8F2xfsTDj+d0Rfr/g2st1psyOJhJj14mbO94xhB8KwoLptyGbctayq
         j+iU1XdSPp0w7QbQ0qkageCd7hgv8+QSlJy+ZrMysgCbW/CSWNFjdXZSfWDIzx89RkwE
         tSBbqwAGxhN5vaqdRvoLwiTuKIv9aRBFpEZ5cRcdpwTexgCoTJslxPjXUAEu8ECfvArd
         olGFHIhAv85UIZQnKH+MaCuU09KuwYeqJV3gMVxO//kqSW4u6J1UNOU9y4NVBrw5Bbss
         NRrfWBoPrLptMpQw5HbSL/mu4y4vP0pWkasEacsl5N7woDOQvyUImeBrUHQXGNCCrkiP
         sb4g==
X-Gm-Message-State: APjAAAVxpSSVSdqhzi3UeASE4Yal7Lzoi1vjWxHS1GSwmOCJY5wB0tUc
        A19zl2Po29+KOAO2U21LuJx0W6vo
X-Google-Smtp-Source: APXvYqztupuTVJB2wW2poL6Iu23u+t8yg0IMjsf7OJlr7KgMkJ/PMGVxOPRrA4l0GZRYt0FFcRgRow==
X-Received: by 2002:ac2:4a6c:: with SMTP id q12mr288945lfp.68.1572472203204;
        Wed, 30 Oct 2019 14:50:03 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id m3sm569192lfl.0.2019.10.30.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:50:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra20/30: Don't pre-initialize displays parent clock
Date:   Thu, 31 Oct 2019 00:49:10 +0300
Message-Id: <20191030214910.14120-1-digetx@gmail.com>
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

