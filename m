Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BEAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7185C20675
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb4cj7iI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfDTLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:24:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32913 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfDTLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:24:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so3716329plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JfSjJDNwm9Ha6yotI6B7MsInAjx3v+q2Ek9jeGHkFUQ=;
        b=Sb4cj7iIJZ1LbeGLALe6MTLZM4hnNY8zNBWV+W0rJjaAbyeCFzU0hh2w+VYZEzgIyy
         XRJpl83GFoAZFM81BaWQZAcSoba6YxFQn6+dW0QQBLOYBjN3DTPiHWZgxBDux7XviJco
         OxrLJxhVZdvrQrDjxLv5fnQS9sAkHAnVhEbZuiwq9pvFjJVft+e2HtpshDmU563Zt95h
         V6GsixrG+BgjiSe58VWpEIbDxT22hLmfmimcuwxzvJqkXpMo2UlTFchJWwHEoap5F4VR
         b2PzgEDmNq1IbFrzdtg6wG2PRMtiSzv22nGbYVlIhCMTvisaJgE9a21fH/X1XOx0N6b0
         a/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JfSjJDNwm9Ha6yotI6B7MsInAjx3v+q2Ek9jeGHkFUQ=;
        b=hcmX32mvZ3i7GN3CQSCtX/G/ehp1vcCbtrHgQe5NNa6zxtnCWrfl7jgqFF6v29s2je
         95HepmhLsAVV0qSV9KKKfkagr5kND+A72KN7AF6GJDNQHusIPUJVkn+V1gtz2b3pktFC
         wg/CG6vCxp7A2bLteOgaA5LsflaGPBeFyGGvPkNITYX0QTKTQpl/I0lpL8T/iDTnhG8X
         //aBHls8ClMNNZReKhvZ5R5jAX/upKIGKB2Tl0AyyGFwtx3rPwU0ErOjQ9Ro+wRCdDj3
         eAR3/WB92onR/h2x3zO8fyR189h5L8m8ThZqUJTVvow113RBMci4TgK24TZETna7KCbI
         F+PQ==
X-Gm-Message-State: APjAAAXrUAGTjt4t1blPByIDZwoRP2HXEDcLTduI2MH0lQGSmpwQj14Q
        mqY4QajU2q2/nURq03ubLRA=
X-Google-Smtp-Source: APXvYqxxl+iZ4qbJKF5CV1BIaOs/XMLA5itssv5In0rMvqqsfEgWBXWjOTJQF62xsc4G/76L7lXoBg==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr9236870pla.78.1555759456902;
        Sat, 20 Apr 2019 04:24:16 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id r145sm21073325pgr.84.2019.04.20.04.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 04:24:16 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: most: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 11:24:08 +0000
Message-Id: <20190420112408.23359-1-moseschristopherb@gmail.com>
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
 drivers/staging/most/Kconfig       | 2 +-
 drivers/staging/most/cdev/Kconfig  | 2 +-
 drivers/staging/most/dim2/Kconfig  | 2 +-
 drivers/staging/most/i2c/Kconfig   | 2 +-
 drivers/staging/most/net/Kconfig   | 2 +-
 drivers/staging/most/sound/Kconfig | 2 +-
 drivers/staging/most/usb/Kconfig   | 2 +-
 drivers/staging/most/video/Kconfig | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 20047abbe560..09d2e1ee3388 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -2,7 +2,7 @@ menuconfig MOST
         tristate "MOST support"
 	depends on HAS_DMA
         default n
-        ---help---
+        help
 	  Say Y here if you want to enable MOST support.
 	  This driver needs at least one additional component to enable the
 	  desired access from userspace (e.g. character devices) and one that
diff --git a/drivers/staging/most/cdev/Kconfig b/drivers/staging/most/cdev/Kconfig
index 2b04e26bcbea..2e27e1fce58d 100644
--- a/drivers/staging/most/cdev/Kconfig
+++ b/drivers/staging/most/cdev/Kconfig
@@ -5,7 +5,7 @@
 config MOST_CDEV
 	tristate "Cdev"
 
-	---help---
+	help
 	  Say Y here if you want to commumicate via character devices.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/most/dim2/Kconfig b/drivers/staging/most/dim2/Kconfig
index 5aeef22c3cba..ce9da9180056 100644
--- a/drivers/staging/most/dim2/Kconfig
+++ b/drivers/staging/most/dim2/Kconfig
@@ -6,7 +6,7 @@ config MOST_DIM2
 	tristate "DIM2"
 	depends on HAS_IOMEM && OF
 
-	---help---
+	help
 	  Say Y here if you want to connect via MediaLB to network transceiver.
 	  This device driver is platform dependent and needs an additional
 	  platform driver to be installed. For more information contact
diff --git a/drivers/staging/most/i2c/Kconfig b/drivers/staging/most/i2c/Kconfig
index 79d0ff27f56d..f723f99711bd 100644
--- a/drivers/staging/most/i2c/Kconfig
+++ b/drivers/staging/most/i2c/Kconfig
@@ -5,7 +5,7 @@
 config MOST_I2C
 	tristate "I2C"
 	depends on I2C
-	---help---
+	help
 	  Say Y here if you want to connect via I2C to network tranceiver.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/most/net/Kconfig b/drivers/staging/most/net/Kconfig
index 795330ba94ef..28040931f7e7 100644
--- a/drivers/staging/most/net/Kconfig
+++ b/drivers/staging/most/net/Kconfig
@@ -6,7 +6,7 @@ config MOST_NET
 	tristate "Net"
 	depends on NET
 
-	---help---
+	help
 	  Say Y here if you want to commumicate via a networking device.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/most/sound/Kconfig b/drivers/staging/most/sound/Kconfig
index 115262a58a42..5614a999b54e 100644
--- a/drivers/staging/most/sound/Kconfig
+++ b/drivers/staging/most/sound/Kconfig
@@ -6,7 +6,7 @@ config MOST_SOUND
 	tristate "Sound"
 	depends on SND
 	select SND_PCM
-	---help---
+	help
 	  Say Y here if you want to commumicate via ALSA/sound devices.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/staging/most/usb/Kconfig b/drivers/staging/most/usb/Kconfig
index ebbdb573a9a6..539b38fb3d88 100644
--- a/drivers/staging/most/usb/Kconfig
+++ b/drivers/staging/most/usb/Kconfig
@@ -5,7 +5,7 @@
 config MOST_USB
 	tristate "USB"
 	depends on USB && NET
-	---help---
+	help
 	  Say Y here if you want to connect via USB to network tranceiver.
 	  This device driver depends on the networking AIM.
 
diff --git a/drivers/staging/most/video/Kconfig b/drivers/staging/most/video/Kconfig
index ce6af4f951a6..a458d0c74a0f 100644
--- a/drivers/staging/most/video/Kconfig
+++ b/drivers/staging/most/video/Kconfig
@@ -5,7 +5,7 @@
 config MOST_VIDEO
 	tristate "Video"
 	depends on VIDEO_V4L2
-	---help---
+	help
 	  Say Y here if you want to commumicate via Video 4 Linux.
 
 	  To compile this driver as a module, choose M here: the
-- 
2.11.0

