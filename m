Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF377C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886272082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nZEdyTYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfFRHqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:46:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19658 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfFRHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:46:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0896e90000>; Tue, 18 Jun 2019 00:46:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 00:46:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 00:46:49 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 07:46:48 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 07:46:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 07:46:48 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.217]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0896e60001>; Tue, 18 Jun 2019 00:46:48 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 05/17] clk: tegra: pllout: save and restore pllout context
Date:   Tue, 18 Jun 2019 00:46:19 -0700
Message-ID: <1560843991-24123-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560843991-24123-1-git-send-email-skomatineni@nvidia.com>
References: <1560843991-24123-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560844010; bh=Fzu2bnKTENqIS6KXMYVarTHgv0l912Cey6G3jQKOW8c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nZEdyTYucXwLVnD5zK4QnqT+ncZAbxqTqF5uPDpP5MfIbvasiNFCBWs3k75E1BVdo
         +34W/kyhru5QrdgiOIbhbKoivkYSQLp5GrXyi8P9Bx2sCqxZzqOG+fRSwNylgNlatX
         ZFGjLnEqVdOt8RNUa+FSt/iWnjIVkBA1XXflIGVlEwPFWSmRXfEq4M0vlOh6hPIXcg
         vaZXvnAq3WrUTeg77NmSsJT/HobtP9KROrHpAv+FcFEIPrJ9RI8GsU/QDcxOBDa0cp
         FNsIXUGPZkc5WoQ0/dBR72a/Zcdc40SrIGrYYMfUyNdgUPiqYObcLfJ9SCEBKcQ2ko
         8SHYbnn4m0F6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements save and restore of pllout context.

During system suspend, core power goes off and looses the settings
of the Tegra CAR controller registers.

So during suspend entry the state of pllout is saved and on resume
it is restored back to have pllout in same state as before suspend.

pllout rate is saved and restore in clock divider so it will be at
same rate as before suspend when pllout state is restored.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll-out.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h         |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
index 35f2bf00e1e6..52d140379ce3 100644
--- a/drivers/clk/tegra/clk-pll-out.c
+++ b/drivers/clk/tegra/clk-pll-out.c
@@ -69,10 +69,38 @@ static void clk_pll_out_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll_out->lock, flags);
 }
 
+static int tegra_clk_pll_out_save_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll_out *pll_out = to_clk_pll_out(hw);
+
+	if (!strcmp(__clk_get_name(hw->clk), "pll_re_out1"))
+		pll_out->pllout_ctx = readl_relaxed(pll_out->reg);
+	else
+		pll_out->pllout_ctx = clk_hw_get_rate(hw);
+
+	return 0;
+}
+
+static void tegra_clk_pll_out_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll_out *pll_out = to_clk_pll_out(hw);
+
+	if (!strcmp(__clk_get_name(hw->clk), "pll_re_out1")) {
+		writel_relaxed(pll_out->pllout_ctx, pll_out->reg);
+	} else {
+		if (!__clk_get_enable_count(hw->clk))
+			clk_pll_out_disable(hw);
+		else
+			clk_pll_out_enable(hw);
+	}
+}
+
 const struct clk_ops tegra_clk_pll_out_ops = {
 	.is_enabled = clk_pll_out_is_enabled,
 	.enable = clk_pll_out_enable,
 	.disable = clk_pll_out_disable,
+	.save_context = tegra_clk_pll_out_save_context,
+	.restore_context = tegra_clk_pll_out_restore_context,
 };
 
 struct clk *tegra_clk_register_pll_out(const char *name,
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 83623f5f55f3..b47f373c35ad 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -439,6 +439,8 @@ struct clk *tegra_clk_register_pllu_tegra210(const char *name,
  * @rst_bit_idx:	bit to reset PLL divider
  * @lock:		register lock
  * @flags:		hardware-specific flags
+ * @pllout_ctx:		pllout context to save and restore during suspend
+ *			and resume
  */
 struct tegra_clk_pll_out {
 	struct clk_hw	hw;
@@ -447,6 +449,7 @@ struct tegra_clk_pll_out {
 	u8		rst_bit_idx;
 	spinlock_t	*lock;
 	u8		flags;
+	unsigned int	pllout_ctx;
 };
 
 #define to_clk_pll_out(_hw) container_of(_hw, struct tegra_clk_pll_out, hw)
-- 
2.7.4

