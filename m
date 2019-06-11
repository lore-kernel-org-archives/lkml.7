Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D42205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248259;
	bh=QrCB9F6TrRnxcZhPbN8ur0QRjMk8IvRHyFauXr/wPw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JurUegXqy2w6Lmmdw/Dr1M7KWe/siPlZ+/Zyep9QPUC9eDPcSiucUveWsptsYtYyq
	 6VtHRKHLy4rbeFqSoYOagNo+OgOAm4WemHeXCVD1HYudsZsDLYJfpBCED99l2T+v4m
	 O0B/MUHfhZKpZqYNj0LBzCIorjzu5L+JsviF0Qvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405407AbfFKKRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404766AbfFKKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:27 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D03C2183F;
        Tue, 11 Jun 2019 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248245;
        bh=QrCB9F6TrRnxcZhPbN8ur0QRjMk8IvRHyFauXr/wPw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu2CxCBP4khNbluILkaEj0j9ursd2BkEG49CrAI9+XYhAm/ZTd8r6mzQIUPWq/Qfs
         6unYKWMlk2ra819Gf1YLQeHat2v9gjSYA8CtvAyCiYyOf6mx8U2jyfRgx15DLEJqld
         mw74DYsIkvxUE4gmXKrjKEUqe3oMqDg+KAaSBbT8=
Received: by wens.tw (Postfix, from userid 1000)
        id A0A3360C95; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 23/25] clk: sunxi-ng: gate: Add macros for referencing local clock parents
Date:   Tue, 11 Jun 2019 18:16:56 +0800
Message-Id: <20190611101658.23855-24-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611101658.23855-1-wens@kernel.org>
References: <20190611101658.23855-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code, clk_init_data was expanded to include
.parent_hws, for clk drivers to directly reference parents by clk_hw,
and .parent_data, for clk drivers to specify parents using a combination
of device tree clock-names, pointers to struct clk_hw, device tree clocks,
and/or fallback global clock names.

Add four new macros:

  - SUNXI_CCU_GATE_HW, that can take a struct clk_hw pointer, instead
    of a string, as its parent.

  - SUNXI_CCU_GATE_FW that takes a string to match a clock-names entry
    in the device tree to specify the clock parent.

  - SUNXI_CCU_GATE_HWS that takes an array of struct clk_hw * as its
    parent. This allows the array to be shared with other clk
    declarations.

  - SUNXI_CCU_GATE_DATA that takes an array of struct clk_parent_data *
    as its parent. This allows the array to be shared with other clk
    declarations.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_gate.h | 53 +++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_gate.h b/drivers/clk/sunxi-ng/ccu_gate.h
index 4466169bd2d7..613ddd03629e 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.h
+++ b/drivers/clk/sunxi-ng/ccu_gate.h
@@ -36,6 +36,59 @@ struct ccu_gate {
 		}							\
 	}
 
+#define SUNXI_CCU_GATE_HW(_struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_HW(_name,		\
+							 _parent,	\
+							 &ccu_gate_ops,	\
+							 _flags),	\
+		}							\
+	}
+
+#define SUNXI_CCU_GATE_FW(_struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_FW_NAME(_name,	\
+							      _parent,	\
+							      &ccu_gate_ops, \
+							      _flags),	\
+		}							\
+	}
+
+/*
+ * The following two macros allow the re-use of the data structure
+ * holding the parent info.
+ */
+#define SUNXI_CCU_GATE_HWS(_struct, _name, _parent, _reg, _gate, _flags) \
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_HWS(_name,	\
+							  _parent,	\
+							  &ccu_gate_ops, \
+							  _flags),	\
+		}							\
+	}
+
+#define SUNXI_CCU_GATE_DATA(_struct, _name, _data, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	=				\
+				CLK_HW_INIT_PARENTS_DATA(_name,		\
+							 _data,		\
+							 &ccu_gate_ops,	\
+							 _flags),	\
+		}							\
+	}
+
 static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
-- 
2.20.1

