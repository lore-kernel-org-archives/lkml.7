Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E930DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C060521E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Old0UmrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfGVJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:54:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45851 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfGVJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:54:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so38677944wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMLWTpRyQOIhO2zBKiwG8296jQFE+BtYZV6zzvxEPl0=;
        b=Old0UmrEQpghjmdsyoDyvj4lfyDsHwZ/YHTJrSS71Rkp6llbPDMWpt6vUyKbPuLD/C
         Al3qUkgJ03TKuwBnLhuB4WEBymQJkvEQjc19V4WryIHJPTcnLoOWr+iynxfl3RPN84eM
         FkLZB3Pv/fGcwGHayM7YO59CZzZni//t8YowaFybhuIkmerAlbWaCULTdMK3532TAAeC
         K2TlU+g+6Tu673Ux91bWkOcZwGE64tRbXJt9cgW8p7TMwFa9I5jOEmW/Qq+5/rDqCVCR
         J58Mgwsq3V9DKWYMcRwPc1020hRhiH6r+0hoZ2tnwkiNcJRCEa9YdlDm/ZaVtLGmVxz6
         m28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMLWTpRyQOIhO2zBKiwG8296jQFE+BtYZV6zzvxEPl0=;
        b=buY8flFSlkWQjAiOT/wEVMaEmR7SqrQNylLOLLCDvFoXIkfE1/QmYXGSMmJhPJMBHJ
         UKhkWXxWWlmQpN9QTQ9lubc94shl7vbOWnuT2Bh4g4x+JXhY5p0EK/2+3aImBXOn7lgN
         DPEj4WGr/aZNF4rkl2VwBE6AAniSUquIkCghgcPmGXDQsmqALqF0KR5lscYeebiZZdf2
         KcongDf42YLMiJMElgxvNM9QBU114Aa+K9vntrx9nvgeVvjo2Km8JKrbBsDSZHCBxOQW
         q9ljQ7NFOzLBwFp/h/2Ym6uFOypw5KD325cRvWvTaSAUB7GdsMyeY7Yehi3mEnTDigm1
         rFiw==
X-Gm-Message-State: APjAAAWMYsFzBeaYnb94kxJChQzdfOcb+cyazV3cnRZTZras821WcXiX
        QOIbQMw1IqwvmZjroENjVwlgRQ==
X-Google-Smtp-Source: APXvYqzv5RI2+LQsoPPLCF7HYqwq+tI19+tyzHYBuoo7bAJ+ZihsVffuyiLWlbK83w2LDeFMa6Ndyg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr77160892wrm.235.1563789275176;
        Mon, 22 Jul 2019 02:54:35 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 91sm83158469wrp.3.2019.07.22.02.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:54:34 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 7/8] clk: meson: remove ee input bypass clocks
Date:   Mon, 22 Jul 2019 11:54:24 +0200
Message-Id: <20190722095425.14193-8-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095425.14193-1-amergnat@baylibre.com>
References: <20190722095425.14193-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, bypass clocks (i.e. ee-in-xtal) are made from device-tree
inputs to provide input clocks which can be access through global name.
The cons of this method are the duplicated clocks, means more string
comparison.

Specify parent directly with device-tree clock name.

Remove the bypass clock registration from the ee probe function.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/Kconfig       |  1 -
 drivers/clk/meson/meson-eeclk.c | 10 ----------
 drivers/clk/meson/meson-eeclk.h |  2 --
 3 files changed, 13 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 178ee72ba4bc..72a37572501f 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -38,7 +38,6 @@ config COMMON_CLK_MESON_AO_CLKC
 config COMMON_CLK_MESON_EE_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
-	select COMMON_CLK_MESON_INPUT
 
 config COMMON_CLK_MESON8B
 	bool
diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 6ba2094be257..a7cb1e7aedc4 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -10,7 +10,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-#include "clk-input.h"
 #include "clk-regmap.h"
 #include "meson-eeclk.h"
 
@@ -18,7 +17,6 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 {
 	const struct meson_eeclkc_data *data;
 	struct device *dev = &pdev->dev;
-	struct clk_hw *input;
 	struct regmap *map;
 	int ret, i;
 
@@ -37,14 +35,6 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 	if (data->init_count)
 		regmap_multi_reg_write(map, data->init_regs, data->init_count);
 
-	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
-	if (IS_ERR(input)) {
-		ret = PTR_ERR(input);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get input clock");
-		return ret;
-	}
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < data->regmap_clk_num; i++)
 		data->regmap_clks[i]->map = map;
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
index 9ab5d6fa7ccb..77316207bde1 100644
--- a/drivers/clk/meson/meson-eeclk.h
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -10,8 +10,6 @@
 #include <linux/clk-provider.h>
 #include "clk-regmap.h"
 
-#define IN_PREFIX "ee-in-"
-
 struct platform_device;
 
 struct meson_eeclkc_data {
-- 
2.17.1

