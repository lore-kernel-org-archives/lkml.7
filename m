Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D5CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B89C2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoIZo3iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfDTLFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:05:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35690 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDTLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:05:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so3752045pgf.2;
        Sat, 20 Apr 2019 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h1jXrIbit+dYjQzQSUAYPMVEDnUNdJL6nOFserWACyM=;
        b=MoIZo3iWYzDWeseG7VZ90apiX/GlTFEcRQHrKJjv7t1gINeFSrbPWRLGrJkB14aK6N
         cKa7BZ1DfMM02N8iuqKEn0q/OR4LGYD0vZ2XT0J6uQ1qAwKYtskSXcP8GgK3Xn1Veh1i
         Km0oUFQMxtkK+EGWLRJ29mQvi1zCXBf4GMwhnDW9WdmRqcBCuiyCQrztqFHSz3nh5DW1
         ctrXygQvIWJ3daDgvZ0YDOcdQe4qcHY+8Frv/mctGhnLWvFcn3Dqgkbm2xu/R30T9dn/
         +7OL4y+7o+2hTntRKChs2SVXc0E4n1x5GRduuu5ejWiRYCbugnI47vdX15Cu++C/ZMkz
         qD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h1jXrIbit+dYjQzQSUAYPMVEDnUNdJL6nOFserWACyM=;
        b=KXhs8gyLgYTqVVexqSG0SJMtoc2oyhNvyQ82LfunT/9NGoNt93q0ftbp0PrYXtHP8j
         60Kcr/CZ8JUo0i5o51zbL9kLMvTF87eBLJgUu6Hv9goLtngpPO7bMCRkXsjIFQDLJiQc
         o8TU/ghz5nC83kHrwuLC8VTh+L0Z+lOnGKVVy20fDrA22QpPJ6OEntEk0gcsbbGieFFq
         hABydFCrvn7Gwm0R1QJlgnsZruF2FShY4Njz4drc0oeIrzcR4rYDWYmD/D/bnzSxrNaG
         x/3nKPOGcqMkJhGdSWAqWsVkUWo+8ZZBJeec9xtXPN8Xa7L3EPNP0bUxgvwLFkacx6+d
         C0uw==
X-Gm-Message-State: APjAAAX+F0WoFNUr/qf5CNATAIiIP8KZj2cAOVHKQnEOadMK3SAQ/IWo
        P2XHUGwCxWGa2Gk4whbxAx4=
X-Google-Smtp-Source: APXvYqzJTyhmBzxKgNso72TAsSJcB3KrkQMwHnyG3T4K2VmtOpAfsTI2+qoXUmqaF/R5Sg84zUk1Ag==
X-Received: by 2002:a63:b03:: with SMTP id 3mr8820658pgl.267.1555758315262;
        Sat, 20 Apr 2019 04:05:15 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id t12sm13755263pfl.59.2019.04.20.04.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 04:05:14 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        slongerbeam@gmail.com, p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, sakari.ailus@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: media: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 11:04:07 +0000
Message-Id: <20190420110407.20215-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/media/Kconfig          | 2 +-
 drivers/staging/media/bcm2048/Kconfig  | 2 +-
 drivers/staging/media/imx/Kconfig      | 4 ++--
 drivers/staging/media/ipu3/Kconfig     | 2 +-
 drivers/staging/media/omap4iss/Kconfig | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index 1da5c20d65c0..277df2b39384 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -1,7 +1,7 @@
 menuconfig STAGING_MEDIA
 	bool "Media staging drivers"
 	default n
-	---help---
+	help
 	  This option allows you to select a number of media drivers that
 	  don't have the "normal" Linux kernel quality level.
 	  Most of them don't follow properly the V4L, DVB and/or RC API's,
diff --git a/drivers/staging/media/bcm2048/Kconfig b/drivers/staging/media/bcm2048/Kconfig
index a9fc6e186494..a1526175eccb 100644
--- a/drivers/staging/media/bcm2048/Kconfig
+++ b/drivers/staging/media/bcm2048/Kconfig
@@ -5,7 +5,7 @@
 config I2C_BCM2048
 	tristate "Broadcom BCM2048 FM Radio Receiver support"
 	depends on I2C && VIDEO_V4L2 && RADIO_ADAPTERS
-	---help---
+	help
 	  Say Y here if you want support to BCM2048 FM Radio Receiver.
 	  This device driver supports only i2c bus.
 
diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 36b276ea2ecc..f6d220b649fb 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -6,7 +6,7 @@ config VIDEO_IMX_MEDIA
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
-	---help---
+	help
 	  Say yes here to enable support for video4linux media controller
 	  driver for the i.MX5/6 SOC.
 
@@ -17,7 +17,7 @@ config VIDEO_IMX_CSI
 	tristate "i.MX5/6 Camera Sensor Interface driver"
 	depends on VIDEO_IMX_MEDIA && VIDEO_DEV && I2C
 	default y
-	---help---
+	help
 	  A video4linux camera sensor interface driver for i.MX5/6.
 
 config VIDEO_IMX7_CSI
diff --git a/drivers/staging/media/ipu3/Kconfig b/drivers/staging/media/ipu3/Kconfig
index 75cd889f18f7..d5e50f88684a 100644
--- a/drivers/staging/media/ipu3/Kconfig
+++ b/drivers/staging/media/ipu3/Kconfig
@@ -5,7 +5,7 @@ config VIDEO_IPU3_IMGU
 	depends on X86
 	select IOMMU_IOVA
 	select VIDEOBUF2_DMA_SG
-	---help---
+	help
 	  This is the Video4Linux2 driver for Intel IPU3 image processing unit,
 	  found in Intel Skylake and Kaby Lake SoCs and used for processing
 	  images and video.
diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
index 841cc0b3ce13..4dcbc5065821 100644
--- a/drivers/staging/media/omap4iss/Kconfig
+++ b/drivers/staging/media/omap4iss/Kconfig
@@ -6,5 +6,5 @@ config VIDEO_OMAP4
 	depends on ARCH_OMAP4 || COMPILE_TEST
 	select MFD_SYSCON
 	select VIDEOBUF2_DMA_CONTIG
-	---help---
+	help
 	  Driver for an OMAP 4 ISS controller.
-- 
2.11.0

