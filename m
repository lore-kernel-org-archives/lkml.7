Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A03C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582120700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384969;
	bh=w5w50r3vpJG9CJUPiNhcuqcLYA7qlpR6IwB/g4wCeDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUfJKEdyXvLfJTz20/7uSXjlpnhr5B43EVHfNUYUOXz9taV3BPM9jFOdzD7UZFgLC
	 AP6cTB+NlV8fe9ceOMHbexATQeFJffefXcEaDtaAA6O7pjdMDbz2CZ1MrwHD/g+dhy
	 Nu5njfY4oSgcQQG1v7W3pAh4VnoH0NqjnA3+E0z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfJFSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfJFRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:25:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16F52080F;
        Sun,  6 Oct 2019 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382730;
        bh=w5w50r3vpJG9CJUPiNhcuqcLYA7qlpR6IwB/g4wCeDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCV5TC6tHF6TaGWmmXgqjMnFrjhc9QpbEgm3TmFAMrwqySpvR46swcJW1XQSY5WIk
         MtestDpD8Z3RsIqiklW/I9I8V9KGdzynjiQ7SixiPZkpDm6NnUh8ypWIuRbGDgRy9d
         8CZ1fWfvkv4YNVU3+ucVpPNITalny95zKtHsn6bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/68] pinctrl: tegra: Fix write barrier placement in pmx_writel
Date:   Sun,  6 Oct 2019 19:20:55 +0200
Message-Id: <20191006171117.069060684@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit c2cf351eba2ff6002ce8eb178452219d2521e38e ]

pmx_writel uses writel which inserts write barrier before the
register write.

This patch has fix to replace writel with writel_relaxed followed
by a readback and memory barrier to ensure write operation is
completed for successful pinctrl change.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Link: https://lore.kernel.org/r/1565984527-5272-2-git-send-email-skomatineni@nvidia.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 51716819129d2..e5c9b9c684289 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -51,7 +51,9 @@ static inline u32 pmx_readl(struct tegra_pmx *pmx, u32 bank, u32 reg)
 
 static inline void pmx_writel(struct tegra_pmx *pmx, u32 val, u32 bank, u32 reg)
 {
-	writel(val, pmx->regs[bank] + reg);
+	writel_relaxed(val, pmx->regs[bank] + reg);
+	/* make sure pinmux register write completed */
+	pmx_readl(pmx, bank, reg);
 }
 
 static int tegra_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
-- 
2.20.1



