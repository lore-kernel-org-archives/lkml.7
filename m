Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B01C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A96216E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uWHt3xtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfEMMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:31:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56043 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbfEMMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:31:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so2448825wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdGNE3efspU2W+dukA5SOqgLjvxWYgLtfHeCCZw+vxg=;
        b=uWHt3xtLWXxZD51SfbvUje5CiKhbokXP41QIxuUjYAjnWDlsEw04aeT04nuOYHjM0Z
         FG2IT9PSXrbBDOlYe9yJ1qiTA2h3hA1Hl75/pEXNCnrxohtH41sh2eXvhUgWwTGNWiyJ
         V8alRsggbL8HsVxjO6HLvJkTIbtkSbMkuPrzLHCDA7NYWbBX5H+rrCRt8/GyNrNpZGdl
         mOznOMZaa/wDZk+YevG8ngfEQcQ8hwHF9teT63WxbnbLncpVGl3Ghkx47iP0JY6tvHjS
         JbLcxHy/1rsxL3nmCjgq78hdzzLjqfehgnjs5MauetJ2vaR129ZC7HBMXrdgwIrLqlln
         IGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdGNE3efspU2W+dukA5SOqgLjvxWYgLtfHeCCZw+vxg=;
        b=fKoB6FtY/WnERdflc4W+g7CCayfaq6sGiH5909MgfJroxmyWchnUdbH8EQWhgRQlQn
         5HEpzV1U3v0kG2C9O3XpCjLXRE8/M9F8ahfOEfmR6HwCqjOVKCswpzmUZKYl05MS3EUN
         wHmx+xNDMPShMRBAu/DBnlCm7l4/71CX9P8CrRFh/KmRl897tKdcAFNDGj/dY2KWC+pj
         rIoe2aXsPTJPbHoKphm8UBbp0CSy+NsIsKFyWAklwI2YbZHq7YHePPVkdZ3FFWr4GiMV
         HocP+24CWTrIp7zoj0TulZXU9r2K+0XHeyeR9jUSlpxWGwDhLqUu7M/JSjnkGvhEeTs0
         f6AQ==
X-Gm-Message-State: APjAAAWWrqS8mlgfgGoW6O5v8uCSurZEwZ5F+4Oa3yMeOj9IwZh9lMmG
        lSkyb9hxLy4ciAuZ1hWLrLs4Jw==
X-Google-Smtp-Source: APXvYqxPFUsw4Pichrq3VBDvd5jo6Vj9rOkVj+suMGVecjhE9VYq2RaJAQ9yjDygOUMEWHNrqTmtHQ==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr15862015wme.128.1557750688475;
        Mon, 13 May 2019 05:31:28 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16175584wra.81.2019.05.13.05.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:31:27 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] clk: meson: g12a: add mpll register init sequences
Date:   Mon, 13 May 2019 14:31:13 +0200
Message-Id: <20190513123115.18145-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required init of each MPLL of the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d11606d5ddbd..ef1d2e4c8fd2 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1001,6 +1001,10 @@ static struct clk_fixed_factor g12a_mpll_prediv = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll0_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL2,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -1024,6 +1028,8 @@ static struct clk_regmap g12a_mpll0_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll0_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll0_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -1047,6 +1053,10 @@ static struct clk_regmap g12a_mpll0 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll1_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL4,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll1_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -1070,6 +1080,8 @@ static struct clk_regmap g12a_mpll1_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll1_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll1_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
@@ -1093,6 +1105,10 @@ static struct clk_regmap g12a_mpll1 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll2_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL6,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll2_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -1116,6 +1132,8 @@ static struct clk_regmap g12a_mpll2_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll2_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll2_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
@@ -1139,6 +1157,10 @@ static struct clk_regmap g12a_mpll2 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll3_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL8,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll3_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -1162,6 +1184,8 @@ static struct clk_regmap g12a_mpll3_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll3_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll3_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3_div",
-- 
2.20.1

