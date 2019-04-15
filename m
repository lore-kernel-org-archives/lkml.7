Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B530EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6522087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfDOU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:27:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:27:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mtf7H-1h0FRt0VLz-00v7Sc; Mon, 15 Apr 2019 22:27:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 4/6] ARM: ks8695: move gpio code back into platform
Date:   Mon, 15 Apr 2019 22:24:16 +0200
Message-Id: <20190415202501.941196-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HMe83s6pohIq/i3bMUw9/5Y38GKGIFa+UtVjWFJhBUsCcTyyx7n
 Gi1iz1hKJqvLPvGlsvmkwc63TPYBxkT0UaJSOeGypK86L0fpZUJq3iwi8bZ/TkWcb2WXplf
 AJNdEJdU31Ncc3IjFDxJL25DIWvBFVj3ds11KFKllCWMiwFWF3GD8QBfFPzXfPj5LIgTmCP
 oG9++Bt28owQxdjC7Zltw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8TLkGYH7ao=:7tbN0O9vt0g0Uo0lpplzUn
 /uv1sRo7/rgsXEYThWrqNaVbxpEKGpA882wAB1Lbn6v7cMpjvW4MmB1Mda/fiAlG4sxHIdy/c
 /LlRjWVQb64f93FAaQtlJiQVePg/xCKSrF/e38RBBpCoQkCZc+b+LhIWlCCqav6Nc4jL5ETG/
 bW3c0v8g/iHtFWXqIacXeNhC9sFjbdBy6soKKx7NhHoieRgecO8Suk/1O2omycu/socdRiv2n
 gshc0uyOuG2E0q+4aIBwEynQ9SJ8ny4M/LxhQavsHxdbcr4o5DsEqQbbG2UsUGf/0ECkgzYH+
 SdaUbLxynr5p9+j1N25VRtO840zNEgnyAKdwqsHjR3bWgMaPpfsNHx+eDP4OSQYCHCYChnPm5
 rx5AWtFAevb1ckg7Pg1D+11dv0ppykPEm9F09DPYNDterffZcOzwgJJGpHZ7jSEetGrlRMu6L
 1Z9QI15TDM9sgUFrcfoGu0eUpqxwHkJGvTQyEYtUZE+or2nuJCi7PZ4Okzplumt++/I+GiQzr
 0nMj5LXu45dwh9K//2LN3VOJlAXe0FOvzLFqwa1qsyKybh8K8CLxJoUO572lpe5MnPLm8Mhe3
 5ulZ1hQ8uRY/rN8dKXPhOE9gt5la8dOlq8865Zb/LxLByeK9sDlaLUlaINGtbnWLYPRWyOAie
 P0Iq6sbPc/BZvjUPeNpXCFfOpm6oZIZyZ2HSWFbv7ugr5kdiiZ2gWWLEBjZyrJSCISuS4P47/
 EYSY1g78XKe2JEq82uf/5DM8+YPW7hoJrsRZbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly splitting this out into a portable driver is
hard, as the gpio code tightly interacts with the irqchip
code. Give up and move it back to its original location,
but make the headers private in the process.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/Makefile                             | 2 +-
 arch/arm/mach-ks8695/board-acs5k.c                        | 2 +-
 arch/arm/mach-ks8695/board-dsm320.c                       | 2 +-
 arch/arm/mach-ks8695/board-micrel.c                       | 2 +-
 arch/arm/mach-ks8695/board-og.c                           | 4 ++--
 arch/arm/mach-ks8695/{include/mach => }/gpio-ks8695.h     | 0
 drivers/gpio/gpio-ks8695.c => arch/arm/mach-ks8695/gpio.c | 6 +++---
 arch/arm/mach-ks8695/irq.c                                | 2 +-
 arch/arm/mach-ks8695/{include/mach => }/regs-gpio.h       | 2 --
 drivers/gpio/Makefile                                     | 1 -
 10 files changed, 10 insertions(+), 13 deletions(-)
 rename arch/arm/mach-ks8695/{include/mach => }/gpio-ks8695.h (100%)
 rename drivers/gpio/gpio-ks8695.c => arch/arm/mach-ks8695/gpio.c (98%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-gpio.h (97%)

diff --git a/arch/arm/mach-ks8695/Makefile b/arch/arm/mach-ks8695/Makefile
index 439b22255a32..0a64557c3050 100644
--- a/arch/arm/mach-ks8695/Makefile
+++ b/arch/arm/mach-ks8695/Makefile
@@ -4,7 +4,7 @@
 # Makefile for KS8695 architecture support
 #
 
-obj-y				:= cpu.o irq.o time.o devices.o
+obj-y				:= cpu.o irq.o time.o devices.o gpio.o
 
 # PCI support is optional
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 5783062224c3..9baa7f91811e 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -34,7 +34,7 @@
 #include <asm/mach/irq.h>
 
 #include "devices.h"
-#include <mach/gpio-ks8695.h>
+#include "gpio-ks8695.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-ks8695/board-dsm320.c b/arch/arm/mach-ks8695/board-dsm320.c
index 13537e9c5485..d3cfc9c955ad 100644
--- a/arch/arm/mach-ks8695/board-dsm320.c
+++ b/arch/arm/mach-ks8695/board-dsm320.c
@@ -29,7 +29,7 @@
 #include <asm/mach/irq.h>
 
 #include "devices.h"
-#include <mach/gpio-ks8695.h>
+#include "gpio-ks8695.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-ks8695/board-micrel.c b/arch/arm/mach-ks8695/board-micrel.c
index 69cfb9935fc1..69a27dfe8232 100644
--- a/arch/arm/mach-ks8695/board-micrel.c
+++ b/arch/arm/mach-ks8695/board-micrel.c
@@ -18,7 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/gpio-ks8695.h>
+#include "gpio-ks8695.h"
 #include "devices.h"
 
 #include "generic.h"
diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
index 478ebd1f2b0f..7b962ba1425d 100644
--- a/arch/arm/mach-ks8695/board-og.c
+++ b/arch/arm/mach-ks8695/board-og.c
@@ -19,8 +19,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include "devices.h"
-#include <mach/regs-gpio.h>
-#include <mach/gpio-ks8695.h>
+#include "regs-gpio.h"
+#include "gpio-ks8695.h"
 #include "generic.h"
 
 static int og_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
diff --git a/arch/arm/mach-ks8695/include/mach/gpio-ks8695.h b/arch/arm/mach-ks8695/gpio-ks8695.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/gpio-ks8695.h
rename to arch/arm/mach-ks8695/gpio-ks8695.h
diff --git a/drivers/gpio/gpio-ks8695.c b/arch/arm/mach-ks8695/gpio.c
similarity index 98%
rename from drivers/gpio/gpio-ks8695.c
rename to arch/arm/mach-ks8695/gpio.c
index d6d6140ffc40..3a6c8f804f91 100644
--- a/drivers/gpio/gpio-ks8695.c
+++ b/arch/arm/mach-ks8695/gpio.c
@@ -28,10 +28,10 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/mach/irq.h>
+#include <mach/irqs.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-ks8695.h>
+#include "regs-gpio.h"
+#include "gpio-ks8695.h"
 
 /*
  * Configure a GPIO line for either GPIO function, or its internal
diff --git a/arch/arm/mach-ks8695/irq.c b/arch/arm/mach-ks8695/irq.c
index 31439f2ee21e..ee3f08f66e7e 100644
--- a/arch/arm/mach-ks8695/irq.c
+++ b/arch/arm/mach-ks8695/irq.c
@@ -32,7 +32,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
 static void ks8695_irq_mask(struct irq_data *d)
 {
diff --git a/arch/arm/mach-ks8695/include/mach/regs-gpio.h b/arch/arm/mach-ks8695/regs-gpio.h
similarity index 97%
rename from arch/arm/mach-ks8695/include/mach/regs-gpio.h
rename to arch/arm/mach-ks8695/regs-gpio.h
index 90614a7d0548..c97414b8825a 100644
--- a/arch/arm/mach-ks8695/include/mach/regs-gpio.h
+++ b/arch/arm/mach-ks8695/regs-gpio.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-ks8695/include/mach/regs-gpio.h
- *
  * Copyright (C) 2007 Andrew Victor
  *
  * KS8695 - GPIO control registers and bit definitions.
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 54d55274b93a..a3b44ef6a8ea 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
-obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
 obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
-- 
2.20.0

