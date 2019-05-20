Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8DFC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339537;
	bh=+xkhllsSjVjbpVBqPaXjmCtg9BOWN3ILFlcR4TcmBAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sleyw81hPXXDOf6WH+IPqYujTmUeFJtH+2cpAtDTbpVsiBS6WK9C0YBzr3BsoZNNh
	 1R398uZHUor/vXYgdHwYXp1raO1MST9QybdKZv7Emou8ieGbU6o0arj+/xsxqaCpab
	 I+KV+/WXGbimo4PQsykPbgsULgqcQBlu6sgRiDGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfETIFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbfETIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:35 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A7B2085A;
        Mon, 20 May 2019 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339534;
        bh=+xkhllsSjVjbpVBqPaXjmCtg9BOWN3ILFlcR4TcmBAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjuAv9ojJKEQJ2xZYp00iCUNPsKCbmW2+DoqnKbsDel11gbBR/z+dO9mJlVTz+Ljh
         r7vFtMr7Bl7eDg89WBp8COwvMlx/aRvylbixnks/mehwIoysCv9PWe7HViXETZNRSn
         pIJjV6OdzldaYeWm6WzJcylNdI1WEDzD3GlqbZFw=
Received: by wens.tw (Postfix, from userid 1000)
        id 4FA2C5FF38; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] clk: Add CLK_HW_INIT_FW_NAME macro using .fw_name in .parent_data
Date:   Mon, 20 May 2019 16:03:59 +0800
Message-Id: <20190520080421.12575-4-wens@kernel.org>
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
.parent_data, for clk drivers that have parents referenced using a
combination of device tree clock-names, clock indices, and/or clk_hw
pointers.

Add a CLK_HW_INIT macro for specifying a single parent from the device
tree using .fw_name in struct clk_parent_data.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0c241b43a802..edad4ad5d897 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -922,6 +922,17 @@ extern struct of_device_id __clk_of_table;
 		.ops		= _ops,					\
 	})
 
+#define CLK_HW_INIT_FW_NAME(_name, _parent, _ops, _flags)		\
+	(&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_data	= (const struct clk_parent_data[]) {	\
+					{ .fw_name = _parent },		\
+				  },					\
+		.num_parents	= 1,					\
+		.ops		= _ops,					\
+	})
+
 #define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
 	(&(struct clk_init_data) {				\
 		.flags		= _flags,			\
-- 
2.20.1

