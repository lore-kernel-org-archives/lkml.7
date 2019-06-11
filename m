Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94573C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6101021744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248243;
	bh=uAVNKwQsk008WMN9I4bdYYLY9j8+uUFL/Mq3nvXQu1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3r0v9sM3SYE05rTpk7QYqptrLV1njlu5rxsZZBgVbzRZgG3jdIbEnoOXRtCHHZCH
	 h91AWof50On1rDaeXSwmQGNrXq7mIlV5pir2xtDd9pVauZXKHgt58bMbz7E0WUkQBP
	 VAZxKyOe2W/FifUSf93jZpwm8/YT6C1h3+P3t/9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405298AbfFKKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405038AbfFKKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:21 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121C8212F5;
        Tue, 11 Jun 2019 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248241;
        bh=uAVNKwQsk008WMN9I4bdYYLY9j8+uUFL/Mq3nvXQu1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQYoJEDm6ZJ8bMcz+vCo/iiV6bx2Ro5ZSfz/GPXanc9zscMEubXZd6D7REBTi0l9J
         AvEf/8g1PHEnv974piDwhvmHKSRXS2Xlo2WVzVdDUqPdexkxhcv3lhqVaqBbPnD3oB
         GRBzyiEn7cH8vNvFTUbxudmsfjopqV/+uBk0ODy0=
Received: by wens.tw (Postfix, from userid 1000)
        id 1871B60039; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 02/25] clk: Add CLK_HW_INIT_* macros using .parent_hws
Date:   Tue, 11 Jun 2019 18:16:35 +0800
Message-Id: <20190611101658.23855-3-wens@kernel.org>
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

With the new clk parenting code, struct clk_init_data was expanded to
include .parent_hws, for clk drivers to directly list parents by
pointing to their respective struct clk_hw's.

Add macros that can take either one single struct clk_hw *, or an array
of them, for drivers to use.

A special CLK_HW_INIT_HWS macro is included, which takes an array of
struct clk_hw *, but sets .num_parents to 1. This variant is to allow
the reuse of the array, instead of having a compound literal allocated
for each clk sharing the same parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..70aad5cefea7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -904,6 +904,29 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_HW(_name, _parent, _ops, _flags)			\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_hws	= (const struct clk_hw*[]) { _parent },	\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
+/*
+ * This macro is intended for drivers to be able to share the otherwise
+ * individual struct clk_hw[] compound literals created by the compiler
+ * when using CLK_HW_INIT_HW. It does NOT support multiple parents.
+ */
+#define CLK_HW_INIT_HWS(_name, _parent, _ops, _flags)			\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_hws	= _parent,				\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
 #define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
 	(&(struct clk_init_data) {				\
 		.flags		= _flags,			\
@@ -913,6 +936,15 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,				\
 	})
 
+#define CLK_HW_INIT_PARENTS_HW(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_hws	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
 #define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)	\
 	(&(struct clk_init_data) {			\
 		.flags          = _flags,		\
-- 
2.20.1

