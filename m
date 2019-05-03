Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C740C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfECNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:53:18 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43502 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfECNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:53:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8FDABFB03;
        Fri,  3 May 2019 15:53:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ooGTtBqEb89p; Fri,  3 May 2019 15:53:13 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A480547CED; Fri,  3 May 2019 15:53:12 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: Get iMX8MQ revision for B0 from ATF
Date:   Fri,  3 May 2019 15:53:12 +0200
Message-Id: <d85c6cfe79f9fc1e7761c952e29dfb2f71cff2c1.1556891520.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to what the BSP does and needed to e.g. determine
necessary quirks for MIPI DSI.

Signed-off-by: Guido Günther <agx@sigxcpu.org>

---
From the list discussion and changelog it's not clear to me why a
different method was chosen for the B1 silicon so I left that in place
as is and only trigger on the B0 silicon I have here.
---
 drivers/soc/imx/soc-imx8.c | 49 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index fc6429f9170a..363acd1151ee 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
@@ -11,16 +12,37 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
+#define REV_B0				0x20
 #define REV_B1				0x21
 
+#define IMX8MQ_ATF_GET_SOC_INFO		0xc2000006
 #define IMX8MQ_SW_INFO_B1		0x40
 #define IMX8MQ_SW_MAGIC_B1		0xff0055aa
 
+
 struct imx8_soc_data {
 	char *name;
 	u32 (*soc_revision)(void);
 };
 
+
+static u32 __init imx8mq_soc_revision_from_atf(void)
+{
+	struct arm_smccc_res res;
+	u32 digprog;
+
+	arm_smccc_smc(IMX8MQ_ATF_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	digprog = res.a0;
+	/*
+	 * Bit [23:16] is the silicon ID
+	 * Bit[7:4] is the base layer revision,
+	 * Bit[3:0] is the metal layer revision
+	 * e.g. 0x10 stands for Tapeout 1.0
+	 */
+	return digprog & 0xff;
+}
+
+
 static u32 __init imx8mq_soc_revision(void)
 {
 	struct device_node *np;
@@ -29,20 +51,23 @@ static u32 __init imx8mq_soc_revision(void)
 	u32 rev = 0;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
-	if (!np)
-		goto out;
-
-	ocotp_base = of_iomap(np, 0);
-	WARN_ON(!ocotp_base);
-
-	magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
-	if (magic == IMX8MQ_SW_MAGIC_B1)
-		rev = REV_B1;
-
-	iounmap(ocotp_base);
+	if (np) {
+		ocotp_base = of_iomap(np, 0);
+		WARN_ON(!ocotp_base);
+
+		magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
+		iounmap(ocotp_base);
+		of_node_put(np);
+		if (magic == IMX8MQ_SW_MAGIC_B1)
+			rev = REV_B1;
+	}
 
+	if (!rev) {
+		magic = imx8mq_soc_revision_from_atf();
+		if (magic == REV_B0)
+			rev = REV_B0;
+	}
 out:
-	of_node_put(np);
 	return rev;
 }
 
-- 
2.20.1

