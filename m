Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD09FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843BF2342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfH3WQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:16:52 -0400
Received: from shell.v3.sk ([90.176.6.54]:56370 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfH3WQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:16:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 11A8AD8823;
        Sat, 31 Aug 2019 00:08:56 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 22cCTkkRqf53; Sat, 31 Aug 2019 00:08:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 87A94D87F2;
        Sat, 31 Aug 2019 00:08:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x2B2gZoGgtqq; Sat, 31 Aug 2019 00:07:59 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DF268D87F3;
        Sat, 31 Aug 2019 00:07:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "To : Olof Johansson" <olof@lixom.net>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 13/16] ARM: mmp: move cputype.h to include/linux/soc/
Date:   Sat, 31 Aug 2019 00:07:40 +0200
Message-Id: <20190830220743.439670-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830220743.439670-1-lkundrak@v3.sk>
References: <20190830220743.439670-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move cputype.h away from mach-mmp/ so that the drivers outside that
directory are able to tell the precise silicon revision. The MMP3 USB OTG
PHY driver needs this.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 MAINTAINERS                                            | 1 +
 arch/arm/mach-mmp/common.c                             | 2 +-
 arch/arm/mach-mmp/devices.c                            | 2 +-
 arch/arm/mach-mmp/mmp2.c                               | 2 +-
 arch/arm/mach-mmp/pm-mmp2.c                            | 2 +-
 arch/arm/mach-mmp/pm-pxa910.c                          | 2 +-
 arch/arm/mach-mmp/pxa168.c                             | 2 +-
 arch/arm/mach-mmp/pxa910.c                             | 2 +-
 arch/arm/mach-mmp/time.c                               | 2 +-
 {arch/arm/mach-mmp =3D> include/linux/soc/mmp}/cputype.h | 0
 10 files changed, 9 insertions(+), 8 deletions(-)
 rename {arch/arm/mach-mmp =3D> include/linux/soc/mmp}/cputype.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cbcf167bdd08..176ef19f0b9db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10797,6 +10797,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderate=
d for non-subscribers)
 S:	Odd Fixes
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
+F:	linux/soc/mmp/
=20
 MMU GATHER AND TLB INVALIDATION
 M:	Will Deacon <will@kernel.org>
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 24c689a01ecb7..e94349d4726ca 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -13,7 +13,7 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 #include "addr-map.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
=20
 #include "common.h"
=20
diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 130c1a603ba29..18bee66a671ff 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -11,7 +11,7 @@
 #include <asm/irq.h>
 #include "irqs.h"
 #include "devices.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "regs-usb.h"
=20
 int __init pxa_register_device(struct pxa_device_desc *desc,
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 18ea3e1a26e69..bbc4c2274de3a 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -20,7 +20,7 @@
 #include <asm/mach/time.h>
 #include "addr-map.h"
 #include "regs-apbc.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "irqs.h"
 #include "mfp.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 2923dd5732a62..2d86381e152d6 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -17,7 +17,7 @@
 #include <linux/interrupt.h>
 #include <asm/mach-types.h>
=20
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "addr-map.h"
 #include "pm-mmp2.h"
 #include "regs-icu.h"
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.=
c
index 58535ce206dc5..69ebe18ff209f 100644
--- a/arch/arm/mach-mmp/pm-pxa910.c
+++ b/arch/arm/mach-mmp/pm-pxa910.c
@@ -18,7 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/outercache.h>
=20
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "addr-map.h"
 #include "pm-pxa910.h"
 #include "regs-icu.h"
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 6e02774889679..b642e900727a5 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -21,7 +21,7 @@
 #include "addr-map.h"
 #include "clock.h"
 #include "common.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "devices.h"
 #include "irqs.h"
 #include "mfp.h"
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index cba31c758dea6..b19a069d9fabe 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -18,7 +18,7 @@
 #include <asm/mach/time.h>
 #include "addr-map.h"
 #include "regs-apbc.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "irqs.h"
 #include "mfp.h"
 #include "devices.h"
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 8f4cacbf640e9..110dcb3314d13 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -33,7 +33,7 @@
 #include "regs-timers.h"
 #include "regs-apbc.h"
 #include "irqs.h"
-#include "cputype.h"
+#include <linux/soc/mmp/cputype.h>
 #include "clock.h"
=20
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
diff --git a/arch/arm/mach-mmp/cputype.h b/include/linux/soc/mmp/cputype.=
h
similarity index 100%
rename from arch/arm/mach-mmp/cputype.h
rename to include/linux/soc/mmp/cputype.h
--=20
2.21.0

