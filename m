Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7ACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116222467
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502228AbfJRPo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505152AbfJRPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MAwTn-1iAEvS44c5-00BIwO; Fri, 18 Oct 2019 17:42:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/46] ARM: pxa: stop using mach/bitfield.h
Date:   Fri, 18 Oct 2019 17:41:21 +0200
Message-Id: <20191018154201.1276638-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RMPIXEZ8B8Uok2FSd/RsBSJ9LSkrToSq1PlXx8YByCDFZq6HKXO
 KnKe5fjMzjccpDiN5gwwbCczfg8ynNnl+hPrJO+a8PXsXmntRxNg4ozDolk9RjQpP8Zdpik
 lbMmZLkdEO2w03TYSr5mMYOpaKIOACmd3xYqlWYLZ96deVragbPJL5squJTDw1pzXyT0Dxe
 cZJNuN3xPdaEgCk9TkpGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Msk+bU1wGA=:TmrLD7gfKbF2/MYts8rrO5
 rb7te9H+HV4fW5jwPd9ReehWNBi/EPHqQx+KCgjdx0wnBv0ap+FPaWRTA5B41snTaRncLo4b9
 sUBRSE0vAOpimcPBjCtY69H7XsHrPUCrXEyMNoaDKl5at215Qv/37C/WVg1cNXaXXgL2wWiGm
 6+lTrQSTDF1qsH5R2RGcK8JMTeCe0PYJUh6ydLEhE9cGxN+WWrIm044zF/4Sj9N47QBArI6wi
 SXH3WGqxQHgxGuqB+TXtkwOY0a5+HKdaBoYW71yCZXL2qRO4XXA5RGxHZAhFP0kKZcV+1CY1T
 xdrjBhoQj0SOdm/fENyzDy/quuiZbnOd+myliWyLU/Wv2ILpI0ZOWaUO2nh3FVyz5pqgeSdrv
 1pyrY6TNWwwkrfshdRU5tbWefz5syOrpiDz6813tZUdortco9jy8aTfXad/tHF8LtlI283eR3
 VNtr8eD4tTARzPStsOJjzd+9jbdQ3va+hHi2GfL37dS1J+9EAUB86tj21evWIDAy/1j0oMVMf
 YC71YRTkfAX2OpEhO9qkEtKfRQCVkXlu8mxaHsqed5U4u1ZB92lXD0wfapcRB09f5C7hZWVrO
 17K8n1n2De9kpHFEVCbGeKMe/AQMHzBLL8Bz0fvtMrgE7EpeZ+p4z2jd2eGz6KxTbZqp5qzWP
 DZJcJLyQBgvN42lSQvxENc5kxrJFVrwD80koXpTDVXhZJ55/OC9ebkTpt9JzSVMVGErz1TV2+
 mIs9CHNjdzm9m9VjxYsWNPGHWR1hzmkWbpWWCZCMMBfxGUG37FFy9/bw6Zazidt3Z+lelKshP
 yaevwfEbLlJmNceg8Jekxa5lYmamSzmD7wzCmGJpjgeQCP+lupbIgpHFGSLlGEk+lUOt6thrg
 WRZS5pE3ChqqFuqxACWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two identical copies of mach/bitfield.h, one for
mach-sa1100 and one for mach-pxa. The pxafb driver only
makes use of two macros, which can be trivially open-coded
in the header.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/idp.c                   | 1 -
 arch/arm/mach-pxa/include/mach/regs-lcd.h | 5 +++--
 arch/arm/mach-pxa/regs-u2d.h              | 2 --
 drivers/video/fbdev/pxafb.c               | 1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 57c0511472bc..525d01ddfbbb 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -30,7 +30,6 @@
 #include "pxa25x.h"
 #include "idp.h"
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/bitfield.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/smc91x.h>
 
diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index e2b6e3d1f625..6a434675f84a 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_ARCH_REGS_LCD_H
 #define __ASM_ARCH_REGS_LCD_H
 
-#include <mach/bitfield.h>
-
 /*
  * LCD Controller Registers and Bits Definitions
  */
@@ -86,6 +84,9 @@
 #define LCCR0_OUC	(1 << 25)	/* Overlay Underlay control bit */
 #define LCCR0_LDDALT	(1 << 26)	/* LDD alternate mapping control */
 
+#define Fld(Size, Shft)	(((Size) << 16) + (Shft))
+#define FShft(Field)	((Field) & 0x0000FFFF)
+
 #define LCCR1_PPL	Fld (10, 0)	/* Pixels Per Line - 1 */
 #define LCCR1_DisWdth(Pixel)	(((Pixel) - 1) << FShft (LCCR1_PPL))
 
diff --git a/arch/arm/mach-pxa/regs-u2d.h b/arch/arm/mach-pxa/regs-u2d.h
index fe4c80ad87ec..ab517ba62c9a 100644
--- a/arch/arm/mach-pxa/regs-u2d.h
+++ b/arch/arm/mach-pxa/regs-u2d.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_ARCH_PXA3xx_U2D_H
 #define __ASM_ARCH_PXA3xx_U2D_H
 
-#include <mach/bitfield.h>
-
 /*
  * USB2 device controller registers and bits definitions
  */
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index ece691a0f18a..e68b8a69db92 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -64,7 +64,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
-#include <mach/bitfield.h>
 #include <linux/platform_data/video-pxafb.h>
 
 /*
-- 
2.20.0

