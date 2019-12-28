Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 22:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB1208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 22:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOTcxs6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL1W0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 17:26:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40570 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1W0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 17:26:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so23001088lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4odryGlLMKaPYu/ipPOfQOTgdveBEZs6ZlVUpsw7H2c=;
        b=WOTcxs6eXxi+JsOSx0kOoYyw0U+9N5NkSAB6B02EWiiH9SUEcaWn94Q+ZD69SIK7R+
         ZKQ6D9jFqZKWWP0zsKgX8UApzi6MSH0xX656AJaCtXIXy8g//t3LgJu5KUJL1FJyx5ht
         liN4boz0AIGvHuZncePNOI8Qxt/t2CwHs30DdWghHMPVhB5IdPy3mkuzdca2agtWQnGw
         mENRtZz1sGeryAVxsLQTzDtYKmfGD32ugziJpBVCeiz3ieRyLRb0nEOYHCUNJJNa4BFn
         tfeGZzreFnAE6MMW0m3Mw9HKD6S93YQbO8yrHjNwdw+iUMEyoG6S10RX5AzNKzZ9sm1m
         Niew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4odryGlLMKaPYu/ipPOfQOTgdveBEZs6ZlVUpsw7H2c=;
        b=GKuvvQmTXxXh2tcvSzWD8qemH0Vi1Ipn/UkSG6XsOZArmJ+7kOyl9LBuqV6vYtMzH6
         9vrG8uVmZV970QWw2ZWAUzA9mc9ADS189Iqdaqbz5wMR87eelP7E6C488m6DdH7gYhw0
         v9PtHEmuCO0mxG8AB0ZdCqBkqgPFkYL+JGe9yDPCz2ntrbbWf0byMaVxgv4YnFunfsIa
         Y/b5tcuU2Qk5pak+VYM0+jmw0bcUbNXza/WjjL7cIWXXzZ+1K0rX/3l/Ft2o/4uhihCh
         EC2qhP24LdonmpbPPSJuoHMdMJ42DMcP6z07UtCtd8hwWK2rzc8VovbNcfGuxTKgrXmc
         JiMQ==
X-Gm-Message-State: APjAAAUMo8OslV9tdNA3ucEFrQSUB/2Ti/bxeAUQ1WFQjcYuESTrTUEh
        GV5xq4jzvYrMZtWgRawEcxmT6J41K8E=
X-Google-Smtp-Source: APXvYqyfCwEOGCAdhi1hQd2i8VOQIGQDyfFHddSRQEQ1w+JkzGEs5w0lKyX/lJTYvJEJd25kfzdJag==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr31852739lfn.95.1577571981672;
        Sat, 28 Dec 2019 14:26:21 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id x4sm13907371ljb.66.2019.12.28.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 14:26:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mfd: dbx500-prcmu: Drop set_display_clocks()
Date:   Sat, 28 Dec 2019 23:26:14 +0100
Message-Id: <20191228222615.24189-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display clocks are handled by the generic clock framework
since ages, this code is completely unused and misleading.
Delete it.

Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c       | 30 ------------------------------
 include/linux/mfd/db8500-prcmu.h |  6 ------
 include/linux/mfd/dbx500-prcmu.h | 10 ----------
 3 files changed, 46 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 26d967a1a046..5f0cfeec8b6a 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -555,14 +555,6 @@ static struct dsiescclk dsiescclk[3] = {
 #define PRCMU_CLK_38_SRC		(1 << 10)
 #define PRCMU_CLK_38_DIV		(1 << 11)
 
-/* PLLDIV=12, PLLSW=4 (PLLDDR) */
-#define PRCMU_DSI_CLOCK_SETTING		0x0000008C
-
-/* DPI 50000000 Hz */
-#define PRCMU_DPI_CLOCK_SETTING		((1 << PRCMU_CLK_PLL_SW_SHIFT) | \
-					  (16 << PRCMU_CLK_PLL_DIV_SHIFT))
-#define PRCMU_DSI_LP_CLOCK_SETTING	0x00000E00
-
 /* D=101, N=1, R=4, SELDIV2=0 */
 #define PRCMU_PLLDSI_FREQ_SETTING	0x00040165
 
@@ -616,28 +608,6 @@ int db8500_prcmu_disable_dsipll(void)
 	return 0;
 }
 
-int db8500_prcmu_set_display_clocks(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clk_mgt_lock, flags);
-
-	/* Grab the HW semaphore. */
-	while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
-		cpu_relax();
-
-	writel(PRCMU_DSI_CLOCK_SETTING, prcmu_base + PRCM_HDMICLK_MGT);
-	writel(PRCMU_DSI_LP_CLOCK_SETTING, prcmu_base + PRCM_TVCLK_MGT);
-	writel(PRCMU_DPI_CLOCK_SETTING, prcmu_base + PRCM_LCDCLK_MGT);
-
-	/* Release the HW semaphore. */
-	writel(0, PRCM_SEM);
-
-	spin_unlock_irqrestore(&clk_mgt_lock, flags);
-
-	return 0;
-}
-
 u32 db8500_prcmu_read(unsigned int reg)
 {
 	return readl(prcmu_base + reg);
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 1fc75d2b4a38..7d0c442e0c25 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -525,7 +525,6 @@ u8 db8500_prcmu_get_power_state_result(void);
 void db8500_prcmu_enable_wakeups(u32 wakeups);
 int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
 int db8500_prcmu_request_clock(u8 clock, bool enable);
-int db8500_prcmu_set_display_clocks(void);
 int db8500_prcmu_disable_dsipll(void);
 int db8500_prcmu_enable_dsipll(void);
 void db8500_prcmu_config_abb_event_readout(u32 abb_events);
@@ -682,11 +681,6 @@ static inline int db8500_prcmu_request_clock(u8 clock, bool enable)
 	return 0;
 }
 
-static inline int db8500_prcmu_set_display_clocks(void)
-{
-	return 0;
-}
-
 static inline int db8500_prcmu_disable_dsipll(void)
 {
 	return 0;
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index e2571040c7e8..812b6c3c4ef6 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -321,11 +321,6 @@ static inline bool prcmu_is_ac_wake_requested(void)
 	return db8500_prcmu_is_ac_wake_requested();
 }
 
-static inline int prcmu_set_display_clocks(void)
-{
-	return db8500_prcmu_set_display_clocks();
-}
-
 static inline int prcmu_disable_dsipll(void)
 {
 	return db8500_prcmu_disable_dsipll();
@@ -511,11 +506,6 @@ static inline bool prcmu_is_ac_wake_requested(void)
 	return false;
 }
 
-static inline int prcmu_set_display_clocks(void)
-{
-	return 0;
-}
-
 static inline int prcmu_disable_dsipll(void)
 {
 	return 0;
-- 
2.21.0

