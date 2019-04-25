Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD83C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4542320678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpt/0gZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfDYMzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:55:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41973 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbfDYMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:55:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so11139634pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8wBY4DrJYGHWrcFUmZjiCL1GZae6MKSXg88kMv8qUJs=;
        b=kpt/0gZ4WrV9SiGhJ7LUvRdANxf1yoZCJH59nBxbGmEN87lgZU0zmDaK0zbjhO7BLG
         utf6gA5paYqhvOPoQZULRLLHoxbGrpcyjoo0Srwg28SpomupgdlyfEaGXKM4E4WWPzMD
         d9vSpUAbWJzG7yM6wfKaL7fMtHgfuZMBGLtOUYvGF0YHuMDzBWmPxOPVH8Hch8x0pxU8
         8FceKSLo+h0ie0C2V3G3NuCXwi9y66ENXD9yCaoeg07jiJWERnqUDi116toaFfMHz+a7
         Snx7/z1M4B+tBKqT+ijdrEWcYvU7/UgzI0eA7GMb40edMPbxfit+kG2Xmf5VhDmE+TJF
         QB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8wBY4DrJYGHWrcFUmZjiCL1GZae6MKSXg88kMv8qUJs=;
        b=fuIxkGjEsMEteivHCJstfNsUO6cNFoXGF6/Wmev01pW4rrGUw708YTXIsPwCrKOU9i
         HgbAypgSj94HvQdqd0NAh+DIXAlSvO58mPXCoBTzlLIXcEdVY5G5qtqD/xjx3SmBcdG9
         HwmzHtuzcfubRd27mNyK+cxGyh0+bjCMGJjIZ/ZgDKgHAGw3rdNvHxZQHc3hL0wd+Z9r
         gTXoBZy1HmO6MfOu/cSrKS/OTHxxLaifl+gg4Ro7J5NiHF1Ld0ns8d3VMrcEsUJdAvHN
         qIcxK+sYJ52v0t374m70sQA80DPkLHM9cyIchtya3zp3zsEmwlh8Wu4CPmhGvg9r1/kb
         wHaQ==
X-Gm-Message-State: APjAAAViDQIPEG9+4u3ha8B1WeFTTmp+hWpIhdH7lQ4UvtF/afYQfdg4
        nX/rgUhYYr8U7MDUk+xDosy5
X-Google-Smtp-Source: APXvYqyPIJF3zDHkGAEdm0iGkdPvkVHpZBxI2K3JRs3H0bNIISQV2X9u90OtMSmDvc6PyZrREiH43w==
X-Received: by 2002:a65:424d:: with SMTP id d13mr37022632pgq.318.1556196931990;
        Thu, 25 Apr 2019 05:55:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id c18sm50507983pfc.0.2019.04.25.05.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:55:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] reset: Add reset controller support for BM1880 SoC
Date:   Thu, 25 Apr 2019 18:25:08 +0530
Message-Id: <20190425125508.5965-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
References: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for Bitmain BM1880 SoC reusing the
reset-simple driver. While we are at it, this driver has also been
modified to make use of the SPDX license identifier.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/Kconfig        |  3 ++-
 drivers/reset/Makefile       |  1 +
 drivers/reset/reset-simple.c | 16 +++++++++++-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2c8c23db92fb..b25e8d139f0d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -117,7 +117,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -129,6 +129,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - Bitmain BM1880 SoC
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 61456b8f659c..b87968771166 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+#obj-$(CONFIG_RESET_BM1880) += reset-bm1880.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 77fbba3100c8..fd1fa4984d76 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Simple Reset Controller Driver
  *
@@ -8,11 +9,6 @@
  * Copyright 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/device.h>
@@ -119,6 +115,14 @@ static const struct reset_simple_devdata reset_simple_active_low = {
 	.status_active_low = true,
 };
 
+#define BM1880_NR_BANKS		2
+
+static const struct reset_simple_devdata reset_simple_bm1880 = {
+	.nr_resets = BM1880_NR_BANKS * 32,
+	.active_low = true,
+	.status_active_low = true,
+};
+
 static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "altr,stratix10-rst-mgr",
 		.data = &reset_simple_socfpga },
@@ -129,6 +133,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "aspeed,ast2400-lpc-reset" },
 	{ .compatible = "aspeed,ast2500-lpc-reset" },
+	{ .compatible = "bitmain,bm1880-reset",
+		.data = &reset_simple_bm1880 },
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

