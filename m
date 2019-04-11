Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D054C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A002083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hcXgs/Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDKIpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:45:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDKIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:45:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so6191942wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uZ7qqews2O7XucznXFEO2bWGmRBz91rjfUznQYaR+AU=;
        b=hcXgs/Us2i1LqiCpownxWKZxx3I0JEedLl7VZ0y48hDAtgCzhSb/I09gP2H4m0nw+2
         NkpeFsk6niKChc3wbjXiDxYbI3w7HWN5i29s+9bKj7sn/U92jLTk6//qc/bm2J7TNmF9
         mL5/HIgHEf8+p/rGagIfcVnuJmHOu2UfS2ryG490lGsCXjEzTqvouiIKdhdfmt8YGbiB
         iz5H9O+HJ85SpBaqRE5iLArDPmjVycGOY5jw0YNvwGjF43lp5LlY2CWozbKlX7tzU+LG
         7vLeBoNpBS8I39/RZJQ1oGJJ+nGf+N4g7jBtAI5ZMwYgcicuJuogiejVD/LURDOIk0Fd
         F7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uZ7qqews2O7XucznXFEO2bWGmRBz91rjfUznQYaR+AU=;
        b=UnLSP9QI8PQgy8W1mgfK7d3X8la9pSjtDA/MMaA5QjmMYoZT0zulYcoXO1pbRawKcT
         XaWn4mEB5ev5TA8Dw4zHT4QKvbi4fZgfYshVtR4gY1rBNpjRjEoyRqP4rgwZHCAp4msk
         CazyYrKyLadAe/U4iyAlyFnVC/FWfDC0MyEXmtiZi8lxN8O27HqX5UYH568VbqRdTme7
         7PHXLgaFafCGuxx/IWAESe91NdRAcjPlPYsLyLQ3OP+fiDO9QBbhAXIfMS6xDmxhqkdu
         pvlZgzW3vA2kdyXYEkF8bbyacK5eHI1vIoI8FphlrhHWyFxl3b51pUpQtbXgrygB660C
         rxkg==
X-Gm-Message-State: APjAAAXBWNOdp9qfAyXW9l88ivmoeHbQxVNeu7y8AvgA0i4takwKqmdI
        gIrVS9C3kwV47+JxfG6febEiqg==
X-Google-Smtp-Source: APXvYqwyTjtvyg5KjtWDh44Yy0fg/y31wD+PxhUHgzWO+R7B19HFHB0yjhjcu9qJ+ovfQ+AEjhN8+g==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr30498225wru.160.1554972341885;
        Thu, 11 Apr 2019 01:45:41 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 7sm128602876wrc.81.2019.04.11.01.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:45:41 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: meson-g12a: Add Temperature Sensor clock
Date:   Thu, 11 Apr 2019 10:45:37 +0200
Message-Id: <20190411084537.30299-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411084537.30299-1-glaroque@baylibre.com>
References: <20190411084537.30299-1-glaroque@baylibre.com>
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
index 3a3134976534..e6d2af6ee8ea 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -2335,6 +2335,33 @@ static struct clk_regmap g12a_mali = {
 	},
 };
 
+static struct clk_regmap g12a_ts_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_TS_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
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

