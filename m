Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED46C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EAD206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339561;
	bh=qxbiy7pYv1UyBjII7RZZHCsKy8cgqqufDiwhp9WjbYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nim34Xy5zDcPgpA29q1lNuGN9t6r5T5oqWqSPNuY0ZafmN9FzUREsxPGJcrNDJXZ+
	 37RxVb2CCEa37usDuZVLfEagCLkI1WoOweBZrI7O9z7fxeuCGyzn4duiKdu2H5C16x
	 ElvOCIPdUJpc0WjczoaYALf1QyFUhbJATrtFzmjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfETIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbfETIFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:37 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C9F208CA;
        Mon, 20 May 2019 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339537;
        bh=qxbiy7pYv1UyBjII7RZZHCsKy8cgqqufDiwhp9WjbYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHSHqk3LxBF7lY/qECJVCOAMj31ubt0jtLLtuUXYv86LQNYkMO69xcocJtYq6eoHC
         k4D4B7m1BFDxf3gGV08lXNsU9V7l1DFb+leN8EU1JcQ9D7FAv7DnKTa081HQVmlFzF
         +wTzTckYuovqrxwdsD8O8D5gOZ11LW5yhNxsSVXw=
Received: by wens.tw (Postfix, from userid 1000)
        id 6CCC462B58; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] clk: fixed-factor: Add CLK_FIXED_FACTOR_FW_NAME for DT clock-names parent
Date:   Mon, 20 May 2019 16:04:03 +0800
Message-Id: <20190520080421.12575-8-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code, clk_init_data was expanded to include
.parent_data, for clk drivers to specify parents using a combination of
device tree clock-names, pointers to struct clk_hw, device tree clocks,
and/or fallback global clock names.

Add a new macro, CLK_FIXED_FACTOR_FW_NAME, that takes a string to match
a clock-names entry in the device tree to specify the clock parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index ac26aef874d1..a6cd04442eff 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1006,6 +1006,17 @@ extern struct of_device_id __clk_of_table;
 						  _flags),	\
 	}
 
+#define CLK_FIXED_FACTOR_FW_NAME(_struct, _name, _parent,		\
+				 _div, _mult, _flags)			\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT_FW_NAME(_name,		\
+						      _parent,		\
+						      &clk_fixed_factor_ops, \
+						      _flags),		\
+	}
+
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
-- 
2.20.1

