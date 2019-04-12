Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9E42171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q3siTrsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDLIhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:37:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42886 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfDLIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:37:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so10795661wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sOiZF2RRECBO6RoEOo/1qBZdgN1RuY9lkXgyf0v0vnQ=;
        b=q3siTrsXSoQjcT4KL9ruKuXWDwVbStT+BhVHeTipGviXOe2TUE80YuwNOzYNQv7OFP
         EVypXJ4oUNAKTBFSLtuA6B3a4ngZUFOZZ8AhCrxmM5xpbvATbZ+S4jH+A4OeEtmEl1M9
         oc6xjfZ5dVbOvH3n3EytgGu+XFkro7oNoL2KGFkWS85H+hW4majuNBHl0+cOGzGTm+1u
         erggezpOtkcThY0b6eX6fxvsrRp46eavJe//IRTi+9REzQdfpXjEn70mdHoRrKsA9xAe
         4/eE2+8HNXHNiUJyyfEmSL3KqXU8U9ypn4c0uAhra5C9ji/l2nkIhsFl5pJB+vKrv4Kn
         d9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sOiZF2RRECBO6RoEOo/1qBZdgN1RuY9lkXgyf0v0vnQ=;
        b=Z5kKOMKLtWOCJzzmt/8u4vGCm7nifCD2JNLXV/geuZyXNVftZVcBQutshifIdgxEOg
         NLkkveI9dYVye/Io5AkG/T3kVjjgD+GtxzNOZOydgX6QVH0gIBQg+2eyykloBYlcAjMg
         VbOBqFTMpS010V2qx3BMj+/sZtH5NqqILNBX1I031pxvBaRmdmiquJ3tqhIMwsmEG8Xf
         a6dTX4b+LfD0xCvBILryclQAoGNlFEvQLHvTJ2Kj2xUoaWRKdHGcVb62tpr+zM7rbRc/
         59JphnNHW8Bdt4l4u/yLng3rrAy7DFw7POXEZk7DaPY24yn1eX5tIpO6qTmnXrAiJ4uo
         XkTg==
X-Gm-Message-State: APjAAAWRDvv0tbbVn5igza858P+0U6ppMAvN10EaWiNCl7GOBvrmlH2f
        qTwdUUXmY0UQcgeaf/jzjA6hGK75mrM=
X-Google-Smtp-Source: APXvYqySZxms+eMsBaAZl0h8nB3hNacE3Jj+YG+7tAhkOfSp7Hyiq9GE6YnFzGnywfXltJ2juNZ2Hg==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr33488719wrx.32.1555058252138;
        Fri, 12 Apr 2019 01:37:32 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y125sm12124318wmc.39.2019.04.12.01.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 01:37:31 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] clk: meson-g12a: Add Temperature Sensor clock
Date:   Fri, 12 Apr 2019 10:37:28 +0200
Message-Id: <20190412083728.21029-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412083728.21029-1-glaroque@baylibre.com>
References: <20190412083728.21029-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TS clock used by two temperature sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/clk/meson/g12a.c | 31 +++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 3a3134976534..cbb4abc0311e 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -2335,6 +2335,33 @@ static struct clk_regmap g12a_mali = {
 	},
 };
 
+static struct clk_regmap g12a_ts_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_TS_CLK_CNTL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ts_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_ts = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_TS_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ts",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "ts_div" },
+		.num_parents = 1,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(g12a_ddr,			HHI_GCLK_MPEG0,	0);
 static MESON_GATE(g12a_dos,			HHI_GCLK_MPEG0,	1);
@@ -2615,6 +2642,8 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
 		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
 		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
+		[CLKID_TS_DIV]			= &g12a_ts_div.hw,
+		[CLKID_TS]			= &g12a_ts.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -2803,6 +2832,8 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_cpu_clk_trace,
 	&g12a_pcie_pll_od,
 	&g12a_pcie_pll_dco,
+	&g12a_ts_div,
+	&g12a_ts,
 };
 
 static const struct meson_eeclkc_data g12a_clkc_data = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 1393a09730a6..5633c72e432d 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -189,8 +189,9 @@
 #define CLKID_PCIE_PLL_DCO			198
 #define CLKID_PCIE_PLL_DCO_DIV2			199
 #define CLKID_PCIE_PLL_OD			200
+#define CLKID_TS_DIV				202
 
-#define NR_CLKS					202
+#define NR_CLKS					204
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.17.1

