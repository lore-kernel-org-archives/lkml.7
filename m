Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A1C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB062171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nO4imJUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfHPTmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:42:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13210 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfHPTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:42:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707210010>; Fri, 16 Aug 2019 12:42:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:22 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d57071c0000>; Fri, 16 Aug 2019 12:42:21 -0700
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
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v9 04/22] clk: tegra: pllout: Save and restore pllout context
Date:   Fri, 16 Aug 2019 12:41:49 -0700
Message-ID: <1565984527-5272-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984546; bh=G6UL0RiW0iYwiCgdSo9xSeLjLu0/Ysld5e3CD18vTzQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nO4imJUI3OYBjz61XlaY/TaQIiBRB2UyYjzRRVut2edcV1rJdvjOPVpXQuyUv3Ri/
         PmmP++JQrB1H+o7rcNsjHyw8srm6JDbNDj+3KQzu54bJ8zM8XNE3ESLvHXdW04dvNO
         M3S2ho0tTXnUZPZiL89O+o/kVDkKaUKnBxzNA+d6VQOh/qaMXQqm/9iVfIs9UyxHOg
         MAKlRg/ilT5lY55kNfGcM0ogIV+2mq5gPXlqOvDn+GE0Uq4hL0mwpruBvNqH/4+zW4
         ECRniX/4fXs9BIKh2rNEhhEN2wtXw34272zjyddq0CPbJGnha9zZ1EoSltvt5hVgPM
         URlZNmlPtnyEg==
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

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll-out.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
index 35f2bf00e1e6..d8bf89a81e6d 100644
--- a/drivers/clk/tegra/clk-pll-out.c
+++ b/drivers/clk/tegra/clk-pll-out.c
@@ -69,10 +69,19 @@ static void clk_pll_out_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll_out->lock, flags);
 }
 
+static void tegra_clk_pll_out_restore_context(struct clk_hw *hw)
+{
+	if (!__clk_get_enable_count(hw->clk))
+		clk_pll_out_disable(hw);
+	else
+		clk_pll_out_enable(hw);
+}
+
 const struct clk_ops tegra_clk_pll_out_ops = {
 	.is_enabled = clk_pll_out_is_enabled,
 	.enable = clk_pll_out_enable,
 	.disable = clk_pll_out_disable,
+	.restore_context = tegra_clk_pll_out_restore_context,
 };
 
 struct clk *tegra_clk_register_pll_out(const char *name,
-- 
2.7.4

