Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF57C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B722075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559674094;
	bh=6IRa4f6L/ww3YDEhCVQKAlSOqA3jvL6WffX8jjrcPpM=;
	h=From:To:Subject:Date:List-ID:From;
	b=yqBhZs2GSVtgco51ntP7G4dyv1Xu07swIUqJYEuWFCZQfbJIytyoeZlg6em6tMO/l
	 t7B80SmZqDKGSW1IKgHIKl2wQT1Gi6WzA/6Xx8qoKEcvNbOGm6nI3m1D9gkxZObKnV
	 GaPNwCiwaZAz86LKnVdroY38seQQvLJRDmx1edHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFDSsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfFDSsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:48:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753BD2075C;
        Tue,  4 Jun 2019 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559674092;
        bh=6IRa4f6L/ww3YDEhCVQKAlSOqA3jvL6WffX8jjrcPpM=;
        h=From:To:Subject:Date:From;
        b=XKPpVW1KYWRevU2tCldqHd9ugkgrdRpUF7LNxRud0cjSle6UkK2UskadTeul6Zgg7
         euvK5PMIYjL09zttgp+zoQOduiZWhPz5EMh7i8uL28VDBZA65b78YxoaYoMtYs3IDm
         ESTlcDbas/8bQick32POPsF6VX56fSBGMRBCUpXk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: defconfig: samsung: Cleanup with savedefconfig
Date:   Tue,  4 Jun 2019 20:47:59 +0200
Message-Id: <20190604184759.4453-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run savedefconfig to cleanup and reorganize the configs.  Most entries
are only moved around and few options disappear because of defaults.

However this removes the already disabled OSS Emulation and OSS
Sequencer API (SND_MIXER_OSS, SND_PCM_OSS, SND_SEQUENCER_OSS).  These
were already disabled (hidden by missing SND_OSSEMUL and SND_SEQUENCER)
and are not strictly hardware related, therefore they are not necessary
for providing reference hardware config.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/mini2440_defconfig | 43 ++++++++++++-----------------
 arch/arm/configs/s3c2410_defconfig  | 24 ++++++----------
 arch/arm/configs/s3c6400_defconfig  | 11 +++-----
 3 files changed, 31 insertions(+), 47 deletions(-)

diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 4bd1b320067a..301f29a1fcc3 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -4,6 +4,16 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ARCH_S3C24XX=y
+CONFIG_S3C_ADC=y
+CONFIG_S3C24XX_PWM=y
+# CONFIG_CPU_S3C2410 is not set
+CONFIG_CPU_S3C2440=y
+CONFIG_MACH_MINI2440=y
+CONFIG_AEABI=y
+CONFIG_KEXEC=y
+CONFIG_CPU_IDLE=y
+CONFIG_APM_EMULATION=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
@@ -16,17 +26,7 @@ CONFIG_MINIX_SUBPARTITION=y
 CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_LDM_PARTITION=y
-CONFIG_ARCH_S3C24XX=y
-# CONFIG_CPU_S3C2410 is not set
-CONFIG_CPU_S3C2440=y
-CONFIG_MACH_MINI2440=y
-CONFIG_S3C_ADC=y
-CONFIG_S3C24XX_PWM=y
-CONFIG_AEABI=y
-CONFIG_KEXEC=y
-CONFIG_CPU_IDLE=y
 CONFIG_BINFMT_MISC=m
-CONFIG_APM_EMULATION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -46,9 +46,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=m
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
@@ -125,7 +122,6 @@ CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_SDIO=m
 CONFIG_ZD1211RW=m
 CONFIG_ZD1211RW_DEBUG=y
-CONFIG_INPUT_FF_MEMLESS=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -172,12 +168,9 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
+CONFIG_SND_DYNAMIC_MINORS=y
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_SEQ_DUMMY=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
-CONFIG_SND_DYNAMIC_MINORS=y
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
@@ -295,13 +288,6 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_AUTHENC=m
 CONFIG_CRYPTO_TEST=m
@@ -340,3 +326,10 @@ CONFIG_LIBCRC32C=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_MINI_4x6=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index addc209ebd3d..95b5a4ffddea 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -4,13 +4,8 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S3C24XX=y
+CONFIG_S3C_ADC=y
 CONFIG_CPU_S3C2412=y
 CONFIG_CPU_S3C2416=y
 CONFIG_CPU_S3C2440=y
@@ -40,13 +35,18 @@ CONFIG_ARCH_S3C2440=y
 CONFIG_MACH_NEO1973_GTA02=y
 CONFIG_MACH_RX1950=y
 CONFIG_MACH_SMDK2443=y
-CONFIG_S3C_ADC=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/hda1 ro init=/bin/bash console=ttySAC0"
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_APM_EMULATION=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -74,7 +74,6 @@ CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
@@ -129,7 +128,6 @@ CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
 CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
 CONFIG_IP_VS=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -148,7 +146,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_NF_CONNTRACK_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -182,9 +179,9 @@ CONFIG_MAC80211=m
 CONFIG_MAC80211_MESH=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
-CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
@@ -290,11 +287,8 @@ CONFIG_BACKLIGHT_PWM=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_SEQUENCER=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
-CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_VERBOSE_PRINTK=y
+CONFIG_SND_SEQUENCER=m
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
 # CONFIG_SND_SPI is not set
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 6eea99300f7f..59a258d504aa 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -2,9 +2,6 @@ CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_S3C64XX=y
@@ -18,9 +15,11 @@ CONFIG_MACH_HMT=y
 CONFIG_MACH_SMARTQ5=y
 CONFIG_MACH_SMARTQ7=y
 CONFIG_MACH_WLF_CRAGG_6410=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M ramdisk_size=6144"
 CONFIG_VFP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_S3C2410=y
@@ -45,8 +44,6 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_SOUND=y
 CONFIG_SND=m
-CONFIG_SND_MIXER_OSS=m
-CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SOC=m
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
@@ -59,8 +56,8 @@ CONFIG_USB_SERIAL_EMPEG=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_MMC=y
-CONFIG_MMC_DEBUG=y
 CONFIG_SDIO_UART=y
+CONFIG_MMC_DEBUG=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_RTC_CLASS=y
-- 
2.17.1

