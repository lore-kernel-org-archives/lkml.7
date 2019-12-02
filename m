Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCCC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3D62068E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLBVS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:18:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLBVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:18:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9428B2901BF
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        fabien.lahoudere@collabora.com, guillaume.tucker@collabora.com,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] x86_64_defconfig: Enable support for Chromebooks devices
Date:   Mon,  2 Dec 2019 22:18:44 +0100
Message-Id: <20191202211844.19629-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202211844.19629-1-enric.balletbo@collabora.com>
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of KernelCI we plan to add different x86 based Chromebooks to do
test boot and runtime testing. It will be useful have an upstream
defconfig supporting this kind of devices like we have for ARM
(multi_v7_defconfig) and ARM64 (defconfig). So add different options to
enable different Chromebooks.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/x86/configs/x86_64_defconfig | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index a95291c89717..4ed7a5de1a5a 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -20,6 +20,7 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
+CONFIG_X86_INTEL_LPSS=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
@@ -43,6 +44,12 @@ CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_IA32_EMULATION=y
+CONFIG_GOOGLE_FIRMWARE=y
+CONFIG_GOOGLE_SMI=m
+CONFIG_GOOGLE_COREBOOT_TABLE=m
+CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
+CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
+CONFIG_GOOGLE_VPD=m
 CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
@@ -153,11 +160,15 @@ CONFIG_FORCEDETH=y
 CONFIG_8139TOO=y
 CONFIG_R8169=y
 CONFIG_FDDI=y
+CONFIG_USB_RTL8152=m
+CONFIG_USB_USBNET=m
 CONFIG_INPUT_POLLDEV=y
 CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_CROS_EC=m
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_TABLET=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_INPUT_MISC=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
@@ -176,7 +187,22 @@ CONFIG_NVRAM=y
 CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
 CONFIG_I2C_I801=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_DESIGNWARE_PCI=y
+CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
+CONFIG_I2C_CROS_EC_TUNNEL=m
+CONFIG_SPI=y
+CONFIG_PINCTRL_SX150X=y
+CONFIG_PINCTRL_BAYTRAIL=y
+CONFIG_CHARGER_CROS_USBPD=m
+CONFIG_CHARGER_WILCO=m
 CONFIG_WATCHDOG=y
+CONFIG_MFD_INTEL_LPSS_ACPI=m
+CONFIG_MFD_INTEL_LPSS_PCI=m
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
@@ -191,11 +217,26 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
 CONFIG_SND_HRTIMER=y
 CONFIG_SND_SEQUENCER=y
 CONFIG_SND_SEQ_DUMMY=y
+CONFIG_SND_SEQUENCER_OSS=y
+CONFIG_SND_DUMMY=m
 CONFIG_SND_HDA_INTEL=y
 CONFIG_SND_HDA_HWDEP=y
+CONFIG_SND_HDA_CODEC_HDMI=m
+CONFIG_SND_HDA_GENERIC=m
+CONFIG_SND_SOC=m
+CONFIG_SND_DESIGNWARE_I2S=m
+CONFIG_SND_DESIGNWARE_PCM=y
+CONFIG_SND_SOC_INTEL_HASWELL=m
+CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
+CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
+CONFIG_SND_SOC_CROS_EC_CODEC=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_HIDRAW=y
 CONFIG_HID_GYRATION=y
 CONFIG_LOGITECH_FF=y
@@ -209,6 +250,8 @@ CONFIG_HID_SUNPLUS=y
 CONFIG_HID_TOPSEED=y
 CONFIG_HID_PID=y
 CONFIG_USB_HIDDEV=y
+CONFIG_I2C_HID=m
+CONFIG_INTEL_ISH_HID=m
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
@@ -218,14 +261,39 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_PRINTER=y
 CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ACPI=y
 CONFIG_EDAC=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
+CONFIG_RTC_DRV_CROS_EC=m
 CONFIG_DMADEVICES=y
 CONFIG_EEEPC_LAPTOP=y
+CONFIG_CHROME_PLATFORMS=y
+CONFIG_CHROMEOS_LAPTOP=m
+CONFIG_CHROMEOS_PSTORE=m
+CONFIG_CHROMEOS_TBMC=m
+CONFIG_CROS_EC=m
+CONFIG_CROS_EC_I2C=m
+CONFIG_CROS_EC_ISHTP=m
+CONFIG_CROS_EC_SPI=m
+CONFIG_CROS_EC_LPC=m
+CONFIG_CROS_KBD_LED_BACKLIGHT=m
+CONFIG_WILCO_EC=m
+CONFIG_WILCO_EC_DEBUGFS=m
+CONFIG_WILCO_EC_EVENTS=m
+CONFIG_WILCO_EC_TELEMETRY=m
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
 # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
+CONFIG_IIO=m
+CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
+CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
+CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.20.1

