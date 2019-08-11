Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E5C32756
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD882085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkw0CyEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHKVBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34955 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHKVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so72914754lfa.2;
        Sun, 11 Aug 2019 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=Mkw0CyELwaroNUoMpow8cyteNQq02ij+IRL0R2Go/VZ1pI8G+ZoKtcNQHJoWMGt4Xt
         N3Q+cp80NsaYAhJEiv7tEp+rNO54t49PH3tAdRX0dimJ/9uDaEf7hR+GagTDv0zKRmVm
         o98iUI/ARpCob3fvJKUeCzHxIkQqAyu8cImxD2NaoBU3sYTvLzy31KyphD8dn3mK4AHW
         Bw5jaNWASImamsLoWnt4LiWcZ6L8K5OtU5B889hDQFIEhBQo/H9yZ4Wdqxa1+ixV8OX2
         vL1ymdJ5tJ9S1JeAxXcCDBjlFOvJVqnTSOaODfDFLnT7326yrxoWJglONHRoIOQMDwXN
         Atig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=BeoukXQ2RGen7x9JZmtjlvlAnOSHa7IUg/ocqPCb7J60aheqA7N5qJfjvHFhRA0EJ/
         3CGncvfD8JaS6dwxeKVc3wSTDTOEhOHE+p7y6ibevygR0EV0TQEZFk7ttrZf5zIOCqh+
         yz3fyaKRF7M5Vb0GUu0VU9mTETp+DpQt90rzF4rw9y4PhhlWAUpmF+95co11LGs+IFGk
         cgJpG+dZ35KhjkiNybIy6Eumro/rKimmfGLOFn8MZVLQyzKuDW9lRvZ/usncfXJOvbUZ
         fQjEOy4KKqf7r6DFuoBI04bDCafXMivTZff/71FspqJ5d7tgznVMmsTJprGj2HwKGNh2
         Vyvw==
X-Gm-Message-State: APjAAAUNC+418rFby0GyfrUtpD5zMDd4kl9FEy4epD00CsHR/prcoXGn
        OSJ8p0aaAES3rjicO1v5JYs=
X-Google-Smtp-Source: APXvYqx+jADpqc2LDeW1SV0+R8sGtJ/i+vyNAH+cfmwtWe2knjPhZG+Q1IuP3KBIIP0cDjTuM5s6Gg==
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr19257481lfp.35.1565557291722;
        Sun, 11 Aug 2019 14:01:31 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:31 -0700 (PDT)
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
Subject: [PATCH v10 05/15] memory: tegra20-emc: Pre-configure debug register
Date:   Mon, 12 Aug 2019 00:00:33 +0300
Message-Id: <20190811210043.20122-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
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

