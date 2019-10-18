Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB4BCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32D420659
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408573AbfJRQc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:32:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442975AbfJRQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:31:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MNcYX-1ifWBP0o6V-00P6cd; Fri, 18 Oct 2019 18:30:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
Date:   Fri, 18 Oct 2019 18:29:15 +0200
Message-Id: <20191018163047.1284736-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018163047.1284736-1-arnd@arndb.de>
References: <20191018163047.1284736-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a8o20A1aeMq66ylH+ZWPfDYZa2uZdpXnGwy6HcyXRtObZyyvUry
 wKkmb06WaBy2sqybhraDlVUY9dM6RoCDORnE55WXFQpwdAw9s1ZnS8K4qFb07qSMfouNQlX
 B2od+y4VfrLuLExqWrrMANYKFpu1xHQxbbD44QqMlCqpY3ii0WyXen7I52Lo/HBx0r3cnUd
 Ij40iRAo12PjYYEU5c/ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O15dYrgphrI=:4W1saKBI4JpXwNNg4EOkNp
 1uiAx1Kdch0ukBarp2iAd0+RDJUk29oqWWe0AycJapz/zJmBWe+Z/+VH1zJn4Lh/VDUyUD0fl
 h98N4WgzqRpnTvX18PBVUXCLV4AC3TAZhZEKXO+CSaxxHtp9ByvXdbJwdVMZmHY1tyJU/qL7m
 GWslC+2UZwmwYNLTvQwsAcSLy54BdiwoW+Iqq7CSVOqpT8/0teoEtwA1ZvwLTLnYtCnz3jLcW
 S2NmFeA6Au9iFK0IewvSjpozvN+Ib3gz7o0RZOoeGRk1LEpG58HAGNTOHcOngaUmU7ANaI/45
 zRBevca/UidqjhJsn7lCdVQOwn9ahFmjBeHUjFuuSh6djHsD7Y/EKWujLTFQj+GlW5FHbi6/I
 9oIUUsFiz/I2h+G1HgKeDxFOEURRrTqXrOxhOvYQl+DG0PDxPedErniCdhdM/h/SsVDLAX60k
 nxuptKnFGjMOOGyG7HWZn84LEvBEXMNAYrVrza6Lgg7IFKNdeKUa+Hixx6BZ1rqPxKcHqDVhK
 hQwECtVoxSq176lQrDuSz/ZNeOk42FzWHgn4MvD6M0JQNWepCx1hJ2hwl5UxP5GFQlxtGLhPY
 RUfp+14vyX18b/Mpj6AmcrO5z7Nh6trj1DdksX6abAVENamnthklMPJhxhEiUtMRJu8hb2ml8
 oRTMcrgjiuAnnbnvpOHEkaWLcuZV5/VAVoECAnRacffmbZ1sl7xkYjp3B4h+w+gm4ph2tgj/z
 HG9X8ZEQoVCoYvxiI9TIRA5Q29JboHPd8lAVwekwXj4U3nu8VjKl4DMISIIq9zYbOBZMPuEPT
 6KZVDquvzm+RYBV3DxziY7dM09GffOKF+ueUN6iEoke8B+/9YvXREqIbE9snDyhADqGhB5BFl
 wgsN6bdCON4tL1zf2Zug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
globally. Do the minimal conversion by setting .nr_irqs in each
machine descriptor.

Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
.nr_irqs the original value there, while using the plain NR_EP93XX_IRQS
everywhere else.

---
It's been a while since I did this, no idea what else is needed
here or if this is correct at all.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                               | 2 ++
 arch/arm/mach-ep93xx/adssphere.c               | 1 +
 arch/arm/mach-ep93xx/edb93xx.c                 | 8 ++++++++
 arch/arm/mach-ep93xx/gesbc9312.c               | 1 +
 arch/arm/mach-ep93xx/{include/mach => }/irqs.h | 7 -------
 arch/arm/mach-ep93xx/micro9.c                  | 4 ++++
 arch/arm/mach-ep93xx/simone.c                  | 1 +
 arch/arm/mach-ep93xx/snappercl15.c             | 1 +
 arch/arm/mach-ep93xx/soc.h                     | 1 +
 arch/arm/mach-ep93xx/ts72xx.c                  | 3 ++-
 arch/arm/mach-ep93xx/vision_ep9307.c           | 1 +
 11 files changed, 22 insertions(+), 8 deletions(-)
 rename arch/arm/mach-ep93xx/{include/mach => }/irqs.h (94%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b6681b61e46c..cca3d240a01e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -365,6 +365,8 @@ config ARCH_EP93XX
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
+	select IRQ_DOMAIN
+	select SPARSE_IRQ
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 57cfd8ebe04f..bb5e7b3c2fba 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -32,6 +32,7 @@ static void __init adssphere_init_machine(void)
 MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 7b7280c21ee0..19f38f58ff46 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -243,6 +243,7 @@ static void __init edb93xx_init_machine(void)
 MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -256,6 +257,7 @@ MACHINE_END
 MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	/* Maintainer: George Kashperko <george@chas.com.ua> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -269,6 +271,7 @@ MACHINE_END
 MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -282,6 +285,7 @@ MACHINE_END
 MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -295,6 +299,7 @@ MACHINE_END
 MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -308,6 +313,7 @@ MACHINE_END
 MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -321,6 +327,7 @@ MACHINE_END
 MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -334,6 +341,7 @@ MACHINE_END
 MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 8905db1edd5a..6bc86b554864 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -32,6 +32,7 @@ static void __init gesbc9312_init_machine(void)
 MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/irqs.h
similarity index 94%
rename from arch/arm/mach-ep93xx/include/mach/irqs.h
rename to arch/arm/mach-ep93xx/irqs.h
index 244daf83ce6d..3ffdb3a2f3e4 100644
--- a/arch/arm/mach-ep93xx/include/mach/irqs.h
+++ b/arch/arm/mach-ep93xx/irqs.h
@@ -1,8 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-ep93xx/include/mach/irqs.h
- */
-
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
@@ -73,7 +69,4 @@
 #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
 #define EP93XX_BOARD_IRQS		32
 
-#define NR_IRQS				(NR_EP93XX_IRQS + EP93XX_BOARD_IRQS)
-
-
 #endif
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index b18ebf26da45..271898b17296 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -76,6 +76,7 @@ static void __init micro9_init_machine(void)
 MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -89,6 +90,7 @@ MACHINE_END
 MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -102,6 +104,7 @@ MACHINE_END
 MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -115,6 +118,7 @@ MACHINE_END
 MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 8a53b74dc4b2..e2f7243629fe 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -119,6 +119,7 @@ static void __init simone_init_machine(void)
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	/* Maintainer: Ryan Mallon */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 703f25f19d51..29c8ea34c8e1 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -153,6 +153,7 @@ static void __init snappercl15_init_machine(void)
 MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	/* Maintainer: Ryan Mallon */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index f2dace1c9154..770743bbaf80 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -10,6 +10,7 @@
 #define _EP93XX_SOC_H
 
 #include <mach/ep93xx-regs.h>
+#include "irqs.h"
 
 /*
  * EP93xx Physical Memory Map:
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index e0e1b11032f1..9ac0308f3d71 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -22,7 +22,6 @@
 
 #include "gpio-ep93xx.h"
 #include "hardware.h"
-#include <mach/irqs.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -350,6 +349,7 @@ static void __init ts72xx_init_machine(void)
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
@@ -414,6 +414,7 @@ static void __init bk3_init_machine(void)
 MACHINE_START(BK3, "Liebherr controller BK3.1")
 	/* Maintainer: Lukasz Majewski <lukma@denx.de> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index cbcba3136d74..04f9f15be248 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -302,6 +302,7 @@ static void __init vision_init_machine(void)
 MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= NR_EP93XX_IRQS + EP93XX_BOARD_IRQS,
 	.map_io		= vision_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.init_time	= ep93xx_timer_init,
-- 
2.20.0

