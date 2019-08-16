Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDFDC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6B62133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfHPKO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:14:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54858 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfHPKOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:14:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 316C81A0042;
        Fri, 16 Aug 2019 12:14:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 74EB01A0027;
        Fri, 16 Aug 2019 12:14:16 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DC3184030F;
        Fri, 16 Aug 2019 18:14:09 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v3 2/2] drm/arm/mali-dp: Add display QoS interface configuration for Mali DP500
Date:   Fri, 16 Aug 2019 18:04:24 +0800
Message-Id: <20190816100424.5366-2-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190816100424.5366-1-wen.he_1@nxp.com>
References: <20190816100424.5366-1-wen.he_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the display Quality of service (QoS) levels priority if the
optional property node "arm,malidp-aqros-value" is defined in DTS file.

QoS signaling using AQROS and AWQOS AXI interface signals, the AQROS is
driven from the "RQOS" register, so needed to program the RQOS register
to avoid the high resolutions flicker issue on the LS1028A platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v3:
        - after testing more resolutions, if pixelclock > 148.5MHz will
        get the flickering

 drivers/gpu/drm/arm/malidp_drv.c  |  6 ++++++
 drivers/gpu/drm/arm/malidp_hw.c   | 13 +++++++++++++
 drivers/gpu/drm/arm/malidp_hw.h   |  3 +++
 drivers/gpu/drm/arm/malidp_regs.h | 10 ++++++++++
 4 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index c27ff456eddc..80e8d15760ac 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -815,6 +815,12 @@ static int malidp_bind(struct device *dev)
 
 	malidp->core_id = version;
 
+	ret = of_property_read_u32(dev->of_node,
+					"arm,malidp-arqos-value",
+					&hwdev->arqos_value);
+	if (ret)
+		hwdev->arqos_value = 0x0;
+
 	/* set the number of lines used for output of RGB data */
 	ret = of_property_read_u8_array(dev->of_node,
 					"arm,malidp-output-port-lines",
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 380be66d4c6e..f90a367a5bc9 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -374,6 +374,19 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 		malidp_hw_setbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
 	else
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
+
+	/*
+	 * Program the RQoS register to avoid high resolutions flicker
+	 * issue on the LS1028A.
+	 */
+	if (hwdev->arqos_value) {
+		val = hwdev->arqos_value;
+
+		if (mode->pixelclock > 148500000)
+			malidp_hw_setbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+		else
+			malidp_hw_clearbits(hwdev, val, MALIDP500_RQOS_QUALITY);
+	}
 }
 
 int malidp_format_get_bpp(u32 fmt)
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 968a65eed371..e4c36bc90bda 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -251,6 +251,9 @@ struct malidp_hw_device {
 
 	/* size of memory used for rotating layers, up to two banks available */
 	u32 rotation_memory[2];
+
+	/* priority level of RQOS register used for driven the ARQOS signal */
+	u32 arqos_value;
 };
 
 static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32 reg)
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 993031542fa1..514c50dcb74d 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -210,6 +210,16 @@
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
+
 /* register offsets and bits specific to DP550/DP650 */
 #define MALIDP550_ADDR_SPACE_SIZE	0x10000
 #define MALIDP550_DE_CONTROL		0x00010
-- 
2.17.1

