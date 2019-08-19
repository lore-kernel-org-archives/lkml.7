Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D513C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4414205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRbdUQec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfHSNCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:02:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40623 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfHSNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:02:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so945688pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=70nxwZafCYlFjcUnZixCqBC0Lk3FuIHCQ+uw4WwvqpE=;
        b=kRbdUQecsr5QHKl+P1TtO20EsX7vl6bofQEVYRamOy0xxhn52UCo7x6pVlYA+v5drN
         JR7JzqrTUlQ24hee8AyQWh17A1leKgseAR8xY1wCUm0aZtEJcXA5L7R69e6JRyJyBsJg
         FbEJ1SZvSA/WAFK5CU3kNaZDiR2OzlY/DW9cXB5Ko81ryQCR4yhGUxKz2eHR1OJJYZ/U
         y5gcc5hXtrBpVRE158eZCRBL49iepq+au58cuvL7eA45tUJ57r5y7RIRS/7X+3ZDVQ8V
         y7eLpNQD6QX/WqLB/jVeRO3d6hy4cXRX/avlYmDdAB+ySxi77djSiDnPrd1LeAXyvzFy
         xRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=70nxwZafCYlFjcUnZixCqBC0Lk3FuIHCQ+uw4WwvqpE=;
        b=GRropf/RbKkL7T7himF+ad5JOC9CFafJIi7JIT0vNCC4Fo5r32Zv/oC7YEj+G/8JSd
         K6qJ/icI/0Fq6QQc1Xch2IfYh5jI00z3L2/voIm9h0u6N9FZ6cY6Ji84pXn6xyFRCqR3
         ngs4j71QPEjrDRICIJpSrMmgn/ZAtVd1Ujdp2xO2j53hsk5OLS2jj4EWhVmq7FRFVuLq
         sqqAR8VqW0bS2S77umZv+y1NcNH7vHx/x+B10XW+cpRE0+dYAa9GBoiqekLR7e/6Wi2d
         i7lkWMw+UMl8vv8ilBp4FKomUCTeXKqYwADRh5MAwa4oiTCoTKtP012/Igmskx6t4nG3
         KG8w==
X-Gm-Message-State: APjAAAXFgRbBevlhKl+zJf4U0iAduOKu2G7kG5d4ivhwDDALPq780Axa
        TtwY77WnTrwl9ushkUdtf9Vo
X-Google-Smtp-Source: APXvYqzIJeKTT2sTPwuWm/ZOaSwja3rS2vyAc3OwiPxIxqONpU/2Nq1Q0YRO6tWZsc9Der/3EdjrvQ==
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr7460089plq.92.1566219722377;
        Mon, 19 Aug 2019 06:02:02 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id l123sm20626464pfl.9.2019.08.19.06.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:02:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/8] clk: Zero init clk_init_data in helpers
Date:   Mon, 19 Aug 2019 18:31:36 +0530
Message-Id: <20190819130143.18778-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org>
References: <20190819130143.18778-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_init_data struct needs to be initialized to zero for the new
parent_map implementation to work correctly. Otherwise, the member which
is available first will get processed.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/clk-composite.c  | 2 +-
 drivers/clk/clk-divider.c    | 2 +-
 drivers/clk/clk-fixed-rate.c | 2 +-
 drivers/clk/clk-gate.c       | 2 +-
 drivers/clk/clk-mux.c        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index b06038b8f658..4d579f9d20f6 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -208,7 +208,7 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 			unsigned long flags)
 {
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 	struct clk_composite *composite;
 	struct clk_ops *clk_composite_ops;
 	int ret;
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3f9ff78c4a2a..65dd8137f9ec 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -471,7 +471,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 {
 	struct clk_divider *div;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 	int ret;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index a7e4aef7a376..746c3ecdc5b3 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -58,7 +58,7 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 {
 	struct clk_fixed_rate *fixed;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 	int ret;
 
 	/* allocate fixed-rate clock */
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 1b99fc962745..8ed83ec730cb 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -141,7 +141,7 @@ struct clk_hw *clk_hw_register_gate(struct device *dev, const char *name,
 {
 	struct clk_gate *gate;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 	int ret;
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 66e91f740508..2caa6b2a9ee5 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -153,7 +153,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 {
 	struct clk_mux *mux;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = { NULL };
 	u8 width = 0;
 	int ret;
 
-- 
2.17.1

