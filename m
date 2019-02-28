Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20D3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6540E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dagExFZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbfB1PAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44062 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732599AbfB1PAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:00:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id v185so4089071lfa.11;
        Thu, 28 Feb 2019 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJuHOAPojVX7qrqRXbHoJbDHdudT5MkzR884VeGeyOI=;
        b=dagExFZxekXp/+3chAffr8/lb5lhkLqTYDVY3Jgd2EZdET4MJmo+963n2XecheQd+X
         5SNX2lwdWEC0mptv1X4ve2aZrr5tuA+SxTHrxJzxAHiK0ODqbnPpZnjSI7VY397YIEnu
         ivD3LOgNvdtc9kP0u6PBZOrO2xrzuZXlH+Xxq8QawaYAChILUUWffdY0syKOIfPWE+gw
         PLwASactz9G72jr2bx2DLPM5f8Ksf1FH2dbBOzrspZPFRAVqIUpj/OS19Xjh4pvVQwFv
         KVkfib1xkP0+Fjk02q/xFOUTktFugZacHcAYiK6SBypEz73RruWiyAGeNRWkJv+pglUW
         rkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJuHOAPojVX7qrqRXbHoJbDHdudT5MkzR884VeGeyOI=;
        b=UbrjXy0n1duJPOjgYU0QbpJ5a3owbopAmsCVfyDMccluZxawg3pIyOJt0E1/lYlcFT
         zd7kp2lzXfrIOqLC/Fx8on/3fDDAb1xu7bw1/dGwAd63wvSeFIavdu+8ERRTIz347/Y7
         tn6wpRQbmIRVIw7rdCcZs2fWP/X7tmlK1No3xcyTrHRZvi49G/b5nu/azL8oz3ardiIu
         8zO0b41kl8abKYACW/gOTslGr9Iw4FdgO3K1/yTjS4y14TbxIMpfmGRQfXfnWUaW8c8t
         i4ozfXEfIEq7xe6s8s7Ko6xnXOsgsuaKjVAxtWGszTHB0aXpG6rvCZy/KK3uAFDb0+Lk
         U9nA==
X-Gm-Message-State: AHQUAubmWaQGmKOrGE8NRmkSFAU/lggInAkKB+UWCO1Tw8+gbKVMavcK
        kPUM4eooTL6uGidHShIM/kQ=
X-Google-Smtp-Source: AHgI3IYw36fKI1x7vihYSnoWfIvrQg+SanddOrjigPuDOl/9X/zHpXXrE628FwG7+B6wOgjwQdZY+g==
X-Received: by 2002:a19:8b82:: with SMTP id n124mr4447621lfd.118.1551365999163;
        Thu, 28 Feb 2019 06:59:59 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/7] ARM: tegra: Don't apply CPU erratas in insecure mode
Date:   Thu, 28 Feb 2019 17:59:35 +0300
Message-Id: <20190228145937.27725-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU isn't allowed to touch secure registers while running under secure
monitor. Hence skip applying of CPU erratas in the reset handler if
Trusted Foundations firmware presents.

Partially based on work done by Michał Mirosław [1].

[1] https://www.spinics.net/lists/arm-kernel/msg594768.html

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 23 ++++++++++++-----------
 arch/arm/mach-tegra/reset.c         |  3 +++
 arch/arm/mach-tegra/reset.h         |  9 +++++++--
 arch/arm/mach-tegra/sleep-tegra20.S |  4 ++++
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..6bea95d165fa 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -29,8 +29,6 @@
 
 #define PMC_SCRATCH41	0x140
 
-#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
-
 #ifdef CONFIG_PM_SLEEP
 /*
  *	tegra_resume
@@ -121,6 +119,12 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+	adr	r12, __tegra_cpu_reset_handler_data
+	ldr	r5, [r12, #RESET_DATA(TF_PRESENT)]
+	cmp	r5, #0
+	bne	after_errata
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
@@ -155,7 +159,6 @@ after_errata:
 	and	r10, r10, #0x3			@ R10 = CPU number
 	mov	r11, #1
 	mov	r11, r11, lsl r10  		@ R11 = CPU mask
-	adr	r12, __tegra_cpu_reset_handler_data
 
 #ifdef CONFIG_SMP
 	/* Does the OS know about this CPU? */
@@ -169,10 +172,9 @@ after_errata:
 	cmp	r6, #TEGRA20
 	bne	1f
 	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov32	r5, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
 	mov	r0, #CPU_NOT_RESETTABLE
 	cmp	r10, #0
-	strneb	r0, [r5, #__tegra20_cpu1_resettable_status_offset]
+	strneb	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
 1:
 #endif
 
@@ -277,14 +279,13 @@ ENDPROC(__tegra_cpu_reset_handler)
 	.align L1_CACHE_SHIFT
 	.type	__tegra_cpu_reset_handler_data, %object
 	.globl	__tegra_cpu_reset_handler_data
+	.globl	__tegra_cpu_reset_handler_data_offset
+	.equ	__tegra_cpu_reset_handler_data_offset, \
+					. - __tegra_cpu_reset_handler_start
 __tegra_cpu_reset_handler_data:
-	.rept	TEGRA_RESET_DATA_SIZE
-	.long	0
+	.rept   TEGRA_RESET_DATA_SIZE
+	.long   0
 	.endr
-	.globl	__tegra20_cpu1_resettable_status_offset
-	.equ	__tegra20_cpu1_resettable_status_offset, \
-					. - __tegra_cpu_reset_handler_start
-	.byte	0
 	.align L1_CACHE_SHIFT
 
 ENTRY(__tegra_cpu_reset_handler_end)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index dc558892753c..b02ae7699842 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "irammap.h"
@@ -89,6 +90,8 @@ static void __init tegra_cpu_reset_handler_enable(void)
 
 void __init tegra_cpu_reset_handler_init(void)
 {
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] =
+		trusted_foundations_registered();
 
 #ifdef CONFIG_SMP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 9c479c7925b8..db0e6b3097ab 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -25,7 +25,11 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_DATA_SIZE		6
+#define TEGRA_RESET_RESETTABLE_STATUS	6
+#define TEGRA_RESET_TF_PRESENT		7
+#define TEGRA_RESET_DATA_SIZE		8
+
+#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
 #ifndef __ASSEMBLY__
 
@@ -49,7 +53,8 @@ void __tegra_cpu_reset_handler_end(void);
 	 (u32)__tegra_cpu_reset_handler_start)))
 #define tegra20_cpu1_resettable_status \
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
-	 (u32)__tegra20_cpu1_resettable_status_offset))
+	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_RESETTABLE_STATUS] - \
+	 (u32)__tegra_cpu_reset_handler_start)))
 #endif
 
 #define tegra_cpu_reset_handler_offset \
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index dedeebfccc55..50d51d3465f6 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -28,6 +28,7 @@
 #include <asm/cache.h>
 
 #include "irammap.h"
+#include "reset.h"
 #include "sleep.h"
 
 #define EMC_CFG				0xc
@@ -53,6 +54,9 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
+#define __tegra20_cpu1_resettable_status_offset \
+	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
+
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
-- 
2.20.1

