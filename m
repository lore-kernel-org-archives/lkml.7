Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20732087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDOU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:26:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:26:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2lv2-1gqaRJ31GW-0133p3; Mon, 15 Apr 2019 22:26:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 3/6] ARM: ks8695: net: move machine header contents
Date:   Mon, 15 Apr 2019 22:24:15 +0200
Message-Id: <20190415202501.941196-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IyfXVAi6CM4P9EgizpcZtkIJmhbyjrAob6YPsAkHaOiC5wwZcAM
 JBIISStr63qoAtDqcrnpjyPjQUJcZYOrpZ5042zmbYmDnE2vixbY3aeROfCJRYIr+fUPlTP
 0Za7FKYLdDqz00vWk4MvoV/KGJGjBV6iq2iZJPHA3ByK5jqsXfTGi/b6IiXdm3+UNxLlIFc
 6jXPd9Emj6eK7OIUpp1/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TS3Bx3A2MW8=:PZk6d1DO7MqupR58Mr7c6E
 aSFgZXy4XgEks2Yl+ZDSyutKO82QM/DqGt02gTR9Di7cr28BA5jQve+OE6e/rD1Exh/XpYkYO
 bPiHk7WJODOSanUAZRFmRhG4KFM2oHycJdTNEcb2ymUKTiabo0wp/3+PpeuGd10lcXxTEnmFK
 /kq8wOcZJ2W4CRXqtobWYZS15wZ7JPXeYl4ZdO4Q7//Agxub1Wv4I1lGiKY0/7LmCc0QYNrwp
 IAFpDRMzcBso8bY+x9wwIOuwrioowqNPJispVgD/Ps+VUt0tsgoNVzPgnRcSX6UJq1n+m/9Ze
 UCbTWEMBsLVgEy2OuBAQXDB6pU5G6vL1dSLpLoFm/CwzUBjPUJIq9TaksyLTXph8LJLqMNuCj
 WjH7xP+Qg6w52Z9IUlENGKfwqY24Y9GN1NjIKhhiiRT0yxzmrSck3i3wQlHz2yh+e4oR4s1O1
 VOL+rgJ39c93E0FPmpJzA/eHrsXc1LkH3uEzHOVdbPVzhFKC3Xsjxn3kF39yXGrw54zdhpUdh
 XEVMI5ZaSBaMBe84YQZen+mjSRTX5t1OsXALsv1mvmhQi4g52NGpGVx/XTkAjXg8ayFfeO88T
 ZOI7AZGoSzcDq53nmRRwM89Tu9QZPu9k2m64tRw7XdNyhMeV7abqllanzF+qt8ReMyqeLFWYt
 qN1kQV426geJnjggbfBBlEneRzJBTotdLqbeOGsVa2SznqpuQ13+Et1/4WKRts0MOQ43gsvrF
 QhMcky6MR+1Kxj0l5njnpYA+LlGZ5C9SU7UBZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the headers are only used by the ethernet driver, other
parts are only used in the machine definitions. Move everything
to the appropriate place that lets us kill off the global headers
and allow build testing on other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/cpu.c                    |   2 +-
 arch/arm/mach-ks8695/devices.c                |   5 +-
 arch/arm/mach-ks8695/include/mach/regs-misc.h |  97 ---------------
 .../mach-ks8695/include/mach/regs-switch.h    |  66 ----------
 arch/arm/mach-ks8695/regs-misc.h              |  33 +++++
 arch/arm/mach-ks8695/regs-switch.h            |  18 +++
 drivers/net/ethernet/micrel/Kconfig           |   2 +-
 drivers/net/ethernet/micrel/ks8695net.c       | 116 ++++++++++++++++--
 8 files changed, 164 insertions(+), 175 deletions(-)
 delete mode 100644 arch/arm/mach-ks8695/include/mach/regs-misc.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/regs-switch.h
 create mode 100644 arch/arm/mach-ks8695/regs-misc.h
 create mode 100644 arch/arm/mach-ks8695/regs-switch.h

diff --git a/arch/arm/mach-ks8695/cpu.c b/arch/arm/mach-ks8695/cpu.c
index 7a1c4caa1ab5..7eadf73c7e30 100644
--- a/arch/arm/mach-ks8695/cpu.c
+++ b/arch/arm/mach-ks8695/cpu.c
@@ -31,7 +31,7 @@
 #include <asm/mach/map.h>
 
 #include "regs-sys.h"
-#include <mach/regs-misc.h>
+#include "regs-misc.h"
 
 
 static struct map_desc ks8695_io_desc[] __initdata = {
diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index 57766817d86f..6bd50a8f12f9 100644
--- a/arch/arm/mach-ks8695/devices.c
+++ b/arch/arm/mach-ks8695/devices.c
@@ -27,9 +27,8 @@
 #include "regs-wan.h"
 #include "regs-lan.h"
 #include "regs-hpna.h"
-#include <mach/regs-switch.h>
-#include <mach/regs-misc.h>
-
+#include "regs-switch.h"
+#include "regs-misc.h"
 
 /* --------------------------------------------------------------------
  *  Ethernet
diff --git a/arch/arm/mach-ks8695/include/mach/regs-misc.h b/arch/arm/mach-ks8695/include/mach/regs-misc.h
deleted file mode 100644
index 2740c52494a0..000000000000
--- a/arch/arm/mach-ks8695/include/mach/regs-misc.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * arch/arm/mach-ks8695/include/mach/regs-misc.h
- *
- * Copyright (C) 2006 Andrew Victor
- *
- * KS8695 - Miscellaneous Registers
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef KS8695_MISC_H
-#define KS8695_MISC_H
-
-#define KS8695_MISC_OFFSET	(0xF0000 + 0xEA00)
-#define KS8695_MISC_VA		(KS8695_IO_VA + KS8695_MISC_OFFSET)
-#define KS8695_MISC_PA		(KS8695_IO_PA + KS8695_MISC_OFFSET)
-
-
-/*
- * Miscellaneous registers
- */
-#define KS8695_DID		(0x00)		/* Device ID */
-#define KS8695_RID		(0x04)		/* Revision ID */
-#define KS8695_HMC		(0x08)		/* HPNA Miscellaneous Control [KS8695 only] */
-#define KS8695_WMC		(0x0c)		/* WAN Miscellaneous Control */
-#define KS8695_WPPM		(0x10)		/* WAN PHY Power Management */
-#define KS8695_PPS		(0x1c)		/* PHY PowerSave */
-
-/* Device ID Register */
-#define DID_ID			(0xffff << 0)	/* Device ID */
-
-/* Revision ID Register */
-#define RID_SUBID		(0xf << 4)	/* Sub-Device ID */
-#define RID_REVISION		(0xf << 0)	/* Revision ID */
-
-/* HPNA Miscellaneous Control Register */
-#define HMC_HSS			(1 << 1)	/* Speed */
-#define HMC_HDS			(1 << 0)	/* Duplex */
-
-/* WAN Miscellaneous Control Register */
-#define WMC_WANC		(1 << 30)	/* Auto-negotiation complete */
-#define WMC_WANR		(1 << 29)	/* Auto-negotiation restart */
-#define WMC_WANAP		(1 << 28)	/* Advertise Pause */
-#define WMC_WANA100F		(1 << 27)	/* Advertise 100 FDX */
-#define WMC_WANA100H		(1 << 26)	/* Advertise 100 HDX */
-#define WMC_WANA10F		(1 << 25)	/* Advertise 10 FDX */
-#define WMC_WANA10H		(1 << 24)	/* Advertise 10 HDX */
-#define WMC_WLS			(1 << 23)	/* Link status */
-#define WMC_WDS			(1 << 22)	/* Duplex status */
-#define WMC_WSS			(1 << 21)	/* Speed status */
-#define WMC_WLPP		(1 << 20)	/* Link Partner Pause */
-#define WMC_WLP100F		(1 << 19)	/* Link Partner 100 FDX */
-#define WMC_WLP100H		(1 << 18)	/* Link Partner 100 HDX */
-#define WMC_WLP10F		(1 << 17)	/* Link Partner 10 FDX */
-#define WMC_WLP10H		(1 << 16)	/* Link Partner 10 HDX */
-#define WMC_WAND		(1 << 15)	/* Auto-negotiation disable */
-#define WMC_WANF100		(1 << 14)	/* Force 100 */
-#define WMC_WANFF		(1 << 13)	/* Force FDX */
-#define WMC_WLED1S		(7 <<  4)	/* LED1 Select */
-#define		WLED1S_SPEED		(0 << 4)
-#define		WLED1S_LINK		(1 << 4)
-#define		WLED1S_DUPLEX		(2 << 4)
-#define		WLED1S_COLLISION	(3 << 4)
-#define		WLED1S_ACTIVITY		(4 << 4)
-#define		WLED1S_FDX_COLLISION	(5 << 4)
-#define		WLED1S_LINK_ACTIVITY	(6 << 4)
-#define WMC_WLED0S		(7 << 0)	/* LED0 Select */
-#define		WLED0S_SPEED		(0 << 0)
-#define		WLED0S_LINK		(1 << 0)
-#define		WLED0S_DUPLEX		(2 << 0)
-#define		WLED0S_COLLISION	(3 << 0)
-#define		WLED0S_ACTIVITY		(4 << 0)
-#define		WLED0S_FDX_COLLISION	(5 << 0)
-#define		WLED0S_LINK_ACTIVITY	(6 << 0)
-
-/* WAN PHY Power Management Register */
-#define WPPM_WLPBK		(1 << 14)	/* Local Loopback */
-#define WPPM_WRLPKB		(1 << 13)	/* Remove Loopback */
-#define WPPM_WPI		(1 << 12)	/* PHY isolate */
-#define WPPM_WFL		(1 << 10)	/* Force link */
-#define WPPM_MDIXS		(1 << 9)	/* MDIX Status */
-#define WPPM_FEF		(1 << 8)	/* Far End Fault */
-#define WPPM_AMDIXP		(1 << 7)	/* Auto MDIX Parameter */
-#define WPPM_TXDIS		(1 << 6)	/* Disable transmitter */
-#define WPPM_DFEF		(1 << 5)	/* Disable Far End Fault */
-#define WPPM_PD			(1 << 4)	/* Power Down */
-#define WPPM_DMDX		(1 << 3)	/* Disable Auto MDI/MDIX */
-#define WPPM_FMDX		(1 << 2)	/* Force MDIX */
-#define WPPM_LPBK		(1 << 1)	/* MAX Loopback */
-
-/* PHY Power Save Register */
-#define PPS_PPSM		(1 << 0)	/* PHY Power Save Mode */
-
-
-#endif
diff --git a/arch/arm/mach-ks8695/include/mach/regs-switch.h b/arch/arm/mach-ks8695/include/mach/regs-switch.h
deleted file mode 100644
index 97e8acb1cf6c..000000000000
--- a/arch/arm/mach-ks8695/include/mach/regs-switch.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * arch/arm/mach-ks8695/include/mach/regs-switch.h
- *
- * Copyright (C) 2006 Andrew Victor
- *
- * KS8695 - Switch Registers and bit definitions.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef KS8695_SWITCH_H
-#define KS8695_SWITCH_H
-
-#define KS8695_SWITCH_OFFSET	(0xF0000 + 0xe800)
-#define KS8695_SWITCH_VA	(KS8695_IO_VA + KS8695_SWITCH_OFFSET)
-#define KS8695_SWITCH_PA	(KS8695_IO_PA + KS8695_SWITCH_OFFSET)
-
-
-/*
- * Switch registers
- */
-#define KS8695_SEC0		(0x00)		/* Switch Engine Control 0 */
-#define KS8695_SEC1		(0x04)		/* Switch Engine Control 1 */
-#define KS8695_SEC2		(0x08)		/* Switch Engine Control 2 */
-
-#define KS8695_SEPXCZ(x,z)	(0x0c + (((x)-1)*3 + ((z)-1))*4)	/* Port Configuration Registers */
-
-#define KS8695_SEP12AN		(0x48)		/* Port 1 & 2 Auto-Negotiation */
-#define KS8695_SEP34AN		(0x4c)		/* Port 3 & 4 Auto-Negotiation */
-#define KS8695_SEIAC		(0x50)		/* Indirect Access Control */
-#define KS8695_SEIADH2		(0x54)		/* Indirect Access Data High 2 */
-#define KS8695_SEIADH1		(0x58)		/* Indirect Access Data High 1 */
-#define KS8695_SEIADL		(0x5c)		/* Indirect Access Data Low */
-#define KS8695_SEAFC		(0x60)		/* Advance Feature Control */
-#define KS8695_SEDSCPH		(0x64)		/* TOS Priority High */
-#define KS8695_SEDSCPL		(0x68)		/* TOS Priority Low */
-#define KS8695_SEMAH		(0x6c)		/* Switch Engine MAC Address High */
-#define KS8695_SEMAL		(0x70)		/* Switch Engine MAC Address Low */
-#define KS8695_LPPM12		(0x74)		/* Port 1 & 2 PHY Power Management */
-#define KS8695_LPPM34		(0x78)		/* Port 3 & 4 PHY Power Management */
-
-
-/* Switch Engine Control 0 */
-#define SEC0_LLED1S		(7 << 25)	/* LED1 Select */
-#define		LLED1S_SPEED		(0 << 25)
-#define		LLED1S_LINK		(1 << 25)
-#define		LLED1S_DUPLEX		(2 << 25)
-#define		LLED1S_COLLISION	(3 << 25)
-#define		LLED1S_ACTIVITY		(4 << 25)
-#define		LLED1S_FDX_COLLISION	(5 << 25)
-#define		LLED1S_LINK_ACTIVITY	(6 << 25)
-#define SEC0_LLED0S		(7 << 22)	/* LED0 Select */
-#define		LLED0S_SPEED		(0 << 22)
-#define		LLED0S_LINK		(1 << 22)
-#define		LLED0S_DUPLEX		(2 << 22)
-#define		LLED0S_COLLISION	(3 << 22)
-#define		LLED0S_ACTIVITY		(4 << 22)
-#define		LLED0S_FDX_COLLISION	(5 << 22)
-#define		LLED0S_LINK_ACTIVITY	(6 << 22)
-#define SEC0_ENABLE		(1 << 0)	/* Enable Switch */
-
-
-
-#endif
diff --git a/arch/arm/mach-ks8695/regs-misc.h b/arch/arm/mach-ks8695/regs-misc.h
new file mode 100644
index 000000000000..54866182c5b9
--- /dev/null
+++ b/arch/arm/mach-ks8695/regs-misc.h
@@ -0,0 +1,33 @@
+/*
+ * arch/arm/mach-ks8695/include/mach/regs-misc.h
+ *
+ * Copyright (C) 2006 Andrew Victor
+ *
+ * KS8695 - Miscellaneous Registers
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef KS8695_MISC_H
+#define KS8695_MISC_H
+
+#define KS8695_MISC_OFFSET	(0xF0000 + 0xEA00)
+#define KS8695_MISC_VA		(KS8695_IO_VA + KS8695_MISC_OFFSET)
+#define KS8695_MISC_PA		(KS8695_IO_PA + KS8695_MISC_OFFSET)
+
+/*
+ * Miscellaneous registers
+ */
+#define KS8695_DID		(0x00)		/* Device ID */
+#define KS8695_RID		(0x04)		/* Revision ID */
+
+/* Device ID Register */
+#define DID_ID			(0xffff << 0)	/* Device ID */
+
+/* Revision ID Register */
+#define RID_SUBID		(0xf << 4)	/* Sub-Device ID */
+#define RID_REVISION		(0xf << 0)	/* Revision ID */
+
+#endif
diff --git a/arch/arm/mach-ks8695/regs-switch.h b/arch/arm/mach-ks8695/regs-switch.h
new file mode 100644
index 000000000000..4b33b4bdc1b0
--- /dev/null
+++ b/arch/arm/mach-ks8695/regs-switch.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2006 Andrew Victor
+ *
+ * KS8695 - Switch Registers and bit definitions.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef KS8695_SWITCH_H
+#define KS8695_SWITCH_H
+
+#define KS8695_SWITCH_OFFSET	(0xF0000 + 0xe800)
+#define KS8695_SWITCH_VA	(KS8695_IO_VA + KS8695_SWITCH_OFFSET)
+#define KS8695_SWITCH_PA	(KS8695_IO_PA + KS8695_SWITCH_OFFSET)
+
+#endif
diff --git a/drivers/net/ethernet/micrel/Kconfig b/drivers/net/ethernet/micrel/Kconfig
index b7e2f49696b7..c5027014a8e9 100644
--- a/drivers/net/ethernet/micrel/Kconfig
+++ b/drivers/net/ethernet/micrel/Kconfig
@@ -19,7 +19,7 @@ if NET_VENDOR_MICREL
 
 config ARM_KS8695_ETHER
 	tristate "KS8695 Ethernet support"
-	depends on ARM && ARCH_KS8695
+	depends on (ARM && ARCH_KS8695) || COMPILE_TEST
 	select MII
 	---help---
 	  If you wish to compile a kernel for the KS8695 and want to
diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index 3b6375adff08..8e8037a83ed9 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -33,18 +33,120 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <asm/irq.h>
-
-#include <mach/regs-switch.h>
-#include <mach/regs-misc.h>
-#include <asm/mach/irq.h>
-#include <mach/regs-irq.h>
-
 #include "ks8695net.h"
 
 #define MODULENAME	"ks8695_ether"
 #define MODULEVERSION	"1.02"
 
+#define KS8695_HMC		(0x08)		/* HPNA Miscellaneous Control [KS8695 only] */
+#define KS8695_WMC		(0x0c)		/* WAN Miscellaneous Control */
+#define KS8695_WPPM		(0x10)		/* WAN PHY Power Management */
+#define KS8695_PPS		(0x1c)		/* PHY PowerSave */
+
+
+/* WAN Miscellaneous Control Register */
+#define WMC_WANC		(1 << 30)	/* Auto-negotiation complete */
+#define WMC_WANR		(1 << 29)	/* Auto-negotiation restart */
+#define WMC_WANAP		(1 << 28)	/* Advertise Pause */
+#define WMC_WANA100F		(1 << 27)	/* Advertise 100 FDX */
+#define WMC_WANA100H		(1 << 26)	/* Advertise 100 HDX */
+#define WMC_WANA10F		(1 << 25)	/* Advertise 10 FDX */
+#define WMC_WANA10H		(1 << 24)	/* Advertise 10 HDX */
+#define WMC_WLS			(1 << 23)	/* Link status */
+#define WMC_WDS			(1 << 22)	/* Duplex status */
+#define WMC_WSS			(1 << 21)	/* Speed status */
+#define WMC_WLPP		(1 << 20)	/* Link Partner Pause */
+#define WMC_WLP100F		(1 << 19)	/* Link Partner 100 FDX */
+#define WMC_WLP100H		(1 << 18)	/* Link Partner 100 HDX */
+#define WMC_WLP10F		(1 << 17)	/* Link Partner 10 FDX */
+#define WMC_WLP10H		(1 << 16)	/* Link Partner 10 HDX */
+#define WMC_WAND		(1 << 15)	/* Auto-negotiation disable */
+#define WMC_WANF100		(1 << 14)	/* Force 100 */
+#define WMC_WANFF		(1 << 13)	/* Force FDX */
+#define WMC_WLED1S		(7 <<  4)	/* LED1 Select */
+#define		WLED1S_SPEED		(0 << 4)
+#define		WLED1S_LINK		(1 << 4)
+#define		WLED1S_DUPLEX		(2 << 4)
+#define		WLED1S_COLLISION	(3 << 4)
+#define		WLED1S_ACTIVITY		(4 << 4)
+#define		WLED1S_FDX_COLLISION	(5 << 4)
+#define		WLED1S_LINK_ACTIVITY	(6 << 4)
+#define WMC_WLED0S		(7 << 0)	/* LED0 Select */
+#define		WLED0S_SPEED		(0 << 0)
+#define		WLED0S_LINK		(1 << 0)
+#define		WLED0S_DUPLEX		(2 << 0)
+#define		WLED0S_COLLISION	(3 << 0)
+#define		WLED0S_ACTIVITY		(4 << 0)
+#define		WLED0S_FDX_COLLISION	(5 << 0)
+#define		WLED0S_LINK_ACTIVITY	(6 << 0)
+
+/*
+ * Switch registers
+ */
+#define KS8695_SEC0		(0x00)		/* Switch Engine Control 0 */
+#define KS8695_SEC1		(0x04)		/* Switch Engine Control 1 */
+#define KS8695_SEC2		(0x08)		/* Switch Engine Control 2 */
+
+#define KS8695_SEPXCZ(x,z)	(0x0c + (((x)-1)*3 + ((z)-1))*4)	/* Port Configuration Registers */
+
+#define KS8695_SEP12AN		(0x48)		/* Port 1 & 2 Auto-Negotiation */
+#define KS8695_SEP34AN		(0x4c)		/* Port 3 & 4 Auto-Negotiation */
+#define KS8695_SEIAC		(0x50)		/* Indirect Access Control */
+#define KS8695_SEIADH2		(0x54)		/* Indirect Access Data High 2 */
+#define KS8695_SEIADH1		(0x58)		/* Indirect Access Data High 1 */
+#define KS8695_SEIADL		(0x5c)		/* Indirect Access Data Low */
+#define KS8695_SEAFC		(0x60)		/* Advance Feature Control */
+#define KS8695_SEDSCPH		(0x64)		/* TOS Priority High */
+#define KS8695_SEDSCPL		(0x68)		/* TOS Priority Low */
+#define KS8695_SEMAH		(0x6c)		/* Switch Engine MAC Address High */
+#define KS8695_SEMAL		(0x70)		/* Switch Engine MAC Address Low */
+#define KS8695_LPPM12		(0x74)		/* Port 1 & 2 PHY Power Management */
+#define KS8695_LPPM34		(0x78)		/* Port 3 & 4 PHY Power Management */
+
+
+/* Switch Engine Control 0 */
+#define SEC0_LLED1S		(7 << 25)	/* LED1 Select */
+#define		LLED1S_SPEED		(0 << 25)
+#define		LLED1S_LINK		(1 << 25)
+#define		LLED1S_DUPLEX		(2 << 25)
+#define		LLED1S_COLLISION	(3 << 25)
+#define		LLED1S_ACTIVITY		(4 << 25)
+#define		LLED1S_FDX_COLLISION	(5 << 25)
+#define		LLED1S_LINK_ACTIVITY	(6 << 25)
+#define SEC0_LLED0S		(7 << 22)	/* LED0 Select */
+#define		LLED0S_SPEED		(0 << 22)
+#define		LLED0S_LINK		(1 << 22)
+#define		LLED0S_DUPLEX		(2 << 22)
+#define		LLED0S_COLLISION	(3 << 22)
+#define		LLED0S_ACTIVITY		(4 << 22)
+#define		LLED0S_FDX_COLLISION	(5 << 22)
+#define		LLED0S_LINK_ACTIVITY	(6 << 22)
+#define SEC0_ENABLE		(1 << 0)	/* Enable Switch */
+
+
+/* HPNA Miscellaneous Control Register */
+#define HMC_HSS			(1 << 1)	/* Speed */
+#define HMC_HDS			(1 << 0)	/* Duplex */
+
+/* WAN PHY Power Management Register */
+#define WPPM_WLPBK		(1 << 14)	/* Local Loopback */
+#define WPPM_WRLPKB		(1 << 13)	/* Remove Loopback */
+#define WPPM_WPI		(1 << 12)	/* PHY isolate */
+#define WPPM_WFL		(1 << 10)	/* Force link */
+#define WPPM_MDIXS		(1 << 9)	/* MDIX Status */
+#define WPPM_FEF		(1 << 8)	/* Far End Fault */
+#define WPPM_AMDIXP		(1 << 7)	/* Auto MDIX Parameter */
+#define WPPM_TXDIS		(1 << 6)	/* Disable transmitter */
+#define WPPM_DFEF		(1 << 5)	/* Disable Far End Fault */
+#define WPPM_PD			(1 << 4)	/* Power Down */
+#define WPPM_DMDX		(1 << 3)	/* Disable Auto MDI/MDIX */
+#define WPPM_FMDX		(1 << 2)	/* Force MDIX */
+#define WPPM_LPBK		(1 << 1)	/* MAX Loopback */
+
+/* PHY Power Save Register */
+#define PPS_PPSM		(1 << 0)	/* PHY Power Save Mode */
+
+
 /*
  * Transmit and device reset timeout, default 5 seconds.
  */
-- 
2.20.0

