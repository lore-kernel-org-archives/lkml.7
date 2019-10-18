Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C32CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9821852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409012AbfJRPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505165AbfJRPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2w8Y-1iKNOx0fMK-003MKP; Fri, 18 Oct 2019 17:42:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 41/46] ARM: pxa: move it8152 PCI support into machine
Date:   Fri, 18 Oct 2019 17:41:56 +0200
Message-Id: <20191018154201.1276638-41-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qEl9cjQP4jyS4qxefcQzFCM3uP5InkPkvne7KhgjFGqfdepw0ze
 BfBs+1RGSS5OnS+jwtbBaruL9sYCZyzLgpJu+h9MhEryoVQStbfDkr1SIkqCYKVFKm5fjaH
 o6g37RJhoVZz1wpsh5v91LLNGX+9V2dQ+AKKoNXu7RezLWr/xCYZWr6JvyFOCn5eSP+2qlx
 YBlbR1BTWfB3i9M8wkSRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:np0pVgM23GE=:+pvh0Wx7At+Uwi2OwfrOm0
 SCRf4wYf1CSkawelW6xLjErUh+tdKVU73XOqlWk/nfsjS4w3tKg+pkRnHPx4CE1WnKs5qgfTG
 Ek9jO0I83Iao//9KJ0fQAttuUSj6CuhpcW+M6X2R8JbyRoUgPhqiajc7A7j/31LeC7SrHTYfB
 kDknGSiHNbt1E488AzYoLw5FnNxw2hEC9zbsmJSdNIKFWWuSVapoAIX4WzTmlQHxZmf4j4jEh
 3RDjqPWzUdpCTKhX7eQ9T48bMYAyAkEJAysDEwTvChktx8phGv43FCmZ37O8SiHKCZ3GKzGLL
 7OLhY3cA4jVh6LKPkkhhBvQjN5EngcgMbU8cP4RM7LWCnrfI7dV+OnZt0HEnt5z9BxpT+vWUR
 BLvABQqmOcwlK26DWSpId+wl4e06up6C8guSPnJXbn8NDeyQ3vmyNv+H1MZnUaCg8/3R0quD3
 vP0JmB/wMFzph0V9CHKuIzXX+QltCA7Z+3glncaqVj7VdeY5MHebHgfDZk7yWOUTu51ViLOcf
 m4oPkn/CtNl9QN00tWoyNSCsg8IAEa7dsrSgE6rbsYT34MM03ljFpxypUIpp4TtLg4EcVYdWL
 8pE7JxurRi/g1DsXCaMs3PENx6gjCUSZn3XZb3unXdQl/R8TBjG7ZQcOBcN0BaUM5dStC/xQB
 ddvHeXeMvT6APL4YFOcq3eyB5vhgAL7jflpNSKXomFWMTnG7wRzsUIqk3FxjAHZvsG2VuPj4I
 UbaT69roGIBailpqB4OxihTWPriYVhmmvBmc5kIEfeD1SOVjWzjrKI8Vz9wPJWfnQoNFJGhTA
 VidOBSvtCr9jYXBjJ+B/SqTjh9szSLFPrvFM2NwJVZwbYvLDeAbFy62FDrIrJ4uAq2+Y9PicC
 2mjliZ42cErF2s8kHZIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was written as a "common" driver that could
be shared between platforms, but it was never actually shared
and now written in a completely portable way either, so just
move it into the platform to avoid header file dependencies.

Unfortunately, this driver uses the DMABOUNCE feature, which
is likely to cause problems in a multiplatform configuration,
need to investigate further. Apparently the cm-x255 only
has 64MB of RAM and does not need bouncing, but the cm-x270
can have anywhere between 32MB and 128MB, which is where
we exceed the 64 MB of address space in the chip.

Another problem is the ARCH_HAS_DMA_SET_COHERENT_MASK flag,
which messes up other PCI implementations.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                          | 6 ------
 arch/arm/common/Makefile                                  | 1 -
 arch/arm/mach-pxa/Kconfig                                 | 8 +++++++-
 arch/arm/mach-pxa/Makefile                                | 1 +
 arch/arm/mach-pxa/cm-x2xx-pci.c                           | 2 +-
 arch/arm/mach-pxa/cm-x2xx.c                               | 3 +--
 arch/arm/{common/it8152.c => mach-pxa/pci-it8152.c}       | 3 ++-
 .../asm/hardware/it8152.h => mach-pxa/pci-it8152.h}       | 2 --
 8 files changed, 12 insertions(+), 14 deletions(-)
 rename arch/arm/{common/it8152.c => mach-pxa/pci-it8152.c} (99%)
 rename arch/arm/{include/asm/hardware/it8152.h => mach-pxa/pci-it8152.h} (98%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a50efb559f3..b01f762abbda 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1146,12 +1146,6 @@ config PCI_NANOENGINE
 	help
 	  Enable PCI on the BSE nanoEngine board.
 
-config PCI_HOST_ITE8152
-	bool
-	depends on PCI && MACH_ARMCORE
-	default y
-	select DMABOUNCE
-
 config ARM_ERRATA_814220
 	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
 	depends on CPU_V7
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 219a260bbe5f..8cd574be94cf 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_CPU_V7)		+= secure_cntvoff.o
-obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
 AFLAGS_mcpm_head.o		:= -march=armv7-a
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f60bc29aef68..0553fca46f5a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -125,13 +125,19 @@ config CSB726_CSB701
 
 config MACH_ARMCORE
 	bool "CompuLab CM-X255/CM-X270 modules"
-	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
 	select IWMMXT
 	select HAVE_PCI
 	select NEED_MACH_IO_H if PCI
 	select PXA25x
 	select PXA27x
 
+config PCI_HOST_ITE8152
+	bool
+	depends on PCI && MACH_ARMCORE
+	default y
+	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select DMABOUNCE
+
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
 	select PXA27x
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index e0df39b0238d..01cad198bdb0 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CSB726_CSB701)	+= csb701.o
 obj-$(CONFIG_MACH_ARMCORE)      += cm-x2xx.o cm-x255.o cm-x270.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_MACH_ARMCORE)	+= cm-x2xx-pci.o
+obj-$(CONFIG_PCI_HOST_ITE8152)  += pci-it8152.o
 endif
 obj-$(CONFIG_MACH_ARMCORE)	+= cm_x2xx-pcmcia.o cm_x255-pcmcia.o cm_x270-pcmcia.o
 obj-$(CONFIG_MACH_EM_X270)	+= em-x270.o
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index f1c61c6b5610..a5689946d8c1 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -21,7 +21,7 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
-#include <asm/hardware/it8152.h>
+#include "pci-it8152.h"
 
 void __iomem *it8152_base_address;
 static int cmx2xx_it8152_irq_gpio;
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index 9b030eccd548..5ce23842239e 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -37,10 +37,9 @@
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/smemc.h>
 
-#include <asm/hardware/it8152.h>
-
 #include "generic.h"
 #include "cm-x2xx-pci.h"
+#include "pci-it8152.h"
 
 extern void cmx255_init(void);
 extern void cmx270_init(void);
diff --git a/arch/arm/common/it8152.c b/arch/arm/mach-pxa/pci-it8152.c
similarity index 99%
rename from arch/arm/common/it8152.c
rename to arch/arm/mach-pxa/pci-it8152.c
index 9ec740cac469..af99c990f0c1 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/mach-pxa/pci-it8152.c
@@ -25,7 +25,8 @@
 #include <linux/export.h>
 
 #include <asm/mach/pci.h>
-#include <asm/hardware/it8152.h>
+
+#include "pci-it8152.h"
 
 #define MAX_SLOTS		21
 
diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/mach-pxa/pci-it8152.h
similarity index 98%
rename from arch/arm/include/asm/hardware/it8152.h
rename to arch/arm/mach-pxa/pci-it8152.h
index e175c2384f28..85844c5fe462 100644
--- a/arch/arm/include/asm/hardware/it8152.h
+++ b/arch/arm/mach-pxa/pci-it8152.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/arm/hardware/it8152.h
- *
  * Copyright Compulab Ltd., 2006,2007
  * Mike Rapoport <mike@compulab.co.il>
  *
-- 
2.20.0

