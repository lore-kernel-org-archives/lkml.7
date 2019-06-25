Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1439C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D8204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehQo1iJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfFYQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:47:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52520 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfFYQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so3550460wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx1EmDNUL6NrJs1zybeQYATP7BtRS3ZxfHrchYlbb1w=;
        b=ehQo1iJYS9sB9JFN2Xa22OZs9vsDho+0SpTjnu+gLJrGOR91YDeDq/PPd81moyZ2sY
         0FyU9t0jreva8jyV04sH4pWQ70l6pRHZJbBWvSULWQngBX+Z9EdPpp8VUtNT8LxcsAHh
         vDjKzTSGbPyFTth0SxzDdo/EeN3U2FXuXRuyJ3TxRvy0pEcSXC+KKU2wL+Z5fIRO2H+P
         d9Vits6jzByP971MXaDurZbFM8FOV/kvXPKitcFxzyjSvvlNu2YsdbbzQjdSN7vX566V
         qamvc45X6PPKW9gW0tctAb3tSHNSMZYpqHHqaWFj/NT0HYHWhFqZhwRFbJsoHe1X8UJn
         kUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx1EmDNUL6NrJs1zybeQYATP7BtRS3ZxfHrchYlbb1w=;
        b=OEecLDedvG+EFCf6ystng3Cx9TX3LH8yO7U0ukJwISmdHGAeGUCTcI7mVb9Gozho9r
         eGMsiW9Lv15dF0LDcYFkj+nw17/pJ2/vVZ7bltrtBCPdmsL56ysqJ/I5j5ZUoduxhERT
         V16AV+5L+0dqkP6U5APWL0OQKFFu8gjJ35SDWDVmEyVW5AN0L87N8A+kQrHOqp/XypQV
         gZLzSpcBmfs43z03XhnA5rNqr1sJw1VGxM+K+uayvP39YPAc/LpLD9Z+/fhuzUr+v5pI
         e1ntbSly+dCZoXrnW0AF0P2fJsXq+BGuehxrDFHfH2P1flp3iLA5QCo5VAfQGP2BLDMS
         n9Yw==
X-Gm-Message-State: APjAAAXjOumt9WPQqLe2jM5Hu/RSgrceXmT4t7eEP2PbyYZ9EhQazH0B
        edUqrOh6sasXWJ0iEbi4RNnEOw==
X-Google-Smtp-Source: APXvYqzQegDiAysGwbSCaeJGZtZMZeEuUAmigshcMMK0ThMtUBYljkK/qXsHQTpNJjJTMGnl9rKg9w==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr19048286wmg.134.1561481259356;
        Tue, 25 Jun 2019 09:47:39 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:38 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 01/14] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
Date:   Tue, 25 Jun 2019 18:47:20 +0200
Message-Id: <20190625164733.11091-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
specifications.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 8 ++++++++
 drivers/clk/qcom/clk-alpha-pll.h | 1 +
 drivers/clk/qcom/gcc-qcs404.c    | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 0ced4a5a9a17..ef51f302bdf0 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -730,6 +730,14 @@ static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
 	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
 }
 
+const struct clk_ops clk_alpha_pll_fixed_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_ops);
+
 const struct clk_ops clk_alpha_pll_ops = {
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 66755f0f84fc..6b4eb74706b4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -104,6 +104,7 @@ struct alpha_pll_config {
 };
 
 extern const struct clk_ops clk_alpha_pll_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_ops;
 extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ops;
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 29cf464dd2c8..18c6563889f3 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -330,7 +330,7 @@ static struct clk_alpha_pll gpll0_ao_out_main = {
 			.parent_names = (const char *[]){ "cxo" },
 			.num_parents = 1,
 			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_alpha_pll_ops,
+			.ops = &clk_alpha_pll_fixed_ops,
 		},
 	},
 };
-- 
2.21.0

