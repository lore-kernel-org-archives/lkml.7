Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC4DC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6672089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248324;
	bh=9pP3OKj38O5IkaCOSE4CREy2A/7c7sgJ1J4PosN60ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NX2XVOIyaJvmGM7i6cvfDK2HzN9XEYBI2bCaW8d6fmd3kgbvKGayINar8iLuQ187R
	 In47g8I7QWAncvefqz5KwZEanTB3p1WO7cAaqjMv7+3KJhDr/ud5hpN/3CdJOowsMQ
	 rL1vYvbdXJBsml2u93rlD8+m09Xmwp8Lgb00kDpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405578AbfFKKSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405314AbfFKKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:24 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2C321743;
        Tue, 11 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248243;
        bh=9pP3OKj38O5IkaCOSE4CREy2A/7c7sgJ1J4PosN60ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3WfUcUXiekWEAT+fNA59IZv43uoQI5NzkILbpcZcSRa1AvEEitV9A8yetlJIF8bJ
         X9nxNOXD66Xf4uSGP+UYZ2sFBPyFj5pe4tYyiA+AXftwlUZyi4UTxp2lph4Wx5mibv
         IWQ4neS/eqfTKhGPb2sm67ULS8LtIivQ8oFhUE9s=
Received: by wens.tw (Postfix, from userid 1000)
        id 35F6F602B7; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 06/25] clk: fixed-factor: Add CLK_FIXED_FACTOR_HWS which takes list of struct clk_hw *
Date:   Tue, 11 Jun 2019 18:16:39 +0800
Message-Id: <20190611101658.23855-7-wens@kernel.org>
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
.parent_hws, for clk drivers to directly reference parents by clk_hw.

Add a new macro, CLK_FIXED_FACTOR_HWS, that can take an array of pointers
to struct clk_hw, instead of a string, as its parent. Taking an array
instead of a direct pointer allows the reuse of the array for multiple
clks, rather than having one compound literal with the same contents
allocated for each clk declaration.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/clk-provider.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c85e9f3809f2..146a6859969e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -996,6 +996,21 @@ extern struct of_device_id __clk_of_table;
 						 _flags),		\
 	}
 
+/*
+ * This macro allows the driver to reuse the _parent array for multiple
+ * fixed factor clk declarations.
+ */
+#define CLK_FIXED_FACTOR_HWS(_struct, _name, _parent,			\
+			     _div, _mult, _flags)			\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT_HWS(_name,		\
+						  _parent,		\
+						  &clk_fixed_factor_ops, \
+						  _flags),	\
+	}
+
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *args,
-- 
2.20.1

