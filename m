Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A020643
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G873zF5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDII3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37037 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDII3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so19688345wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=G873zF5dffzKx8qrkIZHrHo6kXTyU1Bv+mgvyIhr3uibQy4aoo1WvphGf2GLK097eX
         31iBzbqiOjvdXYajQXQwz/lVmafuheAQJYVdYEg0zswvPytELmltlloLQmEYIkrmXtK+
         tFfOvXQqXytmOJTR6htl7sdPzYcwqVieM4UZFuACViR5xEy9swNubOoKVJTvGEndTmBn
         tlLxXHR63oUVW+LXmGIpS8wEqXYMKqZCVsJ26mfXvurS7mLPVu6DMbu1O01u1uToAy2K
         evHL9ayeMiZK33tu9pM2aihLvoIqddjHD+IrLg5qKi3eH7ieFJAfMBJvucvRg+DIm3lC
         E0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=UV/2Yk8MkZGUhH94Z+fit/f9WyOy6X24DC4pFDbpkEXh0SsrpdIuUYIIiYRZ9fHlmX
         /HABbR0GMikzQK/ZZ1457ZPpdwcYd804N0PtkY4umXX93sWqsxrlj6MYey3Grt2gwAOE
         NxddTP5DXGQrFMcf3rToSl3lXWgvpYuzqYw/G77bJNHBFsFrus/mZvD7jqaUW8lR4Pt2
         DKoFwwHMdkJuXHIVkCq97YL3V3Ce5khApPjxasOzQLwEBfycqmk7PtGRQsVqApbDNLGD
         ngrBwdBhjr2wRHtVXeZwdnxmbnbyoM3+qlHXsBD1KQVFslHUFfyGt8ouR8rVElcQnrkV
         aBzA==
X-Gm-Message-State: APjAAAXIWGBqguxNkeysIjU1XQqBv3r0ngU8HpbZ5arJhIeb5gJqNI4J
        hXaxqOtYgnIWuMN+warAyQPsGw==
X-Google-Smtp-Source: APXvYqxFy33HpHS7vPDiHpRUKe9PCK4WXUvc5uild4OPX5P/ir+fPCj2jafSHIrmlezXe2kg9W1LPA==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr23401704wrv.19.1554798541528;
        Tue, 09 Apr 2019 01:29:01 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c20sm59968651wre.28.2019.04.09.01.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:29:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/6] ARM: davinci: add missing sentinels to GPIO lookup tables
Date:   Tue,  9 Apr 2019 10:28:50 +0200
Message-Id: <20190409082855.15373-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409082855.15373-1-brgl@bgdev.pl>
References: <20190409082855.15373-1-brgl@bgdev.pl>
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

