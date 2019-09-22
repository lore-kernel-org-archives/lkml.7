Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BBEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D564320869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCNItgjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfIVWQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:16:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42757 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfIVWQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:16:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so8596823lfg.9;
        Sun, 22 Sep 2019 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFYD+fwmoSXyFmKBXVRXyEsrw6rBXAJ+UIU1iw4pKzQ=;
        b=MCNItgjhLhk8mYA+AOoQ7mP3woaPOSlkJnIUVWGkUasSlp4iivPfIGV85YMTEN8nZt
         brB57fJtVWUsS42btjoZVs/kbIvViAf3IpOKUfnmfn9IY6II1vsOlkk7WGx53cRYRsP+
         wTx1m1k6zSvNwAeCAs5WmlKy8lub+Q8KnWVPyZlKgBgKnbxb6Ns25UoMEn9TxRtshCPH
         iMgrYfrsrc04vjYiG/kI6qZ6NrNo82+f3aMnPCTJarAXvXyhFboxio7Wz2l3Peals6An
         xdYHKrtCnDE4Um4WPxp0BTi1c5taTAStfSH+KRGZo4XhK6aElBnJK70LuiNlryiy8upH
         rLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFYD+fwmoSXyFmKBXVRXyEsrw6rBXAJ+UIU1iw4pKzQ=;
        b=TqyEWLJMtHirAvSpvm7cD4M9Jo/9JxfzC5n1JHq/sc7BuhcQyxBZrnq2G9YkmErOLQ
         F32JqwadTsUb6cZ/hamqDEDtOfuTlhTQ3cN68dePjPH3d5lmi54F4xlz79Rk85TVnBw3
         PB0e194Fx7v6t9k8/O6VkFt1m7iy7AjJshokOLJ7LpOlDFAkBr7mvkx1qAKwJvzwU5Kz
         EJaxYGnlNWmUoKDuFUYQqFKDoypr6JzdL2ciUCIrta8dfQz/IgUCuQSgROXvVkoo/ByB
         60PW19947axkhzRVfroH6z8QEmp7zENI1zzqflwTF7CMFQRapBxiaaDSwTjfA82FLkfM
         2mqA==
X-Gm-Message-State: APjAAAV7NqwlMN9OfxebkaLuqwnpXYTMPKoAJCabEHtU1A9QTORoo2Nz
        pRf4pzFkYCUbeQXphLu79WE=
X-Google-Smtp-Source: APXvYqwAK2TAL/PtM5Cs3y25z0RHYQu9TSu6qftq1slRlj05KUFVL0zKYx4YxQksn7N8uqOr+30eQg==
X-Received: by 2002:ac2:5445:: with SMTP id d5mr14558180lfn.43.1569189204261;
        Sun, 22 Sep 2019 14:53:24 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id k8sm2071373ljg.9.2019.09.22.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 14:53:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra20/30: Optimize PLLX configuration restoring
Date:   Mon, 23 Sep 2019 00:52:03 +0300
Message-Id: <20190922215203.32103-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to re-configure PLLX if its configuration in unchanged
on return from suspend / cpuidle, this saves 300us if PLLX is already
enabled (common case for cpuidle).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 25 ++++++++++++++++---------
 drivers/clk/tegra/clk-tegra30.c | 25 ++++++++++++++++---------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cceefbd67a3b..4d8222f5c638 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -955,6 +955,7 @@ static void tegra20_cpu_clock_suspend(void)
 static void tegra20_cpu_clock_resume(void)
 {
 	unsigned int reg, policy;
+	u32 misc, base;
 
 	/* Is CPU complex already running on PLLX? */
 	reg = readl(clk_base + CCLK_BURST_POLICY);
@@ -968,15 +969,21 @@ static void tegra20_cpu_clock_resume(void)
 		BUG();
 
 	if (reg != CCLK_BURST_POLICY_PLLX) {
-		/* restore PLLX settings if CPU is on different PLL */
-		writel(tegra20_cpu_clk_sctx.pllx_misc,
-					clk_base + PLLX_MISC);
-		writel(tegra20_cpu_clk_sctx.pllx_base,
-					clk_base + PLLX_BASE);
-
-		/* wait for PLL stabilization if PLLX was enabled */
-		if (tegra20_cpu_clk_sctx.pllx_base & (1 << 30))
-			udelay(300);
+		misc = readl_relaxed(clk_base + PLLX_MISC);
+		base = readl_relaxed(clk_base + PLLX_BASE);
+
+		if (misc != tegra20_cpu_clk_sctx.pllx_misc ||
+		    base != tegra20_cpu_clk_sctx.pllx_base) {
+			/* restore PLLX settings if CPU is on different PLL */
+			writel(tegra20_cpu_clk_sctx.pllx_misc,
+						clk_base + PLLX_MISC);
+			writel(tegra20_cpu_clk_sctx.pllx_base,
+						clk_base + PLLX_BASE);
+
+			/* wait for PLL stabilization if PLLX was enabled */
+			if (tegra20_cpu_clk_sctx.pllx_base & (1 << 30))
+				udelay(300);
+		}
 	}
 
 	/*
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index a19840fac716..3b5bca44b7aa 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1135,6 +1135,7 @@ static void tegra30_cpu_clock_suspend(void)
 static void tegra30_cpu_clock_resume(void)
 {
 	unsigned int reg, policy;
+	u32 misc, base;
 
 	/* Is CPU complex already running on PLLX? */
 	reg = readl(clk_base + CLK_RESET_CCLK_BURST);
@@ -1148,15 +1149,21 @@ static void tegra30_cpu_clock_resume(void)
 		BUG();
 
 	if (reg != CLK_RESET_CCLK_BURST_POLICY_PLLX) {
-		/* restore PLLX settings if CPU is on different PLL */
-		writel(tegra30_cpu_clk_sctx.pllx_misc,
-					clk_base + CLK_RESET_PLLX_MISC);
-		writel(tegra30_cpu_clk_sctx.pllx_base,
-					clk_base + CLK_RESET_PLLX_BASE);
-
-		/* wait for PLL stabilization if PLLX was enabled */
-		if (tegra30_cpu_clk_sctx.pllx_base & (1 << 30))
-			udelay(300);
+		misc = readl_relaxed(clk_base + CLK_RESET_PLLX_MISC);
+		base = readl_relaxed(clk_base + CLK_RESET_PLLX_BASE);
+
+		if (misc != tegra30_cpu_clk_sctx.pllx_misc ||
+		    base != tegra30_cpu_clk_sctx.pllx_base) {
+			/* restore PLLX settings if CPU is on different PLL */
+			writel(tegra30_cpu_clk_sctx.pllx_misc,
+						clk_base + CLK_RESET_PLLX_MISC);
+			writel(tegra30_cpu_clk_sctx.pllx_base,
+						clk_base + CLK_RESET_PLLX_BASE);
+
+			/* wait for PLL stabilization if PLLX was enabled */
+			if (tegra30_cpu_clk_sctx.pllx_base & (1 << 30))
+				udelay(300);
+		}
 	}
 
 	/*
-- 
2.23.0

