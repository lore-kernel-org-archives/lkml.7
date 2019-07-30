Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F383C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7622B2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaOdoMuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfG3Q6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52841 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfG3Q6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so57824557wms.2;
        Tue, 30 Jul 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=gaOdoMuOJcuk4YlHcKJ+CXgHCK8nzLnuZHNma04tNZ3dRlt+py+fB3CPsfjiZJ3KSx
         UCsCNKDMhFducbHbDGVW5ms5kZTnnBZ/VPVzESJMwHGFCYR0q/XBVzp6peYSXWwXe93G
         rriCYoZconuOGyTWsgvkqpMlCJds5WCpe8L0VhItO6BJZCj45YAttaB1E7diEpfvro6B
         ywA/VhSIiPwQYB7M5ag4aLEEhdXrQ8SEctV44yX0SCGwdQPhbx2wBDbaTzWM6jEq6O03
         WYrf+pn8HLoYgbz1bD5U8u8DHH95HPIaWj9htwmubyfOAn80qhljdXxyLThh0cWzox9X
         9lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=LK0cYdw7edK4rSHMrxYk8n7Sg4i6Zr6i+O0rbgBd2Tjw/4XSdexZC+0dfyI8FWYiuh
         bPLFPTxSVxtey0I5p+1aEOTb121ccBFC5YtClLfHLrJE4TLadoyMfwZjgrZ+rB+YYTtC
         7W/1MA0Rz7/B6nBz6s7sH27btyhs2zF3+der+WeoWwq9C+gez119xjRAiivct08D5Sis
         wCJnavlX+SS+7dLYOvTumM7qLs6rYr/xWVapStZKDLL06tbZunp7AanXfKbjYzSnwo49
         17cQKNeBN2eqp7HYtNaYwT+H4kOGoRrKk1B8OqHJ8K8Pqna1Os9hjyGA9nqRsyX2S5nD
         8Y3g==
X-Gm-Message-State: APjAAAVdq9z7ERzdLcgWUaTBdX7t+M5RMOSYC1P0eB4/7PxCzGdNWcl6
        V4Ax9fe4O52bDbseRc1twIY=
X-Google-Smtp-Source: APXvYqzd4HLIXrliMrPBIjMLd0ov7QAEyx399Ia6eRH8ACdOUuN3ILGPUwzuUrJbRM6o0qw3f1Zrug==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr103929592wmj.167.1564505895091;
        Tue, 30 Jul 2019 09:58:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:14 -0700 (PDT)
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
Subject: [PATCH v9 05/15] memory: tegra20-emc: Pre-configure debug register
Date:   Tue, 30 Jul 2019 19:56:08 +0300
Message-Id: <20190730165618.10122-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
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

