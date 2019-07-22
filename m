Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015AC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E00D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="htZvDSRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfGVJvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:51:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40014 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfGVJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:51:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so34657960wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+f39f/vO7ZpFkzWKsXEJhzhzg/ZN6DlIsY5Iay+VBRo=;
        b=htZvDSRmT6jMXiu+Kg9emxAFoSbpATwOwuK0cNLzVzaiGKLnsnOA2XmQ2RVHdUCUp5
         FdkcTS94h30us1MuHruEE+k/Id0U24bnRRRv58Q8nUy13EA8hTGTQK5E1xzz7YzZN4F3
         ieG/UO+1w3yzdvC2LVnQYulswKw3JEY8e4r8KZ96CHKTPL0yeYG1/hssSbiFPcug93iA
         JekJkwn/2ESSPsvCwKi5qdXqDkFKV+ps3uvjwo6gJrUIRezBoqAYxcZDqoGlIiQHqtbh
         b71qyRpzA5z/tY8lgHFXK5sAOXi2iv4Xhz96QUjaW6nMuOZVK6tymStWgS8qwYW/7fQS
         o5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+f39f/vO7ZpFkzWKsXEJhzhzg/ZN6DlIsY5Iay+VBRo=;
        b=D4k7ihJIw754YtOuc1oVzcRcvi3JITQnJy5nvKnlA9mbyT50F1ZsP4o/L/brqRuRae
         sRHIovbTd8aBBoczJ1gpC7/AGkN5IigpYeh2F2DzvQDEeSYAtfKH7u40riTY6MII5wub
         4ywP0vhnY/v79lywuayhExvFUpPAE2hcj00Ekwk97gd4rkkWY6nTtnkhpZyyfYR6bXZD
         gsrzAZppEVF00b8BO20gV8IyA32TzjevP5B3NKuY9idp181pjYTQUW4AoI9HOpnqHztB
         hRrpJCrsv/sZxHZxrE0g8C80G00D9ab/iaxDMYpxR4Sn4rb6TjL4WwVSckICGnPBIFQM
         kFQA==
X-Gm-Message-State: APjAAAVPw8EhKMkOnxbQGzhfPIVVEpQi3snMR92I03m26Fqt3ASGwAuz
        ZoMe2QiVfSVLiqQVzaWY66+wXw==
X-Google-Smtp-Source: APXvYqwwj/UlXQVUKhMKbdQjX82TUkiVIMSZYM6b25puvxqYcGVmxB0FMrhP37zUSRCkIXwb7Mp1+w==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr60072852wmh.132.1563789064707;
        Mon, 22 Jul 2019 02:51:04 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o3sm31050738wrs.59.2019.07.22.02.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:51:04 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 4/4] clk: meson: remove ao input bypass clocks
Date:   Mon, 22 Jul 2019 11:50:53 +0200
Message-Id: <20190722095053.14104-5-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095053.14104-1-amergnat@baylibre.com>
References: <20190722095053.14104-1-amergnat@baylibre.com>
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

