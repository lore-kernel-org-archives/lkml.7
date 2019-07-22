Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C711C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776ED2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tKsjU5by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfGVJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:54:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfGVJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:54:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so13644846wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BuoDlpPb1vre+s0M4n7UQuzVeVmwTbnqlEv8lDT4UWI=;
        b=tKsjU5byCoZ5Sa+GP1Va7H9RQlqX/jqqS/q2WCk4JH/Cah1N2dHDB/kGpm4ruyddOv
         /u6dzzGOGiOZalKUIfiBGWJUx7fUruazlVJJetd3nBhKlMbSRS8pTCHrIUr8UmzYdpP9
         XchSEBbNVnFJV2uy46sIazeoKX6j+daD4DPGyMhHqCzgMJ0kaNJjuWOA8P+b0ImnJaEA
         XL2DbM2wuoAgFUEifMONziWGqE4jYLjCaYk0F0Ahnx7dI4tA8inuRs89OExzu4ctRTE3
         T3YGEoD/5/4oK1aMSx5dgwPWDdqPq1uhypMS1P/TgB2uPoVHV7opKMN4LUdF1z9ZuD4A
         15qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BuoDlpPb1vre+s0M4n7UQuzVeVmwTbnqlEv8lDT4UWI=;
        b=jgQ2MLnouXcr/AF3+jBE6DqK9COclJCxI65/QVAAZ2SmYTc3ky3NJXQJZlU8IOcCqX
         gRfwae24HLEtgVPKop8MtfboGcstf3tWf4fo8sjOfOV1gkKbdPtQGHAFHN/jKyfs3MBq
         bm9mXKiGhc4vbQoFlfbvb5EGCFMBKZ4HF0hM+ETsAHYIh5+5DXw5CZO8V40iLC63VrDx
         m4GQIveceDUplg561a5/zipd+JZ7kTopQJ3rEortyRoyrbg2r0L+XNbEjpiWP3LVFFt7
         hUHznghDqZvvJgyBwxZQf9Vck7q7QU5Mrus9iygYhtxlf1NdUzuWV1ylOLoAtJ9R1Jlq
         3zGQ==
X-Gm-Message-State: APjAAAXQJZRhezHyFx42DIeUFdhp1oNaicL7Xp4H8iUnFRhicPgW8Ffy
        BP1p1u97pnysI5BdpKRkgYvTNg==
X-Google-Smtp-Source: APXvYqzEI8Yc89xIk5KnT0N0hiwsBpvaUVjuHPZEKB+qhbA7krIHnkZEIerewidwdBrfvIOKyMR26g==
X-Received: by 2002:adf:9486:: with SMTP id 6mr42268769wrr.242.1563789276066;
        Mon, 22 Jul 2019 02:54:36 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 91sm83158469wrp.3.2019.07.22.02.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:54:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 8/8] clk: meson: remove clk input helper
Date:   Mon, 22 Jul 2019 11:54:25 +0200
Message-Id: <20190722095425.14193-9-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095425.14193-1-amergnat@baylibre.com>
References: <20190722095425.14193-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk input function which allows clock controllers to register a bypass
clock from a clock producer is no longer needed anymore since meson clock
controllers have migrated to a new parent allocation method.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/Kconfig     |  3 ---
 drivers/clk/meson/Makefile    |  1 -
 drivers/clk/meson/clk-input.c | 49 -----------------------------------
 drivers/clk/meson/clk-input.h | 19 --------------
 4 files changed, 72 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-input.c
 delete mode 100644 drivers/clk/meson/clk-input.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 72a37572501f..500be0b0d473 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config COMMON_CLK_MESON_INPUT
-	tristate
-
 config COMMON_CLK_MESON_REGMAP
 	tristate
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index bc35a4efd6b7..f09d83dc3d60 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,7 +4,6 @@
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_EE_CLKC) += meson-eeclk.o
-obj-$(CONFIG_COMMON_CLK_MESON_INPUT) += clk-input.o
 obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
 obj-$(CONFIG_COMMON_CLK_MESON_PHASE) += clk-phase.o
 obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
diff --git a/drivers/clk/meson/clk-input.c b/drivers/clk/meson/clk-input.c
deleted file mode 100644
index 086226e9dba6..000000000000
--- a/drivers/clk/meson/clk-input.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (c) 2018 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include "clk-input.h"
-
-static const struct clk_ops meson_clk_no_ops = {};
-
-struct clk_hw *meson_clk_hw_register_input(struct device *dev,
-					   const char *of_name,
-					   const char *clk_name,
-					   unsigned long flags)
-{
-	struct clk *parent_clk = devm_clk_get(dev, of_name);
-	struct clk_init_data init;
-	const char *parent_name;
-	struct clk_hw *hw;
-	int ret;
-
-	if (IS_ERR(parent_clk))
-		return (struct clk_hw *)parent_clk;
-
-	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return ERR_PTR(-ENOMEM);
-
-	parent_name = __clk_get_name(parent_clk);
-	init.name = clk_name;
-	init.ops = &meson_clk_no_ops;
-	init.flags = flags;
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
-	hw->init = &init;
-
-	ret = devm_clk_hw_register(dev, hw);
-
-	return ret ? ERR_PTR(ret) : hw;
-}
-EXPORT_SYMBOL_GPL(meson_clk_hw_register_input);
-
-MODULE_DESCRIPTION("Amlogic clock input helper");
-MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-input.h b/drivers/clk/meson/clk-input.h
deleted file mode 100644
index 4a541b9685a6..000000000000
--- a/drivers/clk/meson/clk-input.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __MESON_CLK_INPUT_H
-#define __MESON_CLK_INPUT_H
-
-#include <linux/clk-provider.h>
-
-struct device;
-
-struct clk_hw *meson_clk_hw_register_input(struct device *dev,
-					   const char *of_name,
-					   const char *clk_name,
-					   unsigned long flags);
-
-#endif /* __MESON_CLK_INPUT_H */
-- 
2.17.1

