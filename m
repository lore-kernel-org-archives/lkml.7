Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3744FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C11F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjDlZAUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392509AbfHVRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:36:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41089 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391576AbfHVRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so3831275pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=70nxwZafCYlFjcUnZixCqBC0Lk3FuIHCQ+uw4WwvqpE=;
        b=wjDlZAUyA+79EgPCGsEzncxofResf0ntanYurX8vDWxjInime4FmFm6ORYEgwqXo7z
         /0virIKbDYaQEaPcAP76VxXXkDOeaI3ZWvseBaGwlW07x2HlEzF8oa7tL2+Pt6itKZg6
         351N80qRTQsgtn8yNEhTokgA0L4COEYnf911oeXo9EsvSgFhzUxqDXjmMkHmjh1+abNx
         p0YC1ybNMoWamMUui+k2D/sepRVDNSOWX9OHZcpgfAJWJ5Mf9Jv5nQ3nUNmWifGjqXiQ
         +BbeGYZniUPpiMqKmd14A3vzc9e1I2CBSExLbMNDdvrFOhknPEbljs91QfSqDMwWGks6
         t7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=70nxwZafCYlFjcUnZixCqBC0Lk3FuIHCQ+uw4WwvqpE=;
        b=sR1GSulbITDJ/m1U6MVfihNMBy3WvSV09wH0ncDv5llguI4E6UmMsO7kW6ZA4tgSMm
         W74z5OMm3NE9c90DoMLr+0sAoZah6ryg/ODE8QLu4kwrnESzErUMoylYF03Fs9XGlPkT
         AbMSq1E+FaFgSovWSTmhyAVSlq8CNjUODho0Z0d+71sQ+bZTS6J8r0iKY5rjiKUeIVtz
         2cHg9uoL7qNParucSm9tTpKWFX53Ji0UhC4O1m7/7hcRbzxQAOhQau36wm7TvLT6AUTx
         HwxPKXvLJh/jICRogvqeri67NiKV4OJiYRX8t4/s8xFtz6wuTl0WPhJN7QOzLhmoyeIj
         3Vzw==
X-Gm-Message-State: APjAAAVnSrzzqijPDGJV5ik+pwciYVP3dyuj9z2TnXb9rvI452J7InsK
        LraIjmGcNtVMWKx5ycofOu8n
X-Google-Smtp-Source: APXvYqyGPkXXQfTveOLHfKtvtOEU23e9V2exsqqblaUouTOQNZ/alWYRyrWpHuw/O2f7ZDi/ObIWbw==
X-Received: by 2002:a17:902:aa93:: with SMTP id d19mr41354972plr.148.1566494688626;
        Thu, 22 Aug 2019 10:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:71cc:5738:24ad:193e:4b59:8a76])
        by smtp.gmail.com with ESMTPSA id r12sm31705798pgb.73.2019.08.22.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:24:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/8] clk: Zero init clk_init_data in helpers
Date:   Thu, 22 Aug 2019 22:54:19 +0530
Message-Id: <20190822172426.25879-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
References: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
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

