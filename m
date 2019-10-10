Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67EAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfJJUgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:36:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:36:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYLqs-1ieCBJ1q2k-00VSwa; Thu, 10 Oct 2019 22:36:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/36] ARM: s5pv210: use private pm save/restore
Date:   Thu, 10 Oct 2019 22:29:54 +0200
Message-Id: <20191010203043.1241612-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t06pj45vMcSDoEbxSCss3f5CI4Q0mCvmon4HXQKdFVgc3CZE2SZ
 6GDEv57UdL2pMT9oYaML5s6k6H4an0hD0vSPqL1TK9QhIqAiZ3JXJGQRYiLA10kdPybEDLM
 LkmdsIkBh+fEfuZ4qKsBYg1p1Ya6B3jCBopYbIsgcd7xLrXfT9D/yReO3ELSeGlzG11eU+v
 IdbSm0rP+MzyF0ya7wCxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XV+MPK70w7E=:BhQ4bhqXydFKuIa+TPbyId
 A5KmTH4/XxVCeHb+3+T5c/+c9wqtBBLomtafNUtbfL7geLlXVDKW10N4L6+AuH1WBjanj7LvJ
 dUFJ4oNaE75ImwWCooDU1IX6BtFBbqMzAypBLcYxMKc7pEA7se7MiEXiGET8BD7NWCYy+Gm4v
 xo32t0jwcI1xZ2hc4rrG7kLEvVfDZ2YUZsJI8Ad4oolmeZVJy//p5Cv5VLW6KYTXCG2TrDC67
 LoQVDf0jAV616OOAAF+jKJIsMqu6Cq2rlSVykk2ZZbKHmByhbdRjqPiUhVpY+ffdMkC7yHUgx
 YLgRrU20ShewwEukIpbl+B7KfZ0zmaawX8Z9CdSYrRKnru5ohJTg3S4SxjyE2WnxZGOBRtFot
 p6i+CXENZsa4rgfp6x9GEoNZj4Rof+xn0WxjqpNP7dNHQECpVls3CHZj7rzGc8TIPzzSqq+1I
 xVHhIuSLdGsq8xL6n8JaiwDD6yqNVPhfeFiSF0SA9MyJulhLZF6n0cQ3zCSauqUSDR7w8XIzf
 O+QLobMdBq81IEEue1nmPN8WlMjIgCZxSjj1H7V2a1hBItJcRp5uCwDjv1vhqM/Yvbj1qkKEt
 lwPpFZ7VPrCtQYmHXOiSDZVRplbPgeD8reNkF4ylUttAds+sCpXi7XwkW/amkRCCjLH5K3bsw
 iksEKWMxTuKZznLo8ThpwcjNdmN6ylK+eBLvmzhHhiW50uLoKZ4wk3YHFRG5ZZyiVoTN++Hji
 IxFdNsp/402JjDicaaBR3WlWnjX586w7YTzQ1x9LvCYrPuIJ8TclTw1NYrMFqu9I8qwXxzJBn
 S3rdkwTgwAzhDmBBaDAvDU72X8nw5Z3tHJ4YIHgDtsFRGEnslYRbRuv+aPzqpybQqwnBOsODv
 44eaAD7nyQxBDF6tZyig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm save/restore code is fairly small, so in order to
separate the s3c and s5p platforms, adding an s5p specific
copy instead of sharing it is actually easier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s5pv210/Makefile     |  7 -----
 arch/arm/mach-s5pv210/pm.c         | 45 ++++++++++++++++++++++++++++--
 arch/arm/mach-s5pv210/regs-clock.h |  2 +-
 arch/arm/mach-s5pv210/s5pv210.c    |  2 --
 arch/arm/plat-samsung/Makefile     |  4 +--
 5 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index e7b551e18e5c..aa0a1f091daf 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -3,12 +3,5 @@
 # Copyright (c) 2010 Samsung Electronics Co., Ltd.
 # 		http://www.samsung.com/
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/arch/arm/plat-samsung/include
-
-# Core
-
 obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
-
-# machine support
-
 obj-y				+= s5pv210.o
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index efdb5a27c060..d59c094cdea8 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -13,15 +13,56 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 #include "regs-clock.h"
 
+/* helper functions to save and restore register state */
+struct sleep_save {
+	void __iomem	*reg;
+	unsigned long	val;
+};
+
+#define SAVE_ITEM(x) \
+	{ .reg = (x) }
+
+/**
+ * s3c_pm_do_save() - save a set of registers for restoration on resume.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Run through the list of registers given, saving their contents in the
+ * array for later restoration when we wakeup.
+ */
+static void s3c_pm_do_save(struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++) {
+		ptr->val = readl_relaxed(ptr->reg);
+		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
+	}
+}
+
+/**
+ * s3c_pm_do_restore() - restore register values from the save list.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Restore the register values saved from s3c_pm_do_save().
+ *
+ * WARNING: Do not put any debug in here that may effect memory or use
+ * peripherals, as things may be changing!
+*/
+
+static void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++)
+		writel_relaxed(ptr->val, ptr->reg);
+}
+
 static struct sleep_save s5pv210_core_save[] = {
 	/* Clock ETC */
 	SAVE_ITEM(S5P_MDNIE_SEL),
diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
index 2a35c831a9b0..8c7530614e37 100644
--- a/arch/arm/mach-s5pv210/regs-clock.h
+++ b/arch/arm/mach-s5pv210/regs-clock.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_ARCH_REGS_CLOCK_H
 #define __ASM_ARCH_REGS_CLOCK_H __FILE__
 
-#include <plat/map-base.h>
+#define S3C_VA_SYS		((void __iomem __force *)0xF6100000)
 
 #define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
 
diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index 868f9c20419d..a21ed3bb992a 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -13,8 +13,6 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 
-#include <plat/map-base.h>
-
 #include "common.h"
 #include "regs-clock.h"
 
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index d88b9b84f3a9..025ce22876c1 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -24,9 +24,7 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
 
 # PM support
 
-obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
-obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm-common.o
-obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
+obj-$(CONFIG_SAMSUNG_PM)	+= pm.o pm-common.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
-- 
2.20.0

