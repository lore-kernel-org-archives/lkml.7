Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D64C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F92166E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oMdKNkXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGVNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38124 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfGVNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so39498197wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk5SBc/PQrRw2/WE7KefplwNGkECcCyB4KQSmX+BTmQ=;
        b=oMdKNkXLkaP9sSsQPXeW5E9HuRIDnGJLDCKBG0jCKWc10aWI5al0uhDXtBHPI6dv8i
         HPZv3gN1k0OFHKVcoVnYg9zpRfV/OBl17ptQ6mRQElPqqqVDrjB2r5Oqo7sFP4pcb1ra
         PM1Ix8qi7QKyGM4he0DnNAdiSIeRJ1rWcBDtQSz4kYm4Izt2yieU7kUaPR9ecS18Oyw4
         OAgX1n9mlI635tsJm2aAyiz9Epq9CKXaBVkcD4rHZ6ct9O5il3cMHgN4Aee8MeOy/dBz
         UajQ8y9i1z6ugIcxI80gALDSIBaicqDqynPVY5gy4rPjQ2T+amnvPcjgReyJOhgwpWAh
         cjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk5SBc/PQrRw2/WE7KefplwNGkECcCyB4KQSmX+BTmQ=;
        b=uoZdiF+hPbX5gSFUH7x7xw9lf5cR+KLNde7uiEzZ4bLSqZWYoJq0dTGfEm97FTUB4d
         UVQ4qHwiPSNJjGEXKDY/sZjMJW3265edVbXkAcj+Jbzci3WH9A49Mp0+I4xLeeo9No5V
         HIckm7Jk+zM5yUQ9reRxkzUgY3/teXjPBMlEr9EpfogLz0U2fOouuk+xaCDPQGgKMjkT
         /+suQuUPIYwr9ixNsA3k/JKfkK6O/qAtZKYM3o5l5/IxXDVMUemuvkuSnQTow8SkxEx9
         24HQqm5EPQzRT13odan6r7VTkZ+41DK1uz1or5HSVHMRswcYbGbaCCObGhVyQb5/6zzA
         MNkQ==
X-Gm-Message-State: APjAAAX2/ewYbNLs4GTpnyxlJbXP+cDkEDpiKssm4pqqoHU72R/8f9qO
        SdsIItQgKjBaPZ4dFG2RELQ=
X-Google-Smtp-Source: APXvYqyH5Daii/W5FgVsigcc5EM5zvOq0oWT61laPegjMx3sk6AFUM5Vv73AT8S3lbRAaWz6NO9M/A==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr31786194wrx.80.1563803080115;
        Mon, 22 Jul 2019 06:44:40 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/9] ARM: davinci: refresh davinci_all_defconfig
Date:   Mon, 22 Jul 2019 15:44:15 +0200
Message-Id: <20190722134423.26555-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
References: <20190722134423.26555-1-brgl@bgdev.pl>
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
 arch/arm/configs/davinci_all_defconfig | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 9a32a8c0f873..7c2a39305f2b 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -10,13 +10,6 @@ CONFIG_CGROUPS=y
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
@@ -31,9 +24,7 @@ CONFIG_MACH_MITYOMAPL138=y
 CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -47,6 +38,12 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPUFREQ_DT=m
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
@@ -64,7 +61,6 @@ CONFIG_BT_HCIUART_LL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER=m
-CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
@@ -168,8 +164,6 @@ CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
-CONFIG_SND_SOC_TLV320AIC3X=m
-CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_DAVINCI_EVM=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HID=m
@@ -214,14 +208,12 @@ CONFIG_MMC_DAVINCI=y
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
@@ -259,10 +251,10 @@ CONFIG_NLS_CODEPAGE_437=y
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

