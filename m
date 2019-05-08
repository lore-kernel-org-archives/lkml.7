Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F9E20449
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEHMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:40:23 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:50793 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEHMkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:40:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C0045FB03;
        Wed,  8 May 2019 14:40:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nZU3glKHYqCD; Wed,  8 May 2019 14:40:18 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 566BE47B7D; Wed,  8 May 2019 14:40:18 +0200 (CEST)
Date:   Wed, 8 May 2019 14:40:18 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
Message-ID: <20190508124018.GA16859@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB6434517A0235C8308D86B050EE310@AM0PR04MB6434.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

Thanks for your comments. Let's try s.th. different then: identify by
bootrom, ocotop and anatop and fall back to ATF afterwards (I'll split
out the DT part and add binding docs if this makes sense). I'm also
happy to drop the whole ATF logic until mailine ATF catched up:

The mainline ATF doesn't currently support the FSL_SIP_GET_SOC_INFO call
nor does it have the code to identify different imx8mq SOC revisions so
mimic what NXPs ATF does here.

As a fallback use ATF so we can identify new revisions once it gains
support or when using NXPs ATF.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++
 drivers/soc/imx/soc-imx8.c                | 68 ++++++++++++++++++-----
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6d635ba0904c..52aa1600b33b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -246,6 +246,18 @@
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
 
+		bus@00000000 { /* ROM */
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00000000 0x00000000 0x20000>;
+
+			rom@00000000 {
+				compatible = "fsl,imx8mq-bootrom";
+				reg = <0x00000000 0x1e800>;
+			};
+		};
+
 		bus@30000000 { /* AIPS1 */
 			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
 			#address-cells = <1>;
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index fc6429f9170a..0a1fe82efe86 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
@@ -11,39 +12,80 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
+#define REV_A0				0x10
+#define REV_B0				0x20
 #define REV_B1				0x21
 
+#define IMX8MQ_SW_INFO_A0		0x800
+#define IMX8MQ_SW_INFO_B0		0x83C
 #define IMX8MQ_SW_INFO_B1		0x40
 #define IMX8MQ_SW_MAGIC_B1		0xff0055aa
 
+#define FSL_SIP_GET_SOC_INFO		0xc2000006
+
 struct imx8_soc_data {
 	char *name;
 	u32 (*soc_revision)(void);
 };
 
-static u32 __init imx8mq_soc_revision(void)
+static u32 __init imx8mq_soc_revision_atf(void)
+{
+	struct arm_smccc_res res = { 0 };
+
+	arm_smccc_smc(FSL_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	/*
+	 * Bit [23:16] is the silicon ID
+	 * Bit[7:4] is the base layer revision,
+	 * Bit[3:0] is the metal layer revision
+	 * e.g. 0x10 stands for Tapeout 1.0
+	 */
+	return res.a0 & 0xff;
+}
+
+static u32 __init imx8mq_soc_magic_node(const char *node, u32 offset)
 {
 	struct device_node *np;
-	void __iomem *ocotp_base;
+	void __iomem *base;
 	u32 magic;
-	u32 rev = 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
+	np = of_find_compatible_node(NULL, NULL, node);
 	if (!np)
-		goto out;
+		return 0;
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	magic = readl_relaxed(base + offset);
+	iounmap(base);
+	of_node_put(np);
+
+	return magic;
+}
 
-	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
+static u32 __init imx8mq_soc_revision(void)
+{
+	u32 magic;
 
-	magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
+	/* B1 revision identified by ocotop */
+	magic = imx8mq_soc_magic_node("fsl,imx8mq-ocotp", IMX8MQ_SW_INFO_B1);
 	if (magic == IMX8MQ_SW_MAGIC_B1)
-		rev = REV_B1;
+		return REV_B1;
 
-	iounmap(ocotp_base);
+	/* B0 identified by bootrom */
+	magic = imx8mq_soc_magic_node("fsl,imx8mq-bootrom", IMX8MQ_SW_INFO_B0);
+	if ((magic & 0xff) == REV_B0)
+		return REV_B0;
 
-out:
-	of_node_put(np);
-	return rev;
+	/* A0 identified by anatop */
+	magic = imx8mq_soc_magic_node("fsl,imx8mq-anatop", IMX8MQ_SW_INFO_A0);
+	if ((magic & 0xff) == REV_A0)
+		return REV_A0;
+
+	/* Read revision from ATF as fallback */
+	magic = imx8mq_soc_revision_atf();
+	if (magic != 0xff)
+		return magic;
+
+	return 0;
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
-- 
2.20.1
