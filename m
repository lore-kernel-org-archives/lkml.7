Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54080C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2293D21852
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lVC/sSd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDJXN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:13:27 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56366 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfDJXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:13:25 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::360])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7D1EE5C0F1A;
        Thu, 11 Apr 2019 01:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554938003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=sNaP+432rMOAKfpdDBWbe8xpTEc36znVYg15CVLRLNQ=;
        b=lVC/sSd3a56Z9ev2QaMhtCgNCro+LOLc3OAFOY+94SsXC9znbF/6h+S/NzqnKIojYMMZ1y
        1iJjd8ZtoqvFqpjxffYsrU/SnXRELuPeFbjAVMZEeVN6kqtqtOr0n7K5TeEx/qCUMDtBB/
        7bsWqNPpVorMX03z3Tlt4/h9JzLBvlU=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     linux@armlinux.org.uk, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: imx: use generic function to exit coherency
Date:   Thu, 11 Apr 2019 01:14:12 +0200
Message-Id: <3f58c55e48c28f41e92883e81c675b8478af6a5e.1554937960.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The common ARM architecture code provides a generic function to exit
coherency called v7_exit_coherency_flush(). Replace the machine
specific implementation using the generic function.

Tested on a i.MX 6Dual by hotplugging the secondary CPU under load
through sysfs several 1000 times.

Tested-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/hotplug.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index b35e99cc5e5b..7a74a9b89a49 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -12,32 +12,12 @@
 
 #include <linux/errno.h>
 #include <linux/jiffies.h>
+#include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/proc-fns.h>
 
 #include "common.h"
 
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-		"mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, %3\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
-	  : "cc");
-}
-
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -45,7 +25,7 @@ static inline void cpu_enter_lowpower(void)
  */
 void imx_cpu_die(unsigned int cpu)
 {
-	cpu_enter_lowpower();
+	v7_exit_coherency_flush(louis);
 	/*
 	 * We use the cpu jumping argument register to sync with
 	 * imx_cpu_kill() which is running on cpu0 and waiting for
-- 
2.21.0

