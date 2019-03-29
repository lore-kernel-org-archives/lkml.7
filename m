Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BINz0rko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfC2Jdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:33:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33202 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfC2Jdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so9246809wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip0Af/xqdfmo1gYikSlIwnA/2wrU/gZ0/N3BF/YGvKw=;
        b=BINz0rkoUktsO2eGgf60kWm2zKPOVlmpSajI41Qsn7Ax1jtXIGm14hbwpmhxH5DjpI
         MmqhjiHdor8Zbe0X/kT1yC2WEDw6Na2gsQrEhBPSRMCK6PSB1EJvO55IRtFDF+woKJcd
         xF71cubZAKvk9fMip/Z9xkk0FuppwXX1TZh+uwgspbOM2VNIEG4spt0WlncVbGeZe65U
         Zqt92edCMA5b5WC8croafLnY04QfNRkOkhzdGn3IN0Mmp0nMH1Rw0/O0fmY+k+bQurJn
         x/mhkcQco4sqUsYVD0g7BI4O2RirQOMQK7YnBxg7DXwIOjETltdv+WSpsoajLG2tuJBA
         792w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip0Af/xqdfmo1gYikSlIwnA/2wrU/gZ0/N3BF/YGvKw=;
        b=eCTiosWd7TtzUc5wKLizefqsQ+QY5XKN0AKMBGm2SmQ21EYMqLBC11b2luDVag/Yql
         BoYQpmQxH3XnpD2Mcx6WWZpExFyHLTnAjt8dRW0n+U115a1WNS85HGl9tTo4/h4H5549
         B5wpLTGmg5LggKfz2HgWNAQyA+ntR3oA5Hdw4yREOja3nnlw0Rx/+MjOAZJUmhJyTsfh
         dqJw/xzxsvDcypSwxvMKLCacaSzH+GEYg7oAyzxLXTgDFeBwC68w+7wKcIMSMoHkW46W
         RaQgSB3Xh7JUmdwlkrNG/X2HvsU1dbM2LeOpVx5QaT8jbowGjrF0bFCJzFxrebHd5R+F
         BijA==
X-Gm-Message-State: APjAAAUTGaTjdoDjkGqzHIG8UOzjaGyYq98pkZYxp8zluw1FWpqdEJ2E
        +ussHWeFHBIrWUSS9tNohSGElA==
X-Google-Smtp-Source: APXvYqzsuCQYuRsG3pxCvRkRN5K6Z3g0w6EFDcvxMtAitbe8e7zPQ/Vy4B9TDNOG9b0vnPRju5ZKtA==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr2760438wmg.83.1553852023122;
        Fri, 29 Mar 2019 02:33:43 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/6] ARM: davinci: add missing sentinels to GPIO lookup tables
Date:   Fri, 29 Mar 2019 10:33:29 +0100
Message-Id: <20190329093334.3885-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329093334.3885-1-brgl@bgdev.pl>
References: <20190329093334.3885-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some GPIO lookup tables defined in davinci board files are missing
array sentinels. If an entry for given device cannot be found, this
will cause a kernel panic.

Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 ++
 arch/arm/mach-davinci/board-da850-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm355-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    | 1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index ff097ecfa451..e3d74e43c47d 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -58,6 +58,7 @@ static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
 	.table = {
 		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
 		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_OVC, "oc", 0),
+		{ }
 	},
 };
 
@@ -156,6 +157,7 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 			    GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
+		{ }
 	},
 };
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1fdc9283a8c5..4ee65a8a3b80 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -784,6 +784,7 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 			    GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_HIGH),
+		{ }
 	},
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 64d81fc86f14..5113273fda69 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -121,6 +121,7 @@ static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index de15f782816e..9d87d4e440ea 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -663,6 +663,7 @@ static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		{ }
 	},
 };
 
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 0896af2bed24..e244c8648594 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -303,6 +303,7 @@ static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
 	.table = {
 		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, "vbus", 0),
 		GPIO_LOOKUP("davinci_gpio", DA850_USB1_OC_PIN, "oc", 0),
+		{ }
 	},
 };
 
-- 
2.21.0

