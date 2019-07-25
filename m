Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159FDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43592238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Is62LuGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390900AbfGYQnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:43:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390853AbfGYQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:43:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so41227870wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMLWTpRyQOIhO2zBKiwG8296jQFE+BtYZV6zzvxEPl0=;
        b=Is62LuGc0BmnvvmbpBU+xVb6noxFfGphUlBMiZveEOXCmAKXoPdXIPTSEssvRQ34s1
         QzU5bh9h8J55jfMBytlBPFy6Iqc6MwejQtZ+qDEsWEVgrhjwyruTWyYleHwZ4anoiAPq
         KzhnbK4frlZITLBbh5jK7NjEi8keSvszPpxuSh6l82rNgg3nDQqDFaJGWdADwEOIGM4Y
         rV4zRxC6aokyakx2qnP2Cii0goc72HfCbc8CDJRLwFRIplm0FypPvRidpk/HZw/w32wP
         HECv44Cs94gzVylVj3/0vTt7HgUnAyh4mkYHAdIdiVoerE3cCj+JP7jFNp52DVD0oyWU
         6t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mMLWTpRyQOIhO2zBKiwG8296jQFE+BtYZV6zzvxEPl0=;
        b=DHTlh/5ubt41Blu1EO8LDo/hLfKj/vBO29Rdf1hU4qx/R2Ikya44+F3fzQQaRzl5H1
         21AQdkOeD1Y2j6jvE1lhm2VkCKgNkccV9i1+wUMe+GNBz1zsCPDJeNcDJMULczlTIEL6
         eWhXynm0MuASwHIjZav5ZOUBisd1XkPAW0AYMlkw+SwSifFx5w+lcmPJT9h3Hb9J44VO
         n6890QvG1emT5nQiwOUcJ+QNErOwK1Yhc88j+XECO1eEJ+u2Y2ZYyPzNOHQNspT3BcbJ
         oDogMFn7DklC3G+5LRQ262sow1nAADzTFna+nF9XiMQgQiUI0WthPbFgep853Bkac45Z
         rFmg==
X-Gm-Message-State: APjAAAXcuj7AwY4o2lkGnkC5SINn6dEMxHu+uN4rLk60rxlflFE6almk
        4EQMb0e7wvl1+HSVxBCivu75Vw==
X-Google-Smtp-Source: APXvYqy/hW7JIa1298EywLJf5h0MYenaQL09q4MVqbon6wyDqqejH9zoPdH9EExeziayAgzU00wSDw==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr82333298wmf.111.1564072985966;
        Thu, 25 Jul 2019 09:43:05 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id 91sm103031727wrp.3.2019.07.25.09.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:43:05 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 7/8] clk: meson: remove ee input bypass clocks
Date:   Thu, 25 Jul 2019 18:42:37 +0200
Message-Id: <20190725164238.27991-8-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164238.27991-1-amergnat@baylibre.com>
References: <20190725164238.27991-1-amergnat@baylibre.com>
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

