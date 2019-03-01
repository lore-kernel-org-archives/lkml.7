Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6B52087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1bWLjVae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfCAKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:21:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfCAKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:21:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so25198174wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+56+BpEQ+JbsY5jIsG+5HwoLjz/jjEOEZma5vzKtt4=;
        b=1bWLjVaecO1Kwe5bWwvDDRYZaziz8Z5HOixwmyelDDE6QltSKocYM44r/FgPZw0ma+
         tgvKzgX1ripXsAT0c9c26b6QxF8siLn/ctI2hJrC7sZfWUDMIKsfHZx08XRuea2V1AZc
         66cHJa7SbS0rFkiGyZVCJzhb7wxCrUXFT5lSPuFval67fkSjbrgEmslFZKw5RSrG2i6u
         YGp64wlteKaIZcq/lG7PVmJ54GLxqQRP3lIergtmj96E1WWFLn0Ab8GF0EGGE0HW2FiG
         efbZJeKMUJF/LQUpH6EXDNGnDehmECgTT6o+83CKy0bD+4H9KCSmrsROYk5xJXvjgoY5
         x6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+56+BpEQ+JbsY5jIsG+5HwoLjz/jjEOEZma5vzKtt4=;
        b=gNNGiG4zkAwYeNq9RP7w4jsg8yl4yzga6hOcv8mETJeuMCYNNGmnYLvJ6wTDlJa26n
         z+NEvwfPPhdMkacm94XYaHyE2w/mBQHAPWrKy4iZI7L1ZY/PaGtu7EO8zLguAZUbM1R4
         LhzKn0VQ4AFZ/G10vdLPXt/EmY83V9S8vTCcAWw0hnOhGc70BiAb07fxLekqvKYk9F3K
         OeA2piIu/r1l+z+bfZUwwQveArIeJiMmFWsEJOOcGioXrAQOJ3Yh/Ht7yyyMecunIkqI
         ZCQpWKhBq38wOXutQKYA0Ov/WCO9Jm8e4WRv1vsLSbJvq7T8+tZRG4Sn/537afSuEQzn
         7C2w==
X-Gm-Message-State: APjAAAV986hFzrTxuq3YhjLY9qOBX5wbHLUR1I1NhDJcE0ldJjPhbvd8
        wZ1EwyWheC5JvpOvJuI9My1UqJqFRNYdHA==
X-Google-Smtp-Source: APXvYqwF4WLTCHup3GgNWVBASfxQaDJG/YFQq7/AFPxadwysFmn4Z3qJ1yFYFuP66LZK0pGgodqoog==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr2909974wro.16.1551435704900;
        Fri, 01 Mar 2019 02:21:44 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f68sm14446626wmg.5.2019.03.01.02.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 02:21:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: meson-g12a: add cpu clock bindings
Date:   Fri,  1 Mar 2019 11:21:39 +0100
Message-Id: <20190301102140.7181-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301102140.7181-1-narmstrong@baylibre.com>
References: <20190301102140.7181-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
it should be the only ID used.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.h              | 24 +++++++++++++++++++++++-
 include/dt-bindings/clock/g12a-clkc.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index f399dfe1401c..4854750df902 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -166,8 +166,30 @@
 #define CLKID_MALI_0_DIV			170
 #define CLKID_MALI_1_DIV			173
 #define CLKID_MPLL_5OM_DIV			176
+#define CLKID_PCIE_PLL_DCO			178
+#define CLKID_PCIE_PLL_DCO_DIV2			179
+#define CLKID_PCIE_PLL_OD			180
+#define CLKID_SYS_PLL_DIV16_EN			181
+#define CLKID_SYS_PLL_DIV16			182
+#define CLKID_CPU_CLK_DYN0_SEL			183
+#define CLKID_CPU_CLK_DYN0_DIV			184
+#define CLKID_CPU_CLK_DYN0			185
+#define CLKID_CPU_CLK_DYN1_SEL			186
+#define CLKID_CPU_CLK_DYN1_DIV			187
+#define CLKID_CPU_CLK_DYN1			188
+#define CLKID_CPU_CLK_DYN			189
+#define CLKID_CPU_CLK_DIV16_EN			191
+#define CLKID_CPU_CLK_DIV16			192
+#define CLKID_CPU_CLK_APB_DIV			193
+#define CLKID_CPU_CLK_APB			194
+#define CLKID_CPU_CLK_ATB_DIV			195
+#define CLKID_CPU_CLK_ATB			196
+#define CLKID_CPU_CLK_AXI_DIV			197
+#define CLKID_CPU_CLK_AXI			198
+#define CLKID_CPU_CLK_TRACE_DIV			299
+#define CLKID_CPU_CLK_TRACE			200
 
-#define NR_CLKS					178
+#define NR_CLKS					201
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 83b657038d1e..33aba232282c 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -131,5 +131,6 @@
 #define CLKID_MALI_1				174
 #define CLKID_MALI				175
 #define CLKID_MPLL_5OM				177
+#define CLKID_CPU_CLK				190
 
 #endif /* __G12A_CLKC_H */
-- 
2.20.1

