Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535EF214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L2oxYcTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfIBWUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:20:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35011 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:20:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so15363437wrx.2;
        Mon, 02 Sep 2019 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbpHxnDBxXx170DoGswvL3HiN5epW2CNEsNmP1ES4JU=;
        b=L2oxYcTkuKi/U6Ryi6UjYgPeUYJb9CH0qbBBWAd7OBpq1bgCTF7LMJJKpUkAJqWkLs
         76cdEl5v8UzM3RervtpvynB2koOelgHtZZHpZE4aMYc/BIsf3w0BXfBJjXx72KDqqlZQ
         fBETKsJKpm2VAfItN6UrLIQAVJlbnwIT7OFBqNKvRyufzpv4VUYb6ou1+Sp1U4amPTiz
         LaSDqB9UQgi04cUWvSNYOY4P4cq9ft0yTl33wQtL4RmQj2QXfUaHsemzo6O3PWaeJT0y
         6zYy8ZuqtRJSTidTJCQ2ltKSpxeQ0sd3FasjRx8t7XD87qc+n3Ta87QB8RGvQifKkK7H
         Oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbpHxnDBxXx170DoGswvL3HiN5epW2CNEsNmP1ES4JU=;
        b=hZWjarX3aPKZA0o+cy/FR6LuWOSev1EBoerZ/zfF8iD5RKC/GpxleJ/X00W+Wk5Jct
         geYAreZH/sZGwa5rvkw8HBeGk8P1eDxQoMODOGf+b6aWHUwZqFCOolsLbyHZ2/gh+yxp
         TAzOKcw8xY7Mm05tHoR5Xvjg/yVxXyaImir+PYlzlZ8WfMhUlQYLYmR8AvSuuISmkjJH
         33C/L7p/roWGR7apRo5nsLV8fDJH7CePuYEI7aZXbMv2FX6jZlU/CFbIcKwOLsvPHfZS
         8o+GXIUlr14CMATV/22inmE5U13I8KNDfKT9pvLDKg6eTPQ9q+RF8o6zE1KatVPeaSNY
         BdZQ==
X-Gm-Message-State: APjAAAXkWoOAMJrN5SQvPiLVR9LerVG9OFgIYk6BL/RxtaVhN3PXSkQ7
        /3wOBhFPYrw1uH2T1lew760=
X-Google-Smtp-Source: APXvYqy+Gbdp/tVMGvd7w7DWg+eedL+1OuXc79nXRKuSBEh7TKnUcGZLii4h5C6ciZmcUY1CQy2LYg==
X-Received: by 2002:adf:f282:: with SMTP id k2mr4450132wro.38.1567462828052;
        Mon, 02 Sep 2019 15:20:28 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133F1DA0058B592E56A73A27F.dip0.t-ipconnect.de. [2003:f1:33f1:da00:58b5:92e5:6a73:a27f])
        by smtp.googlemail.com with ESMTPSA id z17sm16242733wrw.23.2019.09.02.15.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 15:20:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     rahul.tanwar@linux.intel.com
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robhkernel.org@vger.kernel.org, sboyd@kernel.org,
        yixin.zhu@linux.intel.com
Subject: RE: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
Date:   Tue,  3 Sep 2019 00:20:15 +0200
Message-Id: <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I only noticed this patchset today and I don't have much time left.
Here's my initial impressions without going through the code in detail.
I'll continue my review in the next days (as time permits).

As with all other Intel LGM patches: I don't have access to the
datasheets, so it's possible that I don't understand <insert topic here>
feel free to correct me in this case (I appreciate an explanation where
I was wrong, so I can learn from it)


[...]
--- /dev/null
+++ b/drivers/clk/intel/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+config INTEL_LGM_CGU_CLK
+	depends on COMMON_CLK
+	select MFD_SYSCON
can you please explain the reason why you need to use syscon?
also please see [0] for a comment from Rob on another LGM dt-binding
regarding syscon

+	select OF_EARLY_FLATTREE
there's not a single other "select OF_EARLY_FLATTREE" in driver/clk
I'm not saying this is wrong but it makes me curious why you need this

[...]
diff --git a/drivers/clk/intel/clk-cgu.h b/drivers/clk/intel/clk-cgu.h
new file mode 100644
index 000000000000..e44396b4aad7
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright(c) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+
+#ifndef __INTEL_CLK_H
+#define __INTEL_CLK_H
+
+struct intel_clk_mux {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+};
+
+struct intel_clk_divider {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+	const struct clk_div_table *table;
+};
+
+struct intel_clk_ddiv {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift0;
+	u8 width0;
+	u8 shift1;
+	u8 width1;
+	u8 shift2;
+	u8 width2;
+	unsigned int mult;
+	unsigned int div;
+	unsigned long flags;
+};
+
+struct intel_clk_gate {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	unsigned long flags;
+};
I know at least two existing regmap clock implementations:
- drivers/clk/qcom/clk-regmap*
- drivers/clk/meson/clk-regmap*

it would be great if we could decide to re-use one of those for the
"generic" clock types (mux, divider and gate).
Stephen, do you have any preference here?
personally I like the meson one, but I'm biased because I've used it
a lot in the past and I haven't used the qcom one at all.


Martin


[0] https://lkml.org/lkml/2019/8/27/849
