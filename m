Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECBC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D4121773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l4MLGKr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfEUXbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8574 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfEUXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a420000>; Tue, 21 May 2019 16:31:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450009>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 05/12] clk: tegra: add support for OSC clock resume
Date:   Tue, 21 May 2019 16:31:16 -0700
Message-ID: <1558481483-22254-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481475; bh=eLb0PzrFoVvUZXrZVy1nnd5XODPzlndjREfY9jmUOqA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=l4MLGKr0DT0U0W4Z6UF4kwLiSBc4nVItX9MZk9OGRVnj7l7NyNymKV2gLzag72XBC
         Njpj/TAX46Evn/BKeV5aHchD/Z0NOqtoCsBB3D/dgOP6SLhX4YZwscmNx4uYl5UpNH
         GiE+s+3MAvwm0YzjpLlS3Ytu090wc6WRnbTXZGx1wrqE5K1z7T6fE1xb66kDdwJqYv
         037+77SyMS6csRzdAiUdDyz14THRhoICl8U8+HyNO3nmpfqH+9bkAwBafx4IivBzqX
         DNate0B0xoxHCqB4RLzxx8jkze7gvE8VnFhfJHdLJ9HliEXP5syssFdbpLdtCWhn0O
         ELRSZ67uL/ymA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for restoring OSC control context on resume.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra-fixed.c | 15 +++++++++++++++
 drivers/clk/tegra/clk.h             |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra-fixed.c b/drivers/clk/tegra/clk-tegra-fixed.c
index 91c38f1666c1..7efb35717e06 100644
--- a/drivers/clk/tegra/clk-tegra-fixed.c
+++ b/drivers/clk/tegra/clk-tegra-fixed.c
@@ -28,7 +28,10 @@
 #define OSC_CTRL			0x50
 #define OSC_CTRL_OSC_FREQ_SHIFT		28
 #define OSC_CTRL_PLL_REF_DIV_SHIFT	26
+#define OSC_CTRL_MASK			(0x3f2 |	\
+					(0xf << OSC_CTRL_OSC_FREQ_SHIFT))
 
+static u32 osc_ctrl_ctx;
 int __init tegra_osc_clk_init(void __iomem *clk_base, struct tegra_clk *clks,
 			      unsigned long *input_freqs, unsigned int num,
 			      unsigned int clk_m_div, unsigned long *osc_freq,
@@ -107,3 +110,15 @@ void __init tegra_fixed_clk_init(struct tegra_clk *tegra_clks)
 		*dt_clk = clk;
 	}
 }
+
+#ifdef CONFIG_PM_SLEEP
+void tegra_clk_osc_resume(void __iomem *clk_base)
+{
+	u32 val;
+
+	val = readl_relaxed(clk_base + OSC_CTRL) & ~OSC_CTRL_MASK;
+	val |= osc_ctrl_ctx;
+	writel_relaxed(val, clk_base + OSC_CTRL);
+	fence_udelay(2, clk_base);
+}
+#endif
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index ef444648fcb1..7567cf7bd29e 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -856,6 +856,7 @@ void tegra_clk_sync_state_pll_out(struct clk *clk);
 void tegra_clk_periph_suspend(void __iomem *clk_base);
 void tegra_clk_periph_resume(void __iomem *clk_base);
 void tegra_clk_periph_force_on(u32 *clks_on, int count, void __iomem *clk_base);
+void tegra_clk_osc_resume(void __iomem *clk_base);
 #endif
 
 
-- 
2.7.4

