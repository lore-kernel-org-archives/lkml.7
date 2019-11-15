Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9779120740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pM8P5t4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKOWeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKOWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so5313075pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sm9ffuHyQlqHKvL/cAQ/Bj58CBN3LS1S5BSazdWb9s=;
        b=pM8P5t4PtpN4KMbwNUNzh+mn2x2kH6Il5JxeWrKcKQ8kx58doVIPMM4rtWksFJl4Yi
         xpsRjLEis5CKrLOAjaRS2tsUqYI7mBV7IEsmC35MdUVzIJq1+U59yl5C8M/5ckGv0OO2
         WsTXDoKyWjG+RTKzRIP3NmhG82iAuiyJHdHZJlXS2fg0egy7r7NhIwEmTwuwZI/snEuz
         HyEtEYXEheT/4bI8e0D8VFssUGtO3ESnWqkrCqal5Bv0wWXjt+RLeWPfWKS2b2ElEOdH
         b5dok1fcKq2xCkY6DxuuptOWNO3qxCRJOsuscR83yFKy8B3Q3vLeQv1yOg9D+rhmxnPG
         /v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/sm9ffuHyQlqHKvL/cAQ/Bj58CBN3LS1S5BSazdWb9s=;
        b=Ju4Dszw09ENSkH7A4cFltRB5iE7hYriMhBdhJE00NLUiDmJYP4WHVB9enw4KmouUQq
         n9l9J6V6y4AIyKjdjVvrbXkMEhWPwT1OqOe0QxF3plCCG+OnSEvBSOWKBomYVy2uEsIM
         A1RzE24zbE7WdRlJ66Os16Q+srr1dfqzZxPGZe426mMWD/zu+xhte1rWp9uSMvwvkVFn
         +bLmGdpyeBK1g3+4ocV0Wt2tAmX15Wj9WTAntiCLecoRhHyhvW2fSHpBnwC3NxR93A69
         RrVOifrtrcGW+Ad7nCT3E6+buZJvIw+Kqjl9DtWKrnSn/pC0DIhl4W2SaXBUamEF7CJx
         J5MQ==
X-Gm-Message-State: APjAAAWr76efhzACLCSZ0jbMDfzqY2j4OBLs6nMy4CWIFpRRje2RvyIY
        x2ETXnoXDzr4BaT5I6c2yA5yfQ==
X-Google-Smtp-Source: APXvYqxhiASeIh6AbbOCOM1G3JW5aTZMnQlTM00qyXfaFHU8biTlEeNgh5n5hJS1PlX3q3qN6XW4ig==
X-Received: by 2002:a63:9247:: with SMTP id s7mr19675322pgn.334.1573857246932;
        Fri, 15 Nov 2019 14:34:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:06 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 11/20] clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
Date:   Fri, 15 Nov 2019 15:33:47 -0700
Message-Id: <20191115223356.27675-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

commit 72cfd1ad1057f16fc614861b3c271597995e57ba upstream

STM32MP1 clock IP offers lots of Kernel clocks that are shared
by multiple IP's at the same time.
Then boot loader applies a clock tree that allows to use all IP's
at same time and with the maximum of performance.
Not change parents on a change rate on kernel clocks ensures
the integrity of the system.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/clk/clk-stm32mp1.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 851fb4e9ac44..8e25ed62f67b 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1286,10 +1286,11 @@ _clk_stm32_register_composite(struct device *dev,
 	MGATE_MP1(_id, _name, _parent, _flags, _mgate)
 
 #define KCLK(_id, _name, _parents, _flags, _mgate, _mmux)\
-	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE | _flags,\
-		  _MGATE_MP1(_mgate),\
-		  _MMUX(_mmux),\
-		  _NO_DIV)
+	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE |\
+		       CLK_SET_RATE_NO_REPARENT | _flags,\
+		       _MGATE_MP1(_mgate),\
+		       _MMUX(_mmux),\
+		       _NO_DIV)
 
 enum {
 	G_SAI1,
@@ -1952,7 +1953,8 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 	MGATE_MP1(GPU_K, "gpu_k", "pll2_q", 0, G_GPU),
 	MGATE_MP1(DAC12_K, "dac12_k", "ck_lsi", 0, G_DAC12),
 
-	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE,
+	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
 		  _NO_GATE,
 		  _MMUX(M_ETHCK),
 		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
-- 
2.17.1

