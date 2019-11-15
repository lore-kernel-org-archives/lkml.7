Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077442073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCXxmzT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKOWer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40541 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfKOWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so5627044plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SMtnKN7Gs980aMHU7BQIQVC2axVHuGxWT+FltL2atao=;
        b=wCXxmzT0A12PK75MA7nI5jP3tzVW7exsIlZfw+O4eheNL+D7AfmnLUW8+DHy3zzCoT
         imMdV2IXvTuA9H87PHWJW7BZ1JaN+ZUEYeS1ckOpd7oZ3DKkU8RpBCqa2RgFFtzBhNZU
         ubWEC8OF8SNb4i33w0ag7PZ9+KXkkiLBpSiR8p8JVqGpc8do+Et/ECFqhKV6FcfSU3Nh
         BWJl4PpK/32Mi9tIt4EMVAKhaOdIDWTuc68utfJ+H1UFMvl17WpD2yq4hpv84JrGpbIR
         eT68K8VM6j8kNRxR3gmZWlZI61FuWTkCKyr4/74coj9MYpZ8Iqm7O94Yr4jv9UntJTk8
         OazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SMtnKN7Gs980aMHU7BQIQVC2axVHuGxWT+FltL2atao=;
        b=bvWgvfBcFhUqCRXn+wVxkeqWTbaX+hNwHHyK+Jat3RCqb6rCA30LIMR5o6s31UTn/O
         Cx+PnxEcNkQCfkELTwstrbfpbjgnWJtft1NJ3fdAJQiu8G9hEFh/MYcBqMlPnXlPzuC2
         wQpOIFFdwcS3x23UX3BE2MKdm8/NSjRLTXAdXJKYAkD4QZ9oSh1SCxE4OUU7AsDN93+i
         al3poqZgzUvXF5evrmc8RWen0wcsLijZNghwYVnu0IsIYPdrLIkto6C/KOIiQ5bJOQgs
         ZtNQ8R5aqBSxmnyetY0rCyOg2of43fcjKZCoXyyIiVysbqU8/Ft8glkJhUjfbfsORguQ
         NE2A==
X-Gm-Message-State: APjAAAWGGBfEn2QJ7ldUGboIve7uKkSmVdPqJB2N+qwxCciCbehYVfO/
        Ovw7JcMZDMLZX+I5JCFg6xWP9A==
X-Google-Smtp-Source: APXvYqwuKwX6BDI8XlSYaGLwJcivbUjXwRHYUP9kUFXgyIgUSmPpiWVI8b+3JiRmUg2D6EAa5Wg8iA==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr22961176pjk.93.1573857247779;
        Fri, 15 Nov 2019 14:34:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 12/20] clk: stm32mp1: parent clocks update
Date:   Fri, 15 Nov 2019 15:33:48 -0700
Message-Id: <20191115223356.27675-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 749c9e553e1f063eb132a78d80225532cbfedb80 upstream

Fixes parent clock for axi, fdcan, sai and adc12 clocks.

Fixes: e51d297e9a92 ("clk: stm32mp1: add Sub System clocks")
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 8e25ed62f67b..bf3b6a4c78d0 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -121,7 +121,7 @@ static const char * const cpu_src[] = {
 };
 
 static const char * const axi_src[] = {
-	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+	"ck_hsi", "ck_hse", "pll2_p"
 };
 
 static const char * const per_src[] = {
@@ -225,19 +225,19 @@ static const char * const usart6_src[] = {
 };
 
 static const char * const fdcan_src[] = {
-	"ck_hse", "pll3_q", "pll4_q"
+	"ck_hse", "pll3_q", "pll4_q", "pll4_r"
 };
 
 static const char * const sai_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
 };
 
 static const char * const sai2_src[] = {
-	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb"
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb", "pll3_r"
 };
 
 static const char * const adc12_src[] = {
-	"pll4_q", "ck_per"
+	"pll4_r", "ck_per", "pll3_q"
 };
 
 static const char * const dsi_src[] = {
-- 
2.17.1

