Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8729AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499972082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w4GD472K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfDLMhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:37:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDLMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so10838239wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=w4GD472KWldp0hHPg/Ps3G2W0jAvjWrj8BsmHNXWZg1xxBXbkfvw6xjfIUurXJ0nEj
         Q5PYxpgBwOPARJ2B/iOqLjbIfL6CvLFovFvge6SqXCeOISseeXxoejNluTO4E90ViDPF
         psx1VNo+s7x6nt+rXC7R/GbKIlQ09CCr6nTyY5CIGRbCO6w4Dqu6e3BvPUHuJXKhOuiu
         cBAEBtjO9NQEUqnDdSmEGXdBnsd+b2oyrdqojVGjZD4XALlwgOS2rGak2AFRyDrYui8x
         +Tz3h9dDL8LLc4ZCL+JnTx2d3k7R+f/ePhzGN4buShs4pF7091uMECgGujONpSsh0iRT
         fxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=gRuxz96QviM610FwtHQ4ys2tvFKOcjKbSo4N0Mg3N5aLigfo2mdcH2EIaIz2hzYgV8
         1Gz+Ww9rRnomGozErQNtVekEsQyg+JIfS+wFiuFygN1BIJXgDNn6p1gy+9xn1mHnVavY
         B224qRs/AB7cQz90gsZYpjikzrgOOXujQ+8hupkkxRbvjF8K8oLmGP8Qpr44GX8AFduu
         K9wP9SPhOuT5Ax1/XGdyiUvQru6UZRnCIfjjGdc4ZJWyg8qIJrFtib9bU/LqXG60h90L
         ctmca+aImKLYPKhBdajlHHs/UYEncFt16ZEDja6WNW0K6i+KTPBW/U4/xJLfiIZ8/WN1
         ALJg==
X-Gm-Message-State: APjAAAWYusI+wvnuiXwdGa5q47z0UeM2CviwhD0ZszEblllMg63hOKEt
        1Z7oDykICQgaduWGkCzBiK/QTg==
X-Google-Smtp-Source: APXvYqxX06KYCK4XB+Q+dqBWHaGwF6Mn33wY15Ntow3Vhc7yA950/dHiUaR1ywcqfgBGH5OLJHhEWw==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr10822003wmc.43.1555072604648;
        Fri, 12 Apr 2019 05:36:44 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id v190sm12384030wme.18.2019.04.12.05.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:36:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/6] ARM: davinci: add missing sentinels to GPIO lookup tables
Date:   Fri, 12 Apr 2019 14:36:35 +0200
Message-Id: <20190412123640.11437-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412123640.11437-1-brgl@bgdev.pl>
References: <20190412123640.11437-1-brgl@bgdev.pl>
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

