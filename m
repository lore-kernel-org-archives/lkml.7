Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9712C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B2820684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gdtYuN9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:15:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43902 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCGOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:15:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so17597801wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xv40rDikhpGj1gO+S5PFI70OqXKcih9FYV8He3Os+U=;
        b=gdtYuN9ZjvzhNAHkBVQiTohpzwLRLXb3p4HybLzFzTj9g69tpeYIYGLqlaR2nPKnXY
         JbaPCdZwaYN4VckyAgm9advhTTKTi4radONdytGWX6sf33nrw4HY5xMJKocjQJYThxY4
         awrdLTJg+HspXIPMg8K9DbsZWTuK4CW+KsgaghB05bbp0Z6CDcPUvao2pJE0tQ9etYTG
         06Qr1b28YtJCktq53t239Fl6QN0y1QdyOBdaQzEETKV2viTK3doLE5FG9WcQmGeMWx07
         lMLeaoUvr8tCGZ35u8YV4dAfYLjdeViyILVZNrSDKUB/F9a+9jE8J2ur1g8GS1t2K+bZ
         ea1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xv40rDikhpGj1gO+S5PFI70OqXKcih9FYV8He3Os+U=;
        b=RbRtaSC9yB3vIDNwzVosZOSkb4/IHXdu1O3SLrbmqvb4IbOHHSQ7aKuhT/SKT6klkT
         IhdvlwzQPd447elcXIG+V5G87SBBGYjW9NvLIwjdXb+IvlxJstGAionKZQ5426HL9bu+
         1txXnMmrIBx8ylB531VoZhsjaLNZK1hn5oz9VMHIGDyA523FN/UUIyvwAKxBkd1bub/E
         QIqY2Co8hox5x59V5Lm6BVwv5nVXFii+yFAAQolPtGYOhePTxMX0AjlZMeJ0qyIvZT5P
         2TvtSYxzfHE3x5ce0sMLrzngNAU6VZJXwD2blkFAJ7CY9OItysQFXCz/KIj6rX2n/1I5
         YYJQ==
X-Gm-Message-State: APjAAAX/AeqC6MH22LzGYPC9Fq863/F/dwCTDEI0lvdnflAXFXBcLNe1
        sa8pLXyuse8eNbrU1GSyiM79YA==
X-Google-Smtp-Source: APXvYqy+AuFiNJYSmMvWEPg7Pi/wMomf0boO0z0jA8J7VfuGSwtbXOlRqPiMtY+z0E3SxcqpOM8JeA==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr2398130wrw.226.1551968098338;
        Thu, 07 Mar 2019 06:14:58 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm9679304wrv.11.2019.03.07.06.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:14:57 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: meson-pll: add reduced specific clk_ops for G12A PCIe PLL
Date:   Thu,  7 Mar 2019 15:14:53 +0100
Message-Id: <20190307141455.23879-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307141455.23879-1-narmstrong@baylibre.com>
References: <20190307141455.23879-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson G12A PCIE PLL is fined tuned to deliver a very precise
100MHz reference clock for the PCIe Analog PHY, and thus requires
a strict register sequence to enable the PLL.
To simplify, use the _init() op to enable the PLL and keep
the other ops except set_rate since the rate is fixed.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/clk-pll.c | 26 ++++++++++++++++++++++++++
 drivers/clk/meson/clk-pll.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 41e16dd7272a..6a88dd75ccf0 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -303,6 +303,16 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
 	return 1;
 }
 
+static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
+{
+	meson_clk_pll_init(hw);
+
+	if (meson_clk_pll_wait_lock(hw))
+		return -EIO;
+
+	return 0;
+}
+
 static int meson_clk_pll_enable(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
@@ -387,6 +397,22 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+/*
+ * The Meson G12A PCIE PLL is fined tuned to deliver a very precise
+ * 100MHz reference clock for the PCIe Analog PHY, and thus requires
+ * a strict register sequence to enable the PLL.
+ * To simplify, re-use the _init() op to enable the PLL and keep
+ * the other ops except set_rate since the rate is fixed.
+ */
+const struct clk_ops meson_clk_pcie_pll_ops = {
+	.recalc_rate	= meson_clk_pll_recalc_rate,
+	.round_rate	= meson_clk_pll_round_rate,
+	.is_enabled	= meson_clk_pll_is_enabled,
+	.enable		= meson_clk_pcie_pll_enable,
+	.disable	= meson_clk_pll_disable
+};
+EXPORT_SYMBOL_GPL(meson_clk_pcie_pll_ops);
+
 const struct clk_ops meson_clk_pll_ops = {
 	.init		= meson_clk_pll_init,
 	.recalc_rate	= meson_clk_pll_recalc_rate,
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 55af2e285b1b..367efd0f6410 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -45,5 +45,6 @@ struct meson_clk_pll_data {
 
 extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
+extern const struct clk_ops meson_clk_pcie_pll_ops;
 
 #endif /* __MESON_CLK_PLL_H */
-- 
2.20.1

