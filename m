Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B12190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QfISO/Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfGYNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:22:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55477 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:22:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so44990080wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrxrzHfdR2gckMKegx1yxVHO2Izu+Cmysz1TGZaUt4E=;
        b=QfISO/Ct6slzzGV6lLrDhhZRemPsoiiqhiQTC3XaMtgSBNxZohmAqrUpq1jAFqR+dD
         LCZ1ATz5sYQxONgBqCEHM1/VP+XZQEEJ0LyO1MRdBgSUcSDDheE+Ol+wdV0fLvJ8U+/3
         6PpNnsAm6dMOefMHtl3Mwvyg2xHuuqeLDgNY/dcBT57jOGgT6JJrafHjBNNwOoZWUBSS
         mSx7HDxx9q6W9FMW2j2zbTSL33IPhCuiNjNfwG8nl14aSurScQzrUHrWgekI66xDoe16
         S6Jnfr09xGbs9+BOC+0nhP4Gbpjbr04cNA9lWG8MGsIGhcX2Qv8rsFtoJETIqp35Qh++
         pZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrxrzHfdR2gckMKegx1yxVHO2Izu+Cmysz1TGZaUt4E=;
        b=QzJB2ahiiKALc8m4oAQ7Tv5kGiYAvipe2IHXCgzecrIK4RilSnqSDz/90ba+4HFBUu
         jAk3rkCyZTjNWBCgWK98AxUlRvp9c30IBdGfaykW40/96DvQuezqUldvq79+kydMq2Ag
         Qh4FK4BmJN6kbl+Ds6mCCyPsaOYbj0NWUvkvg9wttJdVH3usoGrsgwmcIHQjzoUU1Wco
         aZch3NBDnY3LF2tm4qm595V1oHvugL/w6LHLrtyypMsVl65/4Dupn7q899Yc5DkZtJBP
         vrt88avBZgzNxEgcaU1efjwj304F2lS7pkNfQiS4niAWpGBfLuc7FBQfF3k+KeFI0Gea
         +trQ==
X-Gm-Message-State: APjAAAXL3ipQlt8F8y2d8/v/QRwi7cK/RodhFD5EvYg0wtugqi7/kOZ0
        U867ozGpwBQAorW7ToegmiUKgrzk
X-Google-Smtp-Source: APXvYqxYNPRyCf8Ng0zjZFemZwU2WdjjqfvvmBxyWwh8g64OsosMO2a7JphltDJDTF48NPsMJNvm0A==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr51283395wmi.14.1564060384593;
        Thu, 25 Jul 2019 06:13:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7sm47119735wrh.67.2019.07.25.06.13.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:13:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/5] media: davinci-vpbe: remove obsolete includes
Date:   Thu, 25 Jul 2019 15:12:54 +0200
Message-Id: <20190725131257.6142-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725131257.6142-1-brgl@bgdev.pl>
References: <20190725131257.6142-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver builds fine without these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/media/platform/davinci/vpbe_display.c | 4 ----
 drivers/media/platform/davinci/vpbe_osd.c     | 5 -----
 drivers/media/platform/davinci/vpbe_venc.c    | 5 -----
 3 files changed, 14 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index 000b191c42d8..18f9408013d1 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -19,10 +19,6 @@
 
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_ARCH_DAVINCI
-#include <mach/cputype.h>
-#endif
-
 #include <media/v4l2-dev.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-ioctl.h>
diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/davinci/vpbe_osd.c
index 491842ef33c5..91b571a0ac2c 100644
--- a/drivers/media/platform/davinci/vpbe_osd.c
+++ b/drivers/media/platform/davinci/vpbe_osd.c
@@ -16,11 +16,6 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ARCH_DAVINCI
-#include <mach/cputype.h>
-#include <mach/hardware.h>
-#endif
-
 #include <media/davinci/vpss.h>
 #include <media/v4l2-device.h>
 #include <media/davinci/vpbe_types.h>
diff --git a/drivers/media/platform/davinci/vpbe_venc.c b/drivers/media/platform/davinci/vpbe_venc.c
index 425f91f07165..8caa084e5704 100644
--- a/drivers/media/platform/davinci/vpbe_venc.c
+++ b/drivers/media/platform/davinci/vpbe_venc.c
@@ -14,11 +14,6 @@
 #include <linux/videodev2.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ARCH_DAVINCI
-#include <mach/hardware.h>
-#include <mach/mux.h>
-#endif
-
 #include <linux/platform_data/i2c-davinci.h>
 
 #include <linux/io.h>
-- 
2.21.0

