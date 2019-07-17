Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C296C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7F2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGQJdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:33:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53564 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfGQJdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:33:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD3682000A5;
        Wed, 17 Jul 2019 11:33:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04A6520005C;
        Wed, 17 Jul 2019 11:33:07 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D2F1402D5;
        Wed, 17 Jul 2019 17:33:01 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [PATCH] drm/arm/mali-dp: Add display QoS interface configuration
Date:   Wed, 17 Jul 2019 17:23:53 +0800
Message-Id: <20190717092353.43386-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the display Quality of service (QoS) levels to high priority
if the level is defined as high as in DTS. The ARQOS for DP500 is driven
from the "RQOS" register, needed to program the RQOS register value < 7
for the 4k resolution flicker to disappear on the LS1028A platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v2:
        - add new implementation for 4k flicker issue on the LS1028A

 drivers/gpu/drm/arm/malidp_drv.c  |  5 +++++
 drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
 drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
 drivers/gpu/drm/arm/malidp_regs.h | 12 ++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index f25ec4382277..d2b2cf52ac87 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -818,6 +818,11 @@ static int malidp_bind(struct device *dev)
 
 	malidp->core_id = version;
 
+	hwdev->arqos_high_level = false;
+
+	hwdev->arqos_high_level = of_property_read_bool(dev->of_node,
+					"arm,malidp-arqos-high-level");
+
 	/* set the number of lines used for output of RGB data */
 	ret = of_property_read_u8_array(dev->of_node,
 					"arm,malidp-output-port-lines",
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 50af399d7f6f..eaa1658cd86b 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -374,6 +374,19 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 		malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
 	else
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
+
+	/*
+	 *  Program the RQoS register to increasing QoS levels for
+	 *  the 4k resolution flicker to disappear on the LS1028A.
+	 */
+	if (hwdev->arqos_high_level) {
+		val = RED_ARQOS_VALUE | GREEN_ARQOS_VALUE;
+
+		if (mode->pixelclock == 594000000)
+			malidp_hw_setbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+		else
+			malidp_hw_clearbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+	}
 }
 
 int malidp_format_get_bpp(u32 fmt)
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 968a65eed371..b8baba60508a 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -251,6 +251,9 @@ struct malidp_hw_device {
 
 	/* size of memory used for rotating layers, up to two banks available */
 	u32 rotation_memory[2];
+
+	/* priority level of RQOS register used for driven the ARQOS signal */
+	bool arqos_high_level;
 };
 
 static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32 reg)
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 993031542fa1..08842142b3b2 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -210,6 +210,18 @@
 #define MALIDP500_CONFIG_VALID		0x00f00
 #define MALIDP500_CONFIG_ID		0x00fd4
 
+/*
+ * The quality of service (QoS) register on the DP500. RQOS register values
+ * are driven by the ARQOS signal, using AXI transacations, dependent on the
+ * FIFO input level.
+ * The RQOS register can also set QoS levels for:
+ *    - RED_ARQOS   @ A 4-bit signal value for close to underflow conditions
+ *    - GREEN_ARQOS @ A 4-bit signal value for normal conditions
+ */
+#define MALIDP500_RQOS_QUALITY          0x00500
+#define RED_ARQOS_VALUE                 (0xd << 12)
+#define GREEN_ARQOS_VALUE               (0xd << 28)
+
 /* register offsets and bits specific to DP550/DP650 */
 #define MALIDP550_ADDR_SPACE_SIZE	0x10000
 #define MALIDP550_DE_CONTROL		0x00010
-- 
2.17.1

