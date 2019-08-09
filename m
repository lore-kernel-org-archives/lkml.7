Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DDFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BEE20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbfHIJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:15 -0400
Received: from shell.v3.sk ([90.176.6.54]:51916 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406275AbfHIJdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 66FEDD63CE;
        Fri,  9 Aug 2019 11:33:09 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YFl9FB3e_5iA; Fri,  9 Aug 2019 11:32:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 79F29D63C1;
        Fri,  9 Aug 2019 11:32:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L71iSn9LhGn0; Fri,  9 Aug 2019 11:32:22 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 03702D63C9;
        Fri,  9 Aug 2019 11:32:17 +0200 (CEST)
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
Subject: [PATCH 11/19] ARM: mmp: map the PGU as well
Date:   Fri,  9 Aug 2019 11:31:50 +0200
Message-Id: <20190809093158.7969-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMP2 and later includes a system control unit in this area. We'll nee=
d
that to initialize the secondary core on MMP3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/addr-map.h |  7 +++++++
 arch/arm/mach-mmp/common.c   | 15 +++++++++++++++
 arch/arm/mach-mmp/common.h   |  1 +
 arch/arm/mach-mmp/mmp2-dt.c  |  2 +-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/addr-map.h b/arch/arm/mach-mmp/addr-map.h
index 25edf6a92276e..3dc2f0b0ecba5 100644
--- a/arch/arm/mach-mmp/addr-map.h
+++ b/arch/arm/mach-mmp/addr-map.h
@@ -20,6 +20,10 @@
 #define AXI_VIRT_BASE		IOMEM(0xfe200000)
 #define AXI_PHYS_SIZE		0x00200000
=20
+#define PGU_PHYS_BASE		0xe0000000
+#define PGU_VIRT_BASE		IOMEM(0xfe400000)
+#define PGU_PHYS_SIZE		0x00100000
+
 /* Static Memory Controller - Chip Select 0 and 1 */
 #define SMC_CS0_PHYS_BASE	0x80000000
 #define SMC_CS0_PHYS_SIZE	0x10000000
@@ -38,4 +42,7 @@
 #define CIU_VIRT_BASE		(AXI_VIRT_BASE + 0x82c00)
 #define CIU_REG(x)		(CIU_VIRT_BASE + (x))
=20
+#define SCU_VIRT_BASE		(PGU_VIRT_BASE)
+#define SCU_REG(x)		(SCU_VIRT_BASE + (x))
+
 #endif /* __ASM_MACH_ADDR_MAP_H */
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 6684abc7708bd..2ee08c78e8bc9 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -36,6 +36,15 @@ static struct map_desc standard_io_desc[] __initdata =3D=
 {
 	},
 };
=20
+static struct map_desc mmp2_io_desc[] __initdata =3D {
+	{
+		.pfn		=3D __phys_to_pfn(PGU_PHYS_BASE),
+		.virtual	=3D (unsigned long)PGU_VIRT_BASE,
+		.length		=3D PGU_PHYS_SIZE,
+		.type		=3D MT_DEVICE,
+	},
+};
+
 void __init mmp_map_io(void)
 {
 	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
@@ -44,6 +53,12 @@ void __init mmp_map_io(void)
 	mmp_chip_id =3D __raw_readl(MMP_CHIPID);
 }
=20
+void __init mmp2_map_io(void)
+{
+	mmp_map_io();
+	iotable_init(mmp2_io_desc, ARRAY_SIZE(mmp2_io_desc));
+}
+
 void mmp_restart(enum reboot_mode mode, const char *cmd)
 {
 	soft_restart(0);
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 483b8b6d3005a..ed56b3f15b45e 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -5,4 +5,5 @@
 extern void mmp_timer_init(int irq, unsigned long rate);
=20
 extern void __init mmp_map_io(void);
+extern void __init mmp2_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 305a9daba6d68..8eec881191f4b 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -33,7 +33,7 @@ static const char *const mmp2_dt_board_compat[] __initc=
onst =3D {
 };
=20
 DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
-	.map_io		=3D mmp_map_io,
+	.map_io		=3D mmp2_map_io,
 	.init_time	=3D mmp_init_time,
 	.dt_compat	=3D mmp2_dt_board_compat,
 MACHINE_END
--=20
2.21.0

