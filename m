Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB74B2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565884829;
	bh=QnG/KkGfkTCSQNZwmKsAWgV6XjxiR5j718pQxM/xoeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNKDi0x3gEoo+vw62xeD7CBXwW3y1u1pjZyWZWByyUJIz5jFE24lMXrZrPrxEEc++
	 gTbjUgmfyvDHxbyhwF11IWqD17deXr+QeNvbcgE1snezToQAv88I8a3fdQBpu3rYJd
	 Rxw7c0TOUczA9TvZR0UPvbv8tM1uTLen0sWTSBTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfHOQA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbfHOQAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:00:24 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913782089E;
        Thu, 15 Aug 2019 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565884822;
        bh=QnG/KkGfkTCSQNZwmKsAWgV6XjxiR5j718pQxM/xoeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSIigna+VI36TsKnew3G4UEfT3mJIPLoNRfm7sb/RWCB9SmiK3QeIHDXaE3B9QMsx
         QTM1H/nzSEpYhUVOPe4WnEcA2vhc8CZGGcOA15irWhFYm1kozzwQK3b4ifBer/ZLIL
         PWrbp7O106s4zYZBcjwY8XHzNWRjcvsWgG8Nu6U4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/4] clk: zx296718: Don't reference clk_init_data after registration
Date:   Thu, 15 Aug 2019 09:00:18 -0700
Message-Id: <20190815160020.183334-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190815160020.183334-1-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/zte/clk-zx296718.c | 109 +++++++++++++++------------------
 1 file changed, 49 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index fd6c347bec6a..dd7045bc48c1 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -564,6 +564,7 @@ static int __init top_clocks_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	int i, ret;
+	const char *name;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -573,11 +574,10 @@ static int __init top_clocks_init(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(zx296718_pll_clk); i++) {
 		zx296718_pll_clk[i].reg_base += (uintptr_t)reg_base;
+		name = zx296718_pll_clk[i].hw.init->name;
 		ret = clk_hw_register(NULL, &zx296718_pll_clk[i].hw);
-		if (ret) {
-			pr_warn("top clk %s init error!\n",
-				zx296718_pll_clk[i].hw.init->name);
-		}
+		if (ret)
+			pr_warn("top clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(top_ffactor_clk); i++) {
@@ -585,11 +585,10 @@ static int __init top_clocks_init(struct device_node *np)
 			top_hw_onecell_data.hws[top_ffactor_clk[i].id] =
 					&top_ffactor_clk[i].factor.hw;
 
+		name = top_ffactor_clk[i].factor.hw.init->name;
 		ret = clk_hw_register(NULL, &top_ffactor_clk[i].factor.hw);
-		if (ret) {
-			pr_warn("top clk %s init error!\n",
-				top_ffactor_clk[i].factor.hw.init->name);
-		}
+		if (ret)
+			pr_warn("top clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(top_mux_clk); i++) {
@@ -598,11 +597,10 @@ static int __init top_clocks_init(struct device_node *np)
 					&top_mux_clk[i].mux.hw;
 
 		top_mux_clk[i].mux.reg += (uintptr_t)reg_base;
+		name = top_mux_clk[i].mux.hw.init->name;
 		ret = clk_hw_register(NULL, &top_mux_clk[i].mux.hw);
-		if (ret) {
-			pr_warn("top clk %s init error!\n",
-				top_mux_clk[i].mux.hw.init->name);
-		}
+		if (ret)
+			pr_warn("top clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(top_gate_clk); i++) {
@@ -611,11 +609,10 @@ static int __init top_clocks_init(struct device_node *np)
 					&top_gate_clk[i].gate.hw;
 
 		top_gate_clk[i].gate.reg += (uintptr_t)reg_base;
+		name = top_gate_clk[i].gate.hw.init->name;
 		ret = clk_hw_register(NULL, &top_gate_clk[i].gate.hw);
-		if (ret) {
-			pr_warn("top clk %s init error!\n",
-				top_gate_clk[i].gate.hw.init->name);
-		}
+		if (ret)
+			pr_warn("top clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(top_div_clk); i++) {
@@ -624,11 +621,10 @@ static int __init top_clocks_init(struct device_node *np)
 					&top_div_clk[i].div.hw;
 
 		top_div_clk[i].div.reg += (uintptr_t)reg_base;
+		name = top_div_clk[i].div.hw.init->name;
 		ret = clk_hw_register(NULL, &top_div_clk[i].div.hw);
-		if (ret) {
-			pr_warn("top clk %s init error!\n",
-				top_div_clk[i].div.hw.init->name);
-		}
+		if (ret)
+			pr_warn("top clk %s init error!\n", name);
 	}
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
@@ -754,6 +750,7 @@ static int __init lsp0_clocks_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	int i, ret;
+	const char *name;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -767,11 +764,10 @@ static int __init lsp0_clocks_init(struct device_node *np)
 					&lsp0_mux_clk[i].mux.hw;
 
 		lsp0_mux_clk[i].mux.reg += (uintptr_t)reg_base;
+		name = lsp0_mux_clk[i].mux.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp0_mux_clk[i].mux.hw);
-		if (ret) {
-			pr_warn("lsp0 clk %s init error!\n",
-				lsp0_mux_clk[i].mux.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp0 clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lsp0_gate_clk); i++) {
@@ -780,11 +776,10 @@ static int __init lsp0_clocks_init(struct device_node *np)
 					&lsp0_gate_clk[i].gate.hw;
 
 		lsp0_gate_clk[i].gate.reg += (uintptr_t)reg_base;
+		name = lsp0_gate_clk[i].gate.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp0_gate_clk[i].gate.hw);
-		if (ret) {
-			pr_warn("lsp0 clk %s init error!\n",
-				lsp0_gate_clk[i].gate.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp0 clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lsp0_div_clk); i++) {
@@ -793,11 +788,10 @@ static int __init lsp0_clocks_init(struct device_node *np)
 					&lsp0_div_clk[i].div.hw;
 
 		lsp0_div_clk[i].div.reg += (uintptr_t)reg_base;
+		name = lsp0_div_clk[i].div.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp0_div_clk[i].div.hw);
-		if (ret) {
-			pr_warn("lsp0 clk %s init error!\n",
-				lsp0_div_clk[i].div.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp0 clk %s init error!\n", name);
 	}
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
@@ -862,6 +856,7 @@ static int __init lsp1_clocks_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	int i, ret;
+	const char *name;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -875,11 +870,10 @@ static int __init lsp1_clocks_init(struct device_node *np)
 					&lsp0_mux_clk[i].mux.hw;
 
 		lsp1_mux_clk[i].mux.reg += (uintptr_t)reg_base;
+		name = lsp1_mux_clk[i].mux.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp1_mux_clk[i].mux.hw);
-		if (ret) {
-			pr_warn("lsp1 clk %s init error!\n",
-				lsp1_mux_clk[i].mux.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp1 clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lsp1_gate_clk); i++) {
@@ -888,11 +882,10 @@ static int __init lsp1_clocks_init(struct device_node *np)
 					&lsp1_gate_clk[i].gate.hw;
 
 		lsp1_gate_clk[i].gate.reg += (uintptr_t)reg_base;
+		name = lsp1_gate_clk[i].gate.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp1_gate_clk[i].gate.hw);
-		if (ret) {
-			pr_warn("lsp1 clk %s init error!\n",
-				lsp1_gate_clk[i].gate.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp1 clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(lsp1_div_clk); i++) {
@@ -901,11 +894,10 @@ static int __init lsp1_clocks_init(struct device_node *np)
 					&lsp1_div_clk[i].div.hw;
 
 		lsp1_div_clk[i].div.reg += (uintptr_t)reg_base;
+		name = lsp1_div_clk[i].div.hw.init->name;
 		ret = clk_hw_register(NULL, &lsp1_div_clk[i].div.hw);
-		if (ret) {
-			pr_warn("lsp1 clk %s init error!\n",
-				lsp1_div_clk[i].div.hw.init->name);
-		}
+		if (ret)
+			pr_warn("lsp1 clk %s init error!\n", name);
 	}
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
@@ -979,6 +971,7 @@ static int __init audio_clocks_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	int i, ret;
+	const char *name;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -992,11 +985,10 @@ static int __init audio_clocks_init(struct device_node *np)
 					&audio_mux_clk[i].mux.hw;
 
 		audio_mux_clk[i].mux.reg += (uintptr_t)reg_base;
+		name = audio_mux_clk[i].mux.hw.init->name;
 		ret = clk_hw_register(NULL, &audio_mux_clk[i].mux.hw);
-		if (ret) {
-			pr_warn("audio clk %s init error!\n",
-				audio_mux_clk[i].mux.hw.init->name);
-		}
+		if (ret)
+			pr_warn("audio clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(audio_adiv_clk); i++) {
@@ -1005,11 +997,10 @@ static int __init audio_clocks_init(struct device_node *np)
 					&audio_adiv_clk[i].hw;
 
 		audio_adiv_clk[i].reg_base += (uintptr_t)reg_base;
+		name = audio_adiv_clk[i].hw.init->name;
 		ret = clk_hw_register(NULL, &audio_adiv_clk[i].hw);
-		if (ret) {
-			pr_warn("audio clk %s init error!\n",
-				audio_adiv_clk[i].hw.init->name);
-		}
+		if (ret)
+			pr_warn("audio clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(audio_div_clk); i++) {
@@ -1018,11 +1009,10 @@ static int __init audio_clocks_init(struct device_node *np)
 					&audio_div_clk[i].div.hw;
 
 		audio_div_clk[i].div.reg += (uintptr_t)reg_base;
+		name = audio_div_clk[i].div.hw.init->name;
 		ret = clk_hw_register(NULL, &audio_div_clk[i].div.hw);
-		if (ret) {
-			pr_warn("audio clk %s init error!\n",
-				audio_div_clk[i].div.hw.init->name);
-		}
+		if (ret)
+			pr_warn("audio clk %s init error!\n", name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(audio_gate_clk); i++) {
@@ -1031,11 +1021,10 @@ static int __init audio_clocks_init(struct device_node *np)
 					&audio_gate_clk[i].gate.hw;
 
 		audio_gate_clk[i].gate.reg += (uintptr_t)reg_base;
+		name = audio_gate_clk[i].gate.hw.init->name;
 		ret = clk_hw_register(NULL, &audio_gate_clk[i].gate.hw);
-		if (ret) {
-			pr_warn("audio clk %s init error!\n",
-				audio_gate_clk[i].gate.hw.init->name);
-		}
+		if (ret)
+			pr_warn("audio clk %s init error!\n", name);
 	}
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
-- 
Sent by a computer through tubes

