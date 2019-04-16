Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB9AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF60420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfDPNWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:22:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:22:44 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMXYN-1hX5JC1fF9-00Ja2i; Tue, 16 Apr 2019 15:22:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/6 v2] ARM: ks8695: watchdog: stop using mach/*.h
Date:   Tue, 16 Apr 2019 15:21:41 +0200
Message-Id: <20190416132207.1304277-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uqfgWOfOCLOa4nYg5G/1yN5YmkVEzPGjOL6IbNCxYpSeD28aL8L
 DYqyxCrtfdMCsLI7XiHS/rY0b6QJ6fcEhrF1XMS8e1Gu/6chVpUfT1k/V5G6iQAzLjcJYKn
 DIVPMNu0r0K/b5le/HrM4L4qB7QpD+1jf8fKufGe6k4FrdUATrBWts4949DzIiFIViKG1PR
 Mpdt2qwUjQNk8LOQxK3xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tw6p5CP/Xp8=:gSEDkRYFWUz05sDaS4HxlS
 bUB/iq/Wn7XUFIWst0ZunMDqnS7nczFxHMb1wJLQp2Js76TLVn6jbPmKW4mPkU9sB85qu6Klg
 UklO6CvX5ot0/anHOM79vw8j5pYTz/WMdhJ0xkVFu5681uj2jUWWOnSQT2K5XSNvcDvkclIUy
 vj43s0/ySU8V9md7QIA6SWrcJbpUEmt/nMmScfpX5yzzPcCV2QGm/HrfKOovLCHja4dniRgO0
 OCws+0trVHa4nhDhcjLoTm5nR/Z+DONka75h+5xWpWv0bXkvB6/aPQzmpl3eSDhVKTyMQRG3a
 yfcq7gLc2VFDFjwDoAHFo2b5lSiFrZZQ8/7gCkqXrnLrcHkR1oiUDgZp10j/hTBB7YvtcmS1w
 WEclfnJ9VO9aR0fD0XrHdWZ1ENAaP94CPF5zpQOav5VlKx7YTP4TtG6d9uhm9nsBjx/QwgXOy
 R13CxxgahMFV6yVYgCCqUvnEteplkgpgFg8935Us2riUBb66ZBNRN0tNCeeP11BUnQPfQTrQs
 EWwn9mZWh6BidKbO5WS+pjFtVoxIQaIqO0/2j+cJ+ERqQT8ZallQOaroi1L3f2sJijIyHnLKr
 4HxJZW8rxCSSD6TQfNoiLDhVuCFkX8LIt0rzSoJ5qWvmJpqus4xXx8UiyNp+lKOz4QDuHI57u
 gYWTTI1pHiWWc6vsSP9MmltRFZ2B1Qe4Q5IeUqwqcj7IXCzh0zrZEEMwQLZ/4c2pxZzCIm+kf
 Q9Hk1XX+JVquIOcq3wy6wv5F1dNPkij0uAyegA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers should not rely on machine specific headers but
get their information from the platform device.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/devices.c | 13 ++++++++++++-
 drivers/watchdog/Kconfig       |  2 +-
 drivers/watchdog/ks8695_wdt.c  | 29 ++++++++++++++++-------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index 15afeb964280..ba9d0f0f47ac 100644
--- a/arch/arm/mach-ks8695/devices.c
+++ b/arch/arm/mach-ks8695/devices.c
@@ -169,11 +169,22 @@ void __init ks8696_add_device_hpna(void)
 /* --------------------------------------------------------------------
  *  Watchdog
  * -------------------------------------------------------------------- */
+#define KS8695_TMR_OFFSET      (0xF0000 + 0xE400)
+#define KS8695_TMR_PA          (KS8695_IO_PA + KS8695_TMR_OFFSET)
+static struct resource ks8695_wdt_resources[] = {
+	[0] = {
+		.name	= "tmr",
+		.start	= KS8695_TMR_PA,
+		.end	= KS8695_TMR_PA + 0xf,
+		.flags	= IORESOURCE_MEM,
+	},
+};
 
 static struct platform_device ks8695_wdt_device = {
 	.name		= "ks8695_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= ks8695_wdt_resources,
+	.num_resources	= ARRAY_SIZE(ks8695_wdt_resources),
 };
 
 static void __init ks8695_add_device_watchdog(void)
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea859637..046e01daef57 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -397,7 +397,7 @@ config IXP4XX_WATCHDOG
 
 config KS8695_WATCHDOG
 	tristate "KS8695 watchdog"
-	depends on ARCH_KS8695
+	depends on ARCH_KS8695 || COMPILE_TEST
 	help
 	  Watchdog timer embedded into KS8695 processor. This will reboot your
 	  system when the timeout is reached.
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 1e41818a44bc..2a11cdfe2ab1 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -23,10 +23,8 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <mach/hardware.h>
 
-#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
-#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
+#define KS8695_CLOCK_RATE  25000000
 
 /*
  * Timer registers
@@ -57,6 +55,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 
 static unsigned long ks8695wdt_busy;
 static DEFINE_SPINLOCK(ks8695_lock);
+static void __iomem *tmr_reg;
 
 /* ......................................................................... */
 
@@ -69,8 +68,8 @@ static inline void ks8695_wdt_stop(void)
 
 	spin_lock(&ks8695_lock);
 	/* disable timer0 */
-	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
+	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
 	spin_unlock(&ks8695_lock);
 }
 
@@ -84,15 +83,15 @@ static inline void ks8695_wdt_start(void)
 
 	spin_lock(&ks8695_lock);
 	/* disable timer0 */
-	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
+	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
 
 	/* program timer0 */
-	__raw_writel(tval | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
+	__raw_writel(tval | T0TC_WATCHDOG, tmr_reg + KS8695_T0TC);
 
 	/* re-enable timer0 */
-	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
+	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
 	spin_unlock(&ks8695_lock);
 }
 
@@ -105,9 +104,9 @@ static inline void ks8695_wdt_reload(void)
 
 	spin_lock(&ks8695_lock);
 	/* disable, then re-enable timer0 */
-	tmcon = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(tmcon | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+	tmcon = __raw_readl(tmr_reg + KS8695_TMCON);
+	__raw_writel(tmcon & ~TMCON_T0EN, tmr_reg + KS8695_TMCON);
+	__raw_writel(tmcon | TMCON_T0EN, tmr_reg + KS8695_TMCON);
 	spin_unlock(&ks8695_lock);
 }
 
@@ -239,6 +238,10 @@ static int ks8695wdt_probe(struct platform_device *pdev)
 {
 	int res;
 
+	tmr_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (!tmr_reg)
+		return -ENXIO;
+
 	if (ks8695wdt_miscdev.parent)
 		return -EBUSY;
 	ks8695wdt_miscdev.parent = &pdev->dev;
-- 
2.20.0

