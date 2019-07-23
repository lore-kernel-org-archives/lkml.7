Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06AFC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C278E2239D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK8+hOmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfGWDPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:15:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41336 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfGWDOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id 62so23337946lfa.8;
        Mon, 22 Jul 2019 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=IK8+hOmrekUVNwu6q2xfJu1ibr0cCWiBD7aS+Adx2uSE86z9FjhECnm2NJjTz8UPeZ
         w5eybo8X87grbnd9KvCMDynBFTOSm3EPs3QAsnIu3vFa6PUgVhElQF1CVtvQDtC1kknc
         GNRArRMrkgjYDwT8rcItCxqDQoeahpnSO4um/MM2DK8dBPLPzO3KGsiLZvz9SMcG+OIx
         pgX/Rq4oHLjfd2tLmBjDjh6J/YOCLdo2X9qw2/8iJa7ZEyUNS/QyQ3YXolajxLbqJbRh
         h+tYFun7uq4rrImFfzdAFKAUffnfGNT20+EYXYwuvUKvm02RtMaMkDWSTdGVmK96ghxG
         i5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=n683YDB1Q+MGM8AwdIzH+0gD1xMhrhg4ySi4TeXmdQpMuaC8ri/IgNgmFtVSsyRWmJ
         7qvEwMkNbQ4iAgzMYuhmOW982CROhOuDefTMBuzaofHJT78glOZUYbQ2C/qabOxuYoh7
         Gon902DEifEJVaAAuuogXlHn6N9O1dD8Yn47/IW4gd3TYlpFn1UP5cdzxLNABKm/9aeS
         RP0l1NPgcOfDlzH+Bz+P+1O81qXP3miE/B+TupNee8bM0hzc76JXa2IEUkvXoeS3aZnv
         jseJHjcjqygvYCI4CjBobkNaVQGu5Qz1Oe/JoAOSBAOdVernI70b+7xAUYCoC/JrFcvu
         p6dQ==
X-Gm-Message-State: APjAAAVx3N/e5J735pgP9qm499TJNEi3p66oVfFR9bUmQp+mVyAX4LOn
        LXEMXin7xJo86hlo9KSQvdM=
X-Google-Smtp-Source: APXvYqyO3A1AhNxHDUIvGCUtGbUjiO/Rekb6rV16FkcnGV+oJckWRc53c85NHiy/Z8VoSQwAGyZMKg==
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr32728583lfy.191.1563851652013;
        Mon, 22 Jul 2019 20:14:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/15] memory: tegra20-emc: Pre-configure debug register
Date:   Tue, 23 Jul 2019 06:12:37 +0300
Message-Id: <20190723031247.31932-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver expects certain debug features to be disabled in order to
work properly. Let's disable them explicitly for consistency and to not
rely on a boot state.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 1ce351dd5461..85c24f285fd4 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -22,6 +22,7 @@
 
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
+#define EMC_DBG					0x008
 #define EMC_TIMING_CONTROL			0x028
 #define EMC_RC					0x02c
 #define EMC_RFC					0x030
@@ -80,6 +81,12 @@
 #define EMC_REFRESH_OVERFLOW_INT		BIT(3)
 #define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
 
+#define EMC_DBG_READ_MUX_ASSEMBLY		BIT(0)
+#define EMC_DBG_WRITE_MUX_ACTIVE		BIT(1)
+#define EMC_DBG_FORCE_UPDATE			BIT(2)
+#define EMC_DBG_READ_DQM_CTRL			BIT(9)
+#define EMC_DBG_CFG_PRIORITY			BIT(24)
+
 static const u16 emc_timing_registers[] = {
 	EMC_RC,
 	EMC_RFC,
@@ -396,7 +403,7 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 static int emc_setup_hw(struct tegra_emc *emc)
 {
 	u32 intmask = EMC_REFRESH_OVERFLOW_INT | EMC_CLKCHANGE_COMPLETE_INT;
-	u32 emc_cfg;
+	u32 emc_cfg, emc_dbg;
 
 	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
 
@@ -419,6 +426,14 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	writel_relaxed(intmask, emc->regs + EMC_INTMASK);
 	writel_relaxed(intmask, emc->regs + EMC_INTSTATUS);
 
+	/* ensure that unwanted debug features are disabled */
+	emc_dbg = readl_relaxed(emc->regs + EMC_DBG);
+	emc_dbg |= EMC_DBG_CFG_PRIORITY;
+	emc_dbg &= ~EMC_DBG_READ_MUX_ASSEMBLY;
+	emc_dbg &= ~EMC_DBG_WRITE_MUX_ACTIVE;
+	emc_dbg &= ~EMC_DBG_FORCE_UPDATE;
+	writel_relaxed(emc_dbg, emc->regs + EMC_DBG);
+
 	return 0;
 }
 
-- 
2.22.0

