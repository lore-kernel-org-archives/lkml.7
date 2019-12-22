Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E0C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F96206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP7mfRM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLVU1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:27:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33717 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLVU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:27:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so11117236lfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 12:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/XhSv9rcF0XWmB/OEE0N6v1jyA2bXv8OJQMzsw7bGY=;
        b=QP7mfRM0SFh4sSHhwTjky3RtPOPheJZMTGoxFL0N9x2HHtYfJWngVjbpVYFa+o5H1c
         AWgszBEdGZHtdQ8ReL4ZZCGyJ+CB3IozFrk23ZNzhusRSefmqaIA8iM/CRNXqxcT4viQ
         QraMPV5mtLAz6882ctaXgv/fft14e4P/XOCY0PIF9SMra6SC3yzyi5rLculbJ+MqV7Nm
         fbSQY4oAwVuHURNuBlxQqc807pcO1L3GJe3Rd2de0aGmKjBwuEKpUhkrDUrqe2DI462q
         bYj0424tC4Uh//TC5EbTfw/tAo9xHsZrA8o5Fg9gCltOVOx2aCLZLSQwopeb0fZRiC+P
         zu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/XhSv9rcF0XWmB/OEE0N6v1jyA2bXv8OJQMzsw7bGY=;
        b=AOMv/XOPHl8HHq1RVNZI9hxLSLbKLjkz8kon+fXcMKNN3hY2x0NwwQuRjKTlieVPbh
         8Pc7z35szGsJNwdpwdBjKQ5xzoIykUnGgjprKVzqWas+1lxr08V2sxQQcBlBpn9zWVIJ
         HyEflKXbRlubmLCvrW04jAFKxDjGDGwB/v2YiIyuSaRBXWU5f83z4XVhex7mhU3ISVNG
         wSvgTNr9+mCFjRZT5wCWOipa/Qtj+ty7kS12gN7nAO21iNiD1vGdZSUYHxj8sFWRBvgV
         hqWWWbL3vAUveN2oKi8J7Xr0l+InH05/mKCqOionnzQnyIbE3lU/bPMvh+jdeDF1jV4p
         A26A==
X-Gm-Message-State: APjAAAVeXJxfeIaqgaXZZwN1tZSbgKAuNVVpD0O4MHFf6mXvFyccL1VM
        xoh2GlTJN0GGd7CLCFNS7JYqQg==
X-Google-Smtp-Source: APXvYqzQP4hMfNCXGexX5epfV4aL5IaGmMqV+BEo87o/ZPrmezKrOQhY0NuOdqdaB4qqj9p763Pa4A==
X-Received: by 2002:a19:5f05:: with SMTP id t5mr15013827lfb.149.1577046460055;
        Sun, 22 Dec 2019 12:27:40 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id i17sm5775449ljd.34.2019.12.22.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 12:27:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] mfd: db8500-prcmu: Fix DSI LP clock
Date:   Sun, 22 Dec 2019 21:27:35 +0100
Message-Id: <20191222202735.13910-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DB8420 sysclk firmware is missing the ULPPLL
(ultra-low power phase locked loop) which has repercussions
on how the DSI LP clock is handled in the PRCMU driver.
This was missed in the patch adding support for the U8420
sysclk firmware variant.

Move the functions around a bit to avoid forward declarations.

This fix is not a regression as no systems in the kernel are
currently using it.

Cc: Stephan Gerhold <stephan@gerhold.net>
Fixes: 22fb3ad0cc5f ("mfd: db8500-prcmu: Support U8420-sysclk firmware")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 26d967a1a046..8aa701f81a08 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -561,7 +561,8 @@ static struct dsiescclk dsiescclk[3] = {
 /* DPI 50000000 Hz */
 #define PRCMU_DPI_CLOCK_SETTING		((1 << PRCMU_CLK_PLL_SW_SHIFT) | \
 					  (16 << PRCMU_CLK_PLL_DIV_SHIFT))
-#define PRCMU_DSI_LP_CLOCK_SETTING	0x00000E00
+#define PRCMU_DSI_LP_CLOCK_SETTING_ULPPLL_ON	0x00000E00
+#define PRCMU_DSI_LP_CLOCK_SETTING_ULPPLL_OFF	0x00000A00
 
 /* D=101, N=1, R=4, SELDIV2=0 */
 #define PRCMU_PLLDSI_FREQ_SETTING	0x00040165
@@ -577,6 +578,19 @@ static struct dsiescclk dsiescclk[3] = {
 
 #define PRCMU_PLLDSI_LOCKP_LOCKED	0x3
 
+struct prcmu_fw_version *prcmu_get_fw_version(void)
+{
+	return fw_info.valid ? &fw_info.version : NULL;
+}
+
+static bool prcmu_is_ulppll_disabled(void)
+{
+	struct prcmu_fw_version *ver;
+
+	ver = prcmu_get_fw_version();
+	return ver && ver->project == PRCMU_FW_PROJECT_U8420_SYSCLK;
+}
+
 int db8500_prcmu_enable_dsipll(void)
 {
 	int i;
@@ -627,7 +641,10 @@ int db8500_prcmu_set_display_clocks(void)
 		cpu_relax();
 
 	writel(PRCMU_DSI_CLOCK_SETTING, prcmu_base + PRCM_HDMICLK_MGT);
-	writel(PRCMU_DSI_LP_CLOCK_SETTING, prcmu_base + PRCM_TVCLK_MGT);
+	if (prcmu_is_ulppll_disabled())
+		writel(PRCMU_DSI_LP_CLOCK_SETTING_ULPPLL_OFF, prcmu_base + PRCM_TVCLK_MGT);
+	else
+		writel(PRCMU_DSI_LP_CLOCK_SETTING_ULPPLL_ON, prcmu_base + PRCM_TVCLK_MGT);
 	writel(PRCMU_DPI_CLOCK_SETTING, prcmu_base + PRCM_LCDCLK_MGT);
 
 	/* Release the HW semaphore. */
@@ -664,19 +681,6 @@ void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value)
 	spin_unlock_irqrestore(&prcmu_lock, flags);
 }
 
-struct prcmu_fw_version *prcmu_get_fw_version(void)
-{
-	return fw_info.valid ? &fw_info.version : NULL;
-}
-
-static bool prcmu_is_ulppll_disabled(void)
-{
-	struct prcmu_fw_version *ver;
-
-	ver = prcmu_get_fw_version();
-	return ver && ver->project == PRCMU_FW_PROJECT_U8420_SYSCLK;
-}
-
 bool prcmu_has_arm_maxopp(void)
 {
 	return (readb(tcdm_base + PRCM_AVS_VARM_MAX_OPP) &
-- 
2.21.0

