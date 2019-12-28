Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5537C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D1208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 22:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2r/adkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL1W0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 17:26:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44348 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1W0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 17:26:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so29990094lje.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsV2ohgja1UBSOB/1OLWi1O0UVxip0BHsHDIY7viOWE=;
        b=j2r/adkc/sY/ZcQkr/AmvmPTNIWQKWeQLAZsB3dBQm+LZXc1a9SvsIWZvCjl+AY0p8
         XSWy+Uz6oByPS1++iDRij13fzYsAgYvBh/NRt+a3+Btrbtfog/tJStkYKUW8kuNTFIQc
         ktZiPu1vgoEKV53EjBopPe2X/4vnwKyAOIjNcF2KzoULG/yA2P/TIYBJ7KcNzyIXXSeC
         qNCJMfW/S6PE22jFPmrPH85b+izt6V0OWmHPipLjiA1xAJ6uNzh8siu1WuBr36pM74FD
         oikFCdkMo8ctG85z9d4B1jKcq8uzytWETOdtECiYJLjzi02PRur9dPxxAHgMIr35rgK5
         QXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsV2ohgja1UBSOB/1OLWi1O0UVxip0BHsHDIY7viOWE=;
        b=qthSrf8FeqjRnB35fC9SGbq6D+MNJSuMPh5/hioKqUglN8SuM0t8rBUq49lQJ6Rfxe
         RxN8aIVjY9/hdOwMOFo8FPOdqwTtI6Ms9h6nzCiu3LAURcC79f2LcVTop93uw+aGjaQD
         FSHwf7LEXsKfkRRK6htmf08G2Toa2UFiaxwmvXAwV5DwHmtU+MZED7F8xqYYMxG9ePf8
         /gDilleesG5QrquqollUco1qSHQKSYpXeFQxv4y9mp3oLrmvsVq/cVX2mYnH788KmfyJ
         GpSHl31mbPZ0wWCfa+mOGqRSUMirIG95x3lIajEHSnxXL9r8AUEHzjWYRXw6+j9C4v/K
         hsxw==
X-Gm-Message-State: APjAAAV5z5Fyck6qkbe1OrFkmccC/6PyxOsmZ5lpZufwXyIJemlhzYYi
        a9DL77trI5aIdRbgqnkSQvAKiA==
X-Google-Smtp-Source: APXvYqzGYw38XlMp64PEbR+ADEOSin6f1lDnUw81i2uhV2Q+HPQq74o9pMW5XnK7uNOGE9fOBHp1JQ==
X-Received: by 2002:a2e:3005:: with SMTP id w5mr32605372ljw.184.1577571983594;
        Sat, 28 Dec 2019 14:26:23 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id x4sm13907371ljb.66.2019.12.28.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 14:26:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mfd: dbx500-prcmu: Drop DSI pll clock functions
Date:   Sat, 28 Dec 2019 23:26:15 +0100
Message-Id: <20191228222615.24189-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191228222615.24189-1-linus.walleij@linaro.org>
References: <20191228222615.24189-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI PLLs are handled by the generic clock framework
since ages, this code is completely unused and misleading.
Delete it.

Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c       | 66 --------------------------------
 include/linux/mfd/db8500-prcmu.h | 12 ------
 include/linux/mfd/dbx500-prcmu.h | 20 ----------
 3 files changed, 98 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5f0cfeec8b6a..0452b43b0423 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -542,72 +542,6 @@ static struct dsiescclk dsiescclk[3] = {
 	}
 };
 
-
-/*
-* Used by MCDE to setup all necessary PRCMU registers
-*/
-#define PRCMU_RESET_DSIPLL		0x00004000
-#define PRCMU_UNCLAMP_DSIPLL		0x00400800
-
-#define PRCMU_CLK_PLL_DIV_SHIFT		0
-#define PRCMU_CLK_PLL_SW_SHIFT		5
-#define PRCMU_CLK_38			(1 << 9)
-#define PRCMU_CLK_38_SRC		(1 << 10)
-#define PRCMU_CLK_38_DIV		(1 << 11)
-
-/* D=101, N=1, R=4, SELDIV2=0 */
-#define PRCMU_PLLDSI_FREQ_SETTING	0x00040165
-
-#define PRCMU_ENABLE_PLLDSI		0x00000001
-#define PRCMU_DISABLE_PLLDSI		0x00000000
-#define PRCMU_RELEASE_RESET_DSS		0x0000400C
-#define PRCMU_DSI_PLLOUT_SEL_SETTING	0x00000202
-/* ESC clk, div0=1, div1=1, div2=3 */
-#define PRCMU_ENABLE_ESCAPE_CLOCK_DIV	0x07030101
-#define PRCMU_DISABLE_ESCAPE_CLOCK_DIV	0x00030101
-#define PRCMU_DSI_RESET_SW		0x00000007
-
-#define PRCMU_PLLDSI_LOCKP_LOCKED	0x3
-
-int db8500_prcmu_enable_dsipll(void)
-{
-	int i;
-
-	/* Clear DSIPLL_RESETN */
-	writel(PRCMU_RESET_DSIPLL, PRCM_APE_RESETN_CLR);
-	/* Unclamp DSIPLL in/out */
-	writel(PRCMU_UNCLAMP_DSIPLL, PRCM_MMIP_LS_CLAMP_CLR);
-
-	/* Set DSI PLL FREQ */
-	writel(PRCMU_PLLDSI_FREQ_SETTING, PRCM_PLLDSI_FREQ);
-	writel(PRCMU_DSI_PLLOUT_SEL_SETTING, PRCM_DSI_PLLOUT_SEL);
-	/* Enable Escape clocks */
-	writel(PRCMU_ENABLE_ESCAPE_CLOCK_DIV, PRCM_DSITVCLK_DIV);
-
-	/* Start DSI PLL */
-	writel(PRCMU_ENABLE_PLLDSI, PRCM_PLLDSI_ENABLE);
-	/* Reset DSI PLL */
-	writel(PRCMU_DSI_RESET_SW, PRCM_DSI_SW_RESET);
-	for (i = 0; i < 10; i++) {
-		if ((readl(PRCM_PLLDSI_LOCKP) & PRCMU_PLLDSI_LOCKP_LOCKED)
-					== PRCMU_PLLDSI_LOCKP_LOCKED)
-			break;
-		udelay(100);
-	}
-	/* Set DSIPLL_RESETN */
-	writel(PRCMU_RESET_DSIPLL, PRCM_APE_RESETN_SET);
-	return 0;
-}
-
-int db8500_prcmu_disable_dsipll(void)
-{
-	/* Disable dsi pll */
-	writel(PRCMU_DISABLE_PLLDSI, PRCM_PLLDSI_ENABLE);
-	/* Disable  escapeclock */
-	writel(PRCMU_DISABLE_ESCAPE_CLOCK_DIV, PRCM_DSITVCLK_DIV);
-	return 0;
-}
-
 u32 db8500_prcmu_read(unsigned int reg)
 {
 	return readl(prcmu_base + reg);
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 7d0c442e0c25..4b63d3ecdcff 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -525,8 +525,6 @@ u8 db8500_prcmu_get_power_state_result(void);
 void db8500_prcmu_enable_wakeups(u32 wakeups);
 int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
 int db8500_prcmu_request_clock(u8 clock, bool enable);
-int db8500_prcmu_disable_dsipll(void);
-int db8500_prcmu_enable_dsipll(void);
 void db8500_prcmu_config_abb_event_readout(u32 abb_events);
 void db8500_prcmu_get_abb_event_buffer(void __iomem **buf);
 int db8500_prcmu_config_esram0_deep_sleep(u8 state);
@@ -681,16 +679,6 @@ static inline int db8500_prcmu_request_clock(u8 clock, bool enable)
 	return 0;
 }
 
-static inline int db8500_prcmu_disable_dsipll(void)
-{
-	return 0;
-}
-
-static inline int db8500_prcmu_enable_dsipll(void)
-{
-	return 0;
-}
-
 static inline int db8500_prcmu_config_esram0_deep_sleep(u8 state)
 {
 	return 0;
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 812b6c3c4ef6..e6ee2ec35de9 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -321,16 +321,6 @@ static inline bool prcmu_is_ac_wake_requested(void)
 	return db8500_prcmu_is_ac_wake_requested();
 }
 
-static inline int prcmu_disable_dsipll(void)
-{
-	return db8500_prcmu_disable_dsipll();
-}
-
-static inline int prcmu_enable_dsipll(void)
-{
-	return db8500_prcmu_enable_dsipll();
-}
-
 static inline int prcmu_config_esram0_deep_sleep(u8 state)
 {
 	return db8500_prcmu_config_esram0_deep_sleep(state);
@@ -506,16 +496,6 @@ static inline bool prcmu_is_ac_wake_requested(void)
 	return false;
 }
 
-static inline int prcmu_disable_dsipll(void)
-{
-	return 0;
-}
-
-static inline int prcmu_enable_dsipll(void)
-{
-	return 0;
-}
-
 static inline int prcmu_config_esram0_deep_sleep(u8 state)
 {
 	return 0;
-- 
2.21.0

