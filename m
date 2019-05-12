Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E368CC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9420C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hPLqw9Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfELU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:58:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38165 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfELU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:58:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so13012509wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sm9UEwQ3mt6/GT1ya/gcLVA0odO8xivuaaUGOOt4No4=;
        b=hPLqw9NroyF97KvvhKpIe0wPnef3gIPB4pjDSJW9Jzke60ROE+9tnEZ8Z+AOiwE47K
         TJEoGTYE4jfwwz4sE8mkYttcVJyaT4XHE1IL4g+689KKKC3SZyNqcq+hMYpnvwJDo3Ly
         /GAkrLx9wjGbbbbGrSOyc6Kqld4m2KRu4d/eE4haXvTR2s8uUtzTqwusuY2JMNImsIb1
         7w2hheTMNGldIiGpKYG3uJjEWWca9SrmgxrpQGJAorSmd7HGDQxrO9oEpVjzvf5O6knc
         z2fSkgBwQHyrB+yh6lXbsYvPpM84xjHEXHBENz30aooPFuy554whRfhtUCR/GxlqMc+G
         h3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sm9UEwQ3mt6/GT1ya/gcLVA0odO8xivuaaUGOOt4No4=;
        b=hvlMs+gypCGT8tVH9o14eATkGzGKCEiQAZ/4Zvo4GvqP3cZih5N/4HrQcevSiACTpR
         tHxMWITLNh7nmAx9E+5k3HUr0I0xzipSMZRgJzSP5+cVimfTO9sxHkWY+Xdlf6m68u5y
         t2JggqEp162eglDtxciOAlW4AN4kPjUK3OJSDA3sESGNh8tFimiohRZF/fXaGZiVE4V1
         Gg2Sey2scR4XAfoaSYSLXMtk+UNy7PxAdDhIZT4J3nOqYw7LBwXDzwxGSKPclhigc1Jy
         a+aD03lT3tJPHH3kOpA6uzeChBiTvzkIuPRiTzX37Vi3s6DbIIFaiehyqH/0b6C0XwNo
         xf9A==
X-Gm-Message-State: APjAAAUiAS9yhtmkd6vzvDQIf3lOuPCzNzbffDU5np5oyCFsjHRvk2F7
        hDx3o9QqmFe4TGXjX2oA6pzoLQ==
X-Google-Smtp-Source: APXvYqw8T4YnO6cWYWIIJcnC34eAvY38shlhSF9rcgw5hN8w/eUPE6JNCP2+VaqoLH0QgxrHKgRNUw==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr15615178wrv.52.1557694678203;
        Sun, 12 May 2019 13:57:58 -0700 (PDT)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id o81sm21483068wmb.2.2019.05.12.13.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 13:57:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] clk: meson: fix MPLL 50M binding id typo
Date:   Sun, 12 May 2019 22:57:43 +0200
Message-Id: <20190512205743.24131-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPLL_5OM (the capital letter o) should indeed be MPLL_50M (the number)
Fix this before it gets used.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Fixes: 25db146aa726 ("dt-bindings: clk: meson: add g12a periph clock controller bindings")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c              | 4 ++--
 drivers/clk/meson/g12a.h              | 2 +-
 include/dt-bindings/clock/g12a-clkc.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 739f64fdf1e3..206fafd299ea 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -2734,8 +2734,8 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_MALI_1_DIV]		= &g12a_mali_1_div.hw,
 		[CLKID_MALI_1]			= &g12a_mali_1.hw,
 		[CLKID_MALI]			= &g12a_mali.hw,
-		[CLKID_MPLL_5OM_DIV]		= &g12a_mpll_50m_div.hw,
-		[CLKID_MPLL_5OM]		= &g12a_mpll_50m.hw,
+		[CLKID_MPLL_50M_DIV]		= &g12a_mpll_50m_div.hw,
+		[CLKID_MPLL_50M]		= &g12a_mpll_50m.hw,
 		[CLKID_SYS_PLL_DIV16_EN]	= &g12a_sys_pll_div16_en.hw,
 		[CLKID_SYS_PLL_DIV16]		= &g12a_sys_pll_div16.hw,
 		[CLKID_CPU_CLK_DYN0_SEL]	= &g12a_cpu_clk_premux0.hw,
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 39c41af70804..bcc05cd9882f 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -166,7 +166,7 @@
 #define CLKID_HDMI_DIV				167
 #define CLKID_MALI_0_DIV			170
 #define CLKID_MALI_1_DIV			173
-#define CLKID_MPLL_5OM_DIV			176
+#define CLKID_MPLL_50M_DIV			176
 #define CLKID_SYS_PLL_DIV16_EN			178
 #define CLKID_SYS_PLL_DIV16			179
 #define CLKID_CPU_CLK_DYN0_SEL			180
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 82c9e0c020b2..e10470ed7c4f 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -130,7 +130,7 @@
 #define CLKID_MALI_1_SEL			172
 #define CLKID_MALI_1				174
 #define CLKID_MALI				175
-#define CLKID_MPLL_5OM				177
+#define CLKID_MPLL_50M				177
 #define CLKID_CPU_CLK				187
 #define CLKID_PCIE_PLL				201
 #define CLKID_VDEC_1				204
-- 
2.20.1

