Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44337C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A4221721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riVGsWza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfHPP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:58:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46978 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfHPP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:58:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so2551045pgv.13;
        Fri, 16 Aug 2019 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zglRUo87FrQV2zX9KKFbhlLEMq8IJXox2mwKvEQ1BRM=;
        b=riVGsWzaiZrh4uyngeP2RJwEeuP8SQCbxRX/4QwDFNTYsvkuyZshqUaPQg/YccV6DR
         IsifDMnM9N3rTY2+Tg3e/H950a0CWgcN5UKaFLCcdg3WiLO1Jm6XF3uEoIgyBieq2+lP
         vbX/2HDHoQRqUe2ud7LPRHIJJoXLkjUJVhf/ilp0ViYIG5gxhhZJeRZcwsu/f5oVQGLe
         oLodkSlKQ4lVSfXWGG7qMgA0Tpf51nEBJXUnbzjwWW32YAmPiohbHpkPgH+nQ80qHNEL
         f1KA23kW0V3DU/9S/isEeerAxXYU/QmjzZkvaHFNFBK5bqEl6+AnRmILwdkdJOkZybZx
         ue8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zglRUo87FrQV2zX9KKFbhlLEMq8IJXox2mwKvEQ1BRM=;
        b=EG3d0E0YxDLBNnb5ag4tq27DxPysaTD/HsgLLj666D0vbTlYPMtsvhL+b+wT10IqA+
         kPtPvSTnAsivKgv5VSoNB2X64YEPXedo0lEIvcb7LBdT0KUZ2NqEnpSsiRZWCbGKYkSl
         hMjemxaHI6GDg1ecactaoVWrBmoa8/OpT+jxICgF60jlrsF95HI75yqwPihGyK/BIgyR
         AM9zdK/p7OCjDfyOhriZkjiyWYobV6HZBR2RGpT63vSbQkastyo8t199TOxqaQXpZAlq
         xTdzMkYAYUX71ob2Tqe0smPYcKoCuBkvGYeuZBXbYBn7bJiF7LUGrE2vD/PxW2cfbUxy
         FIgQ==
X-Gm-Message-State: APjAAAVh2UX1yOu3WDketFp8r5BmiC578dN6BP1qmd0E9GaUJC3qHtNh
        w6roqqUUiEa7v3HMtW0lrcc=
X-Google-Smtp-Source: APXvYqwnRgwkT9B1gYcGwvd2PVFCvv/IFEGurXHnnHC9Vjw+S0WcEONGxRvS1+5KwwDQ2FyHNn8iEA==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr8108462pjs.31.1565971101434;
        Fri, 16 Aug 2019 08:58:21 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id s24sm5746052pgm.3.2019.08.16.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:58:20 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 1/2] clk: aspeed: Move structures to header
Date:   Sat, 17 Aug 2019 01:28:05 +0930
Message-Id: <20190816155806.22869-2-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816155806.22869-1-joel@jms.id.au>
References: <20190816155806.22869-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be reused by the ast2600 driver.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 63 ++--------------------------------
 drivers/clk/clk-aspeed.h | 74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 61 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 898291501f45..44df54d87ad4 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -14,6 +14,8 @@
 
 #include <dt-bindings/clock/aspeed-clock.h>
 
+#include "clk-aspeed.h"
+
 #define ASPEED_NUM_CLKS		36
 
 #define ASPEED_RESET2_OFFSET	32
@@ -42,48 +44,6 @@ static struct clk_hw_onecell_data *aspeed_clk_data;
 
 static void __iomem *scu_base;
 
-/**
- * struct aspeed_gate_data - Aspeed gated clocks
- * @clock_idx: bit used to gate this clock in the clock register
- * @reset_idx: bit used to reset this IP in the reset register. -1 if no
- *             reset is required when enabling the clock
- * @name: the clock name
- * @parent_name: the name of the parent clock
- * @flags: standard clock framework flags
- */
-struct aspeed_gate_data {
-	u8		clock_idx;
-	s8		reset_idx;
-	const char	*name;
-	const char	*parent_name;
-	unsigned long	flags;
-};
-
-/**
- * struct aspeed_clk_gate - Aspeed specific clk_gate structure
- * @hw:		handle between common and hardware-specific interfaces
- * @reg:	register controlling gate
- * @clock_idx:	bit used to gate this clock in the clock register
- * @reset_idx:	bit used to reset this IP in the reset register. -1 if no
- *		reset is required when enabling the clock
- * @flags:	hardware-specific flags
- * @lock:	register lock
- *
- * Some of the clocks in the Aspeed SoC must be put in reset before enabling.
- * This modified version of clk_gate allows an optional reset bit to be
- * specified.
- */
-struct aspeed_clk_gate {
-	struct clk_hw	hw;
-	struct regmap	*map;
-	u8		clock_idx;
-	s8		reset_idx;
-	u8		flags;
-	spinlock_t	*lock;
-};
-
-#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
-
 /* TODO: ask Aspeed about the actual parent data */
 static const struct aspeed_gate_data aspeed_gates[] = {
 	/*				 clk rst   name			parent	flags */
@@ -208,13 +168,6 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
 			mult, div);
 }
 
-struct aspeed_clk_soc_data {
-	const struct clk_div_table *div_table;
-	const struct clk_div_table *eclk_div_table;
-	const struct clk_div_table *mac_div_table;
-	struct clk_hw *(*calc_pll)(const char *name, u32 val);
-};
-
 static const struct aspeed_clk_soc_data ast2500_data = {
 	.div_table = ast2500_div_table,
 	.eclk_div_table = ast2500_eclk_div_table,
@@ -315,18 +268,6 @@ static const struct clk_ops aspeed_clk_gate_ops = {
 	.is_enabled = aspeed_clk_is_enabled,
 };
 
-/**
- * struct aspeed_reset - Aspeed reset controller
- * @map: regmap to access the containing system controller
- * @rcdev: reset controller device
- */
-struct aspeed_reset {
-	struct regmap			*map;
-	struct reset_controller_dev	rcdev;
-};
-
-#define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
-
 static const u8 aspeed_resets[] = {
 	/* SCU04 resets */
 	[ASPEED_RESET_XDMA]	= 25,
diff --git a/drivers/clk/clk-aspeed.h b/drivers/clk/clk-aspeed.h
new file mode 100644
index 000000000000..92d384367c25
--- /dev/null
+++ b/drivers/clk/clk-aspeed.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Structures used by ASPEED clock drivers
+ *
+ * Copyright 2019 IBM Corp.
+ */
+
+/**
+ * struct aspeed_gate_data - Aspeed gated clocks
+ * @clock_idx: bit used to gate this clock in the clock register
+ * @reset_idx: bit used to reset this IP in the reset register. -1 if no
+ *             reset is required when enabling the clock
+ * @name: the clock name
+ * @parent_name: the name of the parent clock
+ * @flags: standard clock framework flags
+ */
+struct aspeed_gate_data {
+	u8		clock_idx;
+	s8		reset_idx;
+	const char	*name;
+	const char	*parent_name;
+	unsigned long	flags;
+};
+
+/**
+ * struct aspeed_clk_gate - Aspeed specific clk_gate structure
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register controlling gate
+ * @clock_idx:	bit used to gate this clock in the clock register
+ * @reset_idx:	bit used to reset this IP in the reset register. -1 if no
+ *		reset is required when enabling the clock
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ *
+ * Some of the clocks in the Aspeed SoC must be put in reset before enabling.
+ * This modified version of clk_gate allows an optional reset bit to be
+ * specified.
+ */
+struct aspeed_clk_gate {
+	struct clk_hw	hw;
+	struct regmap	*map;
+	u8		clock_idx;
+	s8		reset_idx;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+#define to_aspeed_clk_gate(_hw) container_of(_hw, struct aspeed_clk_gate, hw)
+
+/**
+ * struct aspeed_reset - Aspeed reset controller
+ * @map: regmap to access the containing system controller
+ * @rcdev: reset controller device
+ */
+struct aspeed_reset {
+	struct regmap			*map;
+	struct reset_controller_dev	rcdev;
+};
+
+#define to_aspeed_reset(p) container_of((p), struct aspeed_reset, rcdev)
+
+/**
+ * struct aspeed_clk_soc_data - Aspeed SoC specific divisor information
+ * @div_table: Common divider lookup table
+ * @eclk_div_table: Divider lookup table for ECLK
+ * @mac_div_table: Divider lookup table for MAC (Ethernet) clocks
+ * @calc_pll: Callback to maculate common PLL settings
+ */
+struct aspeed_clk_soc_data {
+	const struct clk_div_table *div_table;
+	const struct clk_div_table *eclk_div_table;
+	const struct clk_div_table *mac_div_table;
+	struct clk_hw *(*calc_pll)(const char *name, u32 val);
+};
-- 
2.23.0.rc1

