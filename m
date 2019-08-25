Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBEF20870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmj0w6Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfHYOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:19:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfHYOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:19:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id y200so2194226pfb.6;
        Sun, 25 Aug 2019 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+TiXTfy0GvucZpWMpF+hFSYcOEhRLjxhLj5EgYmgAI=;
        b=Fmj0w6FapHbABc+eh987fmHXPe8SCHwirQLQQP6cdae4qFHsUNAz1Siwh0NjJqvkfa
         COWY1/KpH6kxxFZWb2ckNWPSfK4YHU2vt/XlWuP6hGzLArij8okqzymSXrHeuyx5m8EM
         TsjBS11ZpnL4SSmyZIIk4lpjSPniC9YDes63aNa35olscVGvNBX9A5KqGOC6ESzv3ljC
         BoV1R5+gtzPIG6VZkRqRqmCoAQDOnScmWmP9FSIH4xRu/JA5/vWhrCw16R9eWFs3odxV
         dyv38klp+9OXGyfwPTTAzUWArNP4j5gawujiivYMxRIDgHdTCU+ZL6NyYVe8rvYuzCWM
         ZKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y+TiXTfy0GvucZpWMpF+hFSYcOEhRLjxhLj5EgYmgAI=;
        b=XYVwgsdb4iG03MgXH6LA+uozh8Hi0EW90LNz4Cb753S9ls95BntCVOsE/MSCd14tot
         HV4HoC8S/aKRghE/H3FO3hyxSpWUMZ1nEiKx6kpjhiRJ6UQp/LDNv/ry9KvV6DpToDXT
         LndOO5b0P74TcnwJKdFpfFmBywSgzMuTumIpOqYYqbyTTTQFWwm6XC01CFB+0Cn8ANzA
         mhiKRs9xhTgIOvdpsr8lpDIXY64dWiJX3IBqRi4pW6S/k6+tU8ugcG/Tl3tFeCYGYk6Z
         gsEigy0oQDIxoWlBWYG0X2CZFFR6K1HHjYKzjMM4MHR6YJRpUBXo3JXunsZMOfjFAPZX
         93rw==
X-Gm-Message-State: APjAAAUjnIgqDu3xFqa7+jeCszF4uI2guj5a28ZvNk39monhJ4CUjWFq
        2ksa0jpoPubEtm8pBiYNTt8=
X-Google-Smtp-Source: APXvYqzKESmVpB2PpNa7q5Q8l51H9Ksa648hdf0lESby6oBi9xrh0rz5puTH5viJQ284Y8gkE5TC2Q==
X-Received: by 2002:a63:5920:: with SMTP id n32mr11870847pgb.352.1566742751322;
        Sun, 25 Aug 2019 07:19:11 -0700 (PDT)
Received: from voyager.ozlabs.ibm.com (pa49-199-217-21.pa.vic.optusnet.com.au. [49.199.217.21])
        by smtp.gmail.com with ESMTPSA id w1sm7734562pjt.30.2019.08.25.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:19:10 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/2] clk: aspeed: Move structures to header
Date:   Sun, 25 Aug 2019 23:48:47 +0930
Message-Id: <20190825141848.17346-2-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190825141848.17346-1-joel@jms.id.au>
References: <20190825141848.17346-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be reused by the ast2600 driver.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 include required headers for structures used by clk-aspeed.h

 drivers/clk/clk-aspeed.c | 67 ++------------------------------
 drivers/clk/clk-aspeed.h | 82 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 64 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 898291501f45..abf06fb6453e 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -1,19 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp
 
 #define pr_fmt(fmt) "clk-aspeed: " fmt
 
-#include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/reset-controller.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 #include <dt-bindings/clock/aspeed-clock.h>
 
+#include "clk-aspeed.h"
+
 #define ASPEED_NUM_CLKS		36
 
 #define ASPEED_RESET2_OFFSET	32
@@ -42,48 +42,6 @@ static struct clk_hw_onecell_data *aspeed_clk_data;
 
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
@@ -208,13 +166,6 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
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
@@ -315,18 +266,6 @@ static const struct clk_ops aspeed_clk_gate_ops = {
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
index 000000000000..5296b15b1c88
--- /dev/null
+++ b/drivers/clk/clk-aspeed.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Structures used by ASPEED clock drivers
+ *
+ * Copyright 2019 IBM Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+struct clk_div_table;
+struct regmap;
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

