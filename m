Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD22BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD1205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP0jP6IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfDSSmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:42:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33259 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfDSSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:42:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so4623739lfm.0;
        Fri, 19 Apr 2019 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkDQoCQpTgRPIKUHwSpnY6a7B5BEF0xk1EkoTQxVLwY=;
        b=tP0jP6IRgLznIdATt0uMp2nYkMcRXvYtZqZS3Wgu8TBD89Nz+/Ro0WR6SwzDCio120
         aPV34kQsrssK1uSbM39qtjOKbyZZmxqdwGRuhCPRrMrzrSjD68/qCYQKfRb33ekYTByx
         meRQjz/OqbzFA3sDqMtehLi2eHNPFeYBAfxfkmz9bgq/43sFQAExfMu+cI2uEoy7C31e
         jZ9+UUzoIhcKE/ZFo6DxaDgWjl/qPM5SVr2w7o91okr8hgZQFCMOmn1v5uIjYUduFngs
         UrJGkVz7ixz2P1f6DJc39j0dqRemqIiw3HDU+MupIAQozZfsmiCaeAT4HVkowMJuPcrW
         N5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkDQoCQpTgRPIKUHwSpnY6a7B5BEF0xk1EkoTQxVLwY=;
        b=STtlotRtxCSNBef+1cibTjr/61L3H6qmEMxTvfK0oSTATWsmCk4TzseBgL/KJvx+3R
         vB9G3SoG2bKuUSmVqB+wR8jxZNQmy8gEpa0kzrLX17icC90NDZtKuBnrcGPS3czsGYqM
         LHRI3wzauf0bSLw+GYjepS775VQCuk+bPjms1qTnEa/aCvHfeM9NwWH5A2LrFXoFvDBL
         qLxU2YQ2CjbPNEVfSveik0kgsJsmCmH1BMjjcEebJXoKjUo4gd1fbWHPOEvceWhG60oR
         /lqZZKspyqS8QcN7sJu4yg8bLZmFpIntJGzGawUTcrvurv4p/trQDpdE3Nv7uE4luKuM
         Er0A==
X-Gm-Message-State: APjAAAUgR9agSpBqZ5AbdRpuCAxu3Q0qhDn6hLlpfum2gSjiJQPHOA/4
        uc3CdzpZCPJ18Rrbg3+yzK0q02tI
X-Google-Smtp-Source: APXvYqygVdiLLfZ89BVhO+jOmC07goWGyUolGFQSE7DhyxkhRAlan9Af447i6sggU+pibboGL7vhXQ==
X-Received: by 2002:a19:f703:: with SMTP id z3mr2045154lfe.119.1555674339904;
        Fri, 19 Apr 2019 04:45:39 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm1061371lfh.94.2019.04.19.04.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 04:45:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] clk: tegra: Don't enable already enabled PLLs
Date:   Fri, 19 Apr 2019 14:42:26 +0300
Message-Id: <20190419114226.8066-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially Common Clock Framework isn't aware of the clock-enable status,
this results in enabling of clocks that were enabled by bootloader. This
is not a big deal for a regular clock-gates, but for PLL's it may have
some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
clock) may result in extra long period of PLL re-locking.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-pll.c | 50 +++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 3e67cbcd80da..6b976b2514f7 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -444,6 +444,9 @@ static int clk_pll_enable(struct clk_hw *hw)
 	unsigned long flags = 0;
 	int ret;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->lock)
 		spin_lock_irqsave(pll->lock, flags);
 
@@ -940,11 +943,16 @@ static int clk_plle_training(struct tegra_clk_pll *pll)
 static int clk_plle_enable(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 	struct tegra_clk_pll_freq_table sel;
+	unsigned long input_rate;
 	u32 val;
 	int err;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
 
@@ -1355,6 +1363,9 @@ static int clk_pllc_enable(struct clk_hw *hw)
 	int ret;
 	unsigned long flags = 0;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->lock)
 		spin_lock_irqsave(pll->lock, flags);
 
@@ -1567,7 +1578,12 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
 	u32 val;
 	int ret;
 	unsigned long flags = 0;
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	unsigned long input_rate;
+
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
@@ -1704,6 +1720,9 @@ static int clk_pllu_tegra114_enable(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	input_rate = clk_hw_get_rate(__clk_get_hw(osc));
 
 	if (pll->lock)
@@ -2379,6 +2398,16 @@ struct clk *tegra_clk_register_pllre_tegra210(const char *name,
 	return clk;
 }
 
+static int clk_plle_tegra210_is_enabled(struct clk_hw *hw)
+{
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	u32 val;
+
+	val = pll_readl_base(pll);
+
+	return val & PLLE_BASE_ENABLE ? 1 : 0;
+}
+
 static int clk_plle_tegra210_enable(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
@@ -2386,7 +2415,12 @@ static int clk_plle_tegra210_enable(struct clk_hw *hw)
 	u32 val;
 	int ret = 0;
 	unsigned long flags = 0;
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	unsigned long input_rate;
+
+	if (clk_plle_tegra210_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
@@ -2497,16 +2531,6 @@ static void clk_plle_tegra210_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll->lock, flags);
 }
 
-static int clk_plle_tegra210_is_enabled(struct clk_hw *hw)
-{
-	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	u32 val;
-
-	val = pll_readl_base(pll);
-
-	return val & PLLE_BASE_ENABLE ? 1 : 0;
-}
-
 static const struct clk_ops tegra_clk_plle_tegra210_ops = {
 	.is_enabled =  clk_plle_tegra210_is_enabled,
 	.enable = clk_plle_tegra210_enable,
-- 
2.21.0

