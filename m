Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DCEC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2C32189F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406335AbfHIJdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:23 -0400
Received: from shell.v3.sk ([90.176.6.54]:51955 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406108AbfHIJdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9BE68D63BA;
        Fri,  9 Aug 2019 11:33:15 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wpc5XvMN1xAD; Fri,  9 Aug 2019 11:32:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A99CED63D7;
        Fri,  9 Aug 2019 11:32:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jUS-Pko0ZC9i; Fri,  9 Aug 2019 11:32:23 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D0F6ED63CD;
        Fri,  9 Aug 2019 11:32:18 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 12/19] ARM: mmp: DT: convert timer driver to use TIMER_OF_DECLARE
Date:   Fri,  9 Aug 2019 11:31:51 +0200
Message-Id: <20190809093158.7969-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes things just a tiny bit simpler.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/mmp-dt.c  |  5 ++---
 arch/arm/mach-mmp/mmp2-dt.c |  5 ++---
 arch/arm/mach-mmp/time.c    | 38 +++++++++++--------------------------
 3 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 35559792d5cca..91214996acecc 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -9,14 +9,13 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
=20
 #include "common.h"
=20
-extern void __init mmp_dt_init_timer(void);
-
 static const char *const pxa168_dt_board_compat[] __initconst =3D {
 	"mrvl,pxa168-aspenite",
 	NULL,
@@ -32,8 +31,8 @@ static void __init mmp_init_time(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	mmp_dt_init_timer();
 	of_clk_init(NULL);
+	timer_probe();
 }
=20
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 8eec881191f4b..510c762ddc484 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -10,21 +10,20 @@
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
=20
 #include "common.h"
=20
-extern void __init mmp_dt_init_timer(void);
-
 static void __init mmp_init_time(void)
 {
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
 	of_clk_init(NULL);
-	mmp_dt_init_timer();
+	timer_probe();
 }
=20
 static const char *const mmp2_dt_board_compat[] __initconst =3D {
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 483df32583be6..3f6fd0be00512 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -195,30 +195,17 @@ void __init mmp_timer_init(int irq, unsigned long r=
ate)
 	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
 }
=20
-#ifdef CONFIG_OF
-static const struct of_device_id mmp_timer_dt_ids[] =3D {
-	{ .compatible =3D "mrvl,mmp-timer", },
-	{}
-};
-
-void __init mmp_dt_init_timer(void)
+static int __init mmp_dt_init_timer(struct device_node *np)
 {
-	struct device_node *np;
 	struct clk *clk;
 	int irq, ret;
 	unsigned long rate;
=20
-	np =3D of_find_matching_node(NULL, mmp_timer_dt_ids);
-	if (!np) {
-		ret =3D -ENODEV;
-		goto out;
-	}
-
 	clk =3D of_clk_get(np, 0);
 	if (!IS_ERR(clk)) {
 		ret =3D clk_prepare_enable(clk);
 		if (ret)
-			goto out;
+			return ret;
 		rate =3D clk_get_rate(clk) / 2;
 	} else if (cpu_is_pj4()) {
 		rate =3D 6500000;
@@ -227,18 +214,15 @@ void __init mmp_dt_init_timer(void)
 	}
=20
 	irq =3D irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret =3D -EINVAL;
-		goto out;
-	}
+	if (!irq)
+		return -EINVAL;
+
 	mmp_timer_base =3D of_iomap(np, 0);
-	if (!mmp_timer_base) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
+	if (!mmp_timer_base)
+		return -ENOMEM;
+
 	mmp_timer_init(irq, rate);
-	return;
-out:
-	pr_err("Failed to get timer from device tree with error:%d\n", ret);
+	return 0;
 }
-#endif
+
+TIMER_OF_DECLARE(mmp_timer, "mrvl,mmp-timer", mmp_dt_init_timer);
--=20
2.21.0

