Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5402ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B914920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfJIKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:46:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36559 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:46:31 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI9UD-0003wQ-Fz; Wed, 09 Oct 2019 12:46:29 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI9UA-0002w6-RZ; Wed, 09 Oct 2019 12:46:26 +0200
Date:   Wed, 9 Oct 2019 12:46:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] recordmcount: Rewrite error/success handling
Message-ID: <20191009104626.f3hy5dcehdfagxto@pengutronix.de>
References: <cover.1564596289.git.mhelsley@vmware.com>
 <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ty77l2etqcnjy4dl"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ty77l2etqcnjy4dl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

On Wed, Jul 31, 2019 at 11:24:12AM -0700, Matt Helsley wrote:
> Recordmcount uses setjmp/longjmp to manage control flow as
> it reads and then writes the ELF file. This unusual control
> flow is hard to follow and check in addition to being unlike
> kernel coding style.
> 
> So we rewrite these paths to use regular return values to
> indicate error/success. When an error or previously-completed object
> file is found we return an error code following kernel
> coding conventions -- negative error values and 0 for success when
> we're not returning a pointer. We return NULL for those that fail
> and return non-NULL pointers otherwise.
> 
> One oddity is already_has_rel_mcount -- there we use pointer comparison
> rather than string comparison to differentiate between
> previously-processed object files and returning the name of a text
> section.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>

This is 3f1df12019f333442b12c3b5d110b8fc43eb0b36 in mainline now.

I have the following problem:

	$ make ARCH=arm arch/arm/crypto/
	  Using /home/uwe/gsrc/linux as source for kernel
	  GEN     Makefile
	  CALL    /home/uwe/gsrc/linux/scripts/checksyscalls.sh
	  CALL    /home/uwe/gsrc/linux/scripts/atomic/check-atomics.sh
	  CC      arch/arm/crypto/aes-cipher-glue.o
	arch/arm/crypto/aes-cipher-glue.o: failed
	make[2]: *** [/home/uwe/gsrc/linux/scripts/Makefile.build:281: arch/arm/crypto/aes-cipher-glue.o] Error 1
	make[2]: *** Deleting file 'arch/arm/crypto/aes-cipher-glue.o'
	make[1]: *** [/home/uwe/gsrc/linux/Makefile:1792: arch/arm/crypto/] Error 2
	make: *** [/home/uwe/gsrc/linux/Makefile:179: sub-make] Error 2

and bisection points to 3f1df12019f333442b12c3b5d110b8fc43eb0b36.

This doesn't affect all files, most compile just fine. After calling the
compiler by hand to get aes-cipher-glue.o back I have:

uwe@taurus:~/arietta/kbuild$ ./scripts/recordmcount "arch/arm/crypto/aes-cipher-glue.o"
arch/arm/crypto/aes-cipher-glue.o: failed

I didn't debug this further, if you have problems reproducing or need more
infos tell me. The defconfig I'm using is attached.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ty77l2etqcnjy4dl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=arietta_defconfig

# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_BPF=y
CONFIG_NAMESPACES=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_KALLSYMS_ALL=y
CONFIG_BPF_SYSCALL=y
CONFIG_EMBEDDED=y
CONFIG_SLAB=y
CONFIG_ARCH_MULTI_V4T=y
CONFIG_ARCH_MULTI_V5=y
# CONFIG_ARCH_MULTI_V7 is not set
CONFIG_ARCH_AT91=y
CONFIG_SOC_AT91RM9200=y
CONFIG_SOC_AT91SAM9=y
CONFIG_AEABI=y
CONFIG_UACCESS_WITH_MEMCPY=y
CONFIG_SECCOMP=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_KEXEC=y
CONFIG_CPU_IDLE=y
CONFIG_ARM_CRYPTO=y
CONFIG_CRYPTO_SHA1_ARM=y
CONFIG_CRYPTO_SHA256_ARM=y
CONFIG_CRYPTO_SHA512_ARM=y
CONFIG_CRYPTO_AES_ARM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_INET_DIAG is not set
CONFIG_IPV6_SIT_6RD=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=4
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_ATMEL_TCLIB=y
CONFIG_ATMEL_SSC=y
CONFIG_EEPROM_93CX6=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_MACB=y
CONFIG_DM9000=y
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_DAVICOM_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_RT2X00=y
CONFIG_RT2500USB=y
CONFIG_RT73USB=y
CONFIG_RT2800USB=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
# CONFIG_RTL_CARDS is not set
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_GPIO=y
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
# CONFIG_SERIO is not set
CONFIG_LEGACY_PTY_COUNT=4
CONFIG_SERIAL_ATMEL=y
CONFIG_SERIAL_ATMEL_CONSOLE=y
CONFIG_HW_RANDOM=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_AT91=y
CONFIG_I2C_GPIO=y
CONFIG_SPI=y
CONFIG_SPI_ATMEL=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_SPIDEV=y
CONFIG_GPIO_SYSFS=y
CONFIG_W1=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_SLAVE_THERM=y
CONFIG_POWER_RESET=y
CONFIG_POWER_SUPPLY=y
CONFIG_SENSORS_SHT3x=y
CONFIG_WATCHDOG=y
CONFIG_AT91SAM9X_WATCHDOG=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_FB=y
CONFIG_FB_ATMEL=y
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_AT91_SOC_SAM9G20_WM8731=y
CONFIG_SND_ATMEL_SOC_WM8904=y
CONFIG_SND_AT91_SOC_SAM9X5_WM8731=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_ACM=y
CONFIG_USB_STORAGE=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_GADGET=y
CONFIG_USB_AT91=y
CONFIG_USB_ATMEL_USBA=y
CONFIG_USB_ETH=y
CONFIG_MMC=y
CONFIG_MMC_ATMELMCI=y
CONFIG_MMC_SPI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_DMADEVICES=y
CONFIG_AT_HDMAC=y
# CONFIG_IOMMU_SUPPORT is not set
CONFIG_IIO=y
CONFIG_AT91_ADC=y
CONFIG_PWM=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=y
CONFIG_PWM_ATMEL_TCB=y
CONFIG_EXT4_FS=y
CONFIG_FANOTIFY=y
CONFIG_AUTOFS4_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_HW is not set
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_PRINTK_TIME=y
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_SCHED_DEBUG is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_TEST_PRINTF=y
CONFIG_DEBUG_USER=y

--ty77l2etqcnjy4dl--
