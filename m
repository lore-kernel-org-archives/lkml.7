Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85363C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443C722C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k4OX4HGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfGYQnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:43:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390869AbfGYQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:43:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so26415978wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BuoDlpPb1vre+s0M4n7UQuzVeVmwTbnqlEv8lDT4UWI=;
        b=k4OX4HGImt6xJlUN6U2THTvrSVKuSh9FSo+O95Rlh5GKBhaTqsoufUxODGokpDbNy7
         p/DH7+UZgOrr37x9eVV7qAgknaolCqsA0K4TxkHGApyhLMUkTdZm4pELHy+R3Tf6tLFO
         hppZsemHCX2UyAHXLQpmSfWlPsmZrFkFj+PukmvDNdXkEYWyMjV2eGyI4BtfBE3FDcjI
         rARknSq9seZ53bOmA3HD7tQQNkYniZTYGAs1yjDm4jhbxOpplAxW6KpdG/ly9y6E/K1/
         cffygjbxWExgDOYzK2WScKYqVUhNb+8rlIjR58rqQvwidazqKDQLz/sjLdjqSPkJAOpP
         V6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BuoDlpPb1vre+s0M4n7UQuzVeVmwTbnqlEv8lDT4UWI=;
        b=KJk+ZZXVXUjcFYngGFSDIN+Cc08EcL9FkpQKCsrb1CsGWq/p87Ndu+kT+lljaMs0D/
         2RlNRmsLHtNbWVYHChDbgl7EjVaoplqlHYrBIUfS7pe+8H3a5I8VvJPPjShDzJvqCiAW
         v8EjUwhzXwnocVPAUq0cj1CZIllDrYx1UZWZ83r6wjS0srmw5BN53Vx4tXQ+AwXTDGRt
         R6i92fKoYsSX8JCnAA+KsJEB9ag+a9IfBt+iV/oaeR4jGxWiK/YvlGCT7/aEqROZGQFR
         ZMRLljbrUVN1KPgagVHRCVUHD1gflwTSbtB0Q8593bKDwimY6RCjOxuCU4ydR8LI0yJD
         J3oQ==
X-Gm-Message-State: APjAAAVyivaVwjBrwv6M608S4BlHe/PgIZXVRWoirr2l6ASt8DWDJwTV
        FsQ/0FYeHmSGxLE4F3p4GoacFQ==
X-Google-Smtp-Source: APXvYqyqEGwWoPn3HegjruZUySUlT+U/WLjOjEXs2C6Mm+iF/93A1j0eOnV5Nv0nkLc8sV6thc7lsQ==
X-Received: by 2002:a5d:564e:: with SMTP id j14mr93443861wrw.1.1564072987152;
        Thu, 25 Jul 2019 09:43:07 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id 91sm103031727wrp.3.2019.07.25.09.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:43:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 8/8] clk: meson: remove clk input helper
Date:   Thu, 25 Jul 2019 18:42:38 +0200
Message-Id: <20190725164238.27991-9-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164238.27991-1-amergnat@baylibre.com>
References: <20190725164238.27991-1-amergnat@baylibre.com>
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

