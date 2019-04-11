Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10473C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537F62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="F2Wp4yv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDKJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:30:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33674 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDKJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so6420675wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=F2Wp4yv6asyb2BA6lvYd9DEU9QXvgg8ODxLuMyCJdkhul/PM6u0kx7a2L4X69Q6g5T
         qzXxrxHAD0vUNqXdrkcnWeM+oHmUycWMFIOdKAUZKDEPStSVWsaF1d3woBBUIYeuAKV/
         dCfmplXj8/lNSFBEyEER/zDFpHh9YUcs3Oe1XjPKNoT4ehz37qenSfLmTbvcZkNT75x/
         q/Rz1GmLIR3YVsQv1dwjZDIiFGrb9Myz1zkF5oeqQlBcD2njKx42CHUl/0xjGswlMBmA
         1vWvO2J7hPawcvwxO7xlBTcBrcjHRpLE2djlIKEKebpAmSa0zSxvqVBF0nip/AbKDhGw
         wzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45dzSBv6+V3bbvrapzfFB+qo0X2yeBTBy+CINkubKnc=;
        b=hrYPIcgy+8S2Djh3FXlxALSHCrW3z/JB7QEJN8u4C7kOOA0Zq4xogfFyk2pfkvrXCZ
         kWCemOlTCVUaES4M8SUe4pat5dZzfFHY+QR4Vbaltvzk/rlD3aw0AehxbZknC6mCjlKZ
         KytrHJ6Zem1Ciby+G7yVXtUS1f7mT2yy55A6kcj2RDvmHBcywYMlJ45bln+aJC40SDZZ
         Qfh14TrJC/R0GXQ2YV2VRp87RU+aAhWejaA+qS0aD0OxswipJQoANGD6pz84226Z7hwx
         czTZrqnRktGNQTXFbTKeMX8zifu4hS3ibQiQX7mZAtXyUTTut4requYRnB75w4MY8Zcb
         PYbA==
X-Gm-Message-State: APjAAAWMavgFfyhBrzHV0KewIhkk9TYsJAox00W+NO7z/7mu+K4J2o8I
        M5JnAj8m0EC47sAaPpyzJFkNtQ==
X-Google-Smtp-Source: APXvYqzc/aNfb+Y/Bypvvo7Sn36VeXfGLTON3iEYLNkSDqwq6nsm+Rkfv/hwJdevkoX9lofmykaTPw==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr30025478wrp.235.1554975030331;
        Thu, 11 Apr 2019 02:30:30 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/6] ARM: davinci: add missing sentinels to GPIO lookup tables
Date:   Thu, 11 Apr 2019 11:30:19 +0200
Message-Id: <20190411093024.23555-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411093024.23555-1-brgl@bgdev.pl>
References: <20190411093024.23555-1-brgl@bgdev.pl>
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

