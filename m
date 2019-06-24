Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B759C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056920674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBL9gRLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfFXCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:32:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40297 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFXCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:32:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so10975010ljh.7;
        Sun, 23 Jun 2019 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=aBL9gRLMpp20COBMpVkyWL1ghkQ8Wna+0tl7DvEJ7s1yUhb+nKp5ow18cvtUin9Ul8
         DtsVaJoA8DfJNO5BiD9MYfJWzyAQ07kQ82mrX/ua1CGj/0A1au9GfSVe9XHPgJdfBI97
         MClTfMI1igPjDk/lnge7Cfp78dsJaKuMKxu0IrzhU7iyFsZgjun9sHNfiOkQTrJFsXiy
         0HjljPAo+VqMsOx5TLhT90s2x1QidtdaOvJOk0j68v9MVDXcBGT543ylXam/cNz1xCWB
         SXefVlE39nO8fxfwdPGNRJPpwLIe74w9xspyhqbkPSOA9hTTBXMQ5Y7C69znObdyFN5D
         SKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=izhc8C9weZvSUWSBb8VtzqzfKfr7xiNa4ThfRbbb2ZJcil5LPSOjzUzou2D2j4eOPN
         U8lYwKovwRQTROsexdyafYmw+kGd25nWRxDpOkK2BYA7PXRbru0h55sCQcYVubUrcg5r
         mwmBjkc7t0PcymI1AHPfWzeHX81o8ZVxmu7ZIwhTcR01gxNGFdsKN3paY907nzFLgWbq
         KQcK0DWbbvQJPPdB5jbhqx1F/GqqDXkZVNTkvnR+J5BmmO1tnb6rHQqcxI0DHJO+ZDQV
         1FiwRGAFinW0VjKO5WGa1M8zqdHqlhXgYbBCWaDz5nMz8phd/5vkHS/MR3q/hyYk6JFW
         b5Nw==
X-Gm-Message-State: APjAAAXvAzNwUByJ42I2MYeirKwDIihMV7lrZ0kuGfx4kCLGPsLvDTBS
        h4CePa6sne4R1xXwWb0kUDl9/PEC
X-Google-Smtp-Source: APXvYqxQ8lh8IBd1UNDne1IXWkkW5t2Lygtesm40izptBGsxv6zT6NMNazkyZmy9R6eDsB2g83AFqw==
X-Received: by 2002:a2e:124b:: with SMTP id t72mr71386260lje.143.1561336321676;
        Sun, 23 Jun 2019 17:32:01 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id y5sm1495146ljj.5.2019.06.23.17.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:32:01 -0700 (PDT)
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
Subject: [PATCH v5 05/10] memory: tegra20-emc: Pre-configure debug register
Date:   Mon, 24 Jun 2019 03:31:27 +0300
Message-Id: <20190624003132.29473-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624003132.29473-1-digetx@gmail.com>
References: <20190624003132.29473-1-digetx@gmail.com>
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

