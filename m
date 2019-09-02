Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD99FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D85421874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfIBJxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:53:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfIBJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EACDD28CB77
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 02/10] mfd / platform: cros_ec: Move cros-ec core driver out from MFD
Date:   Mon,  2 Sep 2019 11:53:01 +0200
Message-Id: <20190902095309.18574-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the ChromeOS EC core driver has nothing related to an MFD device, so
move that driver from the MFD subsystem to the platform/chrome subsystem.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/extcon/Kconfig                     |  2 +-
 drivers/hid/Kconfig                        |  2 +-
 drivers/i2c/busses/Kconfig                 |  2 +-
 drivers/iio/common/cros_ec_sensors/Kconfig |  2 +-
 drivers/input/keyboard/Kconfig             |  2 +-
 drivers/media/platform/Kconfig             |  3 +--
 drivers/mfd/Kconfig                        | 15 ++-------------
 drivers/mfd/Makefile                       |  2 --
 drivers/platform/chrome/Kconfig            | 21 +++++++++++++++++----
 drivers/platform/chrome/Makefile           |  1 +
 drivers/{mfd => platform/chrome}/cros_ec.c |  0
 drivers/power/supply/Kconfig               |  2 +-
 drivers/pwm/Kconfig                        |  2 +-
 drivers/rtc/Kconfig                        |  2 +-
 sound/soc/codecs/Kconfig                   |  4 ++--
 sound/soc/qcom/Kconfig                     |  2 +-
 16 files changed, 32 insertions(+), 32 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec.c (100%)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index fa1804460e8c..aac507bff135 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -181,7 +181,7 @@ config EXTCON_USB_GPIO
 
 config EXTCON_USBC_CROS_EC
 	tristate "ChromeOS Embedded Controller EXTCON support"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  Say Y here to enable USB Type C cable detection extcon support when
 	  using Chrome OS EC based USB Type-C ports.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 3872e03d9a59..a958b9625bba 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -376,7 +376,7 @@ config HOLTEK_FF
 
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
-	depends on USB_HID && LEDS_CLASS && MFD_CROS_EC
+	depends on USB_HID && LEDS_CLASS && CROS_EC
 	---help---
 	Say Y here if you have a Google Hammer device.
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 09367fc014c3..938fe1f2ce31 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1345,7 +1345,7 @@ config I2C_SIBYTE
 
 config I2C_CROS_EC_TUNNEL
 	tristate "ChromeOS EC tunnel I2C bus"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you get an I2C bus that will tunnel i2c commands
 	  through to the other side of the ChromeOS EC to the i2c bus
diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index bcb58fb76b9f..cdbb29cfb907 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -4,7 +4,7 @@
 #
 config IIO_CROS_EC_SENSORS_CORE
 	tristate "ChromeOS EC Sensors Core"
-	depends on SYSFS && MFD_CROS_EC
+	depends on SYSFS && CROS_EC
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 8e9c3ea9d5e7..861c7a2105a2 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -745,7 +745,7 @@ config KEYBOARD_W90P910
 config KEYBOARD_CROS_EC
 	tristate "ChromeOS EC keyboard"
 	select INPUT_MATRIXKMAP
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
 	  and implemented on the ChromeOS EC. You must enable one bus option
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 8a19654b393a..98c3a9a6725e 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -547,10 +547,9 @@ if CEC_PLATFORM_DRIVERS
 
 config VIDEO_CROS_EC_CEC
 	tristate "ChromeOS EC CEC driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	select CEC_CORE
 	select CEC_NOTIFIER
-	select CHROME_PLATFORMS
 	select CROS_EC_PROTO
 	help
 	  If you say yes here you will get support for the
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4a07afe50b35..1079aff13f54 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -211,21 +211,10 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
-config MFD_CROS_EC
-	tristate "ChromeOS Embedded Controller"
-	select MFD_CORE
-	select CHROME_PLATFORMS
-	select CROS_EC_PROTO
-	depends on X86 || ARM || ARM64 || COMPILE_TEST
-	help
-	  If you say Y here you get support for the ChromeOS Embedded
-	  Controller (EC) providing keyboard, battery and power services.
-	  You also need to enable the driver for the bus you are using. The
-	  protocol for talking to the EC is defined by the bus driver.
-
 config MFD_CROS_EC_CHARDEV
 	tristate "Chrome OS Embedded Controller userspace device interface"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
+	select MFD_CORE
 	---help---
 	  This driver adds support to talk with the ChromeOS EC from userspace.
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7b6a6aa4fe42..b7ea093dd097 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,8 +13,6 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-cros_ec_core-objs		:= cros_ec.o
-obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
 obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 970679d0b6f6..eaeb04e07335 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -50,9 +50,22 @@ config CHROMEOS_TBMC
 	  To compile this driver as a module, choose M here: the
 	  module will be called chromeos_tbmc.
 
+config CROS_EC
+	tristate "ChromeOS Embedded Controller"
+	select CROS_EC_PROTO
+	depends on X86 || ARM || ARM64 || COMPILE_TEST
+	help
+	  If you say Y here you get support for the ChromeOS Embedded
+	  Controller (EC) providing keyboard, battery and power services.
+	  You also need to enable the driver for the bus you are using. The
+	  protocol for talking to the EC is defined by the bus driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec.
+
 config CROS_EC_I2C
 	tristate "ChromeOS Embedded Controller (I2C)"
-	depends on MFD_CROS_EC && I2C
+	depends on CROS_EC && I2C
 
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
@@ -62,7 +75,7 @@ config CROS_EC_I2C
 
 config CROS_EC_RPMSG
 	tristate "ChromeOS Embedded Controller (rpmsg)"
-	depends on MFD_CROS_EC && RPMSG && OF
+	depends on CROS_EC && RPMSG && OF
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  through rpmsg. This uses a simple byte-level protocol with a
@@ -87,7 +100,7 @@ config CROS_EC_ISHTP
 
 config CROS_EC_SPI
 	tristate "ChromeOS Embedded Controller (SPI)"
-	depends on MFD_CROS_EC && SPI
+	depends on CROS_EC && SPI
 
 	---help---
 	  If you say Y here, you get support for talking to the ChromeOS EC
@@ -97,7 +110,7 @@ config CROS_EC_SPI
 
 config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
-	depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
+	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  over an LPC bus, including the LPC Microchip EC (MEC) variant.
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index fd0af05cc14c..12ff8de5ac7a 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -6,6 +6,7 @@ CFLAGS_cros_ec_trace.o:=		-I$(src)
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
+obj-$(CONFIG_CROS_EC)			+= cros_ec.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
diff --git a/drivers/mfd/cros_ec.c b/drivers/platform/chrome/cros_ec.c
similarity index 100%
rename from drivers/mfd/cros_ec.c
rename to drivers/platform/chrome/cros_ec.c
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5d91b5160b41..5e448b64393d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -670,7 +670,7 @@ config CHARGER_RT9455
 
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e57516959e..b0e632ba8590 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -145,7 +145,7 @@ config PWM_CRC
 
 config PWM_CROS_EC
 	tristate "ChromeOS EC PWM driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e72f65b61176..a45175fd8cc4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1274,7 +1274,7 @@ config RTC_DRV_ZYNQMP
 
 config RTC_DRV_CROS_EC
 	tristate "Chrome OS EC RTC driver"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you will get support for the
 	  Chrome OS Embedded Controller's RTC.
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9f89a5346299..11fd97cd9ab4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -51,7 +51,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_BT_SCO
 	select SND_SOC_BD28623
 	select SND_SOC_CQ0093VC
-	select SND_SOC_CROS_EC_CODEC if MFD_CROS_EC
+	select SND_SOC_CROS_EC_CODEC if CROS_EC
 	select SND_SOC_CS35L32 if I2C
 	select SND_SOC_CS35L33 if I2C
 	select SND_SOC_CS35L34 if I2C
@@ -474,7 +474,7 @@ config SND_SOC_CQ0093VC
 
 config SND_SOC_CROS_EC_CODEC
 	tristate "codec driver for ChromeOS EC"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	help
 	  If you say yes here you will get support for the
 	  ChromeOS Embedded Controller's Audio Codec.
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8e3e86619b35..60086858e920 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -99,7 +99,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && MFD_CROS_EC && I2C
+	depends on QCOM_APR && CROS_EC && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.1

