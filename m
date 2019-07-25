Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A36C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67D422C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IHCyozkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbfGYQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:41:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52641 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390122AbfGYQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so45583525wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+f39f/vO7ZpFkzWKsXEJhzhzg/ZN6DlIsY5Iay+VBRo=;
        b=IHCyozkde+ytJLKhfQMkszxOmHnGneR2mvRfOV6tDxq4ijNpl9VuEkwgdp0Zjk6/8F
         U15HoKeaPblJHeJ4JLTUtlWG3qZRyJrZe4LrFE9t95EA81B0m9VDRIxnIjttJsH1wh38
         yqdF8FT4Fzj4LszxG5XiQ83RejOR0HLWgIthwdNmod6oT6VyJ+w9wwS2qUCNtufRJXue
         Rx82NEhvzoRnPPaY5Wb3znOhz6Y/DMXCyV3CZmrVbfZ5i7T2IOm1IOBdhMR0YawEdfwM
         zyNnufZilfWFW93T2lxTmn5kNwaFc5N2aauf/WDY7uubS8QrPHfcaCaoIEsi3N8KCD0P
         HQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+f39f/vO7ZpFkzWKsXEJhzhzg/ZN6DlIsY5Iay+VBRo=;
        b=k6Y/chCXb3O6nTbIvnfKax53DeYSm3A79Ncxx5jq9bFyJrE05i+vjrEyRGPqasdDCa
         fJNdVTtIy9bpbGv7Xp+yyerSv4zCobnX8jpbdgD4tF62YYRaxA7c8Csnkec38x4FeXF0
         EOiQ1UMUndXj30fM1aC3DfbgsaE2rfbSiwEhXezbaTilMZcaEPsQIwEozcxxx2pn/KT/
         Eo6iJVTyomk+38DizybVvn7holLUDHHChbOY+iIXaTiQZwXmZXsWgwxfF8+NMuVEkQcr
         I6cPkW5JdsVH6CD6YvJNC2Sy/ZGCBC6EzNNnnWW4V5cNf8Kl4N+gAOQyx5c79d4q1wDl
         oLyw==
X-Gm-Message-State: APjAAAU+W2TQG0OK/bJR5aj9cI6rHjgnRri3lyGRAddURAAQvdi/Dh/G
        mJakJb13Znwo321d5uUSSLPp/Q==
X-Google-Smtp-Source: APXvYqz/s0HiKXCfYYD11qWyMW5+Fd+3jNPmLiQI9zMZCekWeIA+GJsfHZXk0TGUc4QAlZy0QGeAjA==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr75775556wma.37.1564072908969;
        Thu, 25 Jul 2019 09:41:48 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id y16sm102488858wrg.85.2019.07.25.09.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:41:48 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 4/4] clk: meson: remove ao input bypass clocks
Date:   Thu, 25 Jul 2019 18:41:26 +0200
Message-Id: <20190725164126.27919-5-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164126.27919-1-amergnat@baylibre.com>
References: <20190725164126.27919-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, bypass clocks (i.e. ao-in-xtal) are made from device-tree
inputs to provide input clocks which can be access through global name.
The cons of this method are the duplicated clocks, means more string
comparison.

Specify parent directly with device-tree clock name.

Function to regiter bypass clocks is removed.

Input parameters from meson aoclk data structure are deprecated and then
deleted since all aoclk files are migrated.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/Kconfig       |  1 -
 drivers/clk/meson/meson-aoclk.c | 37 ---------------------------------
 drivers/clk/meson/meson-aoclk.h |  8 -------
 3 files changed, 46 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index ee0b84b6b329..178ee72ba4bc 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -33,7 +33,6 @@ config COMMON_CLK_MESON_VID_PLL_DIV
 config COMMON_CLK_MESON_AO_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
-	select COMMON_CLK_MESON_INPUT
 	select RESET_CONTROLLER
 
 config COMMON_CLK_MESON_EE_CLKC
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index b67951909e04..bf8bea675d24 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include "meson-aoclk.h"
 
-#include "clk-input.h"
-
 static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
@@ -33,37 +31,6 @@ static const struct reset_control_ops meson_aoclk_reset_ops = {
 	.reset = meson_aoclk_do_reset,
 };
 
-static int meson_aoclkc_register_inputs(struct device *dev,
-					struct meson_aoclk_data *data)
-{
-	struct clk_hw *hw;
-	char *str;
-	int i;
-
-	for (i = 0; i < data->num_inputs; i++) {
-		const struct meson_aoclk_input *in = &data->inputs[i];
-
-		str = kasprintf(GFP_KERNEL, "%s%s", data->input_prefix,
-				in->name);
-		if (!str)
-			return -ENOMEM;
-
-		hw = meson_clk_hw_register_input(dev, in->name, str, 0);
-		kfree(str);
-
-		if (IS_ERR(hw)) {
-			if (!in->required && PTR_ERR(hw) == -ENOENT)
-				continue;
-			else if (PTR_ERR(hw) != -EPROBE_DEFER)
-				dev_err(dev, "failed to register input %s\n",
-					in->name);
-			return PTR_ERR(hw);
-		}
-	}
-
-	return 0;
-}
-
 int meson_aoclkc_probe(struct platform_device *pdev)
 {
 	struct meson_aoclk_reset_controller *rstc;
@@ -86,10 +53,6 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
-	ret = meson_aoclkc_register_inputs(dev, data);
-	if (ret)
-		return ret;
-
 	/* Reset Controller */
 	rstc->data = data;
 	rstc->regmap = regmap;
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
index 999cde3868f7..605b43855a69 100644
--- a/drivers/clk/meson/meson-aoclk.h
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -18,20 +18,12 @@
 
 #include "clk-regmap.h"
 
-struct meson_aoclk_input {
-	const char *name;
-	bool required;
-};
-
 struct meson_aoclk_data {
 	const unsigned int			reset_reg;
 	const int				num_reset;
 	const unsigned int			*reset;
 	const int				num_clks;
 	struct clk_regmap			**clks;
-	const int				num_inputs;
-	const struct meson_aoclk_input		*inputs;
-	const char				*input_prefix;
 	const struct clk_hw_onecell_data	*hw_data;
 };
 
-- 
2.17.1

