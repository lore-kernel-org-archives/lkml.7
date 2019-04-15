Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63295C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8B72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfDOUZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:25:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfDOUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:25:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Macf4-1gjXR22qiY-00cDX5; Mon, 15 Apr 2019 22:25:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
Date:   Mon, 15 Apr 2019 22:24:13 +0200
Message-Id: <20190415202501.941196-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3f0N7e03dpDdEs2wFtzwS0wRc0tVAs7W6slwO/9ZNkRveBQIjcS
 bm4Kk2zlsXHtNp6ivUcyOVN3NHYArHErq8bNj2eKnYJh+VMwm8BYplE1+TMUj3wuEl3UMHu
 xuwifGzbWpilUzrkx6snzAfW3nWp+Dc8SiAvqtdCc2D0kGJqB/uRVm8Kc3k47bgPHivbyAB
 LsM+6YV4gTQAJ79yOsakA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lishDkrJYUI=:Rg/rjkvrXx+dapNCpggbg8
 KL2QAoY8mgIU7lQn3xtTlbSJdjVKysqV3KoJmb0RPKVoUF0MKptbJwmi1uqNex14l5fLkAjk1
 mOWjJ+OYHFITg7GCwGMtPZZPlMeTWbzlix7c46jz7dHBxhLAtF7dcc07EeMTRzYZ6WNc6jlb0
 MEm/Cvr5OuzVTiN4LRfYkiDZ6lgNrb3Jt7/N+ePrJ0sYGxgDV8xHDWJnFkNYAd//PMpCteYfa
 YH0dIUZGkNq826yDHCevz8KpnnWjruM/9eeQV89/mFpUDlfeThRcv+tGksw0/7v0c+K5HmDFV
 urSd9qS0ZH7eNid8C+1c+VVWdiV3YXg/ecRYAzijeYqKqleX+k2QHjaOQpADXVkHu8CeSfXcW
 UKWY1MKoqbfREaBoJyjctjhtRxSyeBb/NPWMjMUb5jglLDbs96ESZ30e7RArj57HPoPHPa9kr
 r65YOGI6y9G1oSXtdUb+SeTk8o7+zrrlUfI7P4Czu3gdxy80xcaHC3J9qOPqN0RPgVQ0JlnGM
 y3+/SzwuscWKgiamxQhqxZaakA+DDn/z+BPWX7q5wua9uSX+jD+iJ0GQpOkKKFfxya84at/Um
 K0M+c+/LKxAHh1JwW/myDO+QXyUmMr45bBJwUfK3U5dUSsGba6GlpjmE9fYfMvOjD+z29qQ2J
 Mw/m/RAMoAGWIAf2er7eNVgDiCBYL4TToWKlCZFYotTilexwYkNEmH6XL1NRkwPgSPQ0SIM5N
 s9REX+/W0ovB8/Ft48Lz2xDe/MOni9MGKesk7A==
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
 drivers/watchdog/ks8695_wdt.c  | 30 +++++++++++++++++-------------
 3 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index 61cf20beb45f..57766817d86f 100644
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
index 1e41818a44bc..87c542c2f912 100644
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
 
@@ -238,6 +237,11 @@ static struct miscdevice ks8695wdt_miscdev = {
 static int ks8695wdt_probe(struct platform_device *pdev)
 {
 	int res;
+	struct resource *resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	tmr_reg = devm_ioremap_resource(&pdev->dev, resource);
+	if (!tmr_reg)
+		return -ENXIO;
 
 	if (ks8695wdt_miscdev.parent)
 		return -EBUSY;
-- 
2.20.0

