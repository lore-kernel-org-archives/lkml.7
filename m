Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A14C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5E20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406371AbfHIJdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:36 -0400
Received: from shell.v3.sk ([90.176.6.54]:52013 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406346AbfHIJdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 711D8D63C6;
        Fri,  9 Aug 2019 11:33:29 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K1gVfscxpXnp; Fri,  9 Aug 2019 11:33:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5EA2FD63DC;
        Fri,  9 Aug 2019 11:32:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WFlokgtFpukp; Fri,  9 Aug 2019 11:32:29 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DBE76D63C2;
        Fri,  9 Aug 2019 11:32:21 +0200 (CEST)
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
Subject: [PATCH 15/19] ARM: mmp: add SMP support
Date:   Fri,  9 Aug 2019 11:31:54 +0200
Message-Id: <20190809093158.7969-16-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used to bring up the second core on MMP3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/Makefile  |  3 +++
 arch/arm/mach-mmp/platsmp.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/mach-mmp/platsmp.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 322c1c97dc900..7b3a7f979eece 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -22,6 +22,9 @@ ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+=3D pm-pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+=3D pm-mmp2.o
 endif
+ifeq ($(CONFIG_SMP),y)
+obj-$(CONFIG_MACH_MMP3_DT)	+=3D platsmp.o
+endif
=20
 # board support
 obj-$(CONFIG_MACH_ASPENITE)	+=3D aspenite.o
diff --git a/arch/arm/mach-mmp/platsmp.c b/arch/arm/mach-mmp/platsmp.c
new file mode 100644
index 0000000000000..255df640b5bc1
--- /dev/null
+++ b/arch/arm/mach-mmp/platsmp.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+#include <linux/io.h>
+#include <asm/smp_scu.h>
+#include <asm/smp.h>
+#include "addr-map.h"
+
+#define SW_BRANCH_VIRT_ADDR	CIU_REG(0x24)
+
+static int mmp3_boot_secondary(unsigned int cpu, struct task_struct *idl=
e)
+{
+	/*
+	 * Apparently, the boot ROM on the second core spins on this
+	 * register becoming non-zero and then jumps to the address written
+	 * there. No IPIs involved.
+	 */
+	__raw_writel(virt_to_phys(secondary_startup), SW_BRANCH_VIRT_ADDR);
+	return 0;
+}
+
+static void mmp3_smp_prepare_cpus(unsigned int max_cpus)
+{
+	scu_enable(SCU_VIRT_BASE);
+}
+
+static const struct smp_operations mmp3_smp_ops __initconst =3D {
+	.smp_prepare_cpus	=3D mmp3_smp_prepare_cpus,
+	.smp_boot_secondary	=3D mmp3_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(mmp3_smp, "marvell,mmp3-smp", &mmp3_smp_ops);
--=20
2.21.0

