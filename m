Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC92C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9558D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XfV694/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfFYQfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfFYQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:34:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id f15so8743143wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g1huIVKZozNkv7icnrH8UYyhFSdx5OaAzsnOBD/wug=;
        b=XfV694/+ba+iJjm7XndfMMr4t/G9R6WZsl7ZClO8hbM2sE6598a/agfQtKVXIRT+/V
         AoWfR7WcIGSYP9NtRwQLMxrVuN8omLG3udtaeoq83oK2iDO6nbVLJEHwc4tAlzDRKnUW
         gS/on6mUn/wFH3kWwFQKEFahEkn+l8s83Ssn4MxCUCfZZpg6XEZM2S6oO7wDsjKHlSzK
         6DdCjzey8fw1L2Sr3nfWJAfvgsIF/hpbPE/j6G7N0faVlvQgkRP+V8rn2kBlHP6VSfn7
         CBY8w6r9dg4x854xvpQB8f/T0kExSZQfy1QZEFOwDaubHwfdoPP9zoCw6SwKAt13nfeI
         zNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g1huIVKZozNkv7icnrH8UYyhFSdx5OaAzsnOBD/wug=;
        b=JZqQbYTnLkftmqHs9IJJzKi6vKNxs+AyzKB1UKJSRlVynTL5eo5MtTf5xqHBI3P0jL
         QwOtNrYCfj/M8hPTvwZYvqOdLz200l6PvbReG47P5H9DY/nBnhIiv1l36R7Dr+ZpQQd2
         yrWu0Oa2Mg8uLcKyLfBtyINM7P/Q5reg6tgW6SeIvNBg6AYthUmK/PsIi+30HSSxIU0b
         pup3UXwFQbW9nDgrLoqTzCnC1k27LGGKbYhjv0o7dP5VjWRwLiKCamh+yRiOhBrFiskl
         HJEuMw+kJ5aQOELnfMrO6t1J1GGiumnWdYbYkEU07+Zx6y5Dfcr+PzXwY4Qk9AnfAjwY
         UrgQ==
X-Gm-Message-State: APjAAAUlvb19rtY4Af0It2lUbF5INONRzkqVA2v+TEvABj4F8HZI7/fj
        6qpE3VZ48ZDDmXOMb242K/yFbA==
X-Google-Smtp-Source: APXvYqwvUGzuhdRcRqrCnTEpE5XZ6xpDDtphMfdnxdkKNg7ns8U+hGGMdSWdjbAlt4fd7Q2s17qqjA==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr27001554wrt.295.1561480496798;
        Tue, 25 Jun 2019 09:34:56 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/12] ARM: davinci: refresh davinci_all_defconfig
Date:   Tue, 25 Jun 2019 18:34:26 +0200
Message-Id: <20190625163434.13620-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
References: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Refresh davinci_all_defconfig with current master.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 27 ++++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 4a8cad4d3707..13d7846c613d 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -10,13 +11,6 @@ CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DM644x=y
 CONFIG_ARCH_DAVINCI_DM355=y
@@ -31,9 +25,7 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -46,6 +38,12 @@ CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPU_IDLE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -63,7 +61,6 @@ CONFIG_BT_HCIUART_LL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER=m
-CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
@@ -167,8 +164,6 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_SOC_TLV320AIC3X=m
-CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_DAVINCI_EVM=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
@@ -213,14 +208,12 @@ CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_GPIO=m
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
-CONFIG_TI_EDMA=y
 CONFIG_COMMON_CLK_PWM=m
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
@@ -258,10 +251,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_T10DIF=m
+CONFIG_DMA_CMA=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=m
-- 
2.21.0

