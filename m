Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7EC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D410206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJrRXrKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfFTNTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:19:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35887 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFTNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:19:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so1406998plt.3;
        Thu, 20 Jun 2019 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WAfSE9W5BajJKWLymDwp0X7mWtJXfVrKmtyqCcfxuko=;
        b=WJrRXrKpUAFNdX86ZhIQyqXRSYMXPxhe7v+jiipgR1UWXAZ8aYSHtpZMyLHCG1XBSQ
         kRUVi/P+lGv4MT3GdaXd8j9Ao/+JF5zQjkgOYZXzjRh3BZbY1yDeY5/rLyJtmri44qyw
         e7afQpjZwdW4ziYXb7/FICit+n64ZPv3I3tCRzUmky3bGMC2W82qNNDPaJr6KQUMSSz0
         mLf+kQahLUy9elZgo+AviF4T7BO6CegIUHu8iFUSAIDbc2YTWx7Cr4gdROwPXYmM3Pha
         EZCtJTF2fqtaBHyTVoKyKRubfMqXEB0Bs+mP0pKX+jRUw2vxSGVQmPHdXyNmyzCMaYc4
         DYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WAfSE9W5BajJKWLymDwp0X7mWtJXfVrKmtyqCcfxuko=;
        b=H+2GV1cGFVd1v9eVK4YUyEqHr9e5RR/pzEaJHjg8io8vbViFcFjw0EqqbhAgqRQ4fY
         geHYUPeIzvhkEsuRPQm9aSCncqA1Z9rnwIS7izp31n7YglsRmi7pgkj0FIdG+K1EdpBs
         9uzBJrxojpupHnDFtukw/1hK1VF3m4vlUGuDyfLNKl/hmt4xT9opEAbj+5NTeBAft5/P
         385h/GflH5URU8RROY9xuJU2ZguqMCSHjCqK8G8S5U0JpWjSjphK6F+zbsDA1zYlAD2b
         ApiEAcCJW4RwpPhn3SjRM4Pg/XJj245exYTEm8jDKycx8igKY1X4X1G4kiOoObD+nArp
         L5eg==
X-Gm-Message-State: APjAAAW2XZu/PCZGusuMypgc4Xavnc3ueO/i8/ACE+2ralKtem5kGPOO
        BLDAflYuwfjFC2adO4acKA27BUiJ
X-Google-Smtp-Source: APXvYqzIZHh9fn93IpSozHn+oIrVnPnSFkuSZ6kIv9CBdbX9yq2QnUMhjwmQYdAbHdilhG+DL1FljA==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr123212159plr.243.1561036789060;
        Thu, 20 Jun 2019 06:19:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm5049251pjz.31.2019.06.20.06.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 06:19:48 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: Convert remaining drivers to use SPDX identifier
Date:   Thu, 20 Jun 2019 06:19:46 -0700
Message-Id: <1561036786-23190-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the unnecessary license boilerplate, and avoids
having to deal with individual patches one by one.

No functional changes intended.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1029.c    | 10 ----------
 drivers/hwmon/adt7411.c    |  5 +----
 drivers/hwmon/adt7475.c    |  5 +----
 drivers/hwmon/iio_hwmon.c  |  5 +----
 drivers/hwmon/max197.c     |  5 +----
 drivers/hwmon/scpi-hwmon.c | 10 +---------
 6 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 388060ff85e7..f7752a5bef31 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -10,16 +10,6 @@
  * Very rare chip please let me know if you use it
  *
  * http://www.analog.com/UploadedFiles/Data_Sheets/ADM1029.pdf
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 44a827b031cb..7e6081ff2a74 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Driver for the ADT7411 (I2C/SPI 8 channel 10 bit ADC & temperature-sensor)
  *
  *  Copyright (C) 2008, 2010 Pengutronix
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
  *  TODO: SPI, use power-down mode for suspend?, interrupt handling?
  */
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 7caec127df86..5b6f226cf21b 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * adt7475 - Thermal sensor driver for the ADT7475 chip and derivatives
  * Copyright (C) 2007-2008, Advanced Micro Devices, Inc.
@@ -6,10 +7,6 @@
  * Copyright (C) 2009 Jean Delvare <jdelvare@suse.de>
  *
  * Derived from the lm83 driver by Jean Delvare
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 1770423f7a80..e865a28052be 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Hwmon client for industrial I/O devices
  *
  * Copyright (c) 2011 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index dd6a35219a18..d9b2a3fd0e41 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Maxim MAX197 A/D Converter driver
  *
  * Copyright (c) 2012 Savoir-faire Linux Inc.
  *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * For further information, see the Documentation/hwmon/max197.rst file.
  */
 
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 9bfa228d0eb0..25aac40f2764 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * System Control and Power Interface(SCPI) based hwmon sensor driver
  *
  * Copyright (C) 2015 ARM Ltd.
  * Punit Agrawal <punit.agrawal@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include <linux/hwmon.h>
-- 
2.7.4

