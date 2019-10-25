Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F97CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976E920867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439829AbfJYLOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:14:36 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:63301 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439286AbfJYLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:14:35 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9PBE1TC066720
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Oct 2019 19:14:01 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 25 Oct 2019 19:13:55
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Xiaolong Zhang <xiaolong.zhang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/5] clk: sprd: add gate for pll clocks
Date:   Fri, 25 Oct 2019 19:13:34 +0800
Message-ID: <20191025111338.27324-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9PBE1TC066720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Xiaolong Zhang <xiaolong.zhang@unisoc.com>

Some sprd's gate clocks are used to the switch of pll, which
need to wait a certain time for stable after being enabled.

Signed-off-by: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/gate.c | 19 +++++++++++++++++++
 drivers/clk/sprd/gate.h | 21 +++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
index f59d1936b412..d8b480f852f3 100644
--- a/drivers/clk/sprd/gate.c
+++ b/drivers/clk/sprd/gate.c
@@ -79,6 +79,17 @@ static int sprd_sc_gate_enable(struct clk_hw *hw)
 
 	return 0;
 }
+
+static int sprd_pll_sc_gate_prepare(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_sc_gate_toggle(sg, true);
+	udelay(sg->udelay);
+
+	return 0;
+}
+
 static int sprd_gate_is_enabled(struct clk_hw *hw)
 {
 	struct sprd_gate *sg = hw_to_sprd_gate(hw);
@@ -109,3 +120,11 @@ const struct clk_ops sprd_sc_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
 
+#define sprd_pll_sc_gate_unprepare sprd_sc_gate_disable
+
+const struct clk_ops sprd_pll_sc_gate_ops = {
+	.unprepare	= sprd_pll_sc_gate_unprepare,
+	.prepare	= sprd_pll_sc_gate_prepare,
+	.is_enabled	= sprd_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(sprd_pll_sc_gate_ops);
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index dc352ea55e1f..598ce607ca0a 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -14,16 +14,19 @@ struct sprd_gate {
 	u32			enable_mask;
 	u16			flags;
 	u16			sc_offset;
+	u32			udelay;
 
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
-			     _enable_mask, _flags, _gate_flags, _ops)	\
+#define SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, _udelay, _ops)		\
 	struct sprd_gate _struct = {					\
 		.enable_mask	= _enable_mask,				\
 		.sc_offset	= _sc_offset,				\
 		.flags		= _gate_flags,				\
+		.udelay		= _udelay,				\
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
@@ -34,6 +37,12 @@ struct sprd_gate {
 		}							\
 	}
 
+#define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
+			     _enable_mask, _flags, _gate_flags, _ops)	\
+	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset, _enable_mask, _flags,	\
+				    _gate_flags, 0, _ops)
+
 #define SPRD_GATE_CLK(_struct, _name, _parent, _reg,			\
 		      _enable_mask, _flags, _gate_flags)		\
 	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, 0,		\
@@ -46,6 +55,13 @@ struct sprd_gate {
 			     _enable_mask, _flags, _gate_flags,		\
 			     &sprd_sc_gate_ops)
 
+#define SPRD_PLL_SC_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
+			    _enable_mask, _flags, _gate_flags, _udelay)	\
+	SPRD_SC_GATE_CLK_OPS_UDELAY(_struct, _name, _parent, _reg,	\
+				    _sc_offset,	_enable_mask, _flags,	\
+				    _gate_flags, _udelay,		\
+				    &sprd_pll_sc_gate_ops)
+
 static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
 {
 	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
@@ -55,5 +71,6 @@ static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
 
 extern const struct clk_ops sprd_gate_ops;
 extern const struct clk_ops sprd_sc_gate_ops;
+extern const struct clk_ops sprd_pll_sc_gate_ops;
 
 #endif /* _SPRD_GATE_H_ */
-- 
2.20.1


