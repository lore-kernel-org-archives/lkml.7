Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB65C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA722147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0wgYoQfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfEMMbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:31:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfEMMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:31:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so5408337wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKq0Xmw2ntAqrTVNaEz/XqYkib9vFynLezQDvMrUHDU=;
        b=0wgYoQfY9TIqdwNaY/BkNPlr0XnHO48h33h8xoTL79c51HyaaofletIxDBjvzreQht
         3HV9XeCUyMiQecWaAhnQ1239LeF8VIripVqhuFv2YBfC+L2KqP9AhRShrK/lswUtOiLg
         Y6Q9q5dfecPp9pJ2S7G/R9HBvejDxkZbOS8tPxTz3Rl1C21VYE1grO2WUew9BXfQF7mw
         ZQ8m91LMV8OdEQHmYFjmRZM0BlKZMS9rlwi00GfoeuZ9Kn+0k6OfQn7E5XSYLI6blUdU
         A42s1ISqhSRquPF7VtEhghQr7PT1hMZcqYaY9nIl3QheEk74eXZezq1xuhTKzsXCK7cd
         3wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKq0Xmw2ntAqrTVNaEz/XqYkib9vFynLezQDvMrUHDU=;
        b=thjjTHKpg7KO78aLo0gtcd/rF+yJl2S1Wb4oaNMmtBDgqlOiD+3hO9njCK7fZB5g5B
         WQfizbLdSOFi1vfZ9UDy8HpRfxCJ4wcj83CIYNSgUg44WaAFqVtpQ4GmgAuEr1R01mCk
         cP4vMHXMQd3Jf8VN9TSKqFAVN5XDL85gAzFRwSbrY6CUBIUNELSXiK0cbO6aaK1FWAye
         Pu6396krh0rwVu/AFwBfAAkUKUP0pNTnUJiQ7yyUCzHObxCW1lUY8hpX6OKejyqSmWzz
         oqP6ruSb02/Wo4KtKnzBHtA8Ob+b6SKoHPecQnUWBiHw2LXvFvXvrHX+4pdG/FFM5uig
         MKWw==
X-Gm-Message-State: APjAAAW86wAithCDnKG21ULdkl67oeUE9+09XevMw1INUdFK0vguZLYO
        MobVFCJSn5vk+EeHXVPdrZvfgA==
X-Google-Smtp-Source: APXvYqwzHLI7fugsJXC/aNnzGQOW5Fw4/jeXRTXUrlzZLCuvKph6sDV0Eyyp1mvIS9eOYmglUQwIiA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr15049885wrw.146.1557750689502;
        Mon, 13 May 2019 05:31:29 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16175584wra.81.2019.05.13.05.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:31:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] clk: meson: eeclk: add init regs
Date:   Mon, 13 May 2019 14:31:14 +0200
Message-Id: <20190513123115.18145-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the PLL and MPLL, the controller may require some magic setting to
be applied on startup.

This is needed when the initial setting is not applied by the boot ROM.
The controller need to do it when the setting applies to several clock,
like all the MPLLs in the case of g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-eeclk.c | 3 +++
 drivers/clk/meson/meson-eeclk.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 37a34c9c3885..6ba2094be257 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -34,6 +34,9 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
+	if (data->init_count)
+		regmap_multi_reg_write(map, data->init_regs, data->init_count);
+
 	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
 	if (IS_ERR(input)) {
 		ret = PTR_ERR(input);
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
index 1b809b1419fe..9ab5d6fa7ccb 100644
--- a/drivers/clk/meson/meson-eeclk.h
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -17,6 +17,8 @@ struct platform_device;
 struct meson_eeclkc_data {
 	struct clk_regmap *const	*regmap_clks;
 	unsigned int			regmap_clk_num;
+	const struct reg_sequence	*init_regs;
+	unsigned int			init_count;
 	struct clk_hw_onecell_data	*hw_onecell_data;
 };
 
-- 
2.20.1

